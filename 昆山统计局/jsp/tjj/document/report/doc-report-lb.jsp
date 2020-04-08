<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
String tmc_pageId = "docreportlb";
weaver.general.AccountType.langId.set(lg);
SimpleDateFormat sf = new SimpleDateFormat("yyyy");
String nowyear = sf.format(new Date());
String year = Util.null2String(request.getParameter("year"));
String month = "";
if("".equals(year)){
	year = nowyear;
}
String sql = "";



%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 300px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 30px;
		}
		.table-head{padding-right:20px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{刷新,javascript:refersh(),_self} " ;
		//RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{导出,javascript:daochu(),_self} " ;		
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/tjj/document/report/doc-report-lb.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button"  value="导出" class="e8_btn_top" onClick="daochu()" />
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
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
	
	<div style="width:320px;  margin:0 auto;"  >	
	<div class="table-head" style="width:300px;  margin:0 auto;">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="150px"></col><col width="150px"></col>
				 </colgroup>
                <tbody>
					 <tr>
					    
	                    <td class="fname"  align="center" >类别</td>
						<td class="fname"  align="center" >数量</td>
					</tr>	
					
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:320px;  margin:-3px auto;">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup> <col width="150px"></col><col width="150px"></col>
				 </colgroup>
                <tbody>
					<%
						String gzdt = "";
						String jjxx = "";
						String hj1 = "";
						String tjfx = "";
						String tjnc = "";
						String djwg = "";
						String hj2 = "";
						String hj3 = "";
						if(!"".equals(year)){
							sql = "select a.*,hj1+hj2 as hj3 from (select dbo.f_get_documentcount('','',"+year+",'',3,0) as gzdt,dbo.f_get_documentcount('','',"+year+",'',3,1) as jjxx,dbo.f_get_documentcount('','',"+year+",'',3,0)+dbo.f_get_documentcount('','',"+year+",'',3,1) as hj1,dbo.f_get_documentcount('','',"+year+",'',3,2) as tjfx,dbo.f_get_documentcount('','',"+year+",'',3,3) as tjnc,dbo.f_get_documentcount('','',"+year+",'',3,4) as djwg,dbo.f_get_documentcount('','',"+year+",'',3,2)+dbo.f_get_documentcount('','',"+year+",'',3,3)+dbo.f_get_documentcount('','',"+year+",'',3,4) as hj2 ) a";
						}else{
							sql = "select a.*,hj1+hj2 as hj3 from (select dbo.f_get_documentcount('','','','',3,0) as gzdt,dbo.f_get_documentcount('','','','',3,1) as jjxx,dbo.f_get_documentcount('','','','',3,0)+dbo.f_get_documentcount('','','','',3,1) as hj1,dbo.f_get_documentcount('','','','',3,2) as tjfx,dbo.f_get_documentcount('','','','',3,3) as tjnc,dbo.f_get_documentcount('','','','',3,4) as djwg,dbo.f_get_documentcount('','','','',3,2)+dbo.f_get_documentcount('','','','',3,3)+dbo.f_get_documentcount('','','','',3,4) as hj2 ) a";	
						}
						rs.execute(sql);
						if(rs.next()){
							
							gzdt = Util.null2String(rs.getString("gzdt"));
							jjxx = Util.null2String(rs.getString("jjxx"));
							hj1 = Util.null2String(rs.getString("hj1"));
							tjfx = Util.null2String(rs.getString("tjfx"));
							tjnc = Util.null2String(rs.getString("tjnc"));
							djwg = Util.null2String(rs.getString("djwg"));
							hj2 = Util.null2String(rs.getString("hj2"));
							hj3 = Util.null2String(rs.getString("hj3"));
							
						}
					%>
					<tr >
						<td class="fvalue" align="center">工作动态</td>
						<td class="fvalue" align="center"><%=gzdt%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">经济信息</td>
						<td class="fvalue" align="center"><%=jjxx%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">信息合计</td>
						<td class="fvalue" align="center"><%=hj1%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">统计分析</td>
						<td class="fvalue" align="center"><%=tjfx%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">统计内参</td>
						<td class="fvalue" align="center"><%=tjnc%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">党政文稿</td>
						<td class="fvalue" align="center"><%=djwg%></td>
					</tr>
					<tr >
						<td class="fvalue" align="center">分析等合计</td>
						<td class="fvalue" align="center"><%=hj2%></td>
					</tr>
					<tr>
						<td class="fvalue" align="center">总的合计</td>
						<td class="fvalue" align="center"><%=hj3%></td>
					</tr>
					
	                   
						
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	

	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	     function daochu(){
		   var year="<%=year%>";
		   window.open("/tjj/document/report/exportexcel.jsp?type=3&year="+year);
		}

	</script>
</BODY>
</HTML>