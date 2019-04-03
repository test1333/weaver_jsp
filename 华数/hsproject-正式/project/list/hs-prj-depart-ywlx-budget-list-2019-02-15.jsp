<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="hsproject.util.BrowserInfoUtil"%>
<%@ page import="hsproject.util.ProjectUtil" %>
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
    String out_pageId = "bmys_yw01";
    String bm = Util.null2String(request.getParameter("bm"));
	String ywlx = Util.null2String(request.getParameter("ywlx"));
	String year = Util.null2String(request.getParameter("year"));
	String yearcs = Util.null2String(request.getParameter("yearcs"));
	String ywlx_val = "";
	String sql="select typename from uf_prj_businesstype where id="+ywlx;
	rs.executeSql(sql);
	if(rs.next()){
		ywlx_val = Util.null2String(rs.getString("typename"));
	}
	if("".equals(yearcs) && "".equals(year)){
	    Calendar today = Calendar.getInstance();
		yearcs=Util.add0(today.get(Calendar.YEAR), 4);
		year=Util.add0(today.get(Calendar.YEAR), 4);
	}
		ProjectUtil pu = new ProjectUtil();
	String departmentid = "";
	 sql = "select departmentid from hrmresource where id="+userid;
    rs.executeSql(sql);
    if(rs.next()){
    	departmentid = Util.null2String(rs.getString("departmentid"));
	}
	String supdp = pu.getSupperDepartmentId(departmentid);
	String cansee ="-1";
	if("804".equals(departmentid) || "804".equals(supdp)){
		cansee = "1";
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
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/hsproject/project/list/hs-prj-depart-ywlx-budget-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="yearcs" value="<%=yearcs%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="导出" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="_xtable_getAllExcel();"/>
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				 <wea:item>年份</wea:item>
					<wea:item>
	                    <brow:browser name='year'
									viewType='0'
									browserValue='<%=year%>'
									isMustInput='1'
									browserSpanValue='<%=year%>'
									hasInput='true'
									linkUrl='' 
									completeUrl='/data.jsp?type=178'
									width='60%'
									isSingle='true'
									hasAdd='false'
									browserUrl='/systeminfo/BrowserMain.jsp?url=/workflow/field/Workflow_FieldYearBrowser.jsp?resourceids=#id#'>
						</brow:browser>
                    </wea:item>
					<wea:item>部门</wea:item>
					<wea:item>
	                    <brow:browser name='bm'
									viewType='0'
									browserValue='<%=bm%>'
									isMustInput='1'
									browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(bm),user.getLanguage())%>'
									hasInput='true'
									linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id=' 
									completeUrl='/data.jsp?type=4'
									width='60%'
									isSingle='true'
									hasAdd='false'
									browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
						</brow:browser>
                    </wea:item>
	                <wea:item>业务类型</wea:item>    
	                <wea:item>
		                <brow:browser viewType="0"  name="ywlx" browserValue="<%=ywlx%>"
			                browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.hs_prj_businesstype"
			              	hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
			                 width="60%"
			                linkUrl=""
			                browserSpanValue="<%=ywlx_val %>">
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
		String backfields = "rownum,id,year,department,(select typename from uf_prj_businesstype where id=a.businesstype) as businesstype,nvl(budget,0) as budget,nvl(amount,0) as amount,case when nvl(budget,0) =0 then 0 else round(nvl(amount,0)/budget,2)*100 end||'%' as fsl";
		String fromSql  =  " from (select * from uf_prj_depbudget order by department asc,id desc) a";
		String sqlWhere =  " 1=1  ";
		if(userid !=1 && "-1".equals(cansee)){
			sqlWhere = sqlWhere + " and department in (select department from uf_prj_departperson where general='"+userid+"')";
		}
		if(!"".equals(bm)){
			sqlWhere = sqlWhere + " and department='"+bm+"' ";
		}

		if(!"".equals(year)){
			sqlWhere = sqlWhere + " and year='"+year+"' ";
		}
		if(!"".equals(ywlx)){
			sqlWhere = sqlWhere + " and businesstype='"+ywlx+"' ";
		}
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " rownum asc "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" sumColumns=\"budget,amount\" showCountColumn=\"true\" decimalFormat=\"%,.2f|%,.2f\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"6%\" text=\"序号\" column=\"rownum\" orderkey=\"rownum\" />"+
						"<col width=\"15%\" text=\"年份\" column=\"year\" orderkey=\"year\" />"+ 
						"<col width=\"15%\" text=\"部门\" column=\"department\" orderkey=\"department\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
                		"<col width=\"15%\" text=\"业务类型\" column=\"businesstype\" orderkey=\"businesstype\" />"+ 
                		"<col width=\"15%\" text=\"预算总额\" column=\"budget\" orderkey=\"budget\" />"+ 
                		"<col width=\"15%\" text=\"实际发生额\" column=\"amount\" orderkey=\"amount\" />"+       
						"<col width=\"15%\" text=\"发生率\" column=\"fsl\" orderkey=\"fsl\" />"+                         
						"</head>"+
		 "</table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false" />
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