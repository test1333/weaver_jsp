<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
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
	
	int userid = user.getUID();//获取当前登录用户的ID
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String recipient = Util.null2String(request.getParameter("recipient"));
	String options = Util.null2String(request.getParameter("options"));
	
	Boolean isAdmin=false;
    String sql="";
    sql=" select count(id) as num_admin from HrmRoleMembers where roleid=36 and resourceid="+userid;
    res.executeSql(sql);
    if(res.next()){
        int num_admin=res.getInt("num_admin");
        if(num_admin>0){
            isAdmin=true;
        }
    }
	if(!isAdmin) {
		response.sendRedirect("/notice/noright.jsp") ;
		return ;
	}

	String late_pageId = "late_info";

	sql = " select id,departmentid,workcode,telephone,mobile from HrmResource where id not in(select  EmployeeName  from uf_Exclude_table) ";					
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;//添加鼠标右键菜单：527为数据库中HtmlLableIndex表中对应的id，可通过id值获取显示的内容
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<INPUT type="hidden" id="startdate" name="startdate" value="">
			<INPUT type="hidden" id="enddate" name="enddate" value="">
			
			<div>
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>检查日期</wea:item>
				<wea:item>
			    <button type="button" class=Calendar id="fromdatedate" onclick="onshowVotingEndDate('fromdate','fromdateSpan')"></BUTTON> 
            	<SPAN id=fromdateSpan><%=fromdate%></SPAN> 
            	<INPUT class=inputstyle id="searchInput" type="hidden" name="fromdate" value="<%=fromdate%>"> 
				<!--至
			    <button type="button" class=Calendar id="selectenddate" onclick="onshowVotingEndDate('enddate','enddateSpan')"></BUTTON> 
            		<SPAN id=enddateSpan><%=enddate%></SPAN> 
            		<INPUT type="hidden" name="enddate" value="<%=enddate%>">-->
			    </wea:item>
				</wea:group>
				</wea:layout>
			</div>
		<%
			/*if("".equals(fromdate)){
				sql += " and dbo.sh_absent_emp(id,convert(varchar(10),GETDATE(),23))=0  "; 
			}else{
				sql += " and dbo.sh_absent_emp(id,'"+fromdate+"')=0 ";
			}*/

			if("".equals(fromdate)){
				sql += " and id in(select emp_id from dbo.sh_absent_list(convert(varchar(10),GETDATE(),23)))  "; 
			}else{
				sql += " and id in(select emp_id from dbo.sh_absent_list('"+fromdate+"')) ";
			}
			sql += " order by departmentid ";
			//out.print(sql);
			res.executeSql(sql);
		%>
		<wea:layout attributes="{'expandAllGroup':'true'}">
			<div id="outPlan">
				<wea:group context="旷工列表">
					<wea:item attributes="{'isTableList':'true'}">
						<wea:layout type="table" attributes="{'cols':'5','cws':'20%,20%,20%,20%,20%'}">
							<wea:group context="" attributes="{'groupDisplay':'none'}">
								<wea:item type="thead">所在部门</wea:item>
								<wea:item type="thead">员工姓名</wea:item>
								<wea:item type="thead">员工工号</wea:item>
								<wea:item type="thead">固定电话</wea:item>
								<wea:item type="thead">手机号码</wea:item>
								
								<%
								while(res.next()){
									String emp_id = Util.null2String(res.getString("id"));
									String dept = Util.null2String(res.getString("departmentid"));
									String workcode = Util.null2String(res.getString("workcode"));
									String telephone = Util.null2String(res.getString("telephone"));
									String mobile = Util.null2String(res.getString("mobile"));
									
								
								%>
								<wea:item><%=DepartmentComInfo.getDepartmentname(dept)%></wea:item>
								<wea:item><%=ResourceComInfo.getResourcename(emp_id)%></wea:item>
								<wea:item><%=workcode%></wea:item>
								<wea:item><%=telephone%></wea:item>
								<wea:item><%=mobile%></wea:item>
								<%
								}
								%>
							</wea:group>
						</wea:layout>
					</wea:item>
				</wea:group>
			</div>
		</wea:layout>

		</FORM>
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
		
		function firm(){
			Dialog.confirm("确定修改?", function (){
	        		report.action="/seahonor/attend/jsp/reDoAttend.jsp";
					report.submit();
				}, function () {}, 320, 90,false);
		
		}
		//下拉项触发事件
		function changeRange(obj){
			//alert("obj="+$(obj).val());
			if($(obj).val()==0){
	    		//$("#leaveApply").css("display","none");
				$("#outPlan").removeAttr("style");
			}
			else if($(obj).val()==1){
				//$("#leaveApply").css("display","none");
	   			$("#leaveApply").removeAttr("style");
			}
			else if($(obj).val()==2){
				$("#outPlan").removeAttr("style");
	   			$("#leaveApply").removeAttr("style");
			}
		}

		function setSelectBoxValue(selector, value) {
			alert(555);
			if (value == null) {
				value = jQuery(selector).find('option').first().val();
			}
			if(jQuery(selector).attr("id") == "cutomQuerySelect"){
				return;
			}
			jQuery(selector).selectbox('change',value,jQuery(selector).find('option[value="'+value+'"]').text());
		}

		function cleanBrowserValue(name) {
			alert(333);
			_writeBackData(name, 1, {id:'',name:''});
		}
		/**
		*清空搜索条件
		*/
		function onReset() {
			alert(111);
			//browser
			jQuery('#weaver .e8_os input[type="hidden"]').each(function() {
				alert(222);
				cleanBrowserValue(jQuery(this).attr('name'));
			});
			//input
			jQuery('#weaver input').val('');
			//select
			jQuery('#weaver select').each(function() {
				alert(444);
				setSelectBoxValue(this);
			});
			//resetCustom();
		}


		
	</script>
	
	<script language="javascript" src="/js/ecology8/selectbox/js/jquery.selectbox-0.2_wev8.js"></script>
	<script language="javascript" src="/js/browser/WorkFlowBrowser_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>