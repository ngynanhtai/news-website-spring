package com.firstjavaproject.converter;

import com.firstjavaproject.constant.SystemConstant;
import com.firstjavaproject.dto.CommentDTO;
import com.firstjavaproject.entity.CommentEntity;
import com.firstjavaproject.entity.NewsEntity;
import com.firstjavaproject.entity.UserEntity;
import com.firstjavaproject.repository.NewsRepository;
import com.firstjavaproject.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Locale;

@Component
public class CommentConverter {

    @Autowired
    private NewsRepository newsRepository;

    @Autowired
    private UserRepository userRepository;

    public CommentDTO toDTO(CommentEntity entity) {
        CommentDTO result = new CommentDTO();
        SimpleDateFormat dateFormat = new SimpleDateFormat(SystemConstant.DATE_FORMAT, Locale.US);
        result.setId(entity.getId());
        result.setContent(entity.getContent());
        result.setNews_id(entity.getNews().getId());
        result.setUser_id(entity.getUser().getId());
        result.setUser_fullname(entity.getUser().getFullname());
        result.setUser_username(entity.getUser().getUserName());
        result.setUser_avatar(entity.getUser().getAvatar());
        result.setCreateBy(entity.getCreatedBy());
        result.setCreatedDate(dateFormat.format(entity.getCreateDate()));
        result.setModifiedBy(entity.getModifiedBy());
        result.setModifiedDate(dateFormat.format(entity.getModifiedDate()));
        return result;
    }

    public CommentEntity toEntity(CommentDTO dto) {
        CommentEntity result = new CommentEntity();
        NewsEntity news = newsRepository.findOne(dto.getNews_id());
        UserEntity user = userRepository.findOne(dto.getUser_id());
        result.setNews(news);
        result.setUser(user);
        result.setContent(dto.getContent());
        return result;
    }

    public CommentEntity toEntity(CommentEntity result, CommentDTO dto) {
        NewsEntity news = newsRepository.findOne(dto.getNews_id());
        UserEntity user = userRepository.findOne(dto.getUser_id());
        result.setNews(news);
        result.setUser(user);
        result.setContent(dto.getContent());
        return result;
    }
}
