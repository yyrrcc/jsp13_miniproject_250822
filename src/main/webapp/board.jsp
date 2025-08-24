<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
	  <c:if test="${not empty sessionScope.sessionId }">
	  	<p style="text-align: center;">${sessionScope.sessionId }님 환영합니다!</p>
	  </c:if>

	  <form method="get" action="board.do" class="search-box">
	  	<select name="searchType" class="">
	  		<option value="btitle" ${searchType == 'btitle' ? 'selected' : '' }>제목</option>
	  		<option value="bcontent" ${searchType == 'bcontent' ? 'selected' : '' }>내용</option>
	  		<option value="memberid" ${searchType == 'memberid' ? 'selected' : '' }>아이디</option>
	  	</select>
	    <input type="text" name="keyword" value="${keyword }" placeholder="검색어 입력">
	    <button type="submit">검색</button>
	  </form>
	
	  <table>
	    <thead>
	      <tr>
	        <th>No</th>
	        <th>제목</th>
	        <th>아이디</th>
	        <th>조회수</th>
	        <th>날짜</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:forEach items="${boardDtos }" var="b">
	          <tr>
		        <td>${b.rownum }</td>
		        <td><a href="boardView.do?bnum=${b.bnum }">${b.btitle }</a></td>
		        <td>${b.memberid }</td>
		        <td>${b.bhit }</td>
		        <td>${b.bdate }</td>
		      </tr>       
	      </c:forEach>
  
	    </tbody>
	  </table>

<!-- 결과값 찍어내기, 오류 확인용
<div style="border: 1px solid red; padding: 10px; margin: 10px;">
<p>totalCount: ${totalCount}</p>
<p>nowPage: ${nowPage}</p>
<p>totalPage: ${totalPage}</p>
<p>startPage: ${startPage}</p>
<p>endPage: ${endPage}</p>
<p>isSearch: ${isSearch}</p>
<p>searchType: ${searchType}</p>
<p>keyword: ${keyword}</p>
</div> -->
 
	  <!-- 페이지 그룹 -->
	  <div class="page-container">
		<c:if test="${nowPage > 1 }">
			<span class="pagebtn"><a href="board.do?page=1${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="pagebtn-link">︎&lt;&lt;</a></span>
		</c:if>
		<c:if test="${startPage > 1 }">
			<span class="pagebtn"><a href="board.do?page=${startPage - 1 }${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="pagebtn-link">︎&lt;</a></span>
		</c:if>
		
		  <c:forEach begin="${startPage }" end="${endPage }" var="p">
		  	<c:choose>
		  		<c:when test="${nowPage == p }">
		  			<span class="pagebtn"><a href="board.do?page=${p }${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="nowpagebtn-link">${p }</a></span>		  		
		  		</c:when>
		  		<c:otherwise>
		  			<span class="pagebtn"><a href="board.do?page=${p }${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="pagebtn-link">${p }</a></span>
		  		</c:otherwise>
		  	</c:choose>
		  </c:forEach>
		  
		<c:if test="${endPage < totalPage }">		
			<span class="pagebtn"><a href="board.do?page=${endPage + 1 }${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="pagebtn-link">︎&gt;</a></span>
		</c:if>
		<c:if test="${nowPage < totalPage }">
			<span class="pagebtn"><a href="board.do?page=${totalPage }${isSearch ? '&searchType='.concat(searchType).concat('&keyword=').concat(keyword) : ''}" class="pagebtn-link">︎&gt;&gt;</a></span>
		</c:if>

	  </div>
	  <br>
	  <!-- 글쓰기 버튼 -->
	  <div class="btnn"><a href="boardWrite.do" class="btn">글쓰기</a></div> 
	</section>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
  
  <!-- 자바스크립트 -->
	<script type="text/javascript">
	  // 삭제 완료 되었을 때
		<c:if test="${not empty deleteCompleteMsg}">
		    alert("${deleteCompleteMsg}");
		</c:if>	
	</script>

</body>
</html>