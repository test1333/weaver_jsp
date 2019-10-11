<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="goodbaby.pz.GetGNSTableName"%>
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
    String out_pageId = "operationpz02";

	GetGNSTableName gg = new GetGNSTableName();
	String pktablename = gg.getTableName("PKLC");
	String pzmlid = "131";//凭证生成目录
	String sql = "";
	SimpleDateFormat sf = new SimpleDateFormat("yyyy");

	String year = Util.null2String(request.getParameter("year"));
	String yf = Util.null2String(request.getParameter("yf"));
	String pkbh = Util.null2String(request.getParameter("pkbh"));	
	String pcno = Util.null2String(request.getParameter("pcno"));	
	String begindate = "";
	String enddate = "";
	if(!"".equals(yf) && !"".equals(year)){
		if(yf.length()<=1) {
			begindate = year+"-0"+yf+"-01";
		}else{
			begindate = year+"-"+yf+"-01";
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
		RCMenu += "{生成凭证,javascript:createpz(),_self} " ;
		
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/goodbaby/payment/operationpz.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button"  value="生成凭证" class="e8_btn_top" onClick="createpz()" />
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>年份</wea:item>
					<wea:item>
						<brow:browser name='year' id='year'
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
					<wea:item>排款编号</wea:item>
					<wea:item>
					<input name="pkbh" id="pkbh" class="InputStyle" type="text" value="<%=pkbh%>"/>
					</wea:item>
					<wea:item>批次</wea:item>
					<wea:item>
					<input name="pcno" id="pcno" class="InputStyle" type="text" value="<%=pcno%>"/>
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
		String backfields = " id,keyid,(select pkbh from "+pktablename+" where requestid=a.pklcid) as pkbh,pcno,pklcid,bcyf,bcsf,xzyh,yhmc,cgdl,pzzt,scr,scsj,kjqrqq ";
		String fromSql  =  " from v_gns_kjqrpz a";
		String sqlWhere =  " 1=1";
		if(!"".equals(pkbh)){
			sqlWhere = sqlWhere +"  and (select pkbh from "+pktablename+" where requestid=a.pklcid) like '%"+pkbh+"%'";
		}
		if(!"".equals(begindate) && !"".equals(enddate)){
			sqlWhere = sqlWhere+" and a.kjqrqq<='"+enddate+"' and a.kjqrqq>='"+begindate+"' ";
		}

		if(!"".equals(pcno)){
			sqlWhere = sqlWhere + " and a.pcno='"+pcno+"'";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "id desc"  ;
		String tableString = "";
		String operateString= "";
		operateString = "<operates width=\"20%\">"+
         " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
         " <operate isalwaysshow=\"true\" href=\"javascript:downloadxml();\" linkkey=\"keyid\" linkvaluecolumn=\"keyid\" text=\"下载凭证\" index=\"1\"/> "+
         "</operates>";      

		tableString =" <table tabletype=\"checkbox\"  pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"14%\" text=\"排款编号\" column=\"pkbh\" orderkey=\"pkbh\"  />"+ 
			"<col width=\"6%\" text=\"批次\" column=\"pcno\" orderkey=\"pcno\"/>"+ 
			"<col width=\"10%\" text=\"本次应付\" column=\"bcyf\" orderkey=\"bcyf\"  />"+ 
			"<col width=\"10%\" text=\"本次实付\" column=\"bcsf\" orderkey=\"bcsf\"  />"+ 
			"<col width=\"10%\" text=\"支付银行\" column=\"yhmc\" orderkey=\"yhmc\"  />"+ 
			"<col width=\"10%\" text=\"银行账户\" column=\"xzyh\" orderkey=\"xzyh\"  />"+ 
			"<col width=\"10%\" text=\"确认日期\" column=\"kjqrqq\" orderkey=\"kjqrqq\"  />"+
			"<col width=\"10%\" text=\"凭证状态\" column=\"pzzt\" orderkey=\"pzzt\"  />"+
			"<col width=\"10%\" text=\"生成人\" column=\"scr\" orderkey=\"scr\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+
			"<col width=\"10%\" text=\"生成时间\" column=\"scsj\" orderkey=\"scsj\"  />"+
		
						
						
						"</head>"+
		 "</table>";
		
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
		 function onBtnSearchClick() {
			var year = jQuery("#year").val();
      		var yf = jQuery("#yf").val();
			if ((year == "" && yf != "")||(year != "" && yf == "")) {
				top.Dialog.alert("年份和月份必须同时填写");
				return ;
        	} 
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		function createpz() {
			var ids = _xtable_CheckedCheckboxId();	
			var scr_val = "<%=userid%>";
			var pzmlid  = "<%=pzmlid%>";
			//alert(ids);	
			if(ids==""){
				top.Dialog.alert("请选择数据");
				return ;
			}
			var result = "";
			jQuery.ajax({
					type: "POST",
					url: "/goodbaby/payment/createfkqrxml.jsp",
					data: {'scids':ids,'scr':scr_val,'pzmlid':pzmlid},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								result=data;
							}
        	});
			if(result == "1"){
				top.Dialog.alert("凭证生成成功");
			}else{
				top.Dialog.alert("凭证生成失败，请联系管理员");
			}
			window.location.reload();

		}
		function downloadxml(keyid) {
			var keyvlaue = keyid.split("_");
			var pklcid = keyvlaue[0];
			var pcno = keyvlaue[1];
			var docids = "";
			jQuery.ajax({
					type: "POST",
					url: "/goodbaby/payment/getdocids.jsp",
					data: {'pklcid':pklcid,'pcno':pcno},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								docids=data;
							}
        	});
			if(docids == ""){
				top.Dialog.alert("凭证还未生成，无法下载");
				return;
			}
			downloadAllDocs(docids);

		}
		function downloadAllDocs(docids){ 
			window.location="/weaver/weaver.file.FileDownload?fieldvalue="+docids+"&download=1&downloadBatch=1&requestid="; 
		}

	
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>