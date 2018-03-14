<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %>
 <%@ include file="head.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的购物车</title>
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
	
}</script>
<style type="text/css">
body{
background-color:#EDEDED;
padding: 0px;
margin: 0px;
}
</style>
</head>
<body>
<table width="100%" cellspacing="0">
<tr  style="background-color: #fff;">
<td width="20%"  align="center" style="background-color: #fff;">
<img src="photo/gouwuche.png" width="200px"height="100px">
</td>

<td align="center"  style="background-color: #fff;">
<table  style="background-color: #fff;" border="0">
<tr align="right"  style="background-color: #fff;">
<td style="text-align: left;">
<form action="firstpage.jsp" name="form4" method="post"  onsubmit="return on_submit2()">
<table>
<tr>
<td width="60%" align="center">
<input type="text" name="search" size="50"style="vertical-align: middle; height: 30px; border-color: red;border-width: 1px;font-size: 18px; ">
<input type="text" name="dispAll" value="no" style="display: none;">
</td>
<td><input type="submit" name="submit1" value="搜索" style="width:80px;vertical-align: middle; height:38px;border-radius: 5px; background:red; line-height:20px; text-align:center; color:#fff;font-size:16px;"></td>
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
 <input type="text" name="price_low" size="5" value="" > —— <input type="text" name="price_high" size="5" value="">
</span>
</td>
</tr>
</table>
</form>
</td>

<td> <a href="http://localhost:8088/web-Database/firstpage.jsp" style="font-size: 20px;color:#949494;text-decoration:none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;首页&nbsp;|&nbsp;&nbsp;</a></td>
<td> <a href="http://localhost:8088/web-Database/ui_recommend.jsp" style="font-size: 20px;color:#949494;text-decoration:none;">商品推荐&nbsp;|&nbsp;&nbsp;</a></td>
<td> <a href="http://localhost:8088/web-Database/home_page.jsp" style="font-size: 20px;color:#949494;text-decoration:none;">我的主页</a></td>
</tr>
</table>
</td>
</tr>
</table>
<form action="gouwuche.jsp" name="form6" method="post">
<table border="0" width="80%" align="center" style="border-collapse: collapse;">
<tr><td><br></td></tr>
<tr>
<th>选择</th>
<th>商品图</th>
<th>商品信息</th>
<th>单价</th>
<th>数量</th>
<th>折扣</th>
<th>折扣后金额</th>
<th>加入日期</th>
</tr>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
 
         String user =(String)request.getSession().getAttribute("username");
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
		String qstr;
		//4.搜索
        qstr="select p.PID,p.brand,p.pname,p.price,p.size,p.picture,p.storename,p.resolution,g.quantity,u.rank,g.date "+
		"from gouwuche_table as g join user_table as u on g.myuser=u.myuser  "+
        "join product_table as p on g.PID=p.PID where g.myuser='"+user+"'";
		rs=st.executeQuery(qstr);
        
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String PID=Integer.toString(rs.getInt("PID"));
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String store=rs.getString("storename");
			String resolution=rs.getString("resolution");
			String quantity=rs.getString("quantity");
			String rank=rs.getString("rank");
			String picture=rs.getString("picture");
			String date=formatter.format(rs.getDate("date"));
			
			%>
			<tr >
			<td align="center"><br>店铺:&nbsp;<%=store %></td>
			</tr>
			<tr style="border-bottom: 1px solid  #CDC9C9;">
			<td align="center"><div style="background-color:#F5F5F5; width:40px; height:40px;text-align: center;vertical-align:bottom;"><input type="checkbox" name="select" value="selected"></div></td>
			<td width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
			<td align="center"><%=brand %>&nbsp;&nbsp;<%=pname %><br><%=size %>英寸&nbsp;&nbsp;分辨率&nbsp;<%=resolution %></td>
			<td align="center"><%=price %></td>
			<td align="center"><%=quantity %><input type="text" name="pid" value="<%=PID%>" style="display:none;"></td>
			<td align="center">
			<%if("10".equals(rank))
				out.println("0.5");
			else
				out.println(10-Integer.parseInt(rank));
				%></td>
			<td align="center"><%
			double total;
			if("10".equals(rank))
				total=(0.05*Integer.parseInt(price)*Integer.parseInt(quantity));
			else
				total=((10-Integer.parseInt(rank))*Integer.parseInt(price)*Integer.parseInt(quantity)/10);
			out.println(total);
			%><input type="text" name="total" value="<%=total%>" style="display:none;"></td>
			<td align="center"><%=date %></td>
			</tr>
			
			<% 
		while(rs.next()){
			String PID1=Integer.toString(rs.getInt("PID"));
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String store1=rs.getString("storename");
			String resolution1=rs.getString("resolution");
			String quantity1=rs.getString("quantity");
			String rank1=rs.getString("rank");
			String picture1=rs.getString("picture");
			String date1=formatter.format(rs.getDate("date"));
			
			%>
			<tr >
			<td align="center">店铺:&nbsp;<%=store1 %></td>
			</tr>
			<tr style="border-bottom: 1px solid	#CDC9C9;">
			<td align="center"><div style="background-color:#F5F5F5; width:40px; height:40px;text-align: center;vertical-align:bottom;"><input type="checkbox" name="select" value="selected"></div></td>
			<td width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>
			<td align="center"><%=brand1 %>&nbsp;&nbsp;<%=pname1 %><br><%=size1 %>英寸&nbsp;&nbsp;分辨率&nbsp;<%=resolution1 %></td>
			<td align="center"><%=price1 %></td>
			<td align="center"><%=quantity1 %><input type="text" name="pid" value="<%=PID1%>" style="display:none;"></td>
			<td align="center">
			<%if("10".equals(rank1))
				out.println("0.5");
			else
				out.println(10-Integer.parseInt(rank1));
				%></td>
			<td align="center"><%
					double total1;
			if("10".equals(rank1))
				total1=(0.05*Integer.parseInt(price1)*Integer.parseInt(quantity1));
			else
				total1=((10-Integer.parseInt(rank1))*Integer.parseInt(price1)*Integer.parseInt(quantity1)/10);
			out.println(total1);
			%><input type="text" name="total" value="<%=total1%>" style="display:none;"></td>
			<td align="center"><%=date1 %></td>
			</tr>
			<% 			
		    }
		}
		else{
			%>
			<tr>
			<td><%="购物车空~" %></td>
			</tr>
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
	

%>
</table>
<div style="width: 90%;text-align: right;">
<br>
<br>
<input type="submit" name="submit" value="去支付" style="width:120px; height:30px;border-radius: 5px; background:#8B3E2F; line-height:20px; text-align:center; color:#fff;font-size:13px;">
</div>
</form>

<%

//获取表单的值，实现支付功能
request.setCharacterEncoding("UTF-8");
String []selects=request.getParameterValues("select");
String []pids=request.getParameterValues("pid");
String []totals=request.getParameterValues("total");
if(selects!=null){
try{
		
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr;
		double alltotal=0;
		//4.删除购物车表里的记录
		for(int i=0;i<selects.length;i++){
			if(selects[i]!=null){//已结账，需要删除购物车记录
        qstr="delete gouwuche_table where myuser='"+user+"' and PID='"+pids[i]+"'";
		st.executeUpdate(qstr);
			}
		}
		//5.计算总价钱
		for(int i=0;i<selects.length;i++){
			if(selects[i]!=null){//需要结账
        alltotal=alltotal+Double.parseDouble(totals[i]);
			}
		}
		%>
		<script type="text/javascript">
		alert("您已支付"+<%=alltotal%>+"元！我们即将发货");
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