<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#cainiao{
font-family: "楷体";
color: red;
font-weight: bold;
font-size: 30px;
}
#shu{
font-family: "楷体";
color:#EEEEE0;
font-size: 40px;
}
#store{
font-family: "宋体";
color:#000;
font-weight: bold;
font-size: 20px;
}
#hellow{
font-family: "楷体";
color:#8B4500;
font-weight: bold;
font-size: 20px;
}
</style>
<script type="text/javascript">
function on_submit2(){
	if(form4.searchtype.value!="全部"&form4.search.value==""){
		alert("搜索框不能为空！！");
		form4.search.focus();
		return false;
	}
	if(form4.searchtype.value=="全部"&form4.search.value!=""){
		alert("请选择搜索类型！！");
		form4.search.focus();
		return false;
	}
	
}
</script>
</head>
<body>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentTime = new java.util.Date();//得到当前系统时间
String str_date =formatter.format(currentTime); //将日期时间格式化  
%>
<br>
<table align="center" width="100%" border="0" height="30px" cellspacing="0">
<tr>
<td  height="70px" width="80%">
<table width="100%">
<tr>
<td align="left" width="30%">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="cainiao">菜鸟网</span>&nbsp;&nbsp;&nbsp;<span id="shu">|</span>&nbsp;<span id="store"><%=(String)request.getAttribute("store") %></span>
</td>
<td align="right">
<form action="firstpage.jsp" name="form4" method="post"  onsubmit="return on_submit2()">
<table>
<tr>
<td width="60%" align="center">
<input type="text" name="search" size="50"style="vertical-align: middle; height: 30px; border-color: red;border-width: 1px;font-size: 18px; ">
<input type="text" name="dispAll" value="no" style="display: none;">
</td>
<td>
<input type="submit" name="submit" value="搜索" style="width:80px;vertical-align: middle; height:38px;border-radius: 5px; background:red; line-height:20px; text-align:center; color:#fff;font-size:16px;">
</td>

<td align="left" style="color: #8E8E8E;">
搜索类型:<select name="searchtype">
<option selected="selected">全部</option>
<option>商品名</option>
<option>店名</option>
<option>品牌</option>
<option>分辨率</option>
<option>尺寸</option>
</select>
<span style="display: none;">
价格区间(可选):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 最低价:<input type="text" name="price_low" size="5" value="" > —— 最高价:<input type="text" name="price_high" size="5" value="">
</span>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</td>
<td align="center" height="70px">
<%=str_date%><br><br><span id="hellow">亲爱的~<%=(String)request.getSession().getAttribute("username") %>~你好!</span>
</td>
</tr>
<tr>
<td width="85%" valign="top" >
<img src="photo/topbar1.png" width="100%" height="40px">
</td>
<td align="right" >
<img src="photo/rightbar.jpg" width="60%" height="180px">
</td>
</tr>
</table>
</body>
</html>