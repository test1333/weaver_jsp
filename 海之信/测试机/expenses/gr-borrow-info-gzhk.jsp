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
    String out_pageId = "gzhkxx_2";
	String jkr = Util.null2String(request.getParameter("jkr"));
	String bz = Util.null2String(request.getParameter("bz"));
	String lx = Util.null2String(request.getParameter("lx"));
	String hklx = Util.null2String(request.getParameter("hklx"));
	String sfyq = Util.null2String(request.getParameter("sfyq"));
	String jkrname=ResourceComInfo.getResourcename(jkr);
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
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
		<FORM id=report name=report action="/seahonor/expenses/gr-borrow-info-gzhk.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="jkr" value="<%=jkr%>">
			<input type="hidden" name="bz" value="<%=bz%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td><td></td>
				
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
			
			</div>
		</FORM>
		<%
		String backfields = "id,jkr,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id and b.tablename='uf_personal_borrow' and a.fieldname= 'bz' and c.selectvalue=bz) as bzspan,bz,'借款' as lx,isnull(jkje,0) as jkje,isnull(hkje,0) as hkje,isnull(jkye,0) as jkye,jkrq as jkrq,jkdqr as jkdqr,sfyq,case when sfyq='0' then '是' else '否' end as sfyqspan,case when yqts ='' then null when yqts is not null then yqts+'天'  else null end  as yqts,jksm,xglc,(select requestname from workflow_requestbase where requestid=xglc) as requestname";							         
		String fromSql  = " uf_personal_borrow t";
		String sqlWhere = " where 1=1  and jkr='"+jkr+"' and bz='"+bz+"' and ISNULL(t.jkye,0)>0 ";
		String orderby = " jkrq asc";
		String tableString = "";

		
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" sumColumns=\"jkje,hkje,jkye\" showCountColumn=\"true\" decimalFormat=\"%,.2f|%,.2f|%,.2f\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"10%\" text=\"借款/还款币种\" column=\"bzspan\"  />"+
			
			"               <col width=\"10%\" text=\"借款金额\" column=\"jkje\" transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"还款金额\" column=\"hkje\" transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"借款余额\" column=\"jkye\" transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" />"+
			"               <col width=\"10%\" text=\"类型\" column=\"lx\"  />"+
			"               <col width=\"10%\" text=\"出纳收/付款日期\" column=\"jkrq\"   />"+
			"               <col width=\"10%\" text=\"借款到期日期\" column=\"jkdqr\" />"+
			"               <col width=\"10%\" text=\"逾期天数\" column=\"yqts\"  />"+
			"               <col width=\"10%\" text=\"借款说明\" column=\"jksm\"  />"+
			"               <col width=\"20%\" text=\"流程单号\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"xglc\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+
				
			
		"			</head>"+
	" </table>";
	%>
	<br/>
	<%
	 if("".equals(bz)||"0".equals(bz)){
	%>
	<h3 align="center"><%=jkrname%>人民币借款余额明细表</h3>
	<%
	}else{
	%>
	<h3 align="center"><%=jkrname%>外币借款余额明细表</h3>
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