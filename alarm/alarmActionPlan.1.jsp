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
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	 String alarmid = (String)session.getAttribute("alarmid");
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String zuzhidanwei="";
	String duration="";
	String kfcode="";
	String namedesc="";
	String approvestatus="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String sql="select  getTextValue('AREAL',"+language+",area)||getTextValue('PROVINCE',"+language+",province)||getTextValue('BUSINESS',"+language+",sales_grp) as zuzhidanwei,duration,kfcode,getTextValue('KPI',"+language+",kfcode) as namedesc,approvestatus from uf_alarm_info where alarm_id= "+alarmid;
	rs.execute(sql);
	if(rs.next()){
	   zuzhidanwei =  Util.null2String(rs.getString("zuzhidanwei"));
	   duration =  Util.null2String(rs.getString("duration"));
	   kfcode =  Util.null2String(rs.getString("kfcode"));
	   namedesc =  Util.null2String(rs.getString("namedesc"));
	   approvestatus=  Util.null2String(rs.getString("approvestatus"));
	}
	//判断操作
	 sql="select is_approve,is_send from uf_action_plan where rownum=1 and alarmid='"+alarmid+"'";

		 String is_approve1 ="";
		 String is_send1="";
		 String caozuo="0";
		 String queren="0";
		  rs.execute(sql);
		  if(rs.next()){
		  is_approve1 =  Util.null2String(rs.getString("is_approve"));
		  is_send1 =  Util.null2String(rs.getString("is_send"));
		  }
		  
		  sql="select requestid from formtable_main_13 where id=(select max(id) from formtable_main_13 where alarmid='"+alarmid+"')";
	      int requestid1=0;
		  rs.execute(sql);
		  if(rs.next()){
		  requestid1 = rs.getInt(1);
		  }
		   sql="select is_approve from uf_alarm_info where alarm_id='"+alarmid+"'";
	      String is_approve_alarm="";
		  rs.execute(sql);
		  if(rs.next()){
		  is_approve_alarm = Util.null2String(rs.getString("is_approve"));
		  }
		  int approve1=0;
		  if("1".equals(is_approve_alarm)){
		  approve1=1;
		  }
		  if(requestid1!=0){
		  caozuo = "1";		
		  }
		  if("3".equals(approvestatus)){
		  caozuo = "3";
		  }
		  if("1".equals(is_approve1)){
		  caozuo = "2";
		  }
		   if("2".equals(is_approve1)){
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
						<%if(requestid1==0){%>
						<input type="button" value="新建Action" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnNewClick();"/>
				<%}%>
				<%if(approve1!=1){%>
					
					<input type="button" value="提交审批" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnApproveClick();"/>				
				
				<%}%>
				<input type="button" value="返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="returnBack();"/>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
					
				</tr>
			</table>
			
			<% // 查询条件 %>
			
		</FORM>
		<table style="width:100%;">
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:35%;font-size: 10pt;height:25px;">组织单位： <%=zuzhidanwei%></td>
			<td></td>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;">时间区间： <%=duration%></td>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:35%;font-size: 10pt;height:25px;">行动指标： <%=kfcode%> <%=namedesc%></td>
			<td></td>
			<%if("3".equals(caozuo)){%>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;"><a href="javascript:viewApprove();" style="color:blue;text-decoration:underline;">审批退回方案调整</a></td>
		    <%}else{%>
			<td   style="text-align:left; width:25%;font-size: 10pt;height:25px;"><a href="javascript:viewApprove();" style="color:blue;text-decoration:underline;">审批意见查询</a></td>
			<%}%>
		</tr>
		<tr style="width:100%;">
			<td style=" width:1%"></td>
			<td  style="text-align:left; width:35%;font-size: 10pt;height:25px;">Alarm ID: <%=alarmid%></td>
			<td></td>
			
		</tr>
		
		</table>
		<%
		
		String backfields = "id as idkey ,actionid,xdfa,famb,sjwc,jzrq,wcbl,decode(xdzt,0,'未开始',1,'进行中',2,'已完成','未开始') as xdzt,decode(is_done,'1','查看',decode('"+caozuo+"','1','审批中','2','进展维护','3','被审批退回','')) as xianshi";
		String fromSql  = " uf_action_plan ";
		String sqlWhere = " where 1=1 ";
		String orderby = " id asc";
		String tableString = "";
		sqlWhere +=" and alarmid ="+alarmid;
		String  operateString= "";
		if("2".equals(caozuo)){
			operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:editplan();\" linkkey=\"actionid\" linkvaluecolumn=\"idkey\" text=\"编辑\" index=\"1\"/> "+
		                    "</operates>";
        }else if("0".equals(caozuo)){ 
		operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                     "     <operate isalwaysshow=\"true\" href=\"javascript:edit();\" linkkey=\"billid\" linkvaluecolumn=\"idkey\" text=\"编辑\" index=\"1\"/> "+
							"     <operate isalwaysshow=\"true\" href=\"javascript:deleteplan();\" linkkey=\"actionid\" linkvaluecolumn=\"idkey\" text=\"删除\" index=\"2\"/> "+
							
		                    "</operates>";
		}
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			
			tableString+= " <col width=\"10%\" text=\"Action ID\" column=\"actionid\" orderkey=\"actionid\" />"+
		 "  <col width=\"20%\" text=\"行动方案\" column=\"xdfa\" orderkey=\"xdfa\"/>"+
			"               <col width=\"15%\" text=\"方案目标\" column=\"famb\" orderkey=\"famb\"/>"+
			"               <col width=\"15%\" text=\"实际完成\" column=\"sjwc\" orderkey=\"sjwc\"/>"+
			"               <col width=\"10%\" text=\"截止日期\" column=\"jzrq\" orderkey=\"jzrq\"/>"+
			"               <col width=\"10%\" text=\"完成比率\" column=\"wcbl\" orderkey=\"wcbl\"/>"+
			"               <col width=\"10%\" text=\"行动状态\" column=\"xdzt\" orderkey=\"xdzt\"/>";	
			if("0".equals(caozuo)){
			tableString+="               <col width=\"10%\" text=\"操作\" column=\"xianshi\" orderkey=\"xianshi\"  />";			
			}else if("1".equals(caozuo)){
			tableString+="               <col width=\"10%\" text=\"操作\"  column=\"xianshi\" orderkey=\"xianshi\"  />";			
			}else if("3".equals(caozuo)){
			tableString+="               <col width=\"10%\" text=\"操作\"  column=\"xianshi\" orderkey=\"xianshi\" />";			
			}else if("2".equals(caozuo)){
			tableString+="               <col width=\"10%\" text=\"操作\"  column=\"xianshi\" orderkey=\"xianshi\" linkkey=\"actionid\" linkvaluecolumn=\"idkey\"  href=\"/alarm/getSubActionPlanUrl.jsp\" target=\"_parent\" />";			
			}
		tableString+="			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
     var diag_vote;

	  function closeDialog(){
	    diag_vote.close();
      }

      function closeDlgARfsh(){
	   _table.reLoad();
	   diag_vote.close();
       }
	  function refresh(){
		  	window.location.reload();
	  }
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
		diag_vote.Height = 500;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
	   }
	   function edit(billid) {
		
			var title = "";
		var url = "";
		title = "Action Plan";
		url="/formmode/view/AddFormMode.jsp?mainid=0&modeId=1&formId=-2&type=2&Id=41&billid="+billid+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 500;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
	   }
	   
		
		function onBtnApproveClick() {
			var val=<%=alarmid%>;
			var title = "";
		var url = "";
		<% 
		 int count=0;
		 sql="select count(1) from uf_action_plan where  alarmid = "+alarmid;
		 rs.execute(sql);
		 if(rs.next()){
			 count= rs.getInt(1);
		 }
		%>
		var aa=<%=requestid1%>;
		var cnt=<%=count%>
		if(!cnt>0){
			alert("请先创建ActionpPlan")
			return false;
		}
		title = "Action Plan 审批流程";
		if(!aa>0){
		url="/workflow/request/AddRequest.jsp?workflowid=61&field6021="+val+"&field6031="+val+"";
		}else{
	     url="/workflow/request/ViewRequest.jsp?requestid="+aa;
		}
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		
		diag_vote.maxiumnable = true;
		diag_vote.Width = 1000;
		diag_vote.Height = 800;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");		
		
		}
		function returnBack(){
			window.open("/alarm/getAlarmAllUrl.jsp","_parent");
			
		}
		function viewApprove(){
			var aa=<%=requestid1%>;
			var app=<%=approve1%>
			var title = "";
		var url = "";
		 if(!app>0){
			alert("请先提交审批")
		}else{
				title = "审批意见查询";
		url="/workflow/request/ViewRequest.jsp?requestid="+aa;
		
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		
		diag_vote.maxiumnable = true;
		diag_vote.Width = 1000;
		diag_vote.Height = 800;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
		}
		
		}
	
		function refersh() {
  			window.location.reload();
  		}
		  
	 function editplan(actionid){
		var title = "";
		var url = "";
		 
		title = "Action Plan";
		url="/alarm/editactionplan.jsp?actionid="+actionid;
		
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 650;
		diag_vote.Height = 500;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");

		 }
	function deleteplan(actionid){
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
		}
		if (null != xhr) {

	
		xhr.open("GET","/alarm/deleteactionplan.jsp?val="+actionid, false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
	 	 if (xhr.status == 200) {
	         window.location.reload();
	    }
	  }
	}
	xhr.send(null);
     }

		 }
 
	</script>
</BODY>
</HTML>