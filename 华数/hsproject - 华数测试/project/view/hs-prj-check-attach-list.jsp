<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="hsproject.util.BrowserInfoUtil"%>
<%@ page import="hsproject.impl.ProcessInfoImpl"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="projectUtil" class="hsproject.util.ProjectUtil" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<script type="text/javascript" src="/js/doc/upload_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
    String out_pageId = "checkattachlist2";
    String prjid = Util.null2String(request.getParameter("prjid"));
	 String canSeeChange = Util.null2String(request.getParameter("canSeeChange"));
	ProcessInfoImpl pii = new ProcessInfoImpl();
	String docids = pii.getProcessAttachIds(prjid);

	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
	    <input type="hidden" name="pageId" id="pageId" value="<%=out_pageId%>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		if("1".equals(canSeeChange)){
		RCMenu += "{删除,javascript:deletedoc(),_self} " ;
		}
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/hsproject/project/view/hs-prj-check-attach-list.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<%if("1".equals(canSeeChange)){%>
						<input type="button" value="新建" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="adddoc()"/>
					<%}%>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
					


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
		String backfields = "rownum,id,name,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_prj_check_doc' and a.fieldname='type' and c.selectvalue=t1.type) as type,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_prj_check_doc' and a.fieldname='checktype' and c.selectvalue=t1.checktype) as checktype,attach,cjr,cjrq ";
		String fromSql  =  " from  (select * from uf_prj_check_doc where prjid='"+prjid+"' order by type asc) t1 ";
		String sqlWhere =  " 1=1 ";
		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  " rownum asc "  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table  needPage=\"false\" tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
				tableString +="<col width=\"6%\" text=\"序号\" column=\"rownum\" orderkey=\"rownum\" />"+
						"<col width=\"15%\" text=\"任务名称\" column=\"name\" orderkey=\"name\" />"+ 						
                		"<col width=\"10%\" text=\"类型\" column=\"type\" orderkey=\"type\"  />"+  
						"<col width=\"10%\" text=\"验收类型	\" column=\"checktype\" orderkey=\"checktype\"  />"+ 
						"<col width=\"10%\" text=\"创建人\" column=\"cjr\" orderkey=\"cjr\" transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink'/> />"+ 
						"<col width=\"10%\" text=\"创建日期\" column=\"cjrq\" orderkey=\"cjrq\"  />"+ 
						"<col width=\"30%\" text=\"附件\" column=\"attach\" orderkey=\"attach\"  transmethod='hsproject.impl.ProjectInfoImpl.getCheckAttachLink'/>"+                                 
						"</head>"+
		 "</table>";
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		
		function deletedoc(){
			var ids = _xtable_CheckedCheckboxId();
			 if(ids!=null && ids!=""){
				if(confirm("是否确认删除")){
					var xhr = null;
					if (window.ActiveXObject) {//IE浏览器
						xhr = new ActiveXObject("Microsoft.XMLHTTP");
					} else if (window.XMLHttpRequest) {
						xhr = new XMLHttpRequest();
					}
					if (null != xhr) {
						xhr.open("GET","/hsproject/project/aciton/delete-check-doc.jsp?ids="+ids, false);
						xhr.onreadystatechange = function () {
							if (xhr.readyState == 4) {
								if (xhr.status == 200) {
									var text = xhr.responseText;
									text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
									alert("删除成功");
									
								}	
							}
						}
					xhr.send(null);			
					}
					window.location.reload();
				}else{
					return false;
				}

			 }else{
				 alert("请先选择数据，再点击删除");
			 }	 
		}
		function adddoc() { 
  			var prjid="<%=prjid%>";
			var title = "";
			var url = "";			
			url="/formmode/view/AddFormMode.jsp?type=1&modeId=641&formId=-2422&opentype=0&field101307="+prjid;		
			var diag_vote = new window.top.Dialog();
			diag_vote.currentWindow = window;
			diag_vote.Width = 900;
			diag_vote.Height = 500;
			diag_vote.Modal = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.isIframe=false;		
			diag_vote.CancelEvent=function(){diag_vote.close();
				window.location.reload();
			};
			diag_vote.show();
		
		}
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>