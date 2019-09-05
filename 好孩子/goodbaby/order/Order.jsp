<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	int user_id = user.getUID();
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
String orderno = Util.null2String(request.getParameter("orderno"));

 int userid  = user.getUID();
String tmc_pageId = "aazhang";
%>
	


<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	<%
RCMenu += "{刷新,javascript:onBtnSearchClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{出货,javascript:createRequest(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
// RCMenu += "{创建确认/验收单,javascript:createLC(),_blank} " ;
// RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/goodbaby/order/Order.jsp" method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type="button" id="cflc" name = "cflc"  value="出货" class="e8_btn_top" onClick="createRequest()" />
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>																  
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
                <wea:item>订单编号</wea:item>
				<wea:item>
				 <input name="orderno" id="orderno" class="InputStyle" type="text" value="<%=orderno%>"/>
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
	
    String backfields="";
	String fromSql ="";
	String sqlWhere = "";
     backfields = "b.requestname,b.requestid,b.workflowid ,(select c.name from  crm_customerinfo c where c.id = isnull(a.xtkh,0)) as xtkh,a.CGSL,(select WLname from  uf_materialDatas where id = isnull(a.WLMC,0) ) as WLMC,a.DDBH,a.YQJHRQ as shsj ,isnull((select sum(isnull(d.SJSHSL_1,0)) from  formtable_main_243 c join formtable_main_243_dt1 d on c.id =d.mainid join workflow_requestbase e on c.requestid = e.requestid where e.currentnodetype>=3 and d.wlbh_1=a.WLBM and d.cgsqd=a.requestid and e.workflowid ='213' ),0)as SJSHSL,a.SHRQ ,isnull((select  sum(isnull(g.SJSHSL_1,0)) from  formtable_main_243 f join formtable_main_243_dt1 g on f.id =g.mainid join workflow_requestbase h on f.requestid = h.requestid where h.currentnodetype &lt; 3 and g.wlbh_1=a.WLBM and g.cgsqd=a.requestid and h.workflowid ='213'),0) as chzsl  "; 
	 fromSql  = " from formtable_main_240 a, workflow_requestbase  b  ";
	 sqlWhere = " where  a.requestid=b.requestid   and  b.workflowid = 232 and b.currentnodetype >= 3 ";
	
	if(!"".equals(orderno)){
		sqlWhere +=" and a.DDBH like '%"+orderno+"%' ";
	}
	if(userid!=1){
		sqlWhere +=" and a.xtkh ='"+userid+"' ";
	}
	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " b.requestid " ;
	String tableString = "";
   // out.print("select "+backfields+fromSql+sqlWhere+" order by "+orderby);
//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		" <checkboxpopedom  id=\"checkbox\" popedompara=\"column:requestid\" showmethod=\"goodbaby.order.CheckCanCreate.CheckCreate\" />"+
	"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+	
    operateString+
    "			<head>";
		tableString+="<col width=\"15%\"  text=\"订单编号\" column=\"DDBH\" orderkey=\"DDBH\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
		"<col width=\"15%\"  text=\"供应商名称\" column=\"xtkh\" orderkey=\"xtkh\"/>"+
		"<col width=\"15%\"  text=\"物料名称\" column=\"WLMC\" orderkey=\"WLMC\"/>"+
		"<col width=\"10%\"  text=\"订单数量\" column=\"CGSL\" orderkey=\"CGSL\"/>"+
		"<col width=\"10%\"  text=\"交期\" column=\"shsj\" orderkey=\"shsj\"/>"+
		"<col width=\"10%\"  text=\"对方已入库数量\" column=\"SJSHSL\" orderkey=\"SJSHSL\"/>"+
		//"<col width=\"10%\"  text=\"实际送货日期\" column=\"SHRQ\" orderkey=\"SHRQ\"/>"+
		"<col width=\"10%\"  text=\"出货中数量\" column=\"chzsl\" orderkey=\"chzsl\"/>"+
	"          </head>"+
    " </table>";
	

%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		function createLC(){
			openFullWindowHaveBarForWFList("/workflow/request/AddRequest.jsp?workflowid=233&isagent=0&beagenter=0&f_weaver_belongto_userid="+userid);
		}
        function onBtnSearchClick() {
			report.submit();
		 }
		function createRequest(){
			var ids = _xtable_CheckedCheckboxId();
			var sqr=<%=userid%>;
			var workflowid=213;
			
			var type="1";
			var tablename="formtable_main_520";
            if(ids!=null && ids!=""){
				//alert("1："+ids);
				var url = "/goodbaby/order/OrderInfo.jsp?rids="+ids;
				var title = "出货信息";
				openDialog(url,title);
			}else {
				Dialog.alert("请选择要出库的数据");
			}
		}


		
		
		function openDialog(url,title){
			dialog = new window.top.Dialog();
			dialog.currentWindow = window;
			var url = url;
			dialog.Title = title;
			dialog.Width = 1200;
			dialog.Height = 600;
			dialog.Drag = true;
			dialog.URL = url;
			dialog.maxiumnable=true;//允许最大化
			dialog.show();
		}
	</script>
	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
