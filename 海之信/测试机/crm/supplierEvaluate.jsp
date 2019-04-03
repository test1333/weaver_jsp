<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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

 String customID = (String)session.getAttribute("customID");
if("".equals(customID)){
	customID = "-1";
}


String tmc_pageId = "tmcgys110";
%>
	


<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{新增客户动态,javascript:openDyInfo(),_blank} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" value="新增" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="openDyInfo();"/>
					    <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				
			</div>

	</FORM>
    
	<%
								
	String backfields = " id,pjnr,case xj when '0' then '一星' when '1' then '二星' when '2' then '三星' when '3' then '四星' when '4' then '五星' else '' end as xj,pjr,pjrq "; 
	String fromSql  = " from uf_gys_pingjia ";
	String sqlWhere = " where  gys = '"+customID+"'";
	
	String orderby = " id asc " ;
	String tableString = "";
    //out.print("select "+backfields+fromSql+sqlWhere);


//  右侧鼠标 放上可以点击
String  operateString= "";

tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"70%\"  text=\"评价内容\" column=\"pjnr\" orderkey=\"pjnr\"/>"+
		"<col width=\"10%\"  text=\"星级\" column=\"xj\" orderkey=\"xj\"/>"+
	  "				<col width=\"10%\"  text=\"评价人\" column=\"pjr\" orderkey=\"pjr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  />"+
	  "				<col width=\"10%\"  text=\"评价日期\" column=\"pjrq\" orderkey=\"pjrq\"  />"+
	"			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
    <script>

		function openDyInfo() {
	//	alert(123);
	//	openFullWindowForXtable("/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>");
		var title = "";
	//	var url = "/systeminfo/BrowserMain.jsp?url=/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>";
		
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=gyspj,<%=customID%>";
		
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 700;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		
	//	window.open("/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>","12","height=100,width=400,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no,status=no";); 
	}
	</script>
	
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
