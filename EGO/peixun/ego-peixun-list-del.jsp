<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
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
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
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
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String out_pageId = "peixunlbdel1";
	String pxry = Util.null2String(request.getParameter("pxry"));
	String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String beginDate1 = Util.null2String(request.getParameter("beginDate1"));
	String endDate1 = Util.null2String(request.getParameter("endDate1"));
	String cjr = Util.null2String(request.getParameter("cjr"));
	String beginDate2 = Util.null2String(request.getParameter("beginDate2"));
	String endDate2 = Util.null2String(request.getParameter("endDate2"));
	String department =Util.null2String(request.getParameter("department"));
	String departmentStr = "";
    String sql1 = "select departmentname from HrmDepartment where id in ("+department+")";
	rs.executeSql(sql1);
	String text="";
	String flag="";
	String gh = Util.null2String(request.getParameter("gh"));
	String colist = Util.null2String(request.getParameter("colist"));
	while(rs.next()){
	       departmentStr =departmentStr+""+flag;
	       text = Util.null2String(rs.getString("departmentname"));
		  departmentStr +=text;
		  flag = ",";
	   }

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
		if(lg==7){
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{删除,javascript:deldata(),_self} " ;
		//RCMenu += "{导入,javascript:daoru(),_self} " ;
		
		}else{
			RCMenu += "{Refresh,javascript:refersh(),_self} " ;
		RCMenu += "{delete,javascript:deldata(),_self} " ;
		//RCMenu += "{import,javascript:daoru(),_self} " ;
		}
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/ego/peixun/ego-peixun-list-del.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button"  value="删除" class="e8_btn_top" onClick="deldata()" />
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			
		
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<%if(lg==7){%>
				<wea:item>培训开始时间</wea:item>
				<%}else{%>
				<wea:item>starttime</wea:item>
				<%}%>
					 <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON>
                        <SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN>
                        <INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON>
                        <SPAN id=endDateSpan><%=endDate%></SPAN>
                        <INPUT type="hidden" name="endDate" id="endDate" value="<%=endDate%>">
                	</wea:item>
					<%if(lg==7){%>
						<wea:item>培训结束时间</wea:item>
					<%}else{%>
					<wea:item>endtime</wea:item>
					<%}%>
					 <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate1" onclick="onshowPlanDate('beginDate1','selectBeginDateSpan1')"></BUTTON>
                        <SPAN id=selectBeginDateSpan1 ><%=beginDate1%></SPAN>
                        <INPUT type="hidden" name="beginDate1" id="beginDate1" value="<%=beginDate1%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate1" onclick="onshowPlanDate('endDate1','endDateSpan1')"></BUTTON>
                        <SPAN id=endDateSpan1><%=endDate1%></SPAN>
                        <INPUT type="hidden" name="endDate1" id="endDate1" value="<%=endDate1%>">
                	</wea:item>
					<%if(lg==7){%>
						<wea:item>培训人员</wea:item>
					<%}else{%>
						<wea:item>person</wea:item>
				<%}%>
					<wea:item>
						<brow:browser viewType="0"  name="pxry" browserValue="<%=pxry %>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(pxry),user.getLanguage())%>">
						</brow:browser>
					</wea:item>
					<%if(lg==7){%>
						<wea:item>部门</wea:item>
						<%}else{%>
						<wea:item>department</wea:item>
					<%}%>
					<wea:item>
					<brow:browser viewType="0" name="department" browserValue='<%=department %>' 
					browserurl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
					completeUrl="/data.jsp?type=4"
					browserSpanValue='<%=Util.toScreen(departmentStr,user.getLanguage())%>'></brow:browser>
					</wea:item>
					<%if(lg==7){%>
						<wea:item>工号</wea:item>
						<%}else{%>
						<wea:item>workcode</wea:item>
					<%}%>
					<wea:item>
					<input name="gh" id="gh" class="InputStyle" type="text" value="<%=gh%>"/>
					</wea:item>

					<%if(lg==7){%>
						<wea:item>课程清单</wea:item>
						<%}else{%>
						<wea:item>Course List</wea:item>
					<%}%>
					<wea:item>
					<input name="colist" id="colist" class="InputStyle" type="text" value="<%=colist%>"/>
					</wea:item>
					<%if(lg==7){%>
						<wea:item>创建人</wea:item>
						<%}else{%>
						<wea:item>creater</wea:item>
					<%}%>
						<wea:item>
						<brow:browser viewType="0"  name="cjr" browserValue="<%=cjr%>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(cjr),user.getLanguage())%>">
						</brow:browser>
              		</wea:item>
					<%if(lg==7){%>
						<wea:item>创建日期</wea:item>
					<%}else{%>
					<wea:item>createDate</wea:item>
					<%}%>
					 <wea:item>
                    <button type="button" class=Calendar id="selectBeginDate2" onclick="onshowPlanDate('beginDate2','selectBeginDateSpan2')"></BUTTON>
                        <SPAN id=selectBeginDateSpan2 ><%=beginDate2%></SPAN>
                        <INPUT type="hidden" name="beginDate2" id="beginDate2" value="<%=beginDate2%>">
                    &nbsp;-&nbsp;
                    <button type="button" class=Calendar id="selectEndDate2" onclick="onshowPlanDate('endDate2','endDateSpan2')"></BUTTON>
                        <SPAN id=endDateSpan2><%=endDate2%></SPAN>
                        <INPUT type="hidden" name="endDate2" id="endDate2" value="<%=endDate2%>">
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
		<TABLE width="100%">
		<tr>
		<td>
		<%
		String backfields = " id,lastname,workcode,field11,field10,field12,field2,departmentcode,departmentname,jobtitlename,CourseList,Trainingcategory,year,starttime,endtime,xs,Trainingcenter,certificate,Attendance,fei,Cost,status,modedatacreater,modedatacreatedate";
		String fromSql  =  " from v_peixun_list_del ";
		String sqlWhere =  " 1=1 ";
		
		if(!"".equals(pxry)){
			sqlWhere = sqlWhere+" and pxry='"+pxry+"'";
		}
		
		if(!"".equals(beginDate)){
			sqlWhere = sqlWhere+" and startdate >='"+beginDate+"'";
		}
		if(!"".equals(endDate)){
			sqlWhere = sqlWhere+" and startdate <='"+endDate+"'";
		}
		if(!"".equals(beginDate1)){
			sqlWhere = sqlWhere+" and finishdate >='"+beginDate1+"'";
		}
		if(!"".equals(endDate1)){
			sqlWhere = sqlWhere+" and finishdate <='"+endDate1+"'";
		}

		if(!"".equals(department)){
			sqlWhere+=" and departmentid in("+department+") ";
		}
		if(!"".equals(gh)){
			sqlWhere+=" and upper(workcode) like upper('%"+gh+"%') ";
		}
		if(!"".equals(colist)){
			sqlWhere+=" and upper(CourseList) like upper('%"+colist+"%') ";
		}
		if(!"".equals(cjr)){
			sqlWhere = sqlWhere+" and modedatacreater='"+cjr+"'";
		}
		if(!"".equals(beginDate2)){
			sqlWhere = sqlWhere+" and modedatacreatedate >='"+beginDate2+"'";
		}
		if(!"".equals(endDate2)){
			sqlWhere = sqlWhere+" and modedatacreatedate <='"+endDate2+"'";
		}
		

		//out.print("select "+backfields+fromSql+" where "+sqlWhere);
		String orderby =  "id"  ;
		String tableString = "";
		String operateString= "";
		  tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+         
				   "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
		operateString+
		"			<head>";
		if(lg==7){
				tableString +="<col width=\"120px\" text=\"创建人\" column=\"modedatacreater\" orderkey=\"modedatacreater\" transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+ 
							"<col width=\"120px\" text=\"创建日期\" column=\"modedatacreatedate\" orderkey=\"modedatacreatedate\"  />"+ 
							"<col width=\"120px\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+ 
							"<col width=\"120px\" text=\"名\" column=\"field11\" orderkey=\"field11\"  />"+ 
							"<col width=\"120px\" text=\"姓\" column=\"field10\" orderkey=\"field10\"  />"+ 
							"<col width=\"120px\" text=\"合同类型\" column=\"field12\" orderkey=\"field12\"  />"+ 
							"<col width=\"120px\" text=\"成本中心\" column=\"field2\" orderkey=\"field2\"  />"+ 
							"<col width=\"120px\" text=\"组织单元代码\" column=\"departmentcode\" orderkey=\"departmentcode\"  />"+ 
							"<col width=\"120px\" text=\"组织单元名称\" column=\"departmentname\" orderkey=\"departmentname\"  />"+ 
							"<col width=\"120px\" text=\"职位\" column=\"jobtitlename\" orderkey=\"jobtitlename\"  />"+ 
							"<col width=\"120px\" text=\"课程清单\" column=\"CourseList\" orderkey=\"CourseList\"  />"+ 
							"<col width=\"120px\" text=\"培训目录\" column=\"Trainingcategory\" orderkey=\"Trainingcategory\"  />"+ 
							"<col width=\"120px\" text=\"培训年份\" column=\"year\" orderkey=\"year\"  />"+ 
							"<col width=\"120px\" text=\"开始时间\" column=\"starttime\" orderkey=\"starttime\"  />"+ 
							"<col width=\"120px\" text=\"结束时间\" column=\"endtime\" orderkey=\"endtime\"  />"+ 
							"<col width=\"120px\" text=\"时长\" column=\"xs\" orderkey=\"xs\"  />"+ 
							"<col width=\"120px\" text=\"培训中心\" column=\"Trainingcenter\" orderkey=\"Trainingcenter\"  />"+ 
							"<col width=\"120px\" text=\"相关证书\" column=\"certificate\" orderkey=\"certificate\"  transmethod='ego.peixun.TransUtil.getAttachUrl' />"+ 
							"<col width=\"120px\" text=\"参与情况\" column=\"Attendance\" orderkey=\"Attendance\"  />"+ 
							"<col width=\"120px\" text=\"个人培训费用\" column=\"fei\" orderkey=\"fei\"  />"+ 
							"<col width=\"120px\" text=\"该培训总费用\" column=\"Cost\" orderkey=\"Cost\"  />"+ 
							"<col width=\"120px\" text=\"状态\" column=\"status\" orderkey=\"status\"  />"+ 
				
						
						
						"</head>"+
		 "</table>";
		}else{
			tableString +="<col width=\"120px\" text=\"Creater\" column=\"modedatacreater\" orderkey=\"modedatacreater\" transmethod='weaver.proj.util.ProjectTransUtil.getResourceNamesWithLink' />"+ 
							"<col width=\"120px\" text=\"Create Date\" column=\"modedatacreatedate\" orderkey=\"modedatacreatedate\"  />"+ 
							"<col width=\"120px\" text=\"Personnel Number\" column=\"workcode\" orderkey=\"workcode\"  />"+ 
							"<col width=\"120px\" text=\"First Name\" column=\"field11\" orderkey=\"field11\"  />"+ 
							"<col width=\"120px\" text=\"Last Name\" column=\"field10\" orderkey=\"field10\"  />"+ 
							"<col width=\"120px\" text=\"Contract Type\" column=\"field12\" orderkey=\"field12\"  />"+ 
							"<col width=\"120px\" text=\"Cost Center\" column=\"field2\" orderkey=\"field2\"  />"+ 
							"<col width=\"120px\" text=\"Organizational Code\" column=\"departmentcode\" orderkey=\"departmentcode\"  />"+ 
							"<col width=\"120px\" text=\"Organizational Unit Name\" column=\"departmentname\" orderkey=\"departmentname\"  />"+ 
							"<col width=\"120px\" text=\"Position Name\" column=\"jobtitlename\" orderkey=\"jobtitlename\"  />"+ 
							"<col width=\"120px\" text=\"Course List\" column=\"CourseList\" orderkey=\"CourseList\"  />"+ 
							"<col width=\"120px\" text=\"Training Category\" column=\"Trainingcategory\" orderkey=\"Trainingcategory\"  />"+ 
							"<col width=\"120px\" text=\"Training Year\" column=\"year\" orderkey=\"year\"  />"+ 
							"<col width=\"120px\" text=\"Start Time\" column=\"starttime\" orderkey=\"starttime\"  />"+ 
							"<col width=\"120px\" text=\"End Time\" column=\"endtime\" orderkey=\"endtime\"  />"+ 
							"<col width=\"120px\" text=\"Duration\" column=\"xs\" orderkey=\"xs\"  />"+ 
							"<col width=\"120px\" text=\"Training Center\" column=\"Trainingcenter\" orderkey=\"Trainingcenter\"  />"+ 
							"<col width=\"120px\" text=\"Certificate\" column=\"certificate\" orderkey=\"certificate\" transmethod='ego.peixun.TransUtil.getAttachUrl' />"+ 
							"<col width=\"120px\" text=\"Attendance \" column=\"Attendance\" orderkey=\"Attendance\"  />"+ 
							"<col width=\"120px\" text=\"Price\" column=\"fei\" orderkey=\"fei\"  />"+ 
							"<col width=\"120px\" text=\"Cost\" column=\"Cost\" orderkey=\"Cost\"  />"+ 
							"<col width=\"120px\" text=\"Status\" column=\"status\" orderkey=\"status\"  />"+ 
				
						
						
						"</head>"+
		 "</table>";
		}
	//showExpExcel="false"
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
	</td>
		</tr>
		</TABLE>
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}

		function refersh() {
  			window.location.reload();
  		}
		function deldata() {
			var lg = "<%=lg%>";
			var ids = _xtable_CheckedCheckboxId();	
			//alert(ids);	
			if(ids==""){
				if(lg==7){
				top.Dialog.alert("请选择数据");
				}else{
				top.Dialog.alert("please choose data");
				}
				return ;
			}
			if(ids.match(/,$/)){
				ids = ids.substring(0,ids.length-1);
			}
			if(confirm("是否确认删除")){
            }else{
                return;
            }

			var result = "";
			jQuery.ajax({
					type: "POST",
					url: "/ego/peixun/deletepxdata.jsp",
					data: {'pxids':ids},
					dataType: "text",
					async:false,//同步   true异步
					success: function(data){
								data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
								result=data;
								alert(result);
							}
        	});
			if(result == "1"){
				if(lg==7){
					top.Dialog.alert("删除成功");
				}else{
					top.Dialog.alert("success");
				}
				
			}else{
				if(lg==7){
					top.Dialog.alert("删除失败");
				}else{
					top.Dialog.alert("fail");
				}
			}
			window.location.reload();

		}
	  
   </script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>