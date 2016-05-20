<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
        <%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LogOut</title>
</head>
<body>
	
	
	
	<%
	 DateFormat formatter;
    formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
     // you can change format of date
    Date date = formatter.parse(request.getParameter("time"));
     
    //Date date = formatter.parse("2016-05-20 15:22:20");
   Timestamp time= new Timestamp(date.getTime());

   System.out.println("To be deleted : "+time);
   
   System.out.println(new Timestamp(date.getTime()));
   
   	//						new Timestamp(new Date().getTime())
	
	
	
	
	
	%>
	
<sql:setDataSource var="data" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/CybageNet" user="root" password="root"/>
	
	<sql:update var="result" dataSource="${data}">
	delete from users where  username=? and logintime=?

		<sql:param value="${param.uname}"/>
	 <%-- <sql:dateParam value="<%= new Timestamp(date.getTime())%>" type="TIME"/> --%> 
	 <sql:param value='<%=request.getParameter("time")%>'/>
	</sql:update>
	
	 <%@ include file="LoginPage.jsp" %>
	
	

</body>
</html>