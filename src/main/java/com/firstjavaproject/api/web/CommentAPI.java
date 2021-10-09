package com.firstjavaproject.api.web;

import com.firstjavaproject.dto.CommentDTO;
import com.firstjavaproject.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value="apiCommentOfWeb")
public class CommentAPI {

    @Autowired
    private ICommentService commentService;

    @PostMapping("/api/comment")
    public ResponseEntity<?> postComment(@RequestBody CommentDTO comment) {
        if (commentService.saveComment(comment)) {
            return null;
        } else {
            return ResponseEntity.status(503).body("Your comment includes some restricted keywords. Try again !");
        }
    }
}
