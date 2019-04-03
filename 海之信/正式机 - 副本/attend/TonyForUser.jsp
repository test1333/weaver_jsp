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
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action=TonyForUser.jsp method=post>
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
				<wea:item>姓名</wea:item>
				<wea:item><INPUT name=uname class='InputStyle' size="30" value="<%=uname%>"></wea:item>
				<wea:item>编号</wea:item>
				<wea:item><INPUT name=uworkcode class='InputStyle' size="30" value="<%=uworkcode%>"></wea:item>
				<wea:item>分部</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="subcompanyid1" browserValue="<%=subcompanyid_para %>"
				browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/SubcompanyBrowser.jsp?selectedids="
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=164" width="120px" _callback="makechecked"
				browserSpanValue="<%=SubCompanyComInfo.getSubCompanyname(subcompanyid_para)%>">
				</brow:browser>
				<INPUT class='InputStyle' id='chkSubCompany' name='chkSubCompany'
				type='checkbox' value='<%=chkSubCompany%>'
				onclick="setCheckbox(this)" <%if("1".equals(chkSubCompany)){%>
				checked <%}%> <%if("".equals(subcompanyid_para)){%>
				style="display:none" <%}%>><LABEL FOR='chkSubCompany'
					id='lblSubCompany' <%if("".equals(subcompanyid_para)){%>
				style="display:none" <%}%>><%=SystemEnv.getHtmlLabelName(18921,user.getLanguage())%></LABEL>
				</wea:item>
				<wea:item>部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="departmentid" browserValue="<%=departmentid_para %>"
				browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/DepartmentBrowser.jsp?selectedids="
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="120px"
				linkUrl="/hrm/company/HrmDepartmentDsp.jsp?id="
				browserSpanValue="<%=departmentComInfo.getDepartmentname(departmentid_para)%>">
				</brow:browser>
				</wea:item>
				<wea:item>电话</wea:item>
				<wea:item><INPUT name=utel class='InputStyle' size="30" value="<%=utel%>"></wea:item>
				<wea:item>移动电话</wea:item>
				<wea:item><INPUT name=umobile class='InputStyle' size="30" value="<%=umobile%>"></wea:item>
				<wea:item>477</wea:item>
				<wea:item><INPUT name=uemail class='InputStyle' size="30" value="<%=uemail%>"></wea:item>
				<wea:item>&nbsp;</wea:item>
				<wea:item>&nbsp;</wea:item>
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
		
		String backfields = " * ";
		String fromSql  = " from hrmresource ";
		String sqlWhere = " where status in(0,1,2)";
		String orderby = " lastname " ;
		String tableString = "";
		if(!departmentid_para.equals(""))
		sqlWhere+=" and departmentid="+departmentid_para;
		//分部
		if(!subcompanyid_para.equals("")) {
		String subcomstr = "";
		if ("1".equals(chkSubCompany)) {
		subcomstr = SubCompanyComInfo.getSubCompanyTreeStr(subcompanyid_para);
		}
		if (!"".equals(subcomstr)) {
		subcomstr += subcompanyid_para;
		sqlWhere+=" and subcompanyid1 in ("+ subcomstr + ")";
		} else {
		sqlWhere+=" and subcompanyid1="+subcompanyid_para;
		}
		}
		//
		if(!qname.equals(""))sqlWhere+=" and lastname like '%"+ qname + "%'";
		//编号
		if(!uworkcode.equals("")) sqlWhere+=" and workcode like '%"+ uworkcode + "%'";
		//姓名
		if(!uname.equals("")) sqlWhere+=" and lastname like '%"+ uname + "%'";
		//电话
		if(!utel.equals("")) sqlWhere+=" and telephone like '%"+ utel + "%'";
		//移动电话
		if(!umobile.equals("")) sqlWhere+=" and mobile like '%"+ umobile + "%'";
		//电子邮件
		if(!uemail.equals("")) sqlWhere+=" and email like '%"+ uemail + "%'";
		//  右侧鼠标 放上可以点击
		String  operateString= "";
		operateString = "<operates width=\"20%\">"+
	" <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
	"     <operate href=\"/hrm/resource/HrmResourceBase.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"查看\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
	"     <operate href=\"/hrm/resource/HrmResourceBasicEdit.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"编辑\" target=\"_fullwindow\" isalwaysshow='true' index=\"1\"/>"+
	"     <operate href=\"/workplan/data/WorkPlan.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"个人日程\" target=\"_fullwindow\" isalwaysshow='true' index=\"3\"/>"+
	"</operates>";
	tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+="<col width=\"10%\" labelid=\"714\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"/>"+
			"				<col width=\"10%\" labelid=\"413\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp?1=1\" target=\"_fullwindow\" />"+
			"				<col width=\"10%\" labelid=\"141\" text=\"分部\" column=\"subcompanyid1\" orderkey=\"subcompanyid1\" transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\" href=\"/hrm/company/HrmDepartment.jsp\"  linkkey=\"subcompanyid\" target=\"_fullwindow\"/>"+
			"				<col width=\"10%\" labelid=\"124\" text=\"部门\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" href=\"/hrm/company/HrmDepartmentDsp.jsp\" linkkey=\"departmentid\" target=\"_fullwindow\"/>"+
			"				<col width=\"15%\" labelid=\"421\" text=\"电话\" column=\"telephone\" orderkey=\"telephone\"/>"+
			"				<col width=\"15%\" labelid=\"620\" text=\"移动电话\" column=\"id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getMobileShow\" otherpara=\""+user.getUID()+"\" />"+
			"				<col width=\"20%\" labelid=\"477\" text=\"邮箱\" column=\"email\" orderkey=\"email\"/>"+
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