<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<h1>게시글 수정</h1>
	<form action="<c:url value="/review/update"/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label for="title">제목:</label>
			<input type="text" class="form-control" id="title" name="rv_title" value="${review.rv_title }">
		</div>
		<div class="form-group">
			<label for="content">내용:</label>
			<textarea class="form-control" id="content" name="rv_content">${review.rv_content }</textarea>
		</div>
		<div class="form-group file-container">
			<label>첨부파일:</label>
			<c:forEach items="${list }" var="image">
				<div class="form-control" style="position: relative;">
					<span>${image.im_ori_name }</span>
					<a 	class="btn-del" 
						style="position: absolute; right:10px;"
						href="javascript:void(0);"
						data-num="${image.im_num}"
					>X</a>
				</div>
			</c:forEach>
			<c:forEach begin="1" end="${3 - list.size() }">
				<input type="image" class="form-control" name="imageList">
			</c:forEach>
		</div>
		<button class="btn btn-outline-info col-12 mb-3">게시글 수정</button>
		<input type="hidden" name="rv_tf" value="${cri.rv_tf }">
		<input type="hidden" name="rv_id" value="${review.rv_id }">
		<input type="hidden" name="page" value="${cri.page }">
		<input type="hidden" name="search" value="${cri.search }">
		<input type="hidden" name="type" value="${cri.type }">
	</form>
	<script>
	$('#content').summernote({
		placeholder: '내용을 작성하세요.',
		tabsize: 2,
		height: 400
	});
	$('.btn-del').click(function(){
		var im_num = $(this).data('num');
		$(this).parent().remove();
		var input = `<input type="hidden" name="im_nums" value="\${im_num}">`
		var file = `<input type="image" class="form-control" name="imageList">`;
		$('.file-container').append(input);
		$('.file-container').append(image);
	})
    </script>
</body>
</html>
