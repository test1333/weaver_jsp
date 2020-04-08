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
	
	int userid = user.getUID();
	
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String tablename = "formtable_main_295";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "jxdjckbm1_xm_all";
	String sql = "";
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	String nowmonth = nowdate.substring(5,7);
	String year = Util.null2String(request.getParameter("year"));
	String zq = Util.null2String(request.getParameter("zq"));
	String status = Util.null2String(request.getParameter("status"));
	String ry = Util.null2String(request.getParameter("ry"));
	String month = "";
	String xmmc = Util.null2String(request.getParameter("xmmc"));
	String xmmcspan = "";
	String xmflag = "";
	if(!"".equals(xmmc)){
		sql = "select xmmc from uf_xmxx where id in("+xmmc+")";
		rs.execute(sql);
		while(rs.next()){
			xmmcspan = xmmcspan + xmflag + Util.null2String(rs.getString("xmmc"));
			xmflag = ",";
		}
	}
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
		<FORM id=report name=report action="/cx/jx/xmwd/sjhz/jxdj-xm-list-all.jsp" method=post>
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
					 <wea:item>项目</wea:item>
					<wea:item>
						<brow:browser name='xmmc'
						viewType='0'
						browserValue='<%=xmmc%>'
						isMustInput='1'
						browserSpanValue='<%=xmmcspan%>'
						hasInput='true'
						linkUrl=''
						completeUrl=''
						width='60%'
						isSingle='false'
						hasAdd='false'
						browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.uf_xmmc'>
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
		String backfields = " xmid,keyid,khzq,xmmc,dj,convert(varchar(20),fbyq)+'%' as fbyq,convert(varchar(20),ztfbrls)+'%' as ztfbrls,convert(varchar(20),sjfbrls)+'%' as sjfbrls,convert(varchar(20),sjfbqk)+'%' as sjfbqk,jcjg";
		String fromSql  =  " from (select a.id as xmid,1 as keyid ,'"+year+"年"+month+"' as khzq,xmmc,'A' as dj ,isnull([dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'0'),0) as fbyq,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*[dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'0')/100,0) as numeric(10,1)) as ztfbrls,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'0'),0.0) as numeric(10,1)) as sjfbrls,case when [dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')=0.000 then 0.00 else cast([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'0')/[dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*100 as numeric(10,2)) end as sjfbqk,[dbo].[get_jyjg]('"+year+"','"+zq+"',a.id,'0') as jcjg from uf_xmxx a  "+
		"union all "+
		" select a.id as xmid,2 as keyid ,'"+year+"年"+month+"' as khzq,xmmc,'B' as dj ,isnull([dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'1'),0) as fbyq,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*[dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'1')/100,0) as numeric(10,1)) as ztfbrls,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'1'),0.0) as numeric(10,1)) as sjfbrls,case when [dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')=0.000 then 0.00 else cast([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'1')/[dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*100 as numeric(10,2)) end  as sjfbqk,[dbo].[get_jyjg]('"+year+"','"+zq+"',a.id,'1') as jcjg from uf_xmxx a "+
		"union all "+
		" select a.id as xmid,3 as keyid ,'"+year+"年"+month+"' as khzq,xmmc,'C' as dj ,isnull([dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'2'),0) as fbyq,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*[dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'2')/100,0) as numeric(10,1)) as ztfbrls,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'2'),0.0) as numeric(10,1)) as sjfbrls,case when [dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')=0.000 then 0.00 else cast([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'2')/[dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*100 as numeric(10,2)) end  as sjfbqk,[dbo].[get_jyjg]('"+year+"','"+zq+"',a.id,'2') as jcjg from uf_xmxx a "+
 "union all "+
		" select a.id as xmid,4 as keyid ,'"+year+"年"+month+"' as khzq,xmmc,'D' as dj ,isnull([dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'3'),0) as fbyq,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*[dbo].[get_fbyq]('"+year+"','"+zq+"',a.id,'3')/100,0) as numeric(10,1)) as ztfbrls,cast(isnull([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'3'),0.0) as numeric(10,1)) as sjfbrls,case when [dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')=0.000 then 0.00 else cast([dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'3')/[dbo].[get_xmrls]('"+year+"','"+zq+"',a.id,'')*100 as numeric(10,2)) end  as sjfbqk,[dbo].[get_jyjg]('"+year+"','"+zq+"',a.id,'3') as jcjg from uf_xmxx a ) a"; 
		String sqlWhere =  " 1=1 ";
		if("".equals(zq)){
			sqlWhere += " and 1=2 ";
		}
		if(!"".equals(xmmc)){
			sqlWhere += " and xmid in ("+xmmc+") ";
		}

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "xmid desc,keyid "  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"keyid\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"12.5%\" text=\"考核周期年份\" column=\"khzq\" orderkey=\"khzq\" />"+ 
		    "<col width=\"12.5%\" text=\"项目名称\" column=\"xmmc\" orderkey=\"xmmc\" />"+ 
			"<col width=\"12.5%\" text=\"绩效考核等级\" column=\"dj\" orderkey=\"dj\" />"+ 
			"<col width=\"12.5%\" text=\"分布要求\" column=\"fbyq\" orderkey=\"fbyq\"  /> "+ 
			"<col width=\"12.5%\" text=\"正态分布人力数\" column=\"ztfbrls\" orderkey=\"ztfbrls\" />"+ 
			"<col width=\"12.5%\" text=\"实际分布人力数\" column=\"sjfbrls\" orderkey=\"sjfbrls\"  />"+ 
			"<col width=\"12.5%\"  text=\"实际分布情况\" column=\"sjfbqk\" orderkey=\"sjfbqk\"  />"+
			"<col width=\"12.5%\"  text=\"校检结果\" column=\"jcjg\" orderkey=\"jcjg\"  />"+
			
		
						
						
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