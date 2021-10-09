package com.firstjavaproject.service.impl;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.MyUser;
import com.firstjavaproject.entity.RoleEntity;
import com.firstjavaproject.entity.UserEntity;
import com.firstjavaproject.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity userEntity = userRepository.findOneByUserNameAndStatus(username, SystemConstant.ACTIVE_STATUS);

        if (userEntity == null) {
            throw new UsernameNotFoundException("User not found");
        }
        List<GrantedAuthority> authorities = new ArrayList<>();
        RoleEntity role = userEntity.getRole();
        authorities.add(new SimpleGrantedAuthority(role.getCode()));

        MyUser myUser = new MyUser(userEntity.getUserName(), userEntity.getPassword(), true, true, true, true, authorities);
        myUser.setFullName(userEntity.getFullname());
        myUser.setId(userEntity.getId());
        return myUser;
    }
}
