
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
   // response.sendRedirect("/notice/noright.jsp");
    //return;
//}

String deptid = Util.null2String(request.getParameter("deptid"));
String subcomid = Util.null2String(request.getParameter("subcomid"));
String sql="";
String id = "";
sql=" select modedatacreater,modedatacreatedate,modedatacreatetime,(select lastname from HrmResource where id =EmployeeName ) "
   +" as empName,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,EffectiveStartDate,EffectiveEndDate,EmployeeName  "
   +" from uf_Scheduling_table where isActive = 0 ";
if(!"".equals(deptid)){
	sql = sql + " and department  = "+deptid+" ";
}

if(!"".equals(subcomid)){
	sql = sql + " and subcompany = "+subcomid+" ";
}
	
%>

<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET> 
<link href="/formmode/css/formmode_wev8.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/formmode/js/ext/resources/css/ext-all_wev8.css" />
<link rel="stylesheet" type="text/css" href="/formmode/js/ext/ux/css/columnLock_wev8.css"/>
<script type="text/javascript">
	/**定义js中一些中文label，改用标签显示**/
	var label = {"showmethod":"<%=SystemEnv.getHtmlLabelName(82403,user.getLanguage())%>"//显示方式转换
	};
</script>
<script type="text/javascript" src="/formmode/js/ext/adapter/ext/ext-base_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ext-all_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/miframe_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/iconMgr_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/columnLock_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/CardLayout_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/Wizard_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/showmethod_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/Card_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/Header_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/ext/ux/TreeCheckNodeUI_wev8.js"></script>
<script type="text/javascript" src="/formmode/js/FormmodeUtil_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></SCRIPT>
<style>
html body{
	width:100%;
	height:100%;
}
.e8_forGridHidden{
	height: 10px;
}
/*Ext 表格对应的样式(框架)*/
.x-border-layout-ct{
	background-color: #fff;
}
.x-panel-body-noheader{
	border: none;
}
.x-panel-tl{
	border-bottom-width: 0px;
}
.x-panel-ml{
	padding-left: 0px;
	background-image: none;
}
.x-panel-mc{
	padding-top: 0px;
	background-color: #fff;
}
.x-panel-mr{
	padding-right: 0px;
	background-image: none;
}
.x-panel-nofooter .x-panel-bc{
	height: 0px;
	overflow:hidden;
}

/*Ext 表格对应的样式(表格)*/
.x-grid-panel .x-panel-mc .x-panel-body{
	border: none; 
}
.x-grid3-header{
	background: none;
	padding-left: 3px;
	background-color: #E5E5E5;
}
.x-grid3-hd-inner{
	background-image: none;
	background-color:#e5e5e5;
}
.x-grid3-hd-row td{
	background-color: #E5E5E5;
	border-left: none;
	border-right-color: #d0d0d0;
}
.x-grid3-hd-row td .x-grid3-hd-inner{
	color: #333;
}
.x-grid3-row-table td{
	
}
.x-grid3-header-inner{
	background-color: #E5E5E5;
}
td.x-grid3-hd-over .x-grid3-hd-inner{
	background-image: none;
	background-color: #E5E5E5;
}
.x-grid3-hd-over .x-grid3-hd-btn{
	display: none;
}
.x-grid3-scroller{

}
.x-grid3-locked .x-grid3-scroller{
	border-right-color: #d0d0d0;
}
.x-grid3-body .x-grid3-td-checker{
	padding-left: 3px;
	background: none;
}
.x-grid3-cell-inner{
	padding: 1px 3px 1px 5px;
}
.x-grid3-row, .x-grid3-row-selected{
	/*background-color: #fff !important;*/
	border-top: 1px solid #fff;
	border-bottom: 1px solid #ededed;
	border-left: 0px;
	border-right: 0px;
}

.x-grid3-body .x-grid3-row-selected .x-grid3-td-checker{
	background-image: none;
}
.x-panel-bc, .x-panel-bl, .x-panel-br{
	background-image:none;
}

.x-grid3-col .x-grid3-col-6{
	width: 200px;
}
.x-grid3-hd-inner{
	padding-left: 0;
}

.checkboxcommon{
	height:12px;
	line-height:12px;
	padding-left:5px;
}
</style>
</script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;

%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="">
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("30902,32765",user.getLanguage())%>">
		<wea:item attributes="{'isTableList':'true'}">
			<wea:layout type="table" attributes="{'cols':'9','cws':'11%,11%,11%,11%,11%,11%,11%,11%,11%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead">姓名</wea:item>
			    <wea:item type="thead">上午开始时间</wea:item>
			    <wea:item type="thead">上午结束时间</wea:item>
			    <wea:item type="thead">下午开始时间</wea:item>
			    <wea:item type="thead">下午结束时间</wea:item>
			    <wea:item type="thead">有效开始日期</wea:item>
			    <wea:item type="thead">有效结束日期</wea:item>
			    <wea:item type="thead">创建人</wea:item>
			    <wea:item type="thead">创建时间</wea:item>
			    
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
			        String creater = Util.null2String(RecordSet.getString("modedatacreater"));
			        String createdate = Util.null2String(RecordSet.getString("modedatacreatedate"));
			        String createtime = Util.null2String(RecordSet.getString("modedatacreatetime"));
			        String empName = Util.null2String(RecordSet.getString("EmpName"));
			        String amBeginTime = Util.null2String(RecordSet.getString("AmBeginTime"));
			        String amEndTime = Util.null2String(RecordSet.getString("AmEndTime"));
			        String pmBeginTime = Util.null2String(RecordSet.getString("PmBeginTime"));
			        String pmEndTime = Util.null2String(RecordSet.getString("PmEndTime"));
			        String startDate = Util.null2String(RecordSet.getString("EffectiveStartDate"));
			        String endDate = Util.null2String(RecordSet.getString("EffectiveEndDate"));
			        String employeeName = Util.null2String(RecordSet.getString("EmployeeName"));
			        if("".equals(endDate)) endDate = "9999-12-31";
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/seahonor/jsp/ScheduledPersonal.jsp?id=<%=employeeName%>')><%=empName%></a>
			     </wea:item>
			     <wea:item><%=amBeginTime%>
			     </wea:item>
			     <wea:item>
			     <%=amEndTime%>
			     </wea:item>
			     <wea:item><%=pmBeginTime%>
			     </wea:item>
			     <wea:item>
			     <%=pmEndTime%>
			     </wea:item>
			     <wea:item><%=startDate%>
			     </wea:item>
			     <wea:item>
			     <%=endDate%>
			     </wea:item>
			     <wea:item><%=ResourceComInfo.getResourcename(creater)%>
			     </wea:item>
			     <wea:item>
			     <%=createdate%>&nbsp<%=createtime%>
			     </wea:item>
			     
			  <%
			    }
			  %>
				</wea:group>
			</wea:layout>
		</wea:item>
	</wea:group>
	</div>
</wea:layout>
</form>
</BODY>
</HTML>
