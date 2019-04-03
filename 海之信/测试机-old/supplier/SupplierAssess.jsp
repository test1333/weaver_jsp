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
String titlename = "交易评价";
String needfav ="1";
String needhelp ="";

String customID = Util.null2String(request.getParameter("customID"));

if("".equals(customID)){
	customID = "-1";
}

String tmc_pageId = "tmcSupp001";
%>

<script type="text/javascript">
	function openNewInfo(id) {
	//	openFullWindowForXtable("CustomGroupDynamicDetail.jsp?customID="+id);
		var title = "";
	//	var url = "/seahonor/remind/RemindJobBase_crm.jsp?customID="+id;
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/supplier/SupplierAssessDt.jsp?typex="+id;
		//alert(url)
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.checkDataChange = false;
		diag_vote.show();	
	}
</script>

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
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td></td>
			</tr>
		</table>

	</FORM>
     <%for(int index=0;index<20;index++){out.println("&nbsp;");}%>    	
        	
       <%for(int index=0;index<20;index++){out.println("&nbsp;");}%>  <a href="javascript:onBtnSearchClick()"> 刷新</a> 
	<%
								
	String backfields = " id,sysNo,gendate,cycle,amount,remark "; 
	String fromSql  = " from uf_TradeRecord ";
	String sqlWhere = " supplier= " + customID ;
	String orderby = " sysNo " ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:openNewInfo();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"评价\"  target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
						

 	       				"</operates>";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>"; 
		tableString+="<col width=\"15%\" labelid=\"20576\" text=\"生成编号\" column=\"sysNo\" orderkey=\"sysNo\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=99&amp;formId=-145&amp;opentype=0&amp;customid=85&amp;viewfrom=fromsearchlist\"/>"+
	  "				<col width=\"15%\" labelid=\"15397\" text=\"发生日期\" column=\"gendate\" orderkey=\"gendate\" />"+
	  "				<col width=\"15%\" labelid=\"-9935\" text=\"关联周期\" column=\"cycle\" orderkey=\"cycle\"  />"+
"				<col width=\"15%\" labelid=\"15398\" text=\"发生金额\" column=\"amount\" orderkey=\"amount\"  />"+
"				<col width=\"40%\" labelid=\"1339\" text=\"备注\" column=\"remark\" orderkey=\"remark\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
	function openDyInfo() {
	//	alert(123);
	//	openFullWindowForXtable("/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>");
		var title = "";
	//	var url = "/systeminfo/BrowserMain.jsp?url=/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>";
		
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,<%=customID%>";
		
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 600;
		diag_vote.Height = 400;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
		
	//	window.open("/formmode/view/AddFormModeIframe.jsp?modeId=7&formId=-8&type=1&customid=0&field5846=<%=customID%>","12","height=100,width=400,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no,status=no";); 
	}

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
