<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function userfocus(){
	//用户输入框聚焦
	form.user.focus();
}
function on_submit(){
	//验证数据合法性
	if(form.photo.value==""){
		alert("请选择头像！");
		return false;
	}
	if(form.user.value==""){
		alert("用户名不能为空！请输入用户名！");
		form.user.focus();
		return false;
	}
	if(form.password.value==""){
		alert("密码不能为空！请输入密码！");
		form.password.focus();
		return false;
	}
	if(form.comfirmpw.value==""){
		alert("确认密码不能为空！请输入确认密码！");
		form.comfirmpw.focus();
		return false;
	}
	if(form.password.value!=form.comfirmpw.value){
		alert("密码与确认密码不一致！");
		form.comfirmpw.focus();
		return false;
	}
	if(form.phonenum.value==""){
		alert("手机号码不能为空！请输入手机号码！");
		form.phonenum.focus();
		return false;
	}
	
}
function selecttouxing(){
	//让图像框显示出来
	var selectphoto=document.getElementById('selectphoto');
	selectphoto.style.display='block';
}
function td_click(e){//点击事件
	var myphoto=document.getElementById("myphoto");
	myphoto.src=e;
	var photos=document.getElementById("photos");
	photos.value=e;
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>界面</title>
<style type="text/css">
body{
    background-color:#7B68EE;
    background: url('photo/ba.jpg');
    repeat: no-repeat;
    background-attachment:fixed;
    background-size: cover;
    height:450px;
    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/ba.jpg', sizingMethod='scale');
    -ms-filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/ba.jpg', sizingMethod='scale');
    -moz-background-size: cover;
    -webkit-background-size: cover;
    text-align: center;

}
.register{
    background: url('photo/register.jpg');
    repeat: no-repeat;
    background-size: cover;
    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/register.jpg', sizingMethod='scale');
    -ms-filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/register.jpg', sizingMethod='scale');
 	margin:200px auto;
 	text-align:center;
 	width:70%;
 	height:100%;
 	background-color: #f978f3;
 	box-shadow:-3px -3px 5px #ffbd9d,5px 5px 10px #a3d1d1;
}

</style>
</head>
<body onload="userfocus()"> 
<table width="100%" cellspacing="0" cellpadding="0">
<tr>
<td width="88%" style="padding: 0px;" align="right" >
<div class="register" >
<h2 style="color:#A5A556;"><br>用户注册</h2>
<form action="register.jsp" name="form" method="post" target="_self" onsubmit="return on_submit()">
<p><img id="myphoto" src="photo/mytouxiang.png" width="50px" height="50px" onclick="selecttouxing()" style="boder-radius:25px;"><input type="text" value="" id="photos" name="photo" style="display:none;"></p>
<p><img src="photo\user.png" width="30px" height="30px" style="vertical-align:middle;"><input type="text" name="user"  size="20" style="vertical-align:middle; "></p>
<p><img src="photo\password.png" width="30px" height="30px" style="vertical-align:middle;"><input type="password" name="password" size="20" style="vertical-align:middle; " ></p>
<p><img src="photo\password.png" width="30px" height="30px" style="vertical-align:middle;"><input type="password" name="comfirmpw" size="20" style="vertical-align:middle; "></p>
<p><img src="photo\phonenum.png" width="30px" height="30px" style="vertical-align:middle;"><input type="text" name="phonenum" size="20" style="vertical-align:middle; "></p>
<p>性别：<input type="radio" name="sex" value="nan" checked="checked" >男<input type="radio" name="sex" value="nv" >女</p>
<input type="submit" name="submit" value="注册" style="width:120px; height:30px;border-radius: 5px; background:#8E8E8E; line-height:30px; text-align:center; color:#fff;font-size:13px;">
</form>
<a href='http://localhost:8088/web-Database/login.jsp' style="font-weight: bold;margin-left: 300px; color:	#FFD700;">去登录试试</a>
<%
//定义全局变量
//驱动程序名称
String drivername="com.microsoft.sqlserver.jdbc.SQLServerDriver";
//定义数据库的URL
String url="jdbc:sqlserver://localhost:1433;databasename=Recommend of TV;";
//定义访问数据库的用户名   
String s_user="sa";
//定义访问数据库的密码
String s_password="960810";
String qstr;//查询语句
//获取表单信息
request.setCharacterEncoding("UTF-8");
String user=request.getParameter("user");
String password=request.getParameter("password");
String phonenum=request.getParameter("phonenum");
String sex=request.getParameter("sex");
String photo=request.getParameter("photo");
Connection con=null;
Statement st=null;
ResultSet rs=null;
if(user!=null){
try{
	//1.加载驱动程序
	Class.forName(drivername).newInstance();
	//2.建立连接
	con=DriverManager.getConnection(url, s_user, s_password);
	//3.创建Statement对象(在连接上执行SQL语句的容器)
	st=con.createStatement();
	//4.判断是否该用户注册过
	qstr="select *from user_table where myuser='"+user+"'";
	rs=st.executeQuery(qstr);
	if(rs.next()){//该用户名已注册过
	%>
	<script type="text/javascript">
	alert("该用户名已存在，请重新注册！");
	</script>
	<%
	}
	else{
 	//5.将该用户信息加入用户表里
 		%>
	<script type="text/javascript">
	alert("注册成功！！");
	</script>
	<%
	qstr="insert into user_table values("+"'"+user+"'"+",'"+password+"','"+phonenum+"','"+sex+"','0','0','"+photo+"')";
 	st.executeQuery(qstr); 
	}
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
</div>
</td>
<td align="left">
<div id="selectphoto" style="display:none; width:180px;height:160px;" align="center">
<table width="100%">
<tr>
<td onclick="td_click('photo/touxiang.jpg')"><img id="p1" src="photo/touxiang.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang1.jpg')"><img id="p2" src="photo/touxiang1.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang3.jpg')"><img id="p3" src="photo/touxiang3.jpg" width="50px" height="50px"></td>
</tr>
<tr>
<td onclick="td_click('photo/touxiang4.jpg')"><img id="p4" src="photo/touxiang4.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang5.jpg')"><img id="p5" src="photo/touxiang5.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang6.jpg')"><img id="p6" src="photo/touxiang6.jpg" width="50px" height="50px"></td>
</tr>
<tr>
<td onclick="td_click('photo/touxiang7.jpg')"><img id="p7" src="photo/touxiang7.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang8.jpg')"><img id="p8" src="photo/touxiang8.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/touxiang9.jpg')"><img id="p9" src="photo/touxiang9.jpg" width="50px" height="50px"></td>
</tr>
</table>
</div>
</td>
</tr>
</table>
</body>
</html>