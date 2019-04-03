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
    String out_pageId = "zoaex_2";
	String mandt = Util.null2String(request.getParameter("mandt"));
	String lc_type = Util.null2String(request.getParameter("lc_type"));
	String ref_no = Util.null2String(request.getParameter("ref_no"));
	String index_no = Util.null2String(request.getParameter("index_no"));
	String pernr_f = Util.null2String(request.getParameter("pernr_f"));
	String UPD_FLAG_NAME = Util.null2String(request.getParameter("UPD_FLAG_NAME"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String OA_STATUS_NAME = Util.null2String(request.getParameter("OA_STATUS_NAME"));
	String lc_no = Util.null2String(request.getParameter("lc_no"));
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
		RCMenu += "{异常处理,javascript:doservice(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/appdevjsp/HQ/SAPOA/Exception/ZOAException.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="异常处理" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="doservice();"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
			    <wea:item>客户端</wea:item>
				<wea:item>
				 <input name="mandt" id="mandt" class="InputStyle" type="text" value="<%=mandt%>"/>
				</wea:item>
				 <wea:item>流程类型</wea:item>
				<wea:item>
				 <input name="lc_type" id="lc_type" class="InputStyle" type="text" value="<%=lc_type%>"/>
				</wea:item>
				 <wea:item>单据编号</wea:item>
				<wea:item>
				 <input name="ref_no" id="ref_no" class="InputStyle" type="text" value="<%=ref_no%>"/>
				</wea:item>
				<wea:item>SAP流水号</wea:item>
				<wea:item>
				 <input name="index_no" id="index_no" class="InputStyle" type="text" value="<%=index_no%>"/>
				</wea:item>
				<wea:item>创建人</wea:item>
                <wea:item>
                <brow:browser viewType="0"  name="pernr_f" browserValue="<%=pernr_f %>"
                browserOnClick=""
                browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
                hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp" width="165px"
                browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(pernr_f),user.getLanguage())%>">
                </brow:browser>
                </wea:item>
				<wea:item>更新标识</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="UPD_FLAG_NAME" id="UPD_FLAG_NAME"> 
				<option value="" <%if("".equals(UPD_FLAG_NAME)){%> selected<%} %>>
					<%=""%></option>
				<option value="Y" <%if("Y".equals(UPD_FLAG_NAME)){%> selected<%} %>>
					<%="需要"%></option>
				<option value="N" <%if("N".equals(UPD_FLAG_NAME)){%> selected<%} %>>
					<%="不需要"%></option>
				</select>
				</wea:item>

				 <wea:item>归档日期</wea:item>
				<wea:item>
					<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
						<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
						<INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">  
					&nbsp;-&nbsp;
					<button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
						<SPAN id=endDateSpan><%=endDate%></SPAN> 
						<INPUT type="hidden" name="endDate"  id="endDate"  value="<%=endDate%>">  
				</wea:item>
			    <wea:item>OA状态</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="OA_STATUS_NAME" id="OA_STATUS_NAME"> 
				<option value="" <%if("".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%=""%></option>
				<option value="N" <%if("N".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%="已提交"%></option>
				<option value="Y" <%if("Y".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%="审批中"%></option>
				<option value="F" <%if("F".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%="同意"%></option>
				<option value="J" <%if("J".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%="拒绝"%></option>
				<option value="T" <%if("T".equals(OA_STATUS_NAME)){%> selected<%} %>>
					<%="退回修改"%></option>
				</select>
				</wea:item>
				  <wea:item>流程ID</wea:item>
				<wea:item>
				 <input name="lc_no" id="lc_no" class="InputStyle" type="text" value="<%=lc_no%>"/>
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
		String backfields = "t.*,case t.STATUS when 'N' then '已提交' when 'Y' then '审批中' when 'F' then '同意' when 'J' then '拒绝' when 'T' then '退回修改'  else '' end statusname,"+
							" case t.UPD_FLAG when 'Y' then '需要' else '不需要' end as UPD_FLAG_NAME,case t.OA_STATUS when 'N' then '已提交' when 'Y' then '审批中' when 'F' then '同意' when 'J' then '拒绝' when 'T' then '退回修改'  else '' end OA_STATUS_NAME";                   
		String fromSql  = " v_excep_zoat00020 t";
		String sqlWhere = " where 1=1  ";
		String orderby = " lc_no desc";
		String tableString = "";
	    if(!"".equals(mandt)){
			sqlWhere +=" and  Upper(mandt) like Upper('%"+mandt+"%')";
		}
		if(!"".equals(lc_type)){
			sqlWhere +=" and  Upper(LC_TYPE) like Upper('%"+lc_type+"%')";
		}
		if(!"".equals(ref_no)){
			sqlWhere +=" and Upper(ref_no) like Upper('%"+ref_no+"%')";
		}
		if(!"".equals(index_no)){
			sqlWhere +=" and Upper(index_no) like Upper('%"+index_no+"%')";
		}
		if(!"".equals(pernr_f)){
			sqlWhere +=" and pernr_f='"+pernr_f+"'";
		}
		if(!"".equals(UPD_FLAG_NAME)){
			if("Y".equals(UPD_FLAG_NAME)){
				sqlWhere +=" and upd_flag ='"+UPD_FLAG_NAME+"'";
			}else{
				sqlWhere +=" and (upd_flag is null or upd_flag = 'N')";
			}
			
		}
		if(!"".equals(beginDate)){
				sqlWhere +=  " and OA_ENDDATE >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere +=  " and OA_ENDDATE <='"+endDate+"'";
		}
		if(!"".equals(OA_STATUS_NAME)){
			sqlWhere +=" and OA_STATUS='"+OA_STATUS_NAME+"'";
		}
		if(!"".equals(lc_no)){
			sqlWhere +=" and lc_no='"+lc_no+"'";
		}
		//out.print("select "+backfields+" from "+fromSql+sqlWhere);
		String  operateString= "";
			operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:editStatus();\" linkkey=\"lc_no\" linkvaluecolumn=\"lc_no\" text=\"编辑\" index=\"1\"/> "+
		                    "</operates>";		 		
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"lc_no\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"6%\" text=\"客户端\" column=\"MANDT\" orderkey=\"MANDT\" />"+
			"               <col width=\"6%\" text=\"流程类型\" column=\"LC_TYPE\" orderkey=\"LC_TYPE\" />"+
			"               <col width=\"10%\" text=\"单据编号\" column=\"REF_NO\" orderkey=\"REF_NO\" />"+
			"               <col width=\"10%\" text=\"SAP流水号\" column=\"INDEX_NO\" orderkey=\"INDEX_NO\" />"+
			"               <col width=\"6%\" text=\"创建人\" column=\"PERNR_F\" orderkey=\"PERNR_F\" otherpara=\"column:PERNR_F\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\"/>"+
			"               <col width=\"6%\" text=\"单据状态\" column=\"statusname\" orderkey=\"statusname\"/>"+
			"               <col width=\"20%\" text=\"流程\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"lc_no\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
			"               <col width=\"6%\" text=\"更新标示\" column=\"UPD_FLAG_NAME\" orderkey=\"UPD_FLAG_NAME\" />"+
			"               <col width=\"10%\" text=\"归档日期\" column=\"OA_ENDDATE\" orderkey=\"OA_ENDDATE\"/>"+
			"               <col width=\"6%\" text=\"OA状态\" column=\"OA_STATUS_NAME\" orderkey=\"OA_STATUS_NAME\"  />"+
			"               <col width=\"6%\" text=\"Sap状态\" column=\"SAP_STATUS\" orderkey=\"SAP_STATUS\" />"+
			"               <col width=\"8%\" text=\"Sap更新状态\" column=\"SAP_UPDATESTATUS\" orderkey=\"SAP_UPDATESTATUS\" />"+	
				
			
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>
	<script type="text/javascript">
	 var diag_vote;

	  function closeDialog(){
	    diag_vote.close();
      }

      function closeDlgARfsh(){
	   _table.reLoad();
	   diag_vote.close();
       }
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
			  	var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {
					xhr.open("GET","/appdevjsp/HQ/SAPOA/Exception/doException.jsp?requestids="+ids, false);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4) {
							if (xhr.status == 200) {
								var text = xhr.responseText;
								text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
								//alert(text);
								
							}	
						}
					}
				xhr.send(null);			
				}
				window.location.reload();
			}else{
				alert("请先选择需要处理的内容");
			}
	   }
	   function editStatus(lc_no){
		var title = "";
		var url = "";
		 
		title = "";
		url="/appdevjsp/HQ/SAPOA/Exception/edit_upd_flag.jsp?lc_no="+lc_no;
		
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 500;
		diag_vote.Height = 100;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");

		 }
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>