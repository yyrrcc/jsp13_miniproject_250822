<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/boardWrite.css">

	<section class="board-write">
		<h2>글쓰기</h2>
		
		<div>
			<c:if test="${not empty boardwriteErrorMsg }">
				<p style="text-align: center; color: red;">${boardwriteErrorMsg}</p>
			</c:if>
		</div>
		
		<form action="boardWriteAction.do" method="post">
		    <div class="form-group">
		      <label>작성자</label>
		      <input type="text" name="writer" value="${sessionScope.sessionId }" readonly>
		    </div>
		    
		    <div class="form-group">
		      <label>제목</label>
		      <input type="text" name="title" required>
		    </div>
		    
		    <div class="form-group">
		      <label>내용</label>
		      <textarea name="content" rows="10" required></textarea>
		    </div>
		    
		    <div class="form-group">
		      <label>파일첨부</label>
		      <input type="file" name="attachedfile">
		    </div>
		    
		    <div class="btn-group">
		      <button type="submit">작성완료</button>
		      <button type="reset">다시쓰기</button>
		      <a href="board.do?page=${param.page }" class="btn">목록으로</a>
		    </div>
		</form>
	</section>

<jsp:include page="includes/footer.jsp" />