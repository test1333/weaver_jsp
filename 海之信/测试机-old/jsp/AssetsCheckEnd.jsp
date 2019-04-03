<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%!
// JSP中的方法
public static String CreateTmpOnlineUserId(	RecordSet rs ,ArrayList<String> onlineuserids)throws Exception
{
String userids = "";
rs.execute("delete from TmpOnlineUserId");

for(int i=0;onlineuserids!=null&&i<onlineuserids.size();i++){
rs.execute("INSERT INTO TmpOnlineUserId VALUES ("+onlineuserids.get(i)+")");
}
return userids;
}
%>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<%
    //读取当前操作人
    int userid = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    
    String sysno = Util.null2String(request.getParameter("sysno"));

	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(354,user.getLanguage())+",javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		//RCMenu += "{"+SystemEnv.getHtmlLabelName(236,user.getLanguage())+",javascript:approvalReturn(),_self} " ;
		//RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="checkid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">


				<wea:item>系统编号</wea:item>
				<wea:item><INPUT name=sysno class='InputStyle' size="30" value="<%=sysno%>"></wea:item>

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
		<%
		String backfields = " id,sysno,checkcate,case checkrange when '0' then '所有'  when 1 then '按类别设置' when 2 then '按库房设置' "+
		                    " when 3 then '按客户设置' else '组合设置' End as checkrange, "+
		                    " creater,monitor,checkperson,checkdate,case workprocess when '0' then '待填报' when '1' then '待处理' "+
		                    " when '2' then '申请中' when '3' then '审批中' when '4' then '平差中' else '已通过' End "+ 
		                    " as workprocess, case status when '0' then '盘点中' else '盘点结束' End as status,detailx ";
		String fromSql  = " from uf_checkrecord";
		String sqlWhere = " where workprocess not in(0,1) and status = 0 and monitor = "+userid+"";
		String orderby = "" ;
		String tableString = "";

		if(!sysno.equals(""))sqlWhere+=" and sysno = '"+sysno+ "'";

		String  operateString= "";
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+            "\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+="  <col width=\"15%\" labelid=\"系统编号\" text=\"系统编号\" column=\"sysno\" orderkey=\"sysno\" linkvaluecolumn=\"id\"  target=\"_fullwindow\" />"+
			"               <col width=\"10%\" labelid=\"盘点方式\" text=\"盘点方式\" column=\"checkrange\" orderkey=\"checkrange\"/>"+
			"               <col width=\"10%\" labelid=\"创建人\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" linkvaluecolumn=\"creater\"  linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
			"               <col width=\"10%\" labelid=\"盘点人\" text=\"盘点人\" column=\"checkperson\" orderkey=\"checkperson\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  linkvaluecolumn=\"checkperson\"  linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
			"               <col width=\"10%\" labelid=\"监盘人\" text=\"监盘人\" column=\"monitor\" orderkey=\"monitor\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  linkvaluecolumn=\"monitor\"  linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
			"				<col width=\"10%\" labelid=\"盘点日期\" text=\"盘点日期\" column=\"checkdate\" orderkey=\"checkdate\"/>"+
			"				<col width=\"10%\" labelid=\"状态\" text=\"状态\" column=\"status\" orderkey=\"status\"/>"+
			"               <col width=\"10%\" labelid=\"工作进度\" text=\"工作进度\" column=\"workprocess\" orderkey=\"workprocess\"/>"+
			"				<col width=\"15%\" labelid=\"设置列表\" text=\"盘点设置\" column=\"detailx\" orderkey=\"detailx\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=90&amp;formId=-116\"  target=\"_fullwindow\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">

		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}

	</script>
</BODY>
</HTML>