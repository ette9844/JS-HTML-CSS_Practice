package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JoinServlet
 */
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinServlet() {
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
		String name = request.getParameter("name");
		String addr2 = request.getParameter("addr2");
		String buildingno = request.getParameter("buildingno");
		System.out.println(id + pwd + name + addr2 + buildingno);
		
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
			String selectSQL = "INSERT INTO customer "
					+ "VALUES(\'"+id+"\', \'"+pwd+"\', \'"+name+"\', \'"+addr2+"\', \'"+buildingno+"\')";
			pstmt = conn.prepareStatement(selectSQL);
				
			// 4) SQL 결과 수신
			rs = pstmt.executeQuery();
			System.out.println(rs);

			// 5) 결과 확인
			response.setContentType("text/html;charset=utf-8"); // MIME 타입 지정 + 한글 인코딩 설정
			// 응답 출력 스트립 얻기, 출력 형식을 정해준 다음 호출해야 적용됨
			PrintWriter out = response.getWriter();
			// 응답 생성
			if(rs.next()) {
				// 가입 성공
				String str = "{\"status\":1}";
				out.print(str);
			} else {
				// 가입 실패
				String str = "{\"status\":-1}";
				out.print(str);
			}					
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 6) 연결 닫기
		try {
			if(rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
