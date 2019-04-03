<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<%
	int userid = user.getUID();
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String departmentid = Util.null2String(request.getParameter("departmentid"));
	String workcode = Util.null2String(request.getParameter("workcode"));
	
%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script language="javascript" src="/js/weaver_wev8.js"></script>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	
	String guard_pageId = "receive_info";
	%>
	<BODY>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{查询,javascript:onBtnSearchClick(this),_TOP} ";
		RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self} ";
		RCMenu += "{导出全部,javascript:_xtable_getAllExcel(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type=button class="e8_btn_top" onclick="onBtnSearchClick(this);" value="查询">
						<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="resourceid" browserValue="<%=resourceid%>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
                <wea:item>所在部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="departmentid" browserValue="<%=departmentid%>"
				browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/DepartmentBrowser.jsp?selectedids="
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="165px"
				linkUrl="/hrm/company/HrmDepartmentDsp.jsp?id="
				browserSpanValue="<%=DepartmentComInfo.getDepartmentname(departmentid)%>">
				</brow:browser>
				</wea:item>
				<wea:item>员工工号</wea:item>
				<wea:item>
					<input class=inputstyle id='workcode' name=workcode size="20" value="<%=workcode%>" >
			     </wea:item>
				</wea:group>
				
				<wea:group context="">
				<wea:item type="toolbar">
				<input class="e8_btn_submit" type="submit" name="submit_1" onClick="onBtnSearchClick()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
				<span class="e8_sep_line">|</span>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
			
		</FORM>
		<%
		//  select id,lastname,departmentid,workcode,njAll,njhours,njleft from fx_annual_leave_view
		String backfields = " id,lastname,departmentid,workcode,isnull(njAll,0) as njAll,isnull(njhours,0) as njhours,isnull(njleft,0) as njleft ";
		String fromSql  = " from fx_annual_leave_view  ";
		String sqlWhere = " 1=1 ";

		String orderby = " id " ;
		String tableString = "";
		String operateString= "";

		//员工姓名
		if(!"".equals(resourceid)){
			sqlWhere += "and id = "+resourceid+" ";
		}

		//部门										
		if(!"".equals(departmentid)){
		 	sqlWhere += " and departmentid = "+departmentid+" ";
		}

		//工号										
		if(!"".equals(workcode)){
		 	sqlWhere += " and workcode like '%"+workcode+"%' ";
		}
		
		//out.println("select "+ backfields + fromSql + "where"+ sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(guard_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+guard_pageId+"\">"+
			"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
			operateString +
			"			<head>";
				tableString+="<col width=\"16%\" labelid=\"-10257\" text=\"员工姓名\" column=\"id\" orderkey=\"id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
				"		<col width=\"16%\" labelid=\"-10263\" text=\"所在部门\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
				"		<col width=\"16%\" labelid=\"18939\" text=\"员工工号\" column=\"workcode\" orderkey=\"workcode\" />"+
				"		<col width=\"16%\" labelid=\"-10263\" text=\"年假总时数\" column=\"njAll\" orderkey=\"njAll\" />"+
				"		<col width=\"16%\" labelid=\"18939\" text=\"年假已用时数\" column=\"njhours\" orderkey=\"njhours\" />"+
				"		<col width=\"16%\" labelid=\"-10263\" text=\"年假剩余时数\" column=\"njleft\" orderkey=\"njleft\" />"+
			"			</head>"+
		" </table>";
		%>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
		<script type="text/javascript">
			function onBtnSearchClick() {
				weaver.submit();
			}
		
			function doEdit(){
				
				var ids = _xtable_CheckedCheckboxId();
				//alert("ids="+ids);
				
				if(ids == ""){
					window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
					return false;
				}
				
				Dialog.confirm("确认发放？", function (){
						weaver.action="/fx/annual/jsp/CountAnnual.jsp?id="+ids;
						weaver.submit();
					}, function () {}, 320, 90,false);
			}
			
		</script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
		<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
	</BODY>
</HTML>