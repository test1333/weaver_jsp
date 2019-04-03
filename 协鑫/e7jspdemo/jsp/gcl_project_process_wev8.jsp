<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<style>
.sp1{
	display:inline-block;
	width:50%;
	height:20px;
	background:#0066CC;
	text-align:center;
	color:white;
	float: left;
    line-height: 20px;
    vertical-align: middle;
}

.sp2{
	display:inline-block;
	width:50%;
	height:20px;
	background:#97CBFF;
	text-align:center;
	color:white;
	float: left;
    line-height: 20px;
    vertical-align: middle;
}

</style>
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
	String departmentid = Util.null2String(request.getParameter("departmentid")) ;
	String qname=Util.null2String(request.getParameter("flowTitle"));

	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));

	String operDate = Util.null2String(request.getParameter("operDate"));

	//if("".equals(fromdate)) fromdate = getNowDate();
	//if("".equals(enddate)) enddate = getNowDate();

	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String isActive = Util.null2String(request.getParameter("isActive"));
	String standard = Util.null2String(request.getParameter("standard"));
	
	String out_pageId = "out_info";
	
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


	String projName = Util.null2String(request.getParameter("projName"));
	String projCode = Util.null2String(request.getParameter("projCode"));
	String projStatus = Util.null2String(request.getParameter("projStatus"));
	String projManager = Util.null2String(request.getParameter("projManager"));
	String projClient = Util.null2String(request.getParameter("projClient"));
	String projC_address = Util.null2String(request.getParameter("projC_address"));
	String projC_contactor = Util.null2String(request.getParameter("projC_contactor"));
	String projC_tel = Util.null2String(request.getParameter("projC_tel"));

	String sql_proj = " select id,projName,projCode,projStatus,projManager,projClient,projC_address,projC_contactor,projC_tel from uf_project_base where id=1 ";
	rs.executeSql(sql_proj);
	//out.print(sql_proj);
	if(rs.next()){
		projName = Util.null2String(rs.getString("projName"));
		projCode = Util.null2String(rs.getString("projCode"));
		projStatus = Util.null2String(rs.getString("projStatus"));
		projManager = Util.null2String(rs.getString("projManager"));
		projClient = Util.null2String(rs.getString("projClient"));
		projC_address = Util.null2String(rs.getString("projC_address"));
		projC_contactor = Util.null2String(rs.getString("projC_contactor"));
		projC_tel = Util.null2String(rs.getString("projC_tel"));
	}
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
				<%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %>
			</span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{查询,javascript:onBtnSearchClick(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report target="reportFrame" method=post>
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">	
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
					<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			<div>
				<table width="100%" rules="all" style="background:white;font-size: 9pt;border-collapse:collapse;" border="1px" bordercolor="#D3D3D3" cellspacing="1px">
					<colgroup>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col></col>
					</colgroup>
				
					<tr>
						<td class=Field>项目名称</td>
						<td class=Field><%=projName%></td>
						<td class=Field>项目编号</td>
						<td class=Field><%=projCode%></td>
						<td class=Field>项目状态</td>
						<td class=Field><%=projStatus%></td>
						<td class=Field>项目负责人</td>
						<td class=Field><%=projManager%></td>
					</tr>

					<tr>
						<td class=Field>客户名称</td>
						<td class=Field><%=projClient%></td>
						<td class=Field>公司地址</td>
						<td class=Field><%=projC_address%></td>
						<td class=Field>联系人</td>
						<td class=Field><%=projC_contactor%></td>
						<td class=Field>联系方式</td>
						<td class=Field><%=projC_tel%></td>
					</tr>
				</table>
			</div>

			<div>
				<table width="100%" rules="all" style="background:white;font-size: 9pt;border-collapse:collapse;" border="1px" bordercolor="#D3D3D3" cellspacing="1px">	
					<colgroup>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col></col>
					</colgroup>
				
					<tr>
						<td class=Field>整理初步设计方案</td>
						<td class=Field>搜集详细资料</td>
						<td class=Field>签订合作意向书</td>
						<td class=Field>设计详细方案</td>
						<td class=Field>签订合同</td>
						<td class=Field>归档</td>
					</tr>
				</table>
			</div>

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
  				<wea:item>所在部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="departmentid" browserValue="<%=departmentid%>"
				browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/DepartmentBrowser.jsp?selectedids="
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="165px"
				linkUrl="/hrm/company/HrmDepartmentDsp.jsp?id="
				browserSpanValue="<%=DepartmentComInfo.getDepartmentname(departmentid)%>">
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
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="autoSubmit();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				
				</wea:layout> 
			</div>
		</FORM>
	<%
		//select rwmc,fzr,xgwd,xglc,sfkx,sfkxyj,tjrq from uf_project_base_dt1
		String backfields = " id,rwmc,fzr,xgwd,xglc,sfkx,sfkxyj,tjrq ";
		String fromSql  = " from uf_project_base_dt1 ";
		String sqlWhere = " where 1=1 ";
		//out.println("select "+ backfields + fromSql +"where"+ sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " id " ;
		String tableString = "";
		String  operateString= "";

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
        
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"13%\" labelid=\"25034\" text=\"任务名称\" column=\"rwmc\" orderkey=\"rwmc\" />"+
			"		<col width=\"13%\" labelid=\"33456\" text=\"负责人\" column=\"fzr\" orderkey=\"fzr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"13%\" labelid=\"-9321\" text=\"相关文档\" column=\"xgwd\" orderkey=\"xgwd\" />"+
			"		<col width=\"13%\" labelid=\"-9320\" text=\"相关流程\" column=\"xglc\" orderkey=\"xglc\" />"+
			"		<col width=\"13%\" labelid=\"-9319\" text=\"是否可行\" column=\"sfkx\" orderkey=\"sfkx\"/>"+
			"		<col width=\"13%\" labelid=\"-9318\" text=\"是否可行性意见\" column=\"sfkxyj\" orderkey=\"sfkxyj\" />"+
			"		<col width=\"13%\" labelid=\"-9222\" text=\"提交日期\" column=\"tjrq\" orderkey=\"tjrq\" />"+
			"		<col width=\"13%\" labelid=\"-9221\" text=\"id\" column=\"id\" orderkey=\"id\" />"+
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
		
		function invalidRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			Dialog.confirm("确认该考勤记录有效？", function (){
	        		report.action="/seahonor/attend/jsp/sh_removeRecord.jsp?id="+ids+"&optype=0";
					report.submit();
				}, function () {}, 320, 90,false);
		}	

		function removeRecord(){
			var ids = _xtable_CheckedCheckboxId();
			//alert("ids="+ids);
			if(ids == ""){
				window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(19689,user.getLanguage())%>");
				return false;
			}
			Dialog.confirm("确定移除该考勤记录？", function (){
	        		report.action="/seahonor/attend/jsp/sh_removeRecord.jsp?id="+ids+"&optype=1";
					report.submit();
				}, function () {}, 320, 90,false);
		}
		//查看地图
		/*function showMap(id, uid, thisDate){
			parent.parent.location.href = "/hrm/HrmTab.jsp?_fromURL=mobileSignIn&showMap=true&id="+id+"&uid="+uid+"&thisDate="+thisDate;
		}
		href=\"javascript:this.showMap('sign9',operater,operate_date)\"
		*/
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

		//cjkEncode方法的实现代码，放在网页head中或者用户自己的js文件中
		function cjkEncode(text) {                                                                          
			if (text == null) {       
				return "";       
			}       
			var newText = "";       
			for (var i = 0; i < text.length; i++) {       
				var code = text.charCodeAt (i);        
				if (code >= 128 || code == 91 || code == 93) {  //91 is "[", 93 is "]".       
					newText += "[" + code.toString(16) + "]";       
				} else {       
					newText += text.charAt(i);       
				}       
			}       
			return newText;       
		}   

		function autoSubmit() {
		var resourceid = document.getElementById('resourceid').value; //获取文本控件的值
		//alert("resourceid="+resourceid);
		//var row = document.getElementById('row').value; //获取下拉框控件的值
		//拼接出最终报表访问路径，并对完整的路径进行编码转换，防止乱码问题
		var reportURL = cjkEncode("http://58.247.6.130:8075/WebReport/ReportServer?reportlet=monthHoliday02.cpt&__pi__=false&emp_id="+resourceid);
		//alert("reportURL="+reportURL);
		//var reportURL = cjkEncode("../ReportServer?reportlet=/demo/parameter/number1.cpt¶=" + num + "&row=" + row);
		document.report.action = reportURL; //通过form的name获取表单，并将报表访问路径赋给表单的action
		document.report.submit(); //触发表单提交事件
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>