<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>

	<h1>마이페이지 지만 곧 메뉴관리 페이지로 바뀔 예정</h1>
	<form action="<c:url value="/mypage"/>" method="post" id="form">
		<div class="form-group">
			<label for="id">아이디</label>
			<input type="text" class="form-control" id="id" name="me_id" value="${user.us_id }" readonly>
		</div>
		<div class="form-group">
			<label for="pw"> 비밀번호</label>
			<input type="password" class="form-control" id="pw" name="me_pw">
		</div>
		<div class="form-group">
			<label for="pw2"> 비밀번호 확인</label>
			<input type="password" class="form-control" id="pw2" name="me_pw2">
		</div>
		<div class="form-group">
			<label for="auth"> 권한(1: 회원 / 7: 사업자 등록 대기 / 8: 사업자 / 9: 관리자)</label>
			<input type="text" class="form-control" id="auth" name="us_auth" value="${user.us_auth }" readonly>
		</div>
		<div class="form-group">
			<label for="gender"> 성별</label>
			<input type="text" class="form-control" id="gender" name="us_gender" value="${user.us_gender }" readonly>
		</div>
		<div class="form-group">
			<label for="hbd"> 생년월일</label>
			<input type="text" class="form-control" id="hbd" name="us_hbd" value="${user.us_hbd }" readonly>
		</div>
		<div class="form-group">
			<label for="phone"> 전화번호</label>
			<input type="text" class="form-control" id="phone" name="us_phone" value="${user.us_phone }" >
		</div>
		<div class="form-group">
			<label for="email"> 이메일</label>
			<input type="text" class="form-control" id="email" name="me_email" value="${user.us_email }" >
		</div>
		<div class="form-group">
			<label for="say"> 유저 한마디</label>
			<textarea class="form-control" id="say" name="us_say">${user.us_say }</textarea>
		</div>
		<button type="submit" class="btn btn-outline-success col-12">회원정보 수정</button>
	</form>
	
</body>
</html>