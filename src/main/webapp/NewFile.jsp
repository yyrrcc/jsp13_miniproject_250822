<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/board.css">
</head>
<body>

<section class="board">
  <h2>게시판</h2>
  
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
        <td>
          <a href="board_view.jsp?id=1">우리동네 좋은 약국</a>
          <span class="comment-count">(3)</span>
        </td>
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



</body>
</html>