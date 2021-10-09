package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.CommentConverter;
import com.firstjavaproject.dto.CommentDTO;
import com.firstjavaproject.entity.CommentEntity;
import com.firstjavaproject.entity.CommentFilterEntity;
import com.firstjavaproject.repository.CommentFilterRepository;
import com.firstjavaproject.repository.CommentRepository;
import com.firstjavaproject.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentService implements ICommentService {

    @Autowired
    private CommentFilterRepository commentFilterRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private CommentConverter commentConverter;

    @Override
    @Transactional
    public boolean saveComment(CommentDTO comment) {
        List<CommentFilterEntity> keywords = commentFilterRepository.findAll();
        for(CommentFilterEntity item : keywords) {
            if (comment.getContent().contains(item.getKeyword())) {
                return false;
            }
        }
        commentRepository.save(commentConverter.toEntity(comment));
        return true;
    }

    @Override
    public int getTotalCommentInNews(long news_id) {
        return commentRepository.countCommentEntityByNews_Id(news_id);
    }

    @Override
    @Transactional
    public void deleteComment(long[] ids) {
        for(long id : ids) {
            commentRepository.delete(id);
        }
    }

    @Override
    public List<CommentDTO> findAll() {
        List<CommentEntity> entities = commentRepository.findAll();
        List<CommentDTO> comments = new ArrayList<>();
        for (CommentEntity item : entities) {
            CommentDTO dto = commentConverter.toDTO(item);
            comments.add(dto);
        }
        return comments;
    }

    @Override
    public List<CommentDTO> findCommentByNewsID(long news_id, Pageable pageable) {
        List<CommentDTO> comments = new ArrayList<>();
        List<CommentEntity> entities = commentRepository.findCommentEntitiesByNewsIdOrderByCreateDateDesc(news_id, pageable);
        for (CommentEntity item : entities) {
            CommentDTO dto = commentConverter.toDTO(item);
            comments.add(dto);
        }
        return comments;
    }
}
