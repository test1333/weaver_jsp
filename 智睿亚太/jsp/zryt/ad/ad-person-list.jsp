<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "adpersonlist";
	String sql = "";
	String loginid = Util.null2String(request.getParameter("loginid"));
	String lastname = Util.null2String(request.getParameter("lastname"));
	String departmentid = Util.null2String(request.getParameter("departmentid"));
	String subcompanyid1 = Util.null2String(request.getParameter("subcompanyid1"));
	String managerid = Util.null2String(request.getParameter("managerid"));
	String email = Util.null2String(request.getParameter("email"));
	String jobtitle = Util.null2String(request.getParameter("jobtitle"));
	String telephone = Util.null2String(request.getParameter("telephone"));
	String mobile = Util.null2String(request.getParameter("mobile"));
	String residentphone = Util.null2String(request.getParameter("residentphone"));
	String residentpostcode = Util.null2String(request.getParameter("residentpostcode"));
	String fax = Util.null2String(request.getParameter("fax"));
	String ldap_domainName = Util.null2String(request.getParameter("ldap_domainName"));
	
	//out.print("begindate"+begindate+" enddate"+enddate);
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
	    <input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
	
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{更新人员,javascript:updatePerson(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/zryt/ad/ad-person-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button"  value="更新人员" class="e8_btn_top" onClick="updatePerson()" />
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
					<wea:item>登录名</wea:item>
					<wea:item>
						<input name="loginid" id="loginid" class="InputStyle" type="text" value="<%=loginid%>"/>
					</wea:item>
					<wea:item>姓名</wea:item>
					<wea:item>
						<input name="lastname" id="lastname" class="InputStyle" type="text" value="<%=lastname%>"/>
					</wea:item>
					<wea:item>部门</wea:item>
					<wea:item>
						<input name="departmentid" id="departmentid" class="InputStyle" type="text" value="<%=departmentid%>"/>
					</wea:item>
					<wea:item>分部</wea:item>
					<wea:item>
						<input name="subcompanyid1" id="subcompanyid1" class="InputStyle" type="text" value="<%=subcompanyid1%>"/>
					</wea:item>
					<wea:item>上级</wea:item>
					<wea:item>
						<input name="managerid" id="managerid" class="InputStyle" type="text" value="<%=managerid%>"/>
					</wea:item>
					<wea:item>邮件</wea:item>
					<wea:item>
						<input name="email" id="email" class="InputStyle" type="text" value="<%=email%>"/>
					</wea:item>
					<wea:item>岗位</wea:item>
					<wea:item>
						<input name="jobtitle" id="jobtitle" class="InputStyle" type="text" value="<%=jobtitle%>"/>
					</wea:item>
					<wea:item>电话</wea:item>
					<wea:item>
						<input name="telephone" id="telephone" class="InputStyle" type="text" value="<%=telephone%>"/>
					</wea:item>
					<wea:item>手机</wea:item>
					<wea:item>
						<input name="mobile" id="mobile" class="InputStyle" type="text" value="<%=mobile%>"/>
					</wea:item>
					<wea:item>家庭电话</wea:item>
					<wea:item>
						<input name="residentphone" id="residentphone" class="InputStyle" type="text" value="<%=residentphone%>"/>
					</wea:item>
					<wea:item>邮编</wea:item>
					<wea:item>
						<input name="residentpostcode" id="residentpostcode" class="InputStyle" type="text" value="<%=residentpostcode%>"/>
					</wea:item>
					<wea:item>传真</wea:item>
					<wea:item>
						<input name="fax" id="fax" class="InputStyle" type="text" value="<%=fax%>"/>
					</wea:item>
					<wea:item>域名</wea:item>
					<wea:item>
						<input name="ldap_domainName" id="ldap_domainName" class="InputStyle" type="text" value="<%=ldap_domainName%>"/>
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
		String backfields = " * ";
		String fromSql  =  " from uf_ad_person";
		String sqlWhere =  " 1=1";
		if(!"".equals(loginid)){
			sqlWhere += " and loginid like '%" + loginid + "%'";
		}
		if(!"".equals(lastname)){
			sqlWhere += " and lastname like '%" + lastname + "%'";
		}
		if(!"".equals(departmentid)){
			sqlWhere += " and departmentid like '%" + departmentid + "%'";
		}
		if(!"".equals(subcompanyid1)){
			sqlWhere += " and subcompanyid1 like '%" + subcompanyid1 + "%'";
		}
		if(!"".equals(managerid)){
			sqlWhere += " and managerid like '%" + managerid + "%'";
		}
		if(!"".equals(email)){
			sqlWhere += " and email like '%" + email + "%'";
		}
		if(!"".equals(jobtitle)){
			sqlWhere += " and jobtitle like '%" + jobtitle + "%'";
		}
		if(!"".equals(telephone)){
			sqlWhere += " and telephone like '%" + telephone + "%'";
		}
		if(!"".equals(mobile)){
			sqlWhere += " and mobile like '%" + mobile + "%'";
		}
		if(!"".equals(residentphone)){
			sqlWhere += " and residentphone like '%" + residentphone + "%'";
		}
		if(!"".equals(residentpostcode)){
			sqlWhere += " and residentpostcode like '%" + residentpostcode + "%'";
		}
		if(!"".equals(fax)){
			sqlWhere += " and fax like '%" + fax + "%'";
		}
		if(!"".equals(ldap_domainName)){
			sqlWhere += " and ldap_domainName = '" + ldap_domainName + "'";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " id "  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"8%\" text=\"登录名\" column=\"loginid\" orderkey=\"loginid\"  />"+ 
			"<col width=\"8%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" />"+ 
			"<col width=\"8%\" text=\"部门\" column=\"departmentid\" orderkey=\"departmentid\" />"+ 
			"<col width=\"8%\" text=\"分部\" column=\"subcompanyid1\" orderkey=\"subcompanyid1\"  />"+ 
			"<col width=\"8%\" text=\"上级\" column=\"managerid\" orderkey=\"managerid\"  />"+ 
			"<col width=\"10%\" text=\"邮件\" column=\"email\" orderkey=\"email\"  />"+ 
			"<col width=\"10%\" text=\"岗位\" column=\"jobtitle\" orderkey=\"jobtitle\" />"+
			"<col width=\"8%\" text=\"电话\" column=\"telephone\" orderkey=\"telephone\" />"+
			"<col width=\"8%\" text=\"手机\" column=\"mobile\" orderkey=\"mobile\" />"+
			"<col width=\"8%\" text=\"家庭电话\" column=\"residentphone\" orderkey=\"residentphone\" />"+
			"<col width=\"6%\" text=\"邮编\" column=\"residentpostcode\" orderkey=\"residentpostcode\" />"+
			"<col width=\"6%\" text=\"传真\" column=\"fax\" orderkey=\"fax\" />"+
			"<col width=\"6%\" text=\"域名\" column=\"ldap_domainName\" orderkey=\"ldap_domainName\" />"+
			

		
						
						
						"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false"/>

	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		function updatePerson() {
			var ids = _xtable_CheckedCheckboxId();	
			if(ids==""){
				top.Dialog.alert("请选择数据");
				return ;
			}
			var result = "";
			jQuery.ajax({
					type: "POST",
					url: "/zryt/ad/updateInsertPerson.jsp",
					data: {'ids':ids},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								result=data;
							}
        	});
			if(result == "1"){
				top.Dialog.alert("更新成功");
			}else if(result == "2"){
				top.Dialog.alert("部分更新成功");
			}
			window.location.reload();

		}
		
		

	
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>