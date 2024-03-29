<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%!
	//获取当前日期
	public String getNowDate(){   
   	 String temp_str="";   
    	Date dt = new Date();   
    	//最后的aa表示“上午”或“下午”    HH表示24小时制    如果换成hh表示12小时制   
    	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");     
    	temp_str=sdf.format(dt);   
    	return temp_str;   
	} 
%>

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

	//if("".equals(fromdate)) fromdate = getNowDate();
	//if("".equals(enddate)) enddate = getNowDate();

	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String isActive = Util.null2String(request.getParameter("isActive"));
	String standard = Util.null2String(request.getParameter("standard"));
	
	String outBack_pageId = "outBack_info";
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
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=outBack_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		if(isAdmin){
			RCMenu += "{"+SystemEnv.getHtmlLabelName(16211,user.getLanguage())+",javascript:invalidRecordBack(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;	
		}
		
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
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
				</brow:browser>
				</wea:item>

				<wea:item>考勤日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selectfromdate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 

			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('enddate','enddateSpan')"></BUTTON> 
            	 <SPAN id=enddateSpan><%=enddate%></SPAN> 
            	 <INPUT type="hidden" name="enddate" value="<%=enddate%>">
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
		
		String backfields = " ms.id,ms.operater,ms.operate_date,ms.operate_time,ms.address,ms.longitude,ms.latitude,ms.remark, "
		+" rt.EmployeeName,rt.ReplaceStartDate,rt.ReplaceStartTime,rt.ReplaceEndTime, "
		+" rt.client,rt.address as cAddress,rt.client_leave,rt.address_leave, "
		+" case rt.isActive when 1 then '无效' else '有效' end as active, "
		+" case rt.AttendanceStandard  when 0 then '上班不参与打卡' when 1 then '下班不参与打卡' when 2 then '上下班不参与打卡' else '' end as standard ";
		String fromSql  = " from mobile_sign ms left join uf_Replace_table rt on ms.operater = rt.EmployeeName and ms.operate_date = rt.ReplaceStartDate ";
		String sqlWhere = " ms.id in(select InvalidID from uf_Invalid_out where isActive=0) ";
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " ms.operate_date " ;
		String tableString = "";
		String  operateString= "";
        
		if(!isAdmin){
			sqlWhere += "and ms.operater ="+userid+" ";
		}else{
				//员工姓名
			if(!"".equals(resourceid)){
				sqlWhere += "and ms.operater ="+resourceid+" ";
			}
		}

        //考勤日期											
		if(!"".equals(fromdate)){
			sqlWhere +=" and ms.operate_date>='"+fromdate+"' ";
				if(!"".equals(enddate)){
					sqlWhere +=" and ms.operate_date <='"+enddate+"' ";
				}
		}else{
			if(!"".equals(enddate)){
				sqlWhere +=" and ms.operate_date<='"+enddate+"' ";
			}
		}
        
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(outBack_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+outBack_pageId+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"ms.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"5%\" labelid=\"413\" text=\"姓名\" column=\"operater\" orderkey=\"operater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"9%\" labelid=\"33563\" text=\"移动签到日期\" column=\"operate_date\" orderkey=\"operate_date\" />"+
			"		<col width=\"9%\" labelid=\"20035\" text=\"移动签到时间\" column=\"operate_time\" orderkey=\"operate_time\" />"+
			"		<col width=\"15%\" labelid=\"110\" text=\"地址\" column=\"address\" orderkey=\"address\" />"+
			"		<col width=\"9%\" labelid=\"20443\" text=\"备注\" column=\"remark\" orderkey=\"remark\"/>"+
			"		<col width=\"8%\" labelid=\"-10148\" text=\"前往客户或者政府\" column=\"client\" orderkey=\"client\" />"+
			"		<col width=\"15%\" labelid=\"-10557\" text=\"外勤上班地址\" column=\"cAddress\" orderkey=\"cAddress\"/>"+
			"		<col width=\"8%\" labelid=\"-10555\" text=\"离开客户或者政府\" column=\"client_leave\" orderkey=\"client_leave\" />"+
			"		<col width=\"15%\" labelid=\"-10556\" text=\"外勤下班地址\" column=\"address_leave\" orderkey=\"address_leave\"/>"+
			"		<col width=\"8%\" labelid=\"20059\" text=\"外出开始时间\" column=\"ReplaceStartTime\" orderkey=\"ReplaceStartTime\" />"+
			"		<col width=\"8%\" labelid=\"20061\" text=\"外出结束时间\" column=\"ReplaceEndTime\" orderkey=\"ReplaceEndTime\" />"+
			"		<col width=\"8%\" labelid=\"-9223\" text=\"考勤标准\" column=\"standard\" orderkey=\"standard\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
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
		
		function invalidRecordBack(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			/*if(confirm("确认恢复考勤记录？")) {
		
				report.action = "/seahonor/attend/jsp/RemoveRecordBack.jsp?id="+ids;
				report.submit();
			}*/
			Dialog.confirm("确认恢复考勤记录？", function (){
	        		report.action="/seahonor/attend/jsp/RemoveRecordBack_new.jsp?id="+ids;
					report.submit();
				}, function () {}, 320, 90,false);
		}
		
		//查看地图
		/*function showMap(id, uid, thisDate){
			parent.parent.location.href = "/hrm/HrmTab.jsp?_fromURL=mobileSignIn&showMap=true&id="+id+"&uid="+uid+"&thisDate="+thisDate;
		}
		href=\"javascript:this.showMap('sign9',operater,operate_date)\" 
		*/
		function showMap(id, uid, thisDate){
			var title = "";
			var url = "";
			title = "<%=SystemEnv.getHtmlLabelNames("82634",user.getLanguage())%>";
			url="/hrm/mobile/signin/mapView.jsp?id="+id+"&uid="+uid+"&thisDate="+thisDate;
		
			diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 600;
			diag_vote.Height = 400;
			diag_vote.maxiumnable = true;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.show();
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>