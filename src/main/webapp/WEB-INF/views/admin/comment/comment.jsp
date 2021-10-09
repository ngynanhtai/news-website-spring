<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 06/10/2021
  Time: 3:06 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="CommentURL" value="/admin/comment"/>
<html>
<head>
    <title>Số bình luận của bài viết</title>
</head>
<body>
    <div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs ace-save-state" id="breadcrumbs">
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value="/admin/home"/>">Trang chủ</a>
                </li>
                <li class="active">Số bình luận của bài viết</li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty message}">
                        <div class="alert alert-${alert}">
                                ${message}
                        </div>
                    </c:if>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="widget-box table-filter">
                                <div class="pull-left">
                                    <select id="categoryCode" name="categoryCode">
                                        <c:if test="${not empty param.sortList}">
                                            <option value="all">Tất cả bài viết</option>
                                            <c:forEach items="${categories}" var="item">
                                                <option id="sortCategory" value="${item.code}"
                                                        <c:if test="${item.code == param.sortList}">
                                                            selected="selected"
                                                        </c:if>
                                                >${item.name}</option>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty param.sortList}">
                                            <option value="all">Tất cả bài viết</option>
                                            <c:forEach items="${categories}" var="item">
                                                <option id="sortCategory" value="${item.code}">${item.name}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form action="<c:url value="/admin/comment"/>" id="formSubmit" method="get">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Thể loại</th>
                                            <th>Tên bài viết</th>
                                            <th>Số bình luận</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="item" items="${model.listResult}">
                                            <tr>
                                                <td>${item.categoryName}</td>
                                                <td>${item.title}</td>
                                                <td>${item.totalComment}</td>
                                                <td>
                                                    <a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip"
                                                       title="Bình luận trong bài viết" href='<c:url value='/admin/comment-list?newsID=${item.id}&page=1'/>'>
                                                        <i class="fa fa-folder-o" aria-hidden="true"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <ul class="pagination" id="pagination"></ul>
                                    <input type="hidden" id="page" name="page" value=""/>
                                    <input type="hidden" id="sortList" name="sortList" value=""/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> <%-- main content --%>

<script type="text/javascript">
    var totalPage = ${model.totalPage};
    var currentPage = ${model.page};
    var sortList = $('#categoryCode').val();
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPage,
            visiblePages: 10,
            startPage: currentPage,
            onPageClick: function (event, page) {
                if (currentPage != page) {
                    $('#page').val(page);
                    if (sortList != null && sortList != "all") {
                        $('#sortList').val(sortList);
                    }
                    $('#formSubmit').submit();
                }
            }
        });
    });

    $(function(){
        // bind change event to select
        $('#categoryCode').on('change', function () {
            var dropdownRoleVal = $('#categoryCode').val();

            var url = $(this).val();
            if (url) {
                if (dropdownRoleVal === "all") {
                    window.location = "${CommentURL}?page=1";
                }
                else {
                    window.location = "${CommentURL}?page=1&sortList="+dropdownRoleVal;
                }
            }
        });
    });
</script>
</body>
</html>
