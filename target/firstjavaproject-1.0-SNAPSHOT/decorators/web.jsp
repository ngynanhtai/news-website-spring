<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 12/09/2021
  Time: 6:51 CH
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/common/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="RegistrationAPI" value="/api/register"/>
<c:url var="UserAPI" value="/api/forgotPassword"/>
<c:url var="HomeURL" value="/home"/>
<c:url var="SearchURL" value="/search"/>
<html>
<head>
    <title><dec:title default="true" /></title>
    <!-- plugin css for this page -->
    <link rel="stylesheet" href="<c:url value='/template/web/assets/vendors/mdi/css/materialdesignicons.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/template/web/assets/vendors/aos/dist/aos.css/aos.css'/>" />

    <!-- End plugin css for this page -->
    <link rel="shortcut icon" href="<c:url value='/template/web/assets/images/favicon.png'/>" />

    <!-- inject:css -->
    <link rel="stylesheet" href="<c:url value='/template/web/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/web/assets/css/mystyle.css'/>">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <!-- end inject -->




</head>
<body>

<div class="container-scroller">
    <div class="main-panel">
        <%--    header    --%>
        <%@include file="/common/web/header.jsp"%>
            <!-- Login / Register Modal-->
            <div class="container">
                <div class="row">
                    <div class="modal fade" data-toggle="modal" id="login-form">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button><br/><br/>
                                    <form action="j_spring_security_check" method="post">
                                        <div class="form-group">
                                            <label for="username">Username:</label>
                                            <input type="text" class="form-control" id="username" placeholder="Enter username" name="j_username">
                                        </div>
                                        <div class="form-group">
                                            <label for="pwd">Password:</label>
                                            <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="j_password">
                                        </div>
                                        <div class="checkbox">
                                            <label><input type="checkbox" name="remember"> Remember me</label>
                                        </div>
                                        <div>
                                            <a href="javascript:void(0)" onclick="ForgotPassword()" id="forgotPassword" style="float: right;">Forgot Password ?</a><br/>
                                        </div>
                                        <div class="modal-footer d-flex justify-content-center">
                                            <button type="submit" class="btn btn-secondary registration-btn">Login</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="modal fade" id="registration-form" data-toggle="modal">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button><br/><br/>
                                    <form id="formRegister">
                                        <div class="form-group">
                                            <label for="fullName">Your Fullname:</label>
                                            <input type="text" class="form-control" id="fullname" placeholder="Enter your name" name="fullName">
                                        </div>
                                        <div class="form-group">
                                            <label for="newUsername">Username:</label>
                                            <input type="text" class="form-control" id="newUsername" placeholder="Enter new username" name="username" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="newPassword">Password:</label>
                                            <input type="password" class="form-control" id="newPassword" placeholder="Enter new password" name="password" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email:</label>
                                            <input type="email" class="form-control" id="email" placeholder="Enter new email" name="email" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="address">Address:</label>
                                            <input type="text" class="form-control" id="address" placeholder="Enter new address" name="address">
                                        </div>
                                        <div class="modal-footer d-flex justify-content-center">
                                            <button type="button" onclick="Register()" class="btn btn-secondary registration-btn">Register</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="sendValidCodeModal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title">Forgot password</h5> <br/>
                            <form id="sendValidCodeForm">
                                <div class="form-group">
                                    <label>Your Username:</label>
                                    <input type="text" class="form-control" placeholder="Enter your username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label>Your email:</label>
                                    <input type="email" class="form-control" placeholder="Enter your email" name="email" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button type="button" onclick="SendValidCode()" class="btn btn-secondary registration-btn">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="forgotPasswordModal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title">Forgot password</h5> <br/>
                            <p style="font-weight: bold;">&#9993;Please check your email for validate code</p><br/>
                            <form id="forgotPasswordForm">
                                <div class="form-group">
                                    <label for="validCode">Validate code:</label>
                                    <input type="text" class="form-control" id="validCode" placeholder="Enter validate code from your email" name="validCode" required>
                                </div>
                                <div class="form-group">
                                    <label for="changePassword">New Password:</label>
                                    <input type="password" class="form-control" id="changePassword" placeholder="Enter your new password" name="newPassword" required>
                                </div>
                                <div class="form-group">
                                    <label for="checkChangePassword">Confirm New Password:</label>
                                    <input type="password" class="form-control" id="checkChangePassword" placeholder="Enter your new password again" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button type="button" onclick="ChangePassword()" class="btn btn-secondary registration-btn">Change Password</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="inputError" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title">Input error !</h5> <br/>
                            <p>Please input value to all fields.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <dec:body/>

        <%--    footer    --%>
        <%@include file="/common/web/footer.jsp"%>
    </div>
</div>
<script type="text/javascript">
    var dt = new Date();
    var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    document.getElementById('date-time').innerHTML = dt.toLocaleString('ICT', options);

    $("#searchInput").on('keyup', function (e) {
        var searchValue = $("#searchInput").val();
        if (e.key === 'Enter' || e.keyCode === 13) {
            window.location.href = "${SearchURL}?q="+searchValue+"&page=1";
        }
    });

    function Register() {
        var isValidForm = document.forms['formRegister'].checkValidity();
        if (isValidForm) {
            var data = {};
            var formData = $('#formRegister').serializeArray();
            $.each(formData, function (i, v){
                data[""+v.name+""] = v.value;
            });
            createUser(data);
        } else {
            $('#inputError').modal('show');
        }
    }

    function createUser(data) {
        $.ajax({
            url: '${RegistrationAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(result) {
                window.location.href = "${HomeURL}?message=createUser_success";
            },
            error: function(error) {
                window.location.href = "${HomeURL}?message=error_system";
            }
        });
    }

    function ForgotPassword() {
        $('#sendValidCodeModal').modal('show');
    }

    function SendValidCode() {
        var isValidForm = document.forms['sendValidCodeForm'].checkValidity();
        if (isValidForm) {
            var data = {};
            var formData = $('#sendValidCodeForm').serializeArray();
            $.each(formData, function (i, v){
                data[""+v.name+""] = v.value;
            });
            sendValidCode(data);
        } else {
            $('#inputError').modal('show');
        }
    }

    function sendValidCode(data) {
        $.ajax({
            url: '${UserAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(data, textStatus, xhr) {
                $('#forgotPasswordModal').modal('show');
                $('#sendValidCodeModal').modal('hide');
            },
            error: function(data, textStatus, xhr) {
                alert(data);
            }
        });
    }

    function ChangePassword() {
        var isValidForm = document.forms['forgotPasswordForm'].checkValidity();
        var newPW = $('#changePassword').val();
        var checknewPW = $('#checkChangePassword').val();
        if (isValidForm) {
            if (newPW === checknewPW) {
                var data = {};
                var formData = $('#forgotPasswordForm').serializeArray();
                $.each(formData, function (i, v) {
                    data["" + v.name + ""] = v.value;
                });
                forgotPassword(data);
            } else {
                var checkChangePassword = document.getElementById("checkChangePassword");

                checkChangePassword.addEventListener("keyup", function (event) {
                    if (checkChangePassword.validity.typeMismatch) {
                        checkChangePassword.setCustomValidity("Bạn cần phải nhập đúng với mật khẩu đã nhập");
                    } else {
                        checkChangePassword.setCustomValidity("");
                    }
                });
            }
        }
    }

    function forgotPassword(data) {
        $.ajax({
            url: '${UserAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(data, textStatus, xhr) {
                alert(data);
                $('#forgotPasswordModal').modal('hide');
            },
            error: function(data, textStatus, xhr) {
                alert(data);
            }
        });
    }


</script>
<!-- inject:js -->
<script src="<c:url value='/template/web/assets/vendors/js/vendor.bundle.base.js'/>"></script>
<!-- end inject -->
<!-- plugin js for this page -->
<script src="<c:url value='/template/web/assets/vendors/aos/dist/aos.js/aos.js'/>"></script>
<!-- End plugin js for this page -->
<!-- Custom js for this page-->
<script src="<c:url value='/template/web/assets/js/demo.js'/>"></script>
<script src="<c:url value='/template/web/assets/js/jquery.easeScroll.js'/>"></script>
<!-- End custom js for this page-->

</body>
</html>
