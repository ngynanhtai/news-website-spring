package com.firstjavaproject.converter;

import com.firstjavaproject.dto.CategoryDTO;
import com.firstjavaproject.entity.CategoryEntity;
import org.springframework.stereotype.Component;

@Component
public class CategoryConverter {
    public CategoryDTO toDTO(CategoryEntity entity) {
        CategoryDTO result = new CategoryDTO();
        result.setId(entity.getId());
        result.setName(entity.getName());
        result.setCode(entity.getCode());
        return result;
    }

    public CategoryEntity toEntity(CategoryDTO dto) {
        CategoryEntity result = new CategoryEntity();
        result.setName(dto.getName());
        result.setCode(dto.getCode());
        return result;
    }

    public CategoryEntity toEntity(CategoryEntity result, CategoryDTO dto) {
        result.setName(dto.getName());
        result.setCode(dto.getCode());
        return result;
    }
}
