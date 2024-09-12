<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.fixed-size {
    width: 100%; /* 너비를 100%로 고정 */
    height: 150px; /* 높이를 150px로 고정 */
    resize: none; /* 사용자가 크기를 조정하지 못하게 설정 */
}
.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}

.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}
</style>
</head>
<body>
	<c:if test="${review ne null }">
		<h1>리뷰 상세</h1>

		<div class="form-group" style="display: flex; align-items: center;">
			<label for="title" style="width: 50px; margin-right: 10px;">제목: </label>
			<div class="form-control" style="flex: 1;">${review.rv_title}</div>
		</div>
		<form action="">
			<div class="form-group" style="display: flex; align-items: center;">
				<label for="title" style="width: 50px; margin-right: 10px;">작성자: </label>
				<div class="form-control" style="flex: 1; margin-right: 100px;">${review.rv_us_id}</div>
				<label for="title" style="width: 50px; margin-right: 10px;">작성일: </label>
				<div class="form-control" style="flex: 1;">${review.rv_date }</div>
			</div>
			<div class="form-group" style="display: flex; align-items: center;">
			<label for="title" style="width: 50px; margin-right: 10px;">매장명: </label>
			<div class="form-control" style="flex: 1;">${review.rv_name}</div>
		</div>
		</form>
		<div class="form-group">
			<label for="content">내용: </label>
			<div class="form-control" style="min-height: 400px; height: auto">${review.rv_content }</div>
		</div>
		<c:if test="${list.size() != 0 }">
			<div class="form-group">
				<label>사진첨부:</label>
				<c:forEach items="${list }" var="image">
					<a href="<c:url value="/download${image.im_name }"/>"
						class="form-control" download="${image.im_ori_name }">${image.im_ori_name }</a>
				</c:forEach>
			</div>
		</c:if>
	</c:if>
	<c:if test="${review eq null }">
		<h3>삭제되거나 잘못된 게시글입니다.</h3>
	</c:if>
	<c:url var="url" value="/review/list">
		<c:param name="rv_tf" value="${cri.rv_tf }" />
		<c:param name="page" value="${cri.page }" />
		<c:param name="type" value="${cri.type }" />
		<c:param name="search" value="${cri.search }" />
	</c:url>
	<a href="${url }" class="btn btn-search-color">목록</a>
		<c:if test="${review.rv_us_id eq user.us_id }">
		<c:url var="url" value="/review/update">
			<c:param name="rv_tf" value="${cri.rv_tf }"/>
			<c:param name="page" value="${cri.page }"/>
			<c:param name="type" value="${cri.type }"/>
			<c:param name="search" value="${cri.search}"/>
			<c:param name="rv_id" value="${review.rv_id }"/>
		</c:url>
		<a href="${url}" class="btn btn-search-color">수정</a>
		<c:url var="url" value="/review/delete">
			<c:param name="rv_tf" value="${cri.rv_tf }"/>
			<c:param name="page" value="${cri.page }"/>
			<c:param name="type" value="${cri.type }"/>
			<c:param name="search" value="${cri.search}"/>
			<c:param name="rv_id" value="${review.rv_id }"/>
		</c:url>
		<a href="${url}" class="btn btn-search-color">삭제</a>
	</c:if>
<!-- 	<div class="comment-container">
		<ul class="comment-list" style="list-style: none; padding: 0" >
			<li class="comment-item">
				<div class="clearfix">
					<span class="float-left" style="line-height: 38px">아이디</span>
					<div class="float-right">
						<button class="btn btn-outline-info">수정</button>
						<button class="btn btn-outline-dark">삭제</button>
					</div>
				</div>
				<div style="padding-left:20px; line-height: 38px;">댓글내용</div>
			</li>
		</ul>
		<div class="comment-pagination">
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link" href="javascript:void(0);">이전</a></li>
				<li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
				<li class="page-item"><a class="page-link" href="javascript:void(0);">다음</a></li>
			</ul>
		</div>
		<div class="comment-input-box">
			<div class="input-group mb-3">
			    <textarea class="form-control fixed-size" placeholder="댓글 입력" id="input-comment"></textarea>
			    <div class="input-group-append">
					<span class="input-group-text btn-insert">등록</span>
			    </div>
			</div>	
		</div>
	</div> -->
</body>
<script type="text/javascript">
	let cri = {
		page : 1,
		search : '${review.rv_id}'
	}
	function checkLogin(){
		return '${user.us_id}' != '';
	}
	function alertLogin(){
		if(checkLogin()){
			return false;
		}
		if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")){
			location.href="<c:url value="/login"/>";
		}
		return true;
	}
	//댓글 목록을 가져와서 화면에 출력하는 함수
	function getCommentList(cri){
		$.ajax({
			async : true, 
			url : '<c:url value="/comment/list"/>', 
			type : 'post', 
			data : JSON.stringify(cri), 
			contentType : "application/json; charset=utf-8",
			dataType : "json", 
			success : function (data){
				//댓글 목록을 화면에 출력
				displayCommentList(data.list);
				//페이지네이션을 화면에 출력
				displayPagination(data.pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR)
			}
		});
	}
	
	function getCommentList2(cri){
		$.ajax({
			async : true, 
			url : '<c:url value="/comment/list2"/>', 
			type : 'post', 
			data : JSON.stringify(cri), 
			contentType : "application/json; charset=utf-8",
			success : function (data){
				$('.comment-container').html(data);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR)
			}
		});
	}
	//댓글 목록이 주어지면 화면에 출력하는 함수
	function displayCommentList(list){
		if(list == null || list.length == 0){
			$(".comment-list").html('<li class="comment-item display-4">등록된 댓글이 없습니다.</li>');
			return;
		}
		var str = '';
		for(comment of list){
			var btns = '';
			if(comment.co_us_id == '${user.us_id}'){
				btns = `
				<div class="float-right">
					<button class="btn btn-outline-info">수정</button>
					<button class="btn btn-outline-dark">삭제</button>
				</div>
				`
			}
			str += `
				<li class="comment-item">
					<div class="clearfix">
						<span class="float-left" style="line-height: 38px">\${comment.co_us_id}</span>
						\${btns}
					</div>
					<div style="padding-left:20px; line-height: 38px;">\${comment.co_content}</div>
				</li>
			`;
		}
		$(".comment-list").html(str);
	}
	//댓글의 페이지네이션을 화면에 출력하는 함수
	function displayPagination(pm){
		if(pm == null || pm.endPage == 0){
			return;
		}
		var str = '';
		if(pm.prev){
			str += `
				<li class="page-item" data-page="\${pm.startPage-1}"><a class="page-link" href="javascript:void(0);">이전</a></li>
			`
		}
		for(var i = pm.startPage; i <= pm.endPage; i++){
			var active = pm.cri.page == i ? 'active' : ''; 
			str += `
				<li class="page-item \${active}" data-page="\${i}"><a class="page-link" href="javascript:void(0);">\${i}</a></li>
			`
		}
		if(pm.next){
			str += `
				<li class="page-item" data-page="\${pm.endPage+1}"><a class="page-link" href="javascript:void(0);">다음</a></li>
			`
		}
		$('.comment-pagination>.pagination').html(str);
	}
	
	getCommentList2(cri);
	
	$(document).on('click', '.comment-pagination .page-item', function(){
		cri.page = $(this).data('page');
		getCommentList2(cri);
	})
	
	
	//댓글 등록을 클릭하면 댓글을 등록
	$(document).on('click', '.btn-insert', function(){
		//로그인 확인
		if(alertLogin()){
			return;
		}
		//댓글 내용, 게시글 번호
		var co_content = $('#input-comment').val();
		var co_rv_id = '${review.rv_id}';
		var comment = {
			co_content : co_content,
			co_rv_id : co_rv_id
		}
		
		if(co_content.length == 0){
			alert('댓글을 입력하세요');
			$('#input-comment').focus();	
			return;
		}
		//서버로 데이터를 전송해서 댓글을 등록하고 알림을 띄움
		$.ajax({
			async : true, //비동기 : true(비동기), false(동기)
			url : '<c:url value="/comment/insert"/>', 
			type : 'post', 
			data : JSON.stringify(comment), 
			contentType : "application/json; charset=utf-8",
			success : function (data){
				if(data){
					alert('댓글을 등록했습니다.');
					$('#input-comment').val('');
				}else{
					alert('댓글을 등록하지 못했습니다.');
				}
				//댓글 목록을 다시 불러옴
				getCommentList2(cri);
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR);
			}
		});
	});
</script>
</html>