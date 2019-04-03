<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String info = (String)request.getParameter("infoKey");
	%>
	<script language="JavaScript">
	<%if(info!=null && !"".equals(info)){

		if("3".equals(info)){%>
			top.Dialog.alert("代理关闭成功！")
		<%}

		else if("4".equals(info)){%>
			top.Dialog.alert("代理关闭失败！")
		<%}
	}%>
	</script>
	<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";

	int userid = user.getUID();
	Boolean isAdmin=false;
	String sql="";
	sql=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		int num_admin=rs.getInt("num_admin");
		if(num_admin>0){
			isAdmin=true;
		}
	}
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		//RCMenu += "{"+SystemEnv.getHtmlLabelName(309,user.getLanguage())+",javascript:setAgent(),_self} " ;
		//RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		
		</FORM>
<%

		String backfields = " id,requestId,authorizer,createTime,agentFirst,agentSecond,updateTime,remarkStart,remarkOver, "
						+" case status when 0 then '关闭' else '启用' end as agentStatus,status, "
                        +" case isEffective when 0 then '有效' else '无效' end as isEffective, "
						+" (select workflowname from workflow_base where id = agentWorkflow) as agentWorkflow ";
		String fromSql  = " from uf_start_Authorize ";
		String sqlWhere = " status=0 and isEffective=1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " createTime,status " ;
		String tableString = "";
		String operateString= "";
        
        if(isAdmin){
        	sqlWhere += " ";	
    	}else{
    		sqlWhere += "and (authorizer ="+userid+" or (agentFirst = "+userid+" and status=1) or (agentSecond = "+userid+" and status=1)) ";
    	}
		
        /*//员工姓名
        if(!"".equals(resourceid)){
			sqlWhere += "and authorizer ="+resourceid+" ";
		}*/
        
        //out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
        
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
			"		<head>";
		tableString+="<col width=\"10%\" labelid=\"413\" text=\"授权人\" column=\"authorizer\" orderkey=\"authorizer\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"15%\" labelid=\"20058\" text=\"创建时间\" column=\"createTime\" orderkey=\"createTime\" />"+
			"		<col width=\"10%\" labelid=\"20059\" text=\"一级代理人\" column=\"agentFirst\" orderkey=\"agentFirst\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
			"		<col width=\"10%\" labelid=\"20061\" text=\"二级代理人\" column=\"agentSecond\" orderkey=\"agentSecond\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
			"		<col width=\"15%\" labelid=\"32611\" text=\"代理流程\" column=\"agentWorkflow\" orderkey=\"agentWorkflow\" />"+
			"		<col width=\"5%\" labelid=\"15591\" text=\"状态\" column=\"agentStatus\" orderkey=\"agentStatus\"/>"+
            "		<col width=\"10%\" labelid=\"20061\" text=\"是否有效\" column=\"isEffective\" orderkey=\"isEffective\"/>"+
			"		<col width=\"20%\" labelid=\"20061\" text=\"备注\" column=\"remarkStart\" orderkey=\"remarkStart\"/>"+
		    "		</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		function setAgent(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			Dialog.confirm("确认关闭？", function (){
	        		report.action="/seahonor/attend/jsp/SetAgent_1.jsp?id="+ids;
					report.submit();
				}, function () {}, 320, 90,false);
		}	
		/*function setAgent(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			if(confirm("确认关闭？")) {
				report.action = "/seahonor/attend/jsp/SetAgent_1.jsp?id="+ids;
				report.submit();
			}
		}*/
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>