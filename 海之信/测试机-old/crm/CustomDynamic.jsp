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
String biaoti = Util.null2String(request.getParameter("biaoti"));
	String dtnr = Util.null2String(request.getParameter("dtnr"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));

String tmc_pageId = "tmcCus001";
%>
	
<script type="text/javascript">
		function openNewInfo1(id) {
		//	openFullWindowForXtable("/seahonor/crm/ModeForward.jsp?type=custom&customID=<%=customID%>&empID="+id);
			var title = "";
			var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,<%=customID%>,"+id;

			var diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 600;
			diag_vote.Height = 400;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.isIframe=false;
			diag_vote.show();	
		}
</script>

<script type="text/javascript">
	function openNewInfo(id) {
	//	openFullWindowForXtable("CustomGroupDynamicDetail.jsp?customID="+id);
		var title = "";
		var url = "/seahonor/remind/RemindJobBase_crm.jsp?customID="+id+"&customID1=<%=customID%>";
		//alert(url)
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1200;
		diag_vote.Height = 700;
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
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				

				<wea:item>标题</wea:item>
				<wea:item>
				 <input name="biaoti" id="biaoti" class="InputStyle" type="text" value="<%=biaoti%>"/>
				</wea:item>
                <wea:item>动态内容</wea:item>
				<wea:item>
				 <input name="dtnr" id="dtnr" class="InputStyle" type="text" value="<%=dtnr %>"/>
				</wea:item>	
				<wea:item>创建日期</wea:item>
		<wea:item>
			<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
              	<INPUT type="hidden" name="beginDate" value="<%=beginDate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=endDate%></SPAN> 
            	<INPUT type="hidden" name="endDate" value="<%=endDate%>">  
		</wea:item>
				

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
								
	String backfields = " id,bt,content,creater,createdate+' '+createtime as createTime "; 
	String fromSql  = " from uf_custom_dynamic ";
	String sqlWhere = " where custom = " + customID 
		+ " and (creater="+user_id+" or AreaType=0 or ','+CAST(Area as varchar(6000))+','  like '%,"+user_id+",%') " ;
	String orderby = " createdate,createtime " ;
	String tableString = "";
    if(!"".equals(biaoti)){
		sqlWhere +=  " and UPPER(bt) like upper('%"+biaoti+"%') ";
	}
	 if(!"".equals(dtnr)){
		sqlWhere +=  " and content like '%"+dtnr+"%' ";
	}
	if(!"".equals(beginDate)){
		sqlWhere +=  " and createdate >='"+beginDate+"'";
	}
	if(!"".equals(endDate)){ 
		sqlWhere +=  " and createdate <='"+endDate+"'";
	}


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:openNewInfo1();\" linkkey=\"id\" linkvaluecolumn=\"creater\" text=\"回复\"  target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
						 "     <operate href=\"javascript:openNewInfo();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"提醒\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+

 	       				"</operates>";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"20%\" labelid=\"-9403\" text=\"标题\" column=\"bt\" orderkey=\"id\"/>"+
		"<col width=\"50%\" labelid=\"-9403\" text=\"动态内容\" column=\"content\" orderkey=\"id\"/>"+
	  "				<col width=\"15%\" labelid=\"882\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  />"+
	  "				<col width=\"15%\" labelid=\"1339\" text=\"创建时间\" column=\"createTime\" orderkey=\"createTime\"  />"+
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
	</script>
			<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
