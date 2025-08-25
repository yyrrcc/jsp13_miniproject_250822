<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp" />   
<link rel="stylesheet" type="text/css" href="css/reservation.css">

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
	                            <a href="reservationUpdate.do?rnum=${res.rno}" class="btn-update">수정</a>
	                            <a href="reservationDelete.do?rnum=${res.rno}" class="btn-delete">취소</a>
	                        </c:if>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</section>

<jsp:include page="includes/footer.jsp" />