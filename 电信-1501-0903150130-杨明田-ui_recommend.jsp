<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"  %>
<%@ include file="head.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function brandfocus(){
	//品牌输入框聚焦
	form2.brand.focus();
}
function on_submit(){
	//验证数据合法性
	if(form2.brand.value==""){
		alert("品牌不能为空！请输入品牌！");
		form2.brand.focus();
		return false;
	}
	if(form2.storename.value==""){
		alert("商家不能为空！请输入商家！");
		form2.storename.focus();
		return false;
	}
	if(form2.pname.value==""){
		alert("商品名称不能为空！请输入商品名称！");
		form2.pname.focus();
		return false;
	}
	if(form2.price.value==""){
		alert("商品价格不能为空！请输入价格！");
		form2.price.focus();
		return false;
	}
	if(form2.size.value==""){
		alert("商品尺寸不能为空！请输入尺寸！");
		form2.size.focus();
		return false;
	}
	if(form2.picture.value==""){
		alert("请上传图片！");
		return false;
	}
	
}
function td_click(e){//点击事件
	//显示图片
	var mypicture=document.getElementById("picture");
	mypicture.src=e;
	//设置需要传的图片路径
	var pictures=document.getElementById("pictures");
	pictures.value=e;
}
function selectpicture(){
	//让图像框显示出来
	var selectpicture=document.getElementById('selectpicture');
	selectpicture.style.display='table-row';
	var selectpicture1=document.getElementById('selectpicture1');
	selectpicture1.style.display='table-row';
	
}
function on_submit1(){
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品推荐系统-商品推荐</title>
<style type="text/css">
body{
background-color:#EDEDED;
padding: 0px;
margin: 0px;
}
div{
width:900px;
text-align:center;
margin:50px auto;
border:1px dashed 	#DCDCDC;
}
</style>
</head>
<body onload="brandfocus()">
<%
//获取登录的对象
String user=(String)request.getSession().getAttribute("username");
%>
<form action="firstpage.jsp" name="form4" method="post"  onsubmit="return on_submit1()">
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

<div style="background-color:#fff;">
<form name="form2" action="ui_recommend.jsp" method="post" onsubmit="return on_submit()">
<table width="70%" border="0" align="center"cellspacing="20px" >
<tr>
<td width="50%" align="left">品牌:</td>
<td width="50%" align="left"><input type="text" name="brand" size="20px"></td>
</tr>
<tr>
<td width="50%" align="left">商家:</td>
<td width="50%" align="left"><input type="text" name="storename" size="20px"></td>
</tr>
<tr>
<td width="50%" align="left">商品名称:</td>
<td width="50%" align="left"><input type="text" name="pname" size="20px"></td>
</tr>
<tr>
<td width="50%" align="left">价钱:</td>
<td width="50%" align="left"><input type="text" name="price" size="20px"></td>
</tr>
<tr>
<td width="50%" align="left" >尺寸:</td>
<td width="50%" align="left"><input type="text" name="size" size="20px"></td>
</tr>
<tr>
<td width="50%" align="left">分辨率:</td>
<td width="50%" align="left">
	<select name="resolution">
	<option>1024*768</option>
	<option>1280*720</option>
	<option>1280*1080</option>
	<option>1920*1080</option>
	<option>3840*2160</option>
</select></td>
</tr>
<tr>
<td width="50%" align="left">上传图片:</td>
<td><img id="picture" width="150px" height="100px" onclick="selectpicture()"><input type="text" id="pictures" name="picture" value="" style="display:none;"> </td>
</tr>
<tr id="selectpicture" style="display: none;">
<td width="50%" align="right">
<table>
<tr>
<td onclick="td_click('photo/TV1.jpg')"><img id="p1" src="photo/TV1.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV2.jpg')"><img id="p2" src="photo/TV2.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV3.jpg')"><img id="p3" src="photo/TV3.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV4.jpg')"><img id="p3" src="photo/TV4.jpg" width="50px" height="50px"></td>
</tr>
</table>
</td>
<td width="50%" align="left">
<table>
<tr>
<td onclick="td_click('photo/TV5.jpg')"><img id="p1" src="photo/TV5.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV6.jpg')"><img id="p2" src="photo/TV6.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV7.jpg')"><img id="p3" src="photo/TV7.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV8.jpg')"><img id="p3" src="photo/TV8.jpg" width="50px" height="50px"></td>
</tr>
</table>
</td>
</tr>
<tr id="selectpicture1" style="display: none;">
<td width="50%" align="right">
<table>
<tr>
<td onclick="td_click('photo/TV9.jpg')"><img id="p1" src="photo/TV9.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV10.jpg')"><img id="p2" src="photo/TV10.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV11.jpg')"><img id="p3" src="photo/TV11.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV12.jpg')"><img id="p3" src="photo/TV12.jpg" width="50px" height="50px"></td>
</tr>
</table>
</td>
<td width="50%" align="left">
<table>
<tr>
<td onclick="td_click('photo/TV13.jpg')"><img id="p1" src="photo/TV13.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV14.jpg')"><img id="p2" src="photo/TV14.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV15.jpg')"><img id="p3" src="photo/TV15.jpg" width="50px" height="50px"></td>
<td onclick="td_click('photo/TV16.jpg')"><img id="p3" src="photo/TV16.jpg" width="50px" height="50px"></td>
</tr>
</table>
</td>
</tr>
<tr>
<td width="50%" align="right">
<p><br><input type="submit" name="submit" value="一键推荐" style="width:120px; height:30px;border-radius: 5px; background:#8E8E8E; line-height:30px; text-align:center; color:#fff;font-size:13px;"></p>
</td>
</tr>
</table>
</form>
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
request.setCharacterEncoding("UTF-8");
String brand=request.getParameter("brand");
String storename=request.getParameter("storename");
String pname=request.getParameter("pname");
String price=request.getParameter("price");
String size=request.getParameter("size");
String resolution=request.getParameter("resolution");
String picture=request.getParameter("picture");
int RPID=0;
Connection con=null;
Statement st=null;
ResultSet rs=null;
if(brand!=null){
try{
	//1.加载驱动程序
	Class.forName(drivername).newInstance();
	//2.建立连接
	con=DriverManager.getConnection(url, s_user, s_password);
	//3.创建Statement对象(在连接上执行SQL语句的容器)
	st=con.createStatement();
	//4.查看是否别人推荐过
	qstr="select *from recommend_product_table where pname='"+pname+"' and price='"+price+"' and storename='"+storename+"' and brand='"+brand+"' and size='"+size+"' and resolution='"+resolution+"'";
	rs=st.executeQuery(qstr);
	if(rs.next()){//别人推荐过了
		%>
		<script type="text/javascript">
		alert("Sorry！此商品别人已推荐过");
		</script>
	<% 	
	}
	//5.将数据插入数据库
	else{
	qstr="select COUNT(*) as 'num' from recommend_product_table";
	rs=st.executeQuery(qstr); 
	while(rs.next()){
		RPID=rs.getInt("num");
		RPID=RPID+1;
	}
	%>
	<script type="text/javascript">
		alert("恭喜！！推荐成功！");
	</script>
	<% 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date();//得到当前系统时间
	String str_date1 = formatter.format(currentTime); //将日期时间格式化  
	qstr="insert into recommend_product_table (RPID,pname,price,storename,brand,size,resolution,myuser,state,date_recommend,picture) values("+"'"+RPID+"'"+",'"+pname+"','"+price+"','"+storename+"','"+brand+"','"+size+"','"+resolution+"','"+user+"','WaitingForAudit','"+str_date1+"','"+picture+"')";
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
</body>
</html>