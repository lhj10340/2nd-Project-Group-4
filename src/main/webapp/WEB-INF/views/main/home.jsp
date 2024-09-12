<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="<c:url value="/resources/css/map.css" />">
	<style type="text/css">
		.body-con{all: unset; margin-top: 0 !important; padding-bottom: 0px !important;}
		.cage-icon{color : #F9EBDE!important;}
	</style>
</head>
<body>
<div class="map_wrap">
    <!-- 지도가 표시될 div -->
    <div id="map"></div>
    
    <!-- 검색창이 표시될 div -->
    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form name="fsearch" onsubmit="searchPlaces(this); return false;" autocomplete="off">
                	<input type="hidden" name="sort" id="sort" value="re_name ASC">
                    <select name="sfl" id="sfl">
                    	<option value="all">전체</option>
                    	<option value="re_name">매장명</option>
                    	<option value="re_tag">태그</option>
                    </select>
                    <input type="text" value="" name="stx" id="stx" size="15" placeholder="검색어 입력"> 
                    <button type="submit" class="btn btn-search-color">찾기</button> 
                </form>
                <div>
                	<ul>
                		<li class="sort" onclick="sort_list('re_name', 'ASC')">
                			이름순(오름차순)
                		</li>
                		<li class="sort off" onclick="sort_list('re_name', 'DESC')">
                			이름순(내림차순) 
                		</li>
                		<li class="sort off" onclick="sort_list('re_score', 'DESC')">
                			좋은 별점순
                		</li>
                		<li class="sort off" onclick="sort_list('re_score', 'ASC')">
                			나쁜 별점순
                		</li>
                	</ul>
                </div>
            </div>                                                                          
        </div>
        <hr>
        <ul id="placesList"></ul>
    </div>   
</div>
<script>
 	var re_id;
	var container = document.getElementById('map');
	var options = {
		//기본위치는 학원위치
		center: new kakao.maps.LatLng(37.49915415626776, 127.03276169330279),
		level: 4
	};
	
	//지도 생성
	var map = new kakao.maps.Map(container, options);
	
	// 마커가 표시될 좌표 배열입니다
	var restaurantPositions = ajaxList();

	var markerImageSrc = '<c:url value="/resources/img/category.png"/>';  // 마커이미지의 주소입니다. 스프라이트 이미지 입니다
	    restaurantMarkers = [], // 맛집가게 마커 객체를 가지고 있을 배열입니다

	    
	createRestaurantMarkers(); // 맛집가게 마커를 생성하고 맛집가게 마커 배열에 추가합니다

	setRestaurantMarkers(map); // 지도에 맛집가게 마커가 보이도록 설정합니다    


	// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
	function createMarkerImage(src, size, options) {
	    var markerImage = new kakao.maps.MarkerImage(src, size, options);
	    return markerImage;            
	}

	// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
	function createMarker(position, image) {
	    var marker = new kakao.maps.Marker({
	        position: position[0],
	        image: image,
	        clickable: true,
	        title: position[1]
	    });
	    
	    kakao.maps.event.addListener(marker, 'click', function() {	
	    	click_marker(marker);
		});
	    
	    return marker;  
	}   
	   
	// 맛집가게 마커를 생성하고 맛집가게 마커 배열에 추가하는 함수입니다
	function createRestaurantMarkers() {
	    for (var i = 0; i < restaurantPositions.length; i++) {  
	        
	        var imageSize = new kakao.maps.Size(22, 26),
	            imageOptions = {  
	                spriteOrigin: new kakao.maps.Point(10, 0),    
	                spriteSize: new kakao.maps.Size(36, 98)  
	            };     
	        // 마커이미지와 마커를 생성합니다
	        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
	            marker = createMarker(restaurantPositions[i], markerImage);  
	        // 생성된 마커를 맛집가게 마커 배열에 추가합니다
	        restaurantMarkers.push(marker);
	    }     
	}

	// 맛집가게 마커들의 지도 표시 여부를 설정하는 함수입니다
	function setRestaurantMarkers(map) {        
	    for (var i = 0; i < restaurantMarkers.length; i++) {  
	        restaurantMarkers[i].setMap(map);
	    }        
	}
	
	
	function click_marker(marker){
		closeOverlay(); //커스텀 오버레이 기존에 켜진거 지우기
		var getRe_id = marker.getTitle(); 
		var getLat = marker.getPosition().getLat();
       	var getLng = marker.getPosition().getLng();
       	//가게정보array
       	var restaurant = ajaxInfo(getRe_id);
       	console.log(restaurant);
       	var category = restaurant[5];
       	if(category == null ) category = "미지정";
       	var cage_icon = '<i class="fa-regular fa-rectangle-xmark cage-icon"></i>';
       	switch(category){
       		case '한식':
       			cage_icon = '<i class="fa-solid fa-bowl-food cage-icon"></i>';
       		break;
       		case '중식':
       			cage_icon = '<i class="fa-regular fa-plate-wheat cage-icon"></i>';
           	break;
       		case '양식':
       			cage_icon = '<i class="fa-solid fa-burger cage-icon"></i>';
           	break;
       		case '일식':
       			cage_icon = '<i class="fa-solid fa-fish-fins cage-icon"></i>';
           	break;
       		case '디저트':
       			cage_icon = '<i class="fa-solid fa-cookie-bite cage-icon"></i>';
           	break;
       		default : cage_icon;
       	}
       	
       	// 커스텀 오버레이에 표시할 내용입니다     
		// HTML 문자열 또는 Dom Element 입니다 
		var content = '<div class="wrap overlay_content">' + 
           '    <div class="info">' + 
           '        <div class="title">' + 
           '           	'+ cage_icon + " " + restaurant[1] + 
           '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
           '        </div>' + 
           '        <div class="body">' + 
           '            <div class="img">' +
           '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
           '           </div>' + 
           '            <div class="desc">' + 
           '                <div class="ellipsis">'+restaurant[2]+'</div>' + 
           '                <div class="jibun ellipsis">'+restaurant[3]+' (<span class="rating">★</span>'+restaurant[4]+')</div>' + 
           '                <div><a href="#" onclick="w3_open()" class="link">리뷰보기 </a></div>' + 
           '            </div>' + 
           '        </div>' + 
           '    </div>' +    
           '</div>';
          	re_id = restaurant[0]; //아이디 저 아래다가 전송 (sidebar에게)
       	var overlay = new kakao.maps.CustomOverlay({
		    content: content,
		    map: map,
		    position: new kakao.maps.LatLng(getLat, getLng)

		});
       	overlay.setMap(map);
	}

	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay() {
	    $(".overlay_content").remove();
	}    
	
	//등록된 모든 맛집 가게 마커를 표시하기 위해 호출되는 함수입니다.
	function ajaxList(){
		var list = new Array();
		var view = new Array(); //리스트업을 위한 정보
		$.ajax({
	        url: "<c:url value="/ajax/list"/>",
			type: "post",
			dataType : "json",
			async: false, //동기식 , 비동기식 설정
	        success: function (data) {
	        	for (var i = 0; i < data.length; i++) {  
	        		view.push(data[i]);
		        	list.push([new kakao.maps.LatLng(data[i].re_y, data[i].re_x), data[i].re_id]);
	        	} //가져온 정보값을 카카오 위치좌표 객체로 변환 후 list array에 담음
	        }
        });
		listView(view);
       	return list;
	}
	
	//마커 클릭시 해당 좌표의 맛집 정보를 가져오기 위해 호출되는 함수입니다.
	function ajaxInfo(re_id){
		var restaurant = [];
		$.ajax({
	        url: "<c:url value="/ajax/info"/>",
			type: "post",
			dataType : "json",
			data : {re_id: re_id},
			async: false, //동기식 , 비동기식 설정
	        success: function (data) {
	        	restaurant = [data.re_id, data.re_name, data.re_address, data.re_phone, data.re_score, data.re_category];
	        }
        });
		return restaurant;
	}
	
	//검색을 요청하는 함수입니다
	function searchPlaces(f) {
	    var markers = new Array();
	    var list = new Array();
		$.ajax({
	        url: "<c:url value="/ajax/search"/>",
			type: "post",
			dataType : 'json',
			data : {sfl: f.sfl.value, stx: f.stx.value, sort: f.sort.value},
			async: false, //동기식 , 비동기식 설정
	        success: function (data) {
	        	for (var i = 0; i < data.length; i++) {  
	        		markers.push(new kakao.maps.LatLng(data[i].re_y, data[i].re_x));
	        		list.push(data[i]);
	        	} //가져온 정보값을 카카오 위치좌표 객체로 변환 후 list array에 담음
	        }
        });
		
		setRestaurantMarkers(null); //기존 지도 마커 초기화
		
		// 마커가 표시될 좌표 배열입니다
		restaurantPositions = markers;
		

		restaurantMarkers = [], // 맛집가게 마커 객체를 가지고 있을 배열입니다			    
		createRestaurantMarkers(); // 맛집가게 마커를 생성하고 맛집가게 마커 배열에 추가합니다
		
		setRestaurantMarkers(map); // 지도에 맛집가게 마커가 보이도록 설정합니다    
		listView(list);
		
	}
	//리스트에 맛집 정보를 노출시키는 함수입니다.
	function listView(list){
		
		var listEl = document.getElementById('placesList');
	 	 
		removeAllChildNods(listEl);
		
		var content = '';
		if(list.length < 1){
			content = '<li class="item">';
			content += '	<div class="info">';
			content += '		일치하는 맛집이 없습니다.';
			content += '	</div>';
			content += "</li>";
		} else {
			for (var i = 0; i < list.length; i++) {
				content += '<li class="item">';
				content += '	<span class="markerbg">';
				content += '		<img src="http://hansusu.cafe24.com/data/apms/background/main.jpg"\>';
				content += '	</span>';
				content += '	<div class="info">';
				content += '		<h5>'+list[i]['re_name']+' (<i class="fa-solid fa-star rating"></i>'+list[i]['re_score']+')</h5>';
				content += '		<span class="addr">' +  list[i]['re_address']  + '</span>';
				content += '  		<span class="tel">' + list[i]['re_phone']  + '</span>';
				content += '	</div>';
				content += "</li>";
			}
		}
		listEl.innerHTML = content;
	}
	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
	
	function sort_list(field, sort){
		$("#sort").val(field + " " + sort);
		searchPlaces(document.fsearch);
	}
	
	$(".sort").on("click", function(){
		$(".sort").addClass('off');
		$(this).removeClass('off');	
	});
</script>
<div class="w3-sidebar w3-bar-block w3-card w3-animate-left sticky" 
     style="display:none; z-index: 999; left: 0;" id="mySidebar">
  
  <button class="w3-button w3-display-topright" onclick="w3_close()">&times;</button>
  
  <div class="" style="width: 91%; margin-left: 1%">
    <div class="w3-bar-item">
      <h1 id="re_name"></h1>
      <div class="star-rating rating">
        <input type="radio" class="star star1" value="1" disabled>
        <input type="radio" class="star star2" value="2" disabled>
        <input type="radio" class="star star3" value="3" disabled>
        <input type="radio" class="star star4" value="4" disabled>
        <input type="radio" class="star star5" value="5" disabled>
        <label id="re-score" style="margin-left: 4px;font-size: 20px;"></label>
      </div>
    </div>

    <!-- Image box -->
    <div class="w3-container">
      <img src="test.jpg" alt="img box" style="width:100px;">
      <img src="test.jpg" alt="img box" style="width:100px;">
      <img src="test.jpg" alt="img box" style="width:100px;">
    </div>

    <hr>

    <!-- Content placeholders -->
    <div class="w3-bar-item">
      <i class="fa-duotone fa-solid fa-location-arrow"></i>&nbsp;
      <span id="re_address"></span>
    </div>
    <div class="w3-bar-item">
      <i class="fa-solid fa-phone"></i>&nbsp;&nbsp;<span id="re_phone"></span>
    </div>
    <div class="w3-bar-item">
      <i class="fa-solid fa-clock"></i>&nbsp;&nbsp;<span id="re_state"></span>
    </div>
    <div class="w3-bar-item w3-button">
      <i class="fa-solid fa-spoon"></i>&nbsp;&nbsp;<span class="" id="re_menu">메뉴 확인 하기</span>
    </div>
    <div class="w3-bar-item">
      <i class="fa-solid fa-store"></i>&nbsp;&nbsp;<span id="re_category"></span>
    </div>
    <div class="w3-bar-item">
      <i class="fa-solid fa-tags"></i>&nbsp;&nbsp;<span id="re_tag"></span>
    </div>
    <div class="w3-bar-item" id="re_comment" 
         style="border-radius: 5px; background-color: rgba(150, 50, 71, 0.4);">
    </div>

    <div class="w3-bar-item" id="mj-footer"></div>

    <hr>

    <!-- Review section -->
    <a href="#" class="w3-bar-item w3-button">
      여기에 대표 리뷰가 들어갈 것 같습니다.
    </a>
    <img src="test.jpg" class="w3-circle" alt="여기에 유저 이미지 들어가요" style="width:50px;">
    <i>작성자 이름</i>
    <p>작성시간 :</p>

    <hr>

    <div class="w3-container">
      <button class="w3-button w3-right w3-khaki w3-round-large">
        상세 홈페이지
      </button>
    </div>

  </div>
</div>
<!-- sidebar done -->

<script type="text/javascript">
  function w3_open() {
    document.getElementById("main").style.marginLeft = "30%";
    document.getElementById("mySidebar").style.width = "30%";
    document.getElementById("mySidebar").style.display = "block";
    get_atag_number(re_id);
    ajax_get_res(re_id);
  }

  function w3_close() {
    document.getElementById("main").style.marginLeft = "0%";
    document.getElementById("mySidebar").style.display = "none";
  }

  function get_atag_number() {
    // Sample module to fetch data using re_id
    // $('#mj-title').text('매장명 받아올 ajax ' + re_id);
  }

  function ajax_get_res(re_id) {
    let re = { re_id : re_id };

    $.ajax({
      async : false, 
      url : '<c:url value="/ajax/res_data"/>', 
      type : 'post', 
      data : JSON.stringify(re), 
      contentType : "application/json; charset=utf-8",
      dataType : "json", 
      success : function (data) {
        $('#re_name').text(data.rest.re_name);
        $('#re-score').text(data.rest.re_score);
        $('#re_comment').text(data.rest.re_content);
        $('#re_address').text(data.rest.re_address);
        $('#re_phone').text(data.rest.re_phone);
        $('#re_state').text(data.rest.re_state + ' / ' + data.rest.re_day);
        $('#re_category').text(data.rest.re_category);
        $('#re_tag').text(data.rest.re_tag);
        
        var score = data.rest.re_score;
        star_reset();
        star_mk(score);
      }, 
      error : function(jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
      }
    });
  }

  function star_reset() {
    $('.star5, .star4, .star3, .star2, .star1').prop('checked', false);
  }

  function star_mk(score) {
    if (score >= 5) {
      $('.star5').prop('checked', true);
    } else if (score >= 4) {
      $('.star4').prop('checked', true);
    } else if (score >= 3) {
      $('.star3').prop('checked', true);
    } else if (score >= 2) {
      $('.star2').prop('checked', true);
    } else if (score >= 1) {
      $('.star1').prop('checked', true);
    }
  }

  function get_review(re_id) {
    alert(re_id);
    
    let rv = { rv_re_id : re_id };

    $.ajax({
      async : false, 
      url : '<c:url value="/ajax/rv_data"/>', 
      type : 'post', 
      data : JSON.stringify(rv), 
      contentType : "application/json; charset=utf-8",
      dataType : "json", 
      success : function (data) {
        console.log(data);
      }, 
      error : function(jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
      }
    });
  }
</script>
</body>
</html>
