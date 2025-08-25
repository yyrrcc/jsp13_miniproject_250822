<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />   
<link rel="stylesheet" type="text/css" href="css/reservation.css">

	<section class="reservation-container">
	    <h2>예약하기</h2>
	    <form action="reservationAction.do" method="post" class="reservation-form">
	        <label for="name">이름</label>
	        <input type="text" id="name" name="name" required>
	
	        <label for="phone">전화번호</label>
	        <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" required>
	
			<label for="gender">성별</label>
	        <input type="radio" id="gender" name="gender" value="female" checked required>여성
	        <input type="radio" id="gender" name="gender" value="male" required>남성
	        
	        <label for="date">예약 날짜</label>
	        <input type="date" id="date" name="date" required>
	
	        <label for="time">예약 시간</label>
	        <input type="time" id="time" name="time" required>
	        
	        <label for="people">인원수</label>
	        <input type="number" id="people" name="people" required>
	
	        <label for="memo">요청사항</label>
	        <textarea id="memo" name="memo" rows="3" placeholder="추가 요청사항을 입력하세요"></textarea>
	
	        <button type="submit">예약하기</button>
	        <button type="reset">다시쓰기</button>
	    </form>
	</section>

<jsp:include page="includes/footer.jsp" />