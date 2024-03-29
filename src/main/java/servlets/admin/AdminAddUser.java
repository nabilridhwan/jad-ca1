package servlets.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import models.UserModel;
import utils.DatabaseConnection;
import utils.Util;

/**
 * Servlet implementation class AdminAddUser
 */
@WebServlet("/admin_add_user")
public class AdminAddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminAddUser() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		Util.forceAdmin(session, response);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/add_user.jsp");

		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirm_password");

		String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");

		String address_1 = request.getParameter("address_1") == null ? "" : request.getParameter("address_1");
		String address_2 = request.getParameter("address_2") == null ? "" : request.getParameter("address_2");
		String apt_suite = request.getParameter("apt_suite") == null ? "" : request.getParameter("apt_suite");
		String postal_code = request.getParameter("postal_code") == null ? "" : request.getParameter("postal_code");

		System.out.println(password);
		System.out.println(confirmPassword);

		if (!password.equals(confirmPassword)) {
			// Set the attribute of error to invalid_credentials
			request.setAttribute("error", "password_match");

			// Dispatch
			dispatcher.forward(request, response);
			return;
		}

		DatabaseConnection connection = new DatabaseConnection();

		// Hash the password using BCrypt
		password = BCrypt.hashpw(password, BCrypt.gensalt());

		int rowsAffected = UserModel
				.insertNewUser(name, email, password, address_1, address_2, apt_suite, postal_code, phone)
				.update(connection);

		connection.close();

		// Check if the user is inserted
		if (rowsAffected > 0) {
			response.sendRedirect("/CA1-Preparation/views/admin/all_users.jsp");
			return;

		} else if (rowsAffected == -1) {
			System.out.println("SQL Error has occured");
			// e.printStackTrace();

			// Set the attribute of error to invalid_credentials
			request.setAttribute("error", "user_exists");

			// Dispatch
			dispatcher.forward(request, response);
		}
	}

}
