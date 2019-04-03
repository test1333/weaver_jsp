<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@page import="weaver.hrm.resource.ResourceComInfo"%>
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="tools" class="tool.tools" scope="page"/>



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
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "流程凭证列表";
String needfav ="1";
String needhelp ="";
	String fromdate = Util.null2String(request.getParameter("fromdate"));
String todate = Util.null2String(request.getParameter("todate"));
String OANO = Util.null2String(request.getParameter("OANO"));
String resID = Util.null2String(request.getParameter("resID"));
String endFale = Util.null2String(request.getParameter("endFalg"));
String inFalg = Util.null2String(request.getParameter("inFalg"));
String money = Util.null2String(request.getParameter("money"));

String rzfromdate = Util.null2String(request.getParameter("rzfromdate"));
String rztodate = Util.null2String(request.getParameter("rztodate"));
 String sql = "";
    String tablename = "";
    String detailtablename = "";
	tablename = "formtable_main_1844";
	detailtablename = " formtable_main_1844_dt1";

			//申请人sqr
			String f_sqr = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqr"));
			//申请部门
			String f_sqbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqbm"));
			//申报金额
			String f_sbje = Util.null2String(Prop.getPropValue("FinancialDocuments", "sbje"));
			//实报金额
			String f_bxje = Util.null2String(Prop.getPropValue("FinancialDocuments", "bxje"));
			//申报日期
			String f_sbrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqrq"));
			//OA编号
			String f_oabh = Util.null2String(Prop.getPropValue("FinancialDocuments", "oabh"));
			//导入标志
			String f_drbz = Util.null2String(Prop.getPropValue("FinancialDocuments", "drbz"));
			//是否生成凭证
			String f_sfscpz = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfxydr"));
			//所属一级部门
			String f_ssyjbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "ssyjbm"));
			//凭证号
			String f_pzh = Util.null2String(Prop.getPropValue("FinancialDocuments", "pzh"));
			//是否导出excel
			String f_sfdc = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfdc"));
			//入账日期
			String f_rzrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "rzrq"));
			
			
			//相关的workflowid
			String workflowid = Util.null2String(Prop.getPropValue("workflowStatusList", "workflowid"));
			//节点ID
			String nodeid = Util.null2String(Prop.getPropValue("workflowStatusList", "nodeid"));
    
String tmc_pageId = "lcpz001";
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
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
	RCMenu += "{Excel,javascript:_xtable_getAllExcel(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/empolder/workflow/WorkflowStatusList.jsp"  method=post>
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						
					<!--<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>-->
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
		</table>
					
		<% // 查询条件 %>
		 <div class="tab_box" style="visibility: visible;">
				<wea:layout type="4col">
				<wea:group context="流程凭证列表">

				

				<wea:item>报销日期</wea:item>
				<wea:item>
				<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('fromdate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=fromdate%></SPAN> 
              	<INPUT type="hidden" name="fromdate" id="fromdate" value="<%=fromdate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('todate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=todate%></SPAN> 
            	<INPUT type="hidden" name="todate"  id="todate"  value="<%=todate%>">  
				</wea:item>

				<wea:item>OA流程编号</wea:item>
				<wea:item>
				<input class="InputStyle" type="text"   name="OANO" id="OANO" value="<%=OANO%>">
				</wea:item>

               <wea:item>入账日期</wea:item>
				<wea:item>
				<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('rzfromdate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=rzfromdate%></SPAN> 
              	<INPUT type="hidden" name="rzfromdate" id="rzfromdate" value="<%=rzfromdate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('rztodate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=rztodate%></SPAN> 
            	<INPUT type="hidden" name="rztodate"  id="rztodate"  value="<%=rztodate%>">  
				</wea:item>

<wea:item>实报金额</wea:item>
				<wea:item>
				<input class="InputStyle" type="text"   name="money" id="money" value="<%=money%>">
				</wea:item>

				<wea:item>归档标志</wea:item>
				<wea:item>
					<select class="e8_btn_top middle" name="endFale" id="endFale"> 
                                 		    <option></option>
                                 			<option value="0" <%if("0".equals(endFale)){ %> selected="selected" <%} %>>未归档</option>
                                 			<option value="3" <%if("3".equals(endFale)){ %> selected="selected" <%} %>>已归档</option>
                                 		</select>
				</wea:item>
					<wea:item>导入标志</wea:item>
				<wea:item>
					<select class="e8_btn_top middle" name="inFalg" id="inFalg"> 
                                 		    <option></option>
                                 				<option value="0" <%if("0".equals(inFalg)){ %> selected="selected" <%} %>>未导入</option>
                                 			<option value="1" <%if("1".equals(inFalg)){ %> selected="selected" <%} %>>已导入</option>
                                 		</select>
				</wea:item>
<wea:item>报销人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="resID" browserValue="<%=resID %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resID),user.getLanguage())%>">
				</brow:browser>
				</wea:item>

				</wea:group>		
				</wea:layout>
			</div>

	</FORM>
    
	<%
								
	String backfields = " t1.id,t1."+f_sqr+",t1."+f_sqbm+",t1."+f_sbje+",t1."+f_bxje+",t1."+f_sbrq+",t1."+f_oabh+", case t1."+f_drbz+" when 0 then '未导入' when 1 then '已导入' else '' end as ffdrbz,t1."+f_sfscpz+",t1."+f_ssyjbm+",t1."+f_rzrq+",t1."+f_pzh+",case t1."+f_sfdc+" when 1 then '已导入' else '未导入' end as ff_sfdc,t1.requestid,t2.currentnodetype,t3.nodename,t4.sumamount,'详细' as xx ";
	String fromSql  = " from "+ tablename + " t1 "+
                                        " left join (select t1.requestid,t2.sumamount from "+tablename+" t1 left join (select t1.id,sum(t1."+f_sbje+") as sumamount from "+detailtablename+" t1 group by t1.id) t2 on t1.id = t2.id) t4 on t1.requestid = t4.requestid"+
                                        " left join workflow_requestbase t2 on t1.requestid = t2.requestid "+
                                        " left join (select t1.id,t1.nodename,t2.requestid from workflow_nodebase t1 left join workflow_requestbase t2 on t2.currentnodeid = t1.id) t3 on t3.requestid = t1.requestid"; 
	String sqlWhere =  " where t1."+f_sbrq+" is not null";
	String orderby = " t1.id ";
	String tableString = "";
    if(!"".equals(fromdate)){
         sqlWhere += " and t1."+f_sbrq+" >= '"+fromdate+"'";
    }
    if(!"".equals(todate)){
      sqlWhere += " and t1."+f_sbrq+" <= '"+todate+"'";
    }
    if(!"".equals(OANO)){
      sqlWhere += " and t1."+f_oabh+" like '%"+OANO+"%'";
    }
    if(!"".equals(resID)){
     	sqlWhere += " and t1."+f_sqr+" = '"+resID+"'";
    }
                                if(!"".equals(endFale) && "3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype = '"+endFale+"'";
                                }else if(!"".equals(endFale) && !"3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype <> '3'";
                                }
                                if(!"".equals(inFalg)){
                                	sqlWhere += " and t1."+f_drbz+" = '"+inFalg+"'";
                                }
                                if(!"".equals(money)){
                                	sqlWhere += " and t1."+f_bxje+" = '"+money+"'";
                                }
                                if(!"".equals(rzfromdate)){
                                	sqlWhere += " and t1."+f_rzrq+" >= '"+rzfromdate+"'";
                                }
                                if(!"".equals(rztodate)){
                                	sqlWhere += " and t1."+f_rzrq+" <= '"+rztodate+"'";
                                }


//  右侧鼠标 放上可以点击
String  operateString= "";	
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+=	 "<col width=\"8%\"  text=\"申请日期\" column=\""+f_sbrq+"\" orderkey=\""+f_sbrq+"\"/>"+
                                             "<col width=\"8%\"  text=\"OA流程编号\" column=\""+f_oabh+"\" orderkey=\""+f_oabh+"\"  href=\"/workflow/request/ViewRequest.jsp\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"/>"+
                                             "<col width=\"5%\"  text=\"报销人\" column=\""+f_sqr+"\" orderkey=\""+f_sqr+"\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"所属一级部门\" column=\""+f_ssyjbm+"\" orderkey=\""+f_ssyjbm+"\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
                                             "<col width=\"10%\"  text=\"报销部门\" column=\""+f_sqbm+"\" orderkey=\""+f_sqbm+"\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
                                             "<col width=\"8%\"  text=\"申报金额\" column=\""+f_sbje+"\" orderkey=\""+f_sbje+"\" />"+
                                             "<col width=\"8%\"  text=\"实报金额\" column=\""+f_bxje+"\" orderkey=\""+f_bxje+"\" />"+
                                             "<col width=\"10%\"  text=\"节点名称\" column=\"nodename\" orderkey=\"nodename\" />"+
                                             "<col width=\"6%\"  text=\"归档标志\" column=\"currentnodetype\" orderkey=\"currentnodetype\" transmethod=\"tool.tools.getIsEnd\"/>"+
                                             "<col width=\"6%\"  text=\"导入标志\" column=\"ffdrbz\" orderkey=\"ffdrbz\" />"+
                                             "<col width=\"8%\"  text=\"是否生成凭证\" column=\""+f_sfscpz+"\" orderkey=\""+f_sfscpz+"\" transmethod=\"tool.tools.getPZ\"/>"+
                                             "<col width=\"6%\"  text=\"凭证号\" column=\""+f_pzh+"\" orderkey=\""+f_pzh+"\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="false" />

	<script type="text/javascript">
	
		function onSearch() {
			report.submit();
		}
		
	</script>
	</script>
			<SCRIPT language="javascript" src="/js/datetime.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>
