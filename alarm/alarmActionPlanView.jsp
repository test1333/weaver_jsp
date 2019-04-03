<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
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
	Calendar now = Calendar.getInstance();
	 String alarmid = (String)session.getAttribute("alarmid");
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String zuzhidanwei="";
	String duration="";
	String kfcode="";
	String kfname="";
	String approvestatus="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String sql="select  area||province||sales_grp as zuzhidanwei,duration,kfcode,kfname,approvestatus from uf_alarm_info where alarm_id= "+alarmid;
	rs.execute(sql);
	if(rs.next()){
	   zuzhidanwei =  Util.null2String(rs.getString("zuzhidanwei"));
	   duration =  Util.null2String(rs.getString("duration"));
	   kfcode =  Util.null2String(rs.getString("kfcode"));
	   kfname =  Util.null2String(rs.getString("kfname"));
	   approvestatus=  Util.null2String(rs.getString("approvestatus"));
	}
	 sql="select is_approve,is_send from uf_action_plan where rownum=1 and alarmid='"+alarmid+"'";

		 String is_approve1 ="";
		 String is_send1="";
		 String caozuo="0";
		  rs.execute(sql);
		  if(rs.next()){
		  is_approve1 =  Util.null2String(rs.getString("is_approve"));
		  is_send1 =  Util.null2String(rs.getString("is_send"));
		  }
		  if("1".equals(is_send1)){
		  caozuo = "1";
		  }
		  if("1".equals(is_approve1)){
		  caozuo = "2";
		  }
	%>

	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					
					<td class="rightSearchSpan" style="text-align:right;">
						
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
					
				</tr>
			</table>
			
			<% // 查询条件 %>
			
		</FORM>
		<table style="width:100%;">
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">组织单位： <%=zuzhidanwei%></td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;">时间区间： <%=duration%></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">行动指标： <%=kfcode%> <%=kfname%></td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;"><a href="#" style="color:blue;text-decoration:underline;">审批意见查询</a></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:25%;font-size: 10pt;height:25px;">Alarm ID: <%=alarmid%></td>
			<td></td>
			
		</tr>
		
		</table>
		<%
		
		String backfields = "id as idkey ,actionid,xdfa,famb,sjwc,jzrq,wcbl,decode(xdzt,0,'未开始',1,'进行中',2,'已完成','未开始') as xdzt,decode('"+caozuo+"','1','审批中','2','进展维护','编辑') as xianshi";
		String fromSql  = " uf_action_plan ";
		String sqlWhere = " where 1=1 ";
		String orderby = " id asc";
		String tableString = "";
		sqlWhere +=" and alarmid ="+alarmid;
		String  operateString= "";
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"Action ID\" column=\"actionid\" orderkey=\"actionid\"/>"+
			"               <col width=\"20%\" text=\"行动方案\" column=\"xdfa\" orderkey=\"xdfa\"/>"+
			"               <col width=\"15%\" text=\"方案目标\" column=\"famb\" orderkey=\"famb\"/>"+
			"               <col width=\"15%\" text=\"实际完成\" column=\"sjwc\" orderkey=\"sjwc\"/>"+
			"               <col width=\"10%\" text=\"截止日期\" column=\"jzrq\" orderkey=\"jzrq\"/>"+
			"               <col width=\"10%\" text=\"完成比率\" column=\"wcbl\" orderkey=\"wcbl\"/>"+
			"               <col width=\"10%\" text=\"行动状态\" column=\"xdzt\" orderkey=\"xdzt\"/>"+
			"               <col width=\"10%\" text=\"操作\"  column=\"\" orderkey=\"\"  />"+					
		    "			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		function onBtnNewClick() {
			var val=<%=alarmid%>;
			var title = "";
		var url = "";
		title = "新建 Action Plan";
		url="/formmode/view/AddFormMode.jsp?mainid=0&modeId=1&formId=-2&type=1&field5827="+val+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 400;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");		
			
			
		}
		function onBtnApproveClick() {
			var val=<%=alarmid%>;
			var title = "";
		var url = "";
		<% 
		 int count=0;
		 sql="select count(1) from uf_action_plan where (is_send is null or is_send = '0') and alarmid = "+alarmid;
		 rs.execute(sql);
		 if(rs.next()){
			 count= rs.getInt(1);
		 }
		%>
		var cnt=<%=count%>
		if(!cnt>0){
			alert("请创建新的ActionpPlan")
			return false;
		}
		title = "Action Plan 审批流程";
		url="/workflow/request/AddRequest.jsp?workflowid=61&field6021="+val+"&field6031="+val+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		
		diag_vote.maxiumnable = true;
		diag_vote.DefaultMax= true;
		diag_vote.Width = 1000;
		diag_vote.Height = 800;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");		
			
			
		}

		function refersh() {
  			window.location.reload();
  		}

	</script>
</BODY>
</HTML>