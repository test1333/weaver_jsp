
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>
<%
	String navName = SystemEnv.getHtmlLabelName(18461,user.getLanguage());
	int userid=user.getUID();
%>
<script type="text/javascript">
$(function() {
	$('.e8_box').Tabs({
		getLine : 1,
		iframe : "tabcontentframe",
		mouldID:"<%= MouldIDConst.getID("workflow")%>",
        staticOnLoad:true,
        objName:"<%=navName%>"
	});
	attachUrl();
});


function attachUrl()
{
	$("[name='tabcontentframe']").attr("src","/workflow/request/wfAgentAdd.jsp?isdialog=1&f_weaver_belongto_userid=<%=userid%>");
}


</script>
</HEAD>
<BODY>
<div class="e8_box demo2">
	<div class="e8_boxhead">
		<div class="div_e8_xtree" id="div_e8_xtree"></div>
		<div class="e8_tablogo" id="e8_tablogo"></div>
		<div class="e8_ultab">
			<div class="e8_navtab" id="e8_navtab">
				<span id="objName"></span>
			</div>
	
			<div>
				<ul class="tab_menu">
    			</ul>
    			<div id="rightBox" class="e8_rightBox"></div>
    		</div> 
    	</div>
	</div>
	<div class="tab_box">
        <div>
			<iframe id="tabcontentframe" onload="update();" name="tabcontentframe" class="flowFrame" frameborder="0" scrolling="no" height="100%" width="100%;"></iframe>
  		</div>
    </div>
</div>
</BODY>
</HTML>