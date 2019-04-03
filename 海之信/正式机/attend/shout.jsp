<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%!
// JSP中的方法
public static String CreateTmpOnlineUserId(	RecordSet rs ,ArrayList<String> onlineuserids)throws Exception
{
String userids = "";
rs.execute("delete from TmpOnlineUserId");

for(int i=0;onlineuserids!=null&&i<onlineuserids.size();i++){
rs.execute("INSERT INTO TmpOnlineUserId VALUES ("+onlineuserids.get(i)+")");
}
return userids;
}
%>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String departmentid_para = Util.null2String(request.getParameter("departmentid")) ;
	String qname=Util.null2String(request.getParameter("flowTitle"));

	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String isActive = Util.null2String(request.getParameter("isActive"));
	String standard = Util.null2String(request.getParameter("standard"));
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
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<!--<input type="text" class="searchInput" name="flowTitle" value="<%=qname %>" />-->		
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
					</span>
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
					</span>
					</td>
				</tr>
			</table>

			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="resourceid" browserValue="<%=resourceid %>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
				</brow:browser>
				</wea:item>

				<wea:item>替代开始日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selectfromdate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 

			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('enddate','enddateSpan')"></BUTTON> 
            	 <SPAN id=enddateSpan><%=enddate%></SPAN> 
            	 <INPUT type="hidden" name="enddate" value="<%=enddate%>">
			     </wea:item>
			     <wea:item>考勤标准</wea:item>
				<wea:item>
				<select id="standard" name="standard">
						<option value=""></option>
						<option value="0" <%if("0".equals(standard)){%>selected<%}%>>上班不参与设备考勤</option>
						<option value="1" <%if("1".equals(standard)){%>selected<%}%>>下班不参与设备考勤</option>
						<option value="2" <%if("1".equals(standard)){%>selected<%}%>>上下班不参与设备考勤</option>
				</select>
				</wea:item>
                <wea:item>是否有效</wea:item>
				<wea:item>
				<select id="isActive" name="isActive">
						<option value=""></option>
						<option value="0" <%if("0".equals(isActive)){%>selected<%}%>>有效</option>
						<option value="1" <%if("1".equals(isActive)){%>selected<%}%>>无效</option>
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
		
		String backfields = " id,EmployeeName,ReplaceStartDate,ReplaceEndDate,ReplaceStartTime,ReplaceEndTime,"
		                    +" case isActive when 1 then '无效' else '有效' end as active,"
		                    +" case AttendanceStandard  when 0 then '上班不参与打卡' when 1 then '下班不参与打卡' when 2 then '上下班不参与打卡' else '' end as standard ";
		String fromSql  = " from uf_Replace_table ";
		String sqlWhere = " where 1 = 1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " ReplaceStartDate " ;
		String tableString = "";
		String  operateString= "";
        
        //员工姓名
        if(!"".equals(resourceid)){
			sqlWhere += "and EmployeeName ="+resourceid+" ";
		}

        //考勤日期											
		if(!"".equals(fromdate)){
			sqlWhere +=" and ReplaceStartDate>='"+fromdate+"' ";
				if(!"".equals(enddate)){
					sqlWhere +=" and ReplaceStartDate <='"+enddate+"' ";
				}
		}else{
			if(!"".equals(enddate)){
				sqlWhere +=" and ReplaceStartDate<='"+enddate+"' ";
			}
		}
        
        //是否有效
		if(!"".equals(isActive)){
			sqlWhere += " and isActive ="+isActive+" ";
		}
        
        //考勤标准
		if(!"".equals(standard)){
			sqlWhere += " and AttendanceStandard ="+standard+" ";
		}


	    tableString =" <table tabletype=\"none\" pagesize=\"15\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"EmployeeName\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"10%\" labelid=\"413\" text=\"姓名\" column=\"EmployeeName\" orderkey=\"EmployeeName\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"10%\" labelid=\"20058\" text=\"外出开始日期\" column=\"ReplaceStartDate\" orderkey=\"ReplaceStartDate\" />"+
			"		<col width=\"10%\" labelid=\"20060\" text=\"外出结束日期\" column=\"ReplaceEndDate\" orderkey=\"ReplaceEndDate\" />"+
			"		<col width=\"10%\" labelid=\"20059\" text=\"外出开始时间\" column=\"ReplaceStartTime\" orderkey=\"ReplaceStartTime\" />"+
			"		<col width=\"10%\" labelid=\"20061\" text=\"外出结束时间\" column=\"ReplaceEndTime\" orderkey=\"ReplaceEndTime\"/>"+
			"		<col width=\"10%\" labelid=\"-5\" text=\"考勤标准\" column=\"standard\" orderkey=\"standard\" />"+
			"		<col width=\"10%\" labelid=\"15591\" text=\"是否有效\" column=\"active\" orderkey=\"active\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
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
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>