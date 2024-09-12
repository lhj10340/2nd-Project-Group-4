<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
</head>

<style>
	.sticky {position: sticky;top: 0;}
	.star-rating {display: flex;}	
	.star {appearance: none;padding: 1px;}
	.star::after {content: '☆';color: #f2be11;font-size: 20px;}
	.star:hover::after,
	.star:has(~ .star:hover)::after,
	.star:checked::after,
	.star:has(~ .star:checked)::after {content: '★';}
	.star:hover ~ .star::after {content: '☆';}
</style>
<body>
 
<!-- user 정보는 로그인 시 세션에서 뿌리게 되었음 user 사용 가능함 -->
	<nav class="navbar navbar-expand-sm sticky"  
		style="font-size: 20px;  justify-content: space-between;">
	  <ul class="navbar-nav">
	  	 <li class="nav-item">
	      <a class="navbar-brand" href="<c:url value="/"/>">
	      	<img width = 80px; height = 35px src="<c:url value="/resources/img/twitter_header_photo_1.png"/>">
	      </a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link text-white" href="<c:url value="/"/>"> 전체리뷰 </a>
	    </li>
	    <li class="nav-item">
				<a class="nav-link text-white" href="<c:url value="/restaurant/register"/>"> 매장등록 </a>
	    </li>
	   </ul>
	    
		
<ul class="navbar-nav">

  <!-- us_auth == 8일 때 매장 관리 메뉴 -->
  <c:if test="${user.us_auth == 8}">
    <li class="nav-item">
      <a class="nav-link text-white" href="<c:url value='/admin/store'/>">매장 관리</a>
    </li>
  </c:if>

  <!-- us_auth == 1일 때 마이페이지 -->
  <c:if test="${user.us_auth == 1}">
    <li class="nav-item">
      <a class="nav-link text-white" href="<c:url value='/user/mypage'/>">마이 페이지</a>
    </li>
  </c:if>

  <!-- us_auth == 9일 때 관리자 페이지 -->
  <c:if test="${user.us_auth == 9}">
    <li class="nav-item">
      <a class="nav-link text-white" href="<c:url value='/admin/adminhome'/>">관리자 페이지</a>
    </li>
  </c:if>
	    
				
	<c:choose>
	
	<c:when test="${user==null}">
	
	    <li class="nav-item">
	    	<a type="button" class="nav-link" data-toggle="modal" data-target="#myModal-signup" style="color: white;">회원가입</a>
	    </li>
	    
	    
	    <li class="nav-item">
    		<a type="button" class="nav-link" data-toggle="modal" data-target="#myModal-login" style="color: white;">로그인</a>
	    </li>
			    
	</c:when>		    
		
	<c:otherwise>
	   		    
 		<li class="nav-item">
			<a class="nav-link text-white" href="<c:url value="/user/mypage"/>">마이 페이지</a>
		</li>
	   		    
		<li class="nav-item">
			<a class="nav-link text-white" href="<c:url value="/user/logout"/>">로그아웃</a>
		</li>
			    
	</c:otherwise>
	
	</c:choose>
	
	<c:if test="${user.us_auth == 9}">
		
		   		    <li class="nav-item">
				      <a class="nav-link text-white" href="<c:url value="/admin/tool"/>">관리자 페이지</a>
				    </li>
	
	</c:if>
	
		</ul>
	</nav>



<c:if test="${user == null }">

<!-- The Modal -->
  <div class="modal fade" id="myModal-login">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
       	  <h1 class="modal-title"> 로그인 </h1>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
		          <div class="container justify-content-center">
					  <form action='<c:url value="/user/login"/>' method="post" class="">
					    <div class="form-group">
					    	<input type=text class="form-control" id="id" placeholder="ID" name="us_id">
					    </div>
					    
					    <div class="form-group">
					      <input type="password" class="form-control" id="pw" placeholder="비밀번호" name="us_pw">
					    </div>
				
					    <div class="form-group form-check">
					      <label class="form-check-label">
					        <input class="form-check-input" type="checkbox" value="true" name="remember"> 자동 로그인
					      </label>
					    </div>
					    <div class="d-flex justify-content-end">
					    	<button type="submit" class="btn btn-primary">로그인</button>
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
  <div class="modal fade" id="myModal-signup">
    <div class="modal-dialog modal-dialog-scrollable">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h1 class="modal-title">회원가입</h1>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <form action='<c:url value="/user/signup"/>' method="post" class="">
        <!-- Modal body -->
        
        <div class="modal-body container">
        
   	 		<label for="id">ID & 비밀번호</label>
     	    <div class="form-group">
        		<input type="text" class="form-control" id="id" placeholder="ID" name="us_id" required>
        	</div>
        	<div class="form-group">
        		<input type="password" class="form-control" id="pw" placeholder="PASSWORD" name="us_pw" required>	
        	</div>
        	<div class="form-group">
        		<input type="password" class="form-control" id="pw2" placeholder="PASSWORD Check" required>
        	</div>
        	
        	<label for="demo">이메일 :</label>
			<div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="EMAIL" id="email" name="us_email" required>
			  <div class="input-group-append">
			  	<select class="input-group-text" name="us_email">
			  		<option>@naver.com</option>
			  		<option>@gmail.com</option>
			  		<option>@daum.net</option>
			  		<option>@kakao.com</option>
			  		<option>직접입력 - 미구현</option>
			  	</select>
			  </div>
			</div>
			
			<label for="id" style="margin-top: 10px;">이름</label>
   	 		
	     	    <div class="form-group">
	        		<input type="text" class="form-control" id="name" placeholder="name" name="us_name" required>
	        	</div>
			
			<div class="d-flex">
				
					<label class="form-check-label mr-auto mb-2" > 성별 : </label>
		
					     <div class="form-check-inline" >
							    <label class="form-check-label" for="radio1">
							      <input type="radio" class="form-check-input mb-2" id="radio1" name="us_gender" value="male" checked>남
							    </label>
						 </div>

						<div class="form-check-inline" >
							    <label class="form-check-label" for="radio2">
							      <input type="radio" class="form-check-input mb-2" id="radio2" name="us_gender" value="female">여
							    </label>
						 </div>
			
			 </div>
			 
			 			 
			 <div class="d-flex" style="margin-top: 6px;">
				<label class="form-check-label mr-auto mb-1" for="date">생일 :</label>
				<input type="date"
						class="form-control"
				        id="date"
				        max="2025-12-31"
				        min="1900-01-01"
				        name="us_hbd"
				        style="width: 300px;"	>
				</div>
				 
			 
			 <div class="d-flex">
				
					<label class="form-check-label mr-auto" > 사업자 여부 : </label>

					     <div class="form-check-inline" >
							    <label class="form-check-label" for="radio3">
							      <input type="radio" class="form-check-input" id="radio3" name="us_auth" value="7"> 예
							    </label>
						 </div>
		
						<div class="form-check-inline" >
							    <label class="form-check-label" for="radio4">
							      <input type="radio" class="form-check-input" id="radio4" name="us_auth" value="1" checked> 아니오
							    </label>
						 </div>
			
			 </div>
			 
   	 		<label for="id" style="margin-top: 10px;"> 전화번호 </label>
   	 		
     	    <div class="form-group">
        		<input type="text" class="form-control" id="phone" placeholder="PHONE NUMBER 010-1234-1234" name="us_phone" required>
        	</div>
        	
		  <label for="comment"> 회원 한마디 </label>
		  
        	<div class="form-group">
			  <textarea class="form-control" rows="2" id="us_say" name="us_say"></textarea>
			</div>
        	
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
          <button type="submit" class="btn btn-primary">회원가입</button>
        </div>
        </form>
      </div>
    </div>
  </div>
</c:if>
</body>
</html>