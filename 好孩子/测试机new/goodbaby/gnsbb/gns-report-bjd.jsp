<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="goodbaby.pz.*"%>
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
    String out_pageId = "gnsreportbjd_1";
	String sql = "";
	
	String xjdh = Util.null2String(request.getParameter("xjdh"));
	String bjwlxx = Util.null2String(request.getParameter("bjwlxx"));
	String gysbh = Util.null2String(request.getParameter("gysbh"));
	String gysmc = Util.null2String(request.getParameter("gysmc"));

	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));

	GetGNSTableName gg = new GetGNSTableName();
	String lrktablename = gg.getTableName("RKD");
	String cgdtablename = gg.getTableName("CGDD");
	String cgsqtablename = gg.getTableName("CGSQ");
	String thdtablename = gg.getTableName("THD");
	//out.print("begindate"+begindate+" enddate"+enddate);

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
	
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		//RCMenu += "{导出凭证,javascript:createpz(),_self} " ;
		RCMenu += "{导出Excel,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/gnsbb/gns-report-bjd.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>询价单号</wea:item>
				<wea:item>
                 <input name="xjdh" id="xjdh" class="InputStyle" type="text" value="<%=xjdh%>"/>
        </wea:item>
				<wea:item>报价物料信息</wea:item>
				<wea:item>
                 <input name="bjwlxx" id="bjwlxx" class="InputStyle" type="text" value="<%=bjwlxx%>"/>
        </wea:item>
				<wea:item>供应商编号</wea:item>
				<wea:item>
                 <input name="gysbh" id="gysbh" class="InputStyle" type="text" value="<%=gysbh%>"/>
        </wea:item>
				<wea:item>供应商名称</wea:item>
				<wea:item>
                 <input name="gysmc" id="gysmc" class="InputStyle" type="text" value="<%=gysmc%>"/>
        </wea:item>
				<wea:item>报价日期</wea:item>
        <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
                        <SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN>
                        <INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON>
                        <SPAN id=endDateSpan><%=endDate%></SPAN>
                        <INPUT type="hidden" name="endDate" id="endDate" value="<%=endDate%>">
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
		String backfields = "a.requestid,XJDH,aid,case when b.currentnodetype=3 then '审批完成' when b.currentnodetype=0 then '发起' else '审批中' end as zt,XJRQ,WLMS,(select portalloginid from crm_customerinfo where id=GYSBM1) as gysbm,(select name from crm_customerinfo where id=GYSBM1) as gysmc,MRBJSJ,HJJE,case when b.currentnodetype=3 then b.lastoperatedate  else '' end as bjrq";
		String fromSql  =  " from formtable_main_227 a,workflow_requestbase b ";
		String sqlWhere =  " a.requestid=b.requestid ";
		if(!"".equals(xjdh)){
			sqlWhere +=" and xjdh like '%"+xjdh+"%' ";
		}
			if(!"".equals(bjwlxx)){
			sqlWhere +=" and WLMS like '%"+bjwlxx+"%' ";
		}
			if(!"".equals(gysbh)){
			sqlWhere +=" and (select portalloginid from crm_customerinfo where id=GYSBM1) like '%"+gysbh+"%' ";
		}
			if(!"".equals(gysmc)){
			sqlWhere +=" and (select name from crm_customerinfo where id=GYSBM1) like '%"+gysmc+"%' ";
		}
		if(!"".equals(beginDate)){
			sqlWhere +=" and case when b.currentnodetype=3 then b.lastoperatedate  else '' end  >='"+beginDate+"' ";
		}
		if(!"".equals(endDate)){
			sqlWhere +=" and case when b.currentnodetype=3 then b.lastoperatedate  else '' end  <='"+endDate+"' ";
		}

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "a.requestid "  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"10%\" text=\"询价单号\" column=\"XJDH\" orderkey=\"XJDH\"  linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\"/>"+ 
		"<col width=\"10%\" text=\"询价状态\" column=\"zt\" orderkey=\"zt\"  />"+ 
		"<col width=\"10%\" text=\"询价日期\" column=\"XJRQ\" orderkey=\"XJRQ\"  />"+ 
		"<col width=\"10%\" text=\"报价物料信息\" column=\"WLMS\" orderkey=\"WLMS\"  />"+ 
		"<col width=\"10%\" text=\"供应商编号\" column=\"gysbm\" orderkey=\"gysbm\"  />"+ 
		"<col width=\"10%\" text=\"供应商名称\" column=\"gysmc\" orderkey=\"gysmc\"  />"+ 
		"<col width=\"10%\" text=\"报价日期\" column=\"bjrq\" orderkey=\"bjrq\"  />"+ 
		"<col width=\"10%\" text=\"报价总额\" column=\"HJJE\" orderkey=\"HJJE\"  />"+ 
						"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>

			<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false"/>

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