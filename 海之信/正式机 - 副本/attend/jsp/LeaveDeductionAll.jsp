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
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
	int userid = user.getUID();//获取当前登录用户的ID
	String year_name = Util.null2String(request.getParameter("year_name"));//在页面中获取字段的值；Util.null2String：如果对象为空则强制转换为String类型
	String month_name = Util.null2String(request.getParameter("month_name"));
	String recipient = Util.null2String(request.getParameter("recipient"));
	String empid = Util.null2String(request.getParameter("emp_id"));
	String tmp_startdate = "";
	String tmp_enddate = "";
	
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
	
	String late_pageId = "late_info";
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
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=late_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;//添加鼠标右键菜单：527为数据库中HtmlLableIndex表中对应的id，可通过id值获取显示的内容
		if(isAdmin){
		RCMenu +="{" + SystemEnv.getHtmlLabelName(-10946, user.getLanguage())+ ",javascript:firm(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		}
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
		    <INPUT type="hidden" id="startdate" name="startdate" value="<%=tmp_startdate%>">
			<INPUT type="hidden" id="enddate" name="enddate" value="<%=tmp_enddate%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<%if(isAdmin){%>
						<input type=button class="e8_btn_top" onclick="firm();" value="迟到统计">
						<%}%>
						<span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
						</span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			<div>
			<table width="100%" class="ListStyle" style="font-size: 8pt">
			    <colgroup>
			    <col width="10%"></col>
			    <col width="5%"></col>
			    <col width="10%"></col>
			    <col width="5%"></col>
			    <col width="60%"></col>
			    <col width="10%"></col>
			    </colgroup>
				
				<tr>
					<td class=Field>
						<select id="year_name" name="year_name">
					    <option value=""></option>
					    <option value="2014" <%if ("2014".equals(year_name)) {%>selected<%}%>>2014</option>
					    <option value="2015" <%if ("2015".equals(year_name)) {%>selected<%}%>>2015</option>
					    <option value="2016" <%if ("2016".equals(year_name)) {%>selected<%}%>>2016</option>
					    <option value="2017" <%if ("2017".equals(year_name)) {%>selected<%}%>>2017</option>
					    <option value="2018" <%if ("2018".equals(year_name)) {%>selected<%}%>>2018</option>
					    <option value="2019" <%if ("2019".equals(year_name)) {%>selected<%}%>>2019</option>
				        </select>
					</td>
					<td class=Field>年</td>
					<td><select id="month_name" name="month_name">
					<option value=""></option>
					<option value="1" <%if ("1".equals(month_name)) {%>selected<%}%>>01</option>
					<option value="2" <%if ("2".equals(month_name)) {%>selected<%}%>>02</option>
					<option value="3" <%if ("3".equals(month_name)) {%>selected<%}%>>03</option>
					<option value="4" <%if ("4".equals(month_name)) {%>selected<%}%>>04</option>
					<option value="5" <%if ("5".equals(month_name)) {%>selected<%}%>>05</option>
					<option value="6" <%if ("6".equals(month_name)) {%>selected<%}%>>06</option>
					<option value="7" <%if ("7".equals(month_name)) {%>selected<%}%>>07</option>
					<option value="8" <%if ("8".equals(month_name)) {%>selected<%}%>>08</option>
					<option value="9" <%if ("9".equals(month_name)) {%>selected<%}%>>09</option>
					<option value="10" <%if ("10".equals(month_name)) {%>selected<%}%>>10</option>
					<option value="11" <%if ("11".equals(month_name)) {%>selected<%}%>>11</option>
					<option value="12" <%if ("12".equals(month_name)) {%>selected<%}%>>12</option>
				    </select></td>
				    <td class=Field>月</td>
					<td class=Field>当月迟到统计表  <font color="red">[<%=tmp_startdate%> - <%=tmp_enddate%>]</font></td>
				</tr>
			</table>
			</div>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>员工姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient %>"
					browserOnClick=""
					browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					completeUrl="/data.jsp" width="165px"
					browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
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
		String backfields = " emp_id,workcode,isnull(absence,0) as absence,isnull(deduction,0) as deduction,CONVERT(varchar(7),countdate,23) as countdate";
		//表单中的字段
		String fromSql  = " from uf_leave_deduction ";//sql查询的表
		String sqlWhere = " where countdate = '"+tmp_enddate+"' ";//where条件
		//out.println("select "+ backfields + fromSql + sqlWhere);
		
		String orderby = " emp_id " ;//排序关键字
		String tableString = "";
		String operateString= "";
        
		if(!isAdmin){
			sqlWhere += "and emp_id ="+userid+" ";
		}else{
			//员工姓名
			if(!"".equals(recipient)){
				sqlWhere += "and emp_id ="+recipient+" ";
			}
		}
        
		operateString = " <operates>";
		operateString +="    <popedom transmethod=\"weaver.workflow.workflow.WFAgentTransMethod.getAgentOperation\" ></popedom> ";
		operateString +="     <operate  	href=\"javascript:showLateDetail();\" text=\"查看明细\" otherpara=\"ct+column:emp_id\" index=\"0\"/>";
		operateString +=" </operates>";
		
		//out.println("select "+ backfields + fromSql +  sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"radio\" pagesize=\""+ PageIdConst.getPageSize(late_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+late_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"20%\" labelid=\"413\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"20%\" labelid=\"1933\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
			"		<col width=\"20%\" labelid=\"-10975\" text=\"归属月份\" column=\"countdate\" orderkey=\"countdate\" />"+
			"		<col width=\"20%\" labelid=\"-10984\" text=\"迟到/早退(分钟)\" column=\"absence\" orderkey=\"absence\" />"+
			"		<col width=\"20%\" labelid=\"-10985\" text=\"迟到/早退核定(小时)\" column=\"deduction\" orderkey=\"deduction\"/>"+
			"			</head>"+
			" </table>"; 
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		//编辑
		function showLateDetail(emp_id){
				alert("1111");
				dialog = new window.top.Dialog();
				dialog.currentWindow = window;
				var emp_id = emp_id;
				//var emp_id = type.split("+")[1];
				//var countdate = type.split("+")[2];
				alert("emp_id="+emp_id);
				//alert("countdate="+countdate);
				var url = "/seahonor/attend/jsp/SH_late_detail.jsp?emp_id="+emp_id+"&countdate="+countdate+";
				dialog.Title = "操作历史记录";
				dialog.Width = 600;
				dialog.Height =550;
				dialog.Drag = true;
				 
				dialog.URL = url;
				dialog.show();
		}

		function onBtnSearchClick() {
			weaver.submit();
		}

		function firm(){
			Dialog.confirm("是否统计迟到时间？", function (){
	        		weaver.action="/seahonor/attend/jsp/CountLate.jsp";
					weaver.submit();
				}, function () {}, 320, 90,false);
		
		}

		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
		
		
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>