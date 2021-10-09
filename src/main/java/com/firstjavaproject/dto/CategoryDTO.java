package com.firstjavaproject.dto;

public class CategoryDTO extends BaseDTO<CategoryDTO> {
    private String name;
    private String code;
    private int countNews;

    public int getCountNews() {
        return countNews;
    }

    public void setCountNews(int countNews) {
        this.countNews = countNews;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
