
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="JobActivitiesComInfo" class="weaver.hrm.job.JobActivitiesComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%
if(!HrmUserVarify.checkUserRight("AnnualLeave:All", user)){
    response.sendRedirect("/notice/noright.jsp");
    return;
}
String cmd = Util.null2String(request.getParameter("cmd"));
int subcompanyid=Util.getIntValue(request.getParameter("subCompanyId"));//分部
int departmentid = Util.getIntValue(request.getParameter("departmentid"));//部门
int message = Util.getIntValue(request.getParameter("message"),-1);
String annualyear = Util.null2String(request.getParameter("annualyear"));
String tempyear = annualyear;
String tempannualyear = annualyear+"-12-31";
String showname="";
String sql="";
if(departmentid>0){
   subcompanyid=Util.getIntValue(DepartmentComInfo.getSubcompanyid1(""+departmentid));
   showname=DepartmentComInfo.getDepartmentname(""+departmentid)+"<b>("+SystemEnv.getHtmlLabelName(124,user.getLanguage())+")</b>";
   //edit by shaw 20160518 start
   //sql = "select * from (select workcode,id,lastname,subcompanyid1,departmentid,jobtitle,dsporder,startdate,enddate from hrmresource where departmentid = " + departmentid + "  and (status = 0 or status = 1 or status = 2 or status = 3) and status != 10) a left join hrmannualmanagement b on a.id = b.resourceid and annualyear = '" + tempyear + "' order by dsporder,lastname,a.id";
   
   sql = "select * from (select workcode,id,lastname,subcompanyid1,departmentid,jobtitle,dsporder,startdate,enddate from hrmresource where departmentid = " + departmentid + "  and (status = 0 or status = 1 or status = 2 or status = 3) and status != 10) a left join uf_holiday_apply b on a.id = b.applyuser and b.enddate = '" + tempannualyear + "' order by dsporder,lastname,a.id";
   //edit by shaw 20160518 end
}else{
   showname=SubCompanyComInfo.getSubCompanyname(""+subcompanyid)+"<b>("+SystemEnv.getHtmlLabelName(141,user.getLanguage())+")</b>";
   //edit by shaw 20160518 start
   //sql = "select * from (select workcode,id,lastname,subcompanyid1,departmentid,jobtitle,dsporder,startdate,enddate from hrmresource where 1=1 "+((cmd.length()==0||subcompanyid==-1)?"":("and subcompanyid1 = " + subcompanyid))+" and (status = 0 or status = 1 or status = 2 or status = 3) and status != 10) a left join hrmannualmanagement b on a.id = b.resourceid and annualyear = '" + tempyear + "' order by dsporder,lastname,a.id";
   
   sql = "select * from (select workcode,id,lastname,subcompanyid1,departmentid,jobtitle,dsporder,startdate,enddate from hrmresource where 1=1 "+((cmd.length()==0||subcompanyid==-1)?"":("and subcompanyid1 = " + subcompanyid))+" and (status = 0 or status = 1 or status = 2 or status = 3) and status != 10) a left join uf_holiday_apply b on a.id = b.applyuser and b.enddate = '" + tempannualyear + "' order by dsporder,lastname,a.id";
   //edit by shaw 20160518 end
}

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
RCMenu += "{"+SystemEnv.getHtmlLabelName(21611,user.getLanguage())+",javascript:BatchProcess(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(21602,user.getLanguage())+SystemEnv.getHtmlLabelName(18596,user.getLanguage())+",javascript:onImport(),_self} " ;
//RCMenuHeight += RCMenuHeightStep;
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:goBack(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="AnnualManagementOperation.jsp">
<input class=inputstyle type="hidden" name="method" value="">
<input class=inputstyle type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="subCompanyId" value="<%=subcompanyid%>">
<input type="hidden" name="departmentid" value="<%=departmentid%>">
<input type="hidden" name="annualyear" value="<%=annualyear%>">
<input type="hidden" name="operation" value="edit">
<%if(message==12){%>
<span><font color='red'><%=SystemEnv.getHtmlLabelName(21612,user.getLanguage())%></font></span>
<%}%>
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
	<wea:group context='<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>'>
    <wea:item><%=SystemEnv.getHtmlLabelName(21602,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(445,user.getLanguage())%></wea:item>
    <wea:item><%=annualyear%></wea:item>
    <%--<wea:item><%=SystemEnv.getHtmlLabelName(16455,user.getLanguage())%></wea:item>
    <wea:item><SPAN id=jobtitlespan><%=showname%></SPAN></wea:item>--%>
	</wea:group>
	<wea:group context='<%=SystemEnv.getHtmlLabelName(21602,user.getLanguage())+SystemEnv.getHtmlLabelName(87,user.getLanguage())%>'>
		<wea:item attributes="{'isTableList':'true'}">
			<wea:layout type="table" attributes="{'cols':'5','cws':'20%,20%,20%,20%,20%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
					<wea:item type="thead"><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelNames("33611,15878",user.getLanguage())%></wea:item>
			    <wea:item type="thead"><%=SystemEnv.getHtmlLabelName(21811,user.getLanguage())%></wea:item>
					<%
			    RecordSet.executeSql(sql);
			    while(RecordSet.next()){
			        String id = RecordSet.getString("id");
			        String lastname = RecordSet.getString("lastname");
			        String tempsubcompanyid = RecordSet.getString("subcompanyid1");
			        String tempdepartmentid = RecordSet.getString("departmentid");
			        String jobtitle = RecordSet.getString("jobtitle");
					String workStartDate = Tools.vString(RecordSet.getString("startdate"));
					String workyear = "0.0";
					if(Tools.isNotNull(workStartDate)){
						String[] currentDate = Tools.getCurrentDate().split("-");
						//double _wy = Tools.round((double)Tools.compDate(workStartDate, tempyear + "-" + currentDate[1] + "-" + currentDate[2])/(double)365, 1);
						double _wy = Tools.round(Tools.compDate(workStartDate, tempyear + "-" + currentDate[1] + "-" + currentDate[2])/365, 1);
						if(_wy < 0){
							_wy = 0;
						}
						workyear = String.valueOf(_wy);
					}
					//edit by shaw 20160518 start
        			//String tempannualdays = Util.null2String(RecordSet.getString("annualdays"));
					String tempannualdays = Util.null2String(RecordSet.getString("applydays"));
					//edit by shaw 20160518 end
			
			    if(departmentid>0){
			       if(!tempdepartmentid.equals(departmentid+"")) continue;
			    }else{
					if(cmd.length()!=0&&subcompanyid!=-1){
						if(!tempsubcompanyid.equals(subcompanyid+"")) continue;
					}
			    }
			   
			    if(jobtitle.equals("")) continue;
			  %>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id=<%=id%>')><%=lastname%></a></wea:item>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/company/HrmDepartment.jsp?subcompanyid=<%=tempsubcompanyid%>')><%=SubCompanyComInfo.getSubCompanyname(tempsubcompanyid)%></a></wea:item>
			     <wea:item><a href=javascript:this.openFullWindowForXtable('/hrm/company/HrmDepartmentDsp.jsp?id=<%=tempdepartmentid%>')><%=DepartmentComInfo.getDepartmentname(tempdepartmentid)%></a></wea:item>
			     <wea:item><%=workyear%></wea:item>
			     <wea:item>
			     	<input type=text size=4 class=inputstyle name=annualdays value="<%=Util.getFloatValue(tempannualdays,0)%>">
			     	<input type=hidden size=4 class=inputstyle name=resourceid value="<%=id%>">
			     </wea:item>
			  <%
			    }
			  %>
				</wea:group>
			</wea:layout>
		</wea:item>
	</wea:group>
</wea:layout>
</form>
<script language=javascript>
function onSave(){
    frmmain.submit();
}
function goBack(){
    frmmain.action="AnnualManagementView.jsp?subCompanyId=<%=subcompanyid%>&departmentid=<%=departmentid%>";
    frmmain.submit();
}
function BatchProcess(){
    document.frmmain.operation.value="batchprocess";
    frmmain.submit();
}
function onImport(){
    location="AnnualManagementImport.jsp?annualyear=<%=annualyear%>&subCompanyId=<%=subcompanyid%>&departmentid=<%=departmentid%>";
}
</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</HTML>
