package com.my.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.my.exception.NotFoundException;

public class PostDAO {

	private String url = "jdbc:oracle:thin:@192.168.30.150:1521:xe";
	private String user = "hyejin";
	private String pw = "wow130";
	private Connection conn = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;

	public Map<String, String> selectByDoro(String doro) throws NotFoundException {
		try {
			// 1) JDBC 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2) DB 연결
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
			
			pstmt = conn.prepareStatement(selectSQL);

			// 4) SQL 결과 수신
			rs = pstmt.executeQuery();

			// 5) 결과 확인
			// 리턴값 대입
			Map<String, String> postMap = new HashMap<String, String>();
			while (rs.next()) {
				String zipcode = rs.getString("zipcode");
				String addr1 = rs.getString("addr1");
				String addr2 = rs.getString("addr2");
				String buildingno = rs.getString("buildingno");
				
				postMap.put(buildingno, zipcode + "/" + addr1 + "/" + addr2);
			}
			return postMap;
		} catch (Exception e) {
			// 사용자 정의 Exception 강제 발생
			throw new NotFoundException(e.getMessage());
		} finally {
			closeConnection();
		}
	}

	private void closeConnection() {
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
