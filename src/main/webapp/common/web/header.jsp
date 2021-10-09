<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.firstjavaproject.util.SecurityUtils" %>

<header id="header">
    <div class="container">
        <c:if test="${param.accessDenied != null}">
            <div class="alert alert-danger alert-dismissible" style="position: absolute; top: 0; right: 0;">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                You don't have permission to access this page !
            </div>
        </c:if>
        <c:if test="${param.incorrectAccount != null}">
            <div class="alert alert-danger alert-dismissible" style="position: absolute; top: 0; right: 0;">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                Username or password is incorrect !
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-${alert} alert-dismissible" style="position: absolute; top: 0; right: 0;">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                ${message}
            </div>
        </c:if>
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="navbar-top">
                <div class="d-flex justify-content-between align-items-center">
                    <ul class="navbar-top-left-menu">
                        <li class="nav-item">
                            <a href="pages/aboutus.html" class="nav-link">About</a>
                        </li>
                        <li class="nav-item">
                            <a href="pages/aboutus.html" class="nav-link">Contact</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">Events</a>
                        </li>
                    </ul>
                    <ul class="navbar-top-right-menu">
                        <li class="nav-item">
                            <input type="text" id="searchInput" style="width: 300px; display: inline-block;" placeholder="Search..."/>
                        </li>
                        <security:authorize access="isAnonymous()">
                            <li class="nav-item">
                                <a href="javascript:void(0)" data-toggle="modal" data-target="#login-form" class="nav-link">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a href="#" data-toggle="modal" data-target="#registration-form" class="nav-link">Đăng ký</a>
                            </li>
                        </security:authorize>
                        <security:authorize access="isAuthenticated()">
                            <li class="nav-item">
                                <a href="javascript:void(0)" class="nav-link">Xin chào, <%=SecurityUtils.getPrincipal().getFullName()%></a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/logout'/>" class="nav-link">Thoát</a>
                            </li>
                        </security:authorize>
                    </ul>
                </div>
            </div>
            <div class="navbar-bottom">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <a class="navbar-brand" href="<c:url value='/home'/>">
                            <img src="<c:url value='/template/web/assets/images/logo.svg'/>" alt=""/>
                        </a>
                    </div>
                    <div>
                        <button class="navbar-toggler"
                                type="button"
                                data-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent"
                                aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="navbar-collapse justify-content-center collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav d-lg-flex justify-content-between align-items-center">
                                <li>
                                    <button class="navbar-close">
                                        <i class="mdi mdi-close"></i>
                                    </button>
                                </li>
                                <li class="nav-item active">
                                    <a class="nav-link" href="<c:url value="/home"/>">Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=the-thao&page=1"/>">Thể thao</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=kinh-doanh&page=1"/>">Kinh doanh</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=thoi-su&page=1"/>">Thời sự</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=chinh-tri&page=1"/>">Chính trị</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=phap-luat&page=1"/>">Pháp luật</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value="/category?code=the-gioi&page=1"/>">Thế giới</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <ul class="social-media">
                        <li>
                            <a href="#">
                                <i class="mdi mdi-facebook"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="mdi mdi-youtube"></i>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="mdi mdi-twitter"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <div class="flash-news-banner">
        <div class="container">
            <div class="d-lg-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <span class="badge badge mr-3" style="color: white; background-color: #d1011c;">Tin nóng</span>
                    <p class="mb-0">
                        <a style="color: #032a63; font-weight: bold;" href="<c:url value="/details?id=${flashNews.id}"/>">${flashNews.title}</a>
                    </p>
                </div>
                <div class="d-flex">
                    <span class="mr-3 text-danger" id="date-time"></span>
                </div>
            </div>
        </div>
    </div>
</header>
