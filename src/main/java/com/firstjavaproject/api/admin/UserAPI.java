package com.firstjavaproject.api.admin;

import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.dto.UserDTO;
import com.firstjavaproject.service.IUserService;
import com.firstjavaproject.util.UploadFileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

@RestController(value="apiUserOfAdmin")
public class UserAPI {

    @Autowired
    private IUserService userService;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @PostMapping(value="/api-user")
    public UserDTO createUser(@RequestBody UserDTO user) {
        UserDTO dto = userService.saveUserFromAdmin(user);
        long id = dto.getId();
        if (user.getAvatar_base64() != null) {
            String partSeperator = ",";
            if (user.getAvatar_base64().contains(partSeperator)) {
                String encodeThumbnail = user.getAvatar_base64().split(partSeperator)[1];
                byte[] decodeBase64 = Base64.getDecoder().decode(encodeThumbnail.getBytes(StandardCharsets.UTF_8));
                user.setAvatar(uploadFileUtils.WriteOrUpdate(decodeBase64, "/uploads/user_avatar/user_" + id + "/" + user.getAvatar_name()));
            }
        }
        return dto;
    }

    @PutMapping(value="/api-user")
    public UserDTO updateUser(@RequestBody UserDTO user) {
        if (user.getAvatar_base64() != null) {
            String partSeperator = ",";
            if (user.getAvatar_base64().contains(partSeperator)) {
                String encodeThumbnail = user.getAvatar_base64().split(partSeperator)[1];
                byte[] decodeBase64 = Base64.getDecoder().decode(encodeThumbnail.getBytes(StandardCharsets.UTF_8));
                user.setAvatar(uploadFileUtils.WriteOrUpdate(decodeBase64, "/uploads/user_avatar/user_" + user.getId() + "/" + user.getAvatar_name()));
            }
        }
        return userService.saveUserFromAdmin(user);
    }

    @DeleteMapping(value="/api-user")
    public void deleteUser(@RequestBody long[] ids) {
        userService.deleteUser(ids);
    }
}
