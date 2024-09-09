<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <style>
        /* 테이블 스크롤 설정 */
        .user-table-container {
            max-height: 400px; /* 테이블의 최대 높이 */
            overflow-y: auto;  /* 세로 스크롤 추가 */
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        /* 팝업 스타일 */
        #popup {
            display: none;
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
            display: none;
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
        // 팝업 열기
        function openPopup(users) {
            const popup = document.getElementById('popup');
            const overlay = document.getElementById('overlay');
            const resultList = document.getElementById('search-results');
            resultList.innerHTML = ''; // 기존 검색 결과 초기화

            users.forEach(user => {
                const li = document.createElement('li');
                li.innerHTML = `<a href="${user.link}">${user.name} - ${user.phone}</a>`;
                resultList.appendChild(li);
            });

            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        // 팝업 닫기
        function closePopup() {
            document.getElementById('popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
    </script>
</head>
<body>
    <h1>회원 관리</h1>
    
    <!-- 회원 검색 -->
    <form action="${pageContext.request.contextPath}/admin/user/search" method="get" onsubmit="event.preventDefault(); searchUsers();">
        <input type="text" id="searchName" name="name" placeholder="회원 이름 검색">
        <button type="submit">검색</button>
    </form>

    <!-- 회원 목록 (스크롤 가능 테이블) -->
    <div class="user-table-container">
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>성별</th>
                    <th>이메일</th>
                    <th>생일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.us_name}</td>
                        <td>${user.us_phone}</td>
                        <td>${user.us_gender}</td>
                        <td>${user.us_email}</td>
                        <td>${user.us_hbd}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/user/info?id=${user.us_id}">상세 정보</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 팝업 창 -->
    <div id="popup">
        <div id="popup-close">
            <button onclick="closePopup()">닫기</button>
        </div>
        <h2>검색 결과</h2>
        <ul id="search-results"></ul>
    </div>
    <div id="overlay" onclick="closePopup()"></div>

    <script>
        function searchUsers() {
            const name = document.getElementById('searchName').value;

            // AJAX 요청을 통해 검색 결과 가져오기
            fetch(`${pageContext.request.contextPath}/admin/user/search?name=${name}`)
                .then(response => response.json())
                .then(data => {
                    if (data.length > 0) {
                        const users = data.map(user => ({
                            name: user.us_name,
                            phone: user.us_phone,
                            link: `${pageContext.request.contextPath}/admin/user/info?id=${user.us_id}`
                        }));
                        openPopup(users);  // 팝업에 결과 표시
                    } else {
                        alert('검색 결과가 없습니다.');
                    }
                })
                .catch(error => {
                    console.error('검색 오류:', error);
                });
        }
    </script>
</body>
</html>
