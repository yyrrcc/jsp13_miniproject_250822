<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/login.css">
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
		        <li><a href="reservation.do">문의사항</a></li>
		        <li><a href="userEdit.do">회원정보수정</a></li>
		        <li><a href="logout.do">로그아웃</a></li>
        	</c:when>
        	<c:otherwise>
        		<li><a href="index.do">홈</a></li>
        		<li><a href="login.do">로그인</a></li>
        		<li><a href="join.do">회원가입</a></li>
        		<li><a href="board.do">자유게시판</a></li>  		
        		<li><a href="reservation.do">문의사항</a></li>
        	</c:otherwise>
        </c:choose>
      </ul>
    </nav>
  </header>
  
  
  
	<section class="login">
	  <h2>로그인</h2>
	  <form action="loginAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="loginId" required>
	    
	    <label>비밀번호</label>
	    <input type="password" name="loginPw" required>
	    
	    <!-- 아이디 비밀번호 틀렸을 때 -->
	   	<c:if test="${not empty loginErrorMsg }">
	   		<p style="text-align: center; color: red;">${loginErrorMsg}</p>
	   	</c:if>

	    <button type="submit">로그인</button>
	  </form>
	  
	  <div class="joinorsearch"><span><a href="join.do">회원가입</a> | <a href="#">비밀번호 찾기</a></span></div>
	</section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
  
  <!-- 자바스크립트 -->
  <script type="text/javascript">
  // 회원 가입 성공 시
	<c:if test="${not empty successMsg }">
		alert("${successMsg }");
	</c:if>
  // 로그인 하지 않은 채 정보 수정 하려 할 때
	<c:if test="${param.error == 'login_required'}">
	alert("로그인 후 접속할 수 있습니다.");
	</c:if>
  // 로그인 하지 않은 유저가 글쓰기 시도 할 때
	<c:if test="${not empty WriteErrorMsg}">
	    alert("${WriteErrorMsg}");
	</c:if>	
  // 로그인 하지 않은 유저가 로그아웃 할 때
	<c:if test="${not empty logoutErrorMsg}">
	    alert("${logoutErrorMsg}");
	</c:if>		
  </script>
  
</body>
</html>