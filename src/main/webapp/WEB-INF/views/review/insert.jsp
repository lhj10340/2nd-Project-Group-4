<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
	rel="stylesheet">

<style>
.fixed-size {
	resize: none; /* 사용자가 크기를 조정하지 못하도록 설정 */
}
</style>
</head>
<body>
	<h1>리뷰 등록</h1>
	<form action="<c:url value="/review/insert"/>" method="post"
		enctype="multipart/form-data">
		<div class="form-group">
			<label for="title">제목: </label> <input type="text"
				class="form-control" id="title" name="rv_title">
		</div>
		<div class="form-group">
			<label for="receiptNumber">리뷰를 작성할 매장을 선택해주세요:)</label>
			<br>
			<select name="rv_re_id" id="rv_re_id" required="required">
				<option value="">매장선택</option>
				<c:forEach items="${rest }" var="list">
					<option value="${list.re_id}">${list.re_name}</option>
				</c:forEach>
			</select>
		</div>

		<div class="form-group mt-3">
			<label for="score">별점:</label> <select class="form-control"
				id="score" name="rv_score">
				<option value="">별점을 선택해주세요.</option>
				<option value="1">1점</option>
				<option value="2">2점</option>
				<option value="3">3점</option>
				<option value="4">4점</option>
				<option value="5">5점</option>
			</select>
		</div>
		<div class="form-check">
			<input class="form-check-input" type="checkbox" id="receiptCheck"
				name="receiptCheck"> <label class="form-check-label"
				for="receiptCheck"> 영수증 리뷰 작성하기 </label>
		</div>

		<!-- 영수증 번호 입력 필드 -->
		<div class="form-group">
			<label for="receiptNumber">영수증 번호</label>
			<textarea class="form-control fixed-size" id="rv_receipt"
				name="rv_receipt" rows="1" disabled></textarea>
		</div>

		<div class="form-group mt-3">
			<label for="content">내용: </label>
			<!-- <textarea type="text" class="form-control" id="content" name="rv_content"></textarea> -->
			<textarea class="content" id="content" name="rv_content" maxlength="200" onkeyup="countText(this.value);"></textarea>
		</div>
		
		<div class="form-group">
			<label>사진첨부:</label> <input type="file" class="form-control"
				name="fileList" accept=".jpg, .jpeg, .png"> <input
				type="file" class="form-control" name="fileList"
				accept=".jpg, .jpeg, .png"> <input type="file"
				class="form-control" name="fileList" accept=".jpg, .jpeg, .png">
		</div>
		<button class="btn btn-search-color col-12 mb-3">리뷰 등록</button>
		<input type="hidden" name="rv_tf" value="${rv_tf }">
	</form>
	<script>
		$('#content').summernote({
			placeholder : '내용을 작성하세요.',
			tabsize : 2,
			height : 400
		});
		
		document.getElementById('receiptCheck').addEventListener(
				'change',
				function() {
					const receiptTextarea = document
							.getElementById('rv_receipt');
					if (this.checked) {
						// 체크박스가 체크되면 영수증 번호 입력 필드 활성화
						receiptTextarea.disabled = false;
					} else {
						// 체크박스가 체크 해제되면 영수증 번호 입력 필드 비활성화
						receiptTextarea.disabled = true;
						// 영수증 번호가 비활성화되면 텍스트도 비우기
				        receiptTextarea.value = '';
					}
				});

		document.getElementById('reviewForm').addEventListener('submit', function(event) {
		    var receipt = document.getElementById('rv_receipt').value.trim();
		    
		    // 영수증 번호가 입력되어 있으면 rv_tf 값을 1로 설정
		    if (receipt !== '') {
		        document.getElementById('rv_tf').value = '1';
		    } else {
		        document.getElementById('rv_tf').value = '0';
		    }
		});
        
		/* function countText(val){
			val = val.replace(/\s+/g, '');
			var count = val.length; //문자수
			var maxLength = 200;
			$("#count").text(count);
			if(count > maxLength){
				$("#content").val(val.slice(0, maxLength));  
			}
		} */
	</script>
</body>
</html>