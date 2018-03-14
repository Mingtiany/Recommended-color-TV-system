<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
<script type="text/javascript">
function on_submit(){
	//验证数据合法性
	if(form3.phonenum.value==""){
		alert("手机号码不能为空！请输入手机号码！");
		form3.phonenum.focus();
		return false;
	}
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=(String)request.getSession().getAttribute("username") %>的主页</title>
<style type="text/css">

body{
    background: url('photo/top.jpg');
    repeat: no-repeat;
    background-attachment:scroll;
    background-size: cover;
    text-align:center;
    filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/login.jpg', sizingMethod='scale');
    -ms-filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='photo/login.jpg', sizingMethod='scale');
    -moz-background-size: cover;
    -webkit-background-size: cover;
}
</style>
<%
String user=(String)(request.getSession().getAttribute("username"));
if("manager".equals(user)){%>
<jsp:include page="m_head.jsp" flush="true"/> 
<%}else{%>
<jsp:include page="head.jsp" flush="true"/>
<%}%>
</head>
<body >
<div class="top">
</div>
<div class="bg">
<table align="center" width="50%" cellspacing="5px" style="background-color:rgba(200,255,205,0.1);">
<tr><!-- XX的主页 -->
<td align="left">
<p style="color:#00BFFF;font-weight: bold; font-size:30px"><%=(String)request.getSession().getAttribute("username")%>的主页</p>
</td>
</tr>
<tr><!-- XX的头像 -->
<td align="left">
<p><img src="<%=(String)request.getSession().getAttribute("photo") %>" width="60px" height="60px"></p>
</td>
</tr>
<tr>
<td align="left" valign="top"><!-- XX的个人信息面板-->
<div style="background-color:#000093;width:200px;height:600px;text-align: left;">
<h3 style="color:#fff; width: 200px;height: 30px;background-color:#5151A2;">个人信息</h3><br>
<form name="form3" action="home_page.jsp" method="post" onsubmit="return on_submit()">
<table align="center" width="200px" cellspacing="10px"cellpadding="0" style="color:#fff;">
<tr align="left">
<td align="left">昵称:</td><td align="left"><%=(String)request.getSession().getAttribute("username") %></td>
</tr>
<tr align="left">
<td align="left">性别:</td><td align="left"><select name="sex"><option id="op_nan" value="nan">男</option><option id="op_nv" value="nv">女</option></select></td>
</tr>
<tr align="left">
<td align="left">电话:</td><td align="left"><input type="text" id="phonenum" name="phonenum" size="15" style="background-color:#97CBFF;text-align: center;"></td>
</tr>
<tr align="left">
<td align="left">积分:</td><td align="left"><%=(String)request.getSession().getAttribute("score") %></td>
</tr>
<tr align="left">
<td align="left">等级:</td><td align="left"><%=(String)request.getSession().getAttribute("rank") %></td>
</tr>
</table>
<div style="width:200px;height:30px;background-color:#000093;text-align: center;">
<br>
<input type="submit" name="submit" value="保存" style="width:100px; height:30px;border-radius: 5px; background:#00B2EE; line-height:30px; text-align:center; color:#fff;font-size:13px;">
</div>
</form>
</div>
</td>
<td align="left" valign="top"><!--我的动态-->
<div style="background-color:rgba(135,206,250,0.1);width:1000px;text-align: center;">
<h3 style="color:#fff; width: 1000px;height: 30px;background-color:#5151A2;">我的动态</h3>
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
if("manager".equals(user)){//管理员
%>
<div style="color:#ff0;font-weight:bold; width: 1000px;height: 30px;">商品审核记录</div>
<table border="0" style="text-align: center;background-color:#fee;"width="100%">
<tr align="center">
<th>产品图</th>
<th>品牌</th>
<th>商品名</th>
<th>店名</th>
<th>价格</th>
<th>尺寸</th>
<th>分辨率</th>
<th>推荐人</th>
<th>推荐时间</th>
<th>审核时间</th>
<th>审核结果</th>
</tr>
<%
      
			try{
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr="select * from recommend_product_table where state !='WaitingForAudit'";
		//4.搜索
		rs=st.executeQuery(qstr);
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String picture=rs.getString("picture");
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			String recommendman=rs.getString("myuser");
			String state=rs.getString("state");
			String date_recommend=rs.getString("date_recommend");
			String date_operate=rs.getString("date_operate");
			%>
			<tr align="center">
			<td width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
			<td><%=brand %></td>
			<td><%=pname %></td>
			<td><%=store %></td>
			<td><%=price %></td>
			<td><%=size %></td>
			<td><%=resolution %></td>
			<td><%=recommendman %></td>
			<td><%=date_recommend %></td>
			<td><%=date_operate %></td>
			<td><%=state %></td>
			</tr>
			<% 
		while(rs.next()){	
			String picture1=rs.getString("picture");
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String recommendman1=rs.getString("myuser");
			String state1=rs.getString("state");
			String date_recommend1=rs.getString("date_recommend");
			String date_operate1=rs.getString("date_operate");
			%>
			<tr align="center">	
			<td  width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>		
			<td><%=brand1 %></td>
			<td><%=pname1 %></td>
			<td><%=store1 %></td>
			<td><%=price1 %></td>
			<td><%=size1 %></td>
			<td><%=resolution1 %></td>
			<td><%=recommendman1 %></td>
			<td><%=date_recommend1 %></td>
			<td><%=date_operate1 %></td>
			<td><%=state1 %></td>
			</tr>
			<% 
		    }
		}
		else{
			%>
			<tr>
			<td><%="暂无动态~" %></td>
			</tr>
			<%			
		}
			
			
	//6.关闭资源
		rs.close();
		st.close();
		con.close();
	}
	 catch (SQLException e){
		 e.printStackTrace();
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
	

%>
</table>
<div style="color:#ff0;font-weight:bold; width: 1000px;height: 30px;">信息维护记录</div>
<table border="0" style="text-align: center;background-color:#fee;"width="100%">
<tr align="center">
<th>品牌</th>
<th>商品名</th>
<th>店名</th>
<th>价格</th>
<th>尺寸</th>
<th>分辨率</th>
<th>操作时间</th>
<th>操作类型</th>
</tr>
<%
      
			try{
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr="select * from operate_table order by date_operate desc";
		//4.搜索
		rs=st.executeQuery(qstr);
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			String operatetype=rs.getString("operatetype");
			String date_operate=rs.getString("date_operate");
			%>
			<tr align="center">
			<td><%=brand %></td>
			<td><%=pname %></td>
			<td><%=store %></td>
			<td><%=price %></td>
			<td><%=size %></td>
			<td><%=resolution %></td>
			<td><%=date_operate %></td>
			<td><%=operatetype %></td>
			</tr>
			<% 
		while(rs.next()){	
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String operatetype1=rs.getString("operatetype");
			String date_operate1=rs.getString("date_operate");
			%>
			<tr align="center">			
			<td><%=brand1 %></td>
			<td><%=pname1 %></td>
			<td><%=store1 %></td>
			<td><%=price1 %></td>
			<td><%=size1 %></td>
			<td><%=resolution1 %></td>
			<td><%=date_operate1 %></td>
			<td><%=operatetype1 %></td>
			</tr>
			<% 
		    }
		}
		else{
			%>
			<tr>
			<td><%="暂无数据~" %></td>
			</tr>
			<%			
		}
			
			
	//6.关闭资源
		rs.close();
		st.close();
		con.close();
	}
	 catch (SQLException e){
		 e.printStackTrace();
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
	

%>
</table>
<%}
else{//普通用户
	%>
	<table border="0" style="text-align: center;"width="100%" >
	<tr align="center">
	<th>产品图</th>
	<th>品牌</th>
	<th>商品名</th>
	<th>店名</th>
	<th>价格</th>
	<th>尺寸</th>
	<th>分辨率</th>
	<th>推荐时间</th>
	<th>审核时间</th>
	<th>审核结果</th>
	</tr>
	<%
	      
				try{
			//1.加载驱动程序
			Class.forName(drivername).newInstance();
			//2.建立连接
			con=DriverManager.getConnection(url, s_user, s_password);
			//3.创建Statement对象(在连接上执行SQL语句的容器)
			st=con.createStatement();
			String qstr="select * from recommend_product_table where myuser='"+user+"'";
			//4.搜索
			rs=st.executeQuery(qstr);
			if(rs.next()){//查到数据rs.next()可以转到下一行
				String picture=rs.getString("picture");
				String brand=rs.getString("brand");
				String pname=rs.getString("pname");
				String store=rs.getString("storename");
				String price=Integer.toString(rs.getInt("price"));
				String size=rs.getString("size");
				String resolution=rs.getString("resolution");
				String state=rs.getString("state");
				String date_recommend=rs.getString("date_recommend");
				String date_operate=rs.getString("date_operate");
				if(date_operate==null)
					date_operate="还未审核";
				if("WaitingForAudit     ".equals(state))
					state="等待审核";
				%>
				<tr align="center">
				<td  width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
				<td><%=brand %></td>
				<td><%=pname %></td>
				<td><%=store %></td>
				<td><%=price %></td>
				<td><%=size %></td>
				<td><%=resolution %></td>
				<td><%=date_recommend %></td>
				<td><%=date_operate %></td>
				<td><%=state %></td>
				</tr>
				<% 
			while(rs.next()){	
				String picture1=rs.getString("picture");
				String brand1=rs.getString("brand");
				String pname1=rs.getString("pname");
				String store1=rs.getString("storename");
				String price1=Integer.toString(rs.getInt("price"));
				String size1=rs.getString("size");
				String resolution1=rs.getString("resolution");
				String date_recommend1=rs.getString("date_recommend");
				String state1=rs.getString("state");
				String date_operate1=rs.getString("date_operate");
				if(date_operate1==null)
					date_operate1="还未审核";
				if("WaitingForAudit     ".equals(state1))
					state1="等待审核";
				%>
				<tr align="center">	
				<td  width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>		
				<td><%=brand1 %></td>
				<td><%=pname1 %></td>
				<td><%=store1 %></td>
				<td><%=price1 %></td>
				<td><%=size1 %></td>
				<td><%=resolution1 %></td>
				<td><%=date_recommend1 %></td>
				<td><%=date_operate1 %></td>
				<td><%=state1 %></td>
				</tr>
				<% 
			    }
			}
			else{
				%>
				<tr>
				<td><%="暂无动态~" %></td>
				</tr>
				<%			
			}
				
				
		//6.关闭资源
			rs.close();
			st.close();
			con.close();
		}
		 catch (SQLException e){
			 e.printStackTrace();
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
		

	%>
	</table>	
<%	
}
%>
</div>
</td>
</tr>
</table>
</div>
<%//初始化个人信息
String sex=(String) request.getSession().getAttribute("sex");
String phone=(String) request.getSession().getAttribute("phonenum");
if(phone!=null){
	%>
<script type="text/javascript">
	document.getElementById("phonenum").setAttribute("value", <%=phone%>);
	</script>	
	<% 
}
if(sex!=null){
if(sex.length()==3){
	
%>
<script type="text/javascript">
	document.getElementById("op_nan").setAttribute("selected", "selected");
	</script>
<% 
}
if(sex.length()==2){
	%>
	<script type="text/javascript">
	document.getElementById("op_nv").setAttribute("selected", "selected");
	</script>
	<% 
}
}
%>


<%//将修改过的用户信息保存进数据库

String qstr;//查询语句
//获取表单信息
request.setCharacterEncoding("utf-8");
String username=(String)(request.getSession().getAttribute("username"));
String newphonenum=request.getParameter("phonenum");
String newsex=request.getParameter("sex");
if(newphonenum!=null){
try{
	//1.加载驱动程序
	Class.forName(drivername).newInstance();
	//2.建立连接
	con=DriverManager.getConnection(url, s_user, s_password);
	//3.创建Statement对象(在连接上执行SQL语句的容器)
	st=con.createStatement();

		//5.将该用户信息加入用户表里
			qstr="update user_table set phonenum='"+newphonenum+"',sex='"+newsex+"' where myuser='"+username+"'";
			//修改会话里的属性
			request.getSession().setAttribute("phonenum", newphonenum);
			request.getSession().setAttribute("sex", newsex);
			st.executeQuery(qstr); 
			
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