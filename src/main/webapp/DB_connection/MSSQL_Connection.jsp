<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %> <!--  -->
    <!-- 
    	java.sql 패기지 내부의 모든 클래스를 가져온다.
    	
    	Connection객체 : 데이터베이스를 연결하는 객체
    	Statement 객체 : DB에 쿼리를 보내는 객체 (insert , update , delete)
    	PrepareStatement객체 : Statement를 개선해서 만든 객체 -> 값을 쉽게 처리
    	ResultSet객체 : 데이터베이스에서 select한 값을 가져오는 객체(select한 레코그 값을 담는 객체)
    	
    -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MS-SQL Connection</title>
</head>
<body>
	<h2>MS-SQL Connection</h2>
	
	<%
		Connection conn = null;		//Connection 객체 변수 초기화
		String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=myDB;encrypt=false";
		
		Boolean connect = false ;	// DB접속의 성공여부를 알려주는 변수
		
		try {
		Class.forName(driver);		// 해당 경로에 오라클드라이버클래스가 존재하지 확인
		
		conn = DriverManager.getConnection(url, "sa", "1234");
		
		connect = true;
		
		}catch (Exception e) {
			connect = false;
		}
	// conect 변수가 true이면 DB 접속성공 , false : DB 접속실패
	if ( connect == true) {
		out.println("MSSQL에  접속이 되었습니다.");
	}else {
		out.println("MSSQL에 접속 실패했습니다.");
	}
	
	%>

</body>
</html>