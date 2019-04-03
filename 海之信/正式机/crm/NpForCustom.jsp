
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

String customName = Util.null2String(request.getParameter("customName"));
String customCode = Util.null2String(request.getParameter("customCode"));
String enLook = Util.null2String(request.getParameter("enLook"));
String jpLook = Util.null2String(request.getParameter("jpLook"));
String telephone = Util.null2String(request.getParameter("telephone"));
String website = Util.null2String(request.getParameter("website"));

String tmc_pageId = "tmc_hh03";
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
	
	    <wea:item>公司名称</wea:item>
		<wea:item>
			<input type="text" name="customName" id="customName" class="InputStyle" value="<%=customName%>"/>
		</wea:item>
		<wea:item>公司代码</wea:item>
		<wea:item>
			<input type="text" name="customCode" id="customCode" class="InputStyle" value="<%=customCode%>" />
		</wea:item>

	    <wea:item>英文快速查询字母</wea:item>
		<wea:item>
			<input type="text" name="enLook" id="enLook" class="InputStyle"  value="<%=enLook%>" />
		</wea:item>
		<wea:item>日文快速查询字母</wea:item>
		<wea:item>
			<input type="text" name="jpLook" id="jpLook" class="InputStyle" value="<%=jpLook%>"  />
		</wea:item>
			
		<wea:item>公司电话</wea:item>
		<wea:item>
			<input type="text" name="telephone" id="telephone" class="InputStyle"  value="<%=telephone%>"/>
		</wea:item>
		<wea:item>公司网站</wea:item>
		<wea:item>
			<input type="text" name="website" id="website" class="InputStyle"  value="<%=website%>" />
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
							
	String backfields = " id,customName,customCode,(select countryName from uf_country where id=Country) as countryname,"
	+" (select TypeName from uf_enterprise_type where id=enterpriseType) as enterpriseName,EnQuickLook,JpQuickLook,"
	+" (select TypeName from uf_industryType where id=industryType) as industryName,Telphone,webSite,'未校对' as status "; 
	String fromSql  = " from uf_custom ";
	String sqlWhere = " where SuperID is null and CutomStatus=0 ";
	String orderby = " id " ;
	String tableString = "";

// out.println("customName="+customName+";customCode="+customCode+";enLook="+enLook+";jpLook="+jpLook+";telephone="+telephone+";website="+website);
	
if(!"".equals(customName)){
	sqlWhere = sqlWhere + " and customName like '%"+customName+"%'";
}
if(!"".equals(customCode)){
	sqlWhere = sqlWhere + " and customCode like '%"+customCode+"%'";
}
if(!"".equals(enLook)){
	sqlWhere = sqlWhere + " and EnQuickLook like '%"+enLook+"%'";
}
if(!"".equals(jpLook)){
	sqlWhere = sqlWhere + " and JpQuickLook like '%"+jpLook+"%'";
}
if(!"".equals(telephone)){
	sqlWhere = sqlWhere + " and Telphone like '%"+telephone+"%'";
}
if(!"".equals(website)){
	sqlWhere = sqlWhere + " and webSite like '%"+website+"%'";
}

//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+tmc_pageId +"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                 
		tableString+="<col width=\"10%\" labelid=\"1268\" text=\"公司名称\" column=\"customName\" orderkey=\"customName\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormModeIframe.jsp?modeId=52&amp;formId=-59&amp;type=0&amp;customid=80&amp;isdialog=&amp;templateid=0&amp;isclose=&amp;mainid=0&amp;opentype=0&amp;fromSave=0&amp;viewfrom=fromsearchlist&amp;isRefreshTree=0&amp;mainid=0&amp;isfromTab=1\" target=\"_fullwindow\"/>"+
	 "				<col width=\"10%\" labelid=\"1266\" text=\"公司代码\" column=\"customCode\" orderkey=\"customCode\"   linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormModeIframe.jsp?modeId=52&amp;formId=-59&amp;type=0&amp;customid=80&amp;isdialog=&amp;templateid=0&amp;isclose=&amp;mainid=0&amp;opentype=0&amp;fromSave=0&amp;viewfrom=fromsearchlist&amp;isRefreshTree=0&amp;mainid=0&amp;isfromTab=1\" target=\"_fullwindow\"/>"+
	  "				<col width=\"10%\" labelid=\"-9349\" text=\"所属国家\" column=\"countryname\" orderkey=\"countryname\"  />"+
	  "				<col width=\"10%\" labelid=\"32497\" text=\"企业类型\" column=\"enterpriseName\" orderkey=\"enterpriseName\" />"+
	  "				<col width=\"10%\" labelid=\"25525\" text=\"行业类型\" column=\"industryName\" orderkey=\"industryName\" />"+
	  "				<col width=\"15%\" labelid=\"-9348\" text=\"公司电话\" column=\"Telphone\" orderkey=\"Telphone\"  />"+
	  "				<col width=\"15%\" labelid=\"15768\" text=\"公司网站\" column=\"webSite\" orderkey=\"webSite\"  />"+
	  "				<col width=\"15%\" labelid=\"15078\" text=\"公司状态\" column=\"status\" orderkey=\"status\"  />"+
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
				document.report.action = "/seahonor/crm/NpForCustomOper.jsp";
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
