package com.firstjavaproject.controller.web;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.ICategoryService;
import com.firstjavaproject.service.INewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "categoryControllerOfWeb")
public class CategoryController {
    @Autowired
    private INewsService newsService;

    @Autowired
    private ICategoryService categoryService;

    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public ModelAndView newsCategory(@RequestParam("code") String code,
                                     @RequestParam("page") int page) {
        ModelAndView mav = new ModelAndView("web/news/categories");
        NewsDTO model = new NewsDTO();
        model.setPage(page);
        Pageable pageable = new PageRequest((page - 1), SystemConstant.PAGE_LIMIT);
        model.setListResult(newsService.findNewsByCategory(pageable, code, true));
        model.setTotalItem(newsService.getTotalItemByCode(code, true));
        model.setTotalPage((int)Math.ceil((double) model.getTotalItem() / SystemConstant.PAGE_LIMIT));

        NewsDTO flashNews = newsService.findFlashNews();
        List<NewsDTO> latestNewsByCategory = newsService.findLatestNewsByCategory(new PageRequest(0, 3),code);
        List<NewsDTO> latestNews = newsService.findLatestNews(new PageRequest(0, 7));
        List<NewsDTO> trendingNews = newsService.findTrendingNewsByCategory(new PageRequest(0, 3) ,code);
        List<NewsDTO> allNews = newsService.findAll(true);

        mav.addObject("latestNews", latestNews);
        mav.addObject("latestNewsByCategory", latestNewsByCategory);
        mav.addObject("trendingNews", trendingNews);
        mav.addObject("flashNews", flashNews);
        mav.addObject("allNews", allNews);
        mav.addObject("category", categoryService.findCategoryByCode(code));
        mav.addObject("categories", categoryService.findAllToDTO());
        mav.addObject("model", model);
        return mav;
    }
}
