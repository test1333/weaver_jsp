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
	
	String out_pageId = "out_info";
	
	int userid = user.getUID();
	int before_n=0;
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
	
	Boolean isAdmin1=false;
	sql=" select count(id) as num_admin from HrmRoleMembers where roleid=66 and resourceid="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		int num_admin=rs.getInt("num_admin");
		if(num_admin>0){
			isAdmin1=true;
			before_n=1;
		}
	}
	Boolean isAdmin2=false;
	sql=" select count(id) as num_admin from HrmRoleMembers where roleid=67 and resourceid="+userid;
	rs.executeSql(sql);
	if(rs.next()){
		int num_admin=rs.getInt("num_admin");
		if(num_admin>0){
			isAdmin2=true;
			before_n=5;
		}
	}
	if(!isAdmin&&!isAdmin1&&!isAdmin2) {
    response.sendRedirect("/notice/noright.jsp") ;
    return ;
}
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		if(isAdmin){
			RCMenu += "{"+SystemEnv.getHtmlLabelName(20230,user.getLanguage())+",javascript:invalidRecord(),_self} " ;
			RCMenuHeight += RCMenuHeightStep ;	
		}
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">	
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
					</span>
					</td>
				</tr>
			</table>

			
		</FORM>
		<%
		String today_date=getNowDate();
		String backfields = " id,operater,operate_date,operate_date+' '+operate_time as op_time,address,ReplaceStartTime+'~'+ReplaceEndTime as out_time,ReplaceStartDate,weekday,client,cAddress,client_leave,address_leave,active,standard ";
		String fromSql  = " from sh_out_mobile_sign_all ";
		String sqlWhere = " 1=1 ";
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " operater,op_time " ;
		String tableString = "";
		String  operateString= "";
        
		if(isAdmin1||isAdmin2){
			sqlWhere+=" and operate_date between dbo.sh_next_n_workday(CONVERT(varchar(20),getdate(),23),"+before_n+")  and CONVERT(varchar(20),getdate(),23) ";
		}

		//if(isAdmin1){
			//sqlWhere+=" operate_date between dbo.sh_next_n_workday(CONVERT(varchar(20),getdate(),23),"+before_n+")  and CONVERT(varchar(20),getdate(),23) ";
		//}
		
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		
		operateString = " <operates>";
		operateString +="    <popedom transmethod=\"weaver.workflow.workflow.WFAgentTransMethod.getAgentOperation\" ></popedom> ";
		operateString +="     <operate  	href=\"javascript:onagentedit();\" text=\"查看历史记录\" otherpara=\"ct+column:id\" index=\"0\"/>";
		operateString +=" </operates>";
        
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\">"+
		    "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		tableString+="<col width=\"5%\" labelid=\"413\" text=\"姓名\" column=\"operater\" orderkey=\"operater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"5%\" labelid=\"18518\" text=\"星期\" column=\"weekday\" orderkey=\"weekday\" />"+
			"		<col width=\"8%\" labelid=\"20035\" text=\"签到时间\" column=\"op_time\" orderkey=\"op_time\" />"+
			"		<col width=\"15%\" labelid=\"125531\" text=\"签到地址\" column=\"address\" orderkey=\"address\" />"+
			"		<col width=\"7%\" labelid=\"20443\" text=\"备注\" column=\"remark\" orderkey=\"remark\"/>"+
			"		<col width=\"8%\" labelid=\"-10148\" text=\"前往客户或者政府\" column=\"client\" orderkey=\"client\" />"+
			"		<col width=\"15%\" labelid=\"-10557\" text=\"外勤上班地址\" column=\"cAddress\" orderkey=\"cAddress\"/>"+
			"		<col width=\"8%\" labelid=\"-10555\" text=\"离开客户或者政府\" column=\"client_leave\" orderkey=\"client_leave\" />"+
			"		<col width=\"15%\" labelid=\"-10556\" text=\"外勤下班地址\" column=\"address_leave\" orderkey=\"address_leave\"/>"+
			"		<col width=\"8%\" labelid=\"-10966\" text=\"外出时间\" column=\"out_time\" orderkey=\"out_time\" />"+
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
		
		function invalidRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			/*if(confirm("确认移除考勤记录？")) {
		
				report.action = "/seahonor/attend/jsp/RemoveRecord.jsp?id="+ids;
				report.submit();
			}*/
			Dialog.confirm("确认移除考勤记录？", function (){
	        		report.action="/seahonor/attend/jsp/RemoveRecord_new2.jsp?id="+ids;
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
		
		//编辑
		function onagentedit(id){
				dialog = new window.top.Dialog();
				dialog.currentWindow = window;
				var operate_id = id;
				//alert("operate_id="+operate_id);
				var url = "/seahonor/attend/jsp/SH_mobile_his.jsp?id="+operate_id;
				dialog.Title = "操作历史记录";
				dialog.Width = 600;
				dialog.Height =550;
				dialog.Drag = true;
				 
				dialog.URL = url;
				dialog.show();
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>