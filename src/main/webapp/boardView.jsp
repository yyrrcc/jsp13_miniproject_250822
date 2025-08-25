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
<link rel="stylesheet" href="css/boardReply.css">

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
	    <!-- param.page 부분 헷갈리지 말기! -->
	    <a href="board.do?page=${param.page }${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="btn">목록으로</a>
	    <!-- 권한 있는 사람만 수정, 삭제 가능 / 그 외 사람에겐 버튼 안 보이게 하기 -->
	    <c:if test="${sessionId == boardDto.memberid || sessionId == 'admin' }">
		    <a href="boardEdit.do?page=${param.page }&bnum=${boardDto.bnum}${not empty param.searchType ? '&searchType='.concat(param.searchType) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}" class="btn">수정</a>
			<a href="#" class="btn delete" onclick="deleteBoard(${boardDto.bnum})">삭제</a>
	    </c:if>
	    </div>
	</section>
	
	
	<!-- 댓글 영역 -->
	<section class="reply">
		<h3>댓글 (${replyCount })</h3>
	    
	    <div class="reply-list">
	    
	    
	    <div class="reply-item">
	      <p><strong>수정삭제버튼구현하기</strong> | 2025-08-22 15:00</p>
	      <p>저도 이 약국 자주 갑니다. 친절해요!</p>
	      <% if("홍길동".equals(session.getAttribute("sid"))) { %>
	        <a href="replyDeleteAction.jsp?rid=1" class="reply-delete">삭제</a>
	      <% } %>
	    </div>
    
		<c:forEach items="${replyDtos }" var="r">
			<div class="reply-item">
				<p><strong>${r.memberid }</strong> | ${r.rdate }</p>
				<p>${r.rcontent }</p>
			</div>       
		</c:forEach>
		</div>
	  
	<!-- form action **************************** -->
    <form action="replyWriteAction.do?page=${param.page }&bnum=${boardDto.bnum}" method="post" class="reply-form">
    	<c:choose>
	    	<c:when test="${not empty sessionScope.sessionId }">
	    		<label>ㅇㅇㅇ님 댓글을 달아보세요</label>
		    	<p><input type="text" name="writer" value="${sessionScope.sessionId }" readonly></p>
				<textarea name="content" rows="3" placeholder="댓글을 입력하세요..." required></textarea>
	    		<button type="submit">댓글 등록</button>
	    	</c:when>
	    	<c:otherwise>
	    		<textarea name="content" rows="3" placeholder="로그인 후 작성할 수 있습니다." required></textarea>
	    	</c:otherwise>
    	</c:choose>
    </form>
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