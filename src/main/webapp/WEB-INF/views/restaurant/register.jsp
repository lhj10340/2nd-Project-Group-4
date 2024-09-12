<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장등록</title>
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
<div class="form-div">
	<form name="frestaurant" id="frestaurant" onsubmit="frestaurantsubmit(this);" action="<c:url value="/restaurant/insert"/>"  method="POST" enctype="multipart/form-data" autocomplete="off">
		<input type="hidden" name="re_us_id" value="test1234">
		<input type="hidden" name="re_x" value="" id="re_x">
		<input type="hidden" name="re_y" value="" id="re_y">
		<div class="form-group">
			<label for="re_name">매장명</label>
			<input type="text" name="re_name" id="re_name" value="" class="form-control-rest">
		</div>
		<div class="form-group">
			<label for="re_category">어떤음식을 파는 곳 인가요?</label>
			<select name="re_category" class="form-control-rest" required>
				<option value="">선택해주세요:)</option>
				<option value="한식">한식</option>
				<option value="양식">양식</option>
				<option value="중식">중식</option>
				<option value="일식">일식</option>
				<option value="디저트">디저트</option>
			</select>
		</div>
		<div class="form-group">
			<label for="re_state">영업상태</label>
			<select name="re_state" id="re_state" class="form-control-rest" required>
				<option value="신규오픈">신규오픈</option>
				<option value="영업중">영업중</option>
				<option value="영업종료">영업종료</option>
				<option value="폐업">폐업</option>
			</select>
		</div>
		<div class="form-group">
			<label for="re_day">영업일</label>
			<input type="text" name="re_day" id="re_day" value="" placeholder="ex) 월~금 09:00 ~ 21:00 연중무휴" class="form-control-rest">
		</div>
		<div class="form-group">
			<label for="phone1">가게연락처</label>
			<br>
			<input type="hidden" name="re_phone" id="re_phone" value="">
			<input type="text" data-num="1" size="5" class="form-control-rest phone" onkeyup="getPhone();"><span class="hyphen">-</span> 
			<input type="text" data-num="2" size="5" class="form-control-rest phone" onkeyup="getPhone();"><span class="hyphen">-</span> 
			<input type="text" data-num="3" size="5" class="form-control-rest phone" onkeyup="getPhone();">
		</div>
		<div class="form-group">
			<label for="re_zip">우편번호</label>
			<br>
			<input type="text" name="re_zip" id="re_zip" placeholder="우편번호" onfocus="getDaumPostcode()" required readonly class="form-control zip-class">
			<input type="button" onclick="getDaumPostcode()" value="우편번호 찾기" class="btn btn-search-color">
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
		</div>
		<div class="form-group">
			<label for="re_address">기본주소(도로명)</label>
			<input type="text" name="re_address" id="re_address" placeholder="우편번호 찾기로 입력할 수 있어요:)" class="form-control-rest" required readonly>
		</div>
		<div class="form-group">
			<label for="re_address2">상세주소</label>
			<input type="text" name="re_address2" id="re_address2" placeholder="상세주소" class="form-control-rest">
			<input type="hidden" id="extraAddress" placeholder="참고항목">
		</div>
		<div class="form-group">
			<label for="re_tag">매장태그(,로 구분되어 집니다. 여러 태그 작성시 ,를 이용해주세요. ex:맛집,분위기,데이트 )</label>
			<input type="text" name="re_tag" id="re_tag" value="" placeholder="콤마(,)로 구분합니다." class="form-control-rest">
		</div>
		<div class="form-group">
			<label for="re_content">매장소개</label>
			<textarea name="re_content" id="re_content" class="form-control-rest" maxlength="500" onkeyup="countText(this.value);" placeholder="간단하게 매장을 소개해주세요:)"></textarea>
			<div class="text-count">
				<span id="count">0</span> / 500
			</div>
		</div>
		<div class="form-group">
			<label>첨부파일:</label>
			<input type="file" class="form-control-rest frm_file" name="fileList">
			<input type="file" class="form-control-rest frm_file" name="fileList">
			<input type="file" class="form-control-rest frm_file" name="fileList">
			<img class="img_preview" width="100%"/>
		</div>
		<div class="form-group button-group">
			<button type="submit" class="btn btn-search-color">매장등록</button>
		</div>
	</form>
</div>

<script type="text/javascript">
	function getPhone(){
		var phone = '';
	    
	    $('input.phone').each(function() {
	        phone += $(this).val();  // 현재 input 값 추가
	        if ($(this).data('num') !== 3) {
	            phone += '-';  // 마지막이 아니면 하이픈 추가
	        }
	    });
	    
	    $("#re_phone").val(phone);
	}
	function countText(val){
		val = val.replace(/\s+/g, '');
		var count = val.length; //문자수
		var maxLength = 500;
		$("#count").text(count);
		if(count > maxLength){
			$("#re_content").val(val.slice(0, maxLength));  
		}
	}
	function frestaurantsubmit(f){
		console.log(f);
		//return false;
	}
	
	function geocoderMap(addr){
		var geocoder = new kakao.maps.services.Geocoder();
		geocoder.addressSearch(addr, function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			var re_x, re_y = '';
		     if (status === kakao.maps.services.Status.OK) {
		    	 re_x = parseFloat(result[0].x);
		    	 re_y = parseFloat(result[0].y);
		    	 //LatLng
		    	 $("#re_x").val(re_x);
		    	 $("#re_y").val(re_y);
		     } else {
		    	 alert("정상적인 주소가 아닙니다.");
		     }
		});
	}
	
	var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function getDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                addr = data.roadAddress;

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('re_zip').value = data.zonecode;
                document.getElementById("re_address").value = addr;
                //좌표 가져오기
                geocoderMap(addr);
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("re_address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
        
	    // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
        
    }
    
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            var $wrap = $(input).parent();
            if($wrap.find('.img_preview').length==0){
                $wrap.append("<div><img class='img_preview'/></div>");
            }

            reader.onload = function(e) {
                $('img.img_preview',$wrap).attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    $(".frm_file").change(function() {
        readURL(this);
    });
</script>
</body>
</html>