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
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 100%;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		</style>
		<%
		 String action = Util.null2String((String)session.getAttribute("actionid"));
		 if("".equals(action)){
		 action =Util.null2String(request.getParameter("actionid1"));
		 }
		
		 String actionid1="";
		 String xdfa="";
		 String jzrq="";
		 String famb="";
		 String sjwc="";
		 String wcbl="";
		 String xdzt="";
		 String alarmid1="";
		 String is_done="";
		 boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
		 String sql="select alarmid,actionid ,xdfa,jzrq,famb,sjwc,wcbl,decode(xdzt,0,'未开始',1,'进行中',2,'已完成','未开始') as xdzt,is_done from uf_action_plan where id= '"+action+"'";
		 rs.execute(sql);
		 if(rs.next()){
		 actionid1 = Util.null2String(rs.getString("actionid"));
		 xdfa = Util.null2String(rs.getString("xdfa"));
		 jzrq = Util.null2String(rs.getString("jzrq"));
		 famb = Util.null2String(rs.getString("famb"));
		 sjwc = Util.null2String(rs.getString("sjwc"));
	 	 wcbl = Util.null2String(rs.getString("wcbl"));
		 xdzt = Util.null2String(rs.getString("xdzt"));
		  is_done = Util.null2String(rs.getString("is_done"));
		  alarmid1 = Util.null2String(rs.getString("alarmid"));
		 }
		%>
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					
					<td class="rightSearchSpan" style="text-align:right;">
						<%if(!"1".equals(is_done)){%>
						<input type="button" value="保存" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnSaveClick();"/>
						<%}%>
						<input type="button" value="返回" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;"  onclick="returnBack();"/>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
					
				</tr>
			</table>
			
			<% // 查询条件 %>
			
		</FORM>
		<%
		 
		String backfields = "";
														
		String fromSql  = " ";
		String sqlWhere = "";
		String orderby = " ";
		String tableString = "";
	
		%>
	<table class="ViewForm1  outertable" >
    <tbody>
        <tr>
            <td><br />
            <div align="center"><font class="reqname">Action Plan</font></div>
            <title></title>
			<FORM id=report1 name=report1 action="/alarm/xxx.jsp" method=post>
            <table class="ViewForm1  maintable">
				<input type="text" value="1" id="flag" name="flag" hidden="true">
                <colgroup>  <col width="25%"></col><col width="20%"></col> <col width="30%"></col><col width="25%"></col> </colgroup>
                <tbody>
                    <tr>
						<input  id="alarmid" type="text" value="<%=alarmid1%>" name="alarmid" hidden="ture"/>
						<input  id="action" type="text" value="<%=action%>" name="action" hidden="ture"/>
			
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;Action ID</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=actionid1%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;行动方案</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=xdfa%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;方案目标</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=famb%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;实际完成</td>
						<%if(!"1".equals(is_done)){%>
                        <td class="fvalue">&nbsp;&nbsp;<input  id="sjwc" type="text" value="<%=sjwc%>" name="sjwc" /></td>                                               
	                    <%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=sjwc%></td>         
						 <%}%>
						<td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;截止日期</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=jzrq%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;完成比率</td>
						<%if(!"1".equals(is_done)){%>
                        <td class="fvalue">&nbsp;&nbsp;<input  id="wcbl" type="text" value="<%=wcbl%>" name="wcbl"/></td>                                                  
	                    <%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=wcbl%></td>         
						 <%}%>                                             
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;行动状态</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=xdzt%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
</FORM>
	<script type="text/javascript">
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	    function returnBack(){
			var alarmid=<%=alarmid1%>;
			var url="/alarm/getActionPlanUrl.jsp?alarmid="+alarmid+"";
			window.open(url,"_parent");
		}

	</script>
</BODY>
</HTML>