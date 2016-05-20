<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
    <%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "LoginPage.jsp" %>

<%!
 //String username="${sessionScope.key}".toString();
 //Cookie visitors = new Cookie("visitor",username); 
 
 String time;
 static Cookie visitors = new Cookie("visitor","0");
	static int id = 0; 
	
		
%>



<%
request.setAttribute("uname", request.getParameter("name"));
request.setAttribute("upass", request.getParameter("pass"));

//response.addCookie(visitors);	

%>


<sql:setDataSource var="data" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/CybageNet" user="root" password="root"/>
	
	<sql:query var="result" dataSource="${data}">
		select * from login;
	</sql:query>

<c:forEach var="row" items="${result.rows}">

<c:if test="${row.name =='Admin' && row.password==upass}">
<% 
	/* request.getSession().setAttribute("key", "Admin"); */
	response.addCookie(visitors);
%>
<%-- <jsp:forward page="AdminPage.jsp"/> --%>

<c:redirect url="AdminPage.jsp"></c:redirect>
</c:if>

<c:if test="${row.name ==uname && row.password==upass}">
<%
	request.getSession().setAttribute("key", request.getParameter("name"));
	id = Integer.parseInt(visitors.getValue());
	id++;
	visitors.setValue(String.valueOf(id)); 
	response.addCookie(visitors);	
	time=new Timestamp(new Date().getTime()).toString();
	

	request.setAttribute("time", time);
	
%>

<!-- 
<a href='servlet2?uname="+n+"'>visit</a> -->

<%

DateFormat formatter;
formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
 // you can change format of date
Date date = formatter.parse(time);
 
Timestamp time1= new Timestamp(date.getTime());

System.out.println("To be inserted : " + time1);
 
%>


<sql:setDataSource var="data1" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/CybageNet" user="root" password="root"/>
	

	<sql:update var="result1" dataSource="${data1}">
		insert into users values(?,?);
		<%-- <sql:param value="<%= request.getParameter("uname")%>"/>
		<sql:dateParam value=" <%= request.getParameter("time")%> " type="TIME"/> --%>
		
		<sql:param value="${row.name}"/>
		<%-- <sql:dateParam value="<%=time1%>" type="TIME"/> --%>
		<sql:param value="<%=time%>"/>
	</sql:update>
	
	
	
	<%-- <%
	
	   out.print("<a href='servlet2?uname="+n+"'>visit</a>");
	
	response.sendRedirect("UserPage.jsp?uname=${row.name}&time=)"")
	%> --%>
<c:redirect url="UserPage.jsp?uname=${row.name}&time=${time}"></c:redirect>

	
	
	

<%-- <jsp:forward page="UserPage.jsp"/> --%>
</c:if>

</c:forEach>

<h4 align="center"; style="color: red"><c:out value="Sorry Wrong user name or password "></c:out></h6>  


</body>
</html>