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
	int userid = user.getUID();
	String year_name = Util.null2String(request.getParameter("year_name"));
	String month_name = Util.null2String(request.getParameter("month_name"));
	String deptid = Util.null2String(request.getParameter("deptid"));
	String subcomid = Util.null2String(request.getParameter("subcomid"));
	String recipient = Util.null2String(request.getParameter("recipient"));
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
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:doEdit(this),_TOP} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<INPUT type="hidden" id="startdate" name="startdate" value="<%=tmp_startdate%>">
			<INPUT type="hidden" id="enddate" name="enddate" value="<%=tmp_enddate%>">
			<INPUT type="hidden" id="year_name" name="year_name" value="<%=year_name%>">
			<INPUT type="hidden" id="month_name" name="enddate" value="<%=month_name%>">
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
						<td class=Field>当月出勤福利表 <font color="red">[<%=tmp_startdate%> - <%=tmp_enddate%>]</font></td>
						<%if(isAdmin){%>
						<td class=Field><input type="button" value="补贴计算" class="e8_btn_submit" onclick="firm()"></td>
						<%}%>
					</tr>
				</table>
			</div>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>姓名</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient %>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(recipient),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
				<wea:item>部门</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="deptid" browserValue="<%=deptid%>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(deptid),user.getLanguage())%>">
				</brow:browser>
				</wea:item>
				<wea:item>分部</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="subcomid" browserValue="<%=subcomid%>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(subcomid),user.getLanguage())%>">
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
		//out.println("year_name="+year_name);
		//out.println("month_name="+month_name);
		String backfields = " emp_id,should_attend,normal_attend,adjusted_leave,sick_leave,casual_leave,other_leave,different,sum_meal,sum_phone,sum_transport ";
		String fromSql  = " from sh_bonus_report  ";
		String sqlWhere = " where startdate = '"+tmp_startdate+"' and enddate = '"+tmp_enddate+"' and emp_id not in(select EmployeeName from uf_Exclude_table) ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " emp_id " ;
		String tableString = "";
		String operateString= "";
		String url = "/seahonor/attend/jsp/BonusPersonalDetail.jsp?year_name="+year_name+"&amp;month_name="+month_name+"";
		
		if(!isAdmin){
			sqlWhere += "and emp_id ="+userid+" ";
		}else{
			//员工姓名
			if(!"".equals(recipient)){
				sqlWhere += "and emp_id ="+recipient+" ";
			}
		}
		
		//考勤部门
		if(!"".equals(deptid)){
			sqlWhere += " and emp_id in (select id from HrmResource where departmentid = "+deptid+") ";
		}
		//考勤分部
		if(!"".equals(subcomid)){
			sqlWhere += " and emp_id in (select id from HrmResource where subcompanyid1 = "+subcomid+") ";
		}
		
		//out.println("select "+ backfields + fromSql +  sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);
		operateString = "<operates>"+
	    " <operate href=\"javascript:this.addFieldTrigger()\" text=\"查看明细\" isalwaysshow='true' index=\"0\"/></operates>";
		tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
			"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"emp_id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
			operateString +
			"			<head>";
				tableString+="<col width=\"8%\" labelid=\"25034\" text=\"姓名\" column=\"emp_id\" orderkey=\"emp_id\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" href=\""+url+"\" linkkey=\"emp_id\" linkvaluecolumn=\"emp_id\" />"+
				"		<col width=\"8%\" labelid=\"34082\" text=\"应出勤\" column=\"should_attend\" orderkey=\"should_attend\" />"+
				"		<col width=\"8%\" labelid=\"34091\" text=\"实出勤\" column=\"normal_attend\" orderkey=\"normal_attend\" />"+
				"		<col width=\"8%\" labelid=\"31297\" text=\"调休假\" column=\"adjusted_leave\" orderkey=\"adjusted_leave\" />"+
				"		<col width=\"8%\" labelid=\"1919\" text=\"病假\" column=\"sick_leave\" orderkey=\"sick_leave\"/>"+
				"		<col width=\"8%\" labelid=\"1920\" text=\"事假\" column=\"casual_leave\" orderkey=\"casual_leave\"/>"+
				"		<col width=\"8%\" labelid=\"20083\" text=\"其他假\" column=\"other_leave\" orderkey=\"other_leave\"/>"+
				"		<col width=\"8%\" labelid=\"22516\" text=\"旷工\" column=\"different\" orderkey=\"different\"/>"+
				"		<col width=\"8%\" labelid=\"1896\" text=\"饭贴\" column=\"sum_meal\" orderkey=\"sum_meal\"/>"+
				"		<col width=\"8%\" labelid=\"1895\" text=\"车贴\" column=\"sum_transport\" orderkey=\"sum_transport\"/>"+
				"		<col width=\"8%\" labelid=\"19266\" text=\"通讯费\" column=\"sum_phone\" orderkey=\"sum_phone\"/>"+
			"			</head>"+
		" </table>";
		%>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
		<script type="text/javascript">
			function onBtnSearchClick() {
				weaver.submit();
			}

		    function firm(){
		        /*if(confirm("是否计算补贴？")){
					weaver.action = "/seahonor/attend/jsp/CountBonus.jsp";
		        	weaver.submit();	
				}*/
				
				Dialog.confirm("是否计算补贴？", function (){
	        		weaver.action="/seahonor/attend/jsp/CountBonus.jsp";
					weaver.submit();
				}, function () {}, 320, 90,false);
		    }

			function doEdit(obj) {
				weaver.submit();
				obj.disabled = true;
			}

			function addFieldTrigger(empid){
		        var title = "";
		        var url = "";
				var year=<%=year_name%>;
				var month=<%=month_name%>;
				//alert("year="+year);
		        title = "<%=SystemEnv.getHtmlLabelNames("81543",user.getLanguage())%>";
		        url="/seahonor/attend/jsp/BonusPersonalDetail1.jsp?emp_id="+empid+"&amp;year_name="+year+"&amp;month_name="+month+" ";
		        diag_vote = new window.top.Dialog();
		        diag_vote.currentWindow = window;
		        diag_vote.Width = 900;
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