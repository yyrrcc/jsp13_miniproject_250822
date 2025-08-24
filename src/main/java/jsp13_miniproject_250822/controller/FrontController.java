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
        BoardDto boardDto = null;
        MemberDao memberDao = new MemberDao(); 
        MemberDto memberDto = null;
        List<BoardDto> boardDtos = null;
        
        
        if (comm.equals("index.do")) {
        	viewpage = "index.jsp";
        } else if (comm.equals("login.do")) {
        	viewpage = "login.jsp";
        } else if (comm.equals("loginAction.do")) {
        	String loginId = request.getParameter("loginId");
        	String loginPw = request.getParameter("loginPw");
        	
        	int loginResult = memberDao.loginCheck(loginId, loginPw);
        	if (loginResult == 1) {
        		session = request.getSession();
        		session.setAttribute("sessionId", loginId);
        		viewpage = "index.do";
        	} else {
        	    request.setAttribute("loginErrorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
        		viewpage = "login.do";
        	}
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
        		request.setAttribute("successMsg", "회원가입 성공하셨습니다.");
        		viewpage = "login.do";
        	} else {
        		request.setAttribute("joinErrorMsg", "회원가입 실패하셨습니다.");
        		viewpage = "join.do";
        	}
        } else if (comm.equals("userEdit.do")) {
        	session = request.getSession();
        	String sid = (String) session.getAttribute("sessionId");
       	
        	if (sid == null) {
        		// 로그인 하지 않고 접속 했을 시
        		viewpage = "login.do?error=login_required";
        	} else {
        		memberDto = memberDao.memberInfo(sid);
        		request.setAttribute("m", memberDto);
        		viewpage = "userEdit.jsp";
        	}
        } else if (comm.equals("editAction.do")) {
        	String updateId = request.getParameter("updateId");
        	String updatePw = request.getParameter("updatePw");
        	String updateName = request.getParameter("updateName");
        	String updateEmail = request.getParameter("updateEmail");
        	int updateBirth = Integer.parseInt(request.getParameter("updateBirth"));
        	memberDto = new MemberDto(updateId, updatePw, updateName, updateEmail, updateBirth);
        	
        	int updateResult = memberDao.memberUpdate(memberDto);
        	
        	if (updateResult == 1) {
        		// **회원정보 수정 완료 표시 해줘야 할 것 같음
        		viewpage = "board.do";
        	} else {
        		// **회원정보 수정 실패 시 어떻게 해야할까
        		viewpage = "index.jsp";
        	}
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("board.do")) {
        	// 페이징 (변수 초기화, 페이지넘버, 페이지블록) + 검색 기능
        	int nowPage = 1;
        	int totalCount;
        	String searchType = request.getParameter("searchType");
        	String keyword = request.getParameter("keyword");
        	
            if (request.getParameter("page") != null) {
            	nowPage = Integer.parseInt(request.getParameter("page"));
            }
            
            if (searchType != null && keyword != null && !keyword.strip().isEmpty()) {
            	boardDtos = boardDao.getSearchBoardList(nowPage, searchType, keyword);
            	totalCount = boardDao.getSearchBoardCount(searchType, keyword);
            	request.setAttribute("searchType", searchType);
                request.setAttribute("keyword", keyword);
                request.setAttribute("isSearch", true);
            } else {
            	totalCount = boardDao.getBoardCount();
            	boardDtos = boardDao.getBoardList(nowPage);
            	request.setAttribute("isSearch", false);
            }
            	
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("boardDtos", boardDtos);
            
            int totalPage = (int) Math.ceil((double) totalCount / BoardDao.PAGESIZE);
            int startPage = (((nowPage - 1) / BoardDao.BLOCKSIZE) * BoardDao.BLOCKSIZE) + 1;
        	int endPage = startPage + BoardDao.BLOCKSIZE - 1;
        	if (endPage > totalPage) {
    			endPage = totalPage;
    		}
        	request.setAttribute("totalCount", totalCount);
        	request.setAttribute("totalPage", totalPage);
        	request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
            
        	viewpage = "board.jsp";
        } else if (comm.equals("boardView.do")) {
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	boardDao.updateHit(bnum);
        	boardDto = boardDao.boardView(bnum);
        	request.setAttribute("boardDto", boardDto);
        	viewpage = "boardView.jsp";
        } else if (comm.equals("boardWrite.do")) {
        	session = request.getSession();
        	String sid = (String) session.getAttribute("sessionId");
        	if (sid == null) {
            	request.setAttribute("WriteErrorMsg", "로그인 한 유저만 글쓰기 가능합니다.");
            	viewpage = "login.do";
        	} else {
        		viewpage = "boardWrite.jsp";
        	}
        } else if (comm.equals("boardWriteAction.do")) {
        	String writer = request.getParameter("writer");
        	String title = request.getParameter("title");
        	String content = request.getParameter("content");
        	int writeResult = boardDao.boardWrite(writer, title, content);
        	if (writeResult == 1) {
        		// **글 작성 성공 후 글 detail 확인하러 가기
        		viewpage = "board.do";
        	} else {
        		// **글 작성 실패
        		viewpage = "boardWrite.do";
        	}
        } else if (comm.equals("boardEdit.do")) {
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	boardDto = boardDao.boardView(bnum);
        	request.setAttribute("boardDto", boardDto);
        	viewpage = "boardEdit.jsp?bnum=" + bnum;
        } else if (comm.equals("boardEditAction.do")) {
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	String title = request.getParameter("title");
        	String content = request.getParameter("content");
        	boardDao.boardEdit(bnum, title, content);
        	viewpage = "boardView.do?bnum=" + bnum;
        } else if (comm.equals("boardDeleteAction.do")) {
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	boardDao.boardDelete(bnum);
        	request.setAttribute("deleteCompleteMsg", "삭제가 완료되었습니다.");
        	viewpage = "board.do";
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("logout.do")) {
        	session = request.getSession();
        	session.invalidate();
        	request.setAttribute("successMsg", "성공적으로 로그아웃 되었습니다.");
        	viewpage = "index.do";
        } else {
        	viewpage = "index.do";
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
        dispatcher.forward(request, response);
	
	}

}
