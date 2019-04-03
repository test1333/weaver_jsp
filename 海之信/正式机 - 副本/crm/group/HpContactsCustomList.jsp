
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
String name = Util.null2String(request.getParameter("name"));
String sysNo = Util.null2String(request.getParameter("sysNo"));
String dept = Util.null2String(request.getParameter("dept"));
String jobTitle = Util.null2String(request.getParameter("jobTitle"));
String telephone = Util.null2String(request.getParameter("telephone"));
String mobile = Util.null2String(request.getParameter("mobile"));
String status = Util.null2String(request.getParameter("status"));

String tmc_pageId = "tmcConCus01";

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
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="customID" value="<%=customID%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>联系人名称</wea:item>
		<wea:item>
			<input type="text" name="name" id="name" class="InputStyle" value="<%=name%>"/>
		</wea:item>
		<wea:item>联系人代码</wea:item>
		<wea:item>
			<input type="text" name="sysNo" id="sysNo" class="InputStyle" value="<%=sysNo%>" />
		</wea:item>

	    <wea:item>部门</wea:item>
		<wea:item>
			<input type="text" name="dept" id="dept" class="InputStyle"  value="<%=dept%>" />
		</wea:item>
		<wea:item>职位</wea:item>
		<wea:item>
			<input type="text" name="jobTitle" id="jobTitle" class="InputStyle" value="<%=jobTitle%>"  />
		</wea:item>
			
		<wea:item>电话</wea:item>
		<wea:item>
			<input type="text" name="telephone" id="telephone" class="InputStyle"  value="<%=telephone%>"/>
		</wea:item>
		<wea:item>手机</wea:item>
		<wea:item>
			<input type="text" name="mobile" id="mobile" class="InputStyle"  value="<%=mobile%>" />
		</wea:item>
			
		<wea:item>客户状态</wea:item>
		<wea:item>
			<select name="status" id="status" > 
				<option value="">所有</option>
				<option value="0">未校队</option>
				<option value="1">已校队</option>
			</select>
		</wea:item>
	</wea:group>
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%

/*Iterator<String> it = map.keySet().iterator();
while(it.hasNext()){
String tmp_id_x = it.next();
String tmp_name_x = map.get(tmp_id_x);
}*/
//	out.prinln(tmp_name_x);	
							
	String backfields = " id,Name,mobile,email,Address,Postcode,tel,status,(case dealStatus when 0 then '未校队' else '已校队' end) as statusx "; 
	String fromSql  = " from uf_Contacts f ";
	String sqlWhere = " where SuperID is null and dealStatus=1 and customName="+customID+" ";
	String orderby = " id " ;
	String tableString = "";

  // out.println("select "+ backfields + fromSql + sqlWhere);
/*
	String name = Util.null2String(request.getParameter("name"));
	String sysNo = Util.null2String(request.getParameter("sysNo"));
	String dept = Util.null2String(request.getParameter("dept"));
	String jobTitle = Util.null2String(request.getParameter("jobTitle"));
	String telephone = Util.null2String(request.getParameter("telephone"));
	String mobile = Util.null2String(request.getParameter("mobile"));
	String status = Util.null2String(request.getParameter("status"));
*/
	
if(!"".equals(name)){
	sqlWhere = sqlWhere + " and name like '%"+name+"%'";
}
if(!"".equals(sysNo)){
	sqlWhere = sqlWhere + " and sysNo like '%"+sysNo+"%'";
}
if(!"".equals(dept)){
	sqlWhere = sqlWhere + " and dept like '%"+dept+"%'";
}
if(!"".equals(jobTitle)){
	sqlWhere = sqlWhere + " and Position like '%"+jobTitle+"%'";
}
if(!"".equals(telephone)){
	sqlWhere = sqlWhere + " and Tel like '%"+telephone+"%'";
}
if(!"".equals(mobile)){
	sqlWhere = sqlWhere + " and mobile like '%"+mobile+"%'";
}
if(!"".equals(status)){
	sqlWhere = sqlWhere + " and dealStatus ="+status+" ";
}

//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                 
		tableString+="<col width=\"10%\" labelid=\"572\" text=\"联系人\" column=\"Name\" orderkey=\"Name\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	 "				<col width=\"10%\" labelid=\"620\" text=\"移动电话\" column=\"mobile\" orderkey=\"mobile\" />"+
	  "				<col width=\"10%\" labelid=\"421\" text=\"电话\" column=\"tel\" orderkey=\"tel\"  />"+
	  "				<col width=\"10%\" labelid=\"20869\" text=\"邮箱\" column=\"email\" orderkey=\"email\" />"+
	  "				<col width=\"10%\" labelid=\"1899\" text=\"邮编\" column=\"Postcode\" orderkey=\"Postcode\" />"+
	  "				<col width=\"20%\" labelid=\"110\" text=\"地址\" column=\"Address\" orderkey=\"Address\"  />"+
	  "				<col width=\"15%\" labelid=\"602\" text=\"状态\" column=\"statusx\" orderkey=\"statusx\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function onCheckup(){
		var ids = _xtable_CheckedCheckboxId();
		if(ids != ""){
	//		alert("ids = " + ids);
			document.report.multiIds.value = ids;
			document.report.action = "/seahonor/crm/NpForCustomContactsOper.jsp";
		//	obj.disabled = true;
			document.report.submit();
		}else{
        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
    	}
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
