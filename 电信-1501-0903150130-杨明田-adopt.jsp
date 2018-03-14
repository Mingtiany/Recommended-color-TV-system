<%@page import="java.awt.SystemTray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>
<%@ include file="m_head.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品采纳</title>
<style type="text/css">
body{
  background: -webkit-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Safari 5.1 - 6 */
  background: -o-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Opera 11.1 - 12*/
  background: -moz-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Firefox 3.6 - 15*/
  background: linear-gradient(to bottom right, rgba(0,191,255,0.3), rgba(255,140,0,1)); /* 标准的语法 */
  background-repeat: no repeat;
  background-attachment: fixed;
  text-align: center;
}
</style>
</head>
<body>
<div style="text-align:center;">
<form name="form5" action="adopt.jsp" method="post">
<table border="0" style="text-align: center;"width="100%">
<tr align="center">
<th>推荐商品号</th>
<th>商品图</th>
<th>品牌</th>
<th>商品名</th>
<th>店名</th>
<th>价格</th>
<th>尺寸</th>
<th>分辨率</th>
<th>推荐人</th>
<th>推荐时间</th>
<th>审核结果</th>
<th>加分</th>
</tr>
<%		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间
		String str_date = formatter.format(currentTime); //将日期时间格式化  

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
			try{
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr="select * from recommend_product_table where state='WaitingForAudit'";
		//4.搜索
		rs=st.executeQuery(qstr);
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String RPID=Integer.toString(rs.getInt("RPID"));
		    String picture=rs.getString("picture");
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			String recommendman=rs.getString("myuser");
			String date_recommend=rs.getString("date_recommend");
			%>
			<tr align="center">
			<td><select name="pid"><option selected="selected"><%=RPID%></option></select></td>
			<td width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
			<td><%=brand %></td>
			<td><%=pname %></td>
			<td><%=store %></td>
			<td><%=price %></td>
			<td><%=size %></td>
			<td><%=resolution %></td>
			<td><%=recommendman %></td>
			<td><%=date_recommend %></td>
			<td><select name="state"><option selected="selected"value="waiting">待定</option><option value="pass">通过</option><option value="nopass">否决</option></select></td>
			<td><select name="addscore">
			<option value="0" selected="selected">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			</select>
			</td>
			</tr>
			<% 
		while(rs.next()){
			String RPID1=Integer.toString(rs.getInt("RPID"));	
			String picture1=rs.getString("picture");
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String recommendman1=rs.getString("myuser");
			String date_recommend1=rs.getString("date_recommend");
			%>
			<tr align="center">
			<td><select name="pid"><option selected="selected"><%=RPID1%></option></select></td>
			<td width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>			
			<td><%=brand1 %></td>
			<td><%=pname1 %></td>
			<td><%=store1 %></td>
			<td><%=price1 %></td>
			<td><%=size1 %></td>
			<td><%=resolution1 %></td>
			<td><%=recommendman1 %></td>
			<td><%=date_recommend1 %></td>
			<td><select name="state"><option selected="selected"value="waiting">待定</option><option value="pass">通过</option><option value="nopass">否决</option></select></td>
			<td><select name="addscore">
			<option value="0" selected="selected">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			</select>
			</td>
			</tr>
			<% 
		    }
		}
		else{
			%>
			<tr>
			<td><%="暂无未审核数据~" %></td>
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
<br>
<input type="submit" name="submit" value="提交结果" style="width:120px; height:30px;border-radius: 5px; background:#8B3E2F; line-height:20px; text-align:center; color:#fff;font-size:13px;">
</form>
</div>
<%
//将提交的结果写入数据库

request.setCharacterEncoding("UTF-8");
String [] pid=request.getParameterValues("pid");
String [] state=request.getParameterValues("state");
String [] addscore=request.getParameterValues("addscore");
try{
	//1.加载驱动程序
	Class.forName(drivername).newInstance();
	//2.建立连接
	con=DriverManager.getConnection(url, s_user, s_password);
	//3.创建Statement对象(在连接上执行SQL语句的容器)
	st=con.createStatement();
	String qstr;
if(pid!=null){
for(int i=0;i<pid.length;i++){
	if("pass".equals(state[i])){//通过——>更新推荐表
		qstr="update recommend_product_table set state='pass',date_operate='"+str_date+"'where RPID='"+pid[i]+"'";
	    st.executeUpdate(qstr);
	    //将该商品录入商品表里
	    //从推荐表里读出该商品数据
	    qstr="select * from recommend_product_table where RPID='"+pid[i]+"'";
	    rs=st.executeQuery(qstr);
	    String pname=null;
	    String price=null;
	    String storename=null;
	    String brand=null;
	    String size=null;
	    String resolution=null;
	    String myuser=null;
	    String picture=null;
	    while(rs.next()){
	    	pname=rs.getString("pname");
	    	price=Integer.toString(rs.getInt("price"));
	    	storename=rs.getString("storename");
	    	brand=rs.getString("brand");
	    	size=rs.getString("size");
	    	resolution=rs.getString("resolution");
	    	myuser=rs.getString("myuser");
	    	picture=rs.getString("picture");
	    }
	  //给用户加分
	    qstr="update user_table set score=score+"+addscore[i]+" where myuser='"+myuser+"'";
	    st.executeUpdate(qstr);
	    //读出商品表里长度
	    qstr="select COUNT(*) as 'num' from product_table";
	    int PID=0;
	    rs=st.executeQuery(qstr);
	    if(rs.next())
	    	PID=rs.getInt("num");
	    PID=PID+1;
	    //将商品插入商品表
	    qstr="insert into product_table values("+"'"+PID+"'"+",'"+pname+"','"+price+"','"+storename+"','"+brand+"','"+size+"','"+resolution+"','"+myuser+"','"+picture+"')";
	    st.executeUpdate(qstr);	
	}
	else if("nopass".equals(state[i])){//该商品被否决——>更新推荐表
		qstr="update recommend_product_table set state='reject',date_operate='"+str_date+"'where RPID='"+pid[i]+"'";
	    st.executeUpdate(qstr);
	}
	
}
%>
<script type="text/javascript">
alert("提交成功！");
window.location="search.jsp";
</script>
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
</body>
</html>