<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/boardView.css">
<link rel="stylesheet" href="css/boardReply.css">

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
	<!-- *****댓글을 쓰고 난 후 목록 이동이 이상함! -->
	<section class="reply">
		<h3>댓글 (${replyCount })</h3>
	    
	    <div class="reply-list"> 
			<c:forEach items="${replyDtos }" var="r">
				<div class="reply-item">
					<p><strong>${r.memberid }</strong> | ${r.rdate }</p>
					<p>${r.rcontent }</p>
					<!-- *******이것도 권한 있는 사람만 삭제 할 수 있게 해줘야 함 -->
					<a href="#" class="reply-delete" onclick="deleteReply(${r.rid},${param.bnum },${param.page})">삭제</a>
				</div>       
			</c:forEach>
		</div>
	  
	<!-- form action ******* -->
    <form action="replyWriteAction.do?page=${param.page }&bnum=${boardDto.bnum}" method="post" class="reply-form">
    	<c:choose>
	    	<c:when test="${not empty sessionScope.sessionId }">
	    		<label>${sessionScope.sessionId }님 댓글을 달아보세요</label>
		    	<p><input type="hidden" name="writer" value="${sessionScope.sessionId }" readonly></p>
				<textarea name="content" rows="3" placeholder="댓글을 입력하세요..." required></textarea>
	    		<button type="submit">댓글 등록</button>
	    	</c:when>
	    	<c:otherwise>
	    		<textarea name="content" rows="3" placeholder="로그인 후 작성할 수 있습니다." required></textarea>
	    	</c:otherwise>
    	</c:choose>
    </form>
	</section>	
	
<jsp:include page="includes/footer.jsp" />
	
	<!-- 자바스크립트 -->
	<script type="text/javascript">
		// 글 삭제 버튼 눌렀을 때
		function deleteBoard (bnum) {
	    	if (confirm("정말로 글을 삭제하시겠습니까?")) {
	        	location.href = "boardDeleteAction.do?bnum=" + bnum;
	        	}
	    	}
		
		// 댓글 삭제 버튼 눌렀을 때
		function deleteReply (rid, bnum, page) {
	    	if (confirm("정말로 댓글을 삭제하시겠습니까?")) {
	        	location.href = "replyDeleteAction.do?page=" + page + "&bnum=" + bnum + "&rid=" + rid;
	        	}
	    	}
	</script>