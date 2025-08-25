<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>       
<jsp:include page="includes/header.jsp" />    
<link rel="stylesheet" href="css/login.css">

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

 <jsp:include page="includes/footer.jsp" />
 
  <!-- 자바스크립트 -->
  <script type="text/javascript">
  // 로그아웃 시
	<c:if test="${not empty successMsg }">
		alert("${successMsg }");
	</c:if>
  </script>