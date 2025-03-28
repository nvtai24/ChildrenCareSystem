<%-- 
    Document   : profile
    Created on : Jan 25, 2025, 10:43:09 PM
    Author     : Nvtai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <main class="ttr-wrapper">
            <!-- The Modal -->
            <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">User Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <form class="edit-profile" onreset="resetChange()" onsubmit="submitChange(event)" enctype="multipart/form-data">

                            <div class="modal-body">
                                <div class="row">
                                    <!-- Avatar -->
                                    <div class="col-md-4 text-center">
                                        <div class="user-profile-thumb" style="width: 150px; height: 150px;">
                                            <img src="${sessionScope.account.profile.avatar != null ? sessionScope.account.profile.avatar :"assets/images/profile/default.jpg"}" id="avatarImage" alt="User Avatar" class="rounded-circle" style="width: 150px; height: 150px; object-fit: cover;">
                                        </div>
                                        <!-- Chỉnh sửa nút Choose File -->
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="avatarInput" name="avatar" style="display: none;" onchange="handleAvatarChange(event)">
                                            <button type="button" class="btn btn-light" onclick="document.getElementById('avatarInput').click()">Choose file</button>
                                        </div>
                                    </div>


                                    <!-- Profile Fields -->
                                    <div class="col-md-8">
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">First Name</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.firstName}" name="firstname">
                                            </div>
                                        </div>

                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Last Name</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.lastName}" name="lastname">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Gender</label>
                                            <div class="col-sm-8">
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="gender" id="male" value="male" ${sessionScope.account.profile.gender ? 'checked' : ''}>
                                                    <label class="form-check-label" for="male">Male</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="gender" id="female" value="female" ${!sessionScope.account.profile.gender ? 'checked' : ''}>
                                                    <label class="form-check-label" for="female">Female</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Birthday</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="date" value="${sessionScope.account.profile.dob}" name="dob">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Address</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.address}" name="address">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Phone Number</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.phone}" name="phone">
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Email</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="email" value="${sessionScope.account.email}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#changePasswordModal">Change Password</button>
                                <button type="submit" class="btn green">Save changes</button>
                                <button type="reset" class="btn red">Reset</button>
                                <button type="button" class="btn gray" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>

            <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="max-width: 500px;">
                    <div class="modal-content" style="padding: 20px; border-radius: 10px; font-family: 'Arial', sans-serif; font-size: 14px; color: #333;">
                        <div class="modal-header" style="background-color: #f8f9fa; border-bottom: 1px solid #dee2e6; padding: 15px;">
                            <h5 class="modal-title" id="changePasswordModalLabel" style="font-weight: bold; font-size: 16px;">Change Password</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="font-size: 18px;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body" style="padding: 20px;">
                            <div id="changePasswordMessage"></div> <!-- Hiển thị thông báo lỗi -->
                            <form id="changePasswordForm">
                                <div class="form-group row" style="margin-bottom: 15px;">
                                    <label for="oldPassword" class="col-sm-4 col-form-label" 
                                           style="font-weight: 600; text-align: right; font-size: 14px;">Current Password</label>
                                    <div class="col-sm-8">
                                        <input type="password" class="form-control" id="oldPassword" name="oldPassword" required oninput="validatePassword()" 
                                               style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 5px; font-size: 14px;">
                                        <small id="oldPasswordError" class="text-danger" style="font-size: 12px; margin-top: 5px;"></small>
                                    </div>
                                </div>

                                <div class="form-group row" style="margin-bottom: 15px;">
                                    <label for="newPassword" class="col-sm-4 col-form-label" 
                                           style="font-weight: 600; text-align: right; font-size: 14px;">New Password</label>
                                    <div class="col-sm-8">
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required oninput="validatePassword()" 
                                               style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 5px; font-size: 14px;">
                                        <small id="newPasswordError" class="text-danger" style="font-size: 12px; margin-top: 5px;"></small>
                                    </div>
                                </div>

                                <div class="form-group row" style="margin-bottom: 15px;">
                                    <label for="confirmNewPassword" class="col-sm-4 col-form-label" 
                                           style="font-weight: 600; text-align: right; font-size: 14px;">Confirm Password</label>
                                    <div class="col-sm-8">
                                        <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required oninput="validatePassword()" 
                                               style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 5px; font-size: 14px;">
                                        <small id="confirmNewPasswordError" class="text-danger" style="font-size: 12px; margin-top: 5px;"></small>
                                    </div>
                                </div>

                                <div class="modal-footer" style="display: flex; justify-content: space-between; padding: 15px; border-top: 1px solid #dee2e6;">
                                    <button type="submit" class="btn btn-primary" 
                                            style="background-color: #ffc107; border-color: #ffc107; color: black; font-weight: bold; font-size: 14px;">
                                        Save changes
                                    </button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal" 
                                            style="background-color: #6c757d; border-color: #6c757d; font-weight: bold; font-size: 14px;">
                                        Close
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>                                
        </main>




        <script>
            function handleAvatarChange(event) {
                var file = event.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#avatarImage').attr('src', e.target.result); // Cập nhật ảnh đại diện ngay lập tức
                    };
                    reader.readAsDataURL(file); // Đọc ảnh dưới dạng URL và thay đổi ảnh
                }
            }

            // for image
            function resetChange() {
                var originalAvatar = $("#avatarImage").attr("src");

                $(".edit-profile").on("reset", function () {
                    setTimeout(function () {
                        $("#avatarImage").attr("src", originalAvatar);
                        $("#avatarInput").val("");
                    }, 10);
                });
            }

            function submitChange(event) {
                event.preventDefault();

                var formData = new FormData(event.target);

                $.ajax({
                    url: "ajax-profile",
                    type: "POST",
                    data: formData,
                    processData: false, // Don't process data
                    contentType: false, // Don't set content type (multipart)
                    success: function (response) {
                        var avatarFile = formData.get("avatar"); // Lấy file avatar

                        if (avatarFile && avatarFile.size > 0) { // Kiểm tra nếu có ảnh mới
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                $("#userAvatar").attr("src", e.target.result); // Cập nhật ảnh đại diện
                            };
                            reader.readAsDataURL(avatarFile); // Đọc ảnh dưới dạng Data URL
                        } else {
                            // Nếu không có ảnh mới, có thể giữ lại ảnh cũ hoặc làm gì đó khác
                            console.log("No new avatar image selected.");
                        }

                        $("#profileModal").modal("hide");

                        Swal.fire({
                            icon: "success",
                            title: "Profile updated successfully",
                            timer: 5000
                        });

                    },
                    error: function (xhr, status, error) {

                        Swal.fire({
                            icon: "error",
                            title: "Something went wrong!",
                            timer: 3000
                        });

                        alert("Update failed: " + xhr.responseText); // Error message
                    }
                });
            }

        </script>


        <script>
            $(document).ready(function () {
                $("#changePasswordForm").submit(function (event) {
                    event.preventDefault();

                    var oldPassword = $("#oldPassword").val();
                    var newPassword = $("#newPassword").val();
                    var confirmNewPassword = $("#confirmNewPassword").val();

                    if ($("#newPasswordError").text() !== "" || $("#confirmNewPasswordError").text() !== "") {
                        return; // Nếu có lỗi ở client thì không gửi request
                    }

                    var formData = $(this).serialize();

                    $.ajax({
                        url: "change",
                        type: "POST",
                        data: formData,
                        dataType: "json",
                        success: function (response) {
                            if (response.status === "success") {
                                $("#changePasswordMessage").html('<div class="alert alert-success">' + response.message + '</div>');
                                setTimeout(function () {
                                    $("#changePasswordModal").modal("hide");
                                }, 2000);

                            } else {
                                $("#changePasswordMessage").html('<div class="alert alert-danger">' + response.message + '</div>');
                            }
                        },
                        error: function () {
                            $("#changePasswordMessage").html('<div class="alert alert-danger">Error processing request.</div>');
                        }
                    });
                });
            });

        </script>
        <script>
            function validatePassword() {
                var oldPassword = document.getElementById("oldPassword").value;
                var newPassword = document.getElementById("newPassword").value;
                var confirmNewPassword = document.getElementById("confirmNewPassword").value;

                var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$/;

                // Kiểm tra mật khẩu cũ không được giống mật khẩu mới
                if (newPassword === oldPassword && newPassword.length > 0) {
                    document.getElementById("newPasswordError").innerText = "New password cannot be the same as the old password.";
                } else if (!passwordPattern.test(newPassword) && newPassword.length > 0) {
                    document.getElementById("newPasswordError").innerText = "Password must be 8-15 characters with at least one uppercase letter, one lowercase letter, and one number.";
                } else {
                    document.getElementById("newPasswordError").innerText = "";
                }

                // Kiểm tra xác nhận mật khẩu
                if (confirmNewPassword !== newPassword && confirmNewPassword.length > 0) {
                    document.getElementById("confirmNewPasswordError").innerText = "New passwords do not match.";
                } else {
                    document.getElementById("confirmNewPasswordError").innerText = "";
                }
            }

        </script>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>

