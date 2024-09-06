<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Info</title>
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
    <h2>회원 정보</h2>
    <form action="${pageContext.request.contextPath}/admin/userinfo" method="post">
        <input type="hidden" name="us_id" value="${user.us_id}"/>

        <!-- Other fields -->
        <label for="us_pw">비밀번호:</label>
        <input type="password" id="us_pw" name="us_pw" value="${user.us_pw}" class="editable"/>
        <br/>
        <label for="us_auth">권한:</label>
        <input type="text" id="us_auth" name="us_auth" value="${user.us_auth}" class="editable"/>
        <br/>
        <label for="us_name">이름:</label>
        <input type="text" id="us_name" name="us_name" value="${user.us_name}" class="editable"/>
        <br/>
        <label for="us_gender">성별:</label>
        <input type="text" id="us_gender" name="us_gender" value="${user.us_gender}" class="editable"/>
        <br/>
        <label for="us_hbd">생일:</label>
        <input type="date" id="us_hbd" name="us_hbd" value="${user.us_hbd}" class="editable"/>
        <br/>
        <label for="us_phone">전화번호:</label>
        <input type="text" id="us_phone" name="us_phone" value="${user.us_phone}" class="editable"/>
        <br/>
        <label for="us_email">이메일:</label>
        <input type="email" id="us_email" name="us_email" value="${user.us_email}" class="editable"/>
        <br/>
        <label for="us_failed">실패 횟수:</label>
        <input type="text" id="us_failed" name="us_failed" value="${user.us_failed}" class="editable"/>
        <br/>
        <label for="us_cookie">쿠키:</label>
        <input type="text" id="us_cookie" name="us_cookie" value="${user.us_cookie}" class="editable"/>
        <br/>
        <label for="us_limit">제한 일자:</label>
        <input type="datetime-local" id="us_limit" name="us_limit" value="${user.us_limit}" class="editable"/>
        <br/>
        <label for="us_report">보고서:</label>
        <input type="text" id="us_report" name="us_report" value="${user.us_report}" class="editable"/>
        <br/>
        <label for="us_stop">중지 일자:</label>
        <input type="datetime-local" id="us_stop" name="us_stop" value="${user.us_stop}" class="editable"/>
        <br/>
        <label for="us_icon">아이콘:</label>
        <input type="text" id="us_icon" name="us_icon" value="${user.us_icon}" class="editable"/>
        <br/>
        <label for="us_say">메모:</label>
        <input type="text" id="us_say" name="us_say" value="${user.us_say}" class="editable"/>
        <br/>

        <!-- Buttons -->
        <button type="button" id="editButton" onclick="toggleEdit()">수정</button>
        <button type="submit" id="saveButton" style="display: none;">저장</button>
        <button type="button" onclick="confirmDelete()">삭제</button>
    </form>

    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/user/delete" method="post" style="display: none;">
        <input type="hidden" name="us_id" value="${user.us_id}"/>
    </form>
</body>
</html>
