package com.firstjavaproject.service.impl;

import com.firstjavaproject.converter.UserConverter;
import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.entity.RoleEntity;
import com.firstjavaproject.entity.UserEntity;
import com.firstjavaproject.repository.RoleRepository;
import com.firstjavaproject.repository.UserRepository;
import com.firstjavaproject.security.PasswordEncoder;
import com.firstjavaproject.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public List<UserDTO> findALl(Pageable pageable) {
        List<UserDTO> model = new ArrayList<>();
        List<UserEntity> entity = userRepository.findAll(pageable).getContent();
        for (UserEntity item : entity) {
            UserDTO dto = userConverter.toDTO(item);
            model.add(dto);
        }
        return model;
    }

    @Override
    public int getTotalItem() {
        return (int) userRepository.count();
    }

    @Override
    public int getTotalItemByCode(String code) {
        return userRepository.countUserEntitiesByRoleCode(code);
    }

    @Override
    @Transactional
    public void saveNewUser(UserDTO dto) {
        UserEntity newUser = new UserEntity();
        UserEntity checkUser = userRepository.findOneByUserName(dto.getUsername());
        if (checkUser == null) {
            newUser = userConverter.toEntity(dto);
            RoleEntity role = roleRepository.findByCode("USER");
            newUser.setRole(role);
            userRepository.save(newUser);
        }
    }

    @Override
    @Transactional
    public UserDTO saveUserFromAdmin(UserDTO dto) {
        if (!dto.getRoleCode().equals("ADMIN")) {
            UserEntity checkUser = userRepository.findOneByUserName(dto.getUsername());
            UserEntity newUser = new UserEntity();
            RoleEntity role = roleRepository.findByCode(dto.getRoleCode());
            if (dto.getId() != null) {
                UserEntity oldUser = userRepository.findOne(dto.getId());
                oldUser.setRole(role);
                if (dto.getAvatar() == null) {
                    dto.setAvatar(oldUser.getAvatar());
                }
                newUser = userConverter.toEntity(oldUser, dto);
            } else if(dto.getId() == null && checkUser == null) {
                newUser = userConverter.toEntity(dto);
                newUser.setRole(role);
            }
            return userConverter.toDTO(userRepository.save(newUser));
        }
        return null;
    }

    @Override
    public UserDTO findOneByID(Long id) {
        return userConverter.toDTO(userRepository.findOne(id));
    }

    @Override
    public boolean findOneByUserNameAndEmail(UserDTO dto) {
        UserEntity checkUser = userRepository.findOneByUserNameAndEmail(dto.getUsername(), dto.getEmail());
        boolean check = false;
        if (checkUser != null) {
            check = true;
        } else {
            check = false;
        }
        return check;
    }

    @Override
    public List<UserDTO> findUsersByRole(Pageable pageable, String sortList) {
        RoleEntity role = roleRepository.findByCode(sortList);
        List<UserEntity> entities = userRepository.findUsersByRole(pageable, role);
        List<UserDTO> users = new ArrayList<>();
        for (UserEntity item : entities) {
            UserDTO dto = userConverter.toDTO(item);
            users.add(dto);
        }
        return users;
    }

    @Override
    @Transactional
    public void deleteUser(long[] ids) {
        for (Long id : ids) {
            UserEntity user = userRepository.findOne(id);
            if (!user.getRole().getCode().equals("ADMIN")) {
                userRepository.delete(id);
            }
        }
    }

    @Override
    @Transactional
    public void changePassword(UserDTO dto, String username) {
        UserEntity user = userRepository.findOneByUserName(username);
        user.setPassword(passwordEncoder.encoder().encode(dto.getNewPassword()));
        userRepository.save(user);
    }

    @Override
    public String sendMail(UserDTO dto) {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(dto.getEmail());
        email.setSubject("Account Validation !");

        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 10;
        Random random = new Random();
        String generatedString = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        email.setText("Validate code: " + generatedString);

        javaMailSender.send(email);
        return generatedString;
    }
}
