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
spckxx.src = "/formmode/search/CustomSearchBySimple.jsp?customid=201"; 
} 
function splj(){ 
var splj = document.getElementById("i"); 
splj.src = "/formmode/search/CustomSearchBySimple.jsp?customid=201"; 
} 
function dy(){ 
var dy = document.getElementById("i"); 
dy.src = "/formmode/search/CustomSearchBySimple.jsp?customid=201"; 
} 
function spjl(){ 
var spjl = document.getElementById("i"); 
spjl.src = "/formmode/search/CustomSearchBySimple.jsp?customid=201"; 
} 
</script> 
<style type="text/css"> 
#i{ 
width:100%; 
height:300px; 
} 
</style> 
</head> 

<body> 

<div> 
<input type = "button" value ="审批记录" onclick = "spjl()"/> 
<input type = "button" value ="审批路径" onclick = "splj()"/> 
<input type = "button" value ="审批查看信息" onclick = "spckxx()"/> 
<input type = "button" value ="打印" onclick = "dy()"/> 
</div> 
<iframe id = "i" scrolling = "no" src="/formmode/search/CustomSearchBySimple.jsp?customid=201"> 
</iframe> 
</body> 
</HTML>
