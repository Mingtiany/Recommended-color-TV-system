<%@page import="java.util.Date"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="head.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情</title>
<style type="text/css">
#tip{
font-family: "楷体";
color:#FF4500;
font-size: 18px;
}
#title{
font-family: "微软雅黑";
color:#000;
font-weight:bold;
font-size: 22px;
}
</style>
</head>
<body>
<%
//获取参数
String brand=request.getParameter("brand");
String pname=request.getParameter("pname");
String store=request.getParameter("store");
String price=request.getParameter("price");
String size=request.getParameter("size");
String resolution=request.getParameter("resolution");
String recommendman=request.getParameter("recommendman");
String pid=request.getParameter("pid");
String picture=request.getParameter("picture");
if(brand!=null){
request.getSession(true).setAttribute("details_brand", brand);
request.getSession(true).setAttribute("details_pname", pname);
request.getSession(true).setAttribute("details_store", store);
request.getSession(true).setAttribute("details_price", price);
request.getSession(true).setAttribute("details_size", size);
request.getSession(true).setAttribute("details_resolution", resolution);
request.getSession(true).setAttribute("details_recommendman", recommendman);
request.getSession(true).setAttribute("details_pid", pid);
request.getSession(true).setAttribute("details_picture", picture);
//解码
brand=URLDecoder.decode(brand, "UTF-8");
pname=URLDecoder.decode(pname, "UTF-8");
store=URLDecoder.decode(store, "UTF-8");
price=URLDecoder.decode(price, "UTF-8");
size=URLDecoder.decode(size, "UTF-8");
resolution=URLDecoder.decode(resolution, "UTF-8");
recommendman=URLDecoder.decode(recommendman, "UTF-8");
pid=URLDecoder.decode(pid, "UTF-8");
picture=URLDecoder.decode(picture, "UTF-8");
request.setAttribute("store", store);
}
else{
	brand=(String)request.getSession(true).getAttribute("details_brand");
	pname=(String)request.getSession(true).getAttribute("details_pname");
	store=(String)request.getSession(true).getAttribute("details_store");
	price=(String)request.getSession(true).getAttribute("details_price");
	size=(String)request.getSession(true).getAttribute("details_size");
	resolution=(String)request.getSession(true).getAttribute("details_resolution");
	recommendman=(String)request.getSession(true).getAttribute("details_recommendman");
	pid=(String)request.getSession(true).getAttribute("details_pid");
	picture=(String)request.getSession(true).getAttribute("details_picture");
//解码
brand=URLDecoder.decode(brand, "UTF-8");
pname=URLDecoder.decode(pname, "UTF-8");
store=URLDecoder.decode(store, "UTF-8");
price=URLDecoder.decode(price, "UTF-8");
size=URLDecoder.decode(size, "UTF-8");
resolution=URLDecoder.decode(resolution, "UTF-8");
recommendman=URLDecoder.decode(recommendman, "UTF-8");
pid=URLDecoder.decode(pid, "UTF-8");
picture=URLDecoder.decode(picture, "UTF-8");
request.setAttribute("store", store);
}
//获取当前时间
java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentTime1 = new java.util.Date();//得到当前系统时间
String time =formatter1.format(currentTime1); //将日期时间格式化  
%>
<%@ include file="details_head.jsp"  %>
<form action="product_details.jsp" method="post" >
<table width="80%">
<tr>
<td width="40%" height="400px">
<div style="border:1px #CCCCCC; width: 100%;height: 400px;">
<img  src="<%=picture%>" width="80%" height="80%">
</div>
</td>
<td valign="top">
<table>
<tr>
<td><span id="title"><%=brand%>&nbsp;&nbsp;<%=pname %>&nbsp;&nbsp;<%=size %>英寸&nbsp;&nbsp;分辨率<%=resolution %></span><br>
<span id="tip">送货入户 海量片源 咨询客服有惊喜</span>&nbsp;&nbsp;<img src="photo/baoyou.png" width="30px" height="20px">
</td>
</tr>
<tr>
<td><br>
<div style="background-color: #DEDEDE;">
<img src="photo/bottombar1.png" width="100%" height="80px">
<br>
<span style="color:#525252;font-size:15px;">原价</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4999.00<br>
<span style="color:#525252;font-size:15px;">现价</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight: bold;color:red;font-size:25px;"><%=price %>.00</span>
</div>
</td>
</tr>
<tr>
<td>
<br>
<span style="color:#525252;font-size:15px;">套餐类型</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>官方标配</span>
</td>
</tr>
<tr>
<td>
<br>
<span style="color:#525252;font-size:15px;">数量</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="quantity" size="3">
</td>
</tr>
<tr>
<td align="center">
<br>
<br>
<input type="submit" name="submit" value="加入购物车" style="width:120px; height:30px;border-radius: 5px; background:#FF7F00; line-height:20px; text-align:center; color:#fff;font-size:13px;">
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
<%
//驱动程序名称
String drivername="com.microsoft.sqlserver.jdbc.SQLServerDriver";
//定义数据库的URL
String url="jdbc:sqlserver://localhost:1433;databasename=Recommend of TV;";
//定义访问数据库的用户名   
String s_user="sa";
//定义访问数据库的密码
String s_password="960810";
Connection con=null;
Statement st=null;
ResultSet rs=null;
//获取表单提交的数据
request.setCharacterEncoding("UTF-8");
String myuser=(String)request.getSession().getAttribute("username");
String quantity=request.getParameter("quantity");
if(quantity!=null){
try{
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr="insert into gouwuche_table values('"+pid+"','"+myuser+"','"+time+"','"+quantity+"')";
		st.executeUpdate(qstr);
        %>
        <script type="text/javascript">
        alert("已加入购物车！");
        </script>
        <% 		
	//6.关闭资源
		rs.close();
		st.close();
		con.close();
	}
	 catch (Throwable t){
		//错误处理，输出错误信息
		if(rs!=null)
		t.printStackTrace(System.out);
	} 
	finally{
		//finally 语句总会被执行，即使发生错误
		try{
			if(rs!=null)
			rs.close();
		}catch(Exception e1){}
		try{
			if(st!=null)
			st.close();
		}catch(Exception e1){}
		try{
			if(con!=null)
			con.close();
		}catch(Exception e1){}
	}
	
}
%>
</body>
</html>