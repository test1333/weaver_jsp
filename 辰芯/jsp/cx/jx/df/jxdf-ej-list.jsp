﻿<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    String out_pageId = "jxdfej";

	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String tablename = "formtable_main_51";
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	String nowmonth = nowdate.substring(5,7);
	String year = Util.null2String(request.getParameter("year"));
	String zq = Util.null2String(request.getParameter("zq"));
	String status = Util.null2String(request.getParameter("status"));
	String ry = Util.null2String(request.getParameter("ry"));
	String sjbm = Util.null2String(request.getParameter("sjbm"));
	String khpjdj = Util.null2String(request.getParameter("khpjdj"));
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
		//sql = "select tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' and tc.selectname='"+month+"'";
		//rs.executeSql(sql);
		//if(rs.next()){
		//	zq = Util.null2String(rs.getString("selectvalue"));
		//}
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
		<FORM id=report name=report action="/cx/jx/df/jxdf-ej-list.jsp" method=post>
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
					<wea:item>状态</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="status" id="status">
							<option value="" <%if("".equals(status)){%> selected<%} %>>
								<%=""%></option>
							<option value="已打分" <%if("已打分".equals(status)){%> selected<%} %>>
								<%="已打分"%></option>
							<option value="打分中" <%if("打分中".equals(status)){%> selected<%} %>>
								<%="打分中"%></option>														
						</select>
					</wea:item>
					<wea:item>人员</wea:item>
						<wea:item>
						<brow:browser viewType="0"  name="ry" browserValue="<%=ry%>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(ry),user.getLanguage())%>">
						</brow:browser>
              		</wea:item>
				<wea:item>三级部门</wea:item>
				<wea:item>
					<brow:browser name='sjbm'
					viewType='0'
					browserValue='<%=sjbm%>'
					isMustInput='1'
					browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(sjbm),user.getLanguage())%>'
					hasInput='true'
					linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id='
					completeUrl='/data.jsp?type=4'
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
					</brow:browser>
				</wea:item>
				<wea:item>考核打分等级</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="khpjdj" id="khpjdj">
							<option value="" <%if("".equals(khpjdj)){%> selected<%} %>>
								<%=""%></option>
							<%
								sql = "select tc.selectname,tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='"+tablename+"' and ta.fieldname='khpjdj' and tc.cancel='0' order by listorder asc";
								rs.executeSql(sql);
								while(rs.next()){
									String selectname = Util.null2String(rs.getString("selectname"));
									String selectvalue = Util.null2String(rs.getString("selectvalue"));
							%>
								<option value="<%=selectvalue%>" <%if(selectvalue.equals(khpjdj)){%> selected<%} %>>
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
			String backfields = " ryid,lastname,workcode,sjbm,jobtitle,(select jobtitlename from hrmjobtitles where id=a.jobtitle) as titlename,erjm,status,year,zq,requestid,keyid,bdbh,khzgdf,khpjdj,khpjdjname,ygkhqz ";
		String fromSql  =  " from (select d.id as ryid,d.lastname,d.workcode,a.sjbm,d.jobtitle,a.erjm,case when c.currentnodetype='3' then '已打分' else '打分中' end as status,a.khzqnf as year,(select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' and tc.selectvalue=a.khzq) as zq,b.requestid,convert(varchar(20),b.requestid) as keyid,b.bdbh,b.khzgdf,b.khpjdj,(select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='"+tablename+"' and ta.fieldname='khpjdj' and tc.selectvalue=b.khpjdj) as khpjdjname,a.ygkhqz from uf_ygjxzbzdk a,"+tablename+" b,workflow_requestbase c,hrmresource d  where a.id=b.xzyzdd and b.requestid=c.requestid and a.fqr=d.id  and d.departmentid in("+deptid+") and d.status&lt;5 and a.khzqnf='"+year+"' and a.khzq='"+zq+"' "+
								" union all "+
								" select d.id as ryid,d.lastname,d.workcode,a.sjbm,d.jobtitle,a.erjm,case when c.currentnodetype='3' then '已打分' else '打分中' end as status,a.khzqnf as year,(select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzbzdk' and ta.fieldname='khzq' and tc.selectvalue=a.khzq) as zq,b.requestid,convert(varchar(20),b.requestid) as keyid,b.bdbh,b.khzgdf,b.khpjdj,(select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='"+tablename+"' and ta.fieldname='khpjdj' and tc.selectvalue=b.khpjdj) as khpjdjname,a.ygkhqz from uf_ygjxzbzdk a,"+tablename+" b,workflow_requestbase c,hrmresource d  where a.id=b.xzyzdd and b.requestid=c.requestid and a.fqr=d.id  and d.departmentid not in("+deptid+") and a.jxssbm in("+deptid+")  and d.status&lt;5 and a.khzqnf='"+year+"' and a.khzq='"+zq+"' "+ 
								" ) a"; 
		String sqlWhere =  " 1=1 ";
		if("".equals(zq)){
			sqlWhere += " and 1=2 ";
		}
		if(!"".equals(status)){
			sqlWhere += " and a.status='"+status+"' ";
		}

		if(!"".equals(ry)){
			sqlWhere += " and a.ryid='"+ry+"' ";
		}

		if(!"".equals(sjbm)){
			sqlWhere += " and a.sjbm='"+sjbm+"' ";
		}
		if(!"".equals(khpjdj)){
			sqlWhere += " and a.khpjdj='"+khpjdj+"' ";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "ryid asc"  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"keyid\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"8%\" text=\"姓名\" column=\"ryid\" orderkey=\"ryid\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/> "+ 
			"<col width=\"8%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+ 
			"<col width=\"8%\" text=\"三级部门\" column=\"sjbm\" orderkey=\"sjbm\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+ 
			"<col width=\"8%\" text=\"岗位\" column=\"titlename\" orderkey=\"titlename\"  />"+ 
			"<col width=\"8%\" text=\"二级部门\" column=\"erjm\" orderkey=\"erjm\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+ 
			"<col width=\"8%\" text=\"打分状态\" column=\"status\" orderkey=\"status\"  />"+ 
			"<col width=\"6%\"  text=\"年份\" column=\"year\" orderkey=\"year\"  />"+
			"<col width=\"6%\"  text=\"周期\" column=\"zq\" orderkey=\"zq\"  />"+
			"<col width=\"10%\"  text=\"最终考核得分\" column=\"khzgdf\" orderkey=\"khzgdf\"  />"+
			"<col width=\"10%\"  text=\"考核打分等级\" column=\"khpjdjname\" orderkey=\"khpjdjname\"  />"+
			"<col width=\"10%\"  text=\"员工考核比重\" column=\"ygkhqz\" orderkey=\"ygkhqz\"  />"+
			"<col width=\"10%\"  text=\"单据编号\" column=\"bdbh\" orderkey=\"bdbh\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
		
						
						
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