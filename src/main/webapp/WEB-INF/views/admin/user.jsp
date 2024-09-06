<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
</head>
<body>
    <h1>회원 관리</h1>
    <form action="${pageContext.request.contextPath}/admin/user/search" method="get">
        <input type="text" name="name" placeholder="회원 이름 검색">
        <button type="submit">검색</button>
    </form>

    <h2>검색 결과</h2>
    <c:if test="${not empty users}">
        <ul>
            <c:forEach var="user" items="${users}">
                <li>
                    <a href="${pageContext.request.contextPath}/admin/user/info?id=${user.us_id}">
                        ${user.us_name} - ${user.us_phone}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </c:if>
</body>
</html>
