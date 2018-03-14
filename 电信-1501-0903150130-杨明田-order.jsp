<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function on_submit(){
	if(form5.searchtype.value!="全部"&form5.search.value==""){
		alert("搜索框不能为空！！");
		form5.search.focus();
		return false;
	}
	if(form5.searchtype.value=="全部"&form5.search.value!=""){
		alert("请选择搜索类型！！");
		form5.search.focus();
		return false;
	}
	
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品排名</title>
<style type="text/css">
body{
background-color:#EDEDED;
padding: 0px;
margin: 0px;
}
.td{
text-align: center;
}
</style>
</head>
<body>
<%
String user=(String)(request.getSession().getAttribute("username"));
if("manager".equals(user)){%>
<jsp:include page="m_head.jsp" flush="true"/> 
<%}else{%>
<jsp:include page="head.jsp" flush="true"/>
<%}%>
<form action="order.jsp" name="form" method="post"  onsubmit="return on_submit()">
<table>
<tr>
<td width="20%" align="center"><img src="photo/bird.png" width="100px" height="100px"> 
<input type="text" name="dispAll" value="no" style="display: none;">
</td>
<td width="60%" align="center">
<input type="text" name="search" size="50"style="vertical-align: middle; height: 30px; border-color: red;border-width: 1px;font-size: 18px; ">
<input type="submit" name="submit" value="排名" style="width:80px;vertical-align: middle; height:38px;border-radius: 5px; background:red; line-height:20px; text-align:center; color:#fff;font-size:16px;">
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
按<select name="ordertype">
<option selected="selected">价格从高到低</option>
<option>价格从低到高</option>
</select>排名
</td>
</tr>
</table>
</form>


<div>
<table border="0" width="100%" class="table">
<tr> 
<th>品牌</th>
<th>商品名</th>
<th>店名</th>
<th>价格</th>
<th>尺寸</th>
<th>分辨率</th>
<th>推荐人</th>
</tr>
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
        //提取表单的数据
        request.setCharacterEncoding("UTF-8");
        String type=request.getParameter("searchtype");
        String search=request.getParameter("search");
        String order=request.getParameter("ordertype"); 
			try{
		
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr;
		//4.搜索
				if(type!=null){
					if("价格从高到低".equals(order)){
					if("全部".equals(type)){
						qstr="select *from product_table order by price desc";
						rs=st.executeQuery(qstr);
					}
					else if("商品名".equals(type)){
						qstr="select *from product_table where pname like'%"+search+"%'order by price desc";
						rs=st.executeQuery(qstr);
					}
					else if("店名".equals(type)){
						qstr="select *from product_table where storename like'%"+search+"%'order by price desc";
						rs=st.executeQuery(qstr);
					}
					else if("品牌".equals(type)){
						qstr="select *from product_table where brand like'%"+search+"%'order by price desc";
						rs=st.executeQuery(qstr);
					}
					else if("分辨率".equals(type)){
						qstr="select *from product_table where resolution like'%"+search+"%'order by price desc";
						rs=st.executeQuery(qstr);
					}
					else if("尺寸".equals(type)){
						qstr="select *from product_table where size='"+search+"'order by price desc";
						rs=st.executeQuery(qstr);
					}
					}
					else{//价格从低到高
						if("全部".equals(type)){
							qstr="select *from product_table order by price";
							rs=st.executeQuery(qstr);
						}
						else if("商品名".equals(type)){
							qstr="select *from product_table where pname like'%"+search+"%' order by price";
							rs=st.executeQuery(qstr);
						}
						else if("店名".equals(type)){
							qstr="select *from product_table where storename like'%"+search+"%' order by price";
							rs=st.executeQuery(qstr);
						}
						else if("品牌".equals(type)){
							qstr="select *from product_table where brand like'%"+search+"%' order by price";
							rs=st.executeQuery(qstr);
						}
						else if("分辨率".equals(type)){
							qstr="select *from product_table where resolution like'%"+search+"%' order by price";
							rs=st.executeQuery(qstr);
						}
						else if("尺寸".equals(type)){
							qstr="select *from product_table where size='"+search+"' order by price";
							rs=st.executeQuery(qstr);
						}
						
					}
				} 

		
        
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			String recommendman=rs.getString("myuser");
			%>
			<tr>
			<td class="td"><%=brand %></td>
			<td class="td"><%=pname %></td>
			<td class="td"><%=store %></td>
			<td class="td"><%=price %></td>
			<td class="td"><%=size %></td>
			<td class="td"><%=resolution %></td>
			<td class="td"><%=recommendman %></td>
			</tr>
			<% 
		while(rs.next()){
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String recommendman1=rs.getString("myuser");
			%>
			<tr>
			<td class="td"><%=brand1 %></td>
			<td class="td"><%=pname1 %></td>
			<td class="td"><%=store1 %></td>
			<td class="td"><%=price1 %></td>
			<td class="td"><%=size1 %></td>
			<td class="td"><%=resolution1 %></td>
			<td class="td"><%=recommendman1 %></td>
			</tr>
			<% 
		    }
		}
		else{
			%>
			<tr>
			<td><%="查不到相应数据~" %></td>
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
</div>

</body>
</html>