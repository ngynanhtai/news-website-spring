package com.firstjavaproject.repository;

import com.firstjavaproject.entity.RoleEntity;
import com.firstjavaproject.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.User;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findOneByUserNameAndStatus(String userName, long status);
    UserEntity findOneByUserName(String userName);
    UserEntity findOneByUserNameAndEmail(String userName, String email);
    List<UserEntity> findUsersByRole(Pageable pageable, RoleEntity role);
    int countUserEntitiesByRoleCode(String code);
}
