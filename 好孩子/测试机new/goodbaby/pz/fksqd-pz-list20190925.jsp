<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="goodbaby.pz.*"%>
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
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "fksqdpz1";
	String sql = "";
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	String nowyear = sf.format(new Date());
	String year = Util.null2String(request.getParameter("year"));
	String yf = Util.null2String(request.getParameter("yf"));
	String yjcbzx = Util.null2String(request.getParameter("yjcbzx"));
	GetGNSTableName gg = new GetGNSTableName();
	String lrktablename = gg.getTableName("FKSQD");
	String month = "";
	if("".equals(year)){
		year = nowyear;
	}
	String begindate = "";
	String enddate = "";
	if(!"".equals(yf)){
		if(yf.length()<=1) {
			begindate = year+"-0"+yf+"-01";
			month=year+"0"+yf;
		}else{
			begindate = year+"-"+yf+"-01";
			month=year+yf;
		}
	}
	if(!"".equals(begindate)){
		sql = " select convert(varchar(20),DATEADD(ms,-3,DATEADD(mm, DATEDIFF(m,0,'"+begindate+"')+1, 0)),23) as enddate";
		rs.executeSql(sql);
		if(rs.next()){
			enddate = Util.null2String(rs.getString("enddate"));
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
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/pz/fksqd-pz-list.jsp" method=post>
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
				<wea:item>一级成本中心</wea:item>
				<wea:item>
					<brow:browser name='yjcbzx'
					viewType='0'
					browserValue='<%=yjcbzx%>'
					isMustInput='1'
					browserSpanValue='<%=yjcbzx%>'
					hasInput='true'
					linkUrl=''
					completeUrl=''
					width='60%'
					isSingle='true'
					hasAdd='false'
					browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.yjcbzx'>
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
		String backfields = " a.requestid as keyid,a.requestid,b.lastoperatedate,a.lcbh,(select GYSMC from uf_suppmessForm where id=a.skrmc) as gysmc,(select yjcbzx from uf_gns_deptyjcbzx where dept=a.zjlbm) as yjcbzx,b.requestnamenew,(select imagefileid from docimagefile where docid=convert(varchar(20),a.pzfj)) as imagefileid,(select imagefilename from docimagefile where docid=convert(varchar(20),a.pzfj)) as imagefilename,(select buydl from uf_buydl where id=a.cglb) as cglb,case when gzrq is null then b.lastoperatedate else gzrq end as pzrq";
		String fromSql  =  " from "+lrktablename+" a,workflow_requestbase b";
		String sqlWhere =  " a.requestid=b.requestid  and b.currentnodetype=3 ";
		
		if("".equals(yf) || "".equals(yjcbzx)){
			sqlWhere = sqlWhere + " and 1=2 ";
		}

		if(!"".equals(yjcbzx)){
			sqlWhere = sqlWhere+"  and (select yjcbzx from uf_gns_deptyjcbzx where dept=a.zjlbm) = '"+yjcbzx+"'";
		}
		if(!"".equals(begindate) && !"".equals(enddate)){
				sqlWhere = sqlWhere+" and (case when gzrq is null then b.lastoperatedate else gzrq end) <='"+enddate+"' and (case when gzrq is null then b.lastoperatedate else gzrq end) >='"+begindate+"' ";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "keyid desc"  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.requestid\" sqlsortway=\"asc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"10%\" text=\"付款单号\" column=\"lcbh\" orderkey=\"lcbh\"  />"+ 
			"<col width=\"10%\" text=\"采购大类\" column=\"cglb\" orderkey=\"cglb\" />"+ 
			"<col width=\"15%\" text=\"供应商\" column=\"gysmc\" orderkey=\"gysmc\"  />"+ 
			"<col width=\"10%\" text=\"一级成本中心\" column=\"yjcbzx\" orderkey=\"yjcbzx\"  />"+ 
			"<col width=\"10%\" text=\"凭证日期\" column=\"pzrq\" orderkey=\"pzrq\"  />"+ 
			"<col width=\"10%\" text=\"归档日期\" column=\"lastoperatedate\" orderkey=\"lastoperatedate\"  />"+ 
			"<col width=\"15%\"  text=\"相关流程\" column=\"requestnamenew\" orderkey=\"requestid\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
			"<col width=\"15%\"  text=\"凭证\" column=\"imagefilename\" orderkey=\"imagefilename\" linkvaluecolumn=\"imagefileid\" linkkey=\"fileid\" href=\"/weaver/weaver.file.FileDownload?download=1\" target=\"_bank\" />"+
		
						
						
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
		function createpz() {
			var yjcbzx_val = "<%=yjcbzx%>";
			var begindate_val = "<%=begindate%>";
			var enddate_val = "<%=enddate%>";
			var scr_val = "<%=userid%>";
			if(yjcbzx_val != "" && begindate_val != "" && enddate_val != ""){
				var result = "1";
				jQuery.ajax({
					type: "POST",
					url: "/goodbaby/pz/checklxrkd.jsp",
					data: {'yjcbzx':yjcbzx_val,'begindate':begindate_val,'enddate':enddate_val,'scr':scr_val},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								result=data;
							}
        		 });
				if(result == "1"){
					alert("无入库数据无法导出");
				}else{
					window.open("/goodbaby/pz/getlxrkdxml.jsp?yjcbzx="+yjcbzx_val+"&begindate="+begindate_val+"&enddate="+enddate_val+"&scr="+scr_val);
				}
				
				

			}

		}
		
		

	
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>