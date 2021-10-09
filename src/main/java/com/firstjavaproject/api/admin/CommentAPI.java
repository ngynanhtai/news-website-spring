package com.firstjavaproject.api.admin;

import com.firstjavaproject.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value = "apiCommentOfAdmin")
public class CommentAPI {

    @Autowired
    private ICommentService commentService;

    @DeleteMapping("/api-comment")
    public void deleteComment(@RequestBody long[] ids) {
        commentService.deleteComment(ids);
    }
}
