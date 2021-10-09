<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="NewsAPI" value="/api-news"/>
<c:url var="NewsEDIT" value="/admin/news-edit"/>
<c:url var="NewsLIST" value="/admin/news-list"/>
<c:url var="PendingNewsLIST" value="/admin/news-pending"/>


<html>
<head>
    <title>
        <c:if test="${not empty model.id}">Chỉnh sửa bài viết</c:if>
        <c:if test="${empty model.id}">Thêm bài viết</c:if>
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
                    <a href="<c:url value='/admin/news-list?page=1'/>">Danh sách bài viết</a>
                </li>
                <c:if test="${not empty model.id}"><li class="active">Chỉnh sửa bài viết</li></c:if>
                <c:if test="${empty model.id}"><li class="active">Thêm bài viết</li></c:if>

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
                            <label class="col-sm-3 control-label no-padding-right" style="font-weight: bold; color: #d1011c;">FLASH NEWS</label>
                            <div class="col-sm-9">
                                <select id="flashNews" name="flashNews">
                                    <c:if test="${empty model.id}">
                                        <option value="${model.flashNews = true}">Yes</option>
                                        <option value="${model.flashNews = false}" selected="selected">No</option>
                                    </c:if>
                                    <c:if test="${not empty model.id}">
                                        <option value="${model.flashNews = true}" <c:if test="${flashNews == 'true'}"> selected="selected" </c:if> >Yes</option>
                                        <option value="${model.flashNews = false}" <c:if test="${flashNews == 'false'}"> selected="selected" </c:if> >No</option>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Thể loại</label>
                            <div class="col-sm-9">
                                <form:select path="categoryCode" id="categoryCode">
                                    <form:option value="" label="Chọn loại bài viết"/>
                                    <form:options items="${categories}"/>
                                </form:select>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Tiêu đề</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="title" name="title" value="${model.title}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Hình đại diện</label>
                            <div class="col-sm-9">
                                <input type="file" class="form-control" id="thumbnail" name="thumbnail" value=""/>
                                <c:if test="${not empty model.thumbnail}">
                                    <div id="preview">
                                        <img src="<c:url value="${model.thumbnail}"/>" style="height: 100px; width: 200px;"/>
                                    </div>
                                </c:if>
                                <div id="preview-afterupdate"></div>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mô tả ngắn</label>
                            <div class="col-sm-9">
                                <textarea rows="" cols="" class="form-control" id="shortDescription" name="shortDescription">${model.shortDescription}</textarea>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Nội dung</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" id="content" name="content" >${model.content}</textarea>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Cập nhật bài viết" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold" value="Thêm bài viết" id="btnAddOrUpdateNew" style="float: right;"/>
                                </c:if>
                            </div>
                        </div>
                        <input type="hidden" id="newsID" value="${model.id}" name="id"/>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var editor = '';
    $(document).ready(function(){
        editor = CKEDITOR.replace('content');
    });

    var base64 = "";
    $('#thumbnail').change(function() {
        var file = $('#thumbnail')[0].files[0];
        if (file !== undefined) {
            var reader = new FileReader();
            reader.onload = function (e) {
                base64 = e.target.result;
                $($.parseHTML('<img>')).attr('src', e.target.result).appendTo('#preview-afterupdate').width(200).height(100);
            };
            reader.readAsDataURL(file);
            $('#preview').hide();
            $('#preview-afterupdate').show();
        }
    });

    $('#btnAddOrUpdateNew').click(function(e) {
        e.preventDefault();
        var id = $('#newsID').val();
        var data = {};
        var formData = $('#formSubmit').serializeArray();
        $.each(formData, function (i, v){
            data[""+v.name+""] = v.value;
        });
        data["content"] = editor.getData();

        var fileData = {};
        var file = $('#thumbnail')[0].files[0];
        if (file !== undefined) {
            fileData = {"thumbnail_base64": base64, "thumbnail_name": file.name};
        }

        var mergeData = {};

        Object.keys(data).forEach(key => mergeData[key] = data[key]);
        Object.keys(fileData).forEach(key => mergeData[key] = fileData[key]);

        if (id == "") {
            createNews(mergeData);
        } else {
            updateNews(mergeData);
        }

    });

    function updateNews(mergeData) {
        var id = $('#newsID').val();
        $.ajax({
            url: '${NewsAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(mergeData),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${NewsEDIT}?id="+result.id+"&message=update_success";
            },
            error: function(error) {
                window.location.href = "${NewsEDIT}?id="+id+"&message=error_system";
            }
        });
    }

    function createNews(mergeData) {
        $.ajax({
            url: '${NewsAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(mergeData),
            dataType: 'json',
            success: function(result) {
                window.location.href = "${PendingNewsLIST}?page=1&message=create_success";
            },
            error: function(error) {
                window.location.href = "${NewsEDIT}?message=error_system";
            }
        });
    }
</script>
</body>
</html>
