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
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />


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
    String out_pageId = "wwpr002";
    String rqid = Util.null2String(request.getParameter("rqid"));
	String currentrqid = Util.null2String(request.getParameter("currentrqid"));
	if("".equals(currentrqid)){
		currentrqid = "-1";
	}
	String tablename = "formtable_main_156";
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
		RCMenu += "{提交,javascript:save(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/zx/purchase/show-wwpr-detail-info.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="提交" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="save()"/>
				<!--<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>-->
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
	
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				
			</div>
		</FORM>
		<%
		String backfields = "b.id,a.sqr,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='xmlb' and c.selectvalue=xmlb) as xmlb,wlbh,wlms,mbsl,jj,jgdw,sl,bhsje,wlz,convert(varchar(20),b.id)+'_'+'"+currentrqid+"' as checkid";
		String fromSql  =  " from "+tablename+" a,"+tablename+"_dt1 b";
		String sqlWhere =  " a.id=b.mainid and a.requestid='"+rqid+"'";
	
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " b.id "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\"  >"+         
				   " <checkboxpopedom  id=\"checkbox\" popedompara=\"column:checkid\" showmethod=\"zx.purchase.CheckPRDetail.getCanCheckForWw\" />"+
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"   />"+
		operateString+
		"			<head>";
				tableString +=
						"<col width=\"7%\" text=\"申请人\" column=\"sqr\" orderkey=\"sqr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+ 
						"<col width=\"10%\" text=\"项目类别\" column=\"xmlb\" orderkey=\"xmlb\"  />"+
						"<col width=\"8%\" text=\"物料编码\" column=\"wlbh\" orderkey=\"wlbh\" />"+ 
						"<col width=\"21%\" text=\"物料描述\" column=\"wlms\" orderkey=\"wlms\"  />"+
            "<col width=\"8%\" text=\"目标数量\" column=\"mbsl\" orderkey=\"mbsl\" />"+ 
            "<col width=\"8%\" text=\"净价\" column=\"jj\" orderkey=\"jj\" />"+ 			
						"<col width=\"8%\" text=\"不含税金额\" column=\"bhsje\" orderkey=\"bhsje\" />"+ 
							"<col width=\"6%\" text=\"税率\" column=\"sl\" orderkey=\"sl\" />"+     
						"<col width=\"8%\" text=\"物料组\" column=\"wlz\" orderkey=\"wlz\" />"+   
					   
						
						"</head>"+
		 "</table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		function save(){
			var checkids = _xtable_CheckedCheckboxId();
			if(checkids==null || checkids==""){
			  alert("请先选择行项目再提交");
			  return;
			}
			if(checkids.match(/,$/)){
				checkids = checkids.substring(0,checkids.length-1);
			}
			var parentWin = window.parent;
        	parentWin.MainCallback1(checkids);

		}
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>