<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.systeminfo.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="ln.LN"%>
<%@ page import="weaver.hrm.settings.RemindSettings" %>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="weaver.workflow.workflow.TestWorkflowCheck" %>
<%@ page import="weaver.systeminfo.template.UserTemplate"%>
<%@ page import="weaver.systeminfo.setting.*,weaver.sitetour.PageTourCache" %>
<%@page import="weaver.login.LicenseCheckLogin"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="pack" class="weaver.general.ParameterPackage" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<script language="javascript" type="text/javascript" src="/FCKEditor/swfobject_wev8.js"></script>
<script type="text/javascript" src="/js/select/script/jquery-1.8.3.min_wev8.js"></script>	 
<script language="vbs" src="/js/string2VbArray.vbs"></script>       
<script type="text/javascript" src="/js/jquery.table_wev8.js"></script>
<script language="javascript" type="text/javascript" src="/js/init_wev8.js"></script>
<script language="javascript"  src="/js/wbusb_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<script type='text/javascript' src='/js/jquery-autoco/wui/common/page/initWui.jspmplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/lang/weaver_lang_7%>_wev8.js"></script>
<script type="text/javascript" src="/js/messagejs/highslide/highslide-full_wev8.js"></script>
<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
<HTML><HEAD>

<%
String saprequestid = Util.null2String(request.getParameter("requestid")) ;
int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
    String requestid="";
	String pernr_f="";
	String sql="select lc_no,pernr_f from zoat00020 where oa_md5='"+saprequestid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("lc_no"));
		pernr_f = Util.null2String(rs.getString("pernr_f"));
	}
	if("".equals(requestid)){
		sql="select lc_no,pernr_f from zoat00030 where oa_md5='"+saprequestid+"'";
		rs.executeSql(sql);
		if(rs.next()){
			requestid = Util.null2String(rs.getString("lc_no"));
			pernr_f = Util.null2String(rs.getString("pernr_f"));
		}
	}
	if("".equals(requestid)){
		response.sendRedirect("/appdevjsp/HQ/SAPOA/noright.jsp?lan="+saplan);
		return;
	}
request.getSession().setAttribute("weaver_user@bean", User.getUser(Integer.valueOf("11000209"), 0));
User user = HrmUserVarify.getUser (request , response);
user.setLanguage(saplan);
int userid=user.getUID(); 
int usertype = 0 ;
int workflowid =0;
int isbill = 0;
int formid =0;
sql="select workflowid from workflow_requestbase where requestid='"+requestid+"'";
rs.executeSql(sql);
if(rs.next()){
	workflowid = rs.getInt("workflowid");
}
sql="select isbill,formid from workflow_base  where id="+workflowid;
rs.executeSql(sql);
if(rs.next()){
	isbill = rs.getInt("isbill");
	formid= rs.getInt("formid");
}
String showupload="";
String showdoc="";
String showworkflow="";
String reportid = Util.null2String(request.getParameter("reportid"));
String isfromreport = Util.null2String(request.getParameter("isfromreport"));
String isfromflowreport = Util.null2String(request.getParameter("isfromflowreport"));
String iswfshare = Util.null2String(request.getParameter("iswfshare"));

String urlparam = "workflowid=" + workflowid + "&requestid=" + requestid + "&isbill=" + isbill + "&formid=" + formid + "&reportid=" + reportid + "&isfromreport=" + isfromreport + "&isfromflowreport=" + isfromflowreport + "&iswfshare=" + iswfshare +"&f_weaver_belongto_userid="+userid+"&f_weaver_belongto_usertype="+usertype;
String navName = "";
/*
String sql="select showuploadtab,showdoctab,showworkflowtab from workflow_base where id="+workflowid+" and formid="+formid+" and isbill="+isbill;
RecordSet.executeSql(sql);
if(RecordSet.next()){
	showupload=Util.null2String(RecordSet.getString("showuploadtab"));
	showdoc=Util.null2String(RecordSet.getString("showdoctab"));
	showworkflow=Util.null2String(RecordSet.getString("showworkflowtab"));
}
*/
%>

<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
<script type="text/javascript">
	var parentWin = null;
	var dialog = null;
	try{
		parentWin = parent.getParentWindow(window);
		dialog = parent.getDialog(window);
	}catch(e){}
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        mouldID:"<%= MouldIDConst.getID("workflow")%>",
        iframe:"tabcontentframe",
        staticOnLoad:true
    });
}); 
jQuery(document).ready(function(){ setTabObjName("<%=Util.toScreenForJs(navName) %>"); });
</script>
<style type="text/css">

#reqresnavblock ul li,#reqresnavblock ul li a, #reqresnavblock ul {
	height:30px;
	line-height:28px;
}

.h24 {
/*
	height:24px;
	line-height:24px;
	*/
}
</style>
<%
	String url = "/workflow/request/RequestResources.jsp?tabindex=0&" + urlparam;
	int current = Util.getIntValue(request.getParameter("current"), 0);
	//System.out.println("current = "+current);
%>

</head>
<BODY scroll="no">
    <div class="e8_box demo2" id="reqresnavblock">
        <ul class="tab_menu" style="" class="h24" >
	   		<li <%if(current==0){%>class="current"<%} %> class="h24" >
	        	<a href="/workflow/request/RequestResources.jsp?tabindex=0&<%=urlparam %>" target="tabcontentframe" class="h24" style="">
	        		<%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%>
	        	</a>
	        </li>
	      
	       	 <li <%if(current==1){%>class="current"<%} %> class="h24" >
	        	<a href="/workflow/request/RequestResources.jsp?tabindex=1&<%=urlparam %>" target="tabcontentframe" class="h24" style="">
	        		<%=SystemEnv.getHtmlLabelName(1044,user.getLanguage())%> 
	        	</a>
	        </li>
	        
	         <li <%if(current==2){%>class="current"<%} %> class="h24" >
	        	<a href="/workflow/request/RequestResources.jsp?tabindex=2&<%=urlparam %>" target="tabcontentframe" class="h24" style="">
	        		<%=SystemEnv.getHtmlLabelName(857,user.getLanguage())%>  
	        	</a>
	        </li> 
	        
	        <li <%if(current==3){%>class="current"<%} %> class="h24" >
	        	<a href="/workflow/request/RequestResources.jsp?tabindex=3&<%=urlparam %>" target="tabcontentframe" class="h24">
	        		<%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%>  
	        	</a>
	        </li>
	        
		</ul>
	    <div class="tab_box">
	        <iframe src="<%=url %>" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	    </div>
	</div>  
</body>
</html>