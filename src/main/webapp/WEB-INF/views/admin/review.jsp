<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #F9EBDE;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #815854;
            text-align: center;
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            font-size: 16px;
            width: 300px;
            margin-right: 10px;
        }

        .search-form button {
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            background-color: #815854;
            color: #F9EBDE;
            font-size: 16px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: #6a4f46;
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
            background-color: #F2F2F2;
            font-weight: bold;
        }

        tbody tr:hover {
            background-color: #F1F1F1;
        }

        .no-records {
            text-align: center;
            color: #815854;
            font-size: 16px;
            padding: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .pagination .page-item a {
            color: #815854;
            text-decoration: none;
            padding: 10px;
        }

        .pagination .page-item.active a {
            background-color: #815854;
            color: #F9EBDE;
            border-radius: 20px;
        }

        .btn-delete {
            background-color: #D9534F;
            color: #FFF;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-delete:hover {
            background-color: #C9302C;
        }
    </style>
</head>
<body>
    <h1>리뷰 게시판</h1>

    <!-- 검색창 -->
    <div class="search-form">
        <form action="<c:url value='/admin/review' />" method="get">
            <input type="text" name="search" placeholder="검색어" value="${pm.cri.search}">
            <button type="submit">검색</button>
        </form>
    </div>

    <!-- 리뷰 목록 -->
    <table class="table table-hover">
        <thead>
            <tr>
                <th>번호</th>
                <th>매장명</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>별점</th>
                <th>삭제</th> <!-- 삭제 버튼 열 추가 -->
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${reviewList }" var="review">
                <tr>
                    <td>${review.rv_id }</td>
                    <td><a href="#">${review.rv_re_id }</a></td>
                    <td><c:url var="url" value="/admin/review/detail">
                        <c:param name="rv_tf" value="${pm.cri.rv_tf }" />
                        <c:param name="page" value="${pm.cri.page }" />
                        <c:param name="type" value="${pm.cri.type }" />
                        <c:param name="search" value="${pm.cri.search }" />
                        <c:param name="rv_id" value="${review.rv_id }" />
                    </c:url> <a href="${url }">${review.rv_title }</a></td>
                    <td><c:url var="url" value="/admin/review">
                        <c:param name="rv_tf" value="${pm.cri.rv_tf }" />
                        <c:param name="type" value="id" />
                        <c:param name="search" value="${review.rv_us_id }" />
                    </c:url> <a href="${url }">${review.rv_us_id }</a></td>
                    <td><fmt:formatDate value="${review.rv_date }" pattern="yy.MM.dd" /></td>
                    <td>${review.rv_score }</td>
                    <td>
                        <form action="<c:url value='/admin/review/delete' />" method="post" onsubmit="return confirmDelete()">
                            <input type="hidden" name="rv_id" value="${review.rv_id}" />
                            <button type="submit" class="btn-delete">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${reviewList.size() eq 0 }">
                <tr>
                    <td colspan="7" class="no-records">등록된 게시글이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <!-- 페이지 네비게이션 -->
    <c:if test="${pm.totalCount ne 0 }">
        <ul class="pagination">
            <c:if test="${pm.prev }">
                <c:url var="url" value="/admin/review">
                    <c:param name="rv_tf" value="${pm.cri.rv_tf }" />
                    <c:param name="page" value="${pm.startPage - 1 }" />
                    <c:param name="type" value="${pm.cri.type }"/>
                    <c:param name="search" value="${pm.cri.search}"/>
                </c:url>
                <li class="page-item">
                    <a class="page-link" href="${url }">이전</a>
                </li>
            </c:if>
            <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="i">
                <c:url var="url" value="/admin/review">
                    <c:param name="rv_tf" value="${pm.cri.rv_tf }" />
                    <c:param name="page" value="${i}" />
                    <c:param name="type" value="${pm.cri.type }" />
                    <c:param name="search" value="${pm.cri.search }" />
                </c:url>
                <c:choose>
                    <c:when test="${pm.cri.page eq i }">
                        <c:set var="active" value="active" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="active" value="" />
                    </c:otherwise>
                </c:choose>
                <li class="page-item ${active}"><a class="page-link" href="${url }">${i}</a></li>
            </c:forEach>
            <c:if test="${pm.next }">
                <c:url var="url" value="/admin/review">
                    <c:param name="rv_tf" value="${pm.cri.rv_tf }" />
                    <c:param name="page" value="${pm.startPage + 1 }" />
                    <c:param name="type" value="${pm.cri.type }" />
                    <c:param name="search" value="${pm.cri.search }" />
                </c:url>
                <li class="page-item"><a class="page-link" href="${url }">다음</a></li>
            </c:if>
        </ul>
    </c:if>

    <script>
        function confirmDelete() {
            return confirm("삭제하시겠습니까?");
        }
    </script>
</body>
</html>
