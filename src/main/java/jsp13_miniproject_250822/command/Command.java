package jsp13_miniproject_250822.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Command {
	public void execute(HttpServletRequest request, HttpServletResponse response);

}
