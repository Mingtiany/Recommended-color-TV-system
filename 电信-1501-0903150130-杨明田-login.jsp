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
	if(form1.login_user.value==""){
		alert("用户名不能为空！请输入用户名！");
		form1.login_user.focus();
		return false;
	}
	if(form1.login_password.value==""){
		alert("密码不能为空！请输入密码！");
		form1.login_password.focus();
		return false;
	}	
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<style type="text/css">
body{
    background-color:#7B68EE;
    background: url('photo/login.jpg');
    repeat: no-repeat;
    background-attachment:fixed;
    background-size: cover;
    text-align:center;
    height:450px;
    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/login.jpg', sizingMethod='scale');
    -ms-filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/login.jpg', sizingMethod='scale');
    -moz-background-size: cover;
    -webkit-background-size: cover;

}
.login{
  background: -webkit-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Safari 5.1 - 6 */
  background: -o-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Opera 11.1 - 12*/
  background: -moz-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Firefox 3.6 - 15*/
  background: linear-gradient(to bottom right, rgba(0,191,255,0.3), rgba(255,140,0,1)); /* 标准的语法 */
  text-align:center;
  margin:50px auto;
  width:50%;
  height:80%;
}
.h{
  font-weight: bold;
  font-family: helvetica;
  text-align:center;
  font-size:30px;
  color:rgb(255,99,71);
}
}
</style>
</head>
<body onload="userfocus()">
<img src="photo\bird.png" style="margin: 50px auto;" width="100px" height="100px">
<div class=login>
<p class=h><br>LOGIN</p><br>
<form action="login.jsp" method="post" name="form1" target="_self" onsubmit="return on_submit()">
<p><img src="photo\login_user.png" width="30px" height="30px" style="vertical-align:middle;"><input type="text" name="login_user"  size="20" style="vertical-align:middle; "></p>
<p><img src="photo\login_password.png" width="30px" height="30px" style="vertical-align:middle;"><input type="password" name="login_password" size="20" style="vertical-align:middle; " ></p><br><br>
<input type="submit" name="submit" value="登录" style="width:130px; height:35px;border-radius: 5px; background:#FF8C00; line-height:30px; text-align:center; color:#fff;font-size:15px;">
</form>
<a href='http://localhost:8088/web-Database/register.jsp' style="font-weight: bold;margin-left: 300px; color:	#F4D720;">去注册</a>
</div>
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
request.setCharacterEncoding("utf-8");
String user=request.getParameter("login_user");
String password=request.getParameter("login_password");
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
 	//4.执行SQL语句，获得查询结果
	qstr="select *from user_table where myuser='"+user+"'and password='"+password+"'";
 	rs=st.executeQuery(qstr);
    if(rs.next()){//登录成功
    	//发送登录的对象及具体信息
    	String phonenum=rs.getString("phonenum");
        String sex=rs.getString("sex");
        String score=Integer.toString(rs.getInt("score"));
        String rank=Integer.toString(rs.getInt("rank"));
        String photo=rs.getString("photo");
        request.setCharacterEncoding("utf-8");
    	request.getSession(true).setAttribute("username", user);
    	request.getSession(true).setAttribute("phonenum", phonenum);
    	request.getSession(true).setAttribute("sex", sex);
    	request.getSession(true).setAttribute("score", score);
    	request.getSession(true).setAttribute("rank", rank);
    	request.getSession(true).setAttribute("photo", photo);
    	if("manager".equals(user)){
    		response.sendRedirect("adopt.jsp");	
    	}
    	else
    	response.sendRedirect("firstpage.jsp");
    }
    else{
    	%>
    	<script type="text/javascript">
    	alert("密码或账户错误！");
    	</script>
    	<%	
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
</body>
</html>