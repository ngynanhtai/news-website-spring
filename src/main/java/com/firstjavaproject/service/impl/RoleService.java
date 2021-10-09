package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.RoleConverter;
import com.firstjavaproject.dto.RoleDTO;
import com.firstjavaproject.entity.RoleEntity;
import com.firstjavaproject.repository.RoleRepository;
import com.firstjavaproject.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleService implements IRoleService {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private RoleConverter roleConverter;


    @Override
    public Map<String, String> findAll() {
        Map<String, String> results = new HashMap<>();
        List<RoleEntity> entities = roleRepository.findAll();
        for (RoleEntity item : entities) {
            results.put(item.getCode(), item.getName());
        }
        return results;
    }

    @Override
    public List<RoleDTO> findAllToDTO() {
        List<RoleEntity> entities = roleRepository.findAll();
        List<RoleDTO> roles = new ArrayList<>();
        for (RoleEntity item : entities) {
            RoleDTO dto = roleConverter.toDTO(item);
            roles.add(dto);
        }
        return roles;
    }


}
