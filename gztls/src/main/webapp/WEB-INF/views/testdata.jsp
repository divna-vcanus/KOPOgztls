<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
	<button class="btn btn-primary" role="button" onclick="servertimeinsert()">서버시간 랜덤 데이터 넣기</button>
	<button class="btn btn-primary" role="button" onclick="servertimeerror()">서버시간 에러 데이터 넣기</button>
</body>
<script>
	function servertimeinsert(){
		$.ajax({
			url : "servertimeinsert",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
		}
	function servertimeerror() {
		$.ajax({
			url : "servertimeerror",
			type : "GET",
			success : function() {
				alert("데이터 삽입 완료");				
			},
			error : function() {
				alert("error",error);
			}
		});
		}
</script>
</html>