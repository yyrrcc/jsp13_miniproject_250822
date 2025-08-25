<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/login.css">

	<section class="login">
	  <h2>로그인</h2>
	  <form action="loginAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="loginId" required>
	    
	    <label>비밀번호</label>
	    <input type="password" name="loginPw" required>
	    
	    <!-- 아이디 비밀번호 틀렸을 때 -->
	   	<c:if test="${not empty loginErrorMsg }">
	   		<p style="text-align: center; color: red;">${loginErrorMsg}</p>
	   	</c:if>

	    <button type="submit">로그인</button>
	  </form>
	  
	  <div class="joinorsearch"><span><a href="join.do">회원가입</a> | <a href="#">비밀번호 찾기</a></span></div>
	</section>

<jsp:include page="includes/footer.jsp" />
  
  <!-- 자바스크립트 -->
  <script type="text/javascript">
  // 회원 가입 성공 시
	<c:if test="${not empty successMsg }">
		alert("${successMsg }");
	</c:if>
  // 로그인 하지 않은 채 정보 수정 하려 할 때
	<c:if test="${param.error == 'login_required'}">
	alert("로그인 후 접속할 수 있습니다.");
	</c:if>
  // 로그인 하지 않은 유저가 글쓰기 시도 할 때
	<c:if test="${not empty WriteErrorMsg}">
	    alert("${WriteErrorMsg}");
	</c:if>	
  // 로그인 하지 않은 유저가 로그아웃 할 때
	<c:if test="${not empty logoutErrorMsg}">
	    alert("${logoutErrorMsg}");
	</c:if>		
  </script>