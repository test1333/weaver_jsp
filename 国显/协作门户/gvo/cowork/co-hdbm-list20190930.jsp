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
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="sharemanager" class="weaver.share.ShareManager" scope="page" />
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
    String out_pageId = "hdbmlist";
	String bt = Util.null2String(request.getParameter("bt"));
	String cjr = Util.null2String(request.getParameter("cjr"));
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
	    <!--<input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>-->
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/gvo/cowork/co-hdbm-list.jsp" method=post>
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
				<wea:item>标题</wea:item>
				<wea:item>
             		<input name="bt" id="bt" class="InputStyle" type="text" value="<%=bt%>"/>
  				</wea:item>
				<wea:item>创建人</wea:item>
				<wea:item>
                <brow:browser viewType="0"  name="cjr" browserValue="<%=cjr %>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(cjr),user.getLanguage())%>">
                </brow:browser>
                </wea:item>

				<wea:item>创建时间</wea:item>
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
		<TABLE width="100%">
		<tr>
		<td>
		<%
		String detailwhere = "";
		String tables = sharemanager.getShareListTableByUser("doc",user,"");
		String backfields = "t1.id,t3.hdbt,doccreatedate||' '||substr(doccreatetime,0,5) as createtime,doccreaterid ";
		String fromSql  =  " from DocDetail  t1,"+tables+"  t2,uf_co_hdbm_mt t3";
		fromSql = fromSql.replaceAll("<", "&lt;");
		String sqlWhere =  " t1.id=t3.wd and t3.sfyx='0' and t1.id = t2.sourceid and ( ( t1.docstatus = 7 and  (sharelevel>1 or (t1.doccreaterid="+userid+" or t1.ownerid="+userid+")) ) or t1.docstatus in ('1','2','5')  )   and  (isreply!=1 or isreply is null)  and seccategory!=0 and (ishistory is null or ishistory = 0) ";
		if(!"".equals(bt)){
			sqlWhere += " and t3.hdbt like '%"+bt+"%'";
		}
		if(!"".equals(cjr)){
			sqlWhere += " and t1.doccreaterid ='"+cjr+"'";
		}
		if(!"".equals(beginDate)){
			sqlWhere += " and t1.doccreatedate >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere += " and t1.doccreatedate <='"+endDate+"'";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "t3.xssx asc "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"60%\" text=\"标题\" column=\"hdbt\" orderkey=\"hdbt\"  linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/docs/docs/DocDsp.jsp\" target=\"_fullwindow\"/>"+ 
							"<col width=\"20%\" text=\"创建人\" column=\"doccreaterid\" orderkey=\"doccreaterid\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+ 
							"<col width=\"20%\" text=\"创建时间\" column=\"createtime\" orderkey=\"createtime\"  />"+ 		
					"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	</td>
		</tr>
		</TABLE>
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