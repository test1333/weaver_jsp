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
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "gbiyq_2";
	String jkr = Util.null2String(request.getParameter("jkr"));
	String bz = Util.null2String(request.getParameter("bz"));
	String pernr_f = Util.null2String(request.getParameter("pernr_f"));

	String ly = Util.null2String(request.getParameter("ly"));
	String jklcdh = Util.null2String(request.getParameter("jklcdh"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String beginDate2 = Util.null2String(request.getParameter("beginDate2"));
	String endDate2 = Util.null2String(request.getParameter("endDate2"));

	String jkrname=ResourceComInfo.getResourcename(jkr);
	String department = Util.null2String(request.getParameter("department"));
	String departmentStr = "";
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
	String flag="";
	while(rs.next()){
	       departmentStr =departmentStr+""+flag;
	       text = Util.null2String(rs.getString("departmentname"));
		  departmentStr +=text;
		  flag = ",";
	   }
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
	    <input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		//RCMenu += "{刷新,javascript:refersh(),_self} " ;
		//RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/seahonor/expenses/gr-borrow-info-yq.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="jkr" value="<%=jkr%>">
			<input type="hidden" name="bz" value="<%=bz%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
				
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
			<wea:layout type="4col">
				<wea:group context="查询条件">
			    <wea:item>流程单号</wea:item>
				<wea:item>
				 <input name="jklcdh" id="jklcdh" class="InputStyle" type="text" value="<%=jklcdh%>"/>
				</wea:item>
				<wea:item>来源</wea:item>
				<wea:item>
				 <input name="ly" id="ly" class="InputStyle" type="text" value="<%=ly%>"/>
				</wea:item>
				
		
				 <wea:item>出纳付款日期</wea:item>
				<wea:item>
					<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
						<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
						<INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">  
					&nbsp;-&nbsp;
					<button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
						<SPAN id=endDateSpan><%=endDate%></SPAN> 
						<INPUT type="hidden" name="endDate"  id="endDate"  value="<%=endDate%>">  
				</wea:item>
			  <wea:item>借款到期日</wea:item>
				<wea:item>
					<button type="button" class=Calendar id="selectBeginDate2" onclick="onshowPlanDate('beginDate2','selectBeginDateSpan2')"></BUTTON> 
						<SPAN id=selectBeginDateSpan2 ><%=beginDate2%></SPAN> 
						<INPUT type="hidden" name="beginDate2" id="beginDate2" value="<%=beginDate2%>">  
					&nbsp;-&nbsp;
					<button type="button" class=Calendar id="selectEndDate2" onclick="onshowPlanDate('endDate2','endDateSpan2')"></BUTTON> 
						<SPAN id=endDateSpan2><%=endDate2%></SPAN> 
						<INPUT type="hidden" name="endDate2"  id="endDate2"  value="<%=endDate2%>">  
				</wea:item>
				
				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		</FORM>
		<%
		String backfields = "id,jkr,hkfs,ly,hkfsspan,bzspan,bz,lx,jkje,jkrq,jkdqr,sfyq,sfyqspan,yqtsspan,yqts,jklc,hklc,requestname,pzhm,jkye";							         
		String fromSql  = " v_gr_borrow t";
		String sqlWhere = " where 1=1  and jkr='"+jkr+"' and bz='"+bz+"' and ISNULL(t.jkye,0)>0 and sfyq='0' and lx='借款'";
		String orderby = " jkrq asc";
		String tableString = "";
		if(!"".equals(ly)){
			sqlWhere+=" and ly='"+ly+"'";
		}
		if(!"".equals(jklcdh)){
			sqlWhere+=" and upper(jklcdh) like upper('%"+jklcdh+"%')";
		}
	
	 	if(!"".equals(beginDate)){
				sqlWhere +=  " and jkrq >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere +=  " and jkrq <='"+endDate+"'";
		}
		if(!"".equals(beginDate2)){
				sqlWhere +=  " and jkdqr >='"+beginDate2+"'";
		}
		if(!"".equals(endDate2)){
			sqlWhere +=  " and jkdqr <='"+endDate2+"'";
		}
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" sumColumns=\"jkye\" showCountColumn=\"true\" decimalFormat=\"%,.2f\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"金额\" column=\"jkye\" transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"来源\" column=\"ly\"  />"+
			"               <col width=\"10%\" text=\"出纳付款日期\" column=\"jkrq\"   />"+
			"               <col width=\"10%\" text=\"借款到期日期\" column=\"jkdqr\" />"+
			"               <col width=\"10%\" text=\"逾期天数\" column=\"yqtsspan\"  />"+
			"               <col width=\"10%\" text=\"凭证号码\" column=\"pzhm\"  />"+
			"               <col width=\"30%\" text=\"流程单号\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"jklc\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
				
			
		"			</head>"+
	" </table>";
	%>
	<br/>
	<%
	 if("".equals(bz)||"0".equals(bz)){
	%>
	<h3 align="center"><%=jkrname%>人民币逾期借款余额明细表</h3>
	<%
	}else{
	%>
	<h3 align="center"><%=jkrname%>外币逾期借款余额明细表</h3>
	<%	
	}
	%>
	<br/>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		
	
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>