<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 26/09/2021
  Time: 2:27 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>
</head>
<body>
<div class="content-wrapper">
    <div class="container">
        <div class="col-sm-12">
            <div class="card" data-aos="fade-up">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <h1 class="font-weight-600 mb-4">
                                Search
                            </h1>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-8">
                            <c:forEach items="${model.listResult}" var="item">
                                <div class="row">
                                    <div class="col-sm-4 grid-margin">
                                        <div class="rotate-img">
                                            <a href="<c:url value="/details?id=${item.id}"/>">
                                                <img src="<c:url value="${item.thumbnail}"/>" alt="banner" class="img-fluid"/>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 grid-margin">
                                        <h2 class="font-weight-600 mb-2">
                                            <a href="<c:url value="/details?id=${item.id}"/>" style="color: black;">
                                                    ${item.title}
                                            </a>
                                        </h2>
                                        <p class="fs-13 text-muted mb-0">
                                            <span class="mr-2">${item.createBy} </span> ${item.createdDate}
                                        </p>
                                        <p class="fs-15">
                                                ${item.shortDescription}
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="container myPaginationContainer">
                                <ul class="myPagination">
                                    <c:if test="${model.page != 1}">
                                        <li><a href="<c:url value="/category?code=${category.code}&page=${model.page - 1}"/>">Prev</a></li>
                                    </c:if>
                                    <c:if test="${model.page == 1}">
                                        <li><a href="javascript:void(0)">Prev</a></li>
                                    </c:if>

                                    <c:forEach begin="1" end="${model.totalPage}" var="i">
                                        <c:choose>
                                            <c:when test="${model.page eq i}">
                                                <li><a href="javascript:void(0)" style="background-color: #032a63; color: white;">${i}</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="<c:url value="/category?code=${category.code}&page=${i}"/>">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <c:if test="${model.page lt model.totalPage}">
                                        <li><a href="<c:url value="/category?code=${category.code}&page=${model.page + 1}"/>">Next</a></li>
                                    </c:if>
                                    <c:if test="${model.page == model.totalPage}">
                                        <li><a href="javascript:void(0)">Next</a></li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <h2 class="mb-4 text-primary font-weight-600">
                                Latest news
                            </h2>
                            <c:forEach begin="0" end="2" var="item" items="${latestNews}">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="border-bottom pb-4 pt-4">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <h5 class="font-weight-600 mb-1">
                                                        <a href="<c:url value="/details?id=${item.id}"/>" style="color: black; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
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

<script type="text/javascript">

</script>
</body>
</html>
