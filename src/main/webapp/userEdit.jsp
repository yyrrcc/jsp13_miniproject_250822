<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />
<link rel="stylesheet" href="css/login.css">

	<section class="login">
	  <h2>회원 정보 수정</h2>
	  <form action="userEditAction.do" method="post">
	    <label>아이디</label>
	    <input type="text" name="updateId" value="${m.memberid }" readonly>
	    
	    <label>변경 할 비밀번호</label>
	    <input type="password" name="updatePw" value="${m.memberpw }" required>
	    
	    <label>이름</label>
	    <input type="text" name="updateName" value="${m.membername }" required>
	    
	    <label>이메일</label>
	    <input type="text" name="updateEmail" value="${m.memberemail }" required>
	    
	    <label>생년월일</label>
	    <input type="text" name="updateBirth" value="${m.memberbirth }" placeholder="예:250822" required>
		<br>
   	
	    <button type="submit">수정하기</button>
	  </form>
	</section>

<jsp:include page="includes/footer.jsp" />
  
	  <!-- 자바스크립트 -->
	  <script type="text/javascript">
	  // 회원정보 수정 관련
	    <c:choose>
	        <c:when test="${param.msg == 'success'}">
	            alert("정상적으로 수정되었습니다.");
	        </c:when>
	        <c:when test="${param.msg == 'error'}">
	            alert("수정되지 않았습니다.");
	        </c:when>
	    </c:choose>
	  </script>