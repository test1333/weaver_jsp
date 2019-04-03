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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="/js/weaver.js"></script>
<script type="text/javascript">
function loadWin()
{
//alert("�û������������");
jQuery.ajax({
                url: "http://10.80.136.31:8080/GvoReport/ReportServer?op=fs_load&cmd=sso",
                dataType:"jsonp",//�������jsonp��ʽ
                data:{"fr_username":'OA_PUBLIC',"fr_password":'OA123'},
            	jsonp:"callback",
             	timeout:5000,//��ʱʱ�䣨��λ�����룩
             	success:function(data) {
				    //alert("��ʱ���������������");
             		//window.location="http://10.80.136.31:8080/GvoReport/ReportServer?reportlet=CIMReport%2FSPC_Alarm.cpt";        
                },
             error:function(){
            	 alert("�����������¼��ʱ�򱨱�������쳣,����ϵ������:15850371438");// ��¼ʧ�ܣ���ʱ���������������
                 }
                });
}

</script>
</head>
<body onload="loadWin();">

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
	   <li><a href="/gvo/report/personnel.jsp">���±���</a></li>
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
		<div class="main6" style="color:#333; width:180px;"><a href="/gvo/report/financial.jsp">���±���+</a></div>
       
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ģ��/���幤�������ʱ���</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled������������</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">ί������ʱ���</a></a>-->
		</div>
	  
      </td>
      <td valign="top" height="800" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > <div class="list">
	  <ul>
	  <h4>�������챨��</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=205&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402375755=" target="_blank">����������ͳ�Ʊ���V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=201&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402465270=" target="_blank">�����������ʱ���V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=102&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402550789=" target="_blank">��̨״̬���ܱ���V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=103&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402611711=" target="_blank">��̨ͨѶ״̬���ܱ���V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=202&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402635232=" target="_blank">ARRAY�ι�����������ϸ����V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=203&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402683095=" target="_blank">OLED�ι�����������ϸ����V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=222&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402724493=" target="_blank">����ι�����������ϸ����V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=221&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402780113=" target="_blank">ģ��ι�����������ϸ����V1.0</a></li>	  
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=204&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402829907=" target="_blank">����ί���������ϸ����V1.0</a></li>
	  </ul>
	  <ul>
	  <h4>��汨��</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=223&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402861521=" target="_blank">���Ϲ���Ԥ������V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=224&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402883589=" target="_blank">��Ʒ������ȫ����Լ��V1.0</a></li>
	  </ul>
	  <ul>
	  <h4>���±���</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=226&subCompanyId=24&isfromportal=1&isfromhp=0&e71459403001099=" target="_blank">�����򿨴�����ѯV1.0</a></li>
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