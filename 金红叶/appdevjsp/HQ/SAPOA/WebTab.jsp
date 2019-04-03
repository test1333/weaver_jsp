
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<html>
<%
	String type=Util.null2String(request.getParameter("type"));
	String showtype=Util.null2String(request.getParameter("showtype"));
%>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<link type="text/css" href="/js/tabs/css/e8tabs1_wev8.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/ecology8/request/searchInput_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/searchInput_wev8.js"></script>

<link rel="stylesheet" href="/css/ecology8/request/seachBody_wev8.css" type="text/css" />
<link rel="stylesheet" href="/css/ecology8/request/hoverBtn_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/hoverBtn_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/request/titleCommon_wev8.js"></script>

<body scroll="no" >
<%
	String loadurl="";
	String navName = "";
	if(showtype.equals("1"))
	{
		navName = "WebService触发集成";//
		loadurl="/appdevjsp/HQ/SAPOA/automaticsetting.jsp?biaoji=1";
	}
%>
<div class="e8_box demo2">
<div class="e8_boxhead">
		<div class="div_e8_xtree" id="div_e8_xtree"></div>
        <div class="e8_tablogo" id="e8_tablogo"></div>
		<div class="e8_ultab">
			<div class="e8_navtab" id="e8_navtab">
				<span id="objName"></span>
			</div>
			<div>
		<%if(showtype.equals("1")){ %>
		<ul class="tab_menu">
			<li class='current'>																		
				<a onmouseover="javascript:showSecTabMenu('#automaticbox','tabcontentframe');" href="/appdevjsp/HQ/SAPOA/automaticsetting.jsp?biaoji=1" target="tabcontentframe">
					<%=SystemEnv.getHtmlLabelName(32366,user.getLanguage())%><!-- 流程触发集成列表 -->
	    	</a>
			</li>
			<li>
					<a href="/appdevjsp/HQ/SAPOA/automaticsetting.jsp?biaoji=2" target="tabcontentframe">
					已删除流程触发列表<!-- 触发周期设置 -->
	    	</a>
	    </li>
	  </ul>

<%
}
%>
	<div id="rightBox" class="e8_rightBox">
	</div>
  </div>
 </div>
</div>
	
	<div class="tab_box">
	    <div>
	        <iframe src="<%=loadurl%>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	    </div>
	</div>
</div>
</body>
<script type="text/javascript">
	
$(function(){
    $('.e8_box').Tabs({
        getLine:1,
        iframe:"tabcontentframe",
        mouldID:"<%= MouldIDConst.getID("integration")%>",
        staticOnLoad:true,
        notRefreshIfrm:true,
        objName:"<%=navName%>",
        hideSelector:"#automaticbox"
    });
});
	
</script>
</html>