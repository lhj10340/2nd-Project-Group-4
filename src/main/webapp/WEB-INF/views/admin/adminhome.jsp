<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F9EBDE; /* 살구 색상 */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background: #815854; /* 갈색 색상 */
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #fff; /* 제목 색상 */
        }
        .btn-group {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            font-weight: bold;
            color: ##F9EBDE ; /* 버튼 텍스트 색상 */
            background-color: #F9EBDE ; /* 버튼 배경 색상 */
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3; /* 버튼 호버 색상 */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <div class="btn-group">
            <a href="<c:url value='/admin/review' />" class="btn">리뷰 관리</a>
            <a href="<c:url value='/admin/user' />" class="btn">회원 관리</a>
        </div>
    </div>
</body>
</html>
