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
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="profileModalLabel">User Profile</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form class="edit-profile" action="profile" method="post" enctype="multipart/form-data">
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
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-8 text-right">
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                        <button type="reset" class="btn btn-secondary">Cancel</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
</html>

