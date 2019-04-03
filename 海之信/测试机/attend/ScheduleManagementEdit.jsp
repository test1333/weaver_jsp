<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%!
	public String[] getEmpInfo(String emp_id){
	    RecordSet rs = new RecordSet();
	    BaseBean log = new BaseBean();
	    String[] arr = new String[6];

	    String sql = " select AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,EffectiveStartDate,isnull(EffectiveEndDate,'9999-01-01')as enddate"
	                +" from uf_Scheduling_table where isActive = 0 and EmployeeName =  "+emp_id;
	    rs.executeSql(sql);
	    //log.writeLog("sql___________" + sql);
	    if(rs.next()){
	        String amBeginTime = Util.null2String(rs.getString("AmBeginTime"));
	        String amEndTime = Util.null2String(rs.getString("AmEndTime"));
	        String pmBeginTime = Util.null2String(rs.getString("PmBeginTime"));
	        String pmEndTime = Util.null2String(rs.getString("PmEndTime"));
	        String effectiveStartDate = Util.null2String(rs.getString("EffectiveStartDate"));
	        String effectiveEndDate = Util.null2String(rs.getString("enddate"));
	        for(int i=0;i<arr.length;i++){
	            arr[0] = amBeginTime;
	            arr[1] = amEndTime;
	            arr[2] = pmBeginTime;
	            arr[3] = pmEndTime;
	            arr[4] = effectiveStartDate;
	            arr[5] = effectiveEndDate;
	        }  
	    }

		return arr;
	}
%>

<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
   // response.sendRedirect("/notice/noright.jsp");
    //return;
//}

String workcode="";
String amBeginTime = Util.null2String(request.getParameter("amBeginTime")); 
String amEndTime = Util.null2String(request.getParameter("amEndTime")); 
String pmBeginTime = Util.null2String(request.getParameter("pmBeginTime")); 
String pmEndTime = Util.null2String(request.getParameter("pmEndTime")); 
String effeStartDate = Util.null2String(request.getParameter("effeStartDate"));
String effeEndDate = Util.null2String(request.getParameter("effeEndDate")); 
String invalidDate = Util.null2String(request.getParameter("invalidDate"));
String isActive = Util.null2String(request.getParameter("isActive")); 
String subcompanyid1 = Util.null2String(request.getParameter("subcompanyid1"));//分部ID 
String departmentid = Util.null2String(request.getParameter("departmentid")); 

String sql="";
String id = "";
//out.print("departmentid="+departmentid);
sql=" select * from HrmResource where id not in(select EmployeeName from uf_Exclude_table) and status<5 ";
if(!"".equals(subcompanyid1)) sql = sql + " and subcompanyid1="+subcompanyid1;

if(!"".equals(departmentid)) sql = sql + " and departmentid="+departmentid;
%>

<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="ScheduleManagementOperation.jsp">
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<%if(HrmUserVarify.checkUserRight("AnnualLeave:All", user)){ %>
				<input type=button class="e8_btn_top" onclick="onSave();" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%>"></input>
				<input type=button class="e8_btn_top" onclick="BatchProcess();" value="<%=SystemEnv.getHtmlLabelName(21611,user.getLanguage())%>"></input>
			<%} %>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
<wea:layout attributes="{'expandAllGroup':'true'}">
	<wea:group context="<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>">
	<wea:item attributes="{'isTableList':'true'}">
	    <wea:layout type="table" attributes="{'cols':'8','cws':'12%,12%,12%,12%,12%,12%,12%,12%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead"></wea:item>
				<wea:item type="thead"></wea:item>
			    <wea:item type="thead">上午开始时间</wea:item>
			    <wea:item type="thead">上午结束时间</wea:item>
			    <wea:item type="thead">下午开始时间</wea:item>
			    <wea:item type="thead">下午结束时间</wea:item>
			    <wea:item type="thead">有效开始日期</wea:item>
			    <wea:item type="thead">有效结束日期</wea:item>
			    <wea:item></wea:item>
			    <wea:item><input type="button" value="同步" onclick="firm()"></wea:item>
			    <wea:item>
			     	<button type="button" class=Clock id="selectamBeginTime" onclick="onShowTime(amBeginTimeSpan,amBeginTime)"></BUTTON> 
            	<SPAN id=amBeginTimeSpan><%=amBeginTime%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHamBeginTimeAll" name="amBeginTime" value="<%=amBeginTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="selectamEndTime" onclick="onShowTime(amendTimeSpan,amEndTime)"></BUTTON>
              	<SPAN id="amendTimeSpan"><%=amEndTime%></SPAN>
              	<INPUT class=inputstyle type=hidden id="SHamEndTimeAll" name="amEndTime" value="<%=amEndTime%>">
			     </wea:item>
			      <wea:item>
			     	<button type="button" class=Clock id="selectpmBeginTime" onclick="onShowTime(pmBeginTimeSpan,pmBeginTime)"></BUTTON> 
            	<SPAN id=pmBeginTimeSpan><%=pmBeginTime%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHpmBeginTimeAll" name="pmBeginTime" value="<%=pmBeginTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="selectpmEndTime" onclick="onShowTime(pmendTimeSpan,pmEndTime)"></BUTTON>
              	<SPAN id="pmendTimeSpan"><%=pmEndTime%></SPAN>
              	<INPUT class=inputstyle type=hidden id="SHpmEndTimeAll" name="pmEndTime" value="<%=pmEndTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Calendar id="selecteffeStartDateAll" onclick="onshowVotingEndDate('effeStartDate','effeStartDateSpan')"></BUTTON> 
            	<SPAN id=effeStartDateSpan><%=effeStartDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHeffeStartDateAll" name="effeStartDate" value="<%=effeStartDate%>">  
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Calendar id="selecteffeEndDateAll" onclick="onshowVotingEndDate('effeEndDate','effeEndDateSpan')"></BUTTON> 
            	<SPAN id=effeEndDateSpan><%=effeEndDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="SHeffeEndDateAll" name="effeEndDate" value="<%=effeEndDate%>">  
			     </wea:item>
                 </wea:group>
	    </wea:layout>
	    </wea:item>
	</wea:group>
	<div id="TimeDate">
	<wea:group context="<%=SystemEnv.getHtmlLabelName(32765,user.getLanguage())%>">
		<wea:item attributes="{'isTableList':'true'}">
			<wea:layout type="table" attributes="{'cols':'8','cws':'12%,12%,12%,12%,12%,12%,12%,12%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(1933,user.getLanguage())%></wea:item>
			    <wea:item type="thead">上午开始时间</wea:item>
			    <wea:item type="thead">上午结束时间</wea:item>
			    <wea:item type="thead">下午开始时间</wea:item>
			    <wea:item type="thead">下午结束时间</wea:item>
			    <wea:item type="thead">有效开始日期</wea:item>
			    <wea:item type="thead">有效结束日期</wea:item>
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
			        id = Util.null2String(RecordSet.getString("id"));
			        String lastname = Util.null2String(RecordSet.getString("lastname"));
			        departmentid = Util.null2String(RecordSet.getString("departmentid"));
			        subcompanyid1 = Util.null2String(RecordSet.getString("subcompanyid1"));
			        workcode = Util.null2String(RecordSet.getString("workcode"));
			   	
			   	    // 6 位
			        String[] str = getEmpInfo(id);
			           amBeginTime = Util.null2String(str[0]);
			           amEndTime = Util.null2String(str[1]);
			           pmBeginTime = Util.null2String(str[2]);
			           pmEndTime = Util.null2String(str[3]);
			           effeStartDate = Util.null2String(str[4]);
			           effeEndDate = Util.null2String(str[5]);
			           //new BaseBean().writeLog("attend_sql___________" + amBeginTime);
			           //out.print("str.[0]="+amBeginTime);

			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id=<%=id%>')><%=lastname%></a></wea:item>
			     <wea:item><%=workcode%>
			     <INPUT type="hidden" name="workcode" value="<%=workcode%>">
			     <INPUT type="hidden" name="departmentid" value="<%=departmentid%>">
			     <INPUT type="hidden" name="subcompanyid" value="<%=subcompanyid1%>">
			     <INPUT type="hidden"  name="ids" value="<%=id%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="SHamBeginTime" onclick="onShowTime(amBeginTime<%=id%>Span,amBeginTime<%=id%>)"></BUTTON> 
            	    <SPAN id=amBeginTime<%=id%>Span><%=amBeginTime%></SPAN> 
            	    <INPUT class=inputstyle type="hidden" id="amBeginTime<%=id%>SH" name="amBeginTime<%=id%>" value="<%=amBeginTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="SHamEndTime" onclick="onShowTime(amEndTime<%=id%>Span,amEndTime<%=id%>)"></BUTTON>
              	    <SPAN id=amEndTime<%=id%>Span><%=amEndTime%></SPAN>
              	<INPUT class=inputstyle type=hidden id="amEndTime<%=id%>SH" name="amEndTime<%=id%>" value="<%=amEndTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="SHpmBeginTime" onclick="onShowTime(pmBeginTime<%=id%>Span,pmBeginTime<%=id%>)"></BUTTON> 
            	    <SPAN id=pmBeginTime<%=id%>Span><%=pmBeginTime%></SPAN> 
            	    <INPUT class=inputstyle type="hidden" id="pmBeginTime<%=id%>SH" name="pmBeginTime<%=id%>" value="<%=pmBeginTime%>">
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Clock id="SHpmEndTime" onclick="onShowTime(pmEndTime<%=id%>Span,pmEndTime<%=id%>)"></BUTTON>
              	        <SPAN id=pmEndTime<%=id%>Span><%=pmEndTime%></SPAN>
              	        <INPUT class=inputstyle type=hidden id="pmEndTime<%=id%>SH" name="pmEndTime<%=id%>" value="<%=pmEndTime%>">
			     </wea:item>
			     <wea:item>
			       <button type="button" class=Calendar id="SHeffeStartDate" onclick="onshowVotingEndDate('effeStartDate<%=id%>','effeStartDate<%=id%>Span')"></BUTTON> 
            	<SPAN id=effeStartDate<%=id%>Span><%=effeStartDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="effeStartDate<%=id%>SH" name="effeStartDate<%=id%>" value="<%=effeStartDate%>">  
			     </wea:item>
			     <wea:item>
			     	<button type="button" class=Calendar id="SHeffeEndDate" onclick="onshowVotingEndDate('effeEndDate<%=id%>','effeEndDate<%=id%>Span')"></BUTTON> 
            	<SPAN id=effeEndDate<%=id%>Span><%=effeEndDate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" id="effeEndDate<%=id%>SH" name="effeEndDate<%=id%>" value="<%=effeEndDate%>">
			     </wea:item>
			     
			  <%
			    }
			  %>
				</wea:group>
			</wea:layout>
		</wea:item>
	</wea:group>
	</div>
</wea:layout>
</form>
<script language=javascript>
function onSave(){
    frmmain.submit();
}

function firm(){

    if(confirm("是否确认同步？"))
    {
        sycal();
    }
    else
    {

    }
}

function BatchProcess(){
    document.frmmain.operation.value="batchprocess";
    frmmain.submit();
}

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/seahonor/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/seahonor/attend/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
