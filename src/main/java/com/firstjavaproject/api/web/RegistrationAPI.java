package com.firstjavaproject.api.web;

import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RegistrationAPI {

    @Autowired
    private IUserService userService;

    @PostMapping("/api/register")
    public void createUser(@RequestBody UserDTO user) {
        userService.sendMail(user);
        userService.saveNewUser(user);
    }
}
