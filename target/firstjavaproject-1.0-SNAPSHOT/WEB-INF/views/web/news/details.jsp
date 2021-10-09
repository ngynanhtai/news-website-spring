<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 26/09/2021
  Time: 10:23 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<%@ page import="com.firstjavaproject.util.SecurityUtils" %>
<c:url var="CommentAPI" value="/api/comment"/>
<html>
<head>
    <title>${model.title}</title>
</head>
<body>
<div class="content-wrapper">
    <div class="container">
        <div class="col-sm-12">
            <div class="card" data-aos="fade-up">
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-8">
                            <div>
                                <h1 class="font-weight-600 mb-1">
                                    ${model.title}
                                </h1>
                                <p class="fs-13 text-muted mb-0">
                                    <span class="mr-2">${model.createBy} </span> ${model.createdDate}
                                </p>
                                <div>
                                    <img src="<c:url value="${model.thumbnail}"/>" alt="banner" class="img-fluid mt-4 mb-4"/>
                                </div>
                                <p class="mb-4 fs-15">
                                    ${model.content}
                                </p>
                            </div>
                            <div class="post-comment-section">
                                <h3 class="font-weight-600">Related Posts</h3>
                                <div class="row">
                                    <c:forEach begin="3" end="5" var="item" items="${latestNewsByCategory}">
                                        <div class="col-sm-6">
                                            <div class="post-author" style="flex-direction: row;">
                                                <div class="rotate-img" style="flex: 1;">
                                                    <a href="<c:url value="/details?id=${item.id}"/>">
                                                        <img src="<c:url value="${item.thumbnail}"/>" style="width: 300px; height: 180px;" alt="banner" class="img-fluid"/>
                                                    </a>
                                                </div>
                                                <div class="post-author-content" style="flex: 1;">
                                                    <h5 class="mb-1">
                                                        <a style="color: black;" href="<c:url value="/details?id=${item.id}"/>">
                                                            ${item.title}
                                                        </a>
                                                    </h5>
                                                    <p class="fs-13 text-muted mb-0">
                                                        <span class="mr-2">${item.createBy} </span> ${item.createdDate}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="comment-section">
                                    <h5 class="font-weight-600">Comments</h5>
                                    <div>
                                        <security:authorize access="isAuthenticated()">
                                            <form id="formSubmit">
                                                <div class="form-group">
                                                    <textarea class="form-control" rows="3" cols="15" id="content" name="content" required></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <input style="width: 79px; height: 34px; float: right; border-radius: 15%" type="button" value="Gửi" id="btnComment">
                                                </div>
                                                <br/>
                                            </form>
                                        </security:authorize>
                                    </div>
                                    <c:forEach var="item" items="${comments}">
                                        <div class="comment-box">
                                            <div class="d-flex align-items-center">
                                                <div class="rotate-img">
                                                    <img style="height: 46px; width: 46px;" src="<c:url value="${item.user_avatar}"/>" alt="banner" class="img-fluid img-rounded mr-3"/>
                                                </div>
                                                <div>
                                                    <p class="fs-12 mb-1 line-height-xs">
                                                        ${item.createdDate}
                                                    </p>
                                                    <p class="fs-16 font-weight-600 mb-0 line-height-xs">
                                                        ${item.user_fullname}
                                                    </p>
                                                </div>
                                            </div>

                                            <p class="fs-12 mt-3">
                                                ${item.content}
                                            </p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <h2 class="mb-4 text-primary font-weight-600">
                                Latest news
                            </h2>
                            <c:forEach begin="0" end="2" var="item" items="${latestNewsByCategory}">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="border-bottom pb-4 pt-4">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h5 class="font-weight-600 mb-1">
                                                        <a style="color: black; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;" href="<c:url value="/details?id=${item.id}"/>">
                                                                ${item.title}
                                                        </a>
                                                    </h5>
                                                    <p class="fs-13 text-muted mb-0">
                                                        <span class="mr-2">${item.createBy} </span> ${item.createdDate}
                                                    </p>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="rotate-img">
                                                        <a href="<c:url value="/details?id=${item.id}"/>">
                                                            <img style="height: 82px; width: 136px;" src="<c:url value="${item.thumbnail}"/>" alt="banner" class="img-fluid"/>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <div class="trending">
                                <h2 class="mb-4 text-primary font-weight-600">
                                    Trending
                                </h2>
                                <c:forEach var="item" items="${trendingNews}">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="border-bottom pb-4 pt-4">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <h5 class="font-weight-600 mb-1">
                                                            <a style="color: black; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;" href="<c:url value="/details?id=${item.id}"/>">
                                                                    ${item.title}
                                                            </a>
                                                        </h5>
                                                        <p class="fs-13 text-muted mb-0">
                                                            <span class="mr-2">${item.createBy} </span> ${item.createdDate}
                                                        </p>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="rotate-img">
                                                            <a href="<c:url value="/details?id=${item.id}"/>">
                                                                <img style="height: 82px; width: 136px;" src="<c:url value="${item.thumbnail}"/>" alt="banner" class="img-fluid"/>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- main-panel ends -->

<script>
    <security:authorize access="isAuthenticated()">
        $('#btnComment').click(function() {
        var isValidForm = document.forms['formSubmit'].checkValidity();
        if (isValidForm) {
            var newsID = ${model.id};
            var data = {};
            var formData = $('#formSubmit').serializeArray();
            $.each(formData, function (i, v){
                data[""+v.name+""] = v.value;
            });
            data["news_id"] = newsID;
            data["user_id"] = <%=SecurityUtils.getPrincipal().getId()%>;
            postComment(data);
        } else {
            $('#inputError').modal('show');
        }
    });


    </security:authorize>

    function postComment(data) {
        $.ajax({
            url: '${CommentAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(data, textStatus, xhr) {

            },
            error: function(data, textStatus, xhr) {
                alert(data.responseText);
            }
        });
    }

</script>
</body>
</html>
