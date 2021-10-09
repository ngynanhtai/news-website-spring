<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 07/10/2021
  Time: 10:06 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="CommentFilterAPI" value="/api-commentFilter"/>
<c:url var="CommentFilterEDIT" value="/admin/comment-filter/edit"/>
<html>
<head>
    <title>
        <c:if test="${not empty model.id}">Chỉnh sửa từ khoá</c:if>
        <c:if test="${empty model.id}">Thêm từ khoá</c:if>
    </title>
</head>
<body>
    <div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value='/admin/home'/>">Trang chủ</a>
                </li>
                <li>
                    <a href="<c:url value='/admin/comment-filter?page=1'/>">Từ khoá cấm</a>
                </li>
                <c:if test="${not empty model.id}"><li class="active">Chỉnh sửa từ khoá</li></c:if>
                <c:if test="${empty model.id}"><li class="active">Thêm từ khoá</li></c:if>

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
                    <form:form id="formSubmit" modelAttribute="model">
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right">Từ khoá</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="keyword" name="keyword" value="${model.keyword}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <div class="col-sm-8">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Cập nhật từ khoá" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Thêm từ khoá" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                            </div>
                        </div>
                        <input type="hidden" id="keywordID" value="${model.id}" name="id"/>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#btnAddOrUpdateNew').click(function(e) {
        e.preventDefault();
        var id = $('#keywordID').val();
        var data = {};
        var formData = $('#formSubmit').serializeArray();
        $.each(formData, function (i, v){
            data[""+v.name+""] = v.value;
        });

        if (id == "") {
            createKeyword(data);
        } else {
            updateKeyword(data);
        }

    });

    function updateKeyword(data) {
        var id = $('#keywordID').val();
        $.ajax({
            url: '${CommentFilterAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${CommentFilterEDIT}?id="+result.id+"&message=update_success";
            },
            error: function(error) {
                window.location.href = "${CommentFilterEDIT}?id="+id+"&message=error_system";
            }
        });
    }

    function createKeyword(data) {
        $.ajax({
            url: '${CommentFilterAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${CommentFilterEDIT}?id="+result.id+"&message=create_success";
            },
            error: function(error) {
                window.location.href = "${CommentFilterEDIT}?message=error_system";
            }
        });
    }
</script>
</body>
</html>
