package com.firstjavaproject.controller.web;

import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.ICategoryService;
import com.firstjavaproject.service.INewsService;
import com.firstjavaproject.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller(value = "homeControllerOfWeb")
public class HomeController {

    @Autowired
    private MessageUtils messageUtils;

    @Autowired
    private INewsService newsService;

    @Autowired
    private ICategoryService categoryService;

    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView homePageGet(HttpServletRequest request){
        ModelAndView mav = new ModelAndView("web/home");
        if (request.getParameter("message") != null) {
            Map<String, String> message = messageUtils.getMessage(request.getParameter("message"));
            mav.addObject("message", message.get("message"));
            mav.addObject("alert", message.get("alert"));
        }

        NewsDTO flashNews = newsService.findFlashNews();
        List<NewsDTO> latestNews = newsService.findLatestNews(new PageRequest(0, 7));
        List<NewsDTO> trendingNews = newsService.findTrendingNews(new PageRequest(0, 10));
        List<NewsDTO> allNews = newsService.findAll(true);

        if (getCode() != null ) {
            List<NewsDTO> latestNewsByCategory = newsService.findLatestNewsByCategory(new PageRequest(0,3), getCode());
            mav.addObject("latestNewsByCategory", latestNewsByCategory);
        }

        mav.addObject("flashNews", flashNews);
        mav.addObject("latestNews", latestNews);
        mav.addObject("trendingNews", trendingNews);
        mav.addObject("allNews", allNews);
        mav.addObject("categories", categoryService.findAllToDTO());

        return mav;
    }

    @RequestMapping(value = "/home", method = RequestMethod.POST)
    public ModelAndView homePagePost(@RequestBody Map<String, String> json) {
        ModelAndView mav = new ModelAndView("web/home");
        setCode(json.get("code"));

        return mav;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return new ModelAndView("redirect:/home");
    }
}
