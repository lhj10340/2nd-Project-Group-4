<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.page-link {
	color: #000;
	background-color: #fff;
	border: 1px solid #ccc;
}

.page-item.active .page-link {
	z-index: 1;
	color: #555;
	font-weight: bold;
	background-color: #f1f1f1;
	border-color: #ccc;
}

.page-link:focus, .page-link:hover {
	color: #000;
	background-color: #fafafa;
	border-color: #ccc;
}

.review-list {
	color: black;
	font-weight: 550;
}
</style>
</head>
<body>
	<h1>
		<c:choose>
			<c:when test="${empty param.rv_tf}">
                리뷰 게시판
            </c:when>
			<c:when test="${param.rv_tf eq '0'}">
                일반 리뷰 게시판
            </c:when>
			<c:when test="${param.rv_tf eq '1'}">
                영수증 리뷰 게시판
            </c:when>
			<c:otherwise>
                리뷰 게시판
            </c:otherwise>
		</c:choose>
	</h1>
	<div class="mb-3">
		<input type="button"
			class="btn btn-review-color <c:if test="${empty param.rv_tf}"></c:if>"
			value="전체 리뷰"
			onclick="window.location.href='<c:url value='/review/list' />'">
		<input type="button"
			class="btn btn-review-color <c:if test="${param.rv_tf eq '0'}"></c:if>"
			value="일반 리뷰"
			onclick="window.location.href='<c:url value='/review/list?rv_tf=0' />'">
		<input type="button"
			class="btn btn-review-color <c:if test="${param.rv_tf eq '1'}"></c:if>"
			value="영수증 리뷰"
			onclick="window.location.href='<c:url value='/review/list?rv_tf=1' />'">
	</div>
	<table class="table table-bordered border-dark table-striped border-4">
		<thead>
			<tr class="text-center">
				<th>번호</th>
				<th>매장명</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>별점</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reviewList }" var="review">
				<tr>
					<td class="text-center">${review.rv_id }</td>
					<td><a class="review-list" href="#">${review.rv_name }</a></td>
					<td><c:url var="url" value="/review/detail">
							<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
							<c:param name="page" value="${pm.cri.page }" />
							<c:param name="type" value="${pm.cri.type }" />
							<c:param name="search" value="${pm.cri.search }" />
							<c:param name="rv_id" value="${review.rv_id }" />
						</c:url> <a class="review-list" href="${url }">${review.rv_title }</a></td>
					<td><c:url var="url" value="/review/list">
							<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
							<c:param name="type" value="id" />
							<c:param name="search" value="${review.rv_us_id }" />
						</c:url> <a class="review-list" href="${url }">${review.rv_us_id }</a></td>
					<td class="text-center"><fmt:formatDate value="${review.rv_date }"
							pattern="yy.MM.dd" /></td>
					<td class="text-center">${review.rv_score }</td>
				</tr>
			</c:forEach>
			<c:if test="${reviewList.size() eq 0 }">
				<tr>
					<th class="text-center" colspan="6">등록된 게시글이 없습니다.</th>
				</tr>
			</c:if>
		</tbody>
	</table>
	<c:if test="${pm.totalCount ne 0 }">
		<ul class="pagination justify-content-center">
			<c:if test="${pm.prev }">
				<c:url var="url" value="/review/list">
					<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
					<c:param name="page" value="${pm.startPage - 1 }" />
					<c:param name="type" value="${pm.cri.type }" />
					<c:param name="search" value="${pm.cri.search}" />
				</c:url>
				<li class="page-item"><a class="page-link" href="${url }">이전</a>
				</li>
			</c:if>
			<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="i">
				<c:url var="url" value="/review/list">
					<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
					<c:param name="page" value="${i}" />
					<c:param name="type" value="${pm.cri.type }" />
					<c:param name="search" value="${pm.cri.search }" />
				</c:url>
				<c:choose>
					<c:when test="${pm.cri.page eq i }">
						<c:set var="active" value="active" />
					</c:when>
					<c:otherwise>
						<c:set var="active" value="" />
					</c:otherwise>
				</c:choose>
				<li class="page-item ${active}"><a class="page-link"
					href="${url }">${i}</a></li>
			</c:forEach>
			<c:if test="${pm.next }">
				<c:url var="url" value="/review/list">
					<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
					<c:param name="page" value="${pm.startPage + 1 }" />
					<c:param name="type" value="${pm.cri.type }" />
					<c:param name="search" value="${pm.cri.search }" />
				</c:url>
				<li class="page-item"><a class="page-link" href="${url }">다음</a>
				</li>
			</c:if>
		</ul>
	</c:if>
	<form action="<c:url value="/review/list"/>">
		<input type="hidden" name="rv_tf" value="${pm.cri.rv_tf}">
		<div class="input-group mb-3">
			<select class="form-control" name="type">
				<option value="all"
					<c:if test="${pm.cri.type eq 'all' }">selected</c:if>>전체</option>
				<option value="title"
					<c:if test="${pm.cri.type eq 'title' }">selected</c:if>>제목</option>
				<option value="id"
					<c:if test="${pm.cri.type eq 'id' }">selected</c:if>>작성자</option>
				<option value="name"
					<c:if test="${pm.cri.type eq 'name' }">selected</c:if>>매장명</option>
			</select> <input type="text" class="form-control" placeholder="검색어"
				name="search" value="${pm.cri.search }">
			<div class="input-group-append">
				<button class="btn btn-search-color col-12">검색</button>
			</div>
		</div>
	</form>
	<a href="<c:url value="/review/insert?rv_tf=${pm.cri.rv_tf }"/>"
		class="btn btn-search-color">리뷰 등록</a>
	<script type="text/javascript">
		$('.btn-insert').click(function(e) {
			e.preventDefault(); // 기본 동작을 막음
	
			// 로그인 여부 확인 (로그인 상태 체크: '${user.us_id}' 사용)
			if ('' != '${user.us_id}') {
				// 로그인된 경우 리뷰 등록 페이지로 이동
				location.href = "<c:url value='/review/insert?rv_tf=${pm.cri.rv_tf }'/>";
			} else {
				// 로그인되지 않은 경우 모달 표시
				alert("로그인이 필요한 서비스입니다.");
				$('#myModal-login').modal('show'); // Bootstrap 모달 표시
			}
		});
	</script>
</body>
</html>
