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
  int userid1 = user.getUID();
  String canSeeChange = "";
  String prjname="";
  String prjtype="";
  String procode = "";
  String prjid = Util.null2String(request.getParameter("id"));
  String url_1 = "";
  String url_2 = "";
  String url_3 = "";
  String url_4 = "";
  String url_5 = "";
  String url_6 = "";
  String url_7 = "";
  String url_8 = "";
  String departmentid = "";
  String department = "";

  String sql = "select name,prjtype,procode from hs_projectinfo where id="+prjid;
  rs.executeSql(sql);
  if(rs.next()){
	prjname = Util.null2String(rs.getString("name"));
	prjtype = Util.null2String(rs.getString("prjtype"));
	procode = Util.null2String(rs.getString("procode"));

  }
   
  url_1 = "/hsproject/project/view/hs-project-info.jsp?id="+prjid+"&prjtype="+prjtype;
  url_2 = "/hsproject/project/view/hs-prj-inner-process-list.jsp?id="+prjid+"&prjtype="+prjtype;
  url_3 = "/hsproject/project/view/hs-prj-change-record-list.jsp?prjid="+prjid+"&prjtype="+prjtype;
  url_4 = "/hsproject/project/view/hs-prj-gdzc-info-list.jsp?prjid="+prjid;
  url_5 = "/hsproject/project/view/hs-prj-swxx-info-list.jsp?prjid="+prjid;
  url_7= "/hsproject/project/view/hs-prj-attach-list.jsp?prjid="+prjid;
  
  
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
  url_6 = "/hsproject/project/view/hs-prj-usedmoney-list.jsp?prjid="+prjid+"&procode="+procode+"&canSeeChange="+canSeeChange;
  url_8= "/hsproject/project/view/hs-prj-check-attach-list.jsp?prjid="+prjid+"&canSeeChange="+canSeeChange;
%>


</head>
 <BODY scroll="no">
 
	<div class="e8_box demo2">
		<div class="e8_boxhead">
			<div class="div_e8_xtree" id="div_e8_xtree"></div>
			<div class="e8_tablogo" id="e8_tablogo" style="margin-left: 6px; background-image: url('/js/tabs/images/nav/mnav0_wev8.png');"></div>
			<div class="e8_ultab">
				<div class="e8_navtab" id="e8_navtab">
					<span id="objName"><%=prjname%></span>
				</div>
				<div>
		    <ul class="tab_menu">
		       <li class="current">
					<a target="tabcontentframe" href="<%=url_1%>">项目信息<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_2%>">里程碑列表<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_4%>">固定资产列表<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_5%>">商务信息列表<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_6%>">项目历史发生额<span id="allNum_span"></span></a>
				</li>
				<%
				  if("1".equals(canSeeChange)){
				%>
				<li>
					<a target="tabcontentframe" href="<%=url_3%>">项目变更记录<span id="allNum_span"></span></a>
				</li>
				<%
				  }
				%>
				<li>
					<a target="tabcontentframe" href="<%=url_7%>">阶段文档列表<span id="allNum_span"></span></a>
				</li>
				<li>
					<a target="tabcontentframe" href="<%=url_8%>">项目验收文档列表<span id="allNum_span"></span></a>
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
				 <iframe src="<%=url_4 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				 <iframe src="<%=url_5 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				 <iframe src="<%=url_6 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				 <%
				  if("1".equals(canSeeChange)){
				 %>
				 <iframe src="<%=url_3 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	       		 <%
				  }
				 %>
				  <iframe src="<%=url_7 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
				  <iframe src="<%=url_8 %>" onload="update()" id="tabcontentframe" name="tabcontentframe" class="flowFrame" frameborder="0" height="100%" width="100%;"></iframe>
	        </div>
	    </div>
	</div> 
	<!--  -->

</BODY>
</HTML>
