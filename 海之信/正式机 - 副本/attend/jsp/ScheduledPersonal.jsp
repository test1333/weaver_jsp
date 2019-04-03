
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%
//if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
   // response.sendRedirect("/notice/noright.jsp");
    //return;
//}
    String empid = Util.null2String(request.getParameter("id"));
    String sql="";
    String id = "";
        sql=" select modedatacreater,modedatacreatedate,modedatacreatetime,(select lastname from HrmResource where id =EmployeeName ) "
           +" as empName,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,EffectiveStartDate,EffectiveEndDate,EmployeeName  "
           +" from uf_Scheduling_table where  EmployeeName ="+empid+" order by EffectiveStartDate desc ";
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
//RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;

%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="">
<wea:layout attributes="{'expandAllGroup':'true'}">
	<div id="TimeDate">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("33604,1477,264",user.getLanguage())%>">
		<wea:item attributes="{'isTableList':'true'}">
			<wea:layout type="table" attributes="{'cols':'9','cws':'11%,11%,11%,11%,11%,11%,11%,11%,11%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
				<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-11,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-12,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-13,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-14,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-15,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(-16,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(882,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(1339,user.getLanguage())%></wea:item>
			    
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
			        String creater = Util.null2String(RecordSet.getString("modedatacreater"));
			        String createdate = Util.null2String(RecordSet.getString("modedatacreatedate"));
			        String createtime = Util.null2String(RecordSet.getString("modedatacreatetime"));
			        String empName = Util.null2String(RecordSet.getString("EmpName"));
			        String amBeginTime = Util.null2String(RecordSet.getString("AmBeginTime"));
			        String amEndTime = Util.null2String(RecordSet.getString("AmEndTime"));
			        String pmBeginTime = Util.null2String(RecordSet.getString("PmBeginTime"));
			        String pmEndTime = Util.null2String(RecordSet.getString("PmEndTime"));
			        String startDate = Util.null2String(RecordSet.getString("EffectiveStartDate"));
			        String endDate = Util.null2String(RecordSet.getString("EffectiveEndDate"));
			        String employeeName = Util.null2String(RecordSet.getString("EmployeeName"));
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id=<%=employeeName%>')><%=empName%></a></wea:item>
			     <wea:item><%=amBeginTime%>
			     </wea:item>
			     <wea:item>
			     <%=amEndTime%>
			     </wea:item>
			     <wea:item><%=pmBeginTime%>
			     </wea:item>
			     <wea:item>
			     <%=pmEndTime%>
			     </wea:item>
			     <wea:item><%=startDate%>
			     </wea:item>
			     <wea:item>
			     <%=endDate%>
			     </wea:item>
			     <wea:item><%=ResourceComInfo.getResourcename(creater)%>
			     </wea:item>
			     <wea:item>
			     <%=createdate%>&nbsp<%=createtime%>
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
</BODY>
</HTML>
