<%-- 
    Document   : profile
    Created on : Jan 25, 2025, 10:43:09 PM
    Author     : Nvtai
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

                        <form class="edit-profile" action="profile" method="post" enctype="multipart/form-data">

                            <div class="modal-body">
                                <div class="row">
                                    <!-- Avatar -->
                                    <div class="col-md-4 text-center">
                                        <div class="user-profile-thumb" style="width: 150px; height: 150px;">
                                            <img src="${sessionScope.account.profile.avatar}" id="avatarImage" alt="User Avatar" class="rounded-circle" style="width: 150px; height: 150px; object-fit: cover;">
                                        </div>
                                        <!-- Chỉnh sửa nút Choose File -->
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="avatarInput" name="avatar" style="display: none;" onchange="updateFileName()">
                                            <button type="button" class="btn btn-light" onclick="document.getElementById('avatarInput').click()">Choose file</button>
                                        </div>
                                    </div>


                                    <!-- Profile Fields -->
                                    <div class="col-md-8">
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">First Name</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.firstName}" name="firstname">
                                                <small id="firstNameError" class="text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Last Name</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.lastName}" name="lastname">
                                                <small id="lastNameError" class="text-danger"></small>
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
                                                <small id="dobError" class="text-danger"></small>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Address</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.address}" name="address">
                                                <small id="addressError" class="text-danger"></small>
                                            </div>
                                        </div>
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-4 col-form-label">Phone Number</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.phone}" name="phone">
                                                <small id="phoneError" class="text-danger"></small>
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

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                // JavaScript để thay đổi ảnh đại diện ngay khi người dùng chọn ảnh mới
                                                const avatarInput = document.getElementById('avatarInput');
                                                const avatarImage = document.getElementById('avatarImage');

                                                avatarInput.addEventListener('change', function (event) {
                                                    const file = event.target.files[0];
                                                    if (file) {
                                                        const reader = new FileReader();
                                                        reader.onload = function (e) {
                                                            avatarImage.src = e.target.result; // Cập nhật ảnh đại diện ngay lập tức
                                                        };
                                                        reader.readAsDataURL(file); // Đọc ảnh dưới dạng URL và thay đổi ảnh
                                                    }
                                                });
        </script>

        <script>
            var originalAvatar = $("#avatarImage").attr("src");

            $(".edit-profile").on("reset", function () {
                setTimeout(function () {
                    $("#avatarImage").attr("src", originalAvatar);
                    $("#avatarInput").val("");
                }, 10);
            });
        </script>

        <script>
            $(document).ready(function () {
                $(".edit-profile").submit(function (event) {
                    event.preventDefault();
                    var formData = new FormData(this);
                    $.ajax({
                        url: "ajax-profile",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
//                            alert("Profile updated successfully!");

                            if (formData.get("avatar").name) {
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    $("#userAvatar").attr("src", e.target.result);
                                };
                                reader.readAsDataURL(formData.get("avatar"));
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("Update failed: " + xhr.responseText);
                        }
                    });
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                function validateForm() {
                    var isValid = true;
                    // Validate First Name
                    var firstName = $("input[name='firstname']").val().trim();
                    if (firstName === "") {
                        $("#firstNameError").text("First name cannot be empty.");
                        isValid = false;
                    } else {
                        $("#firstNameError").text("");
                    }

                    // Validate Last Name
                    var lastName = $("input[name='lastname']").val().trim();
                    if (lastName === "") {
                        $("#lastNameError").text("Last name cannot be empty.");
                        isValid = false;
                    } else {
                        $("#lastNameError").text("");
                    }

                    // Validate Date of Birth (must be before today)
                    var dob = $("input[name='dob']").val();
                    if (dob === "") {
                        $("#dobError").text("Date of birth cannot be empty.");
                        isValid = false;
                    } else {
                        $("#dobError").text("");
                    }

                    // Validate Address
                    var address = $("input[name='address']").val().trim();
                    if (address === "") {
                        $("#addressError").text("Address cannot be empty.");
                        isValid = false;
                    } else {
                        $("#addressError").text("");
                    }

                    // Validate Phone Number (7-15 digits, can include "-")
                    var phone = $("input[name='phone']").val().trim();
                    var phoneRegex = /^(?!-)(?!.*--)[0-9-]{7,15}(?<!-)$/;
                    if (!phoneRegex.test(phone)) {
                        $("#phoneError").text("Phone number must be 7-15 digits and can contain '-' (not consecutive).");
                        isValid = false;
                    } else {
                        $("#phoneError").text("");
                    }

                    return isValid;
                }

                // Validate on input change
                $("input[name='firstname'], input[name='lastname'], input[name='dob'], input[name='address'], input[name='phone']").on("input change", function () {
                    validateForm();
                });
                // Prevent form submission if validation fails
                $(".edit-profile").on("submit", function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        Swal.fire({
                            title: 'Oops...',
                            text: 'Please correct the errors before submitting!',
                            icon: 'error',
                            confirmButtonText: 'Try Again'
                        });
                    } else {
                        Swal.fire({
                            title: 'Success!',
                            text: 'Profile updated successfully.',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        });
                    }
                });
            });
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
    </body>
    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>

