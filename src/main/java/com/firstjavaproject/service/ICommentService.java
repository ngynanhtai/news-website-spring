package com.firstjavaproject.service;

import com.firstjavaproject.dto.CommentDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ICommentService {
    boolean saveComment(CommentDTO comment);
    int getTotalCommentInNews(long news_id);
    void deleteComment(long[] ids);
    List<CommentDTO> findAll();
    List<CommentDTO> findCommentByNewsID(long news_id, Pageable pageable);
}
