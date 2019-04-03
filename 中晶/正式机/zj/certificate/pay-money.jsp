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
    String out_pageId = "fk_1";
	String bz = Util.null2String(request.getParameter("bz"));
	String subid = Util.null2String(request.getParameter("subid"));
	String pernr_f = Util.null2String(request.getParameter("pernr_f"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String requestmark= Util.null2String(request.getParameter("requestmark"));
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
		//RCMenu += "{批量付款,javascript:doservice(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/zj/certificate/pay-money.jsp" method=post>
			<input type="hidden" name="requestid" value="">
				<input type="hidden" name="bz" id="bz" value="<%=bz%>">
					<input type="hidden" name="subid" id="subid" value="<%=subid%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="合并单据" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="doservice();"/>
					<input type="button" value="单笔付款" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="doservice2();"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
			  
				<wea:item>申请人</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="pernr_f" browserValue="<%=pernr_f %>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(pernr_f),user.getLanguage())%>">
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
						<INPUT type="hidden" name="endDate"  id="endDate"  value="<%=endDate%>">  
				</wea:item>
			    <wea:item>单据号码</wea:item>
                <wea:item>
                 <input name="requestmark" id="requestmark" class="InputStyle" type="text" value="<%=requestmark%>"/>
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
		String backfields = "requestid,requestname,sqr,sqrq,case when bz='1' then '美元' else '人民币'end as bz,fkje,fkfs,(select skyh from uf_skfs where id=fkfs) as fkfsname,requestmark";                 
		String fromSql  = " v_fukuan_requestFlow ";
		String sqlWhere = " where 1=1 and bz='"+bz+"' and gs='"+subid+"' and requestid not in (select requestid from request_hb_record where sfcl='0' )";
		String orderby = " requestid desc";
		String tableString = ""; 
	 	if(userid !=1){
			 sqlWhere +=" and cnry='"+userid+"'";
		 }
		if(!"".equals(pernr_f)){
			sqlWhere +=" and sqr='"+pernr_f+"'";
		}
		
		if(!"".equals(beginDate)){
				sqlWhere +=  " and sqrq >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere +=  " and sqrq <='"+endDate+"'";
		}

		if(!"".equals(requestmark)){
			sqlWhere +=" and upper(requestmark) like upper('%"+requestmark+"%')";
		}
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
				 		
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"30%\" text=\"流程名称\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
			"               <col width=\"8%\" text=\"收款人\" column=\"sqr\" orderkey=\"sqr\" otherpara=\"column:sqr\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\"/>"+
                       
			"               <col width=\"8%\" text=\"申请日期\" column=\"sqrq\" orderkey=\"sqrq\"/>"+
			"               <col width=\"8%\" text=\"币种\" column=\"bz\" orderkey=\"bz\"  />"+
			"               <col width=\"8%\" text=\"付款金额\" column=\"fkje\" orderkey=\"fkje\" />"+
			"               <col width=\"18%\" text=\"付款方式\" column=\"fkfsname\" orderkey=\"fkfsname\" />"+
			"               <col width=\"10%\" text=\"单据号码\" column=\"requestmark\" orderkey=\"requestmark\" />"+	
			
		"			</head>"+
	" </table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
	
	   function doservice(){
		   	var ids = _xtable_CheckedCheckboxId();
          //alert(ids);
		  if(ids!=null && ids!=""){
			//  alert(ids);
			  	var xhr1 = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr1 = new XMLHttpRequest();
				}
				if (null != xhr1) {
					xhr1.open("GET","/zj/certificate/do-services.jsp?requestids="+ids, false);
					xhr1.onreadystatechange = function () {
						if (xhr1.readyState == 4) {
							if (xhr1.status == 200) {
								var text = xhr1.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								//if(text =="0"){
								//	alert("请选择付款方式相同的记录，一起提交");
								//	return;
								//}
								
							}	
						}
					}
				xhr1.send(null);			
				}
				window.location.reload();
			}else{
				alert("请先选择需要付款的流程");
			}
	   }
	   function doservice2(){
		   	var ids = _xtable_CheckedCheckboxId();
          //alert(ids);
		  if(ids!=null && ids!=""){
			//  alert(ids);
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/zj/certificate/do-services2.jsp?requestids="+ids, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}else{
				alert("请先选择需要付款的流程");
			}
	   }
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>