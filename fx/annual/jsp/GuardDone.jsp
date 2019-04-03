<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%
	user = (User)session.getAttribute("weaver_user@bean");
	user.setLanguage(7);
	int uid_1 = user.getUID();
	
	if(uid_1!=-10&&uid_1!=1) {
		session.removeAttribute("weaver_user@bean");
		response.sendRedirect("/login/login.jsp") ;
		return ;
	}//控制权限
	
	int userid = user.getUID();
	String receiver = Util.null2String(request.getParameter("receiver"));
	String visitor = Util.null2String(request.getParameter("visitor"));
	String company = Util.null2String(request.getParameter("company"));
	String location = Util.null2String(request.getParameter("location"));
	
%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script language="javascript" src="/js/weaver_wev8.js"></script>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	
	String guard_pageId_his = "receive_info_histroy";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=guard_pageId_his%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:doSearch(this),_TOP} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type=button class="e8_btn_top" onclick="doSearch(this);" value="<%=SystemEnv.getHtmlLabelName(527,user.getLanguage())%>">
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
						</span>
					</td>
				</tr>
			</table>
			<div>
				<wea:layout type="4col" attributes="{'expandAllGroup':'true'}">
					<wea:group context='查询条件'>
						<wea:item>访何人</wea:item>
						<wea:item>
							<input class=inputstyle id='receiver' name=receiver size="20" value="<%=receiver%>" >
						</wea:item>
						<wea:item>来客姓名</wea:item>
						<wea:item>
							<input class=inputstyle id='visitor' name=visitor size="20" value="<%=visitor%>" >
						</wea:item>
						<wea:item>自何单位</wea:item>
						<wea:item>
						<input class=inputstyle id='company' name=company size="20" value="<%=company%>" >
						</wea:item>
						<wea:item>地点</wea:item>
						<wea:item>
							<input class=inputstyle id='location' name=location size="20" value="<%=location%>" >
						</wea:item>
					</wea:group>
				</wea:layout>
			</div>
			
		</FORM>
		<%
		//select requestId,Name,From2,Location,ID2,Tel1,
		//Receiver,Dept,Tel2,Appointment,Subject,Date2,Time,visitingarea,badgeNo 
		//,quantity,vehicleNo,issuedBy,issuedTime,receivedBy,receivedTime from formtable_main_91
		String backfields = " requestId,Name,From2,Location,ID2,Tel1,Receiver,Dept,Tel2, "
							+" Subject,Date2,Time,badgeNo,quantity,vehicleNo,issuedBy, "
							+" case Appointment when 0 then '是' else '否' end as Appointment, "
							+" case visitingarea when 0 then '办公区域' when 1 then '车间' when 2 then '仓库' else '其它' end as visitingarea, "
							+" issuedTime,receivedBy,receivedTime ";
		String fromSql  = " from formtable_main_91  ";
		String sqlWhere = " (issuedTime !='' and receivedTime !='') and requestId "
					+" in (select requestid from workflow_requestbase where currentnodetype > 0) ";

		String orderby = " requestId " ;
		String tableString = "";
		String operateString= "";
		
		if(!"".equals(receiver)){
				receiver = receiver.trim();
				sqlWhere += "and Receiver in (select id from hrmresource where lastname like '%"+receiver+"%')";
			}


		 if(!"".equals(visitor)){
			visitor = visitor.trim();
			sqlWhere += "and Name like '%"+visitor+"%' ";
		}
		
		if(!"".equals(company)){
			company = company.trim();
			sqlWhere += "and From2 like '%"+company+"%' ";
		}
		
		if(!"".equals(location)){
			location = location.trim();
			sqlWhere += "and Location like '%"+location+"%' ";
		}
		//out.println("select "+ backfields + fromSql + "where"+ sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(guard_pageId_his,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+guard_pageId_his+"\">"+
			"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"requestId\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
			operateString +
			"			<head>";
				tableString+="<col width=\"5%\" labelid=\"-10254\" text=\"来客姓名\" column=\"Name\" orderkey=\"Name\" />"+
				"		<col width=\"5%\" labelid=\"-10255\" text=\"自何单位\" column=\"From2\" orderkey=\"From2\"/>"+
				"		<col width=\"5%\" labelid=\"-10261\" text=\"地点\" column=\"Location\" orderkey=\"Location\"/>"+
				"		<col width=\"5%\" labelid=\"-10256\" text=\"来客证件\" column=\"ID2\" orderkey=\"ID2\"/>"+
				"		<col width=\"5%\" labelid=\"-10263\" text=\"联系方式\" column=\"Tel1\" orderkey=\"Tel1\"/>"+
				"		<col width=\"5%\" labelid=\"-10257\" text=\"访何人\" column=\"Receiver\" orderkey=\"Receiver\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
				"		<col width=\"5%\" labelid=\"18939\" text=\"部门\" column=\"Dept\" orderkey=\"Dept\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
				"		<col width=\"5%\" labelid=\"-10263\" text=\"联系方式\" column=\"Tel2\" orderkey=\"Tel2\" />"+
				"		<col width=\"5%\" labelid=\"-10258\" text=\"是否预约\" column=\"Appointment\" orderkey=\"Appointment\" />"+
				"		<col width=\"5%\" labelid=\"-10268\" text=\"事由\" column=\"Subject\" orderkey=\"Subject\"/>"+
				"		<col width=\"5%\" labelid=\"97\" text=\"日期\" column=\"Date2\" orderkey=\"Date2\"/>"+
				"		<col width=\"5%\" labelid=\"277\" text=\"时间\" column=\"Time\" orderkey=\"Time\"/>"+
				"		<col width=\"8%\" labelid=\"-10286\" text=\"被访区域\" column=\"visitingarea\" orderkey=\"visitingarea\"/>"+
				"		<col width=\"5%\" labelid=\"-10287\" text=\"胸卡号\" column=\"badgeNo\" orderkey=\"badgeNo\" />"+
				"		<col width=\"5%\" labelid=\"-10288\" text=\"领卡数量\" column=\"quantity\" orderkey=\"quantity\"/>"+
				"		<col width=\"5%\" labelid=\"-10289\" text=\"车号\" column=\"vehicleNo\" orderkey=\"vehicleNo\"/>"+
				"		<col width=\"5%\" labelid=\"-10290\" text=\"发放人\" column=\"issuedBy\" orderkey=\"issuedBy\"/>"+
				"		<col width=\"5%\" labelid=\"-10291\" text=\"发放时间\" column=\"issuedTime\" orderkey=\"issuedTime\" />"+
				"		<col width=\"5%\" labelid=\"-10292\" text=\"收回人\" column=\"receivedBy\" orderkey=\"receivedBy\"/>"+
				"		<col width=\"5%\" labelid=\"-10293\" text=\"收回时间\" column=\"receivedTime\" orderkey=\"receivedTime\"/>"+
			"			</head>"+
		" </table>";
		%>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
		<script type="text/javascript">
		
			function doSearch() {
				weaver.submit();
			}
		
		</script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
		<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
	</BODY>
</HTML>