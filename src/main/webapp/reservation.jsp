<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약하기</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/reservation.css">
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


	
	<main class="reservation-container">
	    <h2>예약하기</h2>
	    <form action="reservationAction.do" method="post" class="reservation-form">
	        <label for="name">이름</label>
	        <input type="text" id="name" name="name" required>
	
	        <label for="phone">전화번호</label>
	        <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" required>
	
	        <label for="date">예약 날짜</label>
	        <input type="date" id="date" name="date" required>
	
	        <label for="time">예약 시간</label>
	        <input type="time" id="time" name="time" required>
	
	        <label for="memo">요청사항</label>
	        <textarea id="memo" name="memo" rows="3" placeholder="추가 요청사항을 입력하세요"></textarea>
	
	        <button type="submit">예약하기</button>
	        <button type="reset">다시쓰기</button>
	    </form>
	
	    <h2>예약 확인</h2>
	    <table class="reservation-table">
	        <thead>
	            <tr>
	                <th>예약번호</th>
	                <th>이름</th>
	                <th>전화번호</th>
	                <th>예약 날짜</th>
	                <th>예약 시간</th>
	                <th>상태</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="res" items="${reservationList}">
	                <tr>
	                    <td>${res.rnum}</td>
	                    <td>${res.name}</td>
	                    <td>${res.phone}</td>
	                    <td>${res.date}</td>
	                    <td>${res.time}</td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${res.date lt today}">
	                                만료됨
	                            </c:when>
	                            <c:otherwise>
	                                예약중
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	                    <td>
	                        <c:if test="${res.date ge today}">
	                            <a href="reservationUpdate.do?rnum=${res.rnum}" class="btn-update">수정</a>
	                            <a href="reservationDelete.do?rnum=${res.rnum}" class="btn-delete">취소</a>
	                        </c:if>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</main>

  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>

</body>
</html>