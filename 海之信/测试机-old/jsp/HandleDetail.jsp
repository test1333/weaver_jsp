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
    
    String checkid = Util.null2String(request.getParameter("Checkid"));

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

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="checkid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
				</tr>
			</table>
		</FORM>
		<%
		String backfields = " id,handleassets,handleno,handletype,creater,applicant,handlenum,handleremark ";
		String fromSql  = " from uf_differhandle ";
		String sqlWhere = " where CheckID = "+checkid+"";
		String orderby = "" ;
		String tableString = "";

		String  operateString= "";
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=""+
			"				<col width=\"14%\" labelid=\"处理资产\" text=\"处理资产\" column=\"handleassets\" orderkey=\"handleassets\"/>"+
			"				<col width=\"14%\" labelid=\"处理资产编号\" text=\"处理资产编号\" column=\"handleno\" orderkey=\"handleno\"/>"+
			"				<col width=\"14%\" labelid=\"处理方式\" text=\"处理方式\" column=\"handletype\" orderkey=\"handletype\"/>"+
			"               <col width=\"14%\" labelid=\"处理创建人\" text=\"处理创建人\" column=\"creater\" orderkey=\"creater\" linkvaluecolumn=\"creater\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp?1=1\" target=\"_fullwindow\"/>"+
			"               <col width=\"14%\" labelid=\"处理申请人\" text=\"处理申请人\" column=\"applicant\" orderkey=\"applicant\" linkvaluecolumn=\"applicant\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp?1=1\" target=\"_fullwindow\"/>"+
			"				<col width=\"10%\" labelid=\"处理数量\" text=\"处理数量\" column=\"handlenum\" orderkey=\"handlenum\"/>"+
			"				<col width=\"20%\" labelid=\"处理说明\" text=\"处理说明\" column=\"handleremark\" orderkey=\"handleremark\"/>"+
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