package com.firstjavaproject.util;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Component
public class UploadFileUtils {

    private final String root = "D:/aptech/firstjavaproject/src/main/webapp";

    public String WriteOrUpdate(byte[] bytes, String path) {
        //kiem tra xem folder ton tai hay chua, tao folder
        File file = new File(StringUtils.substringBeforeLast(root + path, "/"));
        if (!file.exists()) {
            file.mkdir();
        }
        //ghi file
        //bỏ cái FileOutputStream trong try luôn do java7 trở lên hỗ trợ close FileOutputStream trong try-catch lu6n
        try(FileOutputStream fileOutputStream = new FileOutputStream(new File(root + path))) {
            fileOutputStream.write(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return path;
    }
}
