<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색 결과</title>
    <style>
        /* 팝업 스타일 */
        #popup {
            display: block;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: white;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        #popup-close {
            display: block;
            text-align: right;
            margin-bottom: 10px;
        }

        #overlay {
            display: block;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
    </style>
    <script>
        // 팝업 닫기
        function closePopup() {
            document.getElementById('popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
    </script>
</head>
<body>
    <div id="popup">
        <div id="popup-close">
            <button onclick="closePopup()">닫기</button>
        </div>
        <h2>검색 결과</h2>
        <ul>
            <c:forEach var="user" items="${users}">
                <li><a href="${pageContext.request.contextPath}/admin/user/info?id=${user.us_id}">${user.us_name} - ${user.us_phone}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div id="overlay" onclick="closePopup()"></div>
</body>
</html>
