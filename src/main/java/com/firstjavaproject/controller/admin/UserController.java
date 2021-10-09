package com.firstjavaproject.controller.admin;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.repository.UserRepository;
import com.firstjavaproject.service.IRoleService;
import com.firstjavaproject.service.IUserService;
import com.firstjavaproject.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IRoleService roleService;

    @Autowired
    private MessageUtils messageUtils;

    @RequestMapping(value="/admin/user-list", method = RequestMethod.GET)
    public ModelAndView userList(@RequestParam("page") int page,
                                 @RequestParam(value = "sortList", required = false) String sortList,
                                 HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/list");
        UserDTO model = new UserDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest(page - 1, SystemConstant.PAGE_LIMIT);
        if (sortList != null && !sortList.equals("")) {
            model.setListResult(userService.findUsersByRole(pageable, sortList));
            model.setTotalItem(userService.getTotalItemByCode(sortList));
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        } else {
            model.setListResult(userService.findALl(pageable));
            model.setTotalItem(userService.getTotalItem());
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        }
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("roles", roleService.findAllToDTO());
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping(value="/admin/user-edit", method = RequestMethod.GET)
    public ModelAndView userList(@RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/edit");
        UserDTO model = new UserDTO();
        if (request.getParameter("id") != null) {
            model = userService.findOneByID(id);
        }
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("model", model);
        mav.addObject("roles", roleService.findAll());
        return mav;
    }
}
