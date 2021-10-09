package com.firstjavaproject.service;

import com.firstjavaproject.dto.CategoryDTO;
import com.firstjavaproject.entity.CategoryEntity;

import java.util.List;
import java.util.Map;

public interface ICategoryService {
    Map<String, String> findAll();
    List<CategoryDTO> findAllToDTO();
    CategoryDTO findCategoryByCode(String code);
}
