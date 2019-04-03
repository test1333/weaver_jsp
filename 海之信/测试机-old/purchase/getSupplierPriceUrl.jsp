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
	url_1 = "/seahonor/purchase/supplierPrice.jsp";
	String url_2 = "/seahonor/purchase/supplierPrice.jsp?roleid2=16";
	String url_3 = "/seahonor/purchase/supplierPrice.jsp?roleid2=17";
	String url_4 = "/seahonor/purchase/supplierPrice.jsp?roleid2=18";
	String url_5 = "/seahonor/purchase/supplierPrice.jsp?roleid2=19";
  
  // 目前项目节点
  int userid  = user.getUID();
  String reID = "";
  String sql = " select requestId from formtable_main_73 where id in(select max(mainid) from formtable_main_73_dt1 where val_1="+deRemark+")";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		reID = Util.null2String(RecordSet.getString("requestId"));
	}
String cur_node = "";
String sql_x =  "select nodeid from workflow_currentoperator where id"
	+" in(select max(id) from workflow_currentoperator where isremark in(0,2,4) and requestid="+reID+")" ;
RecordSet.executeSql(sql_x);
if(RecordSet.next()) {
	cur_node = Util.null2String(RecordSet.getString("nodeid"));
}

// 系统触发  01.行政申请询价  02.会计询价复核  03.综合管理部经理 04.总经理  05.归档  01.行政询价审批 
//   184     ,615,          187,           723,         1128           188       1324
// reID
  String tmc_sql = "";
  int roleID = 0;
 if(reID.length() > 1){
	 sql =  "select nodeid from workflow_currentoperator where id in("
		+"select max(id) from workflow_currentoperator where isremark in(0,2) and requestid="+reID + " and  userid =" + userid+")";
	
	RecordSet.executeSql(sql);
	tmc_sql = sql;
	if(RecordSet.next()) {
		String tmp_nodeID = Util.null2String(RecordSet.getString("nodeid"));
		tmc_sql = tmp_nodeID;
		if(tmp_nodeID.equals(cur_node)){
			if( "615".equals(tmp_nodeID)){
				roleID = 1;
			}else if("1324".equals(tmp_nodeID)){
				roleID = 1;
			}else if("187".equals(tmp_nodeID)){
				roleID = 2;
			}else if("723".equals(tmp_nodeID)){
				roleID = 3;
				url_2 = "/seahonor/purchase/supplierPrice.jsp?roleid2=6";
				url_3 = "/seahonor/purchase/supplierPrice.jsp?roleid2=7";
			}else if("1128".equals(tmp_nodeID)){
				roleID = 4;
				url_2 = "/seahonor/purchase/supplierPrice.jsp?roleid2=6";
				url_3 = "/seahonor/purchase/supplierPrice.jsp?roleid2=7";
				url_4 = "/seahonor/purchase/supplierPrice.jsp?roleid2=8";
			}else {
			    roleID = 55;
			}
		}else{
			if( "615".equals(tmp_nodeID)){
				roleID = 11;
			}else if("1324".equals(tmp_nodeID)){
				roleID = 11;
			}else if("187".equals(tmp_nodeID)){
				roleID = 21;
			}else if("723".equals(tmp_nodeID)){
				roleID = 31;
			}else if("1128".equals(tmp_nodeID)){
				roleID = 41;
			}else{
				roleID = 55;
			}
		}
		if("188".equals(cur_node)){
		    roleID=55;
		
		}
        
	
	}
}
 session.setAttribute("roleID",roleID);
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
				<% if(roleID ==1 || roleID==11) { %>
				<li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">行政询价<span id="allNum_span"></span></a>
				</li>
		       
				<% }else if(roleID ==2 || roleID==21){ %>
                 <li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">会计询价<span id="allNum_span"></span></a>
				</li>
				<% }else if(roleID ==3 || roleID==31){ %>
				<li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">综合管理部询价<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_3%>">会计询价<span id="allNum_span"></span></a>
				</li>
                <li>
					<a target="tabcontentframe" href="<%=url_2%>">行政询价<span id="allNum_span"></span></a>
				</li>
				
				
				<% }else if(roleID ==4 || roleID==41){ %>
				<li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">总经理询价<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_4%>">综合管理部询价<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_3%>">会计询价<span id="allNum_span"></span></a>
				</li>
                <li >
					<a target="tabcontentframe" href="<%=url_2%>">行政询价<span id="allNum_span"></span></a>
				</li>
				
				
			
				<% } else{%>
				<li class="current">
					<a target="tabcontentframe" href="<%=url_5%>">总经理询价<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_4%>">综合管理部询价<span id="allNum_span"></span></a>
					
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_3%>">会计询价<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_2%>">行政询价<span id="allNum_span"></span></a>
					
				</li>
				<% } %>
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
				<% if(roleID ==1 || roleID==11) { %>
				<iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>		       
				<% }else if(roleID ==2 || roleID==21){ %>
                <iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<% }else if(roleID ==3 || roleID==31){ %>
				<iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
                <iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>				
				<% }else if(roleID ==4 || roleID==41){ %>
				<iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
                <iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_4 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				
				<% } else{%>
				 <iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_4 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<iframe src="<%=url_5 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<% } %>
				
			</div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
