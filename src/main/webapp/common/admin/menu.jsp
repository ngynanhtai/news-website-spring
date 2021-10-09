<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="sidebar" class="sidebar                  responsive                    ace-save-state">
    <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>
    <div class="sidebar-shortcuts">
        <div class="sidebar-shortcuts-large">
            <button class="btn btn-success">
                <i class="ace-icon fa fa-signal"></i>
            </button>

            <button class="btn btn-info">
                <i class="ace-icon fa fa-pencil"></i>
            </button>

            <button class="btn btn-warning">
                <i class="ace-icon fa fa-users"></i>
            </button>

            <button class="btn btn-danger">
                <i class="ace-icon fa fa-cogs"></i>
            </button>
        </div>
        <div class="sidebar-shortcuts-mini">
            <span class="btn btn-success"></span>

            <span class="btn btn-info"></span>

            <span class="btn btn-warning"></span>

            <span class="btn btn-danger"></span>
        </div>
    </div>
    <ul class="nav nav-list">
        <li >
            <a href="#" class="dropdown-toggle">
                <i class="menu-icon fa fa-list"></i>
                <span class="menu-text"></span>
                Quản lý bài viết
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li>
                    <a href='<c:url value="/admin/news-list?page=1"/>'>
                        <i class="menu-icon fa fa-caret-right"></i>
                        Danh sách bài viết
                    </a>
                    <b class="arrow"></b>
                </li>
                <li>
                    <a href='<c:url value="/admin/news-pending?page=1"/>'>
                        <i class="menu-icon fa fa-caret-right"></i>
                        Bài viết chờ xử lý
                    </a>
                    <b class="arrow"></b>
                </li>
            </ul>
        </li>
        <li >
            <a href="#" class="dropdown-toggle">
                <i class="menu-icon fa fa-user"></i>
                <span class="menu-text"></span>
                Quản lý người dùng
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li>
                    <a href='<c:url value="/admin/user-list?page=1"/>'>
                        <i class="menu-icon fa fa-caret-right"></i>
                        Danh sách người dùng
                    </a>
                    <b class="arrow"></b>
                </li>
            </ul>
        </li>
        <li >
            <a href="#" class="dropdown-toggle">
                <i class="menu-icon fa fa-comment"></i>
                <span class="menu-text"></span>
                Quản lý bình luận
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li>
                    <a href='<c:url value="/admin/comment?page=1"/>'>
                        <i class="menu-icon fa fa-caret-right"></i>
                        Bình luận trong bài viết
                    </a>
                    <b class="arrow"></b>
                </li>
                <li>
                    <a href='<c:url value="/admin/comment-filter?page=1"/>'>
                        <i class="menu-icon fa fa-caret-right"></i>
                        Từ khoá cấm
                    </a>
                    <b class="arrow"></b>
                </li>
            </ul>
        </li>
    </ul>
    <div class="sidebar-toggle sidebar-collapse">
        <i class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>