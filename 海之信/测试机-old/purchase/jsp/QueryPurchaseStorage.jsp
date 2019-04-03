<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

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
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="departmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
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
	String departmentid_para = Util.null2String(request.getParameter("departmentid")) ;
	String subcompanyid_para=Util.null2String(request.getParameter("subcompanyid1"));//分部
	String companyid_para = Util.null2String(request.getParameter("companyid")) ;
	if("0".equals(subcompanyid_para)) subcompanyid_para = "";
	String chkSubCompany=Util.null2o(request.getParameter("chkSubCompany"));//子分部是否包含
	String uworkcode=Util.null2String(request.getParameter("uworkcode"));//编号
	String uname=Util.null2String(request.getParameter("uname"));//姓名
	String utel=Util.null2String(request.getParameter("utel"));//电话
	String umobile=Util.null2String(request.getParameter("umobile"));//移动电话
	String uemail=Util.null2String(request.getParameter("uemail"));//电子邮件
	String qname=Util.null2String(request.getParameter("flowTitle"));

	String applicant = Util.null2String(request.getParameter("applicant"));//申请人
	String applicantdate = Util.null2String(request.getParameter("applicantdate"));//申请日期

	int userid=Util.getIntValue(request.getParameter("userid"));//用户登录名
	
	String effeStartDate =Util.null2String(request.getParameter("effeStartDate"));//日期的定义
	String invalidDate =Util.null2String(request.getParameter("invalidDate"));//日期的定义
	String temp_val = "QueryPurchaseStorage";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= temp_val %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action=QueryPurchaseStorage.jsp method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;"><input
						type="text" class="searchInput" name="flowTitle"
						value="<%=qname %>" /> 			<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span><span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>

			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>申请日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selecteffeStartDateAll" onclick="onshowVotingEndDate('effeStartDate','effeStartDateSpan')"></BUTTON> 
            	<SPAN id=effeStartDateSpan><%=effeStartDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHeffeStartDateAll" name="effeStartDate" value="<%=effeStartDate%>"> 

			    <button type="button" class=Calendar id="SHinvalidDate" onclick="onshowVotingEndDate('invalidDate','invalidDateSpan')"></BUTTON> 
            	 <SPAN id=invalidDateSpan><%=invalidDate%></SPAN> 
            	 <INPUT type="hidden" id="invalidDateSH" name="invalidDate" value="<%=invalidDate%>">
			     </wea:item>
				<wea:item>申请人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="applicant" browserValue="<%=applicant%>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(applicant),user.getLanguage())%>">
				</brow:browser>
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
		
		String backfields = " id,requestid,(select requestname from workflow_requestbase wr where wr.requestid=f.requestId) as request_name,applicant,applicantdate,Sysno,selectpurchaseorder,(select requestname from workflow_requestbase wr where wr.requestid=f.selectpurchaseorder) as requestname ";
		String fromSql  = " from  formtable_main_74 f ";
		//String sqlWhere = " 1=1 ";
		String sqlWhere = " applicant="+userid;
		

		//String sqlWhere = " where gysylqxxkzjydqrq <= convert(char(10),getdate(),120) and gysylqxxkzjydqrq is not null ";
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " applicantdate " ;
		String tableString = "";

		if(!applicant.equals("")) 
		sqlWhere+=" and applicant="+applicant;

		//这是一个时间段日期的比较。effeStartDate是选择的开始日期  invalidDate选择的结束日期 DueDate需要比较的收件日期
		if(!"".equals(effeStartDate)){
			sqlWhere +=" and applicantdate>='"+effeStartDate+"' ";
			if(!"".equals(invalidDate)){
				sqlWhere +=" and applicantdate<='"+invalidDate+"' ";
			}
		}else{
			if(!"".equals(invalidDate)){
				sqlWhere +=" and applicantdate<='"+invalidDate+"' ";
			}
		}
		//out.println(sqlWhere);
	
		String  operateString= "";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(temp_val,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+temp_val+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"25%\" labelid=\"18104\" text=\"流程名称\" column=\"request_name\" orderkey=\"requestid\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
		"<col width=\"25%\" labelid=\"-9520\" text=\"采购单\" column=\"requestname\" orderkey=\"selectpurchaseorder\" />"+
			"		<col width=\"10%\" labelid=\"83588\" text=\"系统编号\" column=\"Sysno\" orderkey=\"Sysno\" />"+		
			"		<col width=\"10%\" labelid=\"368\" text=\"申请人\" column=\"applicant\" orderkey=\"applicant\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"10%\" labelid=\"855\" text=\"申请日期\" column=\"applicantdate\" orderkey=\"applicantdate\" />"+

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
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
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
	<!-- 日期的js引用 -->
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>