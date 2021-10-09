package com.firstjavaproject.converter;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.entity.UserEntity;
import com.firstjavaproject.repository.RoleRepository;
import com.firstjavaproject.security.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Locale;

@Component
public class UserConverter {

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserDTO toDTO(UserEntity entity) {
        UserDTO result = new UserDTO();
        SimpleDateFormat dateFormat = new SimpleDateFormat(SystemConstant.DATE_FORMAT, Locale.US);
        result.setId(entity.getId());
        result.setUsername(entity.getUserName());
        result.setPassword(passwordEncoder.encoder().encode(entity.getPassword()));
        result.setFullName(entity.getFullname());
        result.setEmail(entity.getEmail());
        result.setAddress(entity.getAddress());
        result.setRoleName(entity.getRole().getName());
        result.setRoleCode(entity.getRole().getCode());
        result.setAvatar(entity.getAvatar());
        result.setCreateBy(entity.getCreatedBy());
        result.setCreatedDate(dateFormat.format(entity.getCreateDate()));
        result.setModifiedBy(entity.getModifiedBy());
        result.setModifiedDate(dateFormat.format(entity.getModifiedDate()));
        return result;
    }

    public UserEntity toEntity(UserDTO dto) {
        UserEntity result = new UserEntity();
        result.setUserName(dto.getUsername());
        result.setPassword(passwordEncoder.encoder().encode(dto.getPassword()));
        result.setFullname(dto.getFullName());
        result.setEmail(dto.getEmail());
        result.setAddress(dto.getAddress());
        result.setStatus((long)1);
        result.setAvatar(dto.getAvatar());
        return result;
    }

    public UserEntity toEntity(UserEntity result, UserDTO dto) {
        result.setUserName(dto.getUsername());
        result.setPassword(passwordEncoder.encoder().encode(dto.getPassword()));
        result.setFullname(dto.getFullName());
        result.setEmail(dto.getEmail());
        result.setAddress(dto.getAddress());
        result.setStatus((long)1);
        result.setAvatar(dto.getAvatar());
        return result;
    }
}
