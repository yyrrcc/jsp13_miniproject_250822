<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  <h2>로그인</h2>
	  <form action="loginAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="loginId" required>
	    
	    <label>비밀번호</label>
	    <input type="password" name="loginPw" required>
	    
	    <!-- 아이디 비밀번호 틀렸을 때 나오는 경고창 -->
	    
	    <button type="submit">로그인</button>
	  </form>
	</section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
</body>
</html>