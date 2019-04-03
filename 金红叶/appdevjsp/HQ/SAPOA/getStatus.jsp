<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
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
	String saprequestid = Util.null2String(request.getParameter("requestid")) ;
	int saplan = Util.getIntValue(request.getParameter("lan"),7) ;
%>


</head>
 <script type="text/javascript"> 
 function spckxx(){ 
var spckxx = document.getElementById("i"); 
spckxx.src = "/appdevjsp/HQ/SAPOA/WorkflowPictureStatusZOA.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
function splj(){ 
var splj = document.getElementById("i"); 
splj.src = "/appdevjsp/HQ/SAPOA/WorkflowPictureZOA.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
function dy(){ 
var dy = document.getElementById("i"); 
dy.src = "/appdevjsp/HQ/SAPOA/PrintWorkFlowPrintRequest.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
function spjl(){ 
var spjl = document.getElementById("i"); 
spjl.src = "/appdevjsp/HQ/SAPOA/workflowRemark.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
function allspjl(){ 
var allspjl = document.getElementById("i"); 
allspjl.src = "/appdevjsp/HQ/SAPOA/workflowRemarkAll.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
function xgzy(){ 
var xgzy = document.getElementById("i"); 
xgzy.src = "/appdevjsp/HQ/SAPOA/RequestResourcesZOA.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"; 
} 
</script> 
<style type="text/css"> 
#i{ 
width:100%; 
height:600px; 
scrolling:auto;
} 
 $(document.body).css({
   "overflow-y":"hidden";
 });
</style> 
</head> 

<body> 

<div> 
<input type = "button" value ="审批记录" onclick = "spjl()"/> 
<input type = "button" value ="审批路径" onclick = "splj()"/> 
<input type = "button" value ="审批查看信息" onclick = "spckxx()"/> 
<input type = "button" value ="打印" onclick = "dy()"/> 
<input type = "button" value ="全部审批记录" onclick = "allspjl()"/> 
<input type = "button" value ="相关资源" onclick = "xgzy()"/> 
</div> 
<iframe id = "i" scrolling = "auto" src="/appdevjsp/HQ/SAPOA/workflowRemark.jsp?requestid=<%=saprequestid%>&lan=<%=saplan%>"> 
</iframe> 
</body> 
</HTML>
