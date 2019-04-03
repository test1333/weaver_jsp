<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
<link rel="stylesheet" type="text/css" href="/gvo/report/css/css.css">
<script type="text/javascript" src="/js/jquery.js"></script>
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
 
  <div class="content">
	  
      </td>
      <td valign="top" height="100%" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > 
	  <div class="list">
	  
	    <div class="list1">
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
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=241&subCompanyId=24&isfromportal=1&isfromhp=0&e71461035976754=" target="_blank">各站产品统计报表V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=402&subCompanyId=24&isfromportal=1&isfromhp=0&e71464227407699=" target="_blank">生产周期报表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=442&subCompanyId=24&isfromportal=1&isfromhp=0&e71467191017572=" target="_blank">投入产出平衡表V1.0</a></li>
	  </ul></div>
	  <div class="list1">
	  <ul>
	  <h4>财务报表</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=281&subCompanyId=24&isfromportal=1&isfromhp=0&e71461722519508=" target="_blank">利润指标分析报表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=341&subCompanyId=24&isfromportal=1&isfromhp=0&e71462860267414=" target="_blank">供应商付款计划V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=381&subCompanyId=24&isfromportal=1&isfromhp=0&e71463469101560=" target="_blank">应收款账龄分析表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=401&subCompanyId=24&isfromportal=1&isfromhp=0&e71464227279452=" target="_blank">应付款账龄分析表V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=441&subCompanyId=24&isfromportal=1&isfromhp=0&e71467190676439=" target="_blank">费用报销汇总表V1.0</a></li>
	  </ul>
	   
	  </div>
	   <div class="list1">
	  <ul>
	  <h4>库存报表</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=223&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402861521=" target="_blank">物料过期预警报表V1.0</a></li>
	  <li class="ys2"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=224&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402883589=" target="_blank">备品备件安全库存自检表V1.0</a></li>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=301&subCompanyId=24&isfromportal=1&isfromhp=0&e71462260269697=" target="main">物料呆滞分析报表V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=321&subCompanyId=24&isfromportal=1&isfromhp=0&e71462762104521=" target="main">主要物料库龄分析表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>人事报表</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=226&subCompanyId=24&isfromportal=1&isfromhp=0&e71459403001099=" target="_blank">月忘打卡次数查询V1.0</a></li>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=261&subCompanyId=24&isfromportal=1&isfromhp=0&e71461679552601=" target="_blank">人员离职信息表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>销售报表</h4>
	  <li class="ys1"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=361&subCompanyId=24&isfromportal=1&isfromhp=0&e71463370158129=" target="_blank">销售额汇总报表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>采购报表</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=421&subCompanyId=24&isfromportal=1&isfromhp=0&e71466502532970=" target="_blank">采购准时交货率V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>文档报表</h4>
	  <li class="ys3"><a href="http://222.92.108.195:8082/homepage/Homepage.jsp?hpid=461&subCompanyId=24&isfromportal=1&isfromhp=0&e71467941766646=" target="_blank">文件归档查询报表V1.0</a></li>
	  </ul></div>
	  </div>
	  </div>
	  
	  </td>
     </tr>
   </table>
	 
  </div>
 
</div>
</body>
</html>
