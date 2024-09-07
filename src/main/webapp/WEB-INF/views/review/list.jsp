<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">

</head>
<body>
	<h1>리뷰 게시판</h1>
	<div class="container mt-4">

		<!-- Review Type Buttons -->
		<div class="d-flex justify-content-center mb-4">
			<a href="<c:url value='/review/general'/>" class="btn btn-info mr-2">일반
				리뷰</a> <a href="<c:url value='/review/receipt'/>"
				class="btn btn-outline-info">영수증 리뷰</a>
		</div>

		<!-- Review Table -->
		<table class="table table-bordered">
			<thead class="thead-light">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>평점</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${reviews}" var="review">
					<tr>
						<td>${review.id}</td>
						<td><a href="<c:url value='/review/detail/${review.id}'/>">${review.title}</a></td>
						<td>${review.author}</td>
						<td>${review.date}</td>
						<td>${review.rating}</td>
						<td>${review.views}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- Pagination -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:forEach var="i" begin="1" end="${pageMaker.totalPages}">
					<li class="page-item ${pageMaker.currentPage == i ? 'active' : ''}">
						<a class="page-link"
						href="<c:url value='/review/${reviewType}?page=${i}'/>">${i}</a>
					</li>
				</c:forEach>
			</ul>
		</nav>

		<!-- Search and Write Buttons -->
		<div class="d-flex justify-content-between mt-4">
			<form action="<c:url value='/review/search'/>" method="get"
				class="form-inline">
				<input type="text" name="query" class="form-control mr-2"
					placeholder="검색어를 입력하세요">
				<button type="submit" class="btn btn-primary">검색</button>
			</form>
			<a href="<c:url value='/review/write'/>" class="btn btn-success">글쓰기</a>
		</div>
	</div>
</body>
</html>