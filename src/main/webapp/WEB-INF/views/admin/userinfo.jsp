<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 800px;
            margin: auto;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input[disabled] {
            background-color: #f9f9f9;
        }

        .button-group {
            margin-top: 20px;
        }

        .button-group button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            background-color: #007bff;
            cursor: pointer;
            margin-right: 10px;
        }

        .button-group button:hover {
            background-color: #0056b3;
        }

        .button-group button.delete {
            background-color: #dc3545;
        }

        .button-group button.delete:hover {
            background-color: #c82333;
        }
    </style>
    <script>
        function toggleEdit() {
            var isEditing = document.getElementById('editButton').style.display === 'none';
            document.getElementById('editButton').style.display = isEditing ? 'block' : 'none';
            document.getElementById('saveButton').style.display = isEditing ? 'none' : 'block';
            var fields = document.getElementsByClassName('editable');
            for (var i = 0; i < fields.length; i++) {
                fields[i].disabled = isEditing;
            }
        }

        function confirmDelete() {
            if (confirm('회원정보를 삭제하시겠습니까?')) {
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>회원 정보</h2>
        <form action="${pageContext.request.contextPath}/admin/userinfo" method="post">
            <input type="hidden" name="us_id" value="${user.us_id}"/>

            <div class="form-group">
                <label for="us_id">회원 아이디:</label>
                <input type="text" id="us_id" name="us_id" value="${user.us_id}" disabled/>
            </div>
            <div class="form-group">
                <label for="us_pw">비밀번호:</label>
                <input type="password" id="us_pw" name="us_pw" value="${user.us_pw}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_auth">권한:</label>
                <input type="text" id="us_auth" name="us_auth" value="${user.us_auth}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_name">이름:</label>
                <input type="text" id="us_name" name="us_name" value="${user.us_name}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_gender">성별:</label>
                <input type="text" id="us_gender" name="us_gender" value="${user.us_gender}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_hbd">생일:</label>
                <input type="date" id="us_hbd" name="us_hbd" value="${user.us_hbd}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_phone">전화번호:</label>
                <input type="text" id="us_phone" name="us_phone" value="${user.us_phone}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_email">이메일:</label>
                <input type="email" id="us_email" name="us_email" value="${user.us_email}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_failed">실패 횟수:</label>
                <input type="text" id="us_failed" name="us_failed" value="${user.us_failed}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_cookie">쿠키:</label>
                <input type="text" id="us_cookie" name="us_cookie" value="${user.us_cookie}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_limit">제한 일자:</label>
                <input type="datetime-local" id="us_limit" name="us_limit" value="${user.us_limit}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_report">보고서:</label>
                <input type="text" id="us_report" name="us_report" value="${user.us_report}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_stop">중지 일자:</label>
                <input type="datetime-local" id="us_stop" name="us_stop" value="${user.us_stop}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_icon">아이콘:</label>
                <input type="text" id="us_icon" name="us_icon" value="${user.us_icon}" class="editable"/>
            </div>
            <div class="form-group">
                <label for="us_say">메모:</label>
                <input type="text" id="us_say" name="us_say" value="${user.us_say}" class="editable"/>
            </div>

            <div class="button-group">
                <button type="button" id="editButton" onclick="toggleEdit()">수정</button>
                <button type="submit" id="saveButton" style="display: none;">저장</button>
                <button type="button" class="delete" onclick="confirmDelete()">삭제</button>
            </div>
        </form>

        <form id="deleteForm" action="${pageContext.request.contextPath}/admin/deleteUser" method="post" style="display: none;">
            <input type="hidden" name="us_id" value="${user.us_id}"/>
        </form>
    </div>
</body>
</html>
