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
<%!
	//获取当前日期
	public String getNowDate(){   
   	 String temp_str="";   
    	Date dt = new Date();   
    	//最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制   
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");     
    	temp_str=sdf.format(dt);   
    	return temp_str;   
	} 
%>

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

		if("1".equals(info)){%>
			top.Dialog.alert("代理开启失败！")
		<%}

		else if("2".equals(info)){%>
			top.Dialog.alert("代理开启成功！")
		<%}

		else if("3".equals(info)){%>
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
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	//isSetAgent 判断是否开启代理 0开启 1关闭
	String isSetAgent = Util.null2String(request.getParameter("isSetAgent"));
	if("".equals(isSetAgent)) isSetAgent = "1";

	//if("".equals(fromdate)) fromdate = getNowDate();
	//if("".equals(enddate)) enddate = getNowDate();

	String nowDate = getNowDate();
	String currentDate = nowDate.substring(0,10);
	String currentTime = nowDate.substring(11,19);
	/*out.print("nowDate="+nowDate);
	out.print("currentDate="+currentDate);
	out.print("currentTime="+currentTime);*/
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String requestid = "";
	String agentFirst = "";
	String agentSecond = "";
	String status = "";
	String sql = "";
	sql = " select count(*) as num_Set from Workflow_Agent where agenttype = 1 and beagenterId ="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		int num_Set = rs.getInt("num_Set");
		if(num_Set>0){
			isSetAgent = "0";
		}else{
			isSetAgent = "1";
		} 
	}

	sql = " select requestId,authorizer,agentFirst,agentSecond,status from uf_start_Authorize where authorizer="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		requestid = Util.null2String(rs.getString("requestId"));
		agentFirst = Util.null2String(rs.getString("agentFirst"));
		agentSecond = Util.null2String(rs.getString("agentSecond"));
		status = Util.null2String(rs.getString("status"));
	}
	//out.print("userid="+userid);
	//out.print("isSetAgent="+isSetAgent);
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<INPUT type="hidden" id="userid" name="userid" value="<%=userid%>">
			<INPUT type="hidden" id="requestid" name="requestid" value="<%=requestid%>">
			<INPUT type="hidden" id="agentFirst" name="agentFirst" value="<%=agentFirst%>">
			<INPUT type="hidden" id="agentSecond" name="agentSecond" value="<%=agentSecond%>">
			<INPUT type="hidden" id="status" name="status" value="<%=status%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td></td>
				<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"></span>
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</td>
			</tr>
		</table>
		<div>
		<table width="100%" class="ListStyle" style="font-size: 8pt;border-bottom:1px solid #CCC;">
			<colgroup>
			<col width="10%"></col>
			<col width="5%"></col>
			<col width="10%"></col>
			<col width="55%"></col>
			<col width="10%"></col>
			<col width="10%"></col>
			</colgroup>
					
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<%if("0".equals(isSetAgent)){%>
				<td><input type="button" value="打开" class="e8_btn_submit" onclick="firmCloseAgent ()"></td>
				<%}else{%>
				<td><input type="button" value="关闭" class="e8_btn_submit" onclick="firmOpenAgent()"></td>
				<%}%>
			</tr>
		</table>
	</div>
	</FORM>
<%

		String backfields = "id,requestId,authorizer,createTime,agentFirst,agentSecond,updateTime,remarkStart,remarkOver, "
						+" case status when 1 then '无效' else '有效' end as status ";
		String fromSql  = " from uf_start_Authorize ";
		String sqlWhere = " 1=1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " createTime " ;
		String tableString = "";
		String operateString= "";
        
        if(userid==1){
        	sqlWhere += " ";	
    	}else{
    		sqlWhere += "and authorizer ="+userid;
    }
        /*//员工姓名
        if(!"".equals(resourceid)){
			sqlWhere += "and authorizer ="+resourceid+" ";
		}*/

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
			"		<head>";
		tableString+="<col width=\"10%\" labelid=\"413\" text=\"授权人\" column=\"authorizer\" orderkey=\"authorizer\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"15%\" labelid=\"20058\" text=\"创建时间\" column=\"createTime\" orderkey=\"createTime\" />"+
			"		<col width=\"10%\" labelid=\"20059\" text=\"一级代理人\" column=\"agentFirst\" orderkey=\"agentFirst\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
			"		<col width=\"10%\" labelid=\"20061\" text=\"二级代理人\" column=\"agentSecond\" orderkey=\"agentSecond\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
			"		<col width=\"15%\" labelid=\"-5\" text=\"更新时间\" column=\"updateTime\" orderkey=\"updateTime\" />"+
			"		<col width=\"5%\" labelid=\"15591\" text=\"状态\" column=\"status\" orderkey=\"status\"/>"+
			"		<col width=\"30%\" labelid=\"20061\" text=\"备注\" column=\"remarkStart\" orderkey=\"remarkStart\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}

		function firmOpenAgent(){
			if(confirm("确定开启代理？")){
				//alert(111);
				report.action = "/seahonor/jsp/addAgent.jsp?isSetAgent=0";
				//report.action = "/seahonor/jsp/SetAgent.jsp";
				report.submit();	
			}
				
		}

		function firmCloseAgent(){
			if(confirm("确定关闭代理？")){
				//alert(111);
				report.action = "/seahonor/jsp/addAgent.jsp?isSetAgent=1";
				//report.action = "/seahonor/jsp/SetAgent.jsp";
				report.submit();	
			}
				
		}

	</script>
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>