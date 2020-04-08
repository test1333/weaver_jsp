<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="goodbaby.pz.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
String tmc_pageId = "ckzjckrhz";
weaver.general.AccountType.langId.set(lg);
SimpleDateFormat sf = new SimpleDateFormat("yyyy");
String nowyear = sf.format(new Date());
String year = Util.null2String(request.getParameter("year"));
String yf = Util.null2String(request.getParameter("yf"));
String ckid = Util.null2String(request.getParameter("ckid"));
GetGNSTableName gg = new GetGNSTableName();
String lrktablename = gg.getTableName("LXLL");
String month = "";
if("".equals(year)){
	year = nowyear;
}
if(!"".equals(yf)){
	if(yf.length()<=1) {
		month=year+"0"+yf;
	}else{
		month=year+yf;
	}
}
String sql = "";
String ckmc = "";
if(!"".equals(ckid)){
	sql = "select ckmc from uf_stocks where id="+ckid;
	rs.executeSql(sql);
	if(rs.next()){
		ckmc = Util.null2String(rs.getString("ckmc"));
	}
}



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
			WIDTH: 1000px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 20px;
		}
		.table-head{padding-right:17px}
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
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/crk/ckcrkhz.jsp" method=post>
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
					<wea:item>月份</wea:item>
					<wea:item>
						<select class="e8_btn_top middle" name="yf" id="yf">
							<option value="" <%if("".equals(yf)){%> selected<%} %>>
								<%=""%></option>
							<option value="1" <%if("1".equals(yf)){%> selected<%} %>>
								<%="1月"%></option>
							<option value="2" <%if("2".equals(yf)){%> selected<%} %>>
								<%="2月"%></option>
							<option value="3" <%if("3".equals(yf)){%> selected<%} %>>
								<%="3月"%></option>
							<option value="4" <%if("4".equals(yf)){%> selected<%} %>>
								<%="4月"%></option>
							<option value="5" <%if("5".equals(yf)){%> selected<%} %>>
								<%="5月"%></option>						
							<option value="6" <%if("6".equals(yf)){%> selected<%} %>>
								<%="6月"%></option>
							<option value="7" <%if("7".equals(yf)){%> selected<%} %>>
								<%="7月"%></option>
							<option value="8" <%if("8".equals(yf)){%> selected<%} %>>
								<%="8月"%></option>
							<option value="9" <%if("9".equals(yf)){%> selected<%} %>>
								<%="9月"%></option>
							<option value="10" <%if("10".equals(yf)){%> selected<%} %>>
								<%="10月"%></option>
							<option value="11" <%if("11".equals(yf)){%> selected<%} %>>
								<%="11月"%></option>
							<option value="12" <%if("12".equals(yf)){%> selected<%} %>>
								<%="12月"%></option>


						</select>
					</wea:item>
				<wea:item>仓库</wea:item>
				<wea:item>
					<brow:browser name='ckid'
					viewType='0'
					browserValue='<%=ckid%>'
					isMustInput='1'
					browserSpanValue='<%=ckmc%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.CK'>
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
	
	<div style="width:1020px;  margin:0 auto;"  >	
	<div class="table-head" style="width:1000px;  margin:0 auto;">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="200px"></col><col width="400px"></col><col width="200px"></col><col width="200px"></col>
				 </colgroup>
                <tbody>
				<tr>
					    
	                    <td class="fname" colspan="4" align="center"><%=month%>&nbsp;&nbsp;<%=ckmc%></td>
					</tr>
					 <tr>
					    
	                    <td class="fname"  align="center">类别</td>
						<td class="fname"  align="center">单位</td>
						<td class="fname"  align="center">金额</td>
						<td class="fname"  align="center">调价增减金额</td>
					</tr>	
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:1020px;">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="200px"></col><col width="400px"></col><col width="200px"></col><col width="200px"></col>
				 </colgroup>
                <tbody>
					 <%
					 	if(!"".equals(month) && !"".equals(ckid)){
							 String qcye = "";
							 String byrk = "";
							 String byll = "";
							 String ly = "";
							 String th = "";
							 String qmye = "";
							 sql = "select [dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','qcye') as qcye,[dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','byrk') as byrk,[dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','byll') as byll,[dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','ly') as ly,[dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','th') as th,[dbo].[f_get_crk_je]('"+month+"','"+ckid+"','','qmye') as qmye";
							 rs.executeSql(sql);
							 if(rs.next()){
								qcye = Util.null2String(rs.getString("qcye"));
								byrk = Util.null2String(rs.getString("byrk"));
								byll = Util.null2String(rs.getString("byll"));
								ly = Util.null2String(rs.getString("ly"));
								th = Util.null2String(rs.getString("th"));
								qmye = Util.null2String(rs.getString("qmye"));
							 }
					 %>		 
					 	<tr >
						<td class="fvalue" align="center">期初余额</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=qcye%></td>
						<td class="fvalue"></td>
						</tr>
						<tr  bgcolor="#FFD966">
						<td class="fvalue" align="center">本月入库</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=byrk%></td>
						<td class="fvalue"></td>
						</tr>
						<tr  bgcolor="#FFD966">
						<td class="fvalue" align="center">采购入库</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=byrk%></td>
						<td class="fvalue"></td>
						</tr>
						<%
						 sql = "select gysmc,wsje as je from v_ckr_list where cwny='"+month+"' and ckid="+ckid+" and rkly='0'";
						 rs.executeSql(sql);
						 while(rs.next()){
						%>
						<tr  bgcolor="#FFD966">
						<td class="fvalue" align="center"></td>
						<td class="fvalue"><%=Util.null2String(rs.getString("gysmc"))%></td>
						<td class="fvalue"  align="right"><%=Util.null2String(rs.getString("je"))%></td>
						<td class="fvalue"></td>
						</tr>
						<%	 
						 }
						%>
						
						<tr  bgcolor="#9BC2E6">
						<td class="fvalue" align="center">本月盘盈</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right">0.00</td>
						<td class="fvalue"></td>
						</tr>
						<tr bgcolor="#FFBE00">
						<td class="fvalue" align="center">本月领料</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=byll%></td>
						<td class="fvalue"></td>
						</tr>
						<tr bgcolor="#FFBE00">
						<td class="fvalue" align="center">领用</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=ly%></td>
						<td class="fvalue"></td>
						</tr>
						<%
						 sql = "select (select cbzxbmmc from uf_cbzx a,"+lrktablename+" b where a.id=b.cbzx and b.requestid=lch ) as cbzx,wsje as je from v_ckr_list where cwny='"+month+"' and ckid="+ckid+" and rkly='1' and (thbs is null or thbs ='1')";
						 rs.executeSql(sql);
						 while(rs.next()){
						%>
						<tr bgcolor="#FFBE00">
						<td class="fvalue" align="center"></td>
						<td class="fvalue"><%=Util.null2String(rs.getString("cbzx"))%></td>
						<td class="fvalue"  align="right"><%=Util.null2String(rs.getString("je"))%></td>
						<td class="fvalue"></td>
						</tr>
						<%	 
						 }
						%>
						<tr bgcolor="#FFBE00">
						<td class="fvalue" align="center">退货</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=th%></td>
						<td class="fvalue"></td>
						</tr>
						<%
						 sql = "select gysmc,wsje as je from v_ckr_list where cwny='"+month+"' and ckid="+ckid+" and rkly='1' and thbs ='0'";
						 rs.executeSql(sql);
						 while(rs.next()){
						%>
						<tr bgcolor="#FFBE00">
						<td class="fvalue" align="center"></td>
						<td class="fvalue"><%=Util.null2String(rs.getString("gysmc"))%></td>
						<td class="fvalue"  align="right"><%=Util.null2String(rs.getString("je"))%></td>
						<td class="fvalue"></td>
						</tr>
						<%	 
						 }
						%>
						<tr  bgcolor="#FFFF00">
						<td class="fvalue" align="center">本月盘亏</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right">0.00</td>
						<td class="fvalue"></td>
						</tr>
						<tr>
						<td class="fvalue" align="center">期末余额</td>
						<td class="fvalue"></td>
						<td class="fvalue"  align="right"><%=qmye%></td>
						<td class="fvalue"></td>
						</tr>
					<%
						 }					 					 
					 %>
				
	                   
						
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
	   

	</script>
</BODY>
</HTML>