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
    String out_pageId = "pbi1";
	String bz = Util.null2String(request.getParameter("bz"));
	String pernr_f = Util.null2String(request.getParameter("pernr_f"));
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
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/seahonor/expenses/person-borrow-info.jsp" method=post>
			<input type="hidden" name="requestid" value="">
				<input type="hidden" name="bz" id="bz" value="<%=bz%>">
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
			  
				<wea:item>姓名</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="pernr_f" browserValue="<%=pernr_f %>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(pernr_f),user.getLanguage())%>">
                </brow:browser>
                </wea:item>
				<wea:item>部门</wea:item>
				<wea:item>
                    <brow:browser viewType="0" name="department" browserValue='<%=department %>'
                    browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
                    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                    completeUrl="/data.jsp?type=4"
                    browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
                </wea:item>
				<wea:item>币种</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="bz" id="bz"> 
				<option value="" <%if("".equals(bz)){%> selected<%} %>>
					<%=""%></option>
				<option value="0" <%if("0".equals(bz)){%> selected<%} %>>
					<%="人民币"%></option>
				<option value="1" <%if("1".equals(bz)){%> selected<%} %>>
					<%="欧元"%></option>
				<option value="2" <%if("2".equals(bz)){%> selected<%} %>>
					<%="美元"%></option>
				<option value="3" <%if("3".equals(bz)){%> selected<%} %>>
					<%="日元"%></option>
				<option value="4" <%if("4".equals(bz)){%> selected<%} %>>
					<%="港币"%></option>
				</select>
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
		String backfields = "convert(varchar(20),jkr)+'_'+convert(varchar(20),bz) as keyid,jkr,max(departmentid) as departmentid,bz as bzid,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id and b.tablename='uf_personal_borrow' and a.fieldname= 'bz' and c.selectvalue=bz) as bz,SUM(ISNULL(jkye,0)) as jkye,SUM(ISNULL(yqje,0)) as yqje ";                 
		String fromSql  = " (select t.id,t.bz,t.jkye,isnull((select jkye from uf_personal_borrow where sfyq='0' and id=t.id),0) as yqje,t.jkr,(select departmentid from hrmresource where id=t.jkr) as departmentid from uf_personal_borrow t where ISNULL(t.jkye,0)>0 ) a ";
		String sqlWhere = " where 1=1 ";
		String orderby = " keyid asc ";
		String tableString = "";
		if(!"".equals(pernr_f)){
			sqlWhere +=" and jkr='"+pernr_f+"'";
		}
		  if(!"".equals(department)){
		sqlWhere+=" and departmentid in("+department+") ";
		}
		if(!"".equals(bz)){
			sqlWhere +=" and bzid='"+bz+"'";
		}
		sqlWhere+=" group by jkr,bz";
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         	  
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"jkr\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"30%\" text=\"借款人\" column=\"jkr\" otherpara=\"column:jkr\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
			"               <col width=\"20%\" text=\"部门\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
			"               <col width=\"10%\" text=\"借款币种\" column=\"bz\"/>"+
			"               <col width=\"10%\" text=\"借款余额\" column=\"jkye\" transmethod=\"seahonor.action.expenses.TransMethod.getTransNum\" linkkey=\"keyid\" linkvaluecolumn=\"keyid\"  href=\"/seahonor/expenses/gr-borrow-info-Url.jsp\"/>"+
			
		"			</head>"+
	" </table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		function showInfo(jkr,bz) {

		var title = "";
		var url = "/seahonor/expenses/gr-borrow-info-Url.jsp?jkr="+jkr+"&bz="+bz;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
	
		diag_vote.show();
		
}   
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>