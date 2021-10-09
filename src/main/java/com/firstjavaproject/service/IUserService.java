package com.firstjavaproject.service;

import com.firstjavaproject.dto.UserDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IUserService {
    List<UserDTO> findALl(Pageable pageable);
    List<UserDTO> findUsersByRole(Pageable pageable, String sortList);
    UserDTO findOneByID(Long id);
    boolean findOneByUserNameAndEmail(UserDTO dto);
    UserDTO saveUserFromAdmin(UserDTO dto);
    void saveNewUser(UserDTO dto);
    void deleteUser(long[] ids);
    void changePassword(UserDTO dto, String username);
    String sendMail(UserDTO dto);
    int getTotalItem();
    int getTotalItemByCode(String code);
}
