<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 30/08/2021
  Time: 6:25 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="NewsAPI" value="/api-news"/>
<c:url var="NewsEDIT" value="/admin/news-edit"/>
<c:url var="NewsLIST" value="/admin/news-list"/>
<c:url var="PendingNewsAPI" value="/api-pendingNews"/>

<html>
<head>
    <title>Danh sách bài viết</title>
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
                <li class="active">Danh sách bài viết</li>
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
                    <div class="modal" tabindex="-1" role="dialog" id="updateStatusModal" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h5 class="modal-title">DEACTIVATE NEWS</h5>
                                </div>
                                <div class="modal-body">
                                    <p>Are you sure that you want to deactivate this news ?</p>
                                </div>
                                <div class="modal-footer">
                                    <button style="background-color: red;" type="button" id="btnConfirmUpdateStatus" class="btn btn-primary">DEACTIVATE</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                <div class="dt-buttons">
                                    <button id="btnDelete" type="button"
                                            class="dt-button buttons-html5 btn btn-white btn-primary btn-bold pull-right" data-toggle="tooltip" title="Xoá">
                                        <span>
                                            <i class="fa fa-trash-o bigger-110 pink"></i>
                                        </span>
                                    </button>
                                    <a flag="info"
                                       class="dt-button buttons-colvis btn btn-white btn-primary btn-bold pull-right" data-toggle="tooltip"
                                       title="Thêm bài viết" href="<c:url value='/admin/news-edit'/>">
                                        <span>
                                            <i class="fa fa-plus-circle bigger-110 purple"></i>
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form action="<c:url value="/admin/news-list"/>" id="formSubmit" method="get">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th><input type="checkbox" id="checkAll"></th>
                                            <th>Thể loại</th>
                                            <th>Tên bài viết</th>
                                            <th>Mô tả ngắn</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="item" items="${model.listResult}">
                                            <tr>
                                                <td><input type="checkbox" id=checkbox_${item.id}" value="${item.id}"></td>
                                                <td>${item.categoryName}</td>
                                                <td>${item.title}</td>
                                                <td>${item.shortDescription}</td>
                                                <td style="width: 120px;">
                                                    <div style="display: flex; flex-direction: row; background-color: white !important;">
                                                        <div style="flex: 1;">
                                                            <a style="width: 39px; margin: 5px;" class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip"
                                                               title="Chi tiết bài viết" href='<c:url value='/admin/news-edit?id=${item.id}'/>'>
                                                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                            </a>
                                                        </div>
                                                        <div style="flex: 1;">
                                                            <a style="margin: 5px; width: 39px; background-color: darkred !important; border-color: darkred !important;" class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip"
                                                               title="Deactivate" href='javascript:void(0)' onclick="DeactivatePendingNews(${item.id})">
                                                                <i class="fa fa-toggle-on" aria-hidden="true"></i>
                                                            </a>
                                                        </div>
                                                    </div>
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


<%--  script  --%>
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

    function DeactivatePendingNews(id) {
        var data = {};
        data["id"] = id;
        data["status"] = false;
        $('#updateStatusModal').modal('show');

        $('#btnConfirmUpdateStatus').click(function (){
            updateStatus(data);
        });
    }

    function updateStatus(data) {
        $.ajax({
            url: '${PendingNewsAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${NewsLIST}?page=1&message=update_success";
            },
            error: function (error) {
                window.location.href = "${NewsLIST}?page=1&message=error_system";
            }
        });
    }

    $(function(){
        // bind change event to select
        $('#categoryCode').on('change', function () {
            var dropdownRoleVal = $('#categoryCode').val();

            var url = $(this).val();
            if (url) {
                if (dropdownRoleVal === "all") {
                    window.location = "${NewsLIST}?page=1";
                }
                else {
                    window.location = "${NewsLIST}?page=1&sortList="+dropdownRoleVal;
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
        deleteNews(ids);
    })

    function deleteNews(ids) {
        $.ajax({
            url: '${NewsAPI}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(ids),
            success: function (result) {
                window.location.href = "${NewsLIST}?page=1&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${NewsLIST}?page=1&message=error_system";
            }
        });
    }

</script>
</body>
</html>
