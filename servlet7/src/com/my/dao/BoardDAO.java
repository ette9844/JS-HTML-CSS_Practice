package com.my.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.my.exception.NotFoundException;
import com.my.vo.Board;
import com.my.vo.Customer;
import com.my.vo.Post;

public class BoardDAO {

	private String url = "jdbc:oracle:thin:@192.168.30.150:1521:xe";
	private String user = "hyejin";
	private String pw = "wow130";
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	public List<Board> select() throws NotFoundException {

		List<Board> list = new ArrayList<Board>();
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			//int startPage = (Integer.parseInt(page) - 1) * 10 + 1;
			//int endPage = (startPage + 1) * 10;
			String selectSQL = "SELECT a.*\r\n" + 
					"FROM\r\n" + 
					"    (SELECT rownum rn, level, board.*\r\n" + 
					"    FROM board\r\n" + 
					"    START WITH parent_no IS NULL\r\n" + 
					"    CONNECT BY PRIOR board_no = parent_no\r\n" + 
					"    ORDER SIBLINGS BY board_no DESC) a\r\n" + 
					"WHERE a.rn BETWEEN 1 AND 10";
					//"WHERE a.rn BETWEEN " + startPage + " AND " + endPage;
			pstmt = conn.prepareStatement(selectSQL);	// 

			// 4) SQL구문 처리 & 결과 수신
			rs = pstmt.executeQuery();
			System.out.println(rs);

			// 5) 결과 확인
			while (rs.next()) {
				int board_no = rs.getInt("board_no");
				int parent_no = rs.getInt("parent_no");
				int level = rs.getInt("level");
				String board_subject = rs.getString("board_subject");
				String board_writer = rs.getString("board_writer");
				String board_content = rs.getString("board_content");
				Date board_time = rs.getDate("board_time");
				String board_pwd = rs.getString("board_pwd");
				
				// 대입
				Board board = new Board(board_no, parent_no, level, 
						board_subject, board_writer, board_content, board_time, board_pwd);
				list.add(board);
			}
			if(list.size() == 0) {
				throw new NotFoundException("게시목록이 없습니다.");
			}
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
		return list;
		
	}
	
	public void closeConnection() {
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
