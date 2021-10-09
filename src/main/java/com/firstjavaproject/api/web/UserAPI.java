package com.firstjavaproject.api.web;

import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value="apiUserOfWeb")
public class UserAPI {

    @Autowired
    private IUserService userService;

    private String code;
    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @PostMapping("/api/forgotPassword")
    public ResponseEntity<?> sendValidCode(@RequestBody UserDTO user) {
        if (userService.findOneByUserNameAndEmail(user)) {
            String code = userService.sendMail(user);
            setCode(code);
            setUsername(user.getUsername());
        } else {
            return ResponseEntity.status(503).body("Cannot find your username");
        }
        return null;
    }

    @PutMapping("/api/forgotPassword")
    public ResponseEntity<?> changePassword(@RequestBody UserDTO user) {
        if (user.getValidCode().equals(getCode())) {
            userService.changePassword(user, getUsername());
            return ResponseEntity.status(200).body("Change password success !");
        } else {
            return ResponseEntity.status(503).body("Invalid code, please check your code again");
        }
    }

}
