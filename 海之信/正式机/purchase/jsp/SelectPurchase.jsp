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

	String billid=Util.null2String(request.getParameter("billid"));
	String Month=Util.null2String(request.getParameter("Month"));
	String Year=Util.null2String(request.getParameter("Year"));

	String MailOrder_val = "MailOrder"; //这是区分的值
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= MailOrder_val %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action=SelectExpress.jsp method=post>
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
			
				</wea:layout>
			</div>

		</FORM>
		<%
		
		
		String backfields = " (select goodsname from uf_goodsinfo where id = Name) Name,Numbers,a.requestId,"+
								"wr.requestname,row_number() over (order by a.requestId desc) as rowid,"+
								"a.ApplicationDepartment,a.Application ";
		String fromSql  = " from (select Name,Numbers,f.requestId,f.Application,f.Month,f.ApplicationDepartment,"+
							"f.Year from formtable_main_72_dt1 dt1 left join formtable_main_72 f on dt1.mainid=f.id) "+
							"a left join workflow_requestbase wr on a.requestId=wr.requestId ";

		//String sqlWhere = " 1=1 ";
		String sqlWhere = " where a.Month="+Month+" and a.Year="+Year;

		String orderby = " rowid " ;
		String tableString = "";
		

		//String sqlWhere = " where gysylqxxkzjydqrq <= convert(char(10),getdate(),120) and gysylqxxkzjydqrq is not null ";
		out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		//out.println(sqlWhere);
		//out.println("billid="+billid);
		//out.println("Month="+Month);
		//out.println("Year="+Year);
	
		String  operateString= "";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(MailOrder_val,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+MailOrder_val+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestId\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"10%\" labelid=\"-9516\" text=\"序号\" column=\"rowid\" orderkey=\"rowid\" />"+
		"<col width=\"10%\" labelid=\"-9516\" text=\"商品名称\" column=\"Name\" orderkey=\"Name\" />"+
			"<col width=\"10%\" labelid=\"-265\" text=\"数量\" column=\"Numbers\" orderkey=\"Numbers\" />"+
		"<col width=\"10%\" labelid=\"-9237\" text=\"申请人\" column=\"Application\" orderkey=\"Application\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
		"<col width=\"10%\" labelid=\"-9550\" text=\"申请人部门\" column=\"ApplicationDepartment\" orderkey=\"ApplicationDepartment\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
			"<col width=\"25%\" labelid=\"18104\" text=\"流程名称\" column=\"requestname\" orderkey=\"requestid\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
			
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