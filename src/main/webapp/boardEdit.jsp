<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/boardWrite.css">

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
	
<jsp:include page="includes/footer.jsp" />