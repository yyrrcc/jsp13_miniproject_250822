<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
<link rel="stylesheet" href="css/common.css">
</head>
<body>
  <header>
    <h1><a href="index.do">🏥 동네 병원·약국 안내</a></h1>
    <nav>
      <ul>
        <c:choose>
        	<c:when test="${not empty sessionScope.sessionId }">
        		<li><a href="index.do">홈</a></li>
        		<li><a href="#">[${sessionScope.sessionId }님 로그인 중]</a></li>
        		<li><a href="board.do">자유게시판</a></li>
		        <li><a href="#">문의사항</a></li>
		        <li><a href="userEdit.do">회원정보수정</a></li>
		        <li><a href="logout.do">로그아웃</a></li>
        	</c:when>
        	<c:otherwise>
        		<li><a href="index.do">홈</a></li>
        		<li><a href="login.do">로그인</a></li>
        		<li><a href="join.do">회원가입</a></li>
        		<li><a href="board.do">자유게시판</a></li>  		
        		<li><a href="#">문의사항</a></li>
        	</c:otherwise>
        </c:choose>
      </ul>
    </nav>
  </header>
  
  <main>
	<section class="home">
	
	<c:choose>
		<c:when test="${not empty sessionScope.sessionId}">
			<h2>${sessionScope.sessionId }님 환영합니다!</h2>
		</c:when>
		<c:otherwise>
			<h2>Guest님, 환영합니다!</h2>
		</c:otherwise>
	</c:choose>
	
	<p>우리 동네 병원, 약국 정보를 한눈에 확인하세요.</p>
	<p>건강 꿀팁은 게시판에서 공유할 수 있습니다!</p>
	
	</section>
  </main>
  
  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
  
  <!-- 자바스크립트 -->
  <script type="text/javascript">
  // 로그아웃 시
	<c:if test="${not empty successMsg }">
		alert("${successMsg }");
	</c:if>
  </script>
  
</body>
</html>
