<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
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
	String fromDate = Util.null2String(request.getParameter("fromDate"));
	String toDate = Util.null2String(request.getParameter("toDate"));
	int subCompanyId = Util.getIntValue(request.getParameter("subCompanyId"),0);
	int departmentId = Util.getIntValue(request.getParameter("departmentId"),0);
	String resourceId = Util.null2String(request.getParameter("resourceId"));
  Integer lg=(Integer)user.getLanguage();
	String url_1 = "";
	url_1 = "/TaiSon/kq/detail/BeLateDetail.jsp?fromDate="+fromDate+"&toDate="+toDate+"&subCompanyId="+subCompanyId+"&departmentId="+departmentId+"&resourceId="+resourceId;
%>


</head>
 <BODY scroll="no">
 
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav2_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName">迟到明细表</span>
				</div>
				<div>
		    <ul class="tab_menu">
		       <li class="current">
					<a target="tabcontentframe" href="<%=url_1%>"><span id="allNum_span"></span></a>
				</li>
				 
				
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
	             <iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
