<%-- 
    Document   : dropDownStaff.jsp
    Created on : Mar 15, 2025, 6:28:33 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Staff Dropdown</title>


        <!-- Select2 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" rel="stylesheet" />

        <!-- Select2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>

        <!-- Custom CSS for Avatar -->
        <style>
            .select2-container--default .select2-results__option img {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                margin-right: 10px;
            }
        </style>
    </head>
    <body>

        <!-- Dropdown list with select2 -->
        <select class="form-control" id="staff-select">
            <option value="1" data-avatar="assets/images/avatar1.jpg">John Doe</option>
            <option value="2" data-avatar="assets/images/avatar2.jpg">Jane Smith</option>
            <option value="3" data-avatar="assets/images/avatar3.jpg">Michael Johnson</option>
        </select>

        <!-- Initialize Select2 -->
        <script>
            $(document).ready(function () {
                $('#staff-select').select2({
                    templateResult: function (data) {
                        var $result = $('<span><img src="' + $(data.element).data('avatar') + '" class="img-circle" /> ' + data.text + '</span>');
                        return $result;
                    }
                });
            });
        </script>

    </body>
</html>

