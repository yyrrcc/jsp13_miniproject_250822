<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/login.css">
<!-- *** css -->
</head>
<body>
  <header>
    <h1><a href="index.do">🏥 동네 병원·약국 안내</a></h1>
    <nav>
      <ul>
        <li><a href="index.do">홈</a></li>
        <li><a href="login.do">로그인</a></li>
        <li><a href="join.do">회원가입</a></li>
        <li><a href="board.do">자유게시판</a></li>
        <li><a href="#">문의사항</a></li>
        <li><a href="userEdit.do">회원정보수정</a></li>
        <li><a href="logout.do">로그아웃</a></li>
      </ul>
    </nav>
  </header>
  
	<section class="login">
	  <h2>회원 정보 수정</h2>
	  <form action="editAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="updateId" value="${m.memberid }" readonly>
	    
	    <label>변경 할 비밀번호</label>
	    <input type="password" name="updatePw" value="${m.memberpw }" required>
	    
	    <label>이름</label>
	    <input type="text" name="updateName" value="${m.membername }" required>
	    
	    <label>이메일</label>
	    <input type="text" name="updateEmail" value="${m.memberemail }" required>
	    
	    <label>생년월일</label>
	    <input type="text" name="updateBirth" value="${m.memberbirth }" required>
		<br>
	    <button type="submit">수정하기</button>
	  </form>
	</section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
</body>
</html>