<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%@page import="weaver.general.TimeUtil"%>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<%@page import="java.text.SimpleDateFormat" %>

<%
	int user_id = user.getUID();
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/jNice/jNice/jquery.jNice_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/wuiform/jquery.wuiform_wev8.js"></script>
<style>
.checkbox {
	display: none
}
</style>
</head>
<%!
public String  getStartDay(String source) {
		String startdate="";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal=Calendar.getInstance();  
        try {
            Date date1 = format.parse(source);
			
			cal.setTime(date1);
			cal.add(Calendar.MONTH,-1);
			date1=cal.getTime();  
			startdate=format.format(date1);
			
        } catch (Exception e) {
            e.printStackTrace();
        }
        return startdate;
}






%>



<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";
String workflowname = "";

String requestnamenew = Util.null2String(request.getParameter("requestnamenew"));
String gxbh = Util.null2String(request.getParameter("gxbh"));
String pc = Util.null2String(request.getParameter("pc"));
String requestid = Util.null2String(request.getParameter("requestid"));

String pan=Util.null2String(request.getParameter("pan"));


String MANDT  = Util.null2String(request.getParameter("MANDT"));
String LC_TYPE  = Util.null2String(request.getParameter("LC_TYPE"));
String REF_NO  = Util.null2String(request.getParameter("REF_NO"));  
String INDEX_NO  = Util.null2String(request.getParameter("INDEX_NO"));
String CRDATE  = Util.null2String(request.getParameter("CRDATE"));
String CRDATE1  = Util.null2String(request.getParameter("CRDATE1"));


String STATUS  = Util.null2String(request.getParameter("STATUS"));
String UPD_FLAG  = Util.null2String(request.getParameter("UPD_FLAG"));
String OA_DATE  = Util.null2String(request.getParameter("OA_DATE"));
String OA_DATE1  = Util.null2String(request.getParameter("OA_DATE1"));

String OA_ENDDATE  = Util.null2String(request.getParameter("OA_ENDDATE"));
String OA_ENDDATE1  = Util.null2String(request.getParameter("OA_ENDDATE1"));



String UPD_SUC  = Util.null2String(request.getParameter("UPD_SUC"));
String UPD_DATE  = Util.null2String(request.getParameter("UPD_DATE"));
String UPD_DATE1  = Util.null2String(request.getParameter("UPD_DATE1"));

String PERNR_F  = Util.null2String(request.getParameter("PERNR_F"));
String workflowid = Util.null2String(request.getParameter("workFlowId"));


SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
Calendar cal=Calendar.getInstance(); 
String enddate="";
try {
            Date date = cal.getTime();
		            
			enddate=format1.format(date);
	
        } catch (Exception e) {
            e.printStackTrace();
        }




if("".equals(OA_ENDDATE)&&"".equals(UPD_SUC)&&"".equals(OA_ENDDATE1)&&"".equals(pan)){
	OA_ENDDATE=getStartDay(enddate);
	OA_ENDDATE1=enddate;
	UPD_SUC="N";	
}



if(!"".equals(workflowid)){
	workflowname = Util.null2String(WorkflowComInfo.getWorkflowname(workflowid));
}

 int userid  = user.getUID();
String tmc_pageId = "zhang";
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
RCMenu += "{刷新,javascript:doRefresh(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	<FORM id=report name=report action="/appdevjsp/HQ/SAPOA/Achievements.jsp" method=post>
	
		<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
		<td class="rightSearchSpan">
			<input type="text" class="searchInput" name="namesimple" value="<%=requestnamenew%>"/>
			&nbsp;&nbsp;&nbsp;
			<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage()) %></span>&nbsp;&nbsp;
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage()) %>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
		<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
                <wea:item>标题</wea:item>
				<wea:item>
				 <input name="requestnamenew" id="requestnamenew" class="InputStyle" type="text" value="<%=requestnamenew%>"/>
				</wea:item>
				<wea:item>流程编号</wea:item>
				<wea:item>
				 <input name="requestid" id="requestid" class="InputStyle" type="text" value="<%=requestid%>"/>
				</wea:item>	
				<wea:item>客户端</wea:item>
				<wea:item>
				 <input name="MANDT" id="MANDT" class="InputStyle" type="text" value="<%=MANDT%>"/>
				</wea:item>	
				<wea:item>流程类型</wea:item>
				<wea:item>
				 <input name="LC_TYPE" id="LC_TYPE" class="InputStyle" type="text" value="<%=LC_TYPE%>"/>
				</wea:item>
				<wea:item>单据编号</wea:item>
				<wea:item>
				 <input name="REF_NO" id="REF_NO" class="InputStyle" type="text" value="<%=REF_NO%>"/>
				</wea:item>
				<wea:item>SAP流水号</wea:item>
				<wea:item>
				 <input name="INDEX_NO" id="INDEX_NO" class="InputStyle" type="text" value="<%=INDEX_NO%>"/>
				</wea:item> 
				<wea:item>创建日期 </wea:item>
				<wea:item>
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(CRDATE,CRDATEspan)"></BUTTON> 
            	<SPAN id=CRDATEspan><%=CRDATE%></SPAN>
            	<INPUT  type="hidden" name="CRDATE" value="<%=CRDATE%>">-- 
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(CRDATE1,CRDATEspan1)"></BUTTON> 
            	<SPAN id=CRDATEspan1><%=CRDATE1%></SPAN> 
            	<INPUT  type="hidden" name="CRDATE1" value="<%=CRDATE1%>"> 
				</wea:item> 
				<wea:item>单据状态 </wea:item>
				<wea:item>
				<select id="STATUS" name="STATUS"  >
					<option value="" ></option>
					<option value="N" <%if("N".equals(STATUS))  out.print("selected"); %>>已提交</option>
					<option value="Y" <%if("Y".equals(STATUS))  out.print("selected"); %>>审批中</option>
					<option value="F" <%if("F".equals(STATUS))  out.print("selected"); %>>同意</option>
					<option value="J" <%if("J".equals(STATUS))  out.print("selected"); %>>拒绝</option>
					<option value="T" <%if("T".equals(STATUS))  out.print("selected"); %> >退回修改</option>	
				</select> 
				</wea:item> 
				<wea:item>需要回传更新标示 </wea:item>
				<wea:item>
				<select id="UPD_FLAG" name="UPD_FLAG"   >
					<option value="" ></option>
					<option value="Y" <%if("Y".equals(UPD_FLAG))  out.print("selected"); %>>需要</option>
					<option value="N" <%if("N".equals(UPD_FLAG))  out.print("selected"); %> >不需要</option>
				</select> 
				</wea:item> 
				<wea:item>生成日期 </wea:item>
				<wea:item>
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_DATE,OA_DATEspan)"></BUTTON> 
            	<SPAN id=OA_DATEspan><%=OA_DATE%></SPAN>
            	<INPUT  type="hidden" name="OA_DATE" value="<%=OA_DATE%>">--
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_DATE1,OA_DATEspan1)"></BUTTON> 
            	<SPAN id=OA_DATEspan1><%=OA_DATE1%></SPAN> 
            	<INPUT  type="hidden" name="OA_DATE1" value="<%=OA_DATE1%>"> 
				
				
				</wea:item> 
				<wea:item>完成日期 </wea:item>
				<wea:item>
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_ENDDATE,OA_ENDDATEspan)"></BUTTON> 
            	<SPAN id=OA_ENDDATEspan><%=OA_ENDDATE%></SPAN>
            	<INPUT  type="hidden" name="OA_ENDDATE" value="<%=OA_ENDDATE%>">--
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(OA_ENDDATE1,OA_ENDDATEspan1)"></BUTTON> 
            	<SPAN id=OA_ENDDATEspan1><%=OA_ENDDATE1%></SPAN> 
            	<INPUT  type="hidden" name="OA_ENDDATE1" value="<%=OA_ENDDATE1%>"> 
				
				
				
				
				
				</wea:item>
				<wea:item>更新成功 </wea:item>
				<wea:item>
				<select id="UPD_SUC" name="UPD_SUC"  >
					<option value="" ></option>
					<option value="Y" <%if("Y".equals(UPD_SUC))  out.print("selected"); %>>成功</option>
					<option value="N" <%if("N".equals(UPD_SUC))  out.print("selected"); %> >不成功</option>
				</select> 
				</wea:item> 
				<wea:item>更新完成日期</wea:item>
				<wea:item>
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(UPD_DATE,UPD_DATEspan)"></BUTTON> 
            	<SPAN id=UPD_DATEspan><%=UPD_DATE%></SPAN>
            	<INPUT  type="hidden" name="UPD_DATE" value="<%=UPD_DATE%>">--
				<button type="button" class=Calendar id="SelectDate" onclick="gettheDate(UPD_DATE1,UPD_DATEspan1)"></BUTTON> 
            	<SPAN id=UPD_DATEspan1><%=UPD_DATE1%></SPAN> 
            	<INPUT  type="hidden" name="UPD_DATE1" value="<%=UPD_DATE1%>"> 
				
				
				
				</wea:item>     
				<wea:item>流程创建人</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="PERNR_F" browserValue="<%=PERNR_F%>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(PERNR_F),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
				<wea:item><%=SystemEnv.getHtmlLabelName(18104,user.getLanguage())%></wea:item>
				<wea:item>
			
				<!-- input id="workFlowId" class="wuiBrowser" name="workFlowId" _url="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp" _scroll="no" _callBack="" value="<%=workflowid %>" _displayText="<%=workflowname %>" _displayTemplate="" _required="yes"/ -->
				<brow:browser viewType="0" name="workFlowId" browserValue='<%= ""+workflowid %>'  
					browserUrl="/systeminfo/BrowserMain.jsp?mouldID=workflow&url=/workflow/workflow/WorkflowBrowser.jsp?showvalid=1"
					hasInput="true" isSingle="true" hasBrowser="true" isMustInput='1' hasAdd="false"  
					completeUrl="/data.jsp?type=workflowBrowser&isTemplate=0" linkUrl=""
					browserSpanValue='<%=workflowname %>' width='280px' _callBack="onShowWorkFlowSerach"></brow:browser>
					
				</wea:item>	
					
				</wea:group>
				
				
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="重置" class="e8_btn_cancel" onclick="resetSerch();"/>
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
     backfields = "d.OA_ENDDATE,d.MANDT,c.requestname,d.INDEX_NO,d.REF_NO,d.LC_TYPE, d.CRDATE|| ' '|| d.CRTIME  as hdate,c.requestid,c.workflowid ,(select lastname from hrmresource where id = c.creater) as hrname  ,(select workflowname from workflow_base where id= (select workflowid from workflow_requestbase where requestid =d.LC_NO )) as workname  "; 
	 fromSql  = " from ZOAT00020 d, workflow_requestbase c   ";
	 sqlWhere = " where  d.LC_NO=c.requestid  ";

	if(!"".equals(requestnamenew)){
		sqlWhere +=" and c.requestname like '%"+requestnamenew+"%'";
	}
	if(!"".equals(requestid)){
		sqlWhere +=" and c.requestid  like '%"+requestid+"%'";
	}
	
	if(!"".equals(MANDT)){
		sqlWhere +=" and d.MANDT  like '%"+MANDT+"%'";
	}
	
	if(!"".equals(LC_TYPE)){
		sqlWhere +=" and d.LC_TYPE  like '%"+LC_TYPE+"%'";
	}
	if(!"".equals(REF_NO)){
		sqlWhere +=" and d.REF_NO  like '%"+REF_NO+"%'";
	} 
	if(!"".equals(INDEX_NO)){
		sqlWhere +=" and d.INDEX_NO  like '%"+INDEX_NO+"%'";
	} 
	if(!"".equals(CRDATE)&&!"".equals(CRDATE1)){
		sqlWhere +=" and d.CRDATE >='"+CRDATE+"' and d.CRDATE<='"+CRDATE1+"'";
	}
	if(!"".equals(STATUS)){
		sqlWhere +=" and d.STATUS  like '%"+STATUS+"%'";
	}
	if(!"".equals(UPD_FLAG)){
		sqlWhere +=" and d.UPD_FLAG  like '%"+UPD_FLAG+"%'";
	}
	if(!"".equals(OA_DATE)&&!"".equals(OA_DATE1)){
		sqlWhere +=" and d.OA_DATE >='"+OA_DATE+"' and d.OA_DATE <='"+OA_DATE1+"'";
	}
	if(!"".equals(OA_ENDDATE)&&!"".equals(OA_ENDDATE1)){
		sqlWhere +=" and d.OA_ENDDATE  >='"+OA_ENDDATE+"'  and d.OA_ENDDATE  <='"+OA_ENDDATE1+"'";
	}
	if(!"".equals(UPD_SUC)){
		sqlWhere +=" and d.UPD_SUC  like '%"+UPD_SUC+"%'";
	}
	if(!"".equals(UPD_DATE)&&!"".equals(UPD_DATE1)){
		sqlWhere +=" and d.UPD_DATE >='"+UPD_DATE+"' and d.UPD_DATE <='"+UPD_DATE1+"'";
	}	
	if(!"".equals(PERNR_F)){
		sqlWhere +=" and d.PERNR_F  like '%"+PERNR_F+"%'";
	}	   
	if(!"".equals(workflowid)){
		sqlWhere +=" and d.LC_NO  in  (select requestid from workflow_requestbase where  workflowid = '"+workflowid+"')";
	}
	
	//out.print("select "+backfields+fromSql+sqlWhere);
	String orderby = " c.requestid " ;
	String tableString = "";
   //out.print("select "+backfields+fromSql+sqlWhere+" order by "+orderby);
//  右侧鼠标 放上可以点击
String  operateString= "";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
	"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"c.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+	
    operateString+
    "			<head>";
		tableString+="<col width=\"20%\" labelid=\"18104\" text=\"流程名称\" column=\"requestname\" orderkey=\"requestname\" linkvaluecolumn=\"requestid\" linkkey=\"requestid\" href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />"+
		"<col width=\"10%\"  text=\"工作流\" column=\"workname\" orderkey=\"workname\"/>"+
		"<col width=\"10%\"  text=\"流程类型  \" column=\"LC_TYPE\" orderkey=\"LC_TYPE\"/>"+
		"<col width=\"10%\"  text=\"SAP流水号\" column=\"INDEX_NO\" orderkey=\"INDEX_NO\"/>"+
		"<col width=\"10%\"  text=\"单据编号 \" column=\"REF_NO\" orderkey=\"REF_NO\"/>"+
		"<col width=\"10%\"  text=\"客户端 \" column=\"MANDT\" orderkey=\"MANDT\"/>"+
		
		
		"<col width=\"10%\"  text=\"创建人\" column=\"hrname\" orderkey=\"hrname\"/>"+
		"<col width=\"10%\"  text=\"创建时间\" column=\"hdate\" orderkey=\"hdate\"/>"+
		"<col width=\"10%\"  text=\"完成日期 \" column=\"OA_ENDDATE\" orderkey=\"OA_ENDDATE\"/>"+
	"          </head>"+
    " </table>";
	

%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
	function resetSerch(selector){
		jQuery('#searchInput',parent.document).val('');
		resetCondition(selector);
		//document.getElementById("select").options[0].removeAttribute("selected"); 
		
		
		document.getElementById("report").reset(); 	
	}
	
	function onShowWorkFlowSerach() {
	jQuery($GetEle("setbody")).attr("onbeforeunload", "");
	document.frmmain.operate.value = "reedit";
	document.frmmain.action="/appdevjsp/HQ/SAPOA/Achievements.jsp"
   	document.frmmain.submit()
}
	
	
	
	
	
	
	
	
        function onBtnSearchClick() {
			document.report.action="/appdevjsp/HQ/SAPOA/Achievements.jsp?pan='1'";
			report.submit();	
		 }
 function doRefresh()
{
	
	window.location="/appdevjsp/HQ/SAPOA/Achievements.jsp";
}
	</script>
	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>
