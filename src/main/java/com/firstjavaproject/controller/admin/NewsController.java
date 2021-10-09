package com.firstjavaproject.controller.admin;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.ICategoryService;
import com.firstjavaproject.service.INewsService;
import com.firstjavaproject.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class NewsController {
    @Autowired
    private INewsService newsService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private MessageUtils messageUtils;

    @RequestMapping(value = "/admin/news-list", method = RequestMethod.GET)
    public ModelAndView newsList(@RequestParam("page") int page,
                                 @RequestParam(value = "sortList", required = false) String sortList,
                                 HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/news/list");
        NewsDTO model = new NewsDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest(page - 1, SystemConstant.PAGE_LIMIT);
        if (sortList != null && !sortList.equals("")) {
            model.setListResult(newsService.findNewsByCategory(pageable, sortList, true));
            model.setTotalItem(newsService.getTotalItemByCode(sortList, true));
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        } else {
            model.setListResult(newsService.findAll(pageable, true));
            model.setTotalItem(newsService.getTotalItem(true));
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        }

        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("categories", categoryService.findAllToDTO());
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping(value = "/admin/news-edit", method = RequestMethod.GET)
    public ModelAndView newsEdit(@RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/news/edit");
        NewsDTO model = new NewsDTO();
        if (request.getParameter("id") != null) {
            model = newsService.findOneByID(id);
            String flashNews = "";
            if(model.getFlashNews()) {
                flashNews = "true";
            } else {
                flashNews = "false";
            }
            mav.addObject("flashNews", flashNews);
        }
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }

        mav.addObject("model", model);
        mav.addObject("categories", categoryService.findAll());
        return mav;
    }

    @RequestMapping("/admin/news-pending")
    public ModelAndView newsPending(@RequestParam("page") int page,
                                    @RequestParam(value = "sortList", required = false) String sortList,
                                    HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/news/pending-list");
        NewsDTO model = new NewsDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest(page - 1, SystemConstant.PAGE_LIMIT);
        if (sortList != null && !sortList.equals("")) {
            model.setListResult(newsService.findNewsByCategory(pageable, sortList, false));
            model.setTotalItem(newsService.getTotalItemByCode(sortList, false));
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        } else {
            model.setListResult(newsService.findAll(pageable, false));
            model.setTotalItem(newsService.getTotalItem(false));
            model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        }

        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("categories", categoryService.findAllToDTO());
        mav.addObject("model", model);
        return mav;
    }
}
