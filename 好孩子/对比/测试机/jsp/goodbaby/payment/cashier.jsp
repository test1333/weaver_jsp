<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="goodbaby.util.tanchuang"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
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
int userid = user.getUID();
String pageID = "HHH21ds2qw";

String gysmcs = Util.null2String(request.getParameter("gysmcs"));
String pkbh = Util.null2String(request.getParameter("pkbhs"));


%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{数据确认,javascript:opera(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	// RCMenu += "{废弃不用,javascript:fq(),_self} " ;
	// RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="aa" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" id="cflc" name = "cflc"  value="确认处理" class="e8_btn_top" onClick="opera()" />
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	    <wea:item>排款编号</wea:item>
		<wea:item>
			<input type="text" name="pkbhs" id="pkbhs" class="InputStyle" value="<%=pkbh%>"/>
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
	String backfields = " u.id,u.cnpdcc,u.con,u.pkbh,u.pcno,u.pklcid ,u.xx,convert(varchar(20),u.pklcid)+'&amp;pc='+u.pcno as cs  "; 
	String fromSql  = " from (select xx,cnpdcc,id,con,(select pkbh from  formtable_main_205 where requestid = pklcid ) as pkbh,pklcid,pcno from [dbo].[gb_cashierConfirm] ) u ";
	String sqlWhere = " where 1=1 ";	

	String orderby = " u.id " ;
	String tableString = "";
	if(!"".equals(pkbh)){
		sqlWhere = sqlWhere + " and u.pkbh like '%"+pkbh+"%'";
	}

	//out.println("select "+ backfields + fromSql + "where " + sqlWhere);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageID,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+pageID+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"cnpdcc\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
	  tableString+="<col width=\"25%\" text=\"排款编号\" column=\"pkbh\" orderkey=\"pkbhs\" linkvaluecolumn=\"pklcid\" linkkey=\"requestid\"" +
      "   href=\"/workflow/request/ViewRequest.jsp\" target=\"_fullwindow\" />" +
	  "<col width=\"25%\" text=\"批次\" column=\"pcno\" orderkey=\"pcno\"/>"+
	  "<col width=\"25%\" text=\"总金额\" column=\"con\" orderkey=\"con\" />"+
	  "<col width=\"25%\" text=\"详细\" column=\"xx\" orderkey=\"xx\" otherpara=\"column:cs\" transmethod=\"goodbaby.util.tanchuang.getLinkType\"/>"+
	  "	</head>"+
         " </table>";
	
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>

	<script type="text/javascript">	
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
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
	function opera(){
		var ids = _xtable_CheckedCheckboxId();
		if(ids==""){
			top.Dialog.alert("请选择数据");
			return ;
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		var r=confirm("是否确认提交？！");
		if(r==true){
			var xhr = null;
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			}else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}
					//alert()
			if (null != xhr) {
				xhr.open("GET","/goodbaby/payment/dateInfo.jsp?ids="+ids+"&type=updateCN", false);
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
						}	
					}
				}
				xhr.send(null);			
			}			
		}
		window.location.reload();		
	}	


	
	function openDialog(url,title){
		dialog = new window.top.Dialog();
		dialog.currentWindow = window;
		var url = url;
		dialog.Title = title;
		dialog.Width = 1200;
		dialog.Height = 600;
		dialog.Drag = true;
		dialog.URL = url;
		dialog.maxiumnable=true;//允许最大化
		dialog.show();
	}
	function showVi(vid){
		if(vid=="") return ;
		var url = "/goodbaby/payment/dateInfoList.jsp?pklcid="+vid;
		var title = "基本信息查看";
		openDialog(url,title);	
	}
	</script>
</BODY>
</HTML>
