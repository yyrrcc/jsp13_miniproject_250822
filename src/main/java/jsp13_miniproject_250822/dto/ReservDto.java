package jsp13_miniproject_250822.dto;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;

public class ReservDto {
    private int rno;          // 예약 번호
    private String memberid;    // 유저 아이디
    private String membername;      // 예약자 이름
    private String phone;     // 전화번호
    private String gender;     // 성별
    private Date reservDate;  // 예약 날짜
    private Time reservTime;  // 예약 시간
    private int people;       // 인원수
    private String request;   // 요청사항
    private LocalDateTime regdate; // 등록일

}
