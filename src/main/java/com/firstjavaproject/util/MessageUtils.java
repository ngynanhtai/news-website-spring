package com.firstjavaproject.util;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class MessageUtils {
    public Map<String, String> getMessage(String message) {
        Map<String, String> result = new HashMap<>();
        if (message.equals("update_success")) {
            result.put("message", "Cập nhật thành công !");
            result.put("alert", "success");
        } else if (message.equals("create_success")) {
            result.put("message", "Tạo mới thành công !");
            result.put("alert", "success");
        } else if (message.equals("delete_success")) {
            result.put("message", "Xoá thành công !");
            result.put("alert", "success");
        } else if (message.equals("createUser_success")) {
            result.put("message", "Tạo tài khoản thành công !");
            result.put("alert", "success");
        } else if (message.equals("changePassword_success")) {
            result.put("message", "Đã cập nhật lại mật khẩu !");
            result.put("alert", "success");
        } else if (message.equals("sendValidCode_success")) {
            result.put("message", "Đã gửi code xác nhận \n Vui lòng kiểm tra email !");
            result.put("alert", "success");
        } else if (message.equals("error_system")) {
            result.put("message", "Lỗi hệ thống !");
            result.put("alert", "danger");
        }
        return result;
    }
}
