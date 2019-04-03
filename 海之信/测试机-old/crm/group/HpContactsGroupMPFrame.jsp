<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
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
        iframe:"tabcontentframe1",

        staticOnLoad:true
    });
}); 
</script>

<%
	String customID = Util.null2String(request.getParameter("customID"));
	
	if("".equals(customID)){
		customID = "-1";
	}
	
%>
</head>
 <BODY scroll="no">
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree1"></div>
		
			<div class="e8_ultab">
			
				<div>
		    <ul class="tab_menu">
		       	<li class="current">
					<a target="tabcontentframe1" href="/seahonor/crm/group/HpContactsGroup.jsp?customID=<%=customID%>">集团<span id="allNum_span11"></span></a>
				</li>
		       	<li class="current">
					<span id="allNum_span22"><font color="red">集团下公司>></font></span>
				</li>
				<%	
					// 查询集团下的所有的客户
					String sql = "select * from uf_custom where CustomGroup="+customID+" and SuperID is null and CutomStatus=1 ";
					RecordSet.executeSql(sql);
	            	int flag = 0;
	            	while(RecordSet.next()){  
	            		String tmp_customName = Util.null2String(RecordSet.getString("customName"));
	            		String tmp_customID = Util.null2String(RecordSet.getString("id"));
				%>
				
		       	<li class="current">
					<a target="tabcontentframe1" href="/seahonor/crm/group/HpContactsCustom.jsp?customID=<%=tmp_customID%>"><%=tmp_customName%><span id="allNum_span22"></span></a>
				</li>
				<%}%>
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
	            <iframe src="/seahonor/crm/group/HpContactsGroup.jsp?customID=<%=customID%>" onload="update()" id="tabcontentframe1" name="tabcontentframe1" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div>   
</BODY>
</HTML>
