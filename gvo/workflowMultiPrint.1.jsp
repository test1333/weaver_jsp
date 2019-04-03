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

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<jsp:useBean id="WfComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page"/>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String bxdh = Util.null2String(request.getParameter("bxdh"));
	String dxzje = Util.null2String(request.getParameter("dxzje"));
	String fycdr = Util.null2String(request.getParameter("fycdr"));
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	String zuzhi="";
	
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/gvo/workflowMultiPrint.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" value="<%=SystemEnv.getHtmlLabelName(26382,user.getLanguage())%>" class="e8_btn_top" onclick="onMultiPrint()"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				

				<wea:item>报销单号</wea:item>
				<wea:item>
				 <input name="bxdh" id="bxdh" class="InputStyle" type="text" value="<%=bxdh%>"/>
				</wea:item>
                <wea:item>总金额</wea:item>
				<wea:item>
				 <input name="dxzje" id="dxzje" class="InputStyle" type="text" value="<%=dxzje %>"/>
				</wea:item>	
				<wea:item>费用承担人</wea:item>
				<wea:item>
				<brow:browser viewType="0" name="fycdr" browserValue='<%=fycdr+""%>' 
										browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
										hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
										completeUrl="/data.jsp" linkUrl="javascript:openhrm($id$)" 
										browserSpanValue='<%=ResourceComInfo.getResourcename(fycdr+"")%>'></brow:browser>
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
		String backfields = "select a.requestid,b.creatertype,b.requestname,b.workflowid,b.creater,b.createdate, b.createtime, a.bxdh,a.dxzje, a.fycdr ";
			  
		String fromSql  = " formtable_main_9 a join workflow_requestbase b on a.requestid=b.requestid ";
		String sqlWhere = " where 1=1 ";
		String orderby = " a.requestid desc";
		if(!"".equals(bxdh)){
		sqlWhere += " and a.bxdh like '%+bxdh+%' ";
		}
		if(!"".equals(dxzje)){
		sqlWhere += " and a.dxzje = '+dxzje+' ";
		}
		if(!"".equals(fycdr)){
		sqlWhere += " and a.fycdr = '+fycdr+' ";
		}
		out.print("select "+backfields+" from "+fromSql+sqlWhere+" order by"+orderby);
		String tableString = "";
		String para1="column:requestid+column:workflowid+column:viewtype+0+"+user.getLanguage();
		String  operateString= "";
	  
	    tableString =" <table  tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestid\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"20%\" text=\"请求标题\" column=\"requestname\" orderkey=\"requestname\" transmethod=\"weaver.general.WorkFlowTransMethod.getWfNewLink\"  otherpara=\""+para1+"\" />"+
			"               <col width=\"20%\" text=\"报销单号\" column=\"bxdh\" orderkey=\"bxdh\"/>"+
			"               <col width=\"15%\" text=\"总金额\" column=\"dxzje\" orderkey=\"dxzje\"/>"+
			"               <col width=\"10%\" text=\"费用承担人\" column=\"fycdr\" orderkey=\"fycdr\"  transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
			"               <col width=\"15%\" text=\"工作流\"  column=\"workflowid\" orderkey=\"a.workflowid,a.requestname\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\"/>"+
			"               <col width=\"10%\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
			"               <col width=\"10%\" text=\"创建时间\" column=\"createdate\"  orderkey=\"createdate,createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\"/>"+	
			
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
     function onMultiPrint(){
		var multirequestid = _xtable_CheckedCheckboxId();
		//alert(multirequestid);
		if(multirequestid!=null && multirequestid!=""){
			var redirectUrl = "/workflow/multiprint/MultiPrintGroups.jsp?multirequestid="+multirequestid;
			var width = screen.availWidth-10 ;
			var height = screen.availHeight-50 ;
			var szFeatures = "top=0," ;
			szFeatures +="left=0," ;
			szFeatures +="width="+width+"," ;
			szFeatures +="height="+height+"," ;
			szFeatures +="directories=no," ;
			szFeatures +="status=yes,toolbar=no,location=no," ;
			szFeatures +="menubar=no," ;
			szFeatures +="scrollbars=yes," ;
			szFeatures +="resizable=yes" ; //channelmode
			//window.open(redirectUrl,"",szFeatures) ;
			jQuery.post("/workflow/multiprint/MultiPrintGroups.jsp",{multirequestid : multirequestid },function(_data){
				_data = eval("(" + _data + ")");
				var modereqids = _data.modereqids;
				if(!!modereqids && modereqids.length > 0){
					var redirectUrl = "/workflow/multiprint/MultiPrintMode.jsp?multirequestid=" + modereqids;
					window.open(redirectUrl,"",szFeatures) ;
				}

				var htmlreqids = _data.htmlreqids;
				if(!!htmlreqids && typeof htmlreqids == "object"){
					for(_key in htmlreqids){
						var redirectUrl = "/workflow/multiprint/MultiPrintRequest.jsp?multirequestid=" + htmlreqids[_key];
						window.open(redirectUrl,"",szFeatures) ;
					}
				}
			});
		}else{
		 top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(26427,user.getLanguage())%>");
		}
	}
	</script>
</BODY>
</HTML>