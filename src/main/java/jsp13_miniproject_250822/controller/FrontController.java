package jsp13_miniproject_250822.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jsp13_miniproject_250822.dao.BoardDao;
import jsp13_miniproject_250822.dao.MemberDao;
import jsp13_miniproject_250822.dto.BoardDto;
import jsp13_miniproject_250822.dto.MemberDto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FrontController() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	public void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
        String uri = request.getRequestURI();
        String comm = uri.substring(uri.lastIndexOf('/') + 1);
        
        HttpSession session = null;
        String viewpage = null;
        BoardDao boardDao = new BoardDao();
        MemberDao memberDao = new MemberDao(); 
        MemberDto memberDto = null;
        List<BoardDto> boardDtos = new ArrayList<>();
        
        
        if (comm.equals("index.do")) {
        	viewpage = "index.jsp";
        } else if (comm.equals("login.do")) {
        	viewpage = "login.jsp";
        } else if (comm.equals("loginAction.do")) {
        	String loginId = request.getParameter("loginId");
        	String loginPw = request.getParameter("loginPw");
        	
        	int loginResult = memberDao.loginCheck(loginId, loginPw);
        	if (loginResult == 1) {
        		// **로그인 성공하면 어디로 갈까?
        		session = request.getSession();
        		session.setAttribute("sessionId", loginId);
        		viewpage = "board.do";
        	} else {
        		// **로그인 실패하면 실패 메시지 뜨고 다시 로그인 페이지로
        		viewpage = "index.do";
        	}
        	//viewpage = "board.do";
        } else if (comm.equals("join.do")) {
        	viewpage = "join.jsp";
        } else if (comm.equals("joinAction.do")) {
        	String joinId = request.getParameter("joinId");
        	String joinPw = request.getParameter("joinPw");
        	String joinName = request.getParameter("joinName");
        	String joinEmail = request.getParameter("joinEmail");
        	int joinBirth = Integer.parseInt(request.getParameter("joinBirth"));
        	
        	memberDto = new MemberDto(joinId, joinPw, joinName, joinEmail, joinBirth);
        	
        	int joinResult = memberDao.memberJoin(memberDto);
        	if (joinResult == 1) {
        		// ** 회원가입 성공 + 성공했습니다 메세지
        		viewpage = "login.do";
        	} else {
        		// 회원가입 실패 + 이전 페이지로
        		viewpage = "join.do";
        	}
        } else if (comm.equals("userEdit.do")) {
        	// 회원정보 수정
        	// 로그인 중이어야 함, 기존 정보가 보여야 함
        	session = request.getSession();
        	String sid = (String) session.getAttribute("sessionId");
       	
        	if (sid == null) {
        		// ** 로그인 중이 아닙니다 메세지
        		viewpage = "join.do";
        	} else {
        		// 로그인 중, 회원가입 정보 가져와야 함
        		memberDto = memberDao.memberInfo(sid);
        		request.setAttribute("m", memberDto);
        	}
        	viewpage = "userEdit.jsp";
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("board.do")) {
        	viewpage = "board.jsp";
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("logout.do")) {
        	session = request.getSession();
        	session.invalidate();
        	// ****로그아웃 되었습니다 메세지 띄우기
        	viewpage = "index.do";
        } else {
        	viewpage = "index.do";
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
        dispatcher.forward(request, response);
	
	}

}
