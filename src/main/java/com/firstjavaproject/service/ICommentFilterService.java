package com.firstjavaproject.service;

import com.firstjavaproject.dto.CommentFilterDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ICommentFilterService {
    int getTotalKeyword();
    void deleteKeyword(long[] ids);
    CommentFilterDTO saveKeyword(CommentFilterDTO dto);
    CommentFilterDTO findOneByID(long id);
    List<CommentFilterDTO> findAll(Pageable pageable);
}
