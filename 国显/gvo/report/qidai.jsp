<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<link rel="stylesheet" type="text/css" href="/gvo/report/css/css.css">

<script type="text/javascript" src="/js/weaver.js"></script>
</head>
<body>

<div class="center">

 <div class="head">
  <div class="headlogo"><img src="images/headlogo.png" /></div></div>
  <div class="reportmenu">
   
    <ul><h3><a href="/gvo/report/index.jsp">首页</a></h3>
	   <li><a href="/gvo/report/report.jsp">生产制造报表</a></li>
	   <li><a href="/gvo/report/production.jsp">品质报表</a></li>
	   <li><a href="/gvo/report/sales.jsp">销售报表</a></li>
	   <li><a href="/gvo/report/procurement.jsp">采购报表</a></li>
	   <li><a href="/gvo/report/inventory.jsp">库存报表</a></li>
	   <li><a href="/gvo/report/financial.jsp">财务报表</a></li>
	</ul>
  </div>
  <div class="content">
     <!--<div class="sidebar">-->
	   <!--<div class="sidebarmenu">
	     <ul>
		   <h3><a href="#">生产制造报表</a></h3>
		   <li><a href="#">模组/屏体工单产出率报表</a></li>
		   <li><a href="#">委外产出率报表</a></li>
		   <li><a href="#">Array/Oled工单产出报表</a></li>
		   
		 </ul>
	   </div>-->
   <table class="special " width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
	  <td width="180" valign="top" bgcolor="#d2d2d2" style="overflow:auto;">
	   <div class="main1" style="color:#333; width:180px;"><a href="/gvo/report/report.jsp">生产制造报表+</a></div>
        <!--<div id="child1" style="display:block">-->
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71458032709765=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
		<div class="main2" style="color:#333; width:180px;"><a href="/gvo/report/production.jsp">品质报表+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
		<div class="main3" style="color:#333; width:180px;"><a href="/gvo/report/sales.jsp">销售报表+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
		<div class="main4" style="color:#333; width:180px;"><a href="/gvo/report/procurement.jsp">采购报表+</a></div>
    
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
		<div class="main5" style="color:#333; width:180px;"><a href="/gvo/report/inventory.jsp">库存报表+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
		<div class="main6" style="color:#333; width:180px;"><a href="/gvo/report/financial.jsp">财务报表+</a></div>
       
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
	  
      </td>
      <td valign="top" height="800" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > <div class="list">
	    <div class="qidai"></div>
	  <ul>
	  <h4>生产制造报表</h4>
	  <a href="#" class="ys1">模组/屏体工单产出率报表</a>
	  <a href="#" class="ys2">Array/Oled工单产出报表</a>
	  <a href="#" class="ys3">委外产出率报表</a>
	  <a href="#" class="ys2">生产制造报表</a>
	  <a href="#" class="ys1">采购报表</a>
	  <a href="#" class="ys2">销售报表</a>
	  </ul>
	  <ul>
	  <h4>生产制造报表</h4>
	  <a href="#" class="ys3">模组/屏体工单产出率报表</a>
	  <a href="#" class="ys2">Array/Oled工单产出报表</a>
	  <a href="#" class="ys1">委外产出率报表</a>
	  <a href="#" class="ys3">生产制造报表</a>
	  <a href="#" class="ys3">采购报表</a>
	  <a href="#" class="ys3">销售报表</a>
	  </ul>
	  <ul>
	  <h4>生产制造报表</h4>
	  <a href="#" class="ys2">模组/屏体工单产出率报表</a>
	  <a href="#" class="ys1">Array/Oled工单产出报表</a>
	  <a href="#" class="ys2">委外产出率报表</a>
	  <a href="#" class="ys3">生产制造报表</a>
	  <a href="#" class="ys3">采购报表</a>
	  <a href="#" class="ys3">销售报表</a>
	  </ul>
	  <ul>
	  <h4>生产制造报表</h4>
	  <a href="#" class="ys1">模组/屏体工单产出率报表</a>
	  <a href="#" class="ys1">Array/Oled工单产出报表</a>
	  <a href="#" class="ys1">委外产出率报表</a>
	  <a href="#" class="ys1">生产制造报表</a>
	  <a href="#" class="ys1">采购报表</a>
	  <a href="#" class="ys1">销售报表</a>
	  </ul>
	  <ul>
	  <h4>生产制造报表</h4>
	  <a href="#" class="ys1">模组/屏体工单产出率报表</a>
	  <a href="#" class="ys1">Array/Oled工单产出报表</a>
	  <a href="#" class="ys1">委外产出率报表</a>
	  <a href="#" class="ys1">生产制造报表</a>
	  <a href="#" class="ys1">采购报表</a>
	  <a href="#" class="ys1">销售报表</a>
	  </ul>
	  </div>
	  
	  </td>
     </tr>
   </table>
	 
  </div>
 
</div>
</body>
</html>
<!-- <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr><td width="180" height="30" bgcolor="#d2d2d2" style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" valign="top" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></td></tr>
       </table>-->
	   <!--</div>-->
	 <!--<div class="mainbody"><a href="/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456814771797=" target="_self">00</a></div>-->