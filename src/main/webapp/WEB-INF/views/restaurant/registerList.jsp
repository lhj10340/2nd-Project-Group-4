<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    table {
        width: 70%;
        border-collapse: collapse;
        margin-right: 30%;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    .btn {
        padding: 5px 10px;
        color: white;
        background-color: #815854;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 5px;
    }
    .btn:hover {
        background-color: #6e4740;
    }
    .action-buttons {
        width: 30%;
        text-align: center;
    }
    .action-buttons form {
        display: inline;
    }
</style>
</head>
<body>

<div class="form-div">
    <h2>매장 리스트</h2>
    <table>
        <thead>
            <tr>
                <th>매장이름</th>
                <th>영업상태</th>
                <th>카테고리</th>
                <th class="action-buttons">작업</th>
            </tr>
        </thead><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    table {
        width: 70%;
        border-collapse: collapse;
        margin-right: 30%;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    .btn {
        padding: 5px 10px;
        color: white;
        background-color: #815854;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 5px;
    }
    .btn:hover {
        background-color: #6e4740;
    }
    .action-buttons {
        width: 30%;
        text-align: center;
    }
    .action-buttons form {
        display: inline;
    }
</style>
</head>
<body>

<div class="form-div">
    <h2>매장 리스트</h2>
    <table>
        <thead>
            <tr>
                <th>매장이름</th>
                <th>영업상태</th>
                <th>카테고리</th>
                <th class="action-buttons">작업</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="restaurant" items="${restaurantList}">
                <tr>
                    <td>${restaurant.re_name}</td>
                    <td>${restaurant.re_state}</td>
                    <td>${restaurant.re_category}</td>
                    <td class="action-buttons">
                        <form action="<c:url value='/restaurant/update'/>" method="GET" style="display:inline;">
                            <input type="hidden" name="re_id" value="${restaurant.re_id}">
                            <button type="submit" class="btn">수정</button>
                        </form>
                        <form action="<c:url value='/restaurant/delete'/>" method="POST" style="display:inline;">
                            <input type="hidden" name="re_id" value="${restaurant.re_id}">
                            <button type="submit" class="btn">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
        
        <tbody>
            <c:forEach var="restaurant" items="${restaurantList}">
                <tr>
                    <td>${restaurant.re_name}</td>
                    <td>${restaurant.re_state}</td>
                    <td>${restaurant.re_category}</td>
                    <td class="action-buttons">
                        <form action="<c:url value='/restaurant/update'/>" method="GET" style="display:inline;">
                            <input type="hidden" name="re_id" value="${restaurant.re_id}">
                            <button type="submit" class="btn">수정</button>
                        </form>
                        <form action="<c:url value='/restaurant/delete'/>" method="POST" style="display:inline;">
                            <input type="hidden" name="re_id" value="${restaurant.re_id}">
                            <button type="submit" class="btn">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
