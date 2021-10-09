package com.firstjavaproject.controller.admin;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.CommentDTO;
import com.firstjavaproject.dto.CommentFilterDTO;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.ICategoryService;
import com.firstjavaproject.service.ICommentFilterService;
import com.firstjavaproject.service.ICommentService;
import com.firstjavaproject.service.INewsService;
import com.firstjavaproject.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class CommentController {

    @Autowired
    private INewsService newsService;

    @Autowired
    private ICommentService commentService;

    @Autowired
    private ICommentFilterService commentFilterService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private MessageUtils messageUtils;

    @RequestMapping("/admin/comment")
    public ModelAndView commentList(@RequestParam("page") int page,
                                    @RequestParam(value = "sortList", required = false) String sortList,
                                    HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/comment/comment");
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

        for (NewsDTO item : model.getListResult()) {
            item.setTotalComment(commentService.getTotalCommentInNews(item.getId()));
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

    @RequestMapping("/admin/comment-list")
    public ModelAndView commentListInNews(@RequestParam("newsID") Long newsID,
                                          @RequestParam("page") int page,
                                          HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/comment/list");
        CommentDTO model = new CommentDTO();
        model.setPage(page);
        model.setNews_id(newsID);
        Pageable pageable = new PageRequest(page - 1, SystemConstant.PAGE_LIMIT);
        model.setListResult(commentService.findCommentByNewsID(newsID, pageable));
        model.setTotalItem(commentService.getTotalCommentInNews(newsID));
        model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping("/admin/comment-filter")
    public ModelAndView commentFilter(@RequestParam("page") int page,
                                      HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/comment/comment-filter");
        CommentFilterDTO model = new CommentFilterDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest(page - 1, SystemConstant.PAGE_LIMIT);
        model.setListResult(commentFilterService.findAll(pageable));
        model.setTotalItem(commentFilterService.getTotalKeyword());
        model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping("/admin/comment-filter/edit")
    public ModelAndView commentFilterEdit(@RequestParam(value = "id", required = false) Long id,
                                          HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/comment/comment-filter-edit");
        CommentFilterDTO model = new CommentFilterDTO();
        if (request.getParameter("id") != null) {
            model = commentFilterService.findOneByID(id);
        }
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }

        mav.addObject("model", model);
        return mav;
    }
}
