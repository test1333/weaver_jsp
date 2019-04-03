<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
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
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
			
	</FORM>
	<%
		 String backfields = " za.requestid,za.id,za.bfz,za.bfzlxdh,za.lfdw,za.lfr,za.lfrq,za.lfsj,za.fklx,za.cphm,za.lfsjbn,za.yyh,za.fzc,za.lfrs,"
							  +"za.lksjbn,decode(za.clsfjrcq,0,'是',1,'否','无记录') as sfjrcq ";
            String fromSql  = " from formtable_main_124 za ";
			
            String sqlWhere = " requestid in(select requestid from workflow_requestbase where currentnodetype>0 )"
			                  +" and (za.lfsjbn is not NULL and za.lksjbn is not NULL) ";
          
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
            
           // out.println("select "+ backfields + fromSql + " where " + sqlWhere);
			//System.out.println(sqlWhere);
            String orderby = " lfrq,yyh,lfsj " ;
            String tableString = "";
            tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
                           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />"+
                           "			<head>"+
						   " 				<col width=\"5%\" text=\"预约编号\" column=\"yyh\" orderkey=\"yyh\"  />"+
                           " 				<col width=\"15%\" text=\"访客姓名\" column=\"lfr\" orderkey=\"lfr\"  />"+
						   "				<col width=\"5%\" text=\"被访人\" column=\"bfz\" orderkey=\"bfz\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\" />"+
                           "				<col width=\"6%\" text=\"联系电话\" column=\"bfzlxdh\" orderkey=\"bfzlxdh\"  />"+
						   " 				<col width=\"5%\" text=\"车牌号码\" column=\"cphm\" orderkey=\"cphm\"  />"+
						   " 				<col width=\"5%\" text=\"车辆进入\" column=\"sfjrcq\" orderkey=\"sfjrcq\"  />"+
                           " 				<col width=\"15%\" text=\"来访公司\" column=\"lfdw\" orderkey=\"lfdw\"  />"+
						   " 				<col width=\"5%\" text=\"访客数量\" column=\"lfrs\" orderkey=\"lfrs\"  />"+
                           "				<col width=\"6%\" text=\"来访日期\" column=\"lfrq\" orderkey=\"lfrq\" />"+ 
                           "				<col width=\"5%\" text=\"预计来访\" column=\"lfsj\" orderkey=\"lfsj\"  />"+
						   " 				<col width=\"5%\" text=\"放置处\" column=\"fzc\" orderkey=\"fzc\"  />"+
						   "				<col width=\"5%\" text=\"实际来访\" column=\"lfsjbn\" orderkey=\"lfsjbn\" />"+ 
						   "				<col width=\"5%\" text=\"实际离开\" column=\"lksjbn\" orderkey=\"lksjbn\" />"+ 
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
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>