
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
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

String DID = Util.null2String(request.getParameter("DID"));

if("".equals(DID)){
	DID = "-1";
}
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
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
								
	String backfields = " a.*"; 
	String fromSql  = " from uf_Con_ku_OTC_HTWJ a";
	String sqlWhere = " where a.superid = '" + DID + "'";
	String orderby = " a.version desc" ;
    String operateString= "";
	String tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
	operateString+
	"			<head>";
	tableString+="<col width=\"17%\" text=\"合同编号\" column=\"ZCONNECT\" orderkey=\"ZCONNECT\" linkvaluecolumn=\"id\" linkkey=\"billid\" "+
		" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=2745&amp;formId=-684&amp;opentype=0&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
 "				<col width=\"10%\"  text=\"合同有效期 \" column=\"ZVALID\" orderkey=\"ZVALID\"   />"+
  "				<col width=\"10%\"  text=\"工厂名称 \" column=\"ZPLANTNAME\" orderkey=\"ZPLANTNAME\" />"+
  "				<col width=\"10%\"  text=\"咨询单号码\" column=\"OBJECT_ID\" orderkey=\"OBJECT_ID\"   />"+
  "				<col width=\"10%\"  text=\"供方\" column=\"ZORG_NAME\" orderkey=\"ZORG_NAME\"   />"+
  "				<col width=\"10%\"  text=\"需方\" column=\"ZSOLD_NAME\" orderkey=\"ZSOLD_NAME\"   />"+
  "				<col width=\"10%\"  text=\"签定日期\" column=\"ZZCON_DATE\" orderkey=\"ZZCON_DATE\"   />"+
  "				<col width=\"10%\"  text=\"版本\" column=\"version\" orderkey=\"version\"   />"+
"			</head>"+
" </table>";
     
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">

	</script>
	

</BODY>
</HTML>
