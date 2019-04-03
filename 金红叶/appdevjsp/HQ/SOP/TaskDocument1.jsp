<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String projectID = request.getParameter("prjid");//项目ID
	String docname = Util.null2String(request.getParameter("docname"));
	String pejstatus = Util.null2String(request.getParameter("pejstatus"));
	String sopname = Util.null2String(request.getParameter("sopname"));
    String sopname_val = "";
	String sql="select a.name,a.id from prj_projectinfo a,cus_fielddata b where a.id=b.id  and b.scopeid='1' and a.id="+sopname;
	rs.executeSql(sql);
	if(rs.next()){
	sopname_val = Util.null2String(rs.getString("name"));
	}

	%>
	<BODY>
		<input type="hidden" name="pageId" id="pageId" value="proj"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<FORM id=report name=report action="/appdevjsp/HQ/SOP/TaskDocument1.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
		 <wea:item>项目名称</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="sopname" browserValue="<%=sopname%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_sop_title"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=sopname_val %>">
				</brow:browser>
				</wea:item>
		<wea:item>项目状态</wea:item>
			<wea:item>
				<select class="e8_btn_top middle" name="pejstatus" id="pejstatus"> 
				<option value="" <%if("".equals(pejstatus)){%> selected<%} %>>
					<%=""%></option>
				<option value="草案" <%if("草案".equals(pejstatus)){%> selected<%} %>>
					<%="草案"%></option>
				<option value="与各部门讨论" <%if("与各部门讨论".equals(pejstatus)){%> selected<%} %>>
					<%="与各部门讨论"%></option>
				<option value="向股东报告" <%if("向股东报告".equals(pejstatus)){%> selected<%} %>>
					<%="向股东报告"%></option>
				<option value="完成完整SOP" <%if("完成完整SOP".equals(pejstatus)){%> selected<%} %>>
					<%="完成完整SOP"%></option>
				<option value="书面呈准" <%if("书面呈准".equals(pejstatus)){%> selected<%} %>>
					<%="书面呈准"%></option>
			</select>
		</wea:item>

	    <wea:item>文档名称</wea:item>
	    <wea:item>
		<input type="text" name="docname" id="docname" class="InputStyle" value="<%=docname%>"/>
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
			<% // 查询条件 %>
		
		<%
		String backfields = " x.fullname,x.name,x.idy,x.status,x.idx,x.subject,x.docid,x.id,x.docSubject,x.seccategory,x.ownerid";
		String fromSql  = " from (select t4.fullname,t2.name,t2.id as idy,case t3.status when 4 then '书面呈准' when 3 then '完成完整SOP' when 2 then '向股东报告' when 1 then '与各部门讨论' "+
						" else '草案'end as status,t3.id as idx,t3.subject,t1.docid,t1.id,t5.docSubject,t5.seccategory,t5.ownerid "+
						" from Prj_Doc t1 left join Prj_ProjectInfo t2 on t1.prjid=t2.id left join Prj_TaskProcess t3 on t1.taskid=t3.id left join Prj_ProjectType "+
						"	t4 on t2.prjtype=t4.id left join docdetail t5 on t5.id=t1.docid "+
						"  union all select c.fullname,b.name,b.id as idy,case a.seccategory when  323 then '书面呈准' when 322 then '完成完整SOP' "+
						" when 321 then '向股东报告' when 283 then '与各部门讨论' when 282 then '草案' else '' end as status,null as idx,null as subject ,a.id as docid,a.id+100000000 as id, "+
						" a.docSubject,a.seccategory,a.ownerid from docdetail a left join Prj_ProjectInfo b on a.projectid=b.id left join Prj_ProjectType c on b.prjtype=c.id "+
						" ) x";
		String sqlWhere = " where 1=1";
		String orderby = " idy" ;
		String tableString = " ";

		if(!"".equals(pejstatus)){
			sqlWhere = sqlWhere + " and status ='"+pejstatus+"' ";
		}

		if(!"".equals(docname)){
			sqlWhere = sqlWhere + " and docSubject like '%"+docname+"%'";
		}
        if(!"".equals(sopname)){
			sqlWhere +=" and x.name = '"+sopname_val+"' ";
		}
		//out.print("select "+backfields+fromSql+sqlWhere);
		String  operateString= "";
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize("proj",user.getUID(),PageIdConst.HRM)+"\" pageId=\"proj\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"x.id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+="  <col width=\"15%\" labelid=\"项目类型\" text=\"项目类型\" column=\"fullname\" orderkey=\"fullname\"/>"+
			"               <col width=\"15%\" labelid=\"项目名称\" text=\"项目名称\" column=\"name\" orderkey=\"name\" linkvaluecolumn=\"idy\" linkkey=\"projectid\" href=\"/proj/data/ProjTab.jsp\" target=\"_fullwindow\"/>"+
			"               <col width=\"15%\" labelid=\"项目阶段\" text=\"任务阶段\" column=\"status\" orderkey=\"status\" />"+
			"				<col width=\"20%\" labelid=\"文档名称\" text=\"文档名称\" column=\"docid\"  otherpara=\"column:docSubject\" transmethod=\"weaver.splitepage.transform.SptmForDoc.getDocNameForDocMonitor\" linkvaluecolumn=\"docid\" linkkey=\"id\" href=\"/docs/docs/DocDsp.jsp\" target=\"_fullwindow\" />"+
			"               <col width=\"20%\" labelid=\"文档目录\" text=\"文档目录\" column=\"seccategory\" orderkey=\"seccategory\" transmethod='weaver.proj.util.ProjectTransUtil.getDocCategoryFullname'/>"+
			"               <col width=\"15%\" labelid=\"所有人\" text=\"所有人\" column=\"ownerid\" orderkey=\"ownerid\" transmethod='weaver.hrm.resource.ResourceComInfo.getResourcename' linkvaluecolumn=\"ownerid\" linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
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
		function onBtnSearchClick() {
			report.submit();
		}
	</script>
</BODY>
</HTML>