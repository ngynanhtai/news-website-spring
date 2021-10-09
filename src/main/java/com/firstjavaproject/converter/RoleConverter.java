package com.firstjavaproject.converter;

import com.firstjavaproject.dto.RoleDTO;
import com.firstjavaproject.entity.RoleEntity;
import org.springframework.stereotype.Component;

@Component
public class RoleConverter {
    public RoleDTO toDTO(RoleEntity entity) {
        RoleDTO result = new RoleDTO();
        result.setId(entity.getId());
        result.setName(entity.getName());
        result.setCode(entity.getCode());
        return result;
    }

    public RoleEntity toEntity(RoleDTO dto) {
        RoleEntity result = new RoleEntity();
        result.setName(dto.getName());
        result.setCode(dto.getCode());
        return result;
    }

    public RoleEntity toEntity(RoleEntity result, RoleEntity dto) {
        result.setName(dto.getName());
        result.setCode(dto.getCode());
        return result;
    }
}
