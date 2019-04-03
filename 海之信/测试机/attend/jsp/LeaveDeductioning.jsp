<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
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
	String departmentid_para = Util.null2String(request.getParameter("departmentid")) ;
	String relatedID = Util.null2String(request.getParameter("relatedID"));

	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String departmentidpar = Util.null2String(request.getParameter("departmentid"));
	String source = Util.null2String(request.getParameter("source"));
	String leaveType = Util.null2String(request.getParameter("leaveType"));
	
	int userid = user.getUID();
    Boolean isAdmin=false;
    String sql="";
    sql=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
    rs.executeSql(sql);
    if(rs.next()){
        int num_admin=rs.getInt("num_admin");
        if(num_admin>0){
            isAdmin=true;
        }
    }
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<!-- <div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/> -->
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{"+SystemEnv.getHtmlLabelName(25484,user.getLanguage())+",javascript:updateValid(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">

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
				    completeUrl="/data.jsp" width="150px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
				</brow:browser>
				</wea:item>

				<wea:item>进入日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selectfromdate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 
            	至
			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('enddate','enddateSpan')"></BUTTON> 
            	 <SPAN id=enddateSpan><%=enddate%></SPAN> 
            	 <INPUT type="hidden" name="enddate" value="<%=enddate%>">
			     </wea:item>
                <wea:item>类型</wea:item>
				<wea:item>
				<select id="leaveType" name="leaveType">
						<option value=""></option>
						<option value="0" <%if("0".equals(leaveType)){%>selected<%}%>>年假</option>
						<option value="1" <%if("1".equals(leaveType)){%>selected<%}%>>调休假</option>
				</select>
				</wea:item>
				<wea:item>来源</wea:item>
				<wea:item>
				<select id="source" name="source">
						<option value=""></option>
						<option value="0" <%if("0".equals(source)){%>selected<%}%>>年初发放</option>
						<option value="1" <%if("1".equals(source)){%>selected<%}%>>销假</option>
						<option value="2" <%if("2".equals(source)){%>selected<%}%>>加班</option>
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
		
		String backfields = " id,EmpName,Workcode,EnterDate,case LeaveType when 0 then '年假' else '调休假' end as LeaveTypeName, "
                           +" Source,case Source when 0 then '年初发放' when 1 then '销假' else '加班' end as sourceid, "
                           +" LeaveTime,isnull(LeaveTimeLeft,LeaveTime) as LeaveTimeLeft,ValidDate ";
		String fromSql  = " from uf_YearAdjust_leave ";
		String sqlWhere = " ValidDate >= CONVERT(varchar(10),getdate(),23) ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " EnterDate,EmpName " ;
		String tableString = "";
		String operateString= "";

		if(!isAdmin){
			sqlWhere += "and EmpName ="+userid+" ";
		}else{
			//员工姓名
        	if(!"".equals(resourceid)){
				sqlWhere += "and EmpName ="+resourceid+" ";
			}
		}
        
		//考勤部门										
		if(!"".equals(departmentidpar)){
			sqlWhere += " and emp_id in (select id from HrmResource where departmentid = "+departmentidpar+") ";
		}
		//进入日期											
		if(!"".equals(fromdate)){
			sqlWhere +=" and EnterDate>='"+fromdate+"' ";
				if(!"".equals(enddate)){
					sqlWhere +=" and EnterDate <='"+enddate+"' ";
				}
		}else{
			if(!"".equals(enddate)){
				sqlWhere +=" and EnterDate<='"+enddate+"' ";
			}
		}
        
        //来源
		if(!"".equals(source)){
			sqlWhere += " and Source ="+source+" ";
		}
        
        //类型
		if(!"".equals(leaveType)){
			sqlWhere += " and LeaveType ="+leaveType+" ";
		}
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"12%\" labelid=\"413\" text=\"姓名\" column=\"EmpName\" orderkey=\"EmpName\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"12%\" labelid=\"33456\" text=\"工号\" column=\"Workcode\" orderkey=\"Workcode\" />"+
			"		<col width=\"12%\" labelid=\"-11\" text=\"进入时间\" column=\"EnterDate\" orderkey=\"EnterDate\" />"+
			"		<col width=\"12%\" labelid=\"-12\" text=\"类型\" column=\"LeaveTypeName\" orderkey=\"LeaveTypeName\" />"+
			"		<col width=\"12%\" labelid=\"-13\" text=\"有效期\" column=\"ValidDate\" orderkey=\"ValidDate\"/>"+
			"		<col width=\"12%\" labelid=\"-14\" text=\"时间(小时)\" column=\"LeaveTime\" orderkey=\"LeaveTime\" />"+
			"		<col width=\"12%\" labelid=\"-6\" text=\"剩余时间(小时)\" column=\"LeaveTimeLeft\" orderkey=\"LeaveTimeLeft\" />"+
			"		<col width=\"12%\" labelid=\"-7\" text=\"来源\" column=\"sourceid\" orderkey=\"sourceid\" />"+
		"			</head>"+
	" </table>"; 
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
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
		
		function updateValid(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("id="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}else{
				var idArr = ids.split(",");
				//window.top.Dialog.alert("idArr.length="+idArr.length);
				if(idArr.length>2){
					window.top.Dialog.alert("一次只能修改一条数据！");	
					return false;
				}else{
					var id=idArr[0];
					//window.top.Dialog.alert("id="+id);
					Dialog.confirm("确认变更所选记录？", function (){
						//var slUrl = "/workflow/request/AddRequest.jsp?workflowid=105&field8386="+id;
						var slUrl = "/workflow/request/AddRequest.jsp?workflowid=105&field8611="+id;
						window.open(slUrl);
					}, function () {}, 320, 90,false);
				}
			}
			/*if(confirm("确认移除考勤记录？")) {
		
				report.action = "/seahonor/attend/jsp/RemoveRecord.jsp?id="+ids;
				report.submit();
			}*/
		}	
	</script>

	
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>