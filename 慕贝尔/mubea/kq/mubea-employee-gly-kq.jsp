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
    String out_pageId = "kqdjbb_gly1";
	Calendar today = Calendar.getInstance();
	String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
	String yearmonth = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2);
	String lastmonth = "";
	String sql = "select  left(CONVERT(varchar(100),DATEADD( month, -1, '"+currentdate+"'), 23),7) as lastmonth";
	rs.executeSql(sql);
	if(rs.next()){
		lastmonth = Util.null2String(rs.getString("lastmonth"));
	}
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String cxry = Util.null2String(request.getParameter("cxry"));
	String lastupdateTime = "";
	sql="select * from  mubeaLink.AIS20130117115038.dbo.pro_lastexectime";
	rs.executeSql(sql);
	if(rs.next()){
		lastupdateTime = Util.null2String(rs.getString(1));
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
		//RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		    <input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<FORM id=report name=report action="/mubea/kq/mubea-employee-gly-kq.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
							<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
					<wea:item>查询日期</wea:item>
					<wea:item>
                    <button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
                        <SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN>
                        <INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON>
                        <SPAN id=endDateSpan><%=endDate%></SPAN>
                        <INPUT type="hidden" name="endDate" id="endDate" value="<%=endDate%>">
                	</wea:item>
				<wea:item>查询人员</wea:item>
                <wea:item>
					<brow:browser viewType="0"  name="cxry" browserValue="<%=cxry %>"
					browserOnClick=""
					browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					linkUrl='/hrm/resource/HrmResource.jsp?id=' 
					completeUrl="/data.jsp" width="165px"
					browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(cxry),user.getLanguage())%>">
					</brow:browser>
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
		String backfields = "c.fid,a.id,left(CONVERT(varchar(100),c.fattendday, 23),7) as month,CONVERT(varchar(100),c.fattendday, 23) as fattendday ,c.flateminute,c.flatetimes,c.fearlyminute,c.fearlytimes,c.FAbsentHour,c.FAbsentTimes, convert(varchar(16),e.fdutyfrom1,120) as fdutyfrom1,convert(varchar(16),e.fdutyto1,120) as fdutyto1 ,convert(varchar(16),e.fdutyfrom2,120) as fdutyfrom2 ,convert(varchar(16),e.fdutyto2,120) as fdutyto2,(select fname_en from  mubeaLink.AIS20130117115038.dbo.HR_ATS_HolidayType t where t.fid=fleavetype1) as fleavetype1,'"+lastupdateTime+"' as lastupdateTime  ";
		String fromSql  =  " from hrmresource a,mubeaLink.AIS20130117115038.dbo.hm_employees b,mubeaLink.AIS20130117115038.dbo.HR_ATS_EmpAttendTotal c, mubeaLink.AIS20130117115038.dbo.HM_EmployeesAddInfo d, mubeaLink.AIS20130117115038.dbo.HR_ATS_Emporiginalattend e,mubeaLink.AIS20130117115038.dbo.HR_ATS_Empcalcattend f";
		String sqlWhere =  " b.em_id=c.fempid and c.fempid=e.fempid and c.fattendday=e.fattendday and e.fempid=f.fempid and e.fattendday=f.fattendday and a.workcode=b.code and b.em_id=d.em_id and d.HRMS_Userfield_60 in('IDL - Normal Office','IDL - Shopfloor','DL - Shopfloor') and (c.flateminute>0  or c.fearlyminute>0   or c.FAbsentHour>0 ) and a.status <4 and CONVERT(varchar(100),c.fattendday, 23)<'"+currentdate+"'";	
	
			if("".equals(beginDate) && "".equals(endDate)){
				sqlWhere = sqlWhere+" and left(CONVERT(varchar(100),c.fattendday, 23),7) in('"+yearmonth+"')";
			}
			if(!"".equals(beginDate)){
				sqlWhere = sqlWhere+" and CONVERT(varchar(100),c.fattendday, 23) >='"+beginDate+"'";
			}
			if(!"".equals(endDate)){
				sqlWhere = sqlWhere+" and CONVERT(varchar(100),c.fattendday, 23) <='"+endDate+"'";
			}
			if(!"".equals(cxry)){
				sqlWhere = sqlWhere+" and a.id ='"+cxry+"'";
			}
		
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " c.fid desc "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\"  pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"c.fid\" sqlsortway=\"desc\" sqlisdistinct=\"c.fid\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"10%\" text=\"Employee\" column=\"id\" orderkey=\"id\" transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+ 
						"<col width=\"10%\" text=\"Attendence Date\" column=\"fattendday\" orderkey=\"fattendday\"  />"+
                		"<col width=\"9%\" text=\"Start Period 1\" column=\"fdutyfrom1\" orderkey=\"fdutyfrom1\" />"+ 
						"<col width=\"9%\" text=\"End Period 1\" column=\"fdutyto1\" orderkey=\"fdutyto1\" />"+ 
						"<col width=\"9%\" text=\"Start Period 2\" column=\"fdutyfrom2\" orderkey=\"fdutyfrom2\" />"+ 
						"<col width=\"9%\" text=\"End Period 2\" column=\"fdutyto2\" orderkey=\"fdutyto2\" />"+ 
						"<col width=\"8%\" text=\"Late Hours\" column=\"flateminute\" orderkey=\"flateminute\" />"+ 
						"<col width=\"10%\" text=\"Early Leave Hours\" column=\"fearlyminute\" orderkey=\"fearlyminute\" />"+                               
						"<col width=\"8%\" text=\"Absent Hours\" column=\"FAbsentHour\" orderkey=\"FAbsentHour\" />"+ 
						"<col width=\"8%\" text=\"Leave Type 1\" column=\"fleavetype1\" orderkey=\"fleavetype1\" />"+  
						"<col width=\"10%\" text=\"Data UpdateTime\" column=\"lastupdateTime\"  />"+                                                               
						
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
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>