<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>ㅠㅠ</h1>
	<c:forEach items="${hashmap}" var="e">  
       ${e.userid}<br>
       ${e.username}<br>
	</c:forEach>
</body>
</html>