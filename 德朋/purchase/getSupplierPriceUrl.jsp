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
   String deRemark = Util.null2String(request.getParameter("deRemark"));
   session.setAttribute("deRemark",deRemark);
	String url_1 = "";
	url_1 = "/dp/purchase/supplierPrice.jsp";
     int userid  = user.getUID();
	  String reID = "";
  String sql = " select requestId from  formtable_main_23  where id in(select max(mainid) from  formtable_main_23_dt1 where val="+deRemark+")";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		reID = Util.null2String(RecordSet.getString("requestId"));
	}
	// 01.采购员发起  02.采购主管审批  03.VP审批  04.GM审批  05.结束
    //   219     ,,          247,          248,     249           220 
	String cur_node = "";
String sql_x =  "select nodeid from workflow_currentoperator where id"
	+" in(select max(id) from workflow_currentoperator where isremark in(0,2,4) and requestid="+reID+")" ;
RecordSet.executeSql(sql_x);
if(RecordSet.next()) {
	cur_node = Util.null2String(RecordSet.getString("nodeid"));
}
  String tmc_sql = "";
  int roleID = 11;
  int count=1;
 if(reID.length() > 1){
	 sql =  "select nodeid from workflow_currentoperator where id in("
		+"select max(id) from workflow_currentoperator where isremark in(0,2) and requestid="+reID + " and  userid =" + userid+")";
	
	RecordSet.executeSql(sql);
	tmc_sql = sql;
	if(RecordSet.next()) {
		String tmp_nodeID = Util.null2String(RecordSet.getString("nodeid"));
		tmc_sql = tmp_nodeID;
		if(tmp_nodeID.equals(cur_node)){
			if( "219".equals(tmp_nodeID)){
              roleID = 1;
			}	
		}
			
	}
}
session.setAttribute("nodeid",cur_node);
session.setAttribute("roleID",roleID);
session.setAttribute("xjr",userid);

%>


</head>
 <BODY scroll="no">
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName">询价</span>
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
