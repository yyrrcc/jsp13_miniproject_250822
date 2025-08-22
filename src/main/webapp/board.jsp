<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/board.css">
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
  
	<section class="board">
	  <h2>게시판</h2>
	  
	  <!-- 로그인 완료한 회원 아이디 가져오고 싶음 -->
	  <%
	  	String sid = (String) session.getAttribute("sessionId");
	  %>
	  <p>${sessionId }님 환영합니다!</p>
	  
	  <form method="get" action="board.jsp" class="search-box">
	    <input type="text" name="keyword" placeholder="검색어 입력">
	    <button type="submit">검색</button>
	  </form>
	
	  <table>
	    <thead>
	      <tr>
	        <th>No</th>
	        <th>제목</th>
	        <th>작성자</th>
	        <th>날짜</th>
	        <th>조회수</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	        <td>1</td>
	        <td><a href="board_view.jsp">우리동네 좋은 약국</a></td>
	        <td>관리자</td>
	        <td>2025-08-22</td>
	        <td>15</td>
	      </tr>
	    </tbody>
	  </table>
	
	  <% if (session.getAttribute("sid") != null) { %>
	    <a href="board_write.jsp" class="btn">글쓰기</a>
	  <% } else { %>
	    <p>로그인해야 글을 작성할 수 있습니다.</p>
	  <% } %>
	</section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
</body>
</html>