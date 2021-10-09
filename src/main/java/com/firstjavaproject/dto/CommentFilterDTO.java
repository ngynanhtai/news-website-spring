package com.firstjavaproject.dto;

public class CommentFilterDTO extends BaseDTO<CommentFilterDTO>{
    private String keyword;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
}
