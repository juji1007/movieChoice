<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>메인페이지</title>
 	<meta charset="utf-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="partials/header.jsp"/>
<style>
	header {
		width: 100%;
		background-color: white;
		border-bottom: solid 3px;
		border-bottom-color: #56BEC0;
	}
	.toparea {
		height: 110px;
		width: 100%;
		postion: relative;
	}
	.logo {
		width: 100px;
		height: 100px;
		padding-left: 40px;
	}
	.banner {
		width: 800px;
		height: 100px;
		left: 300px;
		top: 20px;
		position: absolute;
		border: solid black 3px;
	}
	.container-fluid {
	  padding-right: 15px;
	  padding-left: 15px;
	  margin-right: auto;
	  margin-left: auto;
	}
	main {
		height: 100%;
		widht: 100%;
		margin: 0 auto;
	}
</style>

</head>
<body>
<jsp:include page="partials/navbar.jsp"/>
	<!--<header>
		<div class="toparea">
			<div class="logo"><h2>Movie WebSite</h2></div>
			<div class="banner">banner</div>
		</div>
	</header> -->
	
	<main>
	 <div class="container-fluid" >
	 		<h1>본문 영역</h1>
            <div class="row">
                <div class="col-xs-3">.col-xs-3</div>
                <div class="col-xs-3">.col-xs-3</div>
                <div class="col-xs-3">.col-xs-3</div>
                <div class="col-xs-3">.col-xs-3</div>
            </div>
            <div class="row">
                <div class="col-sm-3">.col-sm-3</div>
                <div class="col-sm-3">.col-sm-3</div>
                <div class="col-sm-3">.col-sm-3</div>
                <div class="col-sm-3">.col-sm-3</div>
            </div>
            <div class="row">
                <div class="col-md-3">.col-md-3</div>
                <div class="col-md-3">.col-md-3</div>
                <div class="col-md-3">.col-md-3</div>
                <div class="col-md-3">.col-md-3</div>
            </div>
            <div class="row">
                <div class="col-lg-3">.col-lg-3</div>
                <div class="col-lg-3">.col-lg-3</div>
                <div class="col-lg-3">.col-lg-3</div>
                <div class="col-lg-3">.col-lg-3</div>
            </div>
        </div>
	</main>
<jsp:include page="partials/footer.jsp"/>