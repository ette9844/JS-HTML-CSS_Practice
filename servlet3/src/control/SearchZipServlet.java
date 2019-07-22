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
 * Servlet implementation class SearchZipServlet
 */
public class SearchZipServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchZipServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청 데이터 수신
		String doro = request.getParameter("doro");
		System.out.println(doro);
		
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
			String selectSQL = "SELECT buildingno, zipcode, "
					+ "sido|| \' \' "
					+ "|| sigungu || NVL2(sigungu,\' \', \'\')"
					+ "|| eupmyun || NVL2(eupmyun,\' \', \'\')"
					+ "|| doro ||\' \' "
					+ "|| building1"
					+ "|| DECODE(building2,\'0\', \'\', \'-\'||building2) ||\' \'"
					+ "|| \'(\'|| dong || ri || DECODE(building, \'\', \'\', \',\' ||building) ||\')\'"
					+ "AS addr1, "
					+ "sido ||\' \' "
					+ "|| sigungu ||NVL2(sigungu,\' \', \'\')"
					+ "|| eupmyun ||NVL2(eupmyun,\' \', \'\')"
					+ "|| dong || ri ||\' \' "
					+ "|| zibun1 || DECODE(zibun2, \'0\', \'\',  \'-\'|| zibun2)"
					+ "|| DECODE(building, \'\', \'\', \' (\' ||building ||\')\') "
					+ "AS addr2 "
					+ "FROM post "
					+ "WHERE (doro || \' \' || building1 || DECODE(building2,\'0\', \'\', \'-\'||building2)) LIKE \'%"+doro+"%\'";
			// ? 연산자 앞 뒤에 %등의 wildcard 연산자를 사용하면 안된다
			pstmt = conn.prepareStatement(selectSQL);
			//pstmt.setString(1, "%"+doro+"%");
			
			// 4) SQL 결과 수신
			rs = pstmt.executeQuery();

			// 5) 결과 확인
			response.setContentType("text/html;charset=utf-8"); // MIME 타입 지정 + 한글 인코딩 설정
			// 응답 출력 스트립 얻기, 출력 형식을 정해준 다음 호출해야 적용됨
			PrintWriter out = response.getWriter();

			// 응답 생성
			String str = "";
			int cnt = 0;
			
			while(rs.next()) {
				// 도로명 주소가 존재할 때
				String zipcode = rs.getString("zipcode");
				String addr1 = rs.getString("addr1");
				String addr2 = rs.getString("addr2");
				String buildingno = rs.getString("buildingno");
				
				if(cnt != 0)
					str += ", ";
				else		// 배열 열림
					str += "[";
				str += "{\"zipcode\":\"" + zipcode
						+ "\", \"addr1\":\"" + addr1 
						+ "\", \"addr2\":\"" + addr2 
						+ "\", \"buildingno\":\"" + buildingno + "\"}";
				cnt++;
			}
			if(cnt != 0)	// 배열 닫힘
				str += "]";
			out.print(str);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// 6) 연결 닫기
		try {
			if (rs != null)
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
