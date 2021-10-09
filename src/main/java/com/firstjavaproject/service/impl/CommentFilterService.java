package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.CommentFilterConverter;
import com.firstjavaproject.dto.CommentFilterDTO;
import com.firstjavaproject.entity.CommentFilterEntity;
import com.firstjavaproject.repository.CommentFilterRepository;
import com.firstjavaproject.service.ICommentFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentFilterService implements ICommentFilterService {

    @Autowired
    private CommentFilterRepository commentFilterRepository;

    @Autowired
    private CommentFilterConverter commentFilterConverter;

    @Override
    public int getTotalKeyword() {
        return (int)commentFilterRepository.count();
    }

    @Override
    @Transactional
    public void deleteKeyword(long[] ids) {
        for (long id : ids) {
            commentFilterRepository.delete(id);
        }
    }

    @Override
    @Transactional
    public CommentFilterDTO saveKeyword(CommentFilterDTO dto) {
        CommentFilterEntity keyword = new CommentFilterEntity();
        if (dto.getId() != null) {
            CommentFilterEntity oldKeyword = commentFilterRepository.findOne(dto.getId());
            keyword = commentFilterConverter.toEntity(oldKeyword, dto);
        } else {
            keyword = commentFilterConverter.toEntity(dto);
        }
        return commentFilterConverter.toDTO(commentFilterRepository.save(keyword));
    }

    @Override
    public CommentFilterDTO findOneByID(long id) {
        return commentFilterConverter.toDTO(commentFilterRepository.findOne(id));
    }

    @Override
    public List<CommentFilterDTO> findAll(Pageable pageable) {
        List<CommentFilterEntity> entities = commentFilterRepository.findAll();
        List<CommentFilterDTO> keywords = new ArrayList<>();
        for (CommentFilterEntity item : entities) {
            CommentFilterDTO dto = commentFilterConverter.toDTO(item);
            keywords.add(dto);
        }
        return keywords;
    }
}
