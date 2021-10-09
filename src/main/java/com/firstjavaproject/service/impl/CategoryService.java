package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.CategoryConverter;
import com.firstjavaproject.dto.CategoryDTO;
import com.firstjavaproject.entity.CategoryEntity;
import com.firstjavaproject.repository.CategoryRepository;
import com.firstjavaproject.repository.NewsRepository;
import com.firstjavaproject.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private NewsRepository newsRepository;

    @Autowired
    private CategoryConverter categoryConverter;

    @Override
    public Map<String, String> findAll() {
        Map<String, String> results = new HashMap<>();
        List<CategoryEntity> entities = categoryRepository.findAll();
        for (CategoryEntity item : entities) {
            results.put(item.getCode(), item.getName());
        }
        return results;
    }

    @Override
    public List<CategoryDTO> findAllToDTO() {
        List<CategoryEntity> entities = categoryRepository.findAll();
        List<CategoryDTO> categories = new ArrayList<>();
        for (CategoryEntity item : entities) {
            CategoryDTO dto = new CategoryDTO();
            dto = categoryConverter.toDTO(item);
            dto.setCountNews(newsRepository.countNewsEntityByCategoryCodeAndStatus(dto.getCode(), true));
            categories.add(dto);
        }
        return categories;
    }

    @Override
    public CategoryDTO findCategoryByCode(String code) {
        return categoryConverter.toDTO(categoryRepository.findByCode(code));
    }
}
