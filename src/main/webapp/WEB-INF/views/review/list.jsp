<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
	.zip-class {width: 30% !important; display: inline-flex !important;}
	.form-div {color:#815854;}
	.form-control-rest {background-color:#fcf5ed;display: block;width: 100%;height: calc(1.5em + .75rem + 2px);padding: .375rem .75rem;font-size: 1rem;
    font-weight: 400;line-height: 1.5;color: #815854;background-clip: padding-box;border: 1px solid #fff;
    border-radius: .25rem;transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;}
    label {font-weight: bold; font-size: 15px;}
    .phone {width: 30% !important;display: inline-flex !important;}
    .hyphen {margin-left: 2%;margin-right: 2%;}
    textarea {height: 6.25em !important;resize: none;}                                                                       
    .button-group {text-align: center;}
</style>
</head>
<body>
	<h1>리뷰 게시판</h1>
	<div class="mb-3">
		<a href="<c:url value='/review/list' />" class="btn <c:if test="${empty param.rv_tf}">btn-info text-white</c:if> btn-outline-info">전체 리뷰</a>
		<a href="<c:url value='/review/list?rv_tf=0' />" class="btn <c:if test="${param.rv_tf eq '0'}">btn-info text-white</c:if> btn-outline-info">일반 리뷰</a> 
    	<a href="<c:url value='/review/list?rv_tf=1' />" class="btn <c:if test="${param.rv_tf eq '1'}">btn-info text-white</c:if> btn-outline-info">영수증 리뷰</a>
	</div>
		<table class="table table-hover">
			<thead>
				<tr>
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
						<td>${review.rv_id }</td>
						<td><a href="#">${review.rv_re_id }</a></td>
						<td><c:url var="url" value="/review/detail">
								<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
								<c:param name="page" value="${pm.cri.page }" />
								<c:param name="type" value="${pm.cri.type }" />
								<c:param name="search" value="${pm.cri.search }" />
								<c:param name="rv_id" value="${review.rv_id }" />
							</c:url> <a href="${url }">${review.rv_title }</a></td>
						<td><c:url var="url" value="/review/list">
								<c:param name="rv_tf" value="${pm.cri.rv_tf }" />
								<c:param name="type" value="id" />
								<c:param name="search" value="${review.rv_us_id }" />
							</c:url> <a href="${url }">${review.rv_us_id }</a></td>
						<td><fmt:formatDate value="${review.rv_date }"
								pattern="yy.MM.dd" /></td>
						<td>${review.rv_score }</td>
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
						<c:param name="type" value="${pm.cri.type }"/>
						<c:param name="search" value="${pm.cri.search}"/>
					</c:url>
					<li class="page-item">
						<a class="page-link" href="${url }">이전</a>
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
					<option value="re"
						<c:if test="${pm.cri.type eq 're' }">selected</c:if>>매장명</option>
				</select> <input type="text" class="form-control" placeholder="검색어"
					name="search" value="${pm.cri.search }">
				<div class="input-group-append">
					<button class="btn btn-outline-info col-12">검색</button>
				</div>
			</div>
		</form>
		<a href="<c:url value="/review/insert?rv_tf=${pm.cri.rv_tf }"/>"
			class="btn btn-outline-info btn-insert mb-5">리뷰 등록</a>
	<script type="text/javascript">
		$('.btn-insert').click(function() {
			if ('' != '${user.us_id}') {
				return;
			}
			e.preventDefault();
			if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
				location.href = "<c:url value="/login"/>";
			}
		});
	</script>
</body>
</html>
