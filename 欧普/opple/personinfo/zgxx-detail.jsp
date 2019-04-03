
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

String billid = Util.null2String(request.getParameter("billid"));

if("".equals(billid)){
	billid = "-1";
}
String tmc_pageId = "zgxx001";
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<!--<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>-->
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
//RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
//RCMenuHeight += RCMenuHeightStep ;


%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action=# method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				
			</tr>
		</table>

	</FORM>
	<%
								
	String backfields = "id,profession_type_name,profession_grade,profession_credential_name,profession_credential_nu,profession_credential_org,profession_credential_from,profession_credential_to"; 
	String fromSql  = " from uf_person_detail_dt3 ";
	String sqlWhere = " where mainid = " + billid;
	String orderby = " id asc" ;
	String tableString = "";


//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" >"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"10%\"  text=\"工种名称\" column=\"profession_type_name\" orderkey=\"profession_type_name\"   />"+
	 "				 <col width=\"10%\"  text=\"技能等级\" column=\"profession_grade\" orderkey=\"profession_grade\"   /> "+
	 "				 <col width=\"10%\"  text=\"证书名称\" column=\"profession_credential_name\" orderkey=\"profession_credential_name\"   /> "+
	 "				 <col width=\"10%\"  text=\"证书编号\" column=\"profession_credential_nu\" orderkey=\"profession_credential_nu\"   /> "+
	 "				 <col width=\"10%\"  text=\"发证机构\" column=\"profession_credential_org\" orderkey=\"profession_credential_org\"   /> "+
	 "				 <col width=\"10%\"  text=\"有效从\" column=\"profession_credential_from\" orderkey=\"profession_credential_from\"   /> "+
	 "				 <col width=\"10%\"  text=\"有效至\" column=\"profession_credential_to\" orderkey=\"profession_credential_to\"   /> "+
		
				
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">

	</script>
</BODY>
</HTML>
