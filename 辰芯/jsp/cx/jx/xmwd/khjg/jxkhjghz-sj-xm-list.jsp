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
	String deptid = ResourceComInfo.getDepartmentID(userid+"");
	if("".equals(deptid)){
		deptid = "-1";
	}
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String tablename = "formtable_main_295";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "jxkhjghzcksj_xm";
	String sql = "";
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	String nowmonth = nowdate.substring(5,7);
	String year = Util.null2String(request.getParameter("year"));
	String zq = Util.null2String(request.getParameter("zq"));
	String ry = Util.null2String(request.getParameter("ry"));
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
		//sql = "select tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzdk1' and ta.fieldname='khzq' and tc.selectname='"+month+"'";
		//rs.executeSql(sql);
		//if(rs.next()){
		//	zq = Util.null2String(rs.getString("selectvalue"));
		//}
	}else{
		sql = "select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzdk1' and ta.fieldname='khzq' and tc.selectvalue='"+zq+"'";
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
		<FORM id=report name=report action="/cx/jx/xmwd/khjg/jxkhjghz-sj-xm-list.jsp" method=post>
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
								sql = "select tc.selectname,tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_ygjxzdk1' and ta.fieldname='khzq' and tc.cancel='0' order by listorder asc";
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
					
					<wea:item>人员</wea:item>
						<wea:item>
						<brow:browser viewType="0"  name="ry" browserValue="<%=ry%>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#"
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						linkUrl='/hrm/resource/HrmResource.jsp?id='
						completeUrl='/data.jsp?type=17' width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getMulResourcename1(ry),user.getLanguage())%>">
						</brow:browser>
              		</wea:item>
					<wea:item>评价等级</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="khpjdj" id="khpjdj">
							<option value="" <%if("".equals(khpjdj)){%> selected<%} %>>
							<option value="A(优秀)" <%if("A(优秀)".equals(khpjdj)){%> selected<%} %>>
								<%="A(优秀)"%></option>	
							<option value="B(良好)" <%if("B(良好)".equals(khpjdj)){%> selected<%} %>>
								<%="B(良好)"%></option>		
							<option value="C(一般)" <%if("C(一般)".equals(khpjdj)){%> selected<%} %>>
								<%="C(一般)"%></option>		
							<option value="D(需改进)" <%if("D(需改进)".equals(khpjdj)){%> selected<%} %>>
								<%="D(需改进)"%></option>		
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
		String backfields = " id,lastname,workcode,jobtitle, titlename,ejbm,sjbm,year,zq,zzzhdf,zhkhdj,khzq,(select field1 from cus_fielddata where id=t.id and scopeid=-1) as yglx,'"+year+"年"+month+"' as zqspan,convert(varchar(20),khqz)+'%' as khqz,(select zzsjxs from uf_ygzzsjxs  where gh=(select workcode from hrmresource where id=t.id) and khzqnf='"+year+"' and khzq='"+zq+"') as zzsjxs,[dbo].[get_tbjlxs_hz_xmwd]('"+year+"','"+zq+"',t.id) as tbjlxs,[dbo].[get_ygjxzhxs_hz_xmwd]('"+year+"','"+zq+"',t.id) as ygjxzhxs";
		String fromSql  =  "  from (select id,lastname,workcode,jobtitle,(select jobtitlename from hrmjobtitles where id=a.jobtitle) as titlename,ejbm,sjbm,year,zq,zzzhdf,(select djmc from uf_jxlevel_xm_map where ks&lt;a.zzzhdf and js>=a.zzzhdf) as zhkhdj,'"+year+"'+'_'+'"+zq+"' as khzq,khqz from"+
		" (select id,lastname,workcode,jobtitle,case when (select supdepid from hrmdepartment where id=t.departmentid)=0 then  t.departmentid else (select supdepid from hrmdepartment where id=t.departmentid) end as ejbm,case when (select supdepid from hrmdepartment where id=t.departmentid)=0 then null else t.departmentid end as sjbm,'"+year+"' as year,'"+month+"' as zq,dbo.get_jxzzdf_xmwd('"+year+"','"+zq+"',t.id) as zzzhdf,(select isnull(sum(isnull(a.ygkhqz,0)),0) from "+tablename+" a,workflow_requestbase b where a.requestId=b.requestid and b.currentnodetype>=3   and khzqnf='"+year+"' and khzq='"+zq+"' and fqr=t.id) as khqz from hrmresource t where status&lt;5 and t.departmentid in ("+deptid+") and exists(select 1 from "+tablename+" a,workflow_requestbase b where a.requestId=b.requestid and b.currentnodetype>=3 and khzqnf='"+year+"' and khzq='"+zq+"' and fqr=t.id)) a)t"; 
		String sqlWhere =  " 1=1 ";
		if("".equals(zq)){
			sqlWhere += " and 1=2 ";
		}
		if(!"".equals(ry)){
			sqlWhere += " and t.id in("+ry+")";
		}
		
		if(!"".equals(khpjdj)){
			sqlWhere += " and t.zhkhdj='"+khpjdj+"' ";
		}
		
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  ""  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"8%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+ 
			"<col width=\"8%\" text=\"姓名\" column=\"id\" orderkey=\"id\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/> "+ 
			"<col width=\"8%\" text=\"员工类型\" column=\"yglx\" orderkey=\"yglx\" />"+ 
			"<col width=\"8%\"  text=\"考核周期\" column=\"zqspan\" orderkey=\"zqspan\"  />"+
			//"<col width=\"10%\"  text=\"最终综合得分\" column=\"zzzhdf\" orderkey=\"zzzhdf\"  />"+
			"<col width=\"10%\"  text=\"绩效考核等级\" column=\"zhkhdj\" orderkey=\"zhkhdj\"  />"+
			"<col width=\"10%\"  text=\"员工考核比重\" column=\"khqz\" orderkey=\"khqz\"  />"+
			"<col width=\"10%\"  text=\"在职时间系数\" column=\"zzsjxs\" orderkey=\"zzsjxs\"  />"+
			"<col width=\"12%\"  text=\"员工绩效综合系数\" column=\"ygjxzhxs\" orderkey=\"ygjxzhxs\"  />"+
			"<col width=\"10%\"  text=\"特别激励综合系数\" column=\"tbjlxs\" orderkey=\"tbjlxs\"  />"+
			"<col width=\"16%\"  text=\"单据编号\" column=\"id\" orderkey=\"id\" otherpara=\"column:khzq\" transmethod=\"morningcore.jx.TransUtil.getFlowHrefXmwd\" />"+
		
						
						
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