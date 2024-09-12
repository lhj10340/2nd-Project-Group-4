<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<div>디버깅용 : 리스트... ${list } 가 없으면 널이라 안뜸 로그인이 안되서 확인이 어려워용</div>
	<h1>메뉴 관리</h1>
	
	
		
<div class="w3-container">
	


</div>
	
	
	
<div class="w3-container">
	
	<div class="d-flex">
		<h3>등록된 매뉴</h3>
		<div class="ml-auto" style="margin-top: 10px; margin-left: 30px">
			<i>총 : ${list_total }개 <button class="w3-button w3-blue"> + 메뉴 추가 </button></i>
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
		<tbody>
			<tr class="w3-hover-green" style="text-align: center; vertical-align: middle;">
				<td><img src=""  alt="상품 이미지가 들어갈 예정" ></td>
				<td>고등어 갈치 조림</td>
				<td>인기 메뉴</td>
				<td>100000</td>
				<td>
					<div class="custom-control custom-switch">
						<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu">
						<label class="custom-control-label" for="me_main_menu">대표 매뉴</label>
					</div>
				</td>
				<td>
					<div class="custom-control custom-switch">
						<input type="checkbox" class="custom-control-input" id="me_show" name="me_show" checked>
						<label class="custom-control-label" for="me_show">노출 여부</label>
					</div>
				</td>
				<td>
					<button class="w3-button w3-white w3-border w3-border-yellow w3-round-large">수정</button>
					<button class="w3-button w3-white w3-border w3-border-red w3-round-large">삭제</button>
				</td>
			</tr>
			
			<!-- 위는 테스트용 아래는 리스트 돌려서 만들어 줄 내용 -->
			
			<c:forEach items="${list }" var="me">
				<tr>
					<td><img src=""  alt="상품 이미지가 들어갈 예정" >${me.me_thumb }</td>
					<td>${me.me_title }</td>
					<td>${me.me_category }</td>
					<td>${me.me_price }</td>
					<td>${me.me_price }</td>
					<td>
						<div class="custom-control custom-switch">
							<c:if test="${me.me_main_menu == null }">
								<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu">
							</c:if>
							<c:if test="${me.me_main_menu eq on }">
								<input type="checkbox" class="custom-control-input" id="me_main_menu" name="me_main_menu" checked>
							</c:if>
							<label class="custom-control-label" for="me_main_menu">대표 매뉴</label>
						</div>
					</td>
					<td>
						<div class="custom-control custom-switch">
							<c:if test="${me.me_show == null }">
								<input type="checkbox" class="custom-control-input" id="me_show" name="me_show">							
							</c:if>
							<c:if test="${me.me_show eq on}">
								<input type="checkbox" class="custom-control-input" id="me_show" name="me_show" checked>						
							</c:if>
							<label class="custom-control-label" for="me_show">노출 여부</label>
						</div>
					</td>
					<td>
						<button class="w3-button w3-white w3-border w3-border-yellow w3-round-large">수정</button>
						<button class="w3-button w3-white w3-border w3-border-red w3-round-large">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		
</div>
	
</body>
</html>