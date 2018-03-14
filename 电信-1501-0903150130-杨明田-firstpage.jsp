<%@page import="java.util.ArrayList"%>
<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="java.sql.*"  %>
<%@ page import="com.product.product"  %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function on_submit(){
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
function table_click(e1,e2,e3,e4,e5,e6,e7,e8,e9){//利用URL传参数
	picture=e4;
	brand=e1;	
	pname=e2;
	store=e3;
	price=e5;
	size=e6;
	resolution=e7;
	recommendman=e9;
	pid=e8;
	var url="product_details.jsp?brand="+encodeURI(encodeURI(brand))+"&pname="+encodeURI(encodeURI(pname))+"&store="+encodeURI(encodeURI(store))+"&price="+encodeURI(encodeURI(price))+"&size="+encodeURI(encodeURI(size))+"&resolution="+encodeURI(encodeURI(resolution))+"&recommendman="+encodeURI(encodeURI(recommendman))+"&pid="+encodeURI(encodeURI(pid))+"&picture="+encodeURI(encodeURI(picture));
	window.location=url;
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%
String user=(String)(request.getSession().getAttribute("username"));
if("manager".equals(user)){
out.println("商品搜索"); 
}else{
	out.println("我要购物"); 
}%></title>
<style type="text/css">
body{
background-color:#EDEDED;
padding: 0px;
margin: 0px;
}
.td{
text-align: center;
}
.tr{
background-color:#FFEFD5;
border-bottom: 15px solid  #EDEDED;


}
</style>
</head>
<body>
<%
if("manager".equals(user)){%>
<jsp:include page="m_head.jsp" flush="true"/> 
<%}else{%>
<jsp:include page="head.jsp" flush="true"/>
<%}%>
<form action="firstpage.jsp" name="form4" method="post"  onsubmit="return on_submit()">
<table>
<tr>
<td width="20%" align="center"><img src="photo/bird.png" width="100px" height="100px"> 
<input type="text" name="dispAll" value="no" style="display: none;">
</td>
<td width="60%" align="center">
<input type="text" name="search" size="50"style="vertical-align: middle; height: 30px; border-color: red;border-width: 1px;font-size: 18px; ">
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
价格区间(可选):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 最低价:<input type="text" name="price_low" size="5" value="" > —— 最高价:<input type="text" name="price_high" size="5" value="">
</td>
</tr>
</table>
</form>

<div>
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
		String price_l=request.getParameter("price_low");
		String price_h=request.getParameter("price_high");
		String dispAll=request.getParameter("dispAll");
		if(dispAll!=null){
			try{
		%>
<table border="0" width="100%">

		<%
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
		String qstr;
		//4.搜索
			int mycounter=5;//用来计数，一行4个商品
		 if(price_l!=null&&price_h!=null){
			 if(price_l!=""&&price_h!=""){
			 int price_low=0;
			 int price_high=0;
			 try {
				     price_low = Integer.parseInt(price_l);
				     price_high = Integer.parseInt(price_h);
				} catch (NumberFormatException e) {
				    e.printStackTrace();
				} 
			if("商品名".equals(type)){
				qstr="select *from product_table where pname like'%"+search+"%'and price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
			else if("全部".equals(type)){
				qstr="select *from product_table where price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
			else if("店名".equals(type)){
				qstr="select *from product_table where storename like'%"+search+"%'and price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
			else if("品牌".equals(type)){
				qstr="select *from product_table where brand like'%"+search+"%'and price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
			else if("分辨率".equals(type)){
				qstr="select *from product_table where resolution like'%"+search+"%'and price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
			else if("尺寸".equals(type)){
				qstr="select *from product_table where size='"+search+"'and price >="+price_low+"and price<="+price_high ;
				rs=st.executeQuery(qstr);
			}
		   }
				else{
					if("商品名".equals(type)){
						qstr="select *from product_table where pname like'%"+search+"%'";
						rs=st.executeQuery(qstr);
					}
					else if("全部".equals(type)){
						qstr="select *from product_table";
						rs=st.executeQuery(qstr);
					}
					else if("店名".equals(type)){
						qstr="select *from product_table where storename like'%"+search+"%'" ;
						rs=st.executeQuery(qstr);
					}
					else if("品牌".equals(type)){
						qstr="select *from product_table where brand like'%"+search+"%'" ;
						rs=st.executeQuery(qstr);
					}
					else if("分辨率".equals(type)){
						qstr="select *from product_table where resolution like'%"+search+"%'" ;
						rs=st.executeQuery(qstr);
					}
					else if("尺寸".equals(type)){
						qstr="select *from product_table where size='"+search+"'" ;
						rs=st.executeQuery(qstr);
					}
				} 
		}
		
			
		 rs.last();
		 int len=rs.getRow();
		 rs.beforeFirst();
		 System.out.println(len);
		if(rs.next()){//查到数据rs.next()可以转到下一行
			String picture=rs.getString("picture");
			String brand=rs.getString("brand");
			String pname=rs.getString("pname");
			String store=rs.getString("storename");
			String price=Integer.toString(rs.getInt("price"));
			String size=rs.getString("size");
			String resolution=rs.getString("resolution");
			String recommendman=rs.getString("myuser");
			String pid=Integer.toString(rs.getInt("PID"));
			if("manager".equals(user)){
			%>
			<tr class="tr">
			<td class="pic" width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
			<td class="td"><%=brand %></td>
			<td class="td"><%=pname %></td>
			<td class="td"><%=store %></td>
			<td class="td"><%=price %></td>
			<td class="td"><%=size %></td>
			<td class="td"><%=resolution %></td>
			<td class="td"><%=recommendman %></td>
			<td class="td"><%=pid %></td>
			</tr>
			<% 
			}
			else{
				if(len<6){//不超过5个商品
					%>
					<tr class="tr">
					<td width="250px" onclick="table_click('<%=brand %>','<%=pname %>','<%=store %>','<%=picture%>','<%=price %>','<%=size %>','<%=resolution %>','<%=pid %>','<%=recommendman %>')">
					<table style="width:250px;">
					<tr style="width: 100%;">
					<td class="pic" width="100%"  align="center"><img src="<%=picture%>" width="90%" height="140px"> </td>
					</tr>
					<tr>
					<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price %></td>
					</tr>
					<tr>
					<td class="td"><%=brand+"  "+pname+" "+size+"英寸"+" 分辨率 "+resolution %></td>
					</tr>
					<tr>
					<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store %></td>
					<td class="td" style="text-align: left;"><%=pid %></td>
					</tr>
					</table>
					</td>
					
					<% 
					len--;
					if(len==0){
						%>
						</tr>
						<% 
					}
				}
				else{
				
				%>
				<tr class="tr">
				<td width="20%" onclick="table_click('<%=brand %>','<%=pname %>','<%=store %>','<%=picture%>','<%=price %>','<%=size %>','<%=resolution %>','<%=pid %>','<%=recommendman %>')">
				<table style="width: 100%;">
				<tr style="width: 100%;">
				<td class="pic" width="100%"  align="center"><img src="<%=picture%>" width="90%" height="140px"> </td>
				</tr>
				<tr>
				<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price %></td>
				</tr>
				<tr>
				<td class="td"><%=brand+"  "+pname+" "+size+"英寸"+" 分辨率 "+resolution %></td>
				</tr>
				<tr>
				<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store %></td>
				<td class="td" style="text-align: left;"><%=pid %></td>
				</tr>
				</table>
				</td>
				
				<% 
				mycounter--;
			}
			}
		while(rs.next()){
			String picture1=rs.getString("picture");
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String recommendman1=rs.getString("myuser");
			String pid1=Integer.toString(rs.getInt("PID"));
			if("manager".equals(user)){
			%>
			<tr class="tr">
			<td class="pic" width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>
			<td class="td"><%=brand1 %></td>
			<td class="td"><%=pname1 %></td>
			<td class="td"><%=store1 %></td>
			<td class="td"><%=price1 %></td>
			<td class="td"><%=size1 %></td>
			<td class="td"><%=resolution1 %></td>
			<td class="td"><%=recommendman1 %></td>
			<td class="td"><%=pid1 %></td>
			</tr>
			<% 
			}
			else{
				if(len<6){
					//只有一行商品
                     %>
					<td width="250px" onclick="table_click('<%=brand1 %>','<%=pname1 %>','<%=store1 %>','<%=picture1%>','<%=price1 %>','<%=size1 %>','<%=resolution1 %>','<%=pid1 %>','<%=recommendman1 %>')">
					<table style="width: 250px;">
					<tr style="width: 100%;">
					<td class="pic" width="100%"  align="center"><img src="<%=picture1%>" width="90%" height="140px"> </td>
					</tr>
					<tr>
					<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price1 %></td>
					</tr>
					<tr>
					<td class="td"><%=brand1+"  "+pname1+" "+size1+"英寸"+" 分辨率 "+resolution1 %></td>
					</tr>
					<tr>
					<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store1 %></td>
					<td class="td" style="text-align: left;"><%=pid1 %></td>
					</tr>
					</table>
					</td>
					<% 
					len--;
					if(len==0){
						%>
						</tr>
						<% 
					}
				}
				else{
					if(mycounter==0){//新建行
					mycounter=4;
					%>
					
					<tr  class="tr">
					<td width="20%" onclick="table_click('<%=brand1 %>','<%=pname1 %>','<%=store1 %>','<%=picture1%>','<%=price1 %>','<%=size1 %>','<%=resolution1 %>','<%=pid1 %>','<%=recommendman1 %>')">
					<table style="width: 100%;">
					<tr style="width: 100%;">
					<td class="pic" width="100%"  align="center"><img src="<%=picture1%>" width="90%" height="140px"> </td>
					</tr>
					<tr>
					<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price1 %></td>
					</tr>
					<tr>
					<td class="td"><%=brand1+"  "+pname1+" "+size1+"英寸"+" 分辨率 "+resolution1 %></td>
					</tr>
					<tr>
					<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store1 %></td>
					<td class="td" style="text-align: left;"><%=pid1 %></td>
					</tr>
					</table>
					</td>
					<% 
				}
				else{
				%>
				<td width="20%" onclick="table_click('<%=brand1 %>','<%=pname1 %>','<%=store1 %>','<%=picture1%>','<%=price1 %>','<%=size1 %>','<%=resolution1 %>','<%=pid1 %>','<%=recommendman1 %>')">
				<table style="width: 100%;">
				<tr style="width: 100%;">
				<td class="pic" width="100%"  align="center"><img src="<%=picture1%>" width="90%" height="140px"> </td>
				</tr>
				<tr>
				<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price1 %></td>
				</tr>
				<tr>
				<td class="td"><%=brand1+"  "+pname1+" "+size1+"英寸"+" 分辨率 "+resolution1 %></td>
				</tr>
				<tr>
				<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store1 %></td>
				<td class="td" style="text-align: left;"><%=pid1 %></td>
				</tr>
				</table>
				</td>
				<% 
				mycounter--;
				if(mycounter==0){
					%>
					</tr>
					<%
				}
				}
			}
			}
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
		}

%>
</table>
</div>
<%//显示全部信息
if(dispAll==null){
	int counter=5;//用来计数，一行4个商品
	%>
<table border="0" width="100%" >

	<%
	
try{
		
		//1.加载驱动程序
		Class.forName(drivername).newInstance();
		//2.建立连接
		con=DriverManager.getConnection(url, s_user, s_password);
		//3.创建Statement对象(在连接上执行SQL语句的容器)
		st=con.createStatement();
		String qstr="select *from product_table";
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
			String pid=Integer.toString(rs.getInt("PID"));
			if("manager".equals(user)){
			%>
			<tr class="tr">
			<td class="pic" width="100px" height="80px"><img src="<%=picture%>" width="100px" height="80px"> </td>
			<td class="td"><%=brand %></td>
			<td class="td"><%=pname %></td>
			<td class="td"><%=store %></td>
			<td class="td"><%=price %></td>
			<td class="td"><%=size %></td>
			<td class="td"><%=resolution %></td>
			<td class="td"><%=recommendman %></td>
			<td class="td"><%=pid %></td>
			</tr>
			<% 
			}
			else{

				%>
				<tr class="tr">
				<td width="20%" onclick="table_click('<%=brand %>','<%=pname %>','<%=store %>','<%=picture%>','<%=price %>','<%=size %>','<%=resolution %>','<%=pid %>','<%=recommendman %>')">
				<table style="width: 100%;">
				<tr style="width: 100%;">
				<td class="pic" width="100%"  align="center"><img src="<%=picture%>" width="90%" height="140px"> </td>
				</tr>
				<tr>
				<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price %></td>
				</tr>
				<tr>
				<td class="td"><%=brand+"  "+pname+" "+size+"英寸"+" 分辨率 "+resolution %></td>
				</tr>
				<tr>
				<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store %></td>
				<td class="td" style="text-align: left;"><%=pid %></td>
				</tr>
				</table>
				</td>
				
				<% 
				counter--;

			}
		while(rs.next()){
			String picture1=rs.getString("picture");
			String brand1=rs.getString("brand");
			String pname1=rs.getString("pname");
			String store1=rs.getString("storename");
			String price1=Integer.toString(rs.getInt("price"));
			String size1=rs.getString("size");
			String resolution1=rs.getString("resolution");
			String recommendman1=rs.getString("myuser");
			String pid1=Integer.toString(rs.getInt("PID"));
			if("manager".equals(user)){
			%>
			<tr class="tr" >
			<td class="pic" width="100px" height="80px"><img src="<%=picture1%>" width="100px" height="80px"> </td>
			<td class="td"><%=brand1 %></td>
			<td class="td"><%=pname1 %></td>
			<td class="td"><%=store1 %></td>
			<td class="td"><%=price1 %></td>
			<td class="td"><%=size1 %></td>
			<td class="td"><%=resolution1 %></td>
			<td class="td"><%=recommendman1 %></td>
			<td class="td"><%=pid1 %></td>
			</tr>
			<% 
			}
			else{
				if(counter==0){//新建行
					counter=4;
					%>
					
					<tr  class="tr">
					<td width="20%" onclick="table_click('<%=brand1 %>','<%=pname1 %>','<%=store1 %>','<%=picture1%>','<%=price1 %>','<%=size1 %>','<%=resolution1 %>','<%=pid1 %>','<%=recommendman1 %>')">
					<table style="width: 100%;">
					<tr style="width: 100%;">
					<td class="pic" width="100%"  align="center"><img src="<%=picture1%>" width="90%" height="140px"> </td>
					</tr>
					<tr>
					<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price1 %></td>
					</tr>
					<tr>
					<td class="td"><%=brand1+"  "+pname1+" "+size1+"英寸"+" 分辨率 "+resolution1 %></td>
					</tr>
					<tr>
					<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store1 %></td>
					<td class="td" style="text-align: left;"><%=pid1 %></td>
					</tr>
					</table>
					</td>
					<% 
				}
				else{
				%>
				<td width="20%" onclick="table_click('<%=brand1 %>','<%=pname1 %>','<%=store1 %>','<%=picture1%>','<%=price1 %>','<%=size1 %>','<%=resolution1 %>','<%=pid1 %>','<%=recommendman1 %>')">
				<table style="width: 100%;">
				<tr style="width: 100%;">
				<td class="pic" width="100%"  align="center"><img src="<%=picture1%>" width="90%" height="140px"> </td>
				</tr>
				<tr>
				<td class="td" style="font-weight: bold;font-size: 20px;color: red;text-align: left;"><%="￥"+price1 %></td>
				</tr>
				<tr>
				<td class="td"><%=brand1+"  "+pname1+" "+size1+"英寸"+" 分辨率 "+resolution1 %></td>
				</tr>
				<tr>
				<td class="td" style="text-align: left;"><img src="photo/store.png" width="30px" height="30px"> <%=store1 %></td>
				<td class="td" style="text-align: left;"><%=pid1 %></td>
				</tr>
				</table>
				</td>
				<% 
				counter--;
				if(counter==0){
					%>
					</tr>
					<%
				}
				}
				
			}
			
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
	<% 
	
}
%>

</body>
</html>