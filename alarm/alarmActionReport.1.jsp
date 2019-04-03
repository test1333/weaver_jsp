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
	String flag=",";
	String text="";
	String channel = Util.null2String(request.getParameter("channel"));
	String AREAL_name ="";
	String AREAL = Util.null2String(request.getParameter("AREAL"));
	AREAL = AREAL.replaceAll(",","','");
	String sql1 = "select distinct text from uf_mainalarm where type='AREAL' and active=0 and language=7 and code in('"+AREAL+"')";
	rs.executeSql(sql1);
	text="";
	while(rs.next()){
	       text = Util.null2String(rs.getString("text"));
		   AREAL_name +=text;
		   AREAL_name =AREAL_name+""+flag;
	   }
	String PROVINCE_name ="";
	String PROVINCE = Util.null2String(request.getParameter("PROVINCE"));
	PROVINCE = PROVINCE.replaceAll(",","','");
    sql1 = "select distinct text from uf_mainalarm where type='PROVINCE' and active=0 and language=7 and code in('"+PROVINCE+"')";
	rs.executeSql(sql1);
	text="";
	while(rs.next()){
	       text = Util.null2String(rs.getString("text"));
		   PROVINCE_name +=text;
		   PROVINCE_name =PROVINCE_name+""+flag;
	   }
	
	String rptdesc = Util.null2String(request.getParameter("rptdesc"));
	String BUSINESS_name ="";
	String BUSINESS = Util.null2String(request.getParameter("BUSINESS"));
	BUSINESS = BUSINESS.replaceAll(",","','");
    sql1 = "select distinct text from uf_mainalarm where type='BUSINESS' and active=0 and language=7 and code in('"+BUSINESS+"')";
	rs.executeSql(sql1);
	text="";
	while(rs.next()){
	       text = Util.null2String(rs.getString("text"));
		   BUSINESS_name +=text;
		   BUSINESS_name =BUSINESS_name+""+flag;
	   }
	String CUSTOMER_name ="";
	String CUSTOMER = Util.null2String(request.getParameter("CUSTOMER"));
	CUSTOMER = CUSTOMER.replaceAll(",","','");
    sql1 = "select distinct text from uf_mainalarm where type='CUSTOMER' and active=0 and language=7 and code in('"+CUSTOMER+"')";
	rs.executeSql(sql1);
	text="";
	while(rs.next()){
	       text = Util.null2String(rs.getString("text"));
		  CUSTOMER_name +=text;
		   CUSTOMER_name =CUSTOMER_name+""+flag;
	   }
	String category = Util.null2String(request.getParameter("category"));
	String KPI_name ="";
	String KPI = Util.null2String(request.getParameter("KPI"));
	KPI = KPI.replaceAll(",","','");
    sql1 = "select distinct text from uf_mainalarm where type='KPI' and active=0 and language=7 and code in('"+KPI+"')";
	rs.executeSql(sql1);
	text="";
	while(rs.next()){
	       text = Util.null2String(rs.getString("text"));
		  KPI_name +=text;
		   KPI_name =KPI_name+""+flag;
	   }
	String tjcq = Util.null2String(request.getParameter("tjcq"));
    if("".equals(tjcq)){
	  tjcq ="Y";
	}
	String spcq = Util.null2String(request.getParameter("spcq"));
	String alarmdate = Util.null2String(request.getParameter("alarmdate"));
	String is_search="0";
	if(!"".equals(channel)||!"".equals(AREAL)||!"".equals(PROVINCE)||!"".equals(rptdesc)||!"".equals(BUSINESS)||!"".equals(CUSTOMER)||!"".equals(category)||!"".equals(KPI)||!"".equals(tjcq)||!"".equals(spcq)||!"".equals(alarmdate)){
	is_search="1";
	}
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "out_info";
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
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/alarm/alarmActionReport.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
			     
				<wea:item>渠道</wea:item>
				<wea:item>
				 <input name="channel" id="channel" class="InputStyle" type="text" value="<%=channel%>"/>
				</wea:item>
                <wea:item>大区</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="AREAL" browserValue="<%=AREAL%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.AREAL"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=AREAL_name %>">
				</brow:browser>
				</wea:item>

				 <wea:item>省办</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="PROVINCE" browserValue="<%=PROVINCE%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.PROVINCE"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=PROVINCE_name %>">
				</brow:browser>
				</wea:item>

				<wea:item>责任人</wea:item>
				<wea:item>
				 <input name="rptdesc" id="rptdesc" class="InputStyle" type="text" value="<%=rptdesc%>"/>
				</wea:item>

                <wea:item>营业所</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="BUSINESS" browserValue="<%=BUSINESS%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.BUSINESS"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=BUSINESS_name %>">
				</brow:browser>
				</wea:item>

				<wea:item>客户</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="CUSTOMER" browserValue="<%=CUSTOMER%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.CUSTOMER"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=CUSTOMER_name %>">
				</brow:browser>
				</wea:item>


				<wea:item>品类</wea:item>
				<wea:item>
				 <input name="category" id="category" class="InputStyle" type="text" value="<%=category %>"/>
				</wea:item>
				<wea:item>KPI指标</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="KPI" browserValue="<%=KPI%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/MultiCommonBrowser.jsp?type=browser.KPI"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=KPI_name %>">
				</brow:browser>
				</wea:item>
				<wea:item>提交超期</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="tjcq" id="tjcq"> 
				<option value="A" <%if("".equals(tjcq)){%> selected<%} %>>
					<%=""%></option>
				<option value="Y" <%if("Y".equals(tjcq)){%> selected<%} %>>
					<%="Y"%></option>
				<option value="N" <%if("N".equals(tjcq)){%> selected<%} %>>
					<%="N"%></option>				
				</select>
				</wea:item>
				<wea:item>审批超期</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="spcq" id="spcq"> 
				<option value="" <%if("".equals(spcq)){%> selected<%} %>>
					<%=""%></option>
				<option value="Y" <%if("Y".equals(spcq)){%> selected<%} %>>
					<%="Y"%></option>
				<option value="N" <%if("N".equals(spcq)){%> selected<%} %>>
					<%="N"%></option>				
				</select>
				</wea:item>
				<wea:item>ALARM 创建日期</wea:item>
				<wea:item>
                     <span id="wpbegindate"  >
						<button type="button" class="Calendar" id="SelectBeginDate" onclick="getDate(alarmdatespan,alarmdate)"></BUTTON> 
					  	<SPAN id="alarmdatespan"><%=alarmdate%></SPAN> 
				  		<INPUT type="hidden" name="alarmdate" value="<%=alarmdate%>">  				  		
					</span>
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
		String backfields = "a.alarm_id,a.channel,getTextValue('AREAL',7,a.area) area,getTextValue('PROVINCE',7,a.province) province,getTextValue('BUSINESS',7,a.sales_grp) as sales_grp,a.rptdesc,getTextValue('CUSTOMER',7,a.zcustomer) zcustomer,a.category,"+
		                    "getTextValue('KPI',7,kfcode) kfname,a.acheive||'%' as acheive,a.a_level||'级' as a_level,a.alarm_dat,b.actionid,b.xdfa,b.modedatacreatedate,a.tjsj,a.spsj,"+
							"case when (case when a.tjsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.tjsj,'yyyy-mm-dd') end)-getTextValue('PERIOD',7,'C')>to_date(a.alarm_dat,'yyyy-mm-dd') then 'Y' else 'N' end as tjcq,"+
							"case when a.tjsj is null then 'N' else (case when (case when a.spsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.spsj,'yyyy-mm-dd') end)-getTextValue('PERIOD',7,'A')>to_date(a.tjsj,'yyyy-mm-dd') then 'Y' else 'N' end) end as spcq";			  
		String fromSql  = " uf_alarm_info a left join uf_action_plan b on a.alarm_id=b.alarmid";
		String sqlWhere = " where 1=1 ";
		String orderby = " a.alarm_id desc";
		String tableString = "";
	
		if("1".equals(is_search)){
		 
		 if(!"".equals(channel)){
		 	sqlWhere +="and a.channel = '"+channel+"'";
		 }
		  if(!"".equals(AREAL)){
		 	sqlWhere +="and a.area in ('"+AREAL+"')";
		 }
		  if(!"".equals(PROVINCE)){
		 	sqlWhere +="and a.province in ('"+PROVINCE+"')";
		 }
		  if(!"".equals(rptdesc)){
		 	sqlWhere +="and a.rptdesc = '"+rptdesc+"'";
		 }
		  if(!"".equals(BUSINESS)){
		 	sqlWhere +="and a.sales_grp in ('"+BUSINESS+"')";
		 }
		  if(!"".equals(CUSTOMER)){
		 	sqlWhere +="and a.zcustomer in ('"+CUSTOMER+"')";
		 }
		   if(!"".equals(category)){
		 	sqlWhere +="and a.category = '"+category+"'";
		 }
		   if(!"".equals(KPI)){
		 	sqlWhere +="and a.kfcode = '"+KPI+"'";
		 }
         if(!"".equals(tjcq)){
		    if("Y".equals(tjcq)){
			sqlWhere +="and (case when a.tjsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.tjsj,'yyyy-mm-dd') end)-getTextValue('PERIOD',7,'C')> to_date(a.alarm_dat,'yyyy-mm-dd')";
			}else if("N".equals(tjcq)){
			sqlWhere +="and (case when a.tjsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.tjsj,'yyyy-mm-dd') end)-getTextValue('PERIOD',7,'C') <= to_date(a.alarm_dat,'yyyy-mm-dd')";
			}
		 }
		 if(!"".equals(spcq)){
		    if("Y".equals(spcq)){
			sqlWhere +="and (a.tjsj is not null and (case when a.spsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.spsj,'yyyy-mm-dd')end) -getTextValue('PERIOD',7,'A')> to_date(a.tjsj,'yyyy-mm-dd') )";
			}else{
			sqlWhere +="and (a.tjsj is  null or (a.tjsj is not null and (case when a.spsj is null then to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') else to_date(a.spsj,'yyyy-mm-dd')end) -getTextValue('PERIOD',7,'A')<= to_date(a.tjsj,'yyyy-mm-dd')) )";
			}
		 }

		 if(!"".equals(alarmdate)){
		 	sqlWhere +="and a.alarm_dat = '"+alarmdate+"'";
		 }
		}else{
		sqlWhere +="and approvestatus = 110";
		}
	
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"8%\" text=\"ALARM ID\" column=\"alarm_id\" orderkey=\"alarm_id\"/>"+
			"               <col width=\"5%\" text=\"渠道\" column=\"channel\" orderkey=\"channel\"/>"+
			"               <col width=\"8%\" text=\"销售大区\" column=\"area\" orderkey=\"area\"/>"+
			"               <col width=\"10%\" text=\"销售省办\" column=\"province\" orderkey=\"province\"/>"+
			"               <col width=\"8%\" text=\"责任人\" column=\"rptdesc\" orderkey=\"rptdesc\"/>"+
			"               <col width=\"10%\" text=\"营业所\" column=\"sales_grp\" orderkey=\"sales_grp\"/>"+
			"               <col width=\"10%\" text=\"客户\" column=\"zcustomer\" orderkey=\"zcustomer\"/>"+	
			"               <col width=\"8%\" text=\"品类\" column=\"category\" orderkey=\"category\"/>"+
			"               <col width=\"10%\" text=\"KPI指标\" column=\"kfname\" orderkey=\"kfname\"/>"+
			"               <col width=\"5%\" text=\"达成率\" column=\"acheive\" orderkey=\"acheive\"/>"+
			"               <col width=\"8%\" text=\"预警层级\" column=\"a_level\" orderkey=\"a_level\"/>"+
			"               <col width=\"8%\" text=\"创建日期\" column=\"alarm_dat\" orderkey=\"alarm_dat\"/>"+	
			"               <col width=\"10%\" text=\"行动方案\" column=\"actionid\" orderkey=\"actionid\"/>"+
			"               <col width=\"10%\" text=\"行动描述\" column=\"xdfa\" orderkey=\"xdfa\"/>"+
			"               <col width=\"10%\" text=\"行动创建日期\" column=\"modedatacreatedate\" orderkey=\"modedatacreatedate\"/>"+
			"               <col width=\"10%\" text=\"行动提交日期\" column=\"tjsj\" orderkey=\"tjsj\"/>"+
			"               <col width=\"10%\" text=\"行动审批日期\" column=\"spsj\" orderkey=\"spsj\"/>"+
			"               <col width=\"8%\" text=\"提交超期\" column=\"tjcq\" orderkey=\"tjcq\"/>"+	
			"               <col width=\"8%\" text=\"审批超期\" column=\"spcq\" orderkey=\"spcq\"/>"+			
			
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
   </script>
  <SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
  <SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>