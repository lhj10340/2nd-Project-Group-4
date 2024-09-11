<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">
		
</head>
<body>
	<h1>리뷰 등록</h1>
	<form action="<c:url value="/review/insert"/>" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label for="title">제목: </label>
			<input type="text" class="form-control" id="title" name="rv_title">
		</div>
	    <div class="form-group mt-3">
    	    <label for="score">별점:</label>
	        <select class="form-control" id="score" name="rv_score">
        	    <option value="0">별점을 선택해주세요.</option>
        	    <option value="1">1점</option>
        	    <option value="1.5">1.5점</option>
    	        <option value="2">2점</option>
    	        <option value="2.5">2.5점</option>
	            <option value="3">3점</option>
	            <option value="3.5">3.5점</option>
            	<option value="4">4점</option>
            	<option value="4.5">4.5점</option>
        	    <option value="5">5점</option>
    	    </select>
 	   </div>
 	   <div class="form-group mt-3">
			<label for="receipt">영수증 번호: </label>
			<textarea type="text" class="form-control" id="receipt" name="rv_content"></textarea>
		</div>
		<div class="form-group mt-3">
			<label for="content">내용: </label>
			<textarea type="text" class="form-control" id="content" name="rv_content"></textarea>
		</div>
		<div class="form-group">
			<label>사진첨부:</label>
			<input type="file" class="form-control" name="fileList" accept=".jpg, .jpeg, .png">
			<input type="file" class="form-control" name="fileList" accept=".jpg, .jpeg, .png">
			<input type="file" class="form-control" name="fileList" accept=".jpg, .jpeg, .png">
		</div>
		<button class="btn btn-outline-info col-12 mb-3">리뷰 등록</button>
		<input type="hidden" name="rv_tf" value="${rv_tf }">
	</form>
	<script>
      $('#content').summernote({
        placeholder: '내용을 작성하세요.',
        tabsize: 2,
        height: 400
      });
    </script>
</body>
</html>