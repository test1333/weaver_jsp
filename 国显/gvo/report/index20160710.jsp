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
//alert("用户名或密码错误");
jQuery.ajax({
                url: "http://10.80.136.31:8080/GvoReport/ReportServer?op=fs_load&cmd=sso",
                dataType:"jsonp",//跨域采用jsonp方式
                data:{"fr_username":'OA_PUBLIC',"fr_password":'OA123'},
            	jsonp:"callback",
             	timeout:5000,//超时时间（单位：毫秒）
             	success:function(data) {
				    //alert("超时或服务器其他错误");
             		//window.location="http://10.80.136.31:8080/GvoReport/ReportServer?reportlet=CIMReport%2FSPC_Alarm.cpt";        
                },
             error:function(){
            	 alert("报表服务器登录超时或报表服务器异常,请联系赵盼明:15850371438");// 登录失败（超时或服务器其他错误）
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
   
    <ul><h3><a href="/gvo/report/index.jsp">首页</a></h3>
	   <li><a href="/gvo/report/report.jsp">生产制造报表</a></li>
	   <li><a href="/gvo/report/production.jsp">品质报表</a></li>
	   <li><a href="/gvo/report/sales.jsp">销售报表</a></li>
	   <li><a href="/gvo/report/procurement.jsp">采购报表</a></li>
	   <li><a href="/gvo/report/inventory.jsp">库存报表</a></li>
	   <li><a href="/gvo/report/financial.jsp">财务报表</a></li>
	   <li><a href="/gvo/report/personnel.jsp">人事报表</a></li>
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
		<div class="main6" style="color:#333; width:180px;"><a href="/gvo/report/financial.jsp">人事报表+</a></div>
       
		  <!-- <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">模组/屏体工单产出率报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">Array/Oled工单产出报表</a>
		   <a href="http://10.80.4.156:8083/homepage/Homepage.jsp?hpid=201&subCompanyId=1&isfromportal=1&isfromhp=0&e71456885369270=" target="main">委外产出率报表</a></a>-->
		</div>
	  
      </td>
      <td valign="top" height="800" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > <div class="list">
	  <ul>
	  <h4>生产制造报表</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=205&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402375755=" target="_blank">工单报废率统计报表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=201&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402465270=" target="_blank">量产批次良率报表V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=102&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402550789=" target="_blank">机台状态汇总报表V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=103&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402611711=" target="_blank">机台通讯状态汇总报表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=202&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402635232=" target="_blank">ARRAY段工单产出率明细报表V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=203&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402683095=" target="_blank">OLED段工单产出率明细报表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=222&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402724493=" target="_blank">屏体段工单产出率明细报表V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=221&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402780113=" target="_blank">模组段工单产出率明细报表V1.0</a></li>	  
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=204&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402829907=" target="_blank">薄化委外产出率明细报表V1.0</a></li>
	  </ul>
	  <ul>
	  <h4>库存报表</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=223&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402861521=" target="_blank">物料过期预警报表V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=224&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402883589=" target="_blank">备品备件安全库存自检表V1.0</a></li>
	  </ul>
	  <ul>
	  <h4>人事报表</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=226&subCompanyId=24&isfromportal=1&isfromhp=0&e71459403001099=" target="_blank">月忘打卡次数查询V1.0</a></li>
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