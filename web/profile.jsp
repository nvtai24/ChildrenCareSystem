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

                        <form class="edit-profile" action="profile" method="post" enctype="multipart/form-data">

                            <div class="modal-body">
                                <div class="row">
                                    <!-- Avatar -->
                                    <div class="col-md-4 text-center">
                                        <div class="user-profile-thumb" style="width: 150px; height: 150px;">
                                            <img id="avatarImage" src="${sessionScope.account.profile.avatar}" alt="Avatar" style="max-width: 150px;"/>
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
                                            <label class="col-sm-4 col-form-label">Full Name</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${sessionScope.account.profile.fullName}" name="fullname">
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
                                <button type="submit" class="btn green">Save changes</button>
                                <button type="reset" class="btn red">Reset</button>
                                <button type="button" class="btn gray" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </main>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


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
            var originalAvatar = $("#avatarImage").attr("src"); // Lưu ảnh gốc ban đầu

            // Bắt sự kiện khi nhấn Reset
            $(".edit-profile").on("reset", function () {
                setTimeout(function () {
                    $("#avatarImage").attr("src", originalAvatar); // Gán lại ảnh gốc
                    $("#avatarInput").val(""); // Xóa giá trị của input file
                }, 10); // Đợi một chút để form reset hoàn tất
            });
        </script>

        <script>
            $(document).ready(function () {
                // Bắt sự kiện khi submit form
                $(".edit-profile").submit(function (event) {
                    event.preventDefault(); // Ngăn chặn hành động submit mặc định

                    var formData = new FormData(this); // Lấy dữ liệu form

                    $.ajax({
                        url: "profile", // URL của Servlet xử lý
                        type: "POST",
                        data: formData,
                        processData: false, // Không xử lý dữ liệu thành chuỗi query string
                        contentType: false, // Không thiết lập header content-type
                        success: function (response) {
                            // Hiển thị thông báo thành công
                            alert("Profile updated successfully!");

                            // Cập nhật lại ảnh đại diện nếu có thay đổi
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


    </body>
    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>

