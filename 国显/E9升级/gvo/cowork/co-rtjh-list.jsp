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
<jsp:useBean id="CoworkService" class="weaver.cowork.CoworkService" scope="page" />
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
    String out_pageId = "rtjhlist";
	String zt = Util.null2String(request.getParameter("zt"));
	String searchnr = Util.null2String(request.getParameter("searchnr"));
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
		<FORM id=report name=report action="/gvo/cowork/co-rtjh-list.jsp" method=post>
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
				<wea:item>主题</wea:item>
				<wea:item>
             		<input name="zt" id="zt" class="InputStyle" type="text" value="<%=zt%>"/>
  				</wea:item>
				<wea:item>内容</wea:item>
				<wea:item>
             		<input name="searchnr" id="searchnr" class="InputStyle" type="text" value="<%=searchnr%>"/>
  				</wea:item>

				<wea:item>发布时间</wea:item>
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
		String backfields = "t.id,dis.id as dis,case when dis.topdiscussid = 0 then dis.id else dis.topdiscussid end as topdiscussid,dis.createdate||' '||substr(dis.createtime,0,5) as cjsj,(select COWORKID||'/'||FLOORNUM as linkvalue from COWORK_DISCUSS where id=cre.discussID) as linkvalue";
		String fromSql  =  " from ( select t1.id,t1.name,t1.status,t1.typeid,t1.creater,t1.principal,t1.begindate,t1.enddate,t1.replyNum,t1.readNum,t1.lastdiscussant,t1.lastupdatedate,t1.lastupdatetime,t1.isApproval,t1.approvalAtatus,t1.isTop  from cowork_items t1 ) t,cowork_discuss dis,cowork_cream cre";
		fromSql = fromSql.replaceAll("<", "&lt;");
		String sqlWhere =  " 1 = 1 and t.id=dis.coworkid and dis.id=cre.discussID and cre.status='0' and (t.approvalAtatus=0 or (t.approvalAtatus=1 and (creater="+userid+" or principal="+userid+" )))  ";
		if(!"".equals(beginDate)){
			sqlWhere += " and dis.createdate >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere += " and dis.createdate <='"+endDate+"'";
		}

		if(!"".equals(zt)){
			sqlWhere += " and t.name like '%"+zt+"%'";
		}
		if(!"".equals(searchnr)){
			sqlWhere += " and regexp_replace(dis.remark,'</?[^>]*>|nbsp;|&','') like '%"+searchnr+"%'";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "cre.id desc "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"80%\" text=\"主题\" column=\"topdiscussid\" orderkey=\"topdiscussid\" transmethod='gvo.cowork.PortalTransUtil.getJhTitle' href=\"javascript:ViewCoworkDiscuss('{0}')\" linkkey=\"id\" linkvaluecolumn=\"linkvalue\"/>"+ 
							"<col width=\"20%\" text=\"发布日期\" column=\"cjsj\" orderkey=\"cjsj\"  />"+ 		
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
		function getCoworkDialog(title,width,height){
            diag =new window.top.Dialog();
            diag.currentWindow = window; 
            diag.Modal = true;
            diag.Drag=true;
            diag.Width =width?width:680;
            diag.Height =height?height:420;
            diag.ShowButtonRow=false;
            diag.Title = title;
           // diag.Left=($(window.top).width()-235-width)/2+235;
            return diag;
}
	function ViewCoworkDiscuss(id){
        diag=getCoworkDialog("楼层信息",700,525);
        diag.URL = "/spa/cowork/static/index.html#/cowork/"+id;
        diag.show();
    }
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>