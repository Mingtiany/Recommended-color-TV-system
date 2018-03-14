<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.table{
background-color:#211;
margin: 0px;
padding: 0px;
color: #fff;
}
</style>
</head>
<body style="margin: 0px;">
<table align="center" width="100%" border="0" height="30px" class="table" cellspacing="0">
<tr>
<td width="50%" align="left">
<sapn style="font-size: 20px; font-weight: bold;color:	#fff;">
<a href="http://localhost:8088/web-Database/adopt.jsp" style="font-size: 20px; font-weight: bold;color:#fff;">商品采纳</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/search.jsp" style="font-size: 20px; font-weight: bold;color:#fff;">商品搜索</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/order.jsp" style="font-size: 20px; font-weight: bold;color:#fff;">商品排名</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/mantenance.jsp"style="font-size: 20px; font-weight: bold;color:#fff;">信息维护</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/home_page.jsp" style="font-size: 20px; font-weight: bold;color:#fff;">我的主页</a></sapn>
</td>
<td width="50%" align="right">
<p><img src="<%=(String)request.getSession().getAttribute("photo") %>" style="vertical-align:middle;"width="60px" height="60px"><span style="vertical-align:middle; font-weight: bold;color:#fff; font-size: 20px;"><%=request.getSession().getAttribute("username") %></span></p>
</td>
</tr>
</table>
</body>
</html>