<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<c:url value='/resources/css/form.css' />">
</head>
<body>
	<h1>메뉴 관리</h1>
	
	
		
<div class="w3-container">
	


</div>
	
	
	
<div class="w3-container">
	
	<div class="d-flex">
		<h3>등록된 매뉴</h3>
		<div class="ml-auto" style="margin-top: 10px; margin-left: 30px">
			<i>총 : ${list_total }개 <button class="w3-button w3-light-blue" data-toggle="modal" data-target="#myModal-insert-menu"> + 메뉴 추가 </button></i>
		</div>
	</div>
	
	<table class="w3-table-all">
		<thead>
			<tr class="w3-light-grey w3-hover-red">
				<th scope="col">이미지</th>
				<th scope="col">메뉴 명</th>
				<th scope="col">카테고리</th>
				<th scope="col">판매가</th>
				<th scope="col">대표 매뉴 여부</th>
				<th scope="col">노출 설정</th>
				<th scope="col">메뉴 관리</th>
			</tr>
		</thead>
			
			<!-- 위는 테스트용 아래는 리스트 돌려서 만들어 줄 내용 -->
			
			<c:forEach items="${list }" var="me">
				<tbody>
				<tr class="w3-hover-green" style="text-align: center; vertical-align: middle;">
					<td><img src="<c:url value="/uploads/${me.me_thumb }"/>"  alt="img" ></td>
					<td>${me.me_title }</td>
					<td>${me.me_category }</td>
					<td>${me.me_price }</td>
					<td>
						<div class="custom-control custom-switch">
							<c:if test="${me.me_main_menu eq null }">
								<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu" disabled>
							</c:if>
							<c:if test="${me.me_main_menu eq 'on' }">
								<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu" checked disabled>
							</c:if>
							<label class="custom-control-label" for="me_main_menu">메인 매뉴</label>
						</div>
					</td>
					<td>
						<div class="custom-control custom-switch">
							<c:if test="${me.me_show eq null }">
								<input type="checkbox" class="custom-control-input" id="me_show" name="me_show" disabled>							
							</c:if>
							<c:if test="${me.me_show eq 'on'}">
								<input type="checkbox" class="custom-control-input" id="me_show" name="me_show" checked disabled>						
							</c:if>
							<label class="custom-control-label" for="me_show">노출 여부</label>
						</div>
					</td>
					<td>
						<a class="w3-button w3-white w3-border w3-border-yellow w3-round-large" data-toggle="modal" data-target="#myModal-update-menu-${me.me_id}">수정</a>
						<a href='<c:url value="/menu/delete_menu?me_id=${me.me_id }"/>' class="w3-button w3-white w3-border w3-border-red w3-round-large">삭제</a>
					</td>
				</tr>
				</tbody>
				
				
				
				
				
				
<!-- update-menu modal -->
	
	
<div class="container">


  <!-- The Modal -->
  <div class="modal fade" id="myModal-update-menu-${me.me_id}">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">기존 메뉴 수정</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- from start -->
        <form action='<c:url value="/menu/update_menu"/>' method="post">
		        <!-- Modal body -->
		        <div class="modal-body">
			        <input type="hidden" value="${me.me_id }" name="me_id">
					<p>
						<label>수정할 메뉴 이름</label>
						<input class="w3-input" type="text" name="me_title" value="${me.me_title }"></p>
					<p>
					<p>
						<label>카테고리 명</label>
						<input class="w3-input" type="text" name="me_category" value="${me.me_category }"></p>
					<p>
					<div class="custom-control custom-switch">
						<c:if test="${me.me_main_menu eq null }">
							<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu">
						</c:if>
						<c:if test="${me.me_main_menu eq 'on' }">
							<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu" checked>
						</c:if>
						<label class="custom-control-label" for="me_main_menu">메인 매뉴</label>
					</div>
					<div class="custom-control custom-switch">
						<c:if test="${me.me_show eq null }">
							<input type="checkbox" class="custom-control-input" id="me_show" name="me_show">							
						</c:if>
						<c:if test="${me.me_show eq 'on'}">
							<input type="checkbox" class="custom-control-input" id="me_show" name="me_show" checked>						
						</c:if>
						<label class="custom-control-label" for="me_show">노출 여부</label>
					</div>
					<p>
						<label>가격</label>
						<input class="w3-input" type="number" name="me_price" value="${me.me_price }"></p>
					<p>
					<p>메뉴 섬네일:</p>
					<div class="custom-file mb-3">
						<input type="file" class="custom-file-input" id="customFile" name="me_thumb">
						<label class="custom-file-label" for="customFile">${me.me_thumb }</label>
					</div>
					
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="submit" class="w3-btn w3-block btn-primary" >메뉴 수정<i class="w3-margin-left fa fa-arrow-right"></i></button>
		        </div>
        </form>
        <!-- form done -->
      </div>
    </div>
  </div>
  
</div>				
				
				
				
				
	
				
				
				
				
			</c:forEach>
	</table>
		
</div>
	
	
	
<!-- insert-menu modal -->
	
	
<div class="container">


  <!-- The Modal -->
  <div class="modal fade" id="myModal-insert-menu">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">새로운 메뉴 추가</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- from start -->
        <form action='<c:url value="/menu/add_menu"/>' method="post" enctype="multipart/form-data">
		        <!-- Modal body -->
		        <div class="modal-body">
			          
					<p>
						<label>새로운 메뉴 이름</label>
						<input class="w3-input" type="text" name="me_title"></p>
					<p>
					<p>
						<label>카테고리 명</label>
						<input class="w3-input" type="text" name="me_category"></p>
					<p>
					<div class="custom-control custom-switch">
						<input type="checkbox" class="custom-control-input" id="switch1" name="me_main_menu">
						<label class="custom-control-label" for="switch1">메인 메뉴 등록</label>	
					</div>
					<div class="custom-control custom-switch">
						<input type="checkbox" class="custom-control-input" id="switch2" name="me_show" checked>
						<label class="custom-control-label" for="switch2">화면 노출</label>
					</div>
					<p>
						<label>가격</label>
						<input class="w3-input" type="number" name="me_price"></p>
					<p>
					<p>메뉴 섬네일:</p>
					<div class="custom-file mb-3">
						<input type="file" class="custom-file-input" id="customFile" name="thumb">
						<label class="custom-file-label" for="customFile">파일을 선택해 주세요</label>
					</div>
					
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="submit" class="w3-btn w3-block btn-primary" >메뉴 추가<i class="w3-margin-left fa fa-arrow-right"></i></button>
		        </div>
        </form>
        <!-- form done -->
      </div>
    </div>
  </div>
  
</div>
	

<script type="text/javascript">
// ajax로 대표 매뉴, 노출 여부 변경시 db변경하게 하기



</script>


<script>
// 파일 입력시 파일 명 변경 도와주는 스크립트
	$(".custom-file-input").on("change", function() {
	    var fileName = $(this).val().split("\\").pop();
	    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
	});
	</script>
</body>
</html>
