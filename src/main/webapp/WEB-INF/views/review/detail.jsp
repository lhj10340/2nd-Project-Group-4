<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:if test="${review ne null }">
		<h1>리뷰 상세</h1>

		<div class="form-group" style="display: flex; align-items: center;">
			<label for="title" style="width: 50px; margin-right: 10px;">제목: </label>
			<div class="form-control" style="flex: 1;">${review.rv_title}</div>
		</div>
		<form action="">
			<div class="form-group" style="display: flex; align-items: center;">
				<label for="title" style="width: 50px; margin-right: 10px;">작성자: </label>
				<div class="form-control" style="flex: 1; margin-right: 100px;">${review.rv_us_id}</div>
				<label for="title" style="width: 50px; margin-right: 10px;">작성일: </label>
				<div class="form-control" style="flex: 1;">${review.rv_date }</div>
			</div>
			<div class="form-group" style="display: flex; align-items: center;">
			<label for="title" style="width: 50px; margin-right: 10px;">매장명: </label>
			<div class="form-control" style="flex: 1;">${review.rv_name}</div>
		</div>
		</form>
		<div class="form-group">
			<label for="content">내용: </label>
			<div class="form-control" style="min-height: 400px; height: auto">${review.rv_content }</div>
		</div>
		<c:if test="${list.size() != 0 }">
			<div class="form-group">
				<label>사진첨부:</label>
				<c:forEach items="${list }" var="image">
					<a href="<c:url value="/download${image.im_name }"/>"
						class="form-control" download="${image.im_ori_name }">${image.im_ori_name }</a>
				</c:forEach>
			</div>
		</c:if>
	</c:if>
	<c:if test="${review eq null }">
		<h3>삭제되거나 잘못된 게시글입니다.</h3>
	</c:if>
	<c:url var="url" value="/review/list">
		<c:param name="rv_tf" value="${cri.rv_tf }" />
		<c:param name="page" value="${cri.page }" />
		<c:param name="type" value="${cri.type }" />
		<c:param name="search" value="${cri.search }" />
	</c:url>
	<a href="${url }" class="btn btn-outline-info">목록</a>
</body>
</html>