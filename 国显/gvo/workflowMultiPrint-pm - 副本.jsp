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
	String sqr = Util.null2String(request.getParameter("sqr"));
	String creater = Util.null2String(request.getParameter("creater"));
	String begindate = Util.null2String(request.getParameter("begindate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	int ismultiprint = -1;
	 ismultiprint = Util.getIntValue(request.getParameter("ismultiprint"));
	 int isdone = -1;
	 isdone = Util.getIntValue(request.getParameter("isdone"));
	int userid = user.getUID();

	String operation = Util.null2String(request.getParameter("operation"));
	if("setprint".equals(operation)){
		int ismultiprintinput = Util.getIntValue(request.getParameter("ismultiprintinput"), -1);
		if(ismultiprintinput==0 || ismultiprintinput==1){
			String multirequestid = Util.null2String(request.getParameter("multirequestid"));
			String sql_tmp = "update workflow_requestbase set ismultiprint="+ismultiprintinput+" where requestid in ("+multirequestid+"0)";
			rs.executeSql(sql_tmp);
		}
	}
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
		<FORM id=report name=report action="/gvo/workflowMultiPrint-pm.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<input type="hidden" id="operation" name="operation" value="">
			<input type="hidden" id="multirequestid" name="multirequestid" value="">
			<input type="hidden" id="ismultiprintinput" name="ismultiprintinput" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(26382,user.getLanguage())%>" class="e8_btn_top" onclick="onMultiPrint()"/>
				    <input type="button" value="<%=SystemEnv.getHtmlLabelName(84820,user.getLanguage())%>" class="e8_btn_top" onclick="onSetPrint(1)"/>	&nbsp;&nbsp;&nbsp;
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(84821,user.getLanguage())%>" class="e8_btn_top" onclick="onSetPrint(0)"/>	&nbsp;&nbsp;&nbsp;
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
                
				<wea:item>实际付款人</wea:item>
				<wea:item>
				<brow:browser viewType="0" name="sqr" browserValue='<%=sqr+""%>' 
										browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
										hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
										completeUrl="/data.jsp" linkUrl="javascript:openhrm($id$)" 
										browserSpanValue='<%=ResourceComInfo.getResourcename(sqr+"")%>'></brow:browser>
				</wea:item>	
				<wea:item>创建人</wea:item>
				<wea:item>
				<brow:browser viewType="0" name="creater" browserValue='<%=creater+""%>' 
										browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp"
										hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
										completeUrl="/data.jsp" linkUrl="javascript:openhrm($id$)" 
										browserSpanValue='<%=ResourceComInfo.getResourcename(creater+"")%>'></brow:browser>
				</wea:item>		
				 <wea:item>付款到期日</wea:item>
				<wea:item>
					 <span>从 </span>
                     <span id="wpbegindate"  >
						<button type="button" class="Calendar" id="SelectBeginDate" onclick="getDate(begindatespan,begindate)"></BUTTON> 
					  	<SPAN id="begindatespan"><%=begindate%></SPAN> 
				  		<INPUT type="hidden" name="begindate" value="<%=begindate%>">  				  		
					</span>
					<span> 到 </span>
					<span id="wpenddate"  >
						<button type="button" class="Calendar" id="SelectEndDate" onclick="getDate(enddatespan,enddate)"></BUTTON> 
					  	<SPAN id="enddatespan"><%=enddate%></SPAN> 
				  		<INPUT type="hidden" name="enddate" value="<%=enddate%>">  				  		
					</span>
                </wea:item>
				
				<wea:item >是否归档</wea:item >
				<wea:item >
				<select id="isdone" name="isdone" >
					<option value="-1"></option>
					<option value="0" <%if(isdone==0){%>selected<%}%>>归档</option>
					<option value="1" <%if(isdone==1){%>selected<%}%>>未归档</option>
				</select>
			 </wea:item>

				<!-- 打印状态 -->
				<wea:item ><%=SystemEnv.getHtmlLabelName(27044,user.getLanguage())%></wea:item >
				<wea:item >
				<select id="ismultiprint" name="ismultiprint" >
					<option value="-1"></option>
					<option value="0" <%if(ismultiprint==0){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(27045,user.getLanguage())%></option>
					<option value="1" <%if(ismultiprint==1){%>selected<%}%>><%=SystemEnv.getHtmlLabelName(27046,user.getLanguage())%></option>
				</select>
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
		String backfields = "a.requestid,b.creatertype,b.requestname,b.workflowid,b.creater,b.createdate, b.createtime, a.bxdh ,a.sqrq, a.sqr, case when b.currentnodetype >=3 then '归档' else '未归档' end as isdone ";
			  
		String fromSql  = " v_kvi_print a join workflow_requestbase b on a.requestid=b.requestid ";
		String sqlWhere = " where 1=1 ";
		String orderby = " a.requestid desc";
		if(!"".equals(bxdh)){
		sqlWhere += " and a.bxdh like '%"+bxdh+"%' ";
		}
		
		if(!"".equals(sqr)){
		sqlWhere += " and a.sqr = '"+sqr+"' ";
		}
		if(!"".equals(creater)){
		sqlWhere += " and b.creater = '"+creater+"' ";
		}
		if(!"".equals(begindate)){
			sqlWhere +=" and a.sqrq>='"+begindate+"' ";
			if(!"".equals(enddate)){
				sqlWhere +=" and a.sqrq<='"+enddate+"' ";
			}
		}else{
			if(!"".equals(enddate)){
				sqlWhere +=" and a.sqrq<='"+enddate+"' ";
			}
		}

		if(ismultiprint > -1){
		sqlWhere += " and b.ismultiprint = '"+ismultiprint+"' ";
		}
		if(isdone == 0){
		sqlWhere += " and b.currentnodetype >= 3 ";
		}else if(isdone == 1){
		sqlWhere += " and b.currentnodetype < 3 ";
		}
//out.print("select " +backfields +" from "+fromSql+sqlWhere+" order by"+orderby );
		String tableString = "";
		String para1="column:requestid+column:workflowid+column:viewtype+0+"+user.getLanguage();
		String  operateString= "";
	       
	    tableString =" <table  tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestid\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+= " <col width=\"20%\" text=\"请求标题\" column=\"requestname\" orderkey=\"requestname\" transmethod=\"weaver.general.WorkFlowTransMethod.getWfNewLink\"  otherpara=\""+para1+"\" />"+
			"               <col width=\"10%\" text=\"报销单号\" column=\"bxdh\" orderkey=\"bxdh\"/>"+
			"               <col width=\"10%\" text=\"实际付款人\" column=\"sqr\" orderkey=\"sqr\" otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
			"               <col width=\"10%\" text=\"预计付款日\" column=\"sqrq\" orderkey=\"sqrq\"/>"+
			"               <col width=\"8%\" text=\"状态\" column=\"isdone\" orderkey=\"isdone\"/>"+
			"               <col width=\"16%\" text=\"工作流\"  column=\"workflowid\" orderkey=\"a.workflowid,a.requestname\" transmethod=\"weaver.workflow.workflow.WorkflowComInfo.getWorkflowname\"/>"+
			"               <col width=\"8%\" text=\"创建人\" column=\"creater\" orderkey=\"creater\" otherpara=\"column:creatertype\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultName\" />"+
			"               <col width=\"16%\" text=\"创建时间\" column=\"createdate\"  orderkey=\"createdate,createtime\" otherpara=\"column:createtime\" transmethod=\"weaver.general.WorkFlowTransMethod.getWFSearchResultCreateTime\"/>"+	
			
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
	function onSetPrint(ismultiprint){	
		
		document.getElementById("ismultiprintinput").value = ismultiprint;		
		var multirequestid = _xtable_CheckedCheckboxId();
		if(multirequestid != null && multirequestid != ""){
			document.getElementById("multirequestid").value = multirequestid;
			document.getElementById("operation").value = "setprint";
			$('#report').submit();
		}else{
			 top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(26427,user.getLanguage())%>");
		}
	}

	</script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
  <SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>