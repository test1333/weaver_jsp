<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
	int userid = user.getUID();
	String IPaddress = request.getRemoteAddr();
	//out.println("IPaddress="+IPaddress);
	String year_name = Util.null2String(request.getParameter("year_name"));
	String month_name = Util.null2String(request.getParameter("month_name"));
	String recipient = Util.null2String(request.getParameter("recipient"));
	String empid = Util.null2String(request.getParameter("emp_id"));
	String departmentid = Util.null2String(request.getParameter("departmentid"));
	String chkSubCompany=Util.null2o(request.getParameter("chkSubCompany"));//子分部是否包含
	String subcompanyid_para=Util.null2String(request.getParameter("subcompanyid1"));//分部
	String companyid_para = Util.null2String(request.getParameter("companyid")) ;
		if("0".equals(subcompanyid_para)) subcompanyid_para = "";
	String tmp_startdate = "";
	String tmp_enddate = "";
	
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String lenddate = Util.null2String(request.getParameter("lenddate"));
	
	Calendar cal = Calendar.getInstance();
	if (!"".equals(year_name) && !"".equals(month_name)) {
	cal.set(Integer.parseInt(year_name),Integer.parseInt(month_name)-1, 1);
	}else{
	cal.set(Calendar.DAY_OF_MONTH, 1);
	}
	if("".equals(year_name))   year_name  = Integer.toString(cal.get(Calendar.YEAR));
	if("".equals(month_name))   month_name  = Integer.toString(cal.get(Calendar.MONTH)+1);
	
	String bef_month = Integer.toString(Integer.parseInt(month_name)-1);
	String bef_year = Integer.toString(Integer.parseInt(year_name)-1);
	
	//out.println("bef_month="+bef_month);
	
	if("0".equals(bef_month)){
		bef_month = "12";
		tmp_startdate = bef_year + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
		tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25"; 
	}
	else{
		tmp_startdate = year_name + "-" + (bef_month.length()==1?"0"+bef_month:bef_month) + "-"+ "26";
		tmp_enddate = year_name + "-" + (month_name.length()==1?"0"+month_name:month_name) + "-"+ "25";
	}

	String sql="";
	if(userid!=1){
		sql=" select loginid,departmentid,workcode from HrmResource where id="+userid;
		rs.executeSql(sql);
		if(rs.next()){
			String loginid = Util.null2String(rs.getString("loginid"));
			String dept = Util.null2String(rs.getString("departmentid"));
			String workcode = Util.null2String(rs.getString("workcode"));
			sql = " insert into uf_salary_view_log(EMPID,LOGINID,VIEWTIME,DEPT,WORKCODE,IPADDRESS) "
			+" values("+userid+",'"+loginid+"',to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),"+dept+",'"+workcode+"','"+IPaddress+"') ";
			res.executeSql(sql);
		}
	}else{
		sql = " insert into uf_salary_view_log(EMPID,LOGINID,VIEWTIME,DEPT,WORKCODE,IPADDRESS) "
			+" values("+userid+",'sysadmin',to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),null,'','"+IPaddress+"') ";	
		res.executeSql(sql);
	}
	
	String leave_pageId = "holiday_info";
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
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
			<%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=leave_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
		    <INPUT type="hidden" id="startdate" name="startdate" value="<%=tmp_startdate%>">
			<INPUT type="hidden" id="enddate" name="enddate" value="<%=tmp_enddate%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
						</span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
						</span>
					</td>
				</tr>
			</table>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient%>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
				<wea:item>部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="departmentid" browserValue="<%=departmentid%>"
				browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/DepartmentBrowser.jsp?selectedids="
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="165px"
				linkUrl="/hrm/company/HrmDepartmentDsp.jsp?id="
				browserSpanValue="<%=DepartmentComInfo.getDepartmentname(departmentid)%>">
				</brow:browser>
				</wea:item>
				<wea:item>日期</wea:item>
				<wea:item>
				从
			    <button type="button" class=Calendar id="selectfromdate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle type="hidden" name="fromdate" value="<%=fromdate%>"> 
				至
			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('lenddate','enddateSpan')"></BUTTON> 
            	 <SPAN id=enddateSpan><%=lenddate%></SPAN> 
            	 <INPUT type="hidden" name="lenddate" value="<%=lenddate%>">
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
		String backfields = " xm,rq,bygzhj,jtmc,ck,id ";
		String fromSql  = " from uf_gongzidan ";
		String sqlWhere = " 1=1 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " rq,xm " ;
		String tableString = "";
		String operateString= "";
        
		/*if(!isAdmin){
			sqlWhere += "and applyuser ="+userid+" ";	
		}else{
			//员工姓名
			if(!"".equals(recipient)){
				sqlWhere += "and applyuser ="+recipient+" ";
			}
		}*/
		
		//员工姓名
			if(!"".equals(recipient)){
				sqlWhere += "and xm ="+recipient+" ";
			}
        

		//部门										
		 if(!"".equals(departmentid)){
		 	sqlWhere += " and xm in (select id from HrmResource where departmentid = "+departmentid+") ";
		}
		
		//请假日期											
		if(!"".equals(fromdate)){
			sqlWhere +=" and rq>='"+fromdate+"' ";
				if(!"".equals(lenddate)){
					sqlWhere +=" and rq <='"+lenddate+"' ";
				}
		}else{
			if(!"".equals(lenddate)){
				sqlWhere +=" and rq<='"+lenddate+"' ";
			}
		}
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid); href=\"javascript:ksyView();\"
		String url = "/formmode/view/AddFormMode.jsp?modeId=61&amp;formId=-20&amp;customid=102";

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(leave_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+leave_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"12%\" labelid=\"413\" text=\"姓名\" column=\"xm\" orderkey=\"xm\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"12%\" labelid=\"855\" text=\"日期\" column=\"rq\" orderkey=\"rq\" />"+
			"		<col width=\"12%\" labelid=\"24153\" text=\"本月工资合计\" column=\"bygzhj\" orderkey=\"bygzhj\" />"+
			"		<col width=\"12%\" labelid=\"24978\" text=\"津贴名称\" column=\"jtmc\" orderkey=\"jtmc\" />"+
			"		<col width=\"12%\" labelid=\"742\" text=\"查看\" column=\"ck\" orderkey=\"ck\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?modeId=61&amp;formId=-20&amp;customid=102\" target=\"_fullwindow\" />"+
		"			</head>"+
	" </table>"; 
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
	    function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}

		function onBtnSearchClick() {
			weaver.submit();
		}

		function firm(){
		        if(confirm("是否统计迟到时间？")){
		            weaver.action = "CountLate.jsp";
		            weaver.submit();
		        }
		
		    }

		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}

		function ksyView(obj){
			var _id = id;
			alert("id="+_id);
			openFullWindowHaveBarForWFList("/formmode/view/AddFormMode.jsp?modeId=61&formId=-20&customid=102&billid="+_id);
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>