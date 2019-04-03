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

		li {float: left ;list-style: none; }
		</style>
	</head>
	<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String deptid = Util.null2String(request.getParameter("deptid")) ;
	String qname=Util.null2String(request.getParameter("flowTitle"));
    
    String flag = Util.null2String(request.getParameter("flag"));
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String departmentidpar = Util.null2String(request.getParameter("departmentid"));
	String isNormal = Util.null2String(request.getParameter("isNormal"));
	String isLeave = Util.null2String(request.getParameter("isLeave"));
	String isCard = Util.null2String(request.getParameter("isCard"));
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

				<wea:item>考勤日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="selectfromdate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 

			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('enddate','enddateSpan')"></BUTTON> 
            	 <SPAN id=enddateSpan><%=enddate%></SPAN> 
            	 <INPUT type="hidden" name="enddate" value="<%=enddate%>">
			     </wea:item>
                <wea:item>是否异常</wea:item>
				<wea:item>
				<select id="isNormal" name="isNormal">
						<option value=""></option>
						<option value="0" <%if("0".equals(isNormal)){%>selected<%}%>>正常</option>
						<option value="1" <%if("1".equals(isNormal)){%>selected<%}%>>异常</option>
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
		
		String backfields = " emp_id,atten_day,AmBeginTime,AmEndTime,PmBeginTime,PmEndTime,atten_start_time, "
		                   +" atten_end_time,not_times,late_times,early_leave_times,out_type,card_status,apply_date, "
		                   +" apply_time,case normal_status when 0 then '正常' else '异常' end as normal ";
		String fromSql  = " from sh_work_all_atten_info ";
		String sqlWhere = " where 1 = 1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " atten_day " ;
		String tableString = "";
		String  operateString= "";
        
        //员工姓名
        if(!"".equals(resourceid)){
			sqlWhere += "and emp_id ="+resourceid+" ";
		}
		//考勤部门										
		if(!"".equals(deptid)){
			sqlWhere += " and emp_id in (select id from HrmResource where departmentid = "+deptid+") ";
		}
		//考勤日期											
		if(!"".equals(fromdate)){
			sqlWhere +=" and atten_day>='"+fromdate+"' ";
				if(!"".equals(enddate)){
					sqlWhere +=" and atten_day <='"+enddate+"' ";
				}
		}else{
			if(!"".equals(enddate)){
				sqlWhere +=" and atten_day<='"+enddate+"' ";
			}
		}
        
        //是否正常
		if(!"".equals(isNormal)){
			sqlWhere += " and normal_status ="+isNormal+" ";
		}
        
        //是否外出
		//if(!"".equals(isLeave)){
			//sqlWhere += " and out_type ="+isLeave+" ";
		//}
        
        //是否忘打卡
		//if(!"".equals(isCard)){
			//if("0".equals(isCard)){
			    //sqlWhere += " and card_status in (1,2) ";
			//}else{
		       // sqlWhere += " and (card_status = 0 or card_status is null) ";
			//}
		//}
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		out.println("deptid="+deptid);

	    tableString =" <table tabletype=\"none\" pagesize=\"15\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"6%\" labelid=\"413\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"6%\" labelid=\"33456\" text=\"考勤日期\" column=\"atten_day\" orderkey=\"atten_day\" />"+
			"		<col width=\"6%\" labelid=\"-11\" text=\"上午开始时间\" column=\"AmBeginTime\" orderkey=\"AmBeginTime\" />"+
			"		<col width=\"6%\" labelid=\"-12\" text=\"上午结束时间\" column=\"AmEndTime\" orderkey=\"AmEndTime\" />"+
			"		<col width=\"6%\" labelid=\"-13\" text=\"下午开始时间\" column=\"PmBeginTime\" orderkey=\"PmBeginTime\"/>"+
			"		<col width=\"6%\" labelid=\"-14\" text=\"下午结束时间\" column=\"PmEndTime\" orderkey=\"PmEndTime\" />"+
			"		<col width=\"6%\" labelid=\"-6\" text=\"上班时间\" column=\"atten_start_time\" orderkey=\"atten_start_time\" />"+
			"		<col width=\"6%\" labelid=\"-7\" text=\"下班时间\" column=\"atten_end_time\" orderkey=\"atten_end_time\" />"+
			"		<col width=\"6%\" labelid=\"1924\" text=\"缺勤(min)\" column=\"not_times\" orderkey=\"not_times\" />"+
			"		<col width=\"6%\" labelid=\"34264\" text=\"迟到(min)\" column=\"late_times\" orderkey=\"late_times\"/>"+
			"		<col width=\"6%\" labelid=\"34265\" text=\"早退(min)\" column=\"early_leave_times\" orderkey=\"early_leave_times\" />"+
			"		<col width=\"6%\" labelid=\"31345\" text=\"外出\" column=\"out_type\" orderkey=\"out_type\"/>"+
			"		<col width=\"6%\" labelid=\"-23\" text=\"忘打卡\" column=\"card_status\" orderkey=\"card_status\"/>"+
			"		<col width=\"6%\" labelid=\"-22\" text=\"补卡日期\" column=\"apply_date\" orderkey=\"apply_date\" />"+
			"		<col width=\"6%\" labelid=\"-24\" text=\"补卡时间\" column=\"apply_time\" orderkey=\"apply_time\"/>"+
			"		<col width=\"6%\" labelid=\"24770\" text=\"是否异常\" column=\"normal\" orderkey=\"normal\"/>"+
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

		function doReadIt(requestid,otherpara,obj){
    //alert(otherpara);
    //alert(userid);
    var flag = "<%=flag%>";
    $.ajax({
        type: "GET",
        url: "",
        success:function(){
            if(flag == "newWf"){
                parent.window.location.href="";
            }else if(flag == "rejectWf"){
                parent.window.location.href="";
            }else if(flag == "overtime"){
                parent.window.location.href=""
            }else if(flag == "endWf"){
                parent.window.location.href="";
            }else{
                _table.reLoad();
            }
        }
    });
}

	</script>

	<!--以下是显示定制组件所需的js -->
<script type="text/javascript" src="/js/dragBox/parentShowcol_wev8.js"></script>

		<LINK href="/css/Weaver_wev8.css" type="text/css" rel=STYLESHEET>
		<link rel="stylesheet" href="/css/ecology8/request/requestView_wev8.css" type="text/css" />
		<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
		<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
		<script type="text/javascript">
		function taoHong(requestid,overtime,obj){
			openFullWindowHaveBarForWFList("/workflow/request/ViewRequest.jsp?viewdoc=1&seeflowdoc=1&requestid="+requestid+"&isovertime="+overtime,requestid);
		}
		
		function signNature(requestid,overtime,obj){
			openFullWindowHaveBarForWFList("/workflow/request/ViewRequest.jsp?viewdoc=1&seeflowdoc=1&requestid="+requestid+"&isovertime="+overtime,requestid);
		}
		function doEditContent(requestid,overtime,obj){
			openFullWindowHaveBarForWFList("/workflow/request/ViewRequest.jsp?viewdoc=1&seeflowdoc=1&requestid="+requestid+"&isovertime="+overtime,requestid);
		}
		
		var prePrimarykeys = null;
		var prePageNumber = -1;
		function afterDoWhenLoaded (p) {
			parent.window.__optkeys = "";
			var curPrimarykeys = _table.primarykeylist;
			if (prePageNumber == _table.nowPage) {
				if (!!prePrimarykeys && prePrimarykeys.length > 0 && !!curPrimarykeys && curPrimarykeys.length > 0) {
					var optkeys = "";	
					for (var _i=0; _i<prePrimarykeys.length; _i++) {
						if (curPrimarykeys.indexOf(prePrimarykeys[_i]) == -1) {
							optkeys += "," + prePrimarykeys[_i];
						}
					}
					if (optkeys.length > 1) {
						optkeys = optkeys.substr(1);
						parent.window.__optkeys = optkeys;
					}
				}
			} else {
				prePageNumber = _table.nowPage;
			}
			prePrimarykeys = curPrimarykeys;
			__hidloaddingblock();
			if (!!!p) return;
			var recordCount = p.recordCount;
			updateFatherVal(recordCount); 
		}
		
		function updateFatherVal(recordCount){
			parent.reloadLeftNum();
		}
		</script>
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>