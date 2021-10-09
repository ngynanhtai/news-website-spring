package com.firstjavaproject.service;

import com.firstjavaproject.dto.RoleDTO;

import java.util.List;
import java.util.Map;

public interface IRoleService {
    Map<String, String> findAll();
    List<RoleDTO> findAllToDTO();
}
