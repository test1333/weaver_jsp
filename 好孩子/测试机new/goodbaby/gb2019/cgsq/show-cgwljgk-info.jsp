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
  String out_pageId = "showcgwljgk1";
  String wllx = Util.null2String(request.getParameter("wllx"));
	String wlids = Util.null2String(request.getParameter("wlids"));
	String wlbm = Util.null2String(request.getParameter("wlbm"));
	String wlms = Util.null2String(request.getParameter("wlms"));
	String pp = Util.null2String(request.getParameter("pp"));
	String xh = Util.null2String(request.getParameter("xh"));
	String gg = Util.null2String(request.getParameter("gg"));
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
		<FORM id=report name=report action="/goodbaby/gb2019/cgsq/show-cgwljgk-info.jsp" method=post>
			<input type="hidden" name="wllx" value="<%=wllx%>">
				<input type="hidden" name="wlids" value="<%=wlids%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="提交" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="save()"/>
				<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
	
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
					<wea:layout type="4col">
				<wea:group context="查询条件">
			
				<wea:item>物料编码</wea:item>
				<wea:item>
                 <input name="wlbm" id="wlbm" class="InputStyle" type="text" value="<%=wlbm%>"/>
        </wea:item>
		<wea:item>物料描述</wea:item>
				<wea:item>
                 <input name="wlms" id="wlms" class="InputStyle" type="text" value="<%=wlms%>"/>
        </wea:item>
		<wea:item>品牌</wea:item>
				<wea:item>
                 <input name="pp" id="pp" class="InputStyle" type="text" value="<%=pp%>"/>
        </wea:item>
		<wea:item>型号</wea:item>
				<wea:item>
                 <input name="xh" id="xh" class="InputStyle" type="text" value="<%=xh%>"/>
        </wea:item>
		<wea:item>规格</wea:item>
				<wea:item>
                 <input name="gg" id="gg" class="InputStyle" type="text" value="<%=gg%>"/>
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
		String backfields = "id,WLBM,WLMC,PP,GG,XH,(select gysmc from uf_suppmessForm where id=a.gysmc) as GYSMC,YGDJ";
		String fromSql  =  " from uf_inquiryForm a";
		String sqlWhere =  " id in(select id from [dbo].[CGSQJGK]) and wllx1='"+wllx+"' ";
		if(!"".equals(wlids)){
			sqlWhere += " and id not in("+wlids+")";
		}
		if(!"".equals(wlbm)){
			sqlWhere += " and wlbm like '%"+wlbm+"%'";
		}
		if(!"".equals(wlms)){
			sqlWhere += " and WLMC like '%"+wlms+"%'";
		}
		if(!"".equals(pp)){
			sqlWhere += " and PP like '%"+pp+"%'";
		}
		if(!"".equals(xh)){
			sqlWhere += " and XH like '%"+xh+"%'";
		}
		if(!"".equals(gg)){
			sqlWhere += " and GG like '%"+gg+"%'";
		}
	
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " id  "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\"  >"+         
				  // " <checkboxpopedom  id=\"checkbox\" popedompara=\"column:checkid\" showmethod=\"zx.purchase.CheckPRDetail.getCanCheck\" />"+
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"   />"+
		operateString+
		"			<head>";
				tableString +=
						"<col width=\"10%\" text=\"物料编码\" column=\"WLBM\" orderkey=\"WLBM\" />"+
						"<col width=\"20%\" text=\"物料描述\" column=\"WLMC\" orderkey=\"WLMC\" />"+ 
						"<col width=\"10%\" text=\"品牌\" column=\"PP\" orderkey=\"PP\"  />"+
            "<col width=\"10%\" text=\"规格\" column=\"GG\" orderkey=\"GG\" />"+ 
            "<col width=\"10%\" text=\"型号\" column=\"XH\" orderkey=\"XH\" />"+  
						"<col width=\"20%\" text=\"供应商名称\" column=\"GYSMC\" orderkey=\"GYSMC\" />"+ 
						"<col width=\"10%\" text=\"单价（含税）\" column=\"YGDJ\" orderkey=\"YGDJ\" />"+ 
						
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