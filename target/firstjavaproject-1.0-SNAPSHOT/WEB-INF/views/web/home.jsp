<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 12/09/2021
  Time: 9:47 CH
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="HomeURL" value="/home"/>

<html>
<head>
    <title>Trang chủ</title>
</head>
<body>
<!-- partial -->
<div class="content-wrapper">
    <div class="container">
        <div class="row" data-aos="fade-up">
            <div class="col-xl-8 stretch-card grid-margin">
                <c:forEach begin="0" end="0" items="${latestNews}" var="item">
                    <div class="position-relative">
                        <a href="<c:url value="/details?id=${item.id}"/>">
                            <img style="height: 544px; width: 730px;" src="<c:url value="${item.thumbnail}"/>" alt="banner" class="img-fluid"/>
                        </a>
                        <div class="banner-content">
                            <div class="badge badge-danger fs-12 font-weight-bold mb-3">
                                <a href="<c:url value="/category?code=${item.categoryCode}&page=1"/>" style="color: white;">${item.categoryName}</a>
                            </div>
                            <h1 class="mb-0"><a href="<c:url value="/category?code=${item.categoryCode}&page=1"/>" style="color: white;  text-shadow: black 2px 0 0;">${item.categoryName}</a></h1>
                            <h1 class="mb-2">
                                <a href="<c:url value="/details?id=${item.id}"/>" style="color: white; text-shadow: black 2px 0 0;">${item.title}</a>
                            </h1>
                            <div class="fs-12">
                                <span class="mr-2">${item.createBy} </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="col-xl-4 stretch-card grid-margin">
                <div class="card bg-dark text-white">
                    <div class="card-body">
                        <h2>Latest news</h2>
                        <c:forEach begin="1" end="3" items="${latestNews}" var="item">
                            <div class="d-flex border-bottom-blue pb-4 pt-4 align-items-center justify-content-between" style="flex-direction: row;">
                                <div class="pr-3" style="flex: 1;">
                                    <h5>
                                        <a style="color: white; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;" href="<c:url value="/details?id=${item.id}"/>">
                                                ${item.title}
                                        </a>
                                    </h5>
                                    <div class="fs-12">
                                        <span class="mr-2">${item.createBy} </span>
                                    </div>
                                    <div class="fs-12">
                                        <span class="mr-2">${item.createdDate} </span>
                                    </div>
                                </div>
                                <div class="rotate-img" style="flex: 1;">
                                    <a style="color: white;" href="<c:url value="/details?id=${item.id}"/>">
                                        <img src="<c:url value='${item.thumbnail}'/>" alt="thumb" class="img-fluid img-lg"/>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" data-aos="fade-up">
            <div class="col-lg-3 stretch-card grid-margin">
                <div class="card">
                    <div class="card-body">
                        <h2>Danh mục</h2>
                        <ul class="vertical-menu">
                            <c:forEach var="item" items="${categories}">
                                <li id="category_${item.code}"><a href="javascript:void(0)" onclick="ListFunction('${item.code}')">${item.name}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 stretch-card grid-margin">
                <div class="card" id="categoryItem">
                    <div class="card-body">
                        <c:forEach var="item" items="${latestNewsByCategory}">
                            <div class="row">
                                <div class="col-sm-4 grid-margin">
                                    <div class="position-relative">
                                        <div class="rotate-img">
                                            <a href="<c:url value="/details?id=${item.id}"/>">
                                                <img style="height: 123px; width: 206px" src="<c:url value='${item.thumbnail}'/>" alt="thumb" class="img-fluid"/>
                                            </a>
                                        </div>
                                        <div class="badge-positioned">
                                                <span class="badge badge-danger font-weight-bold">Latest</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-8  grid-margin">
                                    <h2 class="mb-2 font-weight-600">
                                        <a style="color: black;" href="<c:url value="/details?id=${item.id}"/>">${item.title}</a>
                                    </h2>
                                    <div class="fs-13 mb-2">
                                        <span class="mr-2">${item.createBy} </span>${item.createdDate}
                                    </div>
                                    <p class="mb-0" style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                        ${item.shortDescription}
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" data-aos="fade-up">
            <div class="col-sm-12 grid-margin">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card-title" style="color: #032a63;">
                                    Trending News
                                </div>
                                <div class="row">
                                    <c:forEach begin="0" end="1" items="${trendingNews}" var="item">
                                        <div class="col-sm-6 grid-margin">
                                            <div class="position-relative">
                                                <div class="rotate-img">
                                                    <a href="<c:url value="/details?id=${item.id}"/>">
                                                        <img style="width: 322px; height: 188px;" src="<c:url value='${item.thumbnail}'/>" alt="thumb" class="img-fluid"/>
                                                    </a>
                                                </div>
                                                <div class="badge-positioned w-90">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="badge badge-danger font-weight-bold">${item.categoryName}</span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <a href="<c:url value="/details?id=${item.id}"/>" style="color: white; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; font-weight: bold; text-shadow: black 2px 0 0;">
                                                            ${item.title}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="row">
                                    <c:forEach begin="2" end="3" items="${trendingNews}" var="item">
                                        <div class="col-sm-6 grid-margin">
                                            <div class="position-relative">
                                                <div class="rotate-img">
                                                    <a href="<c:url value="/details?id=${item.id}"/>">
                                                        <img style="width: 322px; height: 188px;" src="<c:url value='${item.thumbnail}'/>" alt="thumb" class="img-fluid"/>
                                                    </a>
                                                </div>
                                                <div class="badge-positioned w-90">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="badge badge-danger font-weight-bold">${item.categoryName}</span>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <a href="<c:url value="/details?id=${item.id}"/>" style="color: white; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; font-weight: bold; text-shadow: black 2px 0 0;">
                                                            ${item.title}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="card-title" style="color: #032a63;">
                                        Hot News
                                    </div>
                                </div>
                                <c:forEach begin="4" end="10" var="item" items="${trendingNews}">
                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                        <div class="div-w-80 mr-3" style="flex-direction: row;">
                                            <div class="rotate-img" style="flex: 1;">
                                                <a href="<c:url value="/details?id=${item.id}"/>">
                                                    <img style="width: 80px; height: 50px;" src="<c:url value='${item.thumbnail}'/>" alt="thumb" class="img-fluid"/>
                                                </a>
                                            </div>
                                        </div>
                                        <div style="flex: 3;">
                                            <h3 class="font-weight-600 mb-0">
                                                <a href="<c:url value="/details?id=${item.id}"/>" style="color: black; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                                    <p>${item.title}</p>
                                                </a>
                                            </h3>
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
<!-- container-scroller ends -->
<script>

    window.onload = function() {
        ListFunction('the-thao');
    };


    function ListFunction(code) {
        var data = {};
        data["code"] = code;
        $.ajax({
            url: '${HomeURL}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(data) {
                $(" #categoryItem ").load(window.location.href + " #categoryItem" );
            }
        });
    }
</script>
<!-- partial:partials/_footer.html -->
</body>
</html>
