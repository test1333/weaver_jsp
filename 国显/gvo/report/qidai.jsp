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
   
    <ul><h3><a href="/gvo/report/index.jsp">��ҳ</a></h3>
	   <li><a href="/gvo/report/report.jsp">�������챨��</a></li>
	   <li><a href="/gvo/report/production.jsp">Ʒ�ʱ���</a></li>
	   <li><a href="/gvo/report/sales.jsp">���۱���</a></li>
	   <li><a href="/gvo/report/procurement.jsp">�ɹ�����</a></li>
	   <li><a href="/gvo/report/inventory.jsp">��汨��</a></li>
	   <li><a href="/gvo/report/financial.jsp">���񱨱�</a></li>
	</ul>
  </div>
  <div class="content">
     <!--<div class="sidebar">-->
	   <!--<div class="sidebarmenu">
	     <ul>
		   <h3><a href="#">�������챨��</a></h3>
		   <li><a href="#">ģ��/���幤�������ʱ���</a></li>
		   <li><a href="#">ί������ʱ���</a></li>
		   <li><a href="#">Array/Oled������������</a></li>
		   
		 </ul>
	   </div>-->
   <table class="special " width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
	  <td width="180" valign="top" bgcolor="#d2d2d2" style="overflow:auto;">
	   <div class="main1" style="color:#333; width:180px;"><a href="/gvo/report/report.jsp">�������챨��+</a></div>
        <!--<div id="child1" style="display:block">-->
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71458032709765=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
		<div class="main2" style="color:#333; width:180px;"><a href="/gvo/report/production.jsp">Ʒ�ʱ���+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
		<div class="main3" style="color:#333; width:180px;"><a href="/gvo/report/sales.jsp">���۱���+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
		<div class="main4" style="color:#333; width:180px;"><a href="/gvo/report/procurement.jsp">�ɹ�����+</a></div>
    
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
		<div class="main5" style="color:#333; width:180px;"><a href="/gvo/report/inventory.jsp">��汨��+</a></div>
        
		   <!--<a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
		<div class="main6" style="color:#333; width:180px;"><a href="/gvo/report/financial.jsp">���񱨱�+</a></div>
       
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
	  
      </td>
      <td valign="top" height="800" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > <div class="list">
	    <div class="qidai"></div>
	  <ul>
	  <h4>�������챨��</h4>
	  <a href="#" class="ys1">ģ��/���幤�������ʱ���</a>
	  <a href="#" class="ys2">Array/Oled������������</a>
	  <a href="#" class="ys3">ί������ʱ���</a>
	  <a href="#" class="ys2">�������챨��</a>
	  <a href="#" class="ys1">�ɹ�����</a>
	  <a href="#" class="ys2">���۱���</a>
	  </ul>
	  <ul>
	  <h4>�������챨��</h4>
	  <a href="#" class="ys3">ģ��/���幤�������ʱ���</a>
	  <a href="#" class="ys2">Array/Oled������������</a>
	  <a href="#" class="ys1">ί������ʱ���</a>
	  <a href="#" class="ys3">�������챨��</a>
	  <a href="#" class="ys3">�ɹ�����</a>
	  <a href="#" class="ys3">���۱���</a>
	  </ul>
	  <ul>
	  <h4>�������챨��</h4>
	  <a href="#" class="ys2">ģ��/���幤�������ʱ���</a>
	  <a href="#" class="ys1">Array/Oled������������</a>
	  <a href="#" class="ys2">ί������ʱ���</a>
	  <a href="#" class="ys3">�������챨��</a>
	  <a href="#" class="ys3">�ɹ�����</a>
	  <a href="#" class="ys3">���۱���</a>
	  </ul>
	  <ul>
	  <h4>�������챨��</h4>
	  <a href="#" class="ys1">ģ��/���幤�������ʱ���</a>
	  <a href="#" class="ys1">Array/Oled������������</a>
	  <a href="#" class="ys1">ί������ʱ���</a>
	  <a href="#" class="ys1">�������챨��</a>
	  <a href="#" class="ys1">�ɹ�����</a>
	  <a href="#" class="ys1">���۱���</a>
	  </ul>
	  <ul>
	  <h4>�������챨��</h4>
	  <a href="#" class="ys1">ģ��/���幤�������ʱ���</a>
	  <a href="#" class="ys1">Array/Oled������������</a>
	  <a href="#" class="ys1">ί������ʱ���</a>
	  <a href="#" class="ys1">�������챨��</a>
	  <a href="#" class="ys1">�ɹ�����</a>
	  <a href="#" class="ys1">���۱���</a>
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
          <tr><td width="180" height="30" bgcolor="#d2d2d2" style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a></td></tr>
          <tr bgcolor="#d2d2d2"><td height="30" valign="top" bgcolor="#d2d2d2"  style="border-bottom:1px dashed #333;"><a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></td></tr>
       </table>-->
	   <!--</div>-->
	 <!--<div class="mainbody"><a href="/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456814771797=" target="_self">00</a></div>-->