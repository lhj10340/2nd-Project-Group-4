<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">

<style type="text/css">
  body, p, span {
    font-family: 'Gamja Flower';
  }
.navbar{
 background-color:#815854;
}
</style>

		    <li class="nav-item">
		      <a type="button" class="nav-link" data-toggle="modal" data-target="#myModal-signup">회원가입</a>
		    </li>
		    
		    
		    <li class="nav-item">
		      <a type="button" class="nav-link" data-toggle="modal" data-target="#myModal-login">로그인</a>
		    </li>
		    
		    
</c:when>		    

</head>
<body>

<!-- user 정보는 로그인 시 세션에서 뿌리게 되었음 user 사용 가능함 -->
	<nav class="navbar navbar-expand-sm" 
		style="font-size: 20px;  justify-content: space-between;">
	  
	  <ul class="navbar-nav">
	  	
	  	 <li class="nav-item">
	      <a class="navbar-brand" href="#">
	      	<img width = 80px; height = 35px src="resources/img/twitter_header_photo_1.png">
	      </a>
	    </li>
	  	
	    <li class="nav-item active">
	      <a class="nav-link text-white" href="<c:url value="/"/>">Main</a>
	    </li>
	   
	  	<!-- 실질적으로 커뮤니티(아카이브) 고르는 곳 comm으로 커뮤니티는 줄여 표현할 것 -->
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/comm"/>"> 커뮤니티 </a>
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





<!-- The Modal -->
  <div class="modal fade" id="myModal-login">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
       	  <h1 class="modal-title">Login</h1>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
		          <div class="container justify-content-center">
					  <form action='<c:url value="/login"/>' method="post" class="">
					    <div class="form-group">
					    	<input type=text class="form-control" id="id" placeholder="ID" name="us_id">
					    </div>
					    
					    <div class="form-group">
					      <input type="password" class="form-control" id="pw" placeholder="PASSWORD" name="us_pw">
					    </div>
				
					    <div class="form-group form-check">
					      <label class="form-check-label">
					        <input class="form-check-input" type="checkbox" name="remember"> Remember me
					      </label>
					    </div>
					    <div class="d-flex justify-content-end">
					    	<button type="submit" class="btn btn-primary">Login</button>
					    </div>
					  </form>
				</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer"></div>
        
      </div>
    </div>
  </div>




 <!-- The Modal -->
  <div class="modal" id="myModal-signup">
    <div class="modal-dialog modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h1 class="modal-title">Sign UP</h1>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <form action='<c:url value="/signup"/>' method="post" class="">
        <!-- Modal body -->
        
        <div class="modal-body">
   	 		<label for="id">ID & Password</label>
     	    <div class="form-group">
        		<input type="text" class="form-control" id="id" placeholder="ID" name="us_id" required>
        	</div>
        	<div class="form-group">
        		<input type="password" class="form-control" id="pw" placeholder="PASSWORD" name="us_pw" required>	
        	</div>
        	<div class="form-group">
        		<input type="password" class="form-control" id="pw2" placeholder="PASSWORD Check" required>
        	</div>
        	<label for="demo">email:</label>
			<div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="EMAIL" id="demo" name="us_email" required>
			  <div class="input-group-append">
			  	<select class="input-group-text">
			  		<option>@naver.com</option>
			  		<option>@gmail.com</option>
			  		<option>@daum.net</option>
			  		<option>@kakao.com</option>
			  		<option>직접입력</option>
			  	</select>
			  </div>
			</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Sign up</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  

</body>
</html>