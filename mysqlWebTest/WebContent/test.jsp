<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
	<h3>Hello.jsp</h3>

	<%
		// 1. 환경변수
		String driver = "com.mysql.jdbc.Driver";
		//String url = "jdbc:oracle:thin:@192.168.0.206:1521:orcl";  => 오라클 연결할때
		String url = "jdbc:mysql://192.168.0.206:3306/testdb";
		String user = "scott";
		String password = "tiger";

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		Connection conn = null;

		try {
			// 2. 드라이버 로딩
			Class.forName(driver);

			// 3. Connection
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("접속 실패");
			e.printStackTrace();
		}

		// 4. sql 문
		sb.append("select * from dept");

		try {
			// 5. 문장객체
			pstmt = conn.prepareStatement(sb.toString());

			// 6. 실행
			rs = pstmt.executeQuery();

			// 7. 레코드별 로직 처리
			while (rs.next()) {
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				String loc = rs.getString("loc");
				out.println("<h3>" + deptno + " : " + dname + " : " + loc + "</h3>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				// 8. 자원반납
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	%>

</body>
</html>