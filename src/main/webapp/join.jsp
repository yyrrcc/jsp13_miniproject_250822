<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/login.css">
  
	<section class="login">
	  <h2>회원가입</h2>
	  
	  <!-- 회원가입 실패 시 -->
	    <c:if test="${not empty joinErrorMsg }">
	    	<p style="text-align: center; color: red;">${joinErrorMsg}</p>
	    </c:if>
	  
	  <form action="joinAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="joinId" required>
	    
	    <label>비밀번호</label>
	    <input type="password" name="joinPw" required>
	    
	    <label>이름</label>
	    <input type="text" name="joinName" required>
	    
	    <label>이메일</label>
	    <input type="text" name="joinEmail" required>
	    
	    <label>생년월일</label>
	    <input type="text" name="joinBirth" placeholder="예:250822" required>
		<br>
	    <button type="submit">회원가입</button>
	  </form>
	 </section>

<jsp:include page="includes/footer.jsp" />