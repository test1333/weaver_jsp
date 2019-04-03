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
	        <h4>生产制造报表</h4>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=205&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402375755=" target="_blank">工单报废率统计报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=201&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402465270=" target="_blank">量产批次良率报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=102&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402550789=" target="_blank">机台状态汇总报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=103&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402611711=" target="_blank">机台通讯状态汇总报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=202&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402635232=" target="_blank">ARRAY段工单产出率明细报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=203&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402683095=" target="_blank">OLED段工单产出率明细报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=222&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402724493=" target="_blank">屏体段工单产出率明细报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=221&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402780113=" target="_blank">模组段工单产出率明细报表V1.0</a></li>	  
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=204&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402829907=" target="_blank">薄化委外产出率明细报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=241&subCompanyId=24&isfromportal=1&isfromhp=0&e71461035976754=" target="_blank">各站产品统计报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=402&subCompanyId=24&isfromportal=1&isfromhp=0&e71464227407699=" target="_blank">生产周期报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=442&subCompanyId=24&isfromportal=1&isfromhp=0&e71467191017572=" target="_blank">投入产出平衡表V1.0</a></li>
	  </ul></div> <div class="list1">
	   <ul>
	  <h4>运营报表</h4>
          <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=741&subCompanyId=24&isfromportal=1&isfromhp=0&e71475126928520=" target="_blank">专家库信息查询报表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=761&subCompanyId=24&isfromportal=1&isfromhp=0&e71475892699723=" target="_blank">决策委员会议题报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=565&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387349247=" target="_blank">人员变动情况表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=581&subCompanyId=24&isfromportal=1&isfromhp=0&e71470712757075=" target="_blank">人力编制报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=541&subCompanyId=24&isfromportal=1&isfromhp=0&e71470386796391=" target="_blank">综合良率报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=542&subCompanyId=24&isfromportal=1&isfromhp=0&e71470386879088=" target="_blank">不良代码分则明细V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=543&subCompanyId=24&isfromportal=1&isfromhp=0&e71470386957113=" target="_blank">原材料库存情况表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=544&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387026032=" target="_blank">量产品库存情况V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=547&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387118321=" target="_blank">月度接单情况V1.0</a></li>  
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=548&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387151181=" target="_blank">月度客户情况V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=561&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387183649=" target="_blank">月度销售目标跟踪表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=563&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387231858=" target="_blank">原材料进料检验情况V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=545&subCompanyId=24&isfromportal=1&isfromhp=0&e71470638794899=" target="_blank">原材料到货状况表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=564&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387304797=" target="_blank">月度生产情况V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=566&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387375382=" target="_blank">样品开发进度表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=567&subCompanyId=24&isfromportal=1&isfromhp=0&e71472736847319=" target="_blank">工厂能耗情况表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=570&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387712634=" target="_blank">客诉分析表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=574&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387878779=" target="_blank">集团知识产权统计V1.0</a></li>	  
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=571&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387739328=" target="_blank">按公司统计专利情况表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=572&subCompanyId=24&isfromportal=1&isfromhp=0&e71478326232189=" target="_blank">国显各中心发明专利完成情况表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=546&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387080505=" target="_blank">产品实际出货情况及未来三个月出货预测V1.0</a></li> 
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=562&subCompanyId=24&isfromportal=1&isfromhp=0&e71470387257797=" target="_blank">实际销售情况及未来三个月销售计划表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=801&subCompanyId=24&isfromportal=1&isfromhp=0&e71476768428747=" target="_blank">接单未出库汇总表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=1001&subCompanyId=24&isfromportal=1&isfromhp=0&e71484803405204=" target="_blank">年度客户情况V1.0</a></li>
	  </div>
	  <div class="list1">
	  <ul>
	  <h4>财务报表</h4>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=281&subCompanyId=24&isfromportal=1&isfromhp=0&e71461722519508=" target="_blank">利润指标分析报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=341&subCompanyId=24&isfromportal=1&isfromhp=0&e71462860267414=" target="_blank">供应商付款计划V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=381&subCompanyId=24&isfromportal=1&isfromhp=0&e71463469101560=" target="_blank">应收款账龄分析表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=401&subCompanyId=24&isfromportal=1&isfromhp=0&e71464227279452=" target="_blank">应付款账龄分析表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=441&subCompanyId=24&isfromportal=1&isfromhp=0&e71467190676439=" target="_blank">国显费用报销汇总表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=681&subCompanyId=24&isfromportal=1&isfromhp=0&e71472737149682=" target="_blank">工单目标成本和实际成本差异分析表V1.0</a></li>
          <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=981&subCompanyId=24&isfromportal=1&isfromhp=0&e71483063475441=" target="_blank">PM个人借款汇总表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=1021&subCompanyId=24&isfromportal=1&isfromhp=0&e71487125176313=" target="_blank">维信诺应付款明细查询报表V1.0</a></li>
	  </ul>
	   
	  </div>
	   <div class="list1">
	  <ul>
	  <h4>库存报表</h4>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=223&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402861521=" target="_blank">物料过期预警报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=224&subCompanyId=24&isfromportal=1&isfromhp=0&e71459402883589=" target="_blank">备品备件安全库存自检表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=301&subCompanyId=24&isfromportal=1&isfromhp=0&e71462260269697=" target="main">物料呆滞分析报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=321&subCompanyId=24&isfromportal=1&isfromhp=0&e71462762104521=" target="main">主要物料库龄分析表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>人事报表</h4>
          <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=961&subCompanyId=24&isfromportal=1&isfromhp=0&e71481872188451=" target="_blank">人员信息查询报表(工作地/社保地)V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=226&subCompanyId=24&isfromportal=1&isfromhp=0&e71459403001099=" target="_blank">月忘打卡次数查询V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=261&subCompanyId=24&isfromportal=1&isfromhp=0&e71461679552601=" target="_blank">人员离职信息表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=621&subCompanyId=24&isfromportal=1&isfromhp=0&e71471359926212=" target="_blank">HR系统考勤审查数据查询报表V1.0</a></li>
          <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=663&subCompanyId=24&isfromportal=1&isfromhp=0&e71472632974769=" target="_blank">HR系统结薪考勤综合查询报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=622&subCompanyId=24&isfromportal=1&isfromhp=0&e71471359902846=" target="_blank">OA系统人员加班数据汇总表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=623&subCompanyId=24&isfromportal=1&isfromhp=0&e71471359798242=" target="_blank">OA系统人员加班数据明细表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=701&subCompanyId=24&isfromportal=1&isfromhp=0&e71473661592010=" target="_blank">员工打卡记录(考勤机)查询报表V1.0</a></li>
          <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=881&subCompanyId=24&isfromportal=1&isfromhp=0&e71479878821456=" target="_blank">员工打卡记录(HR)查询报表V1.0</a></li>
          <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=721&subCompanyId=24&isfromportal=1&isfromhp=0&e71474857723706=" target="_blank">考勤相关流程查询报表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=921&subCompanyId=24&isfromportal=1&isfromhp=0&e71481333287438=" target="_blank">河北考勤原始数据查询报表V1.0</a></li>
          <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=941&subCompanyId=24&isfromportal=1&isfromhp=0&e71481710817388=" target="_blank">内训实施计划报表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>销售报表</h4>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=361&subCompanyId=24&isfromportal=1&isfromhp=0&e71463370158129=" target="_blank">销售额汇总报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=641&subCompanyId=24&isfromportal=1&isfromhp=0&e71472041011750=" target="_blank">累计预测缺货金额表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=642&subCompanyId=24&isfromportal=1&isfromhp=0&e71472041051816=" target="_blank">接单预测出货分析表V1.0</a></li>
          <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=702&subCompanyId=24&isfromportal=1&isfromhp=0&e71473664771793=" target="_blank">销售订单追踪表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=901&subCompanyId=24&isfromportal=1&isfromhp=0&e71480493200556=" target="_blank">销售价格分析表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>采购报表</h4>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=421&subCompanyId=24&isfromportal=1&isfromhp=0&e71466502532970=" target="_blank">采购准时交货率V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=662&subCompanyId=24&isfromportal=1&isfromhp=0&e71472632722929=" target="_blank">供应商质量查询表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=661&subCompanyId=24&isfromportal=1&isfromhp=0&e71472632769777=" target="_blank">采购预计到货明细表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=821&subCompanyId=24&isfromportal=1&isfromhp=0&e71478595737558=" target="_blank">供应商采购频率分析表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>文档报表</h4>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=461&subCompanyId=24&isfromportal=1&isfromhp=0&e71467941766646=" target="_blank">文件归档查询报表V1.0</a></li>
	  </ul></div>
	   <div class="list1">
	  <ul>
	  <h4>通用报表</h4>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=601&subCompanyId=24&isfromportal=1&isfromhp=0&e71470793393458=" target="_blank">打印费用分摊报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=568&subCompanyId=24&isfromportal=1&isfromhp=0&e71471360042325=" target="_blank">国显制度文件审批流程节点耗时统计报表V1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=569&subCompanyId=24&isfromportal=1&isfromhp=0&e71471359956743=" target="_blank">ECN签核流程节点耗时统计报表V1.0</a></li>
	  <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=664&subCompanyId=24&isfromportal=1&isfromhp=0&e71472633451372=" target="_blank">通讯费用分摊报表V1.0</a></li>
	  <li class="ys2"><a href="/homepage/Homepage.jsp?hpid=665&subCompanyId=24&isfromportal=1&isfromhp=0&e71472633480934=" target="_blank">流程节点耗时统计报表V1.0</a></li>
          <li class="ys3"><a href="/homepage/Homepage.jsp?hpid=1041&subCompanyId=201&isfromportal=1&isfromhp=0&e71488611987116=" target="_blank">流程效率分析报表1.0</a></li>
	  <li class="ys1"><a href="/homepage/Homepage.jsp?hpid=841&subCompanyId=24&isfromportal=1&isfromhp=0&e71479088298294=" target="_blank">会议室使用率报表V1.0</a></li>
          </ul></div>
	  </div>
	  
	  </td>
     
   </table>
	 
  </div>
 
</div>
</body>
</html>
