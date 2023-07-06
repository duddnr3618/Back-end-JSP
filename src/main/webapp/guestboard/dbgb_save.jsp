<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 
	dbgb_wirte.html -> 에서 form에서 넘어오는 값을 받아서 데이터베이스에 저장하는 파일
-->

 <!--  -->
 <%@ page import = "java.sql.*,java.util.*" %>
 

 <!-- 클라이언트에서 넘어온 한글이 깨지지 않도록 처리 -->
 <% request.setCharacterEncoding("UTF-8"); %>
 
 <!-- dbgb_writh.html 폼에서 넘어오는 변수의 값을 받아서 새로운 변수에 할당
 	
 	request : 클라이언트 정보를 서버에서 읽어오는 객체 (JSP의 내장 객체)
 	response : 서버의 정보를 클라이언트에게 보내는 객체 (JSP의 내장객체)
 	
  -->
 
 <%
 	String na = request.getParameter("name");
 	String em = request.getParameter("email");
 	String sub = request.getParameter("subject");
 	String cont = request.getParameter("content");
 	String ymd = (new java.util.Date()).toLocaleString();	// 현재 시스템의 날짜를 생성해서 string으로 변환	
 
 %>
 
 
	<!-- 오라클 DB연결 -->
 <%@ include file = "../DB_connection/DB_conn_oracle.jsp" %>
 
 <%
	/*//DB에 연결 객체 생성 --> 오라클 DB연결
		Connection conn = null;		//Connection 객체 변수 초기화
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Boolean connect = false ;	// DB접속의 성공여부를 알려주는 변수
		
		try {
		Class.forName(driver);		// 해당 경로에 오라클드라이버클래스가 존재하지 확인
		
		conn = DriverManager.getConnection(url, "C##HR2", "1234");
		
		//connect = true;
		
		}catch (Exception e) {
		//	e.printStackTrace();	// 연결실패시 자세한 정보를 콘솔에 출력
		//	connect = false;
		}*/
	// conect 변수가 true이면 DB 접속성공 , false : DB 접속실패
	/* if ( connect == true) {
		out.println("오라클에  접속이 되었습니다.");
	}else {
		out.println("오라클에 접속 실패했습니다.");
	}
	*/
	%>
 
 
 	<%
	// Client에서 폼에서 넘어오는 값을 데이터베이스에 저장
	String sql = null;		// sql변수 DB에 insert 쿼리를 담은 문자열.
	Statement stmt = null;	// Statement 객체 변수 선언
	
	// Statement 객체생성 : 쿼리를 DB에 (insert, update , delete) 쿼리를 실행하는 객체
	stmt = conn.createStatement();	//Connection 객체에 createStatement() 로 객체를 활성화
	
	sql = "insert into guestboard (name , email , inputdate , subject , content ) ";
	sql = sql + "values ( '"+ na + "','"+ em + "','"+ ymd + "','"+sub + "', '"+cont + "' )";
	
	//DB연결에 문제가 생길시 오류 발생 : try catch로 묶어준다
	try {
	// stmt 객체에 sql 쿼리를 넣어서 DB에 저장
	stmt.executeUpdate(sql); 	//inser , update , delete 쿼리일때 사용 -> 톰켓 기본설정은 commit이 작동됨.
	} catch (Exception e) {
		//오류 발생시 실행
		out.println("DB연결에 문제가 발생했습니다. 고객센터로 연락해주세요");
		
	}finally {
	conn.close();
	stmt.close();
	}
	%>

<!-- 클라이언트에서 넘어온 값을 DB에 저장후 페이지 이동 -->	
<jsp:forward page = "dbgb_show.jsp" />

 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% out.println(sql); %>
	<h3>클라이언트에서 넘어오는 변수를 받아서 출력</h3>
	<div><%= na %></div>
	<div><%= em %></div>
	<div><%= sub %></div>
	<div><%= cont %></div>
	<div><%= ymd %></div>
	
	<hr>
	<h3>출력 : out.println </h3>
	<%
		out.println("<div> na 변수의 값" + na + "</div>"); 
		out.println("<div> em 변수의 값" + em + "</div>"); 
		out.println("<div> sub 변수의 값" + sub + "</div>"); 
		out.println("<div> count 변수의 값" + cont + "</div>"); 
		out.println("<div> ymd 변수의 값" + ymd + "</div>"); 
	%>
	
	
	
</body>
</html>