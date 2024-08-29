<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<title> 회원가입 페이지 </title>
</head>

<body>

	<form>
			<fieldset>
				<legend> 회원가입 </legend>
				<div class="form-group">
					<label for="id">아이디</label>
					<input type="text" name="id" id="id" class="form-control">
				</div>
				<div class="form-group">
					<label for="pw">비밀번호</label>
					<input type="password" name="pw" id="pw" class="form-control">
				</div>
				<div class="form-group">
					<label for="pw2">비밀번호 확인</label>
					<input type="password" name="pw2" id="pw2" class="form-control">
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-outline-info"> 회원가입 </button>
				</div>
			</fieldset>
	</form>

</body>
</html>
