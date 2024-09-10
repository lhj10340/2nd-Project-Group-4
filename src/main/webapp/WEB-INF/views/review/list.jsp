<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록</title>
<style>
    body {
        margin: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    table, th, td {
        border: 1px solid #ccc;
    }
    th, td {
        padding: 12px;
        text-align: left;
    }
    th {
        background-color: #815854;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #ddd;
    }
</style>
</head>
<body>
<table>
	<thead>
	    <tr>
	        <th>제목</th>
	        <th>별점</th>
	        <th>내용</th>
	        <th>작성자</th>
	    </tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${lists}">
			<tr>
		        <td>${list.rv_title}</td>
		        <td>
		        	<span class="rating">
		        		<c:forEach var="a" begin="1" end="${list.rv_score}">
						    ★
						</c:forEach>
						<c:forEach var="b" begin="1" end="${5 - list.rv_score}">
						    ☆
						</c:forEach>
		        	</span>
		        </td>
		        <td>${list.rv_content}</td>
		        <td>${list.rv_us_id}</td>
		    </tr>
		 </c:forEach>
	</tbody>
</table>
</body>
</html>