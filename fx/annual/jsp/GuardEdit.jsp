<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.conn.RecordSetDataSource"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />


<%

String requestId="";
String badgeNo = Util.null2String(request.getParameter("badgeNo"));
String quantity = Util.null2String(request.getParameter("quantity"));
String vehicleNo = Util.null2String(request.getParameter("vehicleNo"));
String issuedBy = Util.null2String(request.getParameter("issuedBy"));
String issuedTime = Util.null2String(request.getParameter("issuedTime"));
String receivedBy = Util.null2String(request.getParameter("receivedBy"));
String receivedTime = Util.null2String(request.getParameter("receivedTime"));
String reqids = Util.null2String(request.getParameter("id")); 
String info = Util.null2String(request.getParameter("idkey")); 

String sql="";
String tmp_reqids= reqids + "0";
	sql=" select requestId,Name,From2,Location,ID2,Tel1,Receiver,Dept,Tel2,Appointment,Subject,Date2,Time,visitingarea,badgeNo, "
		+" quantity,vehicleNo,issuedBy,issuedTime,receivedBy,receivedTime from formtable_main_91 where requestId in("+tmp_reqids+") ";

%>
<script language="JavaScript">
	<%if(info!=null && !"".equals(info)){

		if("0".equals(info)){%>
			top.Dialog.alert("登记成功！")
		<%}

		else if("1".equals(info)){%>
			top.Dialog.alert("登记失败,请填写时间！")
		<%}
	}%>
	</script>
<%    
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script language="javascript" src="/js/weaver_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="CountGuard.jsp">
<wea:layout attributes="{'expandAllGroup':'true'}">
	<wea:group context="访客信息">
	<wea:item attributes="{'isTableList':'true'}">
	    <wea:layout type="table" attributes="{'cols':'7','cws':'14%,14%,14%,14%,14%,14%,15%'}">
				<wea:group context="" attributes="{'groupDisplay':'none'}">
			    <wea:item type="thead">来客姓名</wea:item>
			    <wea:item type="thead">自何单位</wea:item>
			    <wea:item type="thead">地点</wea:item>
			    <wea:item type="thead">来客证件</wea:item>
			    <wea:item type="thead">联系方式</wea:item>
			    <wea:item type="thead">访何人</wea:item>
				<wea:item type="thead">部门</wea:item>
				<%
			    RecordSet.executeSql(sql);
			    if(RecordSet.next()){
			        requestId = Util.null2String(RecordSet.getString("requestId"));
			        String Name = Util.null2String(RecordSet.getString("Name"));
			        String From2 = Util.null2String(RecordSet.getString("From2"));
					String Location = Util.null2String(RecordSet.getString("Location"));
					String ID2 = Util.null2String(RecordSet.getString("ID2"));
					String Tel1 = Util.null2String(RecordSet.getString("Tel1"));
					String Receiver = Util.null2String(RecordSet.getString("Receiver"));
					String receiveName=ResourceComInfo.getResourcename(Receiver);
					String Dept = Util.null2String(RecordSet.getString("Dept"));
					String DeptName = DepartmentComInfo.getDepartmentname(Dept);
					badgeNo = Util.null2String(RecordSet.getString("badgeNo"));
					quantity = Util.null2String(RecordSet.getString("quantity"));
					vehicleNo = Util.null2String(RecordSet.getString("vehicleNo"));
					issuedBy = Util.null2String(RecordSet.getString("issuedBy"));
					issuedTime = Util.null2String(RecordSet.getString("issuedTime"));
					receivedBy = Util.null2String(RecordSet.getString("receivedBy"));
					receivedTime = Util.null2String(RecordSet.getString("receivedTime"));
				%>
			    <wea:item><%=Name%></wea:item>
			    <wea:item><%=From2%></wea:item>
			    <wea:item><%=Location%></wea:item>
			    <wea:item><%=ID2%></wea:item>
				<wea:item><%=Tel1%></wea:item>
			    <wea:item><%=receiveName%></wea:item>
				<wea:item><%=DeptName%></wea:item>
				<%
				}
				%>
                </wea:group>
	    </wea:layout>
	    </wea:item>
	</wea:group>
	
	<div>
	<wea:group context="门卫填写">
	</wea:group>
	</div>
</wea:layout>
<TABLE class=ViewForm>
		<COLGROUP> <COL width="15%"> <COL width="35%"><COL width="15%"> <COL width="35%"><TBODY>
                    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR>
                    <tr>
                      <td>胸卡号</td>
                      <td class=Field>
                      <input class=Inputstyle name="badgeNo" value="<%=badgeNo%>">
                      </td>
                      <td>领卡数量</td>
                      <td class=Field>
                        <INPUT type="hidden"  name="ids" value="<%=requestId%>">
					 <INPUT type="hidden"  name="id_old" value="<%=reqids%>">
					 <input class=Inputstyle maxLength=10 size=30 name="quantity" value="<%=quantity%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)">
                      </td>
                    </tr>
                    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR>
                    <tr>
                      <td>车号</td>
                      <td class=Field colSpan=3>
                        <input class=Inputstyle name="vehicleNo" value="<%=vehicleNo%>">
                      </td>
                      <td></td>
                      <td class=Field>
                      </td>
                    </tr>
                    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR>
                    <tr>
                      <td>发放人</td>
                      <td class=Field>
                        <input class=Inputstyle name="issuedBy" value="<%=issuedBy%>">
                      </td>
                      <td>时间</td>
                      <td class=Field>
                       <button type="button" class="Clock" id="selectissuedTime" onclick="onShowTime(issuedTimeSpan,issuedTime)"></button> 
            		<SPAN id="issuedTimeSpan"><%=issuedTime%></SPAN> 
            		<INPUT class=inputstyle type="hidden" id="issuedTimeID" name="issuedTime" value="<%=issuedTime%>">
                      </td>
                    </tr>
                    <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR>
                    <tr>
                      <td>收回人</td>
                      <td class=Field>
                      <input class=Inputstyle name="receivedBy" value="<%=receivedBy%>"></td>
                      <td>时间</td>
                      <td class=Field>
                      <button type="button" class=Clock id="selectreceivedTime" onclick="onShowTime(receivedTimeSpan,receivedTime)"></button> 
            		<SPAN id=receivedTimeSpan><%=receivedTime%></SPAN> 
            		<INPUT class=inputstyle type="hidden" id="receivedTimeID" name="receivedTime" value="<%=receivedTime%>">
					  </td>
                      <TR style="height: 2px"><TD class=Line colSpan=4></TD></TR>
                    </TBODY>
                  </TABLE>
</form>
<script language=javascript>
function onSave(){
	Dialog.confirm("确认登记？", function (){
		
		frmmain.submit();
		
	}, function () {}, 320, 90,false);
}

</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
