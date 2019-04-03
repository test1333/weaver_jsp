<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%
	int userid = user.getUID();
	user = (User)session.getAttribute("weaver_user@bean");
	user.setLanguage(7);
	int uid_1 = user.getUID();
if(uid_1!=-10&&uid_1!=1) {
	session.removeAttribute("weaver_user@bean");
	response.sendRedirect("/login/login.jsp") ;
	return ;
}//控制权限

String sqr_name = Util.null2String(request.getParameter("sqr_name"));  
String sqrbm_name = Util.null2String(request.getParameter("sqrbm_name"));  
String dcr1_name = Util.null2String(request.getParameter("dcr1_name"));  
String sqqrlxfs_name = Util.null2String(request.getParameter("sqqrlxfs_name"));

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
	String imagefilename = "/images/hdMaintenance_wev8.gif";
	String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
	+ SystemEnv.getHtmlLabelName(480, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(18599, user.getLanguage())
	+ SystemEnv.getHtmlLabelName(352, user.getLanguage());
	String needfav = "1";
	String needhelp = "";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
			<%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
		<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
		<FORM id=weaver name=weaver method=post action="" >
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<input type=button class="e8_btn_top"  value="返回主页" onClick="doReturn();">
						<span id="advancedSearch" class="advancedSearch">
						<%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
						</span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
						</span>
					</td>
				</tr>
			</table>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>申请人</wea:item>
				<wea:item><input class=inputstyle id='sqr_name' name=sqr_name  value="<%=sqr_name%>" ></wea:item>
				<wea:item>申请部门</wea:item>
				<wea:item><input class=inputstyle id='sqrbm_name' name=sqrbm_name  value="<%=sqrbm_name%>" ></wea:item>
				<wea:item>带出人</wea:item>
				<wea:item><input class=inputstyle id='dce1_name' name=dcr1_name  value="<%=dcr1_name%>" ></wea:item>
				<wea:item>申请人联系方式</wea:item>
				<wea:item><input class=inputstyle id='sqqrlxfs_name' name=sqqrlxfs_name  value="<%=sqqrlxfs_name%>" ></wea:item>
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
		 String backfields = " za.requestid,za.id,za.sqr,za.sqrbm,za.sjfxrq,za.sqrq,za.sqqrlxfs,za.dcr1,za.sqfxrq,za.csmc,za.wpmc,za.ggxh,za.dw,za.sl,"
							  +" '&lt;img src=&quot;/images/rule_1.jpg&quot; border=&quot;0&quot;/&gt;' as desc_1 ";
            String fromSql  = " from (select f2.requestid,f2.id,f2.sqr,f2.sqrbm,f2.sjfxrq,f2.sqrq,f2.sqqrlxfs,f2.dcr1,f2.sqfxrq,f2.csmc,f1.wpmc,f1.ggxh,f1.dw,f1.sl from formtable_main_234_dt1 f1 left join formtable_main_234 f2 on f1.mainid = f2.id) za ";
			
            String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype in (3) ) ";
          
		   if(!"".equals(sqr_name)){
				sqr_name = sqr_name.trim();
				sqlWhere += " and za.sqr in (select id from hrmresource where lastname like '%"+sqr_name+"%')";
			}

			
		   if(!"".equals(sqrbm_name)){
				sqrbm_name = sqrbm_name.trim();
				sqlWhere += " and za.sqrbm in (select id from HrmDepartment where departmentmark like '%"+sqrbm_name+"%')";
			}

			if(!"".equals(dcr1_name)){
				dcr1_name = dcr1_name.trim();
				sqlWhere += "and za.dcr1 like '%"+dcr1_name+"%' ";
			}

            if(!"".equals(sqqrlxfs_name)){
				sqqrlxfs_name = sqqrlxfs_name.trim();
				sqlWhere += " and za.sqqrlxfs like '%"+sqqrlxfs_name+"%' ";
			}
			//if(!"".equals(resourceid)){   
				//sqlWhere += "and za.operateuserid ="+resourceid+" ";
			//}
            
            //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//out.println(sqlWhere);
            String orderby = " sqfxrq,sqr " ;
            String tableString = "";
			 tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		
            //tableString =" <table  tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           "			<head>"+
						   " 				<col width=\"6%\" text=\"申请人\" column=\"sqr\" orderkey=\"sqr\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
						   "                <col width=\"7%\" text=\"申请日期\" column=\"sqrq\" orderkey=\"sqrq\" />"+ 
                           " 				<col width=\"7%\" text=\"申请部门\" column=\"sqrbm\" orderkey=\"sqrbm\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\" />"+
						   "				<col width=\"8%\" text=\"申请放行日期\" column=\"sqfxrq\" orderkey=\"sqfxrq\" />"+ 
						   "				<col width=\"6%\" text=\"带出人\" column=\"dcr1\" orderkey=\"dcr1\"  />"+
						   "				<col width=\"12%\" text=\"厂商名称\" column=\"csmc\" orderkey=\"csmc\"  />"+
                           "				<col width=\"6%\" text=\"申请人联系方式\" column=\"sqqrlxfs\" orderkey=\"sqqrlxfs\"  />"+
						   " 				<col width=\"7%\" text=\"物品名称\" column=\"wpmc\" orderkey=\"wpmc\"  />"+
						   " 				<col width=\"8%\" text=\"规格型号\" column=\"ggxh\" orderkey=\"ggxh\"  />"+
                           " 				<col width=\"6%\" text=\"单位\" column=\"dw\" orderkey=\"dw\"  />"+
						   " 				<col width=\"5%\" text=\"数量\" column=\"sl\" orderkey=\"sl\"  />"+
						   "				<col width=\"7%\" text=\"实际放行时间\" column=\"sjfxrq\" orderkey=\"sqfxrq\" />"+ 
                           "			</head>"+
                           "</table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	<script type="text/javascript">
		function onBtnSearchClick() {
			weaver.submit();
		}

		function doReturn() {
			Dialog.confirm("确认返回？", function (){
			window.open('','_self');//关闭IE提醒
			//window.close("/gvo/visitor/GroupForVisitor.jsp");//关闭当前窗窗口
			window.open('/gvo/redirect.jsp');
			//weaver.action="/gvo/redirect.jsp";
			//weaver.submit();
		
			}, function () {}, 320, 90,false);
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>