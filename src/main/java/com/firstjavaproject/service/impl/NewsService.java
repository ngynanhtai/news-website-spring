package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.NewsConverter;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.entity.CategoryEntity;
import com.firstjavaproject.entity.NewsEntity;
import com.firstjavaproject.repository.CategoryRepository;
import com.firstjavaproject.repository.NewsRepository;
import com.firstjavaproject.service.INewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class NewsService implements INewsService {

    @Autowired
    private NewsRepository newsRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private NewsConverter newsConverter;

    @Override
    public List<NewsDTO> findAll(Boolean status) {
        List<NewsEntity> entities = newsRepository.findAllByStatus(status);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findAll(Pageable pageable, Boolean status) {
        List<NewsDTO> model = new ArrayList<>();
        List<NewsEntity> entities = newsRepository.findAllByStatusOrderByCreateDateDesc(pageable, status);
        for (NewsEntity item : entities) {
            NewsDTO newsDTO = newsConverter.toDTO(item);
            model.add(newsDTO);
        }
        return model;
    }

    @Override
    public List<NewsDTO> findNewsByStringTitle(Pageable pageable, String title, Boolean status) {
        List<NewsEntity> entities = newsRepository.findNewsEntitiesByTitleContainsAndStatusOrderByCreateDateDesc(pageable, title, status);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findNewsByCategory(Pageable pageable, String sortList, Boolean status) {
        CategoryEntity category = categoryRepository.findByCode(sortList);
        List<NewsEntity> entities = newsRepository.findNewsEntityByCategoryAndStatusOrderByCreateDateDesc(pageable, category, status);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findLatestNews(Pageable pageable) {
        List<NewsEntity> entities = newsRepository.findAllByStatusOrderByCreateDateDesc(pageable, true);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findTrendingNews(Pageable pageable) {
        List<NewsEntity> entities = newsRepository.findAllByStatusOrderByViewsDesc(pageable, true);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findLatestNewsByCategory(Pageable pageable, String categoryCode) {
        CategoryEntity category = categoryRepository.findByCode(categoryCode);
        List<NewsEntity> entities = newsRepository.findNewsEntityByCategoryAndStatusOrderByCreateDateDesc(pageable, category, true);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public List<NewsDTO> findTrendingNewsByCategory(Pageable pageable, String categoryCode) {
        CategoryEntity category = categoryRepository.findByCode(categoryCode);
        List<NewsEntity> entities = newsRepository.findNewsEntityByCategoryAndStatusOrderByViewsDesc(pageable, category, true);
        List<NewsDTO> news = new ArrayList<>();
        for (NewsEntity item : entities) {
            NewsDTO dto = newsConverter.toDTO(item);
            news.add(dto);
        }
        return news;
    }

    @Override
    public NewsDTO findFlashNews() {
        return newsConverter.toDTO(newsRepository.findNewsEntityByFlashNewsIsTrue());
    }

    @Override
    public int getTotalItem(Boolean status) {
        return newsRepository.countNewsEntityByStatus(status);
    }

    @Override
    public int getTotalItemByCode(String code, Boolean status) {
        return newsRepository.countNewsEntityByCategoryCodeAndStatus(code, status);
    }

    @Override
    public int getTotalItemByStringTitle(String q, Boolean status) {
        return newsRepository.countNewsEntityByTitleContainsAndStatus(q, status);
    }

    @Override
    @Transactional
    public void updateFlashNewsStatus(long id) {
        newsRepository.updateFlashNewsStatusForAllItem(id);
        newsRepository.updateFlashNewsStatus(id);
    }

    @Override
    @Transactional
    public void updateViewWhenAccessPage(long id) {
        newsRepository.updateViewWhenAccessPage(id);
    }

    @Override
    public NewsDTO findOneByID(Long id) {
        return newsConverter.toDTO(newsRepository.findOne(id));
    }

    @Override
    @Transactional
    public void deleteNews(long[] ids) {
        for (long id : ids) {
            newsRepository.delete(id);
        }
    }

    @Override
    @Transactional
    public NewsDTO saveNews(NewsDTO dto) {
        CategoryEntity category = categoryRepository.findByCode(dto.getCategoryCode());
        NewsEntity news = new NewsEntity();
        if (dto.getId() != null) {
            NewsEntity oldNews = newsRepository.findOne(dto.getId());
            oldNews.setCategory(category);
            if (dto.getThumbnail() == null) {
                dto.setThumbnail(oldNews.getThumbnail());
            }
            news = newsConverter.toEntity(oldNews, dto);
        } else {
            dto.setFlashNews(false);
            news = newsConverter.toEntity(dto);
            news.setCategory(category);
            news.setViews((long)0);
            news.setStatus(false);

        }
        return newsConverter.toDTO(newsRepository.save(news));
    }

    @Override
    @Transactional
    public void updatePendingNewsStatus(Long id, Boolean status) {
        newsRepository.updatePendingNewsStatus(id, status);
    }
}
