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
String multiIds = Util.null2String(request.getParameter("multiIds"));
String midd = Util.null2String(request.getParameter("aa"));
String wlmcms = Util.null2String(request.getParameter("wlmcms"));
String resid = Util.null2String(request.getParameter("resid"));
String cgzls = Util.null2String(request.getParameter("cgzls"));
int userid = user.getUID();
String pageID = "HHH21dsqqqq";
if(multiIds.length()>=1){
	String iid[] =multiIds.split(",");
	if(midd.equals("1")){
		for(int j =0;j<iid.length;j++){
			String sqt = "update uf_PR set flag =1 where id ='"+iid[j]+"'";
			RecordSet.executeSql(sqt);
		}
	}else if(midd.equals("2")){
		for(int j =0;j<iid.length;j++){
			String sqt = "update uf_PR set dzzt =1 where id ='"+iid[j]+"'";
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
	RCMenu += "{发起采购流程,javascript:CF(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{废弃不用,javascript:fq(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="" method=post>
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
	
	    <wea:item>采购种类</wea:item>
		<wea:item>
			<select id = 'CGZL' name ='CGZL' >
				<option value=''></option>
				<option value='0'>固定资产</option>
				<option value='1'>非固定资产</option>
			</select>
			<input type = "hidden" id = "cgzls" name = "cgzls" value ="<%=cgzls%>" />
			
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
	String backfields = "id,(select BMENU from uf_NPP where id =CGLX) as CGLX,case when CGZL=0 then '固定资产'  when CGZL=1 then '非固定资产' end as CGZLS ,SQRXX,SQDW,case when SFYYS=0 then '预算内'  when SFYYS=1 then '超预算' else '无预算'  end as SFYYSS,YQJHRQ "; //采购类型 采购种类  申请人信息,,申请单位, 是否有预算 交货日期----收货地址
	String fromSql  = " from uf_PR ";
	String sqlWhere = " where  flag='0' and dzzt='0'  ";	
	String orderby = " id " ;
	String tableString = "";
	if(userid!=1){
		sqlWhere = sqlWhere + " and SHR = '"+userid+"'";
		
	}
	
	if(!"".equals(cgzls)){
		sqlWhere = sqlWhere + " and CGZL ='"+cgzls+"'";
	}
	
	//out.println("select "+ backfields + fromSql+ sqlWhere);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageID,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+pageID+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
	  tableString+="<col width=\"16%\" text=\"采购类型\" column=\"CGLX\" orderkey=\"CGLX\"  linkkey=\"billid\"  linkvaluecolumn=\"id\"  href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=52&amp;formId=-242&amp;opentype=0&amp;customid=49&amp;viewfrom=fromsearchlist\"  target=\"_fullwindow\"  />"+
	   "<col width=\"16%\" text=\"采购种类\" column=\"CGZLS\" orderkey=\"CGZLS\"   />"+
	  
	  "<col width=\"16%\" text=\"申请人信息\" column=\"SQRXX\" orderkey=\"SQRXX\"  transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" linkvaluecolumn=\"SQRXX\"/>"+
	  
	 
	  "	<col width=\"16%\" text=\"申请单位\" column=\"SQDW\" orderkey=\"SQDW\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
	   "<col width=\"16%\" text=\"是否有预算\" column=\"SFYYSS\" orderkey=\"SFYYSS\"   />"+
	  "	<col width=\"16%\" text=\"交货日期\" column=\"YQJHRQ\" orderkey=\"YQJHRQ\"  />"+
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
			top.Dialog.alert("请选择要发起采购流程的数据");
			return ;
		}
		top.Dialog.confirm("确定要发起采购流程吗？", function (){
			var asd="2";
			document.report.action = "/goodbaby/cg/InfoList.jsp";
			document.report.multiIds.value = ids;
			document.report.aa.value = "1";
			document.report.submit();
		}, function () {
			
		}, 320, 90,true);
	}
		
	//搜索
	function OnSearch(){
		var ywlx_val = jQuery("#CGZL" + " option:selected").val();
		document.report.cgzls.value = ywlx_val;
		alert(ywlx_val);
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
		function fq(){
		var ids = "";
		if(!ids){
			ids = _xtable_CheckedCheckboxId();
		}
		if(ids.match(/,$/)){
			ids = ids.substring(0,ids.length-1);
		}
		alert("ids : "+ids);
		if(ids=="")
		{
			top.Dialog.alert("请选择要废弃的数据");
			return ;
		}
		top.Dialog.confirm("确定要废弃不用吗？", function (){
			var asd="2";
			document.report.action = "/goodbaby/cg/InfoList.jsp";
			document.report.multiIds.value = ids;
			document.report.aa.value = "2";
			document.report.submit();
		}, function () {
			
		}, 320, 90,true);
		
		
		
	}
	</script>
</BODY>
</HTML>
