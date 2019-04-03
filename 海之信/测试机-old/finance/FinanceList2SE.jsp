<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

int curr_user = user.getUID();
// 总经理
String sql_1 = "select count(id) as count_cc from HrmRoleMembers where roleid=12 and resourceid="+curr_user;
RecordSet.executeSql(sql_1);
boolean isShow = false;
if(RecordSet.next()){
	int flag_cc = RecordSet.getInt("count_cc");
	if(flag_cc > 0)  isShow = true;
}

String customName = Util.null2String(request.getParameter("customName"));
String customCode = Util.null2String(request.getParameter("customCode"));
String enLook = Util.null2String(request.getParameter("enLook"));

String multiIds = Util.null2String(request.getParameter("multiIds"));
String val_id = Util.null2String(request.getParameter("val_id"));

String sql_x_1 = "";
String sql_x_2 = "";

if("third".equals(val_id)){
	sql_x_1 = "update uf_tmp_financeInfo set ReqSataus=2 where tmpReqID in("+multiIds+"0)";
	RecordSet.executeSql(sql_x_1);
//	sql_x_2 = "insert into uf_tmp_financeInfo(tmpReqID,ReqSataus,createTime,updateTime) select requestid,'2' as st,convert(varchar(40),getdate(),121) as cd,"
//		+"convert(varchar(40),getdate(),121) as ud from workflow_requestbase where requestid in("+multiIds+"0)"
//		+"and requestid not in(select tmpReqID from uf_tmp_financeInfo)";
//	RecordSet.executeSql(sql_x_2);
}

if("first".equals(val_id)){
	sql_x_1 = "update uf_tmp_financeInfo set ReqSataus=0 where tmpReqID in("+multiIds+"0)";
	RecordSet.executeSql(sql_x_1);
//	sql_x_2 = "insert into uf_tmp_financeInfo(tmpReqID,ReqSataus,createTime,updateTime) select requestid,'0' as st,convert(varchar(40),getdate(),121) as cd,"
//		+"convert(varchar(40),getdate(),121) as ud from workflow_requestbase where requestid in("+multiIds+"0) "
//		+"and requestid not in(select tmpReqID from uf_tmp_financeInfo)";
//	RecordSet.executeSql(sql_x_2);
}

%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
if(isShow){
	RCMenu += "{批准,javascript:onCheckup(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{退回,javascript:onCheckup1(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="multiIds" value="">
	<input type="hidden" name="val_id" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	

	</wea:group>
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%

/*Iterator<String> it = map.keySet().iterator();
while(it.hasNext()){
String tmp_id_x = it.next();
String tmp_name_x = map.get(tmp_id_x);
}*/
//	out.prinln(tmp_name_x);	
	int maxField = 4;
	
	if(maxField < 1) maxField = 1;
	if(maxField > 7) maxField = 7;
	
	StringBuffer buff_1 = new StringBuffer();
	StringBuffer buff_2 = new StringBuffer();
	for(int index=1;index<=maxField;index++){
		buff_1.append(",remark");buff_1.append(index);
		buff_1.append(",wb");buff_1.append(index);buff_1.append(".fieldname as remarkQ_");buff_1.append(index);buff_1.append(" ");
		buff_2.append(" left join workflow_billfield wb");buff_2.append(index);buff_2.append(" on wb");buff_2.append(index);
		buff_2.append(".id=uf.remark");buff_2.append(index);buff_2.append(" ");
	}
	
	StringBuffer buff_sql = new StringBuffer();
	
	String f_sql = "select x.tablename,x.workflowname as fname,uf.workflowName " + buff_1.toString() + " from uf_financeConfField uf " 
			+ buff_2.toString() 
		+ " join (select wr.id,tablename,workflowname from workflow_bill wb join workflow_base wr on wr.formid=wb.id) x on uf.workflowName=x.id"
		+ " where uf.id in (select max(id) from uf_financeConfField group by workflowName)  ";
	RecordSet.executeSql(f_sql);
	String flag_t = "";
	while(RecordSet.next()){
		buff_sql.append(flag_t);buff_sql.append("select f.requestid,");
		String tmp_fname = Util.null2String(RecordSet.getString("fname"));
		buff_sql.append("'");buff_sql.append(tmp_fname);buff_sql.append("'as fname");
		
		for(int index=1;index<=maxField;index++){
			String tmp_x = Util.null2String(RecordSet.getString("remarkQ_"+index));
			buff_sql.append(",");
			if("".equals(tmp_x)){
				buff_sql.append("''");
			}else{
				buff_sql.append("f.");buff_sql.append(tmp_x);
			}
			buff_sql.append(" as val_");buff_sql.append(index);buff_sql.append(" ");
		}
		String tmp_tablename = Util.null2String(RecordSet.getString("tablename"));
		buff_sql.append(" from "); buff_sql.append(tmp_tablename); 
		buff_sql.append(" f where f.requestid in (select requestid from workflow_requestbase where currentnodetype=3) ");
		buff_sql.append(" and f.requestid in (select tmpReqID from uf_tmp_financeInfo where ReqSataus=1)");
		
		flag_t = " union ";
	}
	
//	out.print("sql_x_1 = " + sql_x_1 + " ; sql_x_2 = " + sql_x_2);
//	out.print("buff_sql = " + buff_sql.toString());
	
	String wk_ids = "";
	
	String backfields = " fh.* "; 
	String fromSql  = " from ("+buff_sql.toString()+") fh ";
	String sqlWhere = " where 1=1 ";
	String orderby = " fh.requestid " ;
	String tableString = "";

// out.println("customName="+customName+";customCode="+customCode+";enLook="+enLook+";jpLook="+jpLook+";telephone="+telephone+";website="+website);
	
//if(!"".equals(customName)){
//	sqlWhere = sqlWhere + " and customName like '%"+customName+"%'";
//}
//if(!"".equals(customCode)){
//	sqlWhere = sqlWhere + " and customCode like '%"+customCode+"%'";
//}


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
	operateString+
    " <head>";                                                                                                                                                  
	tableString+="	<col width=\"30%\" labelid=\"流程名称\" text=\"请求名称\" column=\"requestid\" orderkey=\"requestid\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\" transmethod=\"seahonor.util.RequestInfo.getRequestName\"  href=\"/workflow/request/ViewRequest.jsp\" />"+
	  " <col width=\"10%\" labelid=\"32497\" text=\"所属内容\" column=\"fname\" orderkey=\"fname\" />"+
	  " <col width=\"10%\" labelid=\"368\" text=\"申请人\" column=\"val_1\" orderkey=\"val_1\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
      " <col width=\"10%\" labelid=\"855\" text=\"申请日期\" column=\"val_2\" orderkey=\"val_2\" />"+
      " <col width=\"10%\" labelid=\"15134\" text=\"付款金额\" column=\"val_3\" orderkey=\"val_3\" />"+
      " </head>"+
      " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function onCheckup(){
		if(window.confirm('你是否已完成付款吗？')){
			var ids = _xtable_CheckedCheckboxId();
			if(ids != ""){
				document.report.multiIds.value = ids;
				document.report.val_id.value = "third";
				document.report.action = "FinanceList2SE.jsp";
				document.report.submit();
			}else{
	        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
	    	}
	    }
	}
	
	function onCheckup1(){
		if(window.confirm('你是否退回待审核付款？')){
			var ids = _xtable_CheckedCheckboxId();
			if(ids != ""){
				document.report.multiIds.value = ids;
				document.report.val_id.value = "first";
				document.report.action = "FinanceList2SE.jsp";
				document.report.submit();
			}else{
	        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
	    	}
	    }
	}
		
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
	</script>
</BODY>
</HTML>
