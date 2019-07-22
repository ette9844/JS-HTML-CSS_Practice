package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 요청 데이터 수신
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		// 응답 출력 스트립 얻기
		PrintWriter out = response.getWriter();
		
		// 1) JDBC 드라이버 로드
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		// 2) DB 연결
		String url = "jdbc:oracle:thin:@192.168.30.150:1521:xe";
		String user = "hyejin";
		String pw = "wow130";
		Connection conn = null; 
		ResultSet rs = null; 
		PreparedStatement pstmt = null;
		try {
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");
			
			// 3) SQL 구문 송신
			String selectSQL = "SELECT * FROM customer WHERE id=\'" + id + "\'";
			pstmt = conn.prepareStatement(selectSQL);

			// 4) SQL 결과 수신
			rs = pstmt.executeQuery(selectSQL);
			System.out.println(rs);
			
			// 5) 결과 확인
			response.setContentType("text/html;charset=utf-8"); // MIME 타입 지정 + 한글 인코딩 설정
			if(rs.next()) {
				if(pwd.equals(rs.getString("PWD"))){
					// 로그인 성공
					String str = "{\"status\":1, \"id\":\""+id+"\"}";
					out.print(str);
				} else {
					// 로그인 실패
					String str = "{\"status\":-1, \"id\":\""+id+"\"}";
					out.print(str);
				}
			} else {
				// id가 존재하지 않을 때
				String str = "{\"status\":-1, \"id\":\""+id+"\"}";
				out.print(str);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// 6) 연결 닫기
		try{
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}

}
