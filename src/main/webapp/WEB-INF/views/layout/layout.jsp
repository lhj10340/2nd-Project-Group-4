<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>인생 최대의 맛집을 찾아서</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
<!-- fontawesome 추가-->
<script src="https://kit.fontawesome.com/aa7d727d3c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd861de20f6f46a674cee82508a967e9&libraries=services"></script>
</head>
<body>
    <tiles:insertAttribute name="nav"/>
	<div id="main">

   
	    <div class="containe body-con">
	        <tiles:insertAttribute name="body" />
	    </div>
     </div>                                       

    <tiles:insertAttribute name="foo" />
</body>
</html>