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
    <table>
     <td valign="top" height="100%" frameborder="0" scrolling="auto" width="100%" bordercolor="#FFFFFF" > 
	  <div class="list">
	    <div class="list1">
	      <ul>
	        <h4>人事报表</h4>
			<li class="ys1"><a href="/homepage/Homepage.jsp?hpid=621&subCompanyId=24&isfromportal=1&isfromhp=0&e71471359926212=" target="_blank">HR系统考勤审查数据查询报表V1.0</a></li>
                        <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=663&subCompanyId=24&isfromportal=1&isfromhp=0&e71472632974769=" target="_blank">HR系统结薪考勤综合查询报表V1.0</a></li>
                        <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=701&subCompanyId=24&isfromportal=1&isfromhp=0&e71473661592010=" target="_blank">员工打卡记录(考勤机)查询报表V1.0</a></li>
                        <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=881&subCompanyId=24&isfromportal=1&isfromhp=0&e71479878821456=" target="_blank">员工打卡记录(HR)查询报表V1.0</a></li>
                        <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=721&subCompanyId=24&isfromportal=1&isfromhp=0&e71474857723706=" target="_blank">考勤相关流程查询报表V1.0</a></li>
		        <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=921&subCompanyId=24&isfromportal=1&isfromhp=0&e71481333287438=" target="_blank">固安考勤原始数据查询报表V1.0</a></li>
	      </ul>
		</div> 
	  </div>
	  <div class="list" style="float:right;">
	    <div class="list1">
	      <ul>
		    <h4>考勤规范</h4>
	        <li class="ys1"><a href="/docs/docs/DocDsp.jsp?id=60961" target="_blank">全员考勤作业规范操作</a></li>
	        <li class="ys1"><a href="/docs/docs/DocDsp.jsp?id=63521" target="_blank">助理版考勤作业规范操作手册</a></li>
	      </ul>
		</div> 
	  </div>
	 </td>
   </table> 
  </div>
 </div>
</div>
</body>
</html>
