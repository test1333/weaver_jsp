<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
	
		String sql = "";
	int userid = user.getUID();
	String deptid =Util.null2String(request.getParameter("deptid"));
	String cktype =Util.null2String(request.getParameter("cktype"));
	if("2".equals(cktype)){
		sql = "select id from hrmdepartment where supdepid="+deptid;
		rs.executeSql(sql);
		while(rs.next()){
			deptid = deptid + "," +Util.null2String(rs.getString("id"));
		}
	}
	//out.print("deptid:"+deptid+" cktype:"+cktype);
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "jxdfhzej";

	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String tablename = "formtable_main_51";
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	String nowmonth = nowdate.substring(5,7);
	String year = Util.null2String(request.getParameter("year"));
	String zq = Util.null2String(request.getParameter("zq"));
	String month = "";
	if("".equals(year)){
		year = nowyear;
	}
	if(nowmonth.substring(0,1).equals("0")){
		month = nowmonth.substring(1,2)+"月";
	}else{
		month = nowmonth+"月";
	}
	//out.print("year"+year+" month"+month);
	if("".equals(zq)){
		sql = "select tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' and tc.selectname='"+month+"'";
		rs.executeSql(sql);
		if(rs.next()){
			zq = Util.null2String(rs.getString("selectvalue"));
		}
	}else{
		sql = "select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' and tc.selectvalue='"+zq+"'";
		rs.executeSql(sql);
		if(rs.next()){
			month = Util.null2String(rs.getString("selectname"));
		}
	}
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
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/cx/jx/dfhz/jxdfhz-ej-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="deptid" value="<%=deptid%>">
			<input type="hidden" name="cktype" value="<%=cktype%>">
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
					<wea:item>考核周期</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="zq" id="zq">
							<option value="" <%if("".equals(zq)){%> selected<%} %>>
								<%=""%></option>
							<%
								sql = "select tc.selectname,tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' order by listorder asc";
								rs.executeSql(sql);
								while(rs.next()){
									String selectname = Util.null2String(rs.getString("selectname"));
									String selectvalue = Util.null2String(rs.getString("selectvalue"));
							%>
								<option value="<%=selectvalue%>" <%if(selectvalue.equals(zq)){%> selected<%} %>>
								<%=selectname%></option>
							<%
								}
							%>
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
		String backfields = "id,departmentname,dbo.get_jxdf_level('"+year+"','"+zq+"',id,'0') as slevel,dbo.get_jxdf_level('"+year+"','"+zq+"',id,'1') as alevel,dbo.get_jxdf_level('"+year+"','"+zq+"',id,'2') as blevel,dbo.get_jxdf_level('"+year+"','"+zq+"',id,'3') as clevel,dbo.get_jxdf_level('"+year+"','"+zq+"',id,'4') as dlevel,'"+year+"' as year,'"+month+"' as zq ";
		String fromSql  =  " from HrmDepartment "; 
		String sqlWhere =  " id in("+deptid+") ";
		
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  ""  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"10%\" text=\"部门名称\" column=\"departmentname\" orderkey=\"departmentname\" /> "+ 
			"<col width=\"10%\"  text=\"年份\" column=\"year\" orderkey=\"year\"  />"+
			"<col width=\"10%\"  text=\"周期\" column=\"zq\" orderkey=\"zq\"  />"+
			"<col width=\"10%\"  text=\"S(杰出)\" column=\"slevel\" orderkey=\"slevel\"  />"+
			"<col width=\"10%\"  text=\"A(优秀)\" column=\"alevel\" orderkey=\"alevel\"  />"+
			"<col width=\"10%\"  text=\"B(良好)\" column=\"blevel\" orderkey=\"blevel\"  />"+
			"<col width=\"10%\"  text=\"C(一般)\" column=\"clevel\" orderkey=\"clevel\"  />"+
			"<col width=\"10%\"  text=\"D(需改进)\" column=\"dlevel\" orderkey=\"dlevel\"  />"+
		
						
						
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