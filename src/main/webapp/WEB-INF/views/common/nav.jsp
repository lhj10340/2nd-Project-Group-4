<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
</head>
<body>

<!-- user 정보는 로그인 시 세션에서 뿌리게 되었음 user 사용 가능함 -->
	<nav class="navbar navbar-expand-sm" 
		style="font-size: 20px;  justify-content: space-between;">
	  
	  <ul class="navbar-nav">
	  	
	  	 <li class="nav-item">
	      <a class="navbar-brand" href="<c:url value="/"/>">
	      	<img width = 80px; height = 35px src="<c:url value="/resources/img/twitter_header_photo_1.png"/>">
	      </a>
	    </li>
	  	
	    <!-- <li class="nav-item active">
	      <a class="nav-link text-white" href="<c:url value="/"/>">Main</a>
	    </li> -->
	   
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/review/list"/>"> 전체리뷰 </a>

	    </li>
	  
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/"/>"> 고객문의 </a>
	    </li>
	  
	    </ul>
	    
	<ul class="navbar-nav">
	
	 <!-- Dropdown -->
	    <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle text-white" href="<c:url value="/"/>" id="navbardrop" data-toggle="dropdown">
	        ...
	      </a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item text-white" href="#"> ... </a>
	        <a class="dropdown-item text-white" href="#"> ... </a>
	        <a class="dropdown-item text-white" href="#"> ... </a>
	      </div>
	    </li>
	
	<c:choose>
	
	<c:when test="${user==null}">
	
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/signup"/>">회원가입</a>
	    </li>
	    
	    
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/login"/>">로그인</a>
	    </li>
			    
	</c:when>		    
		
	<c:otherwise>
	   		    
		<li class="nav-item">
			<a class="nav-link text-white" href="<c:url value="/logout"/>">로그아웃</a>
		</li>
			    
	</c:otherwise>
	
	</c:choose>
	
	<c:if test="${user.me_authority eq 'ADMIN'}">
		
		   		    <li class="nav-item">
				      <a class="nav-link text-white" href="<c:url value="/admin/tool"/>">관리자 페이지</a>
				    </li>
	
	</c:if>
	
		</ul>
	</nav>

</body>
</html>
	