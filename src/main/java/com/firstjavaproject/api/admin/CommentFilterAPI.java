package com.firstjavaproject.api.admin;

import com.firstjavaproject.dto.CommentFilterDTO;
import com.firstjavaproject.service.ICommentFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class CommentFilterAPI {
    @Autowired
    private ICommentFilterService commentFilterService;

    @DeleteMapping("/api-commentFilter")
    public void deleteKeyword(@RequestBody long[] ids) {
        commentFilterService.deleteKeyword(ids);
    }

    @PostMapping("/api-commentFilter")
    public CommentFilterDTO createKeyword(@RequestBody CommentFilterDTO dto) {
        return commentFilterService.saveKeyword(dto);
    }

    @PutMapping("/api-commentFilter")
    public CommentFilterDTO updateKeyword(@RequestBody CommentFilterDTO dto) {
        return commentFilterService.saveKeyword(dto);
    }
}
