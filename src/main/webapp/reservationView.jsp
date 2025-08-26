<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약확인</title>
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
  
  
  
  	
	    <h2>예약 확인</h2>
	    <table class="reservation-table">
	        <thead>
	            <tr>
	                <th>예약번호</th>
	                <th>이름</th>
	                <th>전화번호</th>
	                <th>성별</th>
	                <th>예약 날짜</th>
	                <th>예약 시간</th>
	                <th>인원수</th>
	                <th>상태</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="res" items="${reservationList}">
	                <tr>
	                    <td>${res.rno}</td>
	                    <td>${res.membername}</td>
	                    <td>${res.phone}</td>
	                    <td>${res.gender}</td>
	                    <td>${res.reservDate}</td>
	                    <td>${res.reservTime}</td>
	                    <td>${res.people}</td>
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
	                            <a href="reservationUpdate.do?rno=${res.rno}" class="btn-update">수정</a>
	                            <a href="reservationDelete.do?rno=${res.rno}" class="btn-delete">취소</a>
	                        </c:if>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    
	    
  <footer>
    <p>(c) 2025 동네 병원·약국 안내 | Team JSP Mini Project</p>
  </footer>
  
  
</body>
</html>