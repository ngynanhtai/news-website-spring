package com.firstjavaproject.converter;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.CommentFilterDTO;
import com.firstjavaproject.entity.CommentFilterEntity;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Locale;

@Component
public class CommentFilterConverter {
    public CommentFilterDTO toDTO(CommentFilterEntity entity) {
        CommentFilterDTO result = new CommentFilterDTO();
        SimpleDateFormat dateFormat = new SimpleDateFormat(SystemConstant.DATE_FORMAT, Locale.US);
        result.setId(entity.getId());
        result.setKeyword(entity.getKeyword());
        result.setCreateBy(entity.getCreatedBy());
        result.setCreatedDate(dateFormat.format(entity.getCreateDate()));
        result.setModifiedBy(entity.getModifiedBy());
        result.setModifiedDate(dateFormat.format(entity.getModifiedDate()));
        return result;
    }

    public CommentFilterEntity toEntity(CommentFilterDTO dto) {
        CommentFilterEntity result = new CommentFilterEntity();
        result.setKeyword(dto.getKeyword());
        return result;
    }

    public CommentFilterEntity toEntity(CommentFilterEntity result, CommentFilterDTO dto) {
        result.setKeyword(dto.getKeyword());
        return result;
    }
}
