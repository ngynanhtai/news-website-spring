package com.firstjavaproject.api.admin;

import com.firstjavaproject.dto.NewsDTO;
import com.firstjavaproject.service.INewsService;
import com.firstjavaproject.util.UploadFileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;

@RestController(value="apiNewsOfAdmin")
public class NewsAPI {

    @Autowired
    private INewsService newsService;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @PostMapping("/api-news")
    public NewsDTO createNews(@RequestBody NewsDTO news) {
        NewsDTO dto = newsService.saveNews(news);
        long id = dto.getId();
        if (news.getThumbnail_base64() != null) {
            String partSeperator = ",";
            if (news.getThumbnail_base64().contains(partSeperator)) {
                String encodeThumbnail = news.getThumbnail_base64().split(partSeperator)[1];
                byte[] decodeBase64 = Base64.getDecoder().decode(encodeThumbnail.getBytes(StandardCharsets.UTF_8));
                news.setThumbnail(uploadFileUtils.WriteOrUpdate(decodeBase64, "/uploads/news_thumbnail/news_" + id + "/" + news.getThumbnail_name()));
            }
        }
        if(news.getFlashNews()) {
            newsService.updateFlashNewsStatus(id);
        }
        return dto;
    }

    @PutMapping("/api-news")
    public NewsDTO updateNews(@RequestBody NewsDTO updateNews) {
        if (updateNews.getThumbnail_base64() != null) {
            String partSeperator = ",";
            if (updateNews.getThumbnail_base64().contains(partSeperator)) {
                String encodeThumbnail = updateNews.getThumbnail_base64().split(partSeperator)[1];
                byte[] decodeBase64 = Base64.getDecoder().decode(encodeThumbnail.getBytes(StandardCharsets.UTF_8));
                updateNews.setThumbnail(uploadFileUtils.WriteOrUpdate(decodeBase64, "/uploads/news_thumbnail/news_" + updateNews.getId() + "/" + updateNews.getThumbnail_name()));
            }
        }
        if (updateNews.getFlashNews()) {
            newsService.updateFlashNewsStatus(updateNews.getId());
        }
        return newsService.saveNews(updateNews);
    }

    @DeleteMapping("/api-news")
    public void deleteNews(@RequestBody long[] ids) {
        newsService.deleteNews(ids);
    }

    @PutMapping("/api-pendingNews")
    public void updatePendingNewsStatus(@RequestBody Map<String, String> json) {
        Long id = Long.parseLong(json.get("id"));
        Boolean status = Boolean.parseBoolean(json.get("status"));
        newsService.updatePendingNewsStatus(id, status);
    }
}
