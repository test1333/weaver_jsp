
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
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
<script type="text/javascript">
	function openNewInfo(id) {
	//	openFullWindowForXtable("CustomGroupDynamicDetail.jsp?customID="+id);
		var title = "";
		var url = "/seahonor/remind/RemindJobBase_all.jsp?id="+id;
		//alert(url)
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1200;
		diag_vote.Height = 700;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.checkDataChange = false;
		diag_vote.show();	
	}
	function onCheckupCreate(){
		var title = "";
		var url = "/seahonor/remind/RemindJobBase_emp.jsp";
		//alert(url)
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1200;
		diag_vote.Height = 700;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.checkDataChange = false;
		diag_vote.show();
        }
</script>

</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

int userid = user.getUID();
String title = Util.null2String(request.getParameter("title"));
String customCode = Util.null2String(request.getParameter("customCode"));
String enLook = Util.null2String(request.getParameter("enLook"));
String jpLook = Util.null2String(request.getParameter("jpLook"));
String telephone = Util.null2String(request.getParameter("telephone"));
String website = Util.null2String(request.getParameter("website"));

String tmc_pageId = "tmcEmpRem01";
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=tmc_pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{创建提醒信息,javascript:onCheckupCreate(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{关闭提醒,javascript:onCheckup(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="multiIds" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>提醒标题</wea:item>
		<wea:item>
			<input type="text" name="title" id="title" class="InputStyle" value="<%=title%>"/>
		</wea:item>
	</wea:group>
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%

/*Iterator<String> it = map.keySet().iterator();
while(it.hasNext()){
String tmp_id_x = it.next();
String tmp_name_x = map.get(tmp_id_x);
}*/
//	out.prinln(tmp_name_x);	
							
	String backfields = " id,created_time,title,remarks,reDate+' ' + reTime as reATime,"
					  +" (case over_active when 0 then '未启用' when 1 then '已启用' when 9 then '提醒结束' else '未知' end) as over_active,"
					  +" (case remindHZ when 1 then '即时提醒' when 2 then '到期提醒' else '循环提醒' end) remindHz"; 
	String fromSql  = " from uf_remindRecord ";
	String sqlWhere = " where is_Active=0 and creater="+userid;
	String orderby = " created_time " ;
	String tableString = "";

// out.println("customName="+customName+";customCode="+customCode+";enLook="+enLook+";jpLook="+jpLook+";telephone="+telephone+";website="+website);
	
if(!"".equals(title)){
	sqlWhere = sqlWhere + " and title like '%"+title+"%'";
}


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "<operates width=\"20%\">"+
 	        	    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
						 "     <operate href=\"javascript:openNewInfo();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"查看编辑\"  target=\"_fullwindow\" isalwaysshow='true' index=\"0\"/>"+

 	       				"</operates>";
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
		tableString+="<col width=\"20%\" labelid=\"229\" text=\"标题\" column=\"title\" orderkey=\"title\" linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/seahonor/remind/RemindJobBase_all.jsp\" target=\"_fullwindow\"/>"+
	 "				<col width=\"10%\" labelid=\"1339\" text=\"创建时间\" column=\"created_time\" orderkey=\"created_time\"  />"+
	  "				<col width=\"20%\" labelid=\"454\" text=\"备注\" column=\"remarks\" orderkey=\"remarks\"  />"+
	  "				<col width=\"10%\" labelid=\"742\" text=\"提醒开始时间\" column=\"reATime\" orderkey=\"enterpriseName\" />"+
	  "				<col width=\"10%\" labelid=\"602\" text=\"提醒状态\" column=\"over_active\" orderkey=\"over_active\" />"+
	  "				<col width=\"15%\" labelid=\"18713\" text=\"提醒方式\" column=\"remindHz\" orderkey=\"remindHz\"  />"+
    "			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />


		

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function onCheckup(){	
			
			var ids = _xtable_CheckedCheckboxId();
			if(ids != ""){
			     if(window.confirm('你是否确认关闭提醒吗')){
		//		alert("ids = " + ids);
				document.report.multiIds.value = ids;
				document.report.action = "/seahonor/crm/NpForCustomOper.jsp";
			//	obj.disabled = true;
				document.report.submit();
                            } 
			}else{
	        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
	    		}
	 	
	    
	}
		
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
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
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
	</script>
</BODY>
</HTML>
