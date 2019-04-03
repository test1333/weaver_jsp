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
	int userid = user.getUID();
	String receiver = Util.null2String(request.getParameter("receiver"));
	String visitor = Util.null2String(request.getParameter("visitor"));
	String company = Util.null2String(request.getParameter("company"));
	String location = Util.null2String(request.getParameter("location"));
	String info = Util.null2String(request.getParameter("idkey")); 
	
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
		
		<script language="JavaScript">
	<%if(info!=null && !"".equals(info)){

		if("0".equals(info)){%>
			top.Dialog.alert("发放成功！")
		<%}

		else if("1".equals(info)){%>
			top.Dialog.alert("发放失败！")
		<%}
	}%>
	</script>
	</head>
	<%
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	
	String guard_pageId = "receive_info";
	%>
	<BODY>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(-9505, user.getLanguage())+ ",javascript:doEdit(this),_TOP} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type=button class="e8_btn_top" onclick="doEdit(this);" value="<%=SystemEnv.getHtmlLabelName(-9505,user.getLanguage())%>">
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
		</FORM>
		<%
		//select id,emp_id,enter_year,annual_days,status,isactive from formtable_main_59 
		String backfields = " id,emp_id,enter_year,annual_days,isactive, "
							+" case status when 0 then '已发放' else '未发放' end as status ";
		String fromSql  = " from formtable_main_59  ";
		String sqlWhere = " status=1 ";

		String orderby = " emp_id " ;
		String tableString = "";
		String operateString= "";
		
		//out.println("select "+ backfields + fromSql + "where"+ sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(guard_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+guard_pageId+"\">"+
			"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
			operateString +
			"			<head>";
				tableString+="<col width=\"24%\" labelid=\"-10257\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
				"		<col width=\"24%\" labelid=\"18939\" text=\"入职年份\" column=\"enter_year\" orderkey=\"enter_year\" />"+
				"		<col width=\"24%\" labelid=\"-10263\" text=\"年假天数\" column=\"annual_days\" orderkey=\"annual_days\" />"+
				"		<col width=\"24%\" labelid=\"-10258\" text=\"状态\" column=\"status\" orderkey=\"status\" />"+
			"			</head>"+
		" </table>";
		%>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
		<script type="text/javascript">
		
			function doEdit(){
				
				var ids = _xtable_CheckedCheckboxId();
				//alert("ids="+ids);
				
				if(ids == ""){
					window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
					return false;
				}
				
				Dialog.confirm("确认发放？", function (){
						weaver.action="/fx/annual/jsp/CountAnnual.jsp?id="+ids;
						weaver.submit();
					}, function () {}, 320, 90,false);
			}
			
		</script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
		<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
	</BODY>
</HTML>