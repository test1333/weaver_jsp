
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

if("".equals(customID)){
	customID = "-1";
}
/*		HashMap<String,String> map = new HashMap<String,String>();
		String sql = "select id,customName from uf_custom where id in(select customName from uf_customJoinGroup where GroupName="+customID+")";
		RecordSet.executeSql(sql);
		while(RecordSet.next()){  
			String tmp_id1 = Util.null2String(RecordSet.getString("id"));
			String tmp_name1 = Util.null2String(RecordSet.getString("customName"));
			map.put(tmp_id1,tmp_name1);
		}*/
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
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				
			</tr>
		</table>

	</FORM>
	<%

/*Iterator<String> it = map.keySet().iterator();
while(it.hasNext()){
String tmp_id_x = it.next();
String tmp_name_x = map.get(tmp_id_x);
}*/
//	out.prinln(tmp_name_x);	
							
	String backfields = " id,createDate,projectNo,projectName,(case status when 0 then '进行中' else '完成' end) as status,manager, "
		+"(select customName from uf_custom where id=custom) as customName "; 
	String fromSql  = " from uf_project ";
	String sqlWhere = " where custom  in(select customName from uf_customJoinGroup where GroupName="+customID+")";
	String orderby = " createDate " ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"/hrm/resource/HrmResourceBase.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"查看\" target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+
				 	    "     <operate href=\"/hrm/resource/HrmResourceBasicEdit.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"编辑\" target=\"_fullwindow\" isalwaysshow='true' index=\"1\"/>"+
				        "     <operate href=\"/workplan/data/WorkPlan.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"个人日程\" target=\"_fullwindow\" isalwaysshow='true' index=\"3\"/>"+
 	       				"</operates>";	
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\" labelid=\"714\" text=\"创建日期\" column=\"createDate\" orderkey=\"createDate\"/>"+
	 "				<col width=\"10%\" labelid=\"413\" text=\"客户名称\" column=\"customName\" orderkey=\"customName\"  />"+
	  "				<col width=\"10%\" labelid=\"413\" text=\"项目代码\" column=\"projectNo\" orderkey=\"projectNo\" linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/hrm/resource/HrmResource.jsp?1=1\" target=\"_fullwindow\" />"+
	  "				<col width=\"10%\" labelid=\"141\" text=\"项目名称\" column=\"projectName\" orderkey=\"projectName\"  href=\"/hrm/company/HrmDepartment.jsp\"  linkkey=\"subcompanyid\" target=\"_fullwindow\"/>"+
	  "				<col width=\"10%\" labelid=\"124\" text=\"状态\" column=\"status\" orderkey=\"status\" />"+
	  "				<col width=\"15%\" labelid=\"421\" text=\"责任人\" column=\"manager\" orderkey=\"manager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
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
