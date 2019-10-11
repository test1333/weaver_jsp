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

String zbwjbh = Util.null2String(request.getParameter("zbwjbh"));
String resid = Util.null2String(request.getParameter("resid"));
int userid = user.getUID();
String pageID = "HHH212";
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
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="/goodbaby/ztb/InfoList.jsp" method=post>
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
	
	    <wea:item>招标文件编号</wea:item>
		<wea:item>
			<input type="text" name="zbwjbh" id="zbwjbh" class="InputStyle" value="<%=zbwjbh%>"/>
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
	String table_name1 = "formtable_main_200";
 	String table_name2 = "formtable_main_200_dt1";
	String table_name3 = "formtable_main_223";
 	String table_name4 = "formtable_main_223_dt1";
	
	// String backfields = "d.id,d.requestid,c.requestname,d.ZBWJBH,b.kbrq+' '+b.kbsj  as ykbsj,case when b.lc = 0 then '一轮'  else '二轮' end as DQLC,d.BLZT "; 
	// String fromSql  = " from formtable_main_223 d, workflow_requestbase  c ,formtable_main_223_dt2 b ";
	// String sqlWhere = " where  d.requestid=c.requestid  and c.workflowid = 229 and b.mainid =d.id  and b.id in(select  t.mid from "
	// +"( select max(qw.id)as mid , qw.mainid from formtable_main_223_dt2 qw  group by qw.mainid )t ) ";	
	
	
	// String backfields = "d.id,d.requestid,c.requestname,d.ZBWJBH,b.TBRQ+' '+b.TBSJ  as ykbsj,case when b.lc = 0 then '一轮'  else '二轮' end as DQLC,d.BLZT "; 
	// String fromSql  = " from formtable_main_250 d, workflow_requestbase  c ,formtable_main_250_dt3 b ";
	// String sqlWhere = " where  d.requestid=c.requestid  and c.workflowid = 229 and b.mainid =d.id  and b.id in(select  t.mid from "
	// +"( select max(qw.id)as mid , qw.mainid from formtable_main_250_dt3 qw  group by qw.mainid )t ) ";
	
	
	
	
	String backfields = "d.id,d.requestid,c.requestnamenew as requestname,d.ZBWJBH,d.jzbqrq+' '+d.jzbqsj  as ykbsj,(select case when jzsj>0 then '投标进行中' else '投标结束' end as zt from  [dbo].[ztbzt] where wierid=d.requestid) as BLZT,(select aa.wlmc from uf_inquiryForm aa where aa.id=d.jgkxx ) as MC "; 
	String fromSql  = " from formtable_main_231 d, workflow_requestbase  c  ";
	String sqlWhere = " where  d.requestid=c.requestid  and c.workflowid = 287  and (d.zbj>0 or d.zbj1>0)";	

	if(userid==1){
		sqlWhere +=" and 1=1";
	}else{
		sqlWhere = sqlWhere+" and d.xtkh= '"+userid+"' ";
	}
	String orderby = " d.id " ;
	String tableString = "";
	
	
	if(!"".equals(zbwjbh)){
		sqlWhere = sqlWhere + " and d.ZBWJBH like '%"+zbwjbh+"%'";
	}
	
	//out.println("select "+ backfields + fromSql + "where " + sqlWhere);
	
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageID,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+pageID+"\">"+
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"d.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";                                                                                                                                                  
	  tableString+=
	  
	  "<col width=\"16%\" text=\"招标单号\" column=\"ZBWJBH\" orderkey=\"ZBWJBH\" linkvaluecolumn=\"id\" linkkey=\"id\" href=\"/goodbaby/ztb/bidUrl.jsp\" target=\"_fullwindow\" />"+
	  "	<col width=\"8%\" text=\"项目\" column=\"MC\" orderkey=\"MC\"  />"+
	  "	<col width=\"15%\" text=\"开标时间\" column=\"ykbsj\" orderkey=\"ykbsj\" />"+
	  
	  "	<col width=\"8%\" text=\"本轮状态\" column=\"BLZT\" orderkey=\"BLZT\"  />"+
	  "	</head>"+
    "<operates width=\"20%\">";
	tableString +=  
		 " <popedom transmethod=\"weaver.general.SplitPageTransmethod.getOpratePopedom\" otherpara=\"2\" ></popedom> "+
		 "     <operate href=\"javascript:doEditById()\"  linkkey=\"id\" linkvaluecolumn=\"id\" text=\"投标详情\" target=\"_fullwindow\" index=\"0\"/>"+    
		 "</operates>"+
         " </table>";
	
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  showExpExcel="false"/>

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
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
		function doEditById(aid){	
			//alert(aid);
			if(aid=="") return ;
			//window.location="/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//parent.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			//window.location.href = "/goodbaby/ztb/bidUrl.jsp?id ="+aid;
			var url = "/goodbaby/ztb/bidUrl.jsp?id="+aid;
			var title = "投标信息";
			openDialog(url,title);
			
			
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
	</script>
</BODY>
</HTML>
