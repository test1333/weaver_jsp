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
	String xmid=Util.null2String(request.getParameter("xmid"));
	String deptid = ResourceComInfo.getDepartmentID(userid+"");
	if("".equals(deptid)){
		deptid = "-1";
	}
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String tablename = "";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "qzhzxm";
	String sql = "";
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
	String nowdate = sf.format(new Date());
	String nowyear = nowdate.substring(0,4);
	String nowmonth = nowdate.substring(5,7);
	String year = Util.null2String(request.getParameter("year"));
	String zq = Util.null2String(request.getParameter("zq"));
	String jd = Util.null2String(request.getParameter("jd"));
	String status = Util.null2String(request.getParameter("status"));
	String ry = Util.null2String(request.getParameter("ry"));
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
		<FORM id=report name=report action="/cx/jx/xmwd/qzhz/qzhz-xm-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="xmid" value="<%=xmid%>">
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
					<wea:item>季度</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="jd" id="jd">
							<option value="" <%if("".equals(jd)){%> selected<%} %>>
								<%=""%></option>
							<option value="1" <%if("1".equals(jd)){%> selected<%} %>>
								第一季度</option>
							<option value="2" <%if("2".equals(jd)){%> selected<%} %>>
								第二季度</option>
							<option value="3" <%if("3".equals(jd)){%> selected<%} %>>
								第三季度</option>
							<option value="4" <%if("4".equals(jd)){%> selected<%} %>>
							第四季度</option>
							
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
		String backfields = " keyid,xm,xm1,nf,jd,nbdd,convert(varchar(20),rltrbl)+'%' as rltrbl,ys,convert(varchar(20),pjqz)+'%' as pjqz,(select xmmc from uf_xmxx where id=a.xm) as xmmcname,(select xmbh from uf_xmxx where id=a.xm) as xmbh,(select workcode from hrmresource where id=a.xm1) as workcode,(select field1 from cus_fielddata where id=a.xm1 and scopeid=-1) as yglx,case when jd='1' then '第一季度'  when jd='2' then '第二季度' when jd='3' then '第三季度' else '第四季度' end as jdspan,(select count(distinct yf) from v_jx_ygtrxx where xm1=a.xm1 and nf=a.nf and jd=a.jd) as yfs,cast(a.rltrbl/(select count(distinct yf) from v_jx_ygtrxx where xm1=a.xm1 and nf=a.nf and jd=a.jd) as numeric(10,1)) as pjtrqz";
		String fromSql  =  " from (select max(id) as keyid,xm,xm1,nf,jd,max(nbdd) as nbdd,isnull(sum(isnull(rltrbl,0)),0) as rltrbl,sum(ys) as ys ,cast(isnull(sum(isnull(rltrbl,0)),0)/sum(ys) as numeric(10,1))  as pjqz  from v_jx_ygtrxx where xm="+xmid+" group by xm,xm1,nf,jd) a"; 
		String sqlWhere =  " 1=1 ";
		if("".equals(year)){
			sqlWhere += " and 1=2 ";
		}else{
			sqlWhere += " and nf='"+year+"' ";
		}
		if(!"".equals(jd)){
			sqlWhere += " and jd='"+jd+"' ";
		}
		if(!"".equals(ry)){
			sqlWhere += " and xm1 in("+ry+")";
		}

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "nf asc,jd asc "  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"keyid\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"10%\" text=\"项目名称\" column=\"xmmcname\" orderkey=\"xmmcname\" />"+ 
		    "<col width=\"10%\" text=\"项目编号\" column=\"xmbh\" orderkey=\"xmbh\" />"+ 
			"<col width=\"8%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+ 
			"<col width=\"8%\" text=\"姓名\" column=\"xm1\" orderkey=\"xm1\"   transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/> "+ 
			"<col width=\"8%\" text=\"员工类型\" column=\"yglx\" orderkey=\"yglx\" />"+ 
			"<col width=\"8%\" text=\"年份\" column=\"nf\" orderkey=\"nf\" />"+
			"<col width=\"8%\" text=\"季度\" column=\"jdspan\" orderkey=\"jdspan\"  />"+ 
			"<col width=\"10%\" text=\"内部订单\" column=\"nbdd\" orderkey=\"nbdd\"  />"+ 
			"<col width=\"10%\"  text=\"季度工时合计\" column=\"rltrbl\" orderkey=\"rltrbl\"  />"+
			"<col width=\"10%\"  text=\"进项目月份数\" column=\"yfs\" orderkey=\"yfs\"  />"+
			"<col width=\"10%\"  text=\"项目投入权重\" column=\"pjtrqz\" orderkey=\"pjtrqz\"  />"+
			
		
						
						
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