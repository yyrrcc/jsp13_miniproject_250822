<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정하기</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/boardWrite.css">
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
  
	<section class="board-write">
		<h2>글 수정하기</h2>
		
		<form action="boardEditAction.do?page=${param.page }&bnum=${boardDto.bnum }${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" method="post">
		    <div class="form-group">
		      <label>작성자</label>
		      <input type="text" name="writer" value="${boardDto.memberid }" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>조회수</label>
		      <input type="text" name="hit" value="${boardDto.bhit }" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>작성시간</label>
		      <input type="text" name="date" value="${boardDto.bdate }" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>제목</label>
		      <input type="text" name="title" value="${boardDto.btitle }" required>
		    </div>
		    
		    <div class="form-group">
		      <label>내용</label>
		      <textarea name="content" rows="10" required>${boardDto.bcontent }</textarea>
		    </div>
		    
		    <div class="form-group">
		      <label>파일첨부</label>
		      <input type="file" name="attachedfile">
		    </div>
		    
		    <div class="btn-group">
		      <button type="submit">수정하기</button>
		      <button type="reset">원상복구</button>
		      <a href="board.do?page=${param.page }${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="btn">목록으로</a>
		    </div>
		</form>
	</section>

	<footer>
    	<p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
	</footer>
</body>
</html>