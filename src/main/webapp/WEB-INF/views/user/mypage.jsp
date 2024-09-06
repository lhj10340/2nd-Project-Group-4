<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage</title>
</head>
<body>
	<div class="col-12 col-lg-8">
		<div class="my-info-content">
		<h3>My information</h3>
		<!-- 폼그룹 해주고 나중에 복붙해서 update page에서 사용하자 -->
			<div class="container">
				<form action="">
					<div class="form-group">
						<label for="id"><strong>이름 :</strong></label>
						&nbsp;&nbsp;&nbsp; ${user.us_name }
					</div>
					
					<div class="form-group">
						<label for="id"><strong>아이디 :</strong></label>
						&nbsp;&nbsp;&nbsp;  ${user.us_id }
					</div>
					
					
					<div class="form-group">
						<label for="id"><strong>이메일 :</strong></label>
						&nbsp;&nbsp;&nbsp; ${user.us_email }
					</div>
					
					<div class="form-group">
						<label for="id"><strong>생일 :</strong></label>
						&nbsp;&nbsp;&nbsp; <fmt:formatDate value="${user.us_hbd }" pattern="yyyy-MM-dd"/>
					</div>
					
					<div class="form-group">
						<label for="id"><strong>전화번호 :</strong></label>
						&nbsp;&nbsp;&nbsp; ${user.us_phone }
					</div>
					
					<div class="form-group">
						<label for="id"><strong>한줄 소개 :</strong></label>
						&nbsp;&nbsp;&nbsp; ${user.us_say }
					</div>
					
					
				</form>
			</div>
		</div>
	</div>
</body>
</html>