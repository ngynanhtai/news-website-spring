package com.firstjavaproject.repository;

import com.firstjavaproject.entity.CategoryEntity;
import com.firstjavaproject.entity.NewsEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface NewsRepository extends JpaRepository<NewsEntity, Long> {
    List<NewsEntity>findNewsByCategory(Pageable pageable, CategoryEntity category);
    List<NewsEntity>findNewsEntitiesByTitleContainsAndStatusOrderByCreateDateDesc(Pageable pageable, String title, Boolean status);
    List<NewsEntity>findNewsEntityByCategoryAndStatusOrderByCreateDateDesc(Pageable pageable, CategoryEntity category, Boolean status);
    List<NewsEntity>findNewsEntityByCategoryAndStatusOrderByViewsDesc(Pageable pageable, CategoryEntity category, Boolean status);
    List<NewsEntity>findAllByStatusOrderByCreateDateDesc(Pageable pageable, Boolean status);
    List<NewsEntity>findAllByStatusOrderByViewsDesc(Pageable pageable, Boolean status);
    List<NewsEntity>findAllByStatus(Boolean status);
    NewsEntity findNewsEntityByFlashNewsIsTrue();
    int countNewsEntityByStatus(Boolean status);
    int countNewsEntityByCategoryCodeAndStatus(String code, Boolean status);
    int countNewsEntityByTitleContainsAndStatus(String q, Boolean status);


    @Transactional
    @Modifying
    @Query(value = "UPDATE NewsEntity e SET e.status = ?2 WHERE e.id = ?1")
    void updatePendingNewsStatus(long id, Boolean status);

    @Transactional
    @Modifying
    @Query(value = "UPDATE NewsEntity e SET e.flashNews = false WHERE e.id <> ?1 ")
    void updateFlashNewsStatusForAllItem(long id);

    @Transactional
    @Modifying
    @Query(value = "UPDATE NewsEntity e SET e.flashNews = true WHERE e.id = ?1")
    void updateFlashNewsStatus(long id);

    @Transactional
    @Modifying
    @Query(value = "UPDATE NewsEntity e SET e.views = e.views + 1 WHERE e.id = ?1")
    void updateViewWhenAccessPage(long id);
}
