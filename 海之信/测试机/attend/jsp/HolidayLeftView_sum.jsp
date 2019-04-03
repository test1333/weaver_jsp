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
	String recipient = Util.null2String(request.getParameter("recipient"));
	String fromdate = Util.null2String(request.getParameter("fromdate"));
	String enddate = Util.null2String(request.getParameter("enddate"));
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	String departmentidpar = Util.null2String(request.getParameter("departmentid"));
	String source = Util.null2String(request.getParameter("source"));
	String leaveType = Util.null2String(request.getParameter("leaveType"));
	
	String left_pageId = "holiday_view_info";
	
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

	StringBuffer aphtml = new StringBuffer();
	aphtml.append("<TR style='VERTICAL-ALIGN: middle' class=DataDark>");
	aphtml.append("<TD style='DISPLAY: none; HEIGHT: 38px'>");
	aphtml.append("<INPUT style='DISPLAY: none' id=value=undefined type=checkbox>");
	aphtml.append("</TD>");
	aphtml.append("<TD style='HEIGHT: 38px' align=left>分页后新增行</TD>");
	aphtml.append("<TD style='HEIGHT: 38px' align=left>11</TD>");
	aphtml.append("<TD style='HEIGHT: 38px' align=left>13</TD>");
	aphtml.append("</TR>");
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=left_pageId%>"/>
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
				<brow:browser viewType="0"  name="recipient" browserValue="<%=recipient%>"
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
		
		String backfields = " id,departmentid,holiname,days,dayleft,convert(decimal(10,2),dayUsed/8.00) as dayUsed,startdate,enddate,lastname,orderby as tmporder,applyuser,workcode ";
		String fromSql  = " from holiday_view ";
		String sqlWhere = " days>0 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " departmentid,applyuser,tmporder,enddate " ;
		String tableString = "";
		String operateString= "";

		if(!isAdmin){
			sqlWhere += "and applyuser ="+userid+" ";
		}else{
			if(!"".equals(recipient)){
				sqlWhere += "and applyuser ="+recipient+" ";
				
			}
		}
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(left_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+left_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"13%\" labelid=\"413\" text=\"姓名\" column=\"applyuser\" orderkey=\"applyuser\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"13%\" labelid=\"1933\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
			"		<col width=\"13%\" labelid=\"-10971\" text=\"假期名称\" column=\"holiname\" orderkey=\"holiname\" />"+
			"		<col width=\"13%\" labelid=\"24347\" text=\"剩余天数\" column=\"days\" orderkey=\"days\" />"+
			"		<col width=\"13%\" labelid=\"-9260\" text=\"剩余小时数\" column=\"dayleft\" orderkey=\"dayleft\" />"+
			"		<col width=\"13%\" labelid=\"-10972\" text=\"已用天数\" column=\"dayUsed\" orderkey=\"dayUsed\" />"+
			"		<col width=\"15%\" labelid=\"-10973\" text=\"有效期开始日期\" column=\"startdate\" orderkey=\"startdate\"/>"+
			"		<col width=\"15%\" labelid=\"-10974\" text=\"有效期结束日期\" column=\"enddate\" orderkey=\"enddate\" />"+
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
		}	


		//重写分页后执行函数
	weaverTable.prototype.PageAfter = function(){
   		//alert("我已经成功重写函数了!");
   		jQuery("table.ListStyle").children("tbody").append("<%=aphtml.toString()%>");
	}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>