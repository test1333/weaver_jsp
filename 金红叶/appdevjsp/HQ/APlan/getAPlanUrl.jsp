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
        iframe:"tabcontentframe",

        staticOnLoad:true
    });
}); 
</script>

<%

	String sql = "select machine from uf_machine ";
	rs.execute(sql);
	String machine="";
	if(rs.next()){
		machine=Util.null2String(rs.getString("machine"));
	}
	
    String model = Util.null2String(request.getParameter("model"));
    session.setAttribute("model",model);
	String url_1 = "";
	String url_2 = "";
	String url_3 = "";
	String url_4 = "";
	String url_5 = "";
	url_1 = "/appdevjsp/HQ/APlan/APlanList.jsp?gzzt_0=true&gzzt_1=true&gzzt_2=true&gzzt_3=false&gzzt_4=false";
	url_2 = "/appdevjsp/HQ/APlan/AFlowDesignList.jsp?gzzt_0=true&gzzt_1=true&gzzt_2=true&gzzt_3=true&gzzt_4=true&gzzt_5=true&gzzt_6=true&gzzt_7=false&gzzt_8=false";
	if("DEV".equals(machine)){
		url_3 = "/page/element/ReportForm/reportformtabs.jsp?ebaseid=reportForm&eid=341&hpid=121&subCompanyId=1&indie=true&needHead=true";
		url_4 = "/page/element/ReportForm/reportformtabs.jsp?ebaseid=reportForm&eid=361&hpid=121&subCompanyId=1&indie=true&needHead=true";
    }
	else{
		url_3 = "/page/element/ReportForm/reportformtabs.jsp?ebaseid=reportForm&eid=166&hpid=63&subCompanyId=1&indie=true&needHead=true";
		url_4 = "/page/element/ReportForm/reportformtabs.jsp?ebaseid=reportForm&eid=167&hpid=63&subCompanyId=1&indie=true&needHead=true";
	}
	url_5 = "http://172.18.88.74:8075/WebReport/ReportServer?reportlet=ztjh_report.cpt";
	
%>


</head>
 <BODY scroll="no">
 
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName">A+项目计划</span>
				</div>
				<div>
		    <ul class="tab_menu">
		       	<li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">专题讨论计划<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_2%>">流程讨论和设计计划<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_3%>">专题讨论计划统计<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_4%>">流程讨论计划统计<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_5%>">专题计划统计(new)<span id="allNum_span"></span></a>
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
	            <iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	            <iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	            <iframe src="<%=url_4 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	            <iframe src="<%=url_5 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
