<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
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
String midd = Util.null2String(request.getParameter("aa"));
String multiIds = Util.null2String(request.getParameter("multiIds"));
String wlmcms = Util.null2String(request.getParameter("wlmcms"));
String resid = Util.null2String(request.getParameter("resid"));
int userid = user.getUID();
String pageID = "HHH21ds2";
if(multiIds.length()>=1){
	String iid[] =multiIds.split(",");
	if(midd.equals("1")){
		for(int j =0;j<iid.length;j++){
			String sqt = "update uf_inquirysheet set flag =1 where id ='"+iid[j]+"'";
			RecordSet.executeSql(sqt);
		}
	}else if(midd.equals("2")){
		for(int j =0;j<iid.length;j++){
			String sqt = "update uf_inquirysheet set dzzt =1 where id ='"+iid[j]+"'";
			RecordSet.executeSql(sqt);
		}
	}
	
	
	
}
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
	RCMenu += "{发起询价流程,javascript:CF(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{废弃不用,javascript:fq(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="/goodbaby/xj/InfoList.jsp" method=post>
	<input type="hidden" name="multiIds" value="">
	<input type="hidden" name="aa" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" id="cflc" name = "cflc"  value="触发流程" class="e8_btn_top" onClick="CF()" />
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>


	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
	
	    <wea:item>项目名称</wea:item>
		<wea:item>
			<input type="text" name="wlmcms" id="wlmcms" class="InputStyle" value="<%=wlmcms%>"/>
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
	String backfields = " u.id,u.WLMC,case when u.XJDLX=0 then '采购定价'  when u.XJDLX=1 then '出售定价' end as XJDLX  ,u.PP,u.XH,u.GG,(select f.dw from uf_unitForms f where f.id =u.DW )as DWNM,u.YT ,u.XJRQ,u.NPPDL,u.CGYXM ,u.BMTJR ,u.SJXQR,(select BMENU from uf_NPP where id = u.WLLX1) as WLLX1,u.SL,u.YGDJ,u.YGJE"; 
	String fromSql  = " from uf_inquirysheet u ";
	String sqlWhere = " where  u.flag='0' and u.dzzt='0' ";	
	if(userid!=1){
		sqlWhere =sqlWhere+" and u.BMTJR = '"+userid+"' ";
	}

	
	String orderby = " u.id " ;
	String tableString = "";
	
	
	if(!"".equals(wlmcms)){
		sqlWhere = sqlWhere + " and u.WLMC like '%"+wlmcms+"%'";
	}
	
	//out.println("select "+ backfields + fromSql + "where " + sqlWhere);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageID,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+pageID+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
	  tableString+="<col width=\"9%\" text=\"项目名称\" column=\"WLMC\" orderkey=\"WLMC\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=54&amp;formId=-253&amp;opentype=0&amp;customid=48&amp;viewfrom=fromsearchlist\" target=\"_fullwindow\" />"+
	  "<col width=\"7%\" text=\"询价类型\" column=\"XJDLX\" orderkey=\"XJDLX\" />"+
	  "<col width=\"7%\" text=\"询价日期\" column=\"XJRQ\" orderkey=\"XJRQ\" />"+
	  "<col width=\"10%\" text=\"物料类型\" column=\"WLLX1\" orderkey=\"WLLX1\" />"+
	  "<col width=\"7%\" text=\"数量\" column=\"SL\" orderkey=\"SL\" />"+
	  "<col width=\"7%\" text=\"预估单价\" column=\"YGDJ\" orderkey=\"YGDJ\" />"+
	  "<col width=\"7%\" text=\"预估金额\" column=\"YGJE\" orderkey=\"YGJE\" />"+	  
	  "<col width=\"7%\" text=\"品牌\" column=\"PP\" orderkey=\"PP\" />"+
	  "	<col width=\"7%\" text=\"型号\" column=\"XH\" orderkey=\"XH\" />"+
	  "	<col width=\"7%\" text=\"规格\" column=\"GG\" orderkey=\"GG\"  />"+
	  "	<col width=\"5%\" text=\"单位\" column=\"DWNM\" orderkey=\"DWNM\"  />"+
	  "	<col width=\"7%\" text=\"用途\" column=\"YT\" orderkey=\"YT\"  />"+
	  "<col width=\"5%\" text=\"实际需求人\" column=\"SJXQR\" orderkey=\"SJXQR\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" linkvaluecolumn=\"SJXQR\" linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\"/>"+
	  "<col width=\"6%\" text=\"部门提交人\" column=\"BMTJR\" orderkey=\"BMTJR\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" linkvaluecolumn=\"BMTJR\" linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\"/>"+
	  "	</head>"+
         " </table>";
	
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>

	<script type="text/javascript">
	function CF(){
		var ids = "";
		if(!ids){
			ids = _xtable_CheckedCheckboxId();
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		//alert("ids : "+ids);
		if(ids=="")
		{
			top.Dialog.alert("请选择要发起询价流程的数据");
			return ;
		}
		top.Dialog.confirm("确定要发起询价流程吗？", function (){
			var asd="2";
			document.report.action = "/goodbaby/xj/InfoList.jsp";
			document.report.aa.value = "1";
			document.report.multiIds.value = ids;
			document.report.submit();
		}, function () {
			
		}, 320, 90,true);
	}
	function fq(){
		var ids = "";
		if(!ids){
			ids = _xtable_CheckedCheckboxId();
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		//alert("ids : "+ids);
		if(ids=="")
		{
			top.Dialog.alert("请选择要废弃的数据");
			return ;
		}
		top.Dialog.confirm("确定要废弃不用吗？", function (){
			var asd="2";
			document.report.action = "/goodbaby/xj/InfoList.jsp";
			document.report.multiIds.value = ids;
			document.report.aa.value = "2";
			document.report.submit();
		}, function () {
			
		}, 320, 90,true);
		
		
		
	}
	
	
		
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
		// function doEditById(aid){	
			//alert(aid);
			// if(aid=="") return ;
			///window.location="/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//parent.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//window.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			// var url = "/goodbaby/ztb/bidUrl.jsp?id="+aid;
			// var title = "投标信息";
			// openDialog(url,title);
			
			
		// }
		
		
		// function openDialog(url,title){
			// dialog = new window.top.Dialog();
			// dialog.currentWindow = window;
			// var url = url;
			// dialog.Title = title;
			// dialog.Width = 1200;
			// dialog.Height = 600;
			// dialog.Drag = true;
			// dialog.URL = url;
			// dialog.maxiumnable=true;//允许最大化
			// dialog.show();
		// }
	</script>
</BODY>
</HTML>
