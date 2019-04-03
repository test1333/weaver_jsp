<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="wfAgentCondition" class="weaver.workflow.request.wfAgentCondition" scope="page" />
<HTML><HEAD>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
<script type="text/javascript">
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",

        staticOnLoad:true
    });
}); 
</script>

<%
	int userid = user.getUID();
	int subcompanyid=Util.getIntValue(request.getParameter("subCompanyId"));//分部
    int departmentid = Util.getIntValue(request.getParameter("departmentid"));//部门
	String url_1 = "";
	/*if(userid==1){
		url_1 = "/seahonor/shattend.jsp";
	}else{

        url_2 = "/seahonor/shattendpersonal.jsp?userid="+userid;
    }*/
	
	//url_1 = "/seahonor/jsp/ForTheCost.jsp?ExpressCompany="+ExpressCompany;

	url_1 = "/seahonor/express/jsp/SelectExpress.jsp";
	
%>

</head>
 <BODY scroll="no">
	<%
		String empid = "68";
		String tmp_agent = "53";
		String agentWorkflow = "37";
		String infoKeyF = "";
	//	String agentWorkflow = "36";
		String agentretu=wfAgentCondition.agentadd(empid,tmp_agent,"1900-01-01","00:00","2099-12-31","23:59","1",agentWorkflow,"0","1","1",0,user,"2","");
               
		if("".equals(tmp_agent)){
			infoKeyF = "0";
		}else{//代理成功
			String sql = " update uf_start_Authorize set status = 1 where id=1 ";
			RecordSet.executeSql(sql);
			infoKeyF = "1";   
        } 
        
       out.println("infoKeyF = " + infoKeyF + " K = " + agentWorkflow);
	
	%>

</BODY>
</HTML>
