
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<script type="text/javascript">
function openNewInfo(id) {
//	openFullWindowForXtable("CustomVersionInfoDetail.jsp?type=custom&customID="+id);
//	alert(123);
	var title = "";
	var url = "/seahonor/crm/CustomVersionInfoDetail.jsp?type=badge&customID="+id;
	var diag_vote = new window.top.Dialog();
	diag_vote.currentWindow = window;
	diag_vote.Width = 1200;		
	diag_vote.Height = 700;
	diag_vote.Modal = true;		
	diag_vote.Title = title;
	diag_vote.URL = url;
	diag_vote.isIframe=false;
	diag_vote.show();
}

</script>
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

String customID = Util.null2String(request.getParameter("customID"));

if("".equals(customID)){
	customID = "-1";
}
String tmc_pageId = "badge_val";
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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				
			</tr>
		</table>

	</FORM>
	<%
								
	String backfields = " *,(case Classify when '0' then '内部' else '客户' end) as Classifier "; 
	String fromSql  = " from uf_badges ";
	String sqlWhere = " where superid = " + customID;
	String orderby = " version " ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:openNewInfo();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"修改差异\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
 	       				"</operates>";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"15%\" labelid=\"-61\" text=\"名称\" column=\"Name\" orderkey=\"Name\"/>"+
		"		<col width=\"10%\" labelid=\"27382\" text=\"所属客户\" column=\"Customer\" orderkey=\"Customer\" transmethod=\"seahonor.info.CustomerInfo.getCustomerName\" />"+
		"				<col width=\"10%\" labelid=\"882\" text=\"创建人\" column=\"Creater\" orderkey=\"Creater\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
		"				<col width=\"10%\" labelid=\"-9256\" text=\"有效开始日期\" column=\"StartDate\" orderkey=\"StartDate\"   />"+
		"				<col width=\"10%\" labelid=\"-9255\" text=\"有效结束日期\" column=\"ValidTerm\" orderkey=\"ValidTerm\"   />"+
	  "				<col width=\"10%\" labelid=\"-9661\" text=\"内部/客户\" column=\"Classifier\" orderkey=\"Classifier\"   />"+
	  "				<col width=\"5%\" labelid=\"567\" text=\"版本\" column=\"Version\" orderkey=\"Version\"   />"+
	 "				<col width=\"10%\" labelid=\"-9660\" text=\"证章类型\" column=\"BadgeType\" orderkey=\"BadgeType\"   />"+
	 "				<col width=\"10%\" labelid=\"494\" text=\"传真\" column=\"Fax\" orderkey=\"Fax\"   />"+
	"				<col width=\"20%\" labelid=\"-9659\" text=\"流程申请人\" column=\"ProcessApplicant\" orderkey=\"ProcessApplicant\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
	"				<col width=\"10%\" labelid=\"20443\" text=\"备注\" column=\"Remark\" orderkey=\"Remark\"   />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
	</script>
</BODY>
</HTML>
