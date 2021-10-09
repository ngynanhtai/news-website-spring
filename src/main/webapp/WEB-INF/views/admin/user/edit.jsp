<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="UserAPI" value="/api-user"/>
<c:url var="UserEDIT" value="/admin/user-edit"/>
<c:url var="UserLIST" value="/admin/user-list"/>


<html>
<head>
    <title>
        <c:if test="${not empty model.id}">Chỉnh sửa người dùng</c:if>
        <c:if test="${empty model.id}">Thêm người dùng</c:if>
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
                    <a href="<c:url value='/admin/user-list?page=1&limit=5&sortName=roleCode'/>">Danh sách người dùng</a>
                </li>
                <c:if test="${not empty model.id}"><li class="active">Chỉnh sửa người dùng</li></c:if>
                <c:if test="${empty model.id}"><li class="active">Thêm người dùng</li></c:if>

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
                    <form:form id="formSubmit" modelAttribute="model" enctype="multipart/form-data">
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Role</label>
                            <div class="col-sm-9">
                                <form:select path="roleCode" id="roleCode">
                                    <form:option value="" label="-- Phân quyền --"/>
                                    <form:options items="${roles}"/>
                                </form:select>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Tên đăng nhập</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="username" name="username" value="${model.username}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mật khẩu</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="password" name="password" value="${model.password}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Họ và tên</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${model.fullName}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Email</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="email" name="email" value="${model.email}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Địa chỉ</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="address" name="address" value="${model.address}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Hình đại diện</label>
                            <div class="col-sm-9">
                                <input type="file" class="form-control" id="avatar" name="avatar" value=""/>
                                <c:if test="${not empty model.avatar}">
                                    <div id="preview">
                                        <img src="<c:url value="${model.avatar}"/>" style="height: 100px; width: 100px;"/>
                                    </div>
                                </c:if>
                                <div id="preview-afterupdate"></div>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Cập nhật người dùng" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Thêm người dùng" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                            </div>
                        </div>
                        <input type="hidden" id="userID" value="${model.id}" name="id"/>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    var base64 = "";
    $('#avatar').change(function() {
        var file = $('#avatar')[0].files[0];
        if (file !== undefined) {
            var reader = new FileReader();
            reader.onload = function (e) {
                base64 = e.target.result;
                $($.parseHTML('<img>')).attr('src', e.target.result).appendTo('#preview-afterupdate').width(100).height(100);
            };
            reader.readAsDataURL(file);
            $('#preview').hide();
            $('#preview-afterupdate').show();
        }
    });

    $('#btnAddOrUpdateNew').click(function(e) {
        e.preventDefault();
        var id = $('#userID').val();
        var data = {};
        var formData = $('#formSubmit').serializeArray();
        $.each(formData, function (i, v){
            data[""+v.name+""] = v.value;
        });

        var file = $('#avatar')[0].files[0];
        if (file !== undefined) {
            data["avatar_base64"] = base64;
            data["avatar_name"] = file.name;
        }
        if (id == "") {
            createUser(data);
        } else {
            updateUser(data);
        }
    });

    function updateUser(data) {
        var id = $('#userID').val();
        $.ajax({
            url: '${UserAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${UserEDIT}?id="+result.id+"&message=update_success";
            },
            error: function(error) {
                window.location.href = "${UserEDIT}?id="+id+"&message=error_system";
            }
        });
    }

    function createUser(data) {
        $.ajax({
            url: '${UserAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${UserEDIT}?id="+result.id+"&message=create_success";
            },
            error: function(error) {
                window.location.href = "${UserLIST}?page=1&sortName=roleCode&message=error_system";
            }
        });
    }
</script>
</body>
</html>
