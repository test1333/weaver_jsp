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
	
	String resourceid = Util.null2String(request.getParameter("resourceid"));
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		
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
				<brow:browser viewType="0"  name="resourceid" browserValue="<%=resourceid %>" 
				    browserOnClick=""
				    browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				    hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				    completeUrl="/data.jsp" width="165px"
				    browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(resourceid),user.getLanguage())%>">
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
		
		String backfields = " id,empid,workcode,relatedID,dedutime,deduAlltime ";
		String fromSql  = " from uf_deduction_relate ";
		String sqlWhere = " where relatedID > 0 ";
		//out.println("select "+ backfields + fromSql + sqlWhere);
		//System.out.println(sqlWhere);
		String orderby = " id,empid " ;
		String tableString = "";
		String  operateString= "";
        
		if(!isAdmin){
			sqlWhere += "and empid ="+userid+" ";	
		}else{
			//员工姓名
			if(!"".equals(resourceid)){
				sqlWhere += "and empid ="+resourceid+" ";
			}
		}

		/*//考勤部门										
		if(!"".equals(departmentidpar)){
			sqlWhere += " and emp_id in (select id from HrmResource where departmentid = "+departmentidpar+") ";
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
*/
		//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
		//out.println(sqlWhere);
		//out.println("userid="+userid);

	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"empid\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString +
		"			<head>";
		tableString+="<col width=\"18%\" labelid=\"413\" text=\"姓名\" column=\"empid\" orderkey=\"empid\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\" />"+
			"		<col width=\"18%\" labelid=\"33456\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\" />"+
			"		<col width=\"18%\" labelid=\"-11\" text=\"关联ID\" column=\"relatedID\" orderkey=\"relatedID\" href=\"/seahonor/jsp/LeaveDeductioning.jsp\" linkkey=\"relatedID\" linkvaluecolumn=\"relatedID\" target=\"_blank\" />"+
			"		<col width=\"18%\" labelid=\"-12\" text=\"扣减时间\" column=\"dedutime\" orderkey=\"dedutime\" />"+
			"		<col width=\"18%\" labelid=\"-13\" text=\"应扣总时间\" column=\"deduAlltime\" orderkey=\"deduAlltime\"/>"+
			
		"			</head>"+
	" </table>"; 
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
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

		function relatedData(){
		//alert("relatedID="+relatedID);
		var title = "";
		var url = "";
		title = "<%=SystemEnv.getHtmlLabelNames("81543",user.getLanguage())%>";
		url="/seahonor/jsp/LeaveDeductioning.jsp ";
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

	
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>