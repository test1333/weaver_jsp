<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="hsproject.util.ProjectUtil" %>
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
  String processname="";
  String prjtype="";
  String prjid="";
  String processtype="";
  String processid = Util.null2String(request.getParameter("id"));
  String url_1 = "";
  String url_2 = "";
	
  String sql="select prjid,processname,prjtype,processtype from hs_prj_process where id="+processid;
  rs.executeSql(sql);
  if(rs.next()){
	processname = Util.null2String(rs.getString("processname"));
	prjtype = Util.null2String(rs.getString("prjtype"));
	processtype = Util.null2String(rs.getString("processtype"));
	prjid = Util.null2String(rs.getString("prjid"));

  }
   int userid1 = user.getUID();
  String canSeeChange = "";
String departmentid = "";
  String department = "";
  ProjectUtil pu = new ProjectUtil();
  if(userid1 == 1){
  	canSeeChange ="1";
  }else{
    sql = "select departmentid from hrmresource where id="+userid1;
    rs.executeSql(sql);
    if(rs.next()){
    	departmentid = Util.null2String(rs.getString("departmentid"));
	}
	if(!"".equals(departmentid)){
		sql="select department from uf_project_type where id="+prjtype;
		rs.executeSql(sql);
		if(rs.next()){
			department = Util.null2String(rs.getString("department"));
		}
		String supdp = pu.getSupperDepartmentId(departmentid);
		if(departmentid.equals(department)|| supdp.equals(department) ){
			canSeeChange ="1";
		}
	}
  }
  
  url_1 = "/hsproject/project/view/hs-process-info.jsp?id="+processid+"&prjtype="+prjtype+"&processtype="+processtype;
  url_2 = "/hsproject/project/view/hs-prj-process-change-record-list.jsp?processid="+processid+"&prjtype="+prjtype+"&prjid="+prjid+"&processtype="+processtype;;
%>


</head>
 <BODY scroll="no">
 
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName"><%=processname%></span>
				</div>
				<div>
		    <ul class="tab_menu">
		        <li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">阶段信息<span id="allNum_span"></span></a>
				</li>
				<%
				  if("1".equals(canSeeChange)){
				%>
				 <li >
					<a target="tabcontentframe" href="<%=url_2%>">阶段变更记录<span id="allNum_span"></span></a>
				</li>
				<%
				  }
				%>
				
		    </ul>
	    <div id="rightBox" class="e8_rightBox">
	    </div>
	    </div>
	    </div>
	    </div>
	    <div class="tab_box">
	        <div>
	             <iframe src="<%=url_1 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	            <%
				  if("1".equals(canSeeChange)){
				%>
				 <iframe src="<%=url_2 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				<%
				  }
				%>
				
	        </div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
