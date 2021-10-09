package com.firstjavaproject.controller.web;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.ICategoryService;
import com.firstjavaproject.service.ICommentService;
import com.firstjavaproject.service.INewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "newsControllerOfWeb")
public class NewsController {

    @Autowired
    private INewsService newsService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private ICommentService commentService;

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public ModelAndView newsDetails(@RequestParam("id") long id) {
        ModelAndView mav = new ModelAndView("web/news/details");

        NewsDTO model = newsService.findOneByID(id);
        NewsDTO flashNews = newsService.findFlashNews();
        List<NewsDTO> latestNewsByCategory = newsService.findLatestNewsByCategory(new PageRequest(0, 5) ,model.getCategoryCode());
        List<NewsDTO> latestNews = newsService.findLatestNews(new PageRequest(0, 7));
        List<NewsDTO> trendingNews = newsService.findTrendingNewsByCategory(new PageRequest(0, 3) ,model.getCategoryCode());
        List<NewsDTO> allNews = newsService.findAll(true);

        newsService.updateViewWhenAccessPage(id);

        mav.addObject("latestNewsByCategory", latestNewsByCategory);
        mav.addObject("latestNews", latestNews);
        mav.addObject("trendingNews", trendingNews);
        mav.addObject("flashNews", flashNews);
        mav.addObject("allNews", allNews);
        mav.addObject("categories", categoryService.findAllToDTO());
        mav.addObject("comments", commentService.findAll());
        mav.addObject("id", id);
        mav.addObject("model", model);
        return mav;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView newsSearch(@RequestParam("q") String q,
                                   @RequestParam("page") int page) {
        ModelAndView mav = new ModelAndView("web/news/search");
        NewsDTO model = new NewsDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest((page - 1), SystemConstant.PAGE_LIMIT);
        model.setListResult(newsService.findNewsByStringTitle(pageable, q, true));
        model.setTotalItem(newsService.getTotalItemByStringTitle(q, true));
        model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));

        List<NewsDTO> latestNews = newsService.findLatestNews(new PageRequest(0, 7));
        List<NewsDTO> trendingNews = newsService.findTrendingNews(new PageRequest(0, 3));


        mav.addObject("latestNews", latestNews);
        mav.addObject("trendingNews", trendingNews);
        mav.addObject("categories", categoryService.findAllToDTO());
        mav.addObject("model", model);
        return mav;
    }
}
