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
	
	public int count() throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT COUNT(*) FROM board";
			pstmt = conn.prepareStatement(selectSQL);

			// 4) SQL구문 실행
			rs = pstmt.executeQuery();
			
			// 5) 결과 확인
			// count는 테이블이 없을 경우 바로 exception을 날리기 때문에  rs.next()를 체크해줄 필요가 없다
			// 행이 없을 경우에는 0 반환
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}
	
	public List<Board> select(int startRow, int endRow) throws NotFoundException {

		List<Board> list = new ArrayList<Board>();
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT a.*\r\n" + 
					"FROM\r\n" + 
					"    (SELECT rownum rn, level, board.*\r\n" + 
					"    FROM board\r\n" + 
					"    START WITH parent_no IS NULL\r\n" + 
					"    CONNECT BY PRIOR board_no = parent_no\r\n" + 
					"    ORDER SIBLINGS BY board_no DESC) a\r\n" + 
					"WHERE a.rn BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();	// 실행

			// 4) SQL구문 처리 & 결과 수신
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
	
	public Board selectByBoardNo(int no) throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("connection 성공");

			// 3) SQL 구문 송신
			String selectSQL = "SELECT * FROM board WHERE board_no = ?";
			pstmt = conn.prepareStatement(selectSQL);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();	// 실행

			// 4) 결과 확인
			if (rs.next()) {
				int board_no = rs.getInt("board_no");
				int parent_no = rs.getInt("parent_no");
				String board_subject = rs.getString("board_subject");
				String board_writer = rs.getString("board_writer");
				String board_content = rs.getString("board_content");
				Date board_time = rs.getDate("board_time");
				
				// 대입
				Board board = new Board(board_no, parent_no, 
						board_subject, board_writer, board_content, board_time);
				return board;
			}
			throw new NotFoundException("게시목록이 없습니다.");
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}
	
	public void closeConnection() {
		// 5) 연결 닫기
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
