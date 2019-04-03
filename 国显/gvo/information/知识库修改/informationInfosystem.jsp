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
	
	String late_pageId = "late_info";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
			<%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=late_pageId%>"/>
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
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onClick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
			
	</FORM>
	<%
		String backfields = " requestid,za.xh,decode(za.type,0,'弱电',1,'运维',2,'应用系统') as leibie,za.details2,decode(za.details2,0,'综合布线',1,'网络',2,'视频系统',3,'考勤门禁',4,'监控系统',5,'电话',6,'桌面支持',7,'服务器',8,'数据库',9,'存储',10,'会务',11,'SAP ERP',12,'Kingdee ERP',13,'鼎捷 ERP',14,'泛微OA',15,'EMC D2',16,'HR',17,'BI',18,'FineReport',19,'旧OA') as new1,za.details3,decode(za.details3,0,'故障恢复方法',1,'根本解决方案',2,'操作手册',3,'管理规程',4,'其他知识') as new2,za.recorder,za.subject,za.descrip,za.reason,za.solution,za.unsolutioned,za.recorddate,za.remark,za.attached ";
        String fromSql  = " from formtable_main_325 za ";
			
            //String sqlWhere = " where 1=1 ";
			
		String sqlWhere = " za.details2 in (11,12,13,14,15,16,17,18,19) ";
          
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
            String orderby = " recorder,subject " ;
            String tableString = "";
			String operateString= "";

			operateString = " <operates>";
			operateString +="    <popedom transmethod=\"weaver.workflow.workflow.WFAgentTransMethod.getAgentOperation\" ></popedom> ";
			operateString +="     <operate  	href=\"javascript:doEditVisitor();\" text=\"放行登记\" otherpara=\"ct+column:id\" index=\"0\"/>";
			operateString +=" </operates>";
			 tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(late_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+late_pageId+"\">"+
	
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />"+
                           operateString +
						   "			<head>"+
						   " 				<col width=\"5%\" text=\"记录人\" column=\"recorder\" orderkey=\"recorder\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
						   "				<col width=\"4%\" text=\"类别\" column=\"leibie\" orderkey=\"leibie\"  />"+
						   "				<col width=\"6%\" text=\"二级分类\" column=\"new1\" orderkey=\"new1\"  />"+	
						   "				<col width=\"6%\" text=\"三级分类\" column=\"new2\" orderkey=\"new2\"  />"+	
						   "				<col width=\"6%\" text=\"登记日期\" column=\"recorddate\" orderkey=\"recorddate\"  />"+						   
                           "				<col width=\"8%\" text=\"主题\" column=\"subject\" orderkey=\"subject\"  />"+
                           "				<col width=\"9%\" text=\"问题描述\" column=\"descrip\" orderkey=\"descrip\"  />"+ 
						   "				<col width=\"28%\" text=\"问题发生原因\" column=\"reason\" orderkey=\"reason\"  />"+
                           "				<col width=\"28%\" text=\"解决方案\" column=\"solution\" orderkey=\"solution\"  />"+
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

		function doEditVisitor(id){
				//alert("1111");
				dialog = new window.top.Dialog();
				dialog.currentWindow = window;
				var id = id;
				//alert("id="+id);
				var url = "/gvo/release/releaseEdit_wev8.jsp?id="+id+" ";
				dialog.Title = "放行登记";
				dialog.Width = 750;
				dialog.Height =550;
				dialog.Drag = true;
				 
				dialog.URL = url;
				dialog.show();
		}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>