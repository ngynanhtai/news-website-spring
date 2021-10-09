package com.firstjavaproject.service;

import com.firstjavaproject.dto.NewsDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface INewsService {
    List<NewsDTO> findAll(Boolean status);
    List<NewsDTO> findAll(Pageable pageable, Boolean status);
    List<NewsDTO> findNewsByStringTitle(Pageable pageable, String title, Boolean status);
    List<NewsDTO> findNewsByCategory(Pageable pageable, String sortList, Boolean status);
    List<NewsDTO> findLatestNews(Pageable pageable);
    List<NewsDTO> findTrendingNews(Pageable pageable);
    List<NewsDTO> findLatestNewsByCategory(Pageable pageable, String categoryCode);
    List<NewsDTO> findTrendingNewsByCategory(Pageable pageable, String categoryCode);
    NewsDTO findFlashNews();
    NewsDTO findOneByID(Long id);
    NewsDTO saveNews(NewsDTO dto);
    void updatePendingNewsStatus(Long id, Boolean status);
    void deleteNews(long[] ids);
    void updateFlashNewsStatus(long id);
    void updateViewWhenAccessPage(long id);
    int getTotalItem(Boolean status);
    int getTotalItemByCode(String code, Boolean status);
    int getTotalItemByStringTitle(String q, Boolean status);


}
