package com.firstjavaproject.dto;

public class NewsDTO extends BaseDTO<NewsDTO>{
    private String title;
    private String content;
    private String shortDescription;
    private String thumbnail;
    private String thumbnail_base64;
    private String thumbnail_name;
    private Long category_id;
    private Long views;
    private Boolean flashNews;
    private Boolean status;
    private String categoryCode;
    private String categoryName;
    private int totalComment;

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public int getTotalComment() {
        return totalComment;
    }

    public void setTotalComment(int totalComment) {
        this.totalComment = totalComment;
    }

    public String getThumbnail_name() {
        return thumbnail_name;
    }

    public void setThumbnail_name(String thumbnail_name) {
        this.thumbnail_name = thumbnail_name;
    }

    public String getThumbnail_base64() {
        return thumbnail_base64;
    }

    public void setThumbnail_base64(String thumbnail_base64) {
        this.thumbnail_base64 = thumbnail_base64;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Long category_id) {
        this.category_id = category_id;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }

    public Boolean getFlashNews() {
        return flashNews;
    }

    public void setFlashNews(Boolean flashNews) {
        this.flashNews = flashNews;
    }

    public String getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        this.categoryCode = categoryCode;
    }
}
