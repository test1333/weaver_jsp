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
	

String bfz_name = Util.null2String(request.getParameter("bfz_name"));  
String lfr_name = Util.null2String(request.getParameter("lfr_name"));  
String yyh_name = Util.null2String(request.getParameter("yyh_name"));  
String fzc_name = Util.null2String(request.getParameter("fzc_name"));

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
				<wea:item>被访人</wea:item>
				<wea:item><input class=inputstyle id='bfz_name' name=bfz_name  value="<%=bfz_name%>" ></wea:item>
				<wea:item>访客姓名</wea:item>
				<wea:item><input class=inputstyle id='lfr_name' name=lfr_name  value="<%=lfr_name%>" ></wea:item>
				<wea:item>预约号</wea:item>
				<wea:item><input class=inputstyle id='yyh_name' name=yyh_name  value="<%=yyh_name%>" ></wea:item>
				<wea:item>放置处</wea:item>
				<wea:item><input class=inputstyle id='fzc_name' name=fzc_name  value="<%=fzc_name%>" ></wea:item>
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
		 String backfields = " za.xh,decode(za.type,0,'弱电',1,'运维',2,'应用系统') as leibie,za.details2,"
		 +" decode(za.details2,0,'综合布线',1,'网络',2,'视频系统',3,'考勤门禁',4,'监控系统',5,'电话',6,'桌面支持',7,'服务器',8,'数据库',9,'存储',10,'会务',11,'SAP ERP',12,'Kingdee ERP',13,'鼎捷 ERP',14,'泛微OA',15,'EMC D2',16,'HR',17,'BI',18,'FineReport',19,'旧OA') as new1,"
		 +" za.details3,decode(za.details3,0,'故障恢复方法',1,'根本解决方案',2,'操作手册',3,'管理规程',4,'其他知识') as new2,"
		 +" za.recorder,za.subject,za.descrip,za.reason,za.solution,za.unsolutioned,za.recorddate,za.remark,za.attached  ";
            String fromSql  = " from formtable_main_325 za ";
			
            String sqlWhere = "  za.details2 in (6,7,8,9,10) ";
          
		   if(!"".equals(bfz_name)){
				bfz_name = bfz_name.trim();
				sqlWhere += "and za.bfz in (select id from hrmresource where lastname like '%"+bfz_name+"%')";
			}

			
		   if(!"".equals(lfr_name)){
				lfr_name = lfr_name.trim();
				sqlWhere += "and za.lfr like '%"+lfr_name+"%' ";
			}

			if(!"".equals(yyh_name)){
				yyh_name = yyh_name.trim();
				sqlWhere += "and za.yyh ="+yyh_name+" ";
			}

            if(!"".equals(fzc_name)){
				fzc_name = fzc_name.trim();
				sqlWhere += "and za.fzc like '%"+fzc_name+"%' ";
			}
			//if(!"".equals(resourceid)){   
				//sqlWhere += "and za.operateuserid ="+resourceid+" ";
			//}
            
           
			//System.out.println(sqlWhere);
            String orderby = " recorder " ;
			
			//out.println("select "+ backfields + fromSql + " where " + sqlWhere);
            String tableString = "";
			String operateString= "";

			operateString = " <operates>";
			operateString +="    <popedom transmethod=\"weaver.workflow.workflow.WFAgentTransMethod.getAgentOperation\" ></popedom> ";
			//operateString +="     <operate  	href=\"javascript:doEditVisitor();\" text=\"来访登记\" otherpara=\"ct+column:id\" index=\"0\"/>";
			operateString +=" </operates>";
            tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"za.recorder\" sqlsortway=\"desc\" />"+
						   operateString +
                           "			<head>"+
						   " 				<col width=\"5%\" labelid=\"413\" text=\"记录人\" column=\"recorder\" orderkey=\"recorder\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
                           " 				<col width=\"4%\" labelid=\"413\" text=\"类别\" column=\"leibie\" orderkey=\"leibie\"  />"+
						   "				<col width=\"6%\" labelid=\"413\" text=\"二级分类\" column=\"new1\" orderkey=\"new1\"  />"+
                           "				<col width=\"6%\" labelid=\"413\" text=\"三级分类\" column=\"new2\" orderkey=\"new2\"  />"+
						   " 				<col width=\"6%\" labelid=\"413\" text=\"登记日期\" column=\"recorddate\" orderkey=\"recorddate\"  />"+
						   " 				<col width=\"8%\" labelid=\"413\" text=\"主题\" column=\"subject\" orderkey=\"subject\"  />"+
                           " 				<col width=\"9%\" labelid=\"413\" text=\"问题描述\" column=\"descrip\" orderkey=\"descrip\"  />"+
						   " 				<col width=\"28%\" labelid=\"413\" text=\"问题发生原因\" column=\"reason\" orderkey=\"reason\"  />"+
                           "				<col width=\"28%\" labelid=\"413\" text=\"解决方案\" column=\"solution\" orderkey=\"solution\" />"+ 
                          
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
			window.close("/gvo/visitor/GroupForVisitor.jsp");//关闭当前窗窗口
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
				var url = "/gvo/visitor/visitorEdit_wev8.jsp?id="+id+" ";
				dialog.Title = "来访登记";
				dialog.Width = 600;
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