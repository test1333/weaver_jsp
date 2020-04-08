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
    String out_pageId = "cxyslisthistory5";
	String year = Util.null2String(request.getParameter("year"));
	String month = Util.null2String(request.getParameter("month"));
	String bm = Util.null2String(request.getParameter("bm"));
	String xm = Util.null2String(request.getParameter("xm"));
	String xmval = "";
	String sql = "select INTERNAL_ORDER_DESC from uf_nbdd where id="+xm;
	rs.executeSql(sql);
	if(rs.next()){
		xmval = Util.null2String(rs.getString("INTERNAL_ORDER_DESC"));
	}
	String fykmbm = Util.null2String(request.getParameter("fykmbm"));
	String jtsm = Util.null2String(request.getParameter("jtsm"));
	String version = Util.null2String(request.getParameter("version"));
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	if("".equals(year)){
		year = nowyear;
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
		//RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/cx/ys/cx-ys-list-history.jsp" method=post>
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
				<wea:item>版本</wea:item>
				<wea:item>
				<input name="version" id="version" class="InputStyle" type="text" value="<%=version%>"/>
				</wea:item>
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
				<wea:item>月份</wea:item>
				<wea:item>
				<input name="month" id="month" class="InputStyle" type="text" value="<%=month%>"/>
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

				<wea:item>项目</wea:item>
				<wea:item>
					<brow:browser name='xm'
					viewType='0'
					browserValue='<%=xm%>'
					isMustInput='1'
					browserSpanValue='<%=xmval%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.uf_nbdd'>
					</brow:browser>
				</wea:item>
				<wea:item>费用科目编码</wea:item>
				<wea:item>
				<input name="fykmbm" id="fykmbm" class="InputStyle" type="text" value="<%=fykmbm%>"/>
				</wea:item>
				<wea:item>具体说明</wea:item>
				<wea:item>
				<input name="jtsm" id="jtsm" class="InputStyle" type="text" value="<%=jtsm%>"/>
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
		String backfields = "id,nf,fsyf,rjbm,ejbm,nbdd,xm,(select INTERNAL_ORDER_DESC from uf_nbdd where id=a.xm) as xmname,fykmbh,fykm,(select yskmmc from uf_yskmsj where id=a.fykm) as yskmmc,sl,jldw,dj,hjje,jtsm,fyxqrr,bb,zt,case when sfyfsys='1' then '是' else '否' end as sfyfsys ";
		String fromSql  =  " from (select * from uf_yssjdr where zt=1) a ";
		String sqlWhere =  " 1=1 ";
		if(!"".equals(version)){
			sqlWhere = sqlWhere + " and bb='"+version+"'";
		}
		
		if(!"".equals(year)){
			sqlWhere = sqlWhere + " and nf='"+year+"'";
		}

		if(!"".equals(month)){
			sqlWhere = sqlWhere + " and fsyf='"+month+"'";
		}
		if(!"".equals(bm)){
			sqlWhere = sqlWhere + " and rjbm='"+bm+"'";
		}
		if(!"".equals(xm)){
			sqlWhere = sqlWhere + " and xm='"+xm+"'";
		}
		if(!"".equals(fykmbm)){
			sqlWhere = sqlWhere + " and fykmbh='"+fykmbm+"'";
		}
		if(!"".equals(jtsm)){
			sqlWhere = sqlWhere + " and jtsm like '%"+jtsm+"%'";
		}
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "id"  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"5%\" text=\"历史版本\" column=\"bb\" orderkey=\"bb\"  />"+ 
							"<col width=\"5%\" text=\"年份\" column=\"nf\" orderkey=\"nf\"  />"+ 
							"<col width=\"5%\" text=\"发生月份\" column=\"fsyf\" orderkey=\"fsyf\"  />"+ 
							"<col width=\"6%\" text=\"二级部门\" column=\"rjbm\" orderkey=\"rjbm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+ 
							"<col width=\"6%\" text=\"三级部门\" column=\"ejbm\" orderkey=\"ejbm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+ 
							"<col width=\"6%\" text=\"内部订单\" column=\"nbdd\" orderkey=\"nbdd\"  />"+ 
							"<col width=\"8%\" text=\"项目\" column=\"xmname\" orderkey=\"xmname\"  />"+ 
							"<col width=\"8%\" text=\"费用科目编号\" column=\"fykmbh\" orderkey=\"fykmbh\"  />"+ 
							"<col width=\"8%\" text=\"费用科目类型\" column=\"yskmmc\" orderkey=\"yskmmc\"  />"+ 
							"<col width=\"6%\" text=\"数量\" column=\"sl\" orderkey=\"sl\"  />"+ 
							"<col width=\"6%\" text=\"计量单位\" column=\"jldw\" orderkey=\"jldw\"  />"+ 
							"<col width=\"6%\" text=\"单价（元）\" column=\"dj\" orderkey=\"dj\"  />"+ 
							"<col width=\"6%\" text=\"合计金额（元）\" column=\"hjje\" orderkey=\"hjje\"  />"+ 
							"<col width=\"7%\" text=\"具体说明\" column=\"jtsm\" orderkey=\"jtsm\"  />"+ 
							"<col width=\"6%\" text=\"费用需求人员\" column=\"fyxqrr\" orderkey=\"fyxqrr\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+ 
							"<col width=\"6%\" text=\"是否已发生预算\" column=\"sfyfsys\" orderkey=\"sfyfsys\"  />"+ 
				
						
						
						"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>
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
		function daoru() {
		var title = "Import";
		var url = "/systeminfo/BrowserMain.jsp?url=/cx/ys/ExcelIn.jsp";
		// var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/ModeForward.jsp?typex=custom,,";

		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 500;
		diag_vote.Height = 300;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		

	}
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>