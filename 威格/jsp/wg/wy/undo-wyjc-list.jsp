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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "wyjc";
	String sql = "";

	String sqr = Util.null2String(request.getParameter("sqr"));
	String khyh = Util.null2String(request.getParameter("khyh"));
	String yhzh = Util.null2String(request.getParameter("yhzh"));
	String zhmc = Util.null2String(request.getParameter("zhmc"));
	String sqbm = Util.null2String(request.getParameter("sqbm"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String djbh = Util.null2String(request.getParameter("djbh"));
	String beginDate1 = Util.null2String(request.getParameter("beginDate1"));
	String endDate1 = Util.null2String(request.getParameter("endDate1"));
	
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
		RCMenu += "{推送,javascript:dodata(),_self} " ;
		
		RCMenuHeight += RCMenuHeightStep ; 
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/wg/wy/undo-wyjc-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button"  value="推送" class="e8_btn_top" onClick="dodata()" />
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
					<wea:item>开户银行</wea:item>
					<wea:item>
					<input name="khyh" id="khyh" class="InputStyle" type="text" value="<%=khyh%>"/>
					</wea:item>
					<wea:item>银行账号</wea:item>
					<wea:item>
					<input name="yhzh" id="yhzh" class="InputStyle" type="text" value="<%=yhzh%>"/>
					</wea:item>
					<wea:item>账户名称</wea:item>
					<wea:item>
					<input name="zhmc" id="zhmc" class="InputStyle" type="text" value="<%=zhmc%>"/>
					</wea:item>
					
					<wea:item>申请人</wea:item>
						<wea:item>
						<brow:browser viewType="0"  name="sqr" browserValue="<%=sqr%>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(sqr),user.getLanguage())%>">
						</brow:browser>
              		</wea:item>
					<wea:item>申请部门</wea:item>
					<wea:item>
						<brow:browser name='sqbm'
						viewType='0'
						browserValue='<%=sqbm%>'
						isMustInput='1'
						browserSpanValue='<%=Util.toScreen(DepartmentComInfo.getDepartmentname(sqbm),user.getLanguage())%>'
						hasInput='true'
						linkUrl='/hrm/company/HrmDepartmentDsp.jsp?id='
						completeUrl='/data.jsp?type=4'
						width='60%'
						isSingle='true'
						hasAdd='false'
						browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
						</brow:browser>
					</wea:item>
					<wea:item>申请日期</wea:item>
					<wea:item>
						<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
							<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN>
							<INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">
						&nbsp;-&nbsp;
						<button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON>
							<SPAN id=endDateSpan><%=endDate%></SPAN>
							<INPUT type="hidden" name="endDate" id="endDate" value="<%=endDate%>">
					</wea:item>
					<wea:item>单据编号</wea:item>
					<wea:item>
					<input name="djbh" id="djbh" class="InputStyle" type="text" value="<%=djbh%>"/>
					</wea:item>
					<wea:item>付款日期</wea:item>
					<wea:item>
						<button type="button" class=Calendar id="selectBeginDate1" onclick="onshowPlanDate('beginDate1','selectBeginDateSpan1')"></BUTTON>
							<SPAN id=selectBeginDateSpan1 ><%=beginDate1%></SPAN>
							<INPUT type="hidden" name="beginDate1" id="beginDate1" value="<%=beginDate1%>">
						&nbsp;-&nbsp;
						<button type="button" class=Calendar id="selectEndDate1" onclick="onshowPlanDate('endDate1','endDateSpan1')"></BUTTON>
							<SPAN id=endDateSpan1><%=endDate1%></SPAN>
							<INPUT type="hidden" name="endDate1" id="endDate1" value="<%=endDate1%>">
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
		String backfields = " id,paybank,(select tc.selectname from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='uf_netbank' and ta.fieldname='paybank' and tc.selectvalue=a.paybank) as paybankname,bank,account,accountname,paymount,reqman,reqdept,reqdate,flowno,paydate ";
		String fromSql  =  " uf_netbank a "; 
		String sqlWhere =  " 1=1 and (status='' or status is null) and paybank='0' ";
		
		if(!"".equals(sqr)){
			sqlWhere += " and reqman = '"+sqr+"'";
		}
		if(!"".equals(khyh)){
			sqlWhere += " and bank like '%"+khyh+"%'";
		}
		if(!"".equals(yhzh)){
			sqlWhere += " and account like '%"+yhzh+"%'";
		}
		if(!"".equals(zhmc)){
			sqlWhere += " and accountname like '%"+zhmc+"%'";
		}
		if(!"".equals(sqbm)){
			sqlWhere += " and reqdept = '"+sqbm+"'";
		}
		if(!"".equals(beginDate)){
			sqlWhere += " and reqdate >= '"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere += " and reqdate <= '"+endDate+"'";
		}
		if(!"".equals(djbh)){
			sqlWhere += " and djbh like '%"+djbh+"%'";
		}
		if(!"".equals(beginDate1)){
			sqlWhere += " and paydate >= '"+beginDate+"'";
		}
		if(!"".equals(endDate1)){
			sqlWhere += " and paydate <= '"+endDate+"'";
		}
		
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "id desc"  ;
		String tableString = "";
		String operateString= "";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		tableString +="<col width=\"10%\" text=\"付款银行\" column=\"paybankname\" orderkey=\"paybankname\"  />"+ 
			"<col width=\"10%\" text=\"开户银行\" column=\"bank\" orderkey=\"bank\" />"+ 
			"<col width=\"10%\" text=\"银行账号\" column=\"account\" orderkey=\"account\"  />"+ 
			"<col width=\"10%\" text=\"账户名称\" column=\"accountname\" orderkey=\"accountname\"  />"+ 
			"<col width=\"10%\" text=\"付款金额\" column=\"paymount\" orderkey=\"paymount\" />"+ 
			"<col width=\"10%\" text=\"申请人\" column=\"reqman\" orderkey=\"reqman\"  transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/>"+ 
			"<col width=\"10%\"  text=\"申请部门\" column=\"reqdept\" orderkey=\"reqdept\"  transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
			"<col width=\"10%\"  text=\"申请日期\" column=\"reqdate\" orderkey=\"reqdate\"  />"+
			"<col width=\"10%\"  text=\"单据编号\" column=\"flowno\" orderkey=\"flowno\"  linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=12&amp;formId=-41&amp;opentype=0&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
			"<col width=\"10%\"  text=\"付款日期\" column=\"paydate\" orderkey=\"paydate\"  />"+
		
						
						
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
		function dodata() {
			var ids = _xtable_CheckedCheckboxId();	
			//alert(ids);	
			if(ids==""){				
				top.Dialog.alert("请选择数据");
				return ;
			}
			if(ids.match(/,$/)){
				ids = ids.substring(0,ids.length-1);
			}
			var result = "";
			jQuery.ajax({
					type: "POST",
					url: "/wg/wy/dodata.jsp",
					data: {'clids':ids},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								result=data;
								//alert(result);
							}
        	});
			if(result == "0"){
				top.Dialog.alert("推送成功");								
			}else if(result == "2"){
				top.Dialog.alert("推送失败，请查看原因");								
			}else{				
				top.Dialog.alert("接口调用失败，请联系管理员");
			}
			window.location.reload();

		}
		
		

	
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>