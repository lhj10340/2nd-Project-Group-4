<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .search-form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            width: 300px;
            margin-right: 10px;
        }

        .search-form button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: #0056b3;
        }

        .user-table-container {
            max-height: 500px; /* 테이블의 최대 높이 */
            overflow-y: auto;  /* 세로 스크롤 추가 */
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원 관리</h1>
        
        <!-- 회원 검색 -->
        <form class="search-form" action="${pageContext.request.contextPath}/admin/user" method="get">
            <input type="text" id="searchName" name="name" placeholder="회원 이름 검색" value="${param.name}">
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
                                <a href="${pageContext.request.contextPath}/admin/user/info?id=${user.us_id}" style="color: #007bff; text-decoration: none;">상세 정보</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
