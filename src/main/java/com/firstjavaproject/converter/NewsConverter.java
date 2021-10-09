package com.firstjavaproject.converter;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.entity.NewsEntity;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Locale;

@Component
public class NewsConverter {
    public NewsDTO toDTO(NewsEntity entity) {
        NewsDTO result = new NewsDTO();
        SimpleDateFormat dateFormat = new SimpleDateFormat(SystemConstant.DATE_FORMAT, Locale.US);
        result.setId(entity.getId());
        result.setTitle(entity.getTitle());
        result.setContent(entity.getContent());
        result.setFlashNews(entity.getFlashNews());
        result.setStatus(entity.getStatus());
        result.setViews(entity.getViews());
        result.setShortDescription(entity.getShortDescription());
        result.setThumbnail(entity.getThumbnail());
        result.setCategoryName(entity.getCategory().getName());
        result.setCategoryCode(entity.getCategory().getCode());
        result.setCreateBy(entity.getCreatedBy());
        result.setCreatedDate(dateFormat.format(entity.getCreateDate()));
        result.setModifiedBy(entity.getModifiedBy());
        result.setModifiedDate(dateFormat.format(entity.getModifiedDate()));
        return result;
    }

    public NewsEntity toEntity(NewsDTO dto) {
        NewsEntity result = new NewsEntity();
        result.setTitle(dto.getTitle());
        result.setContent(dto.getContent());
        result.setShortDescription(dto.getShortDescription());
        result.setThumbnail(dto.getThumbnail());
        result.setFlashNews(dto.getFlashNews());
        result.setStatus(dto.getStatus());
        result.setViews(dto.getViews());
        return result;
    }

    public NewsEntity toEntity(NewsEntity result, NewsDTO dto) {
        result.setTitle(dto.getTitle());
        result.setContent(dto.getContent());
        result.setShortDescription(dto.getShortDescription());
        result.setThumbnail(dto.getThumbnail());
        result.setStatus(dto.getStatus());
        result.setFlashNews(dto.getFlashNews());
        result.setViews(dto.getViews());
        return result;
    }
}
