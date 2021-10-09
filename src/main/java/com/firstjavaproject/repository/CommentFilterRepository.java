package com.firstjavaproject.repository;

import com.firstjavaproject.entity.CommentFilterEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentFilterRepository extends JpaRepository<CommentFilterEntity, Long> {
}
