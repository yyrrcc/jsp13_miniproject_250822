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
import jsp13_miniproject_250822.dao.ReplyDao;
import jsp13_miniproject_250822.dto.BoardDto;
import jsp13_miniproject_250822.dto.MemberDto;
import jsp13_miniproject_250822.dto.ReplyDto;

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
        ReplyDto replyDto = null;
        ReplyDao replyDao = new ReplyDao();
        List<ReplyDto> replyDtos = null;
        
        
        // 회원
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
        } else if (comm.equals("userEditAction.do")) {
        	String updateId = request.getParameter("updateId");
        	String updatePw = request.getParameter("updatePw");
        	String updateName = request.getParameter("updateName");
        	String updateEmail = request.getParameter("updateEmail");
        	int updateBirth = Integer.parseInt(request.getParameter("updateBirth"));
        	memberDto = new MemberDto(updateId, updatePw, updateName, updateEmail, updateBirth);
        	
        	int updateResult = memberDao.memberUpdate(memberDto);
        	
        	if (updateResult == 1) {
        		response.sendRedirect("userEdit.do?msg=success");
        		return; // 리턴도 꼭 해줘야 함!
        	} else {
        		response.sendRedirect("userEdit.do?msg=error");
        		return;
        	}
        } 
        
        
        // 게시판
        else if (comm.equals("board.do")) {
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
        	replyDtos = replyDao.getReplyList(bnum); // 댓글
        	int replyCount = replyDao.getReplyCount(bnum);
        	request.setAttribute("replyCount", replyCount);
        	request.setAttribute("replyDtos", replyDtos);
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
        		response.sendRedirect("board.do");
        		return; // 리턴도 꼭 해줘야 함!
        	} else {
        		request.setAttribute("boardwriteErrorMsg", "글 등록에 실패하셨습니다");
        		int page = Integer.parseInt(request.getParameter("page"));
        		viewpage = "boardWrite.do?page=" + page;
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
        } 
        
        
        
        // 댓글
        else if (comm.equals("replyWriteAction.do")) {
        	int page = Integer.parseInt(request.getParameter("page"));
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	String writer = request.getParameter("writer");
        	String content = request.getParameter("content");
        	int replyResult = replyDao.insertReply(bnum, writer, content);
        	if (replyResult == 1) {
        		// 댓글 성공
        		response.sendRedirect("boardView.do?page=" + page + "&bnum=" + bnum);
        		return;
        	} else {
        		// 댓글 실패
        		viewpage = "index.do";
        	}
        } else if (comm.equals("replyDeleteAction.do")) {
        	int rid = Integer.parseInt(request.getParameter("rid"));
        	int page = Integer.parseInt(request.getParameter("page"));
        	int bnum = Integer.parseInt(request.getParameter("bnum"));
        	replyDao.deleteReply(rid);
    		response.sendRedirect("boardView.do?page=" + page + "&bnum=" + bnum);
    		return;
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } 
        
        // 예약
        else if (comm.equals("reservation.do")) {
        	viewpage = "reservation.jsp";
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        } else if (comm.equals("")) {
        	
        }
        
        
        // 로그아웃
        else if (comm.equals("logout.do")) {
        	session = request.getSession();
        	String sid = (String) session.getAttribute("sessionId");
        	if (sid != null) {
	        	session.invalidate();
	        	request.setAttribute("successMsg", "성공적으로 로그아웃 되었습니다.");
	        	viewpage = "index.do";
        	} else {
        		// ********** 로그인 했을 때 보이거나
        		request.setAttribute("logoutErrorMsg", "로그인 하지 않았습니다.");
        		viewpage = "login.do";
        	}
        } else {
        	viewpage = "index.do";
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(viewpage);
        dispatcher.forward(request, response);
	
	}

}
