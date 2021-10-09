<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 06/10/2021
  Time: 3:58 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="CommentAPI" value="/api-comment"/>
<c:url var="CommentLIST" value="/admin/comment-list"/>
<html>
<head>
    <title>Quản lý bình luận của bài viết</title>
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
                <li>
                    <a href="<c:url value="/admin/comment?page=1"/>">Số bình luận của bài viết</a>
                </li>
                <li class="active">Quản lý bình luận của bài viết</li>
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
                    <div class="modal" tabindex="-1" role="dialog" id="deleteModal" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h5 class="modal-title">Delete Message</h5>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure that you want to delete ?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="btnConfirmDelete" class="btn btn-primary">Yes</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="widget-box table-filter">
                                <div class="dt-buttons">
                                    <button id="btnDelete" type="button"
                                            class="dt-button buttons-html5 btn btn-white btn-primary btn-bold pull-right" data-toggle="tooltip" title="Xoá">
                                        <span>
                                            <i class="fa fa-trash-o bigger-110 pink"></i>
                                        </span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form action="<c:url value="/admin/comment-list"/>" id="formSubmit" method="get">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th><input type="checkbox" id="checkAll"></th>
                                            <th>Người dùng</th>
                                            <th>Bình luận</th>
                                            <th>Like</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="item" items="${model.listResult}">
                                            <tr>
                                                <td><input type="checkbox" id=checkbox_${item.id}" value="${item.id}"></td>
                                                <td>${item.user_fullname} (${item.user_username})</td>
                                                <td>${item.content}</td>
                                                <td></td>
                                                <td>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <ul class="pagination" id="pagination"></ul>
                                    <input type="hidden" id="page" name="page" value=""/>
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
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPage,
            visiblePages: 10,
            startPage: currentPage,
            onPageClick: function (event, page) {
                if (currentPage != page) {
                    $('#page').val(page);
                    $('#formSubmit').submit();
                }
            }
        });
    });

    $('#checkAll').click(function(){
        $('input:checkbox').not(this).prop('checked', this.checked);
    });

    $('#btnDelete').click(function(){
        $('#deleteModal').modal('show');
    });

    $('#btnConfirmDelete').click(function(){
        var ids = $('tbody input[type=checkbox]:checked').map(function() {
            return $(this).val();
        }).get();
        deleteComment(ids);
    })

    function deleteComment(ids) {
        var newsID = ${model.news_id};
        $.ajax({
            url: '${CommentAPI}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(ids),
            success: function (result) {
                window.location.href = "${CommentLIST}?newsID="+newsID+"&page=1&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CommentLIST}?newsID="+newsID+"&page=1&message=error_system";
            }
        });
    }
</script>

</body>
</html>
