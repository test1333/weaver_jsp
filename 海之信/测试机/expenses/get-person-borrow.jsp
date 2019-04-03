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
    String out_pageId = "pb_2";
	String jkr = Util.null2String(request.getParameter("jkr"));
	String bz = Util.null2String(request.getParameter("bz"));
	
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
		<FORM id=report name=report action="/seahonor/expenses/get-person-borrow.jsp" method=post>
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
				
			</div>
		</FORM>
		<%
		String backfields = "id, (select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_personal_borrow' and a.fieldname= 'bz' and c.selectvalue=bz) as bz,"+
		"jkje,hkje,jkye,jkr,jkrq as jkrq,jkdqr as jkdqr,yqts,jksm,xglc,(select requestname from workflow_requestbase where requestid=xglc) as requestname";
							         
		String fromSql  = " uf_personal_borrow t";
		String sqlWhere = " where 1=1  and jkr='"+jkr+"' and bz='"+bz+"'";
		String orderby = " id asc";
		String tableString = "";
	 
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" sumColumns=\"jkje,hkje,jkye\" showCountColumn=\"true\" decimalFormat=\"%,.2f|%,.2f|%,.2f\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"币种\" column=\"bz\" orderkey=\"bz\" />"+
			"               <col width=\"10%\" text=\"借款金额\" column=\"jkje\" orderkey=\"jkje\"  transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"还款金额\" column=\"hkje\" orderkey=\"hkje\"  transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"借款余额\" column=\"jkye\" orderkey=\"jkye\"  transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"借款人\" column=\"jkr\" orderkey=\"jkr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
			"               <col width=\"10%\" text=\"借款日期\" column=\"jkrq\" orderkey=\"jkrq\"/>"+
			"               <col width=\"10%\" text=\"借款到期日\" column=\"jkdqr\" orderkey=\"jkdqr\"  />"+
			"               <col width=\"10%\" text=\"逾期天数\" column=\"yqts\" orderkey=\"yqts\" />"+
			"               <col width=\"20%\" text=\"借款说明\" column=\"jksm\" orderkey=\"jksm\"/>"+
			"               <col width=\"20%\" text=\"流程单号\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"xglc\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
				
			
		"			</head>"+
	" </table>";
	%>
	<br/>
	<%
	 if("".equals(bz)||"0".equals(bz)){
	%>
	<h3 align="center">借款人民币余额明细</h3>
	<%
	}else{
	%>
	<h3 align="center">借款外币余额明细</h3>
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