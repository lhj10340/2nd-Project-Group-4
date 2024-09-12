<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/mypage.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/rest.css" />">
</head>
<body>
<div class="form-div">
	<p class="title-p">마이페이지</p>
	
	<form action="<c:url value="/user/mypage"/>" method="post" id="form">
		<div class="form-group">
			<p class="member-p">
				<c:choose>
				    <c:when test="${user.us_auth == 1}">
				        일반회원
				    </c:when>
				    <c:when test="${user.us_auth == 7}">
				       사업자
				    </c:when>
				    <c:when test="${user.us_auth == 8}">
				        사업자
				    </c:when>
				    <c:when test="${user.us_auth == 9}">
				        관리자
				    </c:when>
				    <c:otherwise>
				        비회원
				    </c:otherwise>
				</c:choose>
			</p>
		</div>
		<div class="form-group">
			<label for="id">아이디</label>
			<input type="text" class="form-control" id="id" name="us_id" value="${user.us_id }" readonly>
		</div>
		<div class="form-group">
			<label for="pw"> 비밀번호</label>
			<input type="password" class="form-control-rest" id="pw" name="us_pw">
		</div>
		<div class="form-group">
			<label for="pw2"> 비밀번호 확인</label>
			<input type="password" class="form-control-rest" id="pw2" name="us_pw2">
		</div>
		<div class="form-group mt-2 mb-2">
			<button type="submit" class="btn btn-search-color">비밀번호 변경</button>
		</div>
		<div class="form-group">
			<label for="gender"> 성별</label>
			<input type="text" class="form-control" id="gender" name="us_gender" value="${user.us_gender }" readonly>
		</div>
		
		<div class="form-group">
			<label for="hbd"> 생년월일</label>
			<input type="text" class="form-control" id="hbd" name="us_hbd" 
				value="<fmt:formatDate value="${user.us_hbd }" pattern="yyyy-MM-dd"/>" readonly>
		</div>
		<div class="form-group">
			<label for="phone"> 전화번호</label>
			<input type="text" class="form-control" id="phone" name="us_phone" value="${user.us_phone }" readonly>
		</div>
		<div class="form-group">
			<label for="email"> 이메일</label>
			<input type="text" class="form-control" id="email" name="us_email" value="${user.us_email }" readonly>
		</div>
		<div class="form-group">
			<label for="say"> 유저 한마디</label>
			<textarea class="form-control" id="say" name="us_say" readonly>${user.us_say }</textarea>
		</div>
		<br>
	</form>
</div>	
</body>
</html>