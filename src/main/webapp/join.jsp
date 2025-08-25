<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/login.css">
<!-- *회원가입 css -->
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
	  <h2>회원가입</h2>
	  
	  <!-- 회원가입 실패 시 -->
	    <c:if test="${not empty joinErrorMsg }">
	    	<p style="text-align: center; color: red;">${joinErrorMsg}</p>
	    </c:if>
	  
	  <form action="joinAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="joinId" required>
	    
	    <label>비밀번호</label>
	    <input type="password" name="joinPw" required>
	    
	    <label>이름</label>
	    <input type="text" name="joinName" required>
	    
	    <label>이메일</label>
	    <input type="text" name="joinEmail" required>
	    
	    <label>생년월일</label>
	    <input type="text" name="joinBirth" placeholder="예:250822" required>
		<br>
	    <button type="submit">회원가입</button>
	  </form>
	 </section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
</body>
</html>