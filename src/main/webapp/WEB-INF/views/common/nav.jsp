<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
</head>

<style>
	.sticky{
		position: sticky;
	}
	.star-rating {
      display: flex;
    }

    .star {
      appearance: none;
      padding: 1px;
    }

    .star::after {
      content: '☆';
      color: hsl(60, 80%, 45%);
      font-size: 20px;
    }

    .star:hover::after,
    .star:has(~ .star:hover)::after,
    .star:checked::after,
    .star:has(~ .star:checked)::after {
      content: '★';
    }

    .star:hover ~ .star::after {
      content: '☆';
    }
    
    
    /* 기존 토글 네비게이션 바 크기와 버튼 위치를 유지하기 위한 스타일 */
        .navbar {
            font-size: 20px;
            justify-content: space-between;
        }
        .nav-item {
            margin: 0 10px; /* 버튼 사이의 간격 유지 */
        }
        .navbar-brand img {
            width: 80px;
            height: 35px;
        }
        /* 사이드바 토글 버튼의 위치와 크기 */
        .w3-sidebar {
            display: none;
            z-index: 999;
            left: 0;
            width: 25%;
            position: fixed;
            top: 0;
            bottom: 0;
            background-color: #fff;
            overflow: auto;
        }
        .w3-button.w3-display-topright {
            position: absolute;
            right: 10px;
            top: 10px;
        }
    
    
    
    
    
    
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

<div class="w3-sidebar w3-bar-block w3-card w3-animate-left sticky" style="display:none; z-index: 999; left: 0;" id="mySidebar">
  <button class="w3-button w3-display-topright" onclick="w3_close()">&times;</button>

	<div class="container">
	  <div class="w3-bar-item" >
	  		<h1 id="mj-title"></h1>
	  		  	  <div class="star-rating">
				    <input type="radio" class="star star1" value="1" disabled>
				    <input type="radio" class="star star2" value="2" disabled>
				    <input type="radio" class="star star3" value="3" disabled>
				    <input type="radio" class="star star4" value="4" disabled>
				    <input type="radio" class="star star5" value="5" disabled>
					<label id="re-score" style="margin-left: 4px;font-size: 20px;"></label>
				  </div>
	  </div>
	  <hr>

	  
	  <!-- re_content 자리 -->
	  <div class="w3-bar-item" id="mj-body" style="border-radius: 5px; background-color: rgba(255, 99, 71, 0.4);"></div>
	  <div class="w3-bar-item" id="mj-footer re_comment">
	
	  </div>
	  

	  
	  
	  
	  	  
	  <a href="#" class="w3-bar-item w3-button">■리뷰 포인트 가져와서 몇점인지 별점 세기기</a>
	  <a href="#" class="w3-bar-item w3-button">■상세 홈페이지로 이동</a>
	  <div class="container">값 가져와서 몇몇 테그 걸어주기</div>
	  
	  
  	  <hr>
	  <form class="w3-container">
	  <p><label>댓글</label>
	  <input class="w3-input" type="text" placeholder="댓글 입력"></p>
	  <button class="w3-button w3-right">등록</button>
	  </form>
	  
	  

<script>
//왼쪽에 창띄워서 사이드바로 여러가지 정보를 보여주며 간이 창으로 만들어서 여러가지 무언가를 띄워줄 수 있게 만들어주자



function w3_open() {
  document.getElementById("main").style.marginLeft = "25%";
  document.getElementById("mySidebar").style.width = "25%";
  document.getElementById("mySidebar").style.display = "block";
  //console.log(re_id); //값을 잘 가져오는지 작동하는지 테스트용
  get_atag_number(re_id)
  ajax_get_res(re_id);
}
function w3_close() {
  document.getElementById("main").style.marginLeft = "0%";
  document.getElementById("mySidebar").style.display = "none";
}

function get_atag_number() {
	//모듈 형식으로 제작(sample w3c.css)
	//(re_id를 기반으로 json파일 형식으로 BD값 가져오자)
	//mj-title, mj-body, mj-footer 형식으로 꾸며주자
	//$('#mj-title').text('매장명 받아올 ajax ' + re_id);

	$('#mj-footer').text('여기쯤에 댓글이 들어가지 않을까 생각중입니다.');
	
}

</script>

<!-- test -->

<script type="text/javascript">
// ajax 들어갈 자리 스크롤 가능해야함
// model scroll에서 뜯어오자
function ajax_get_res(re_id) {
	
	let re = {
			re_id : re_id
		}
	
	$.ajax({
		async : false, //비동기 : true(비동기), false(동기)
		url : '<c:url value="/ajax/res_data"/>', 
		type : 'post', 
		data : JSON.stringify(re), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			console.log(data);
			console.log(data.rest);
			console.log(data.rest.re_content);
			$('#mj-title').text(data.rest.re_name);
			$('#re-score').text(data.rest.re_score);
			$('#mj-body').text(data.rest.re_content);
			
			
			var score = data.rest.re_score;
			star_reset();
			star_mk(score);
			

			
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
		}
	});
}
function star_reset() {
	$('.star5').prop('checked',false);
	$('.star5').prop('checked',false);
	$('.star5').prop('checked',false);
	$('.star5').prop('checked',false);
	$('.star5').prop('checked',false);
}

function star_mk(score) {
	if(score == 5){
		$('.star5').prop('checked',true);
	} else if(score >= 4){
		$('.star4').prop('checked',true);
	}else if(score >= 3){
		$('.star3').prop('checked',true);
	}else if(score >= 2){
		$('.star2').prop('checked',true);
	}else if(score >= 1){
		$('.star1').prop('checked',true);
	}else{
		$('.star1').prop('checked',false);
	}
}

</script>

	  

	</div>

  
</div>


</body>
</html>