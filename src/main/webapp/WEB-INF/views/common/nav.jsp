<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- user 정보는 로그인 시 세션에서 뿌리게 되었음 user 사용 가능함 -->
<nav class="navbar navbar-expand-sm bg-primary navbar-dark d-flex justify-content-center" style="font-size: 20px;">
  <ul class="navbar-nav">
  
    <li class="nav-item active">
      <a class="nav-link" href="<c:url value="/"/>">Main</a>
    </li>
   
  	<!-- 실질적으로 커뮤니티(아카이브) 고르는 곳 comm으로 커뮤니티는 줄여 표현할 것 -->
    <li class="nav-item">
      <a class="nav-link" href="<c:url value="/comm"/>">아카이브</a>
    </li>
    

    

  
  
  
    <li class="nav-item">
      <a class="nav-link" href="<c:url value="/"/>">Q&A문의소</a>
    </li>
    
  
           <!-- Dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="<c:url value="/"/>" id="navbardrop" data-toggle="dropdown">
        파일 다운로드
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Link 1</a>
        <a class="dropdown-item" href="#">Link 2</a>
        <a class="dropdown-item" href="#">Link 3</a>
      </div>
    </li>
    
    
<c:choose>
<c:when test="${user==null}">


		    <li class="nav-item">
		      <a class="nav-link" href="<c:url value="/signup"/>">회원가입</a>
		      
		    </li>
		    
		    
		    <li class="nav-item">
		      <a type="button" class="nav-link" data-toggle="modal" data-target="#myModal">로그인</a>
		    </li>
		    
		    
</c:when>		    


	
<c:otherwise>
   		    
   		    <li class="nav-item">
		      <a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
		    </li>
		    
</c:otherwise>
</c:choose>

<c:if test="${user.me_authority eq 'ADMIN'}">
	
	   		    <li class="nav-item">
			      <a class="nav-link" href="<c:url value="/admin/tool"/>">어드민 관리 도구</a>
			    </li>

</c:if>





    <li class="nav-item">
      <a class="nav-link disabled" href="#">LogoH</a>
    </li>
    
    
    
    
    
  </ul>
</nav>



<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
		          <div class="container p-2 row justify-content-center">
					  <form action='<c:url value="/login"/>' method="post" class="">
					    <h2>Login</h2>
					    <div class="form-group id-form">
					    	<input type=text class="form-control" id="id" placeholder="ID" name="us_id">
					    </div>
					    
					    <div class="form-group pw-form">
					      <input type="password" class="form-control" id="pw" placeholder="PassWord" name="us_pw">
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
        <div class="modal-footer">
        </div>
        
      </div>
    </div>
  </div>

