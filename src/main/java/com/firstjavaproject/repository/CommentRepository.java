package com.firstjavaproject.repository;

import com.firstjavaproject.entity.CommentEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {
    int countCommentEntityByNews_Id(long news_id);
    List<CommentEntity> findCommentEntitiesByNewsIdOrderByCreateDateDesc(long news_id, Pageable pageable);
}
