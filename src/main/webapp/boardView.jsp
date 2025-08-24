<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/boardView.css">
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
  
	<section class="board-view">
  	<h2>글 상세보기</h2>
  
	  <div class="view-group">
	    <label>제목</label>
	    <p>${boardDto.btitle }</p>
	  </div>
	
	  <div class="view-group">
	    <label>작성자</label>
	    <p>${boardDto.memberid }</p>
	  </div>
	
	  <div class="view-group">
	    <label>작성시간</label>
	    <p>${boardDto.bdate }</p>
	  </div>
	
	  <div class="view-group">
	    <label>조회수</label>
	    <p>${boardDto.bhit }</p>
	  </div>
	
	  <div class="view-group">
	    <label>내용</label>
	    <p>${boardDto.bcontent }</p>
	  </div>
	
	  <div class="btn-group">
	    <a href="board.do" class="btn">목록으로</a>
	    <a href="boardEdit.do?bnum=${boardDto.bnum}" class="btn">수정</a>
		<a href="#" class="btn delete" onclick="deleteBoard(${boardDto.bnum})">삭제</a>
	  </div>
	</section>
	
	<footer>
    	<p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
	</footer>
	
	<!-- 자바스크립트 -->
	<script type="text/javascript">
	  // 글 삭제 버튼 눌렀을 때
		function deleteBoard(bnum) {
	    	if (confirm("정말로 글을 삭제하시겠습니까?")) {
	        	location.href = "boardDeleteAction.do?bnum=" + bnum;
	    	}
		}
	</script>

</body>
</html>