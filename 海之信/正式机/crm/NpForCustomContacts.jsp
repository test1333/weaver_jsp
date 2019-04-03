
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
</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

String Name = Util.null2String(request.getParameter("Name"));
String xmyr = Util.null2String(request.getParameter("xmyr"));
String telephone = Util.null2String(request.getParameter("telephone"));
String SysNo = Util.null2String(request.getParameter("SysNo"));

String tmc_pageId = "tmc_hh04";
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
	//RCMenu += "{确认校队,javascript:onCheckup(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
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
	
	    <wea:item>联系人姓名(中文)</wea:item>
		<wea:item>
			<input type="text" name="Name" id="Name" class="InputStyle" value="<%=Name%>"/>
		</wea:item>
		<wea:item>联系人姓名(英/日)</wea:item>
		<wea:item>
			<input type="text" name="xmyr" id="xmyr" class="InputStyle" value="<%=xmyr%>" />
		</wea:item>
			
		<wea:item>联系人移动电话</wea:item>
		<wea:item>
			<input type="text" name="telephone" id="telephone" class="InputStyle"  value="<%=telephone%>"/>
		</wea:item>
		<wea:item>联系人代码</wea:item>
		<wea:item>
			<input type="text" name="SysNo" id="SysNo" class="InputStyle"  value="<%=SysNo%>" />
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
							
	String backfields = " id,Name,xmyr,SysNo,dept,mobile,Position,tel,(select customName from uf_custom where id=f.customName) as cname,(select khmcyr from uf_custom where id=f.customName) as khmcyr,"+
	"(select GroupName from uf_custom_group where id=f.GroupName) as GroupName,(select jtmcyr from uf_custom_group where id=f.GroupName) as jtmcyr,'未校对' as status "; 
	String fromSql  = " from uf_Contacts f ";
	String sqlWhere = " where SuperID is null and dealStatus=0  ";
	String orderby = " id " ;
	String tableString = "";

// out.println("customName="+customName+";customCode="+customCode+";enLook="+enLook+";jpLook="+jpLook+";telephone="+telephone+";website="+website);
	
if(!"".equals(Name)){
	sqlWhere = sqlWhere + " and Name like '%"+Name+"%'";
}
if(!"".equals(xmyr)){
	sqlWhere = sqlWhere + " and upper(xmyr) like upper('%"+xmyr+"%')";
}
if(!"".equals(telephone)){
	sqlWhere = sqlWhere + " and mobile like '%"+telephone+"%'";
}
if(!"".equals(SysNo)){
	sqlWhere = sqlWhere + " and SysNo like '%"+SysNo+"%'";
}


//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"
	+	"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                
		tableString+="<col width=\"10%\" labelid=\"17062\" text=\"姓名(中文)\" column=\"Name\" orderkey=\"Name\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
		 "				<col width=\"10%\" labelid=\"15393\" text=\"姓名(英日)\" column=\"xmyr\" orderkey=\"xmyr\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	 "				<col width=\"10%\" labelid=\"1266\" text=\"联系人代码\" column=\"SysNo\" orderkey=\"SysNo\"   linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	   "	<col width=\"10%\" labelid=\"421\" text=\"移动电话\" column=\"mobile\" orderkey=\"mobile\"  />"+
	  "				<col width=\"10%\" labelid=\"1268\" text=\"公司名称(中文)\" column=\"cname\" orderkey=\"cname\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\" />"+
	   "				<col width=\"10%\" labelid=\"1268\" text=\"公司名称(英/日)\" column=\"khmcyr\" orderkey=\"khmcyr\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\" />"+
	 
	  "				<col width=\"10%\" labelid=\"1915\" text=\"集团名称(中文)\" column=\"GroupName\" orderkey=\"GroupName\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	  "				<col width=\"10%\" labelid=\"1915\" text=\"集团名称(英/日)\" column=\"jtmcyr\" orderkey=\"jtmcyr\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=56&amp;formId=-63&amp;opentype=0&amp;customid=37&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\"/>"+
	 
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
		if(window.confirm('你是否确认校队吗？')){
			var ids = _xtable_CheckedCheckboxId();
			if(ids != ""){
		//		alert("ids = " + ids);
				document.report.multiIds.value = ids;
				document.report.action = "/seahonor/crm/NpForCustomContactsOper.jsp";
			//	obj.disabled = true;
				document.report.submit();
			}else{
	        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
	    	}
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
