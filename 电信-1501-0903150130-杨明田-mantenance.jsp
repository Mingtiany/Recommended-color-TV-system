<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"  %> 
<%@ include file="m_head.jsp" %>  
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
<title>商品信息维护</title>
<style type="text/css">
body{
  background: -webkit-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Safari 5.1 - 6 */
  background: -o-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Opera 11.1 - 12*/
  background: -moz-linear-gradient(left top,rgba(0,191,255,0.3),rgba(255,140,0,1)); /* Firefox 3.6 - 15*/
  background: linear-gradient(to bottom right, rgba(0,191,255,0.3), rgba(255,140,0,1)); /* 标准的语法 */
  background-repeat: no repeat;
  background-attachment: fixed;
}
</style>

</head>
<body>
<br>
<form action="mantenance.jsp" name="form5" method="post"  onsubmit="return on_submit()">
<table cellspacing="0" width="100%">
<tr>
<td width="60%" style="text-align: right;" >
<input type="text" name="search" size="50"style="vertical-align: middle; height: 30px; border-color: red;border-width: 1px;font-size: 18px; ">
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
</td>
</tr>
</table>
</form>

<table align="center" width="100%">
<tr>
<td align="center">
<div>
<form action="mantenance.jsp" method="post" >
<table border="0" width="100%" cellpadding="0" cellspacing="0" style="background-color: rgba(255,215,0,0.3);">
<tr>
<th>商品编号</th>
<th>品牌</th>
<th>商品名</th>
<th>店名</th>
<th>价格</th>
<th>尺寸</th>
<th>分辨率</th>
<th>操作类型</th>
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
        String submit=request.getParameter("submit");
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
						if("全部".equals(type)){
							qstr="select *from product_table ";
							rs=st.executeQuery(qstr);
						}
						else if("商品名".equals(type)){
							qstr="select *from product_table where pname like'%"+search+"%'";
							rs=st.executeQuery(qstr);
						}
						else if("店名".equals(type)){
							qstr="select *from product_table where storename like'%"+search+"%'";
							rs=st.executeQuery(qstr);
						}
						else if("品牌".equals(type)){
							qstr="select *from product_table where brand like'%"+search+"%'";
							rs=st.executeQuery(qstr);
						}
						else if("分辨率".equals(type)){
							qstr="select *from product_table where resolution like'%"+search+"%'";
							rs=st.executeQuery(qstr);
						}
						else if("尺寸".equals(type)){
							qstr="select *from product_table where size='"+search+"'";
							rs=st.executeQuery(qstr);
						}
						
					
				} 

		
        
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String pid=Integer.toString(rs.getInt("PID"));
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			%>
			<tr>
			<td><select name="pid"><option selected="selected" value="<%=pid %>"><%=pid %></option></select></td>
			<td align="center"><input type="text" name="brand" size="5" value="<%=brand%>"></td>
			<td align="center"><input type="text" name="pname" size="30" value="<%=pname%>"></td>
			<td align="center"><input type="text" name="store" size="10" value="<%=store%>"></td>
			<td align="center"><input type="text" name="price" size="5" value="<%=price%>"></td>
			<td align="center"><input type="text" name="size" size="5" value="<%=size%>"></td>
			<td align="center"><input type="text" name="resolution" size="10" value="<%=resolution%>"></td>
			<td align="center"><select name="operatetype"><option selected="selected" value="hold">忽略</option> <option value="modify">修改</option><option value="delete">删除</option></select></td>
			</tr>
			<% 
		while(rs.next()){
			String pid1=Integer.toString(rs.getInt("PID"));
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			%>
			<tr>
			<td><select name="pid"><option selected="selected" value="<%=pid1 %>"><%=pid1 %></option></select></td>
			<td align="center"><input type="text" name="brand" size="5" value="<%=brand1%>"></td>
			<td align="center"><input type="text" name="pname" size="30" value="<%=pname1%>"></td>
			<td align="center"><input type="text" name="store" size="10" value="<%=store1%>"></td>
			<td align="center"><input type="text" name="price" size="5" value="<%=price1%>"></td>
			<td align="center"><input type="text" name="size" size="5" value="<%=size1%>"></td>
			<td align="center"><input type="text" name="resolution" size="10" value="<%=resolution1%>"></td>
			<td align="center"><select name="operatetype"><option selected="selected" value="hold">忽略</option> <option value="modify">修改</option><option value="delete">删除</option></select></td>
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
<input type="submit" name="submit1" value="提交修改" style="width:120px; height:30px;border-radius: 5px; background:#8B3E2F; line-height:20px; text-align:center; color:#fff;font-size:13px;">
</form>
</div>
</td>
</tr>
</table>

<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.util.Date currentTime = new java.util.Date();//得到当前系统时间
String str_date = formatter.format(currentTime); //将日期时间格式化  


//将修改的数据写入数据库

request.setCharacterEncoding("UTF-8");
String [] pids=request.getParameterValues("pid");
String [] brands=request.getParameterValues("brand");
String [] pnames=request.getParameterValues("pname");
String [] stores=request.getParameterValues("store");
String [] prices=request.getParameterValues("price");
String [] sizes=request.getParameterValues("size");
String [] resolutions=request.getParameterValues("resolution");
String [] operatetypes=request.getParameterValues("operatetype");
 
 try{
//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr;
		//4.保存修改
		if(brands!=null){
			
			for(int i=0;i<brands.length;i++){
				//删除
				if("delete".equals(operatetypes[i])){
					
					//删除商品表里的记录
					qstr="delete product_table where PID='"+Integer.parseInt(pids[i])+"'";
					st.executeUpdate(qstr);
					//将删除记录保存在操作表里
					qstr="insert into operate_table values('"+Integer.parseInt(pids[i])+"','"+pnames[i]+"','"+prices[i]+"','"+stores[i]+"','"+brands[i]+"','"+sizes[i]+"','"+resolutions[i]+"','"+str_date+"','删除')";
					st.executeUpdate(qstr);
				}
				else if("modify".equals(operatetypes[i])){//修改
					//修改用户表里的记录
					System.out.println("修改");
					qstr="update product_table set brand='"+brands[i]+"',pname='"+pnames[i]+"',storename='"+stores[i]+"',price='"+prices[i]+"',size='"+sizes[i]+"',resolution='"+resolutions[i]+"' where PID='"+Integer.parseInt(pids[i])+"'";
					st.executeUpdate(qstr);
					//将修改记录保存在操作表里
					qstr="insert into operate_table values('"+Integer.parseInt(pids[i])+"','"+pnames[i]+"','"+prices[i]+"','"+stores[i]+"','"+brands[i]+"','"+sizes[i]+"','"+resolutions[i]+"','"+str_date+"','修改')";
					st.executeUpdate(qstr);
				}
				
			}
			
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
</body>
</html>