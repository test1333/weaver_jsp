<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
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
	
	int userid = user.getUID();//获取当前登录用户的ID
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String recipient = Util.null2String(request.getParameter("recipient"));
	String options = Util.null2String(request.getParameter("options"));
	
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
	if(!isAdmin) {
		response.sendRedirect("/notice/noright.jsp") ;
		return ;
	}

	String late_pageId = "late_info";

	String sql_outPlan = " select requestid,nodename,createdate+' '+createtime as create_time,lastoperatedate+' '+lastoperatetime as lastoperate,"
						+" creater,requestnamenew,workflowname,ArrangedStaff,startDate+'~'+endDate as outDate  from sh_outPlan_workflow where 1=1 ";
	String sql_leaveApply = " select requestid,nodename,createdate+' '+createtime as create_time,lastoperatedate+' '+lastoperatetime as lastoperate,"
						+" creater,requestnamenew,workflowname,applyuser,startdate+'~'+enddate as leaveDate from sh_leaveApply_workflow where 1=1 ";
						
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=late_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;//添加鼠标右键菜单：527为数据库中HtmlLableIndex表中对应的id，可通过id值获取显示的内容
		if(isAdmin){
		RCMenu +="{" + SystemEnv.getHtmlLabelName(-10946, user.getLanguage())+ ",javascript:firm(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		}
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<INPUT type="hidden" id="startdate" name="startdate" value="">
			<INPUT type="hidden" id="enddate" name="enddate" value="">
			
			<div>
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  id="searchInput" name="recipient" browserValue="<%=recipient%>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
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
				<wea:item>检查内容</wea:item>
				<wea:item>
					<select id="searchInput" name="options" width="165px" onChange="changeRange(this)">
					    <option value=""></option>
					    <option value="0" <%if ("0".equals(options)) {%>selected<%}%>>外出</option>
					    <option value="1" <%if ("1".equals(options)) {%>selected<%}%>>请假</option>
					    <option value="2" <%if ("2".equals(options)) {%>selected<%}%>>全部</option>
				    </select>
				</wea:item>
				</wea:group>

				<wea:group context="">
					<wea:item type="toolbar">
						<input class="e8_btn_submit" type="submit" name="submit_1" onClick="onBtnSearchClick()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
						<span class="e8_sep_line">|</span>
						<input class="e8_btn_cancel" type="button" name="reset" onclick="firm();" value="修改"/>
						<span class="e8_sep_line">|</span>
						<input type="button" onclick="onReset();" value="重置" class="e8_btn_cancel" id="cancel"/>
					</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		<%
			if("0".equals(options)){
				if(!"".equals(recipient)){
					sql_outPlan += " and (','+ cast(ArrangedStaff as varchar(7998 ))+',') like '%,"+recipient+",%' ";
				}

				if(!"".equals(fromdate)){
					sql_outPlan += " and '"+fromdate+"' between startDate and endDate ";
				}
				//out.print(sql_outPlan);
				RecordSet.executeSql(sql_outPlan);
			}else if("1".equals(options)){
				if(!"".equals(recipient)){
					sql_leaveApply += " and applyuser = "+recipient+" ";
				}

				if(!"".equals(fromdate)){
					sql_leaveApply += " and '"+fromdate+"' between startdate and enddate ";
				}
				//out.print(sql_leaveApply);
				rs.executeSql(sql_leaveApply);	
			}else if("2".equals(options)){
					if(!"".equals(recipient)){
					sql_outPlan += " and (','+ cast(ArrangedStaff as varchar(7998 ))+',') like '%,"+recipient+",%' ";
					sql_leaveApply += " and applyuser = "+recipient+" ";
				}

				if(!"".equals(fromdate)){
					sql_outPlan += " and '"+fromdate+"' between startDate and endDate ";
					sql_leaveApply += " and '"+fromdate+"' between startdate and enddate ";
				}
				//out.print(sql_outPlan);
				//out.print(sql_leaveApply);
				RecordSet.executeSql(sql_outPlan);
				rs.executeSql(sql_leaveApply);	
			}

			if(!"".equals(fromdate)&&!"".equals(recipient)){
				String sql_attend = " select a.emp_id,a.startTime,a.endTime,b.atten_start_time,b.atten_end_time,b.late_times,b.early_leave_times, "
					+" case a.source when 0 then '正常考勤' when 1 then '移动考勤' when 2 then '请假' when 99 then '全天请假' else '' end as sourceNew, "
					+" dbo.sh_atten_type(a.source,a.atten_type) as atten_type  "
					+" from dbo.sh_attend_arrange_new("+recipient+",'"+fromdate+"') a "
					+" left join uf_all_attend_info b on a.emp_id=b.emp_id and a.attend_day=b.atten_day where isnull(isEffective,0)=0";
				res.executeSql(sql_attend);
				//out.print(sql_attend);
			}
		%>
		<wea:layout attributes="{'expandAllGroup':'true'}">
			<div id="outPlan">
				<wea:group context="当日考勤">
					<wea:item attributes="{'isTableList':'true'}">
						<wea:layout type="table" attributes="{'cols':'9','cws':'11%,11%,11%,11%,11%,11%,11%,11%,11%'}">
							<wea:group context="" attributes="{'groupDisplay':'none'}">
								<wea:item type="thead">员工姓名</wea:item>
								<wea:item type="thead">考勤类型</wea:item>
								<wea:item type="thead">外出/请假</wea:item>
								<wea:item type="thead">上班时间</wea:item>
								<wea:item type="thead">上班打卡</wea:item>
								<wea:item type="thead">下班时间</wea:item>
								<wea:item type="thead">下班打卡</wea:item>
								<wea:item type="thead">迟到时间</wea:item>
								<wea:item type="thead">早退时间</wea:item>
								<%
								if(res.next()){
									String emp_id = Util.null2String(res.getString("emp_id"));
									String source = Util.null2String(res.getString("sourceNew"));
									String atten_type = Util.null2String(res.getString("atten_type"));
									String startTime = Util.null2String(res.getString("startTime"));
									String atten_start_time = Util.null2String(res.getString("atten_start_time"));
									String endTime = Util.null2String(res.getString("endTime"));
									String atten_end_time = Util.null2String(res.getString("atten_end_time"));
									String late_times = Util.null2String(res.getString("late_times"));
									String early_leave_times = Util.null2String(res.getString("early_leave_times"));
								
								%>
								<wea:item><%=ResourceComInfo.getResourcename(emp_id)%></wea:item>
								<wea:item><%=source%></wea:item>
								<wea:item><%=atten_type%></wea:item>
								<wea:item><%=startTime%></wea:item>
								<wea:item><%=atten_start_time%></wea:item>
								<wea:item><%=endTime%></wea:item>
								<wea:item><%=atten_end_time%></wea:item>
								<wea:item><%=late_times%></wea:item>
								<wea:item><%=early_leave_times%></wea:item>
								<%
								}
								%>
							</wea:group>
						</wea:layout>
					</wea:item>
				</wea:group>
			</div>
		</wea:layout>

		<wea:layout attributes="{'expandAllGroup':'true'}">
			<div id="outPlan">
				<wea:group context="外出计划">
					<wea:item attributes="{'isTableList':'true'}">
						<wea:layout type="table" attributes="{'cols':'8','cws':'25%,10%,5%,15%,10%,15%,5%,15%'}">
							<wea:group context="" attributes="{'groupDisplay':'none'}">
								<wea:item type="thead">请求标题</wea:item>
								<wea:item type="thead">工作流</wea:item>
								<wea:item type="thead">创建人</wea:item>
								<wea:item type="thead">创建时间</wea:item>
								<wea:item type="thead">当前节点</wea:item>
								<wea:item type="thead">上次操作时间</wea:item>
								<wea:item type="thead">申请人</wea:item>
								<wea:item type="thead">外出日期</wea:item>
								<%
								while(RecordSet.next()){
									String requestid = Util.null2String(RecordSet.getString("requestid"));
									String requestnamenew = Util.null2String(RecordSet.getString("requestnamenew"));
									String workflowname = Util.null2String(RecordSet.getString("workflowname"));
									String creater = Util.null2String(RecordSet.getString("creater"));
									String create_time = Util.null2String(RecordSet.getString("create_time"));
									String nodename = Util.null2String(RecordSet.getString("nodename"));
									String lastoperate = Util.null2String(RecordSet.getString("lastoperate"));
									String ArrangedStaff = Util.null2String(RecordSet.getString("ArrangedStaff"));
									String outDate = Util.null2String(RecordSet.getString("outDate"));
								
								%>
								<wea:item><a href=javascript:this.openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid=<%=requestid%>&ismonitor=1')><%=requestnamenew%></a></wea:item>
								<wea:item><%=workflowname%></wea:item>
								<wea:item><%=ResourceComInfo.getResourcename(creater)%></wea:item>
								<wea:item><%=create_time%></wea:item>
								<wea:item><%=nodename%></wea:item>
								<wea:item><%=lastoperate%></wea:item>
								<wea:item><%=ResourceComInfo.getResourcename(ArrangedStaff)%></wea:item>
								<wea:item><%=outDate%></wea:item>
								<%
								}
								%>
							</wea:group>
						</wea:layout>
					</wea:item>
				</wea:group>
			</div>
		</wea:layout>

		<wea:layout attributes="{'expandAllGroup':'true'}">
			<div id="leaveApply" style="display:none;">
				<wea:group context="请假申请">
					<wea:item attributes="{'isTableList':'true'}">
						<wea:layout type="table" attributes="{'cols':'8','cws':'25%,10%,5%,15%,10%,15%,5%,15%'}">
							<wea:group context="" attributes="{'groupDisplay':'none'}">
								<wea:item type="thead">请求标题</wea:item>
								<wea:item type="thead">工作流</wea:item>
								<wea:item type="thead">创建人</wea:item>
								<wea:item type="thead">创建时间</wea:item>
								<wea:item type="thead">当前节点</wea:item>
								<wea:item type="thead">上次操作时间</wea:item>
								<wea:item type="thead">申请人</wea:item>
								<wea:item type="thead">请假日期</wea:item>
								<%
								while(rs.next()){
									String requestid = Util.null2String(rs.getString("requestid"));
									String requestnamenew = Util.null2String(rs.getString("requestnamenew"));
									String workflowname = Util.null2String(rs.getString("workflowname"));
									String creater = Util.null2String(rs.getString("creater"));
									String create_time = Util.null2String(rs.getString("create_time"));
									String nodename = Util.null2String(rs.getString("nodename"));
									String lastoperate = Util.null2String(rs.getString("lastoperate"));
									String applyuser = Util.null2String(rs.getString("applyuser"));
									String leaveDate = Util.null2String(rs.getString("leaveDate"));
								
								%>
								<wea:item><a href=javascript:this.openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid=<%=requestid%>&ismonitor=1')><%=requestnamenew%></a></wea:item>
								<wea:item><%=workflowname%></wea:item>
								<wea:item><%=ResourceComInfo.getResourcename(creater)%></wea:item>
								<wea:item><%=create_time%></wea:item>
								<wea:item><%=nodename%></wea:item>
								<wea:item><%=lastoperate%></wea:item>
								<wea:item><%=ResourceComInfo.getResourcename(applyuser)%></wea:item>
								<wea:item><%=leaveDate%></wea:item>
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