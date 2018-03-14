<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.table{
background-color:#D3D3D3;
margin: 0px;
padding: 0px;
}
</style>
<script type="text/javascript">
function mytou(){
	document.getElementById("tou").src=<%=(String)request.getSession().getAttribute("photo")%>
	alert(<%=(String)request.getSession().getAttribute("photo")%>);
}
</script>
</head>
<body style="margin: 0px;padding:0px;">
<table align="center" width="100%" class="table" border="0" cellspacing="5px" cellpadding="5px">
<tr style="height:50%;">
<td width="50%"  align="center" style="padding: 0px;">
<img id="tou" src="<%=(String)request.getSession().getAttribute("photo")%>" style="vertical-align:middle;"width="20px" height="20px"><span style="vertical-align:middle; color:#8E8E8E"><%=request.getSession().getAttribute("username") %>&nbsp;你好</span>
</td>
<td width="50%"  align="center" style="padding: 0px;">
<span style="width: 100%;height: 100%; font-weight: bold;color:#8E8E8E;">
<a href="http://localhost:8088/web-Database/firstpage.jsp" style="font-size: 15px;color:#8E8E8E;">首页</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/ui_recommend.jsp" style="font-size: 15px;color:#8E8E8E;">商品推荐</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/order.jsp" style="font-size: 15px;color:#8E8E8E; ">商品排名</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/gouwuche.jsp" style="font-size:15px;color:#8E8E8E; ">我的购物车</a>&nbsp;|&nbsp;
<a href="http://localhost:8088/web-Database/home_page.jsp" style="font-size:15px;color:#8E8E8E; ">我的主页</a></span>
</td>
</tr>
</table>
</body>
</html>