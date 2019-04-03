
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.general.Util" %>
<%@page import="weaver.formmode.data.FieldInfo"%>
<%@page import="weaver.formmode.service.AppInfoService"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ include file="/formmode/pub_detach.jsp"%>
<jsp:useBean id="checkSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ReportTypeComInfo" class="weaver.workflow.report.ReportTypeComInfo" scope="page" />
<jsp:useBean id="formComInfo" class="weaver.workflow.form.FormComInfo" scope="page" />
<jsp:useBean id="billComInfo" class="weaver.workflow.workflow.BillComInfo" scope="page" />
<jsp:useBean id="workflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="SubComanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>

<%!

private String getFieldShowName(String fieldids){
	String showname = "";
	if(!fieldids.equals("")&&!fieldids.equals("0")){
		RecordSet rs1 = new RecordSet();
		String sql = "select b.indexdesc from workflow_billfield a,HtmlLabelIndex b where a.id in ("+fieldids+") and a.fieldlabel = b.id ";
		rs1.executeSql(sql);
		while(rs1.next()){
			showname = showname+","+rs1.getString("indexdesc");
		}
	}
	if(!showname.equals("")){
		showname = showname.substring(1);
	}
	return showname;
} 
%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET />
		<link href="/formmode/css/formmode_wev8.css" type="text/css" rel="stylesheet" />
		<SCRIPT language="javascript" src="/js/weaver_wev8.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="/formmode/js/WdatePicker/WdatePicker_wev8.js"></script>
			
		<link rel="stylesheet" type="text/css" href="/formmode/js/ext/lovCombo/css/Ext.ux.form.LovCombo_wev8.css">
		<link rel="stylesheet" type="text/css" href="/formmode/js/ext/lovCombo/css/webpage_wev8.css">
		<link rel="stylesheet" type="text/css" href="/formmode/js/ext/lovCombo/css/lovcombo_wev8.css">
		<script type="text/javascript" src="/formmode/js/ext/adapter/ext/ext-base_wev8.js"></script>
		<script type="text/javascript" language="javascript" src="/formmode/js/ext/ext-all_wev8.js"></script>
		<script type="text/javascript" src="/formmode/js/ext/lovCombo/ext-all_wev8.js"></script>

		<script type="text/javascript" src="/formmode/js/ext/lovCombo/Ext.ux.util_wev8.js"></script>
		<script type="text/javascript" src="/formmode/js/ext/lovCombo/Ext.ux.form.LovCombo_wev8.js"></script>
		<script type="text/javascript" src="/formmode/js/ext/lovCombo/Ext.ux.form.ThemeCombo_wev8.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/ext/ux/iconMgr_wev8.js"></script>
		
		 <link rel="stylesheet" type="text/css" href="/formmode/js/ext/resources/css/ext-all_wev8.css" />
	
	
		<style type="text/css">
			.e8_tblForm_f{
				padding-left: 10px;
			}
			.e8_tblForm_b{
				font-weight: bold;
			}
			.x-shadow .xsml{
				display: none;
			}
			.x-shadow .xsmc{
				background: none;
			}
			
			.x-ie-shadow{
				background: none;
			}
			
			.x-form-field-wrap .x-form-trigger{
				background-image: url("/wui/theme/ecology8/skins/default/general/browser_wev8.png") !important;
				border: 0px;
			}
			
			.x-form-field-wrap .x-form-trigger-over{
				background-position: 0 0;
			}
			
			.x-trigger-wrap-focus .x-form-trigger{
				background-position: 0 0;
			}
			
.codeEditFlag{
	padding-left:20px;
	padding-right: 10px;
	height: 16px;
	background:transparent url('/formmode/images/list_edit_wev8.png') no-repeat !important;
	cursor: pointer;
	margin-left: 2px;
	margin-top: 2px;
	position: relative;
}
.codeDelFlag{
	position: absolute;
	top: 2px;
	right: 2px;
	width:9px;
	height:9px;
	background:transparent url('/images/messageimages/delete_wev8.gif') no-repeat !important;
	cursor: pointer;	
}
		</style>
	</HEAD>
<%
	

	String imagefilename = "/images/hdHRMCard_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(30063,user.getLanguage());//自定义页面设置
	String needfav ="1";
	String needhelp ="";

	String customID = Util.null2String(request.getParameter("customID"));
	String customID1 = Util.null2String(request.getParameter("customID1"));
	String buff = "";
	String sqlx = "select Content from uf_custom_dynamic where id= " + customID;
	RecordSet.executeSql(sqlx);
	if(RecordSet.next()){
		buff = Util.null2String(RecordSet.getString("Content"));
	}
	
	
	String modename = "";
	String isrefresh = Util.null2String(request.getParameter("isrefresh"));
	String id = Util.null2String(request.getParameter("id"),"0");
    
    String uqid = "";
	
	
	int formid = 0;
	int modeid = 0;
	String appid = Util.null2String(request.getParameter("appid"),"1");
	int creator = 0;
	
	
	int reminddatefield = 0;
	int remindtimefield = 0;
	
	
	

	int incrementtype = 0;
	int incrementfield = 0;

	
	int remindway = 0;
	int sendertype = 1;
	int senderfield = 0;
	String reminddml = "";
	String remindjava = "";
	
	int conditionstype = 0;
	String conditionsfield = "";
	String conditionsfieldcn = "";
	String conditionssql = "";
	String conditionsjava = "";
	
	String subject = "";
	int remindcontenttype = 0;
	
	String remindcontentjava = "";
	
	
	String receiverdetail = "";
	int receiverfieldtype = 0;
	String receiverfield = "";
	
	
	int triggerway = 0;
	int triggertype = 0;
	int triggercycletime = 0;
	String triggerexpression = "";
	
	String weeks = "";
	String months = "";
	String days = "";
	
	
	int remindHZ = 0;
	String title = "集团动态信息提醒";
	int over_active = 0;
	String deDate = "";
	String deTime = "";
	String deDate1 = "";
	String deTime1 = "";
	String remarks = buff;
	int incrementnum = 0;
	int incrementunit = 0;
	int incrementway = 0;
	int receivertype = 0;
	int level = 10;
	int areaType = 0;
	String stopID = "";
	String dateField = "";
	String timeField = "";
	int remindtimetype = 0;
	String tableName = "";
	String infowhere = "";
	int selStopInfo = 0;
	int LeadType = 1;
	String areaVal = "";
	String sql = "select * from uf_remindRecord where id="+id;
	
	RecordSet.executeSql(sql);
	while(RecordSet.next()){
	    title = Util.null2String(RecordSet.getString("title")) ;
	    over_active = Util.getIntValue(RecordSet.getString("over_active"),0);
	    remindHZ = Util.getIntValue(RecordSet.getString("remindHZ"),0);
	    deDate = Util.null2String(RecordSet.getString("deDate"));
	    deTime = Util.null2String(RecordSet.getString("deTime"));
	    deDate1 = Util.null2String(RecordSet.getString("deDate1"));
	    deTime1 = Util.null2String(RecordSet.getString("deTime1"));
	    remarks = Util.null2String(RecordSet.getString("remarks"));
	    incrementnum = Util.getIntValue(RecordSet.getString("incrementnum").replace(".00", ""),0);
	    incrementunit = Util.getIntValue(RecordSet.getString("incrementunit"),0);
	    incrementway = Util.getIntValue(RecordSet.getString("incrementway"),0);
	    areaType = Util.getIntValue(RecordSet.getString("areaType"),0);
	    level = Util.getIntValue(RecordSet.getString("level"),10);
	    stopID = Util.null2String(RecordSet.getString("stopID"));
	    dateField = Util.null2String(RecordSet.getString("dateField"));
	    timeField = Util.null2String(RecordSet.getString("timeField"));
	    remindtimetype = Util.getIntValue(RecordSet.getString("remindtimetype"),0);
	    tableName = Util.null2String(RecordSet.getString("tableName"));
	    infowhere = Util.null2String(RecordSet.getString("infowhere"));
	    selStopInfo = Util.getIntValue(RecordSet.getString("selStopInfo"),0);
	    LeadType = Util.getIntValue(RecordSet.getString("LeadType"),1);
	    areaVal = Util.null2String(RecordSet.getString("areaVal"));
	    
	    
	    formid = Util.getIntValue(RecordSet.getString("formid"),0);
	    modeid = Util.getIntValue(RecordSet.getString("modeid"),0);
	    appid = Util.null2String(RecordSet.getString("appid"));
	    creator = Util.getIntValue(RecordSet.getString("creator"),0);
	    
	    
	    reminddatefield = Util.getIntValue(RecordSet.getString("reminddatefield"),0);
	    remindtimefield = Util.getIntValue(RecordSet.getString("remindtimefield"),0);
	    
	    
	    incrementtype = Util.getIntValue(RecordSet.getString("incrementtype"),0);
	    incrementfield = Util.getIntValue(RecordSet.getString("incrementfield"),0);
	    
	    remindway = Util.getIntValue(RecordSet.getString("remindway"),0);
	    sendertype = Util.getIntValue(RecordSet.getString("sendertype"),1);
	    senderfield = Util.getIntValue(RecordSet.getString("senderfield"),0);
	    reminddml = Util.null2String(RecordSet.getString("reminddml"));
	    remindjava = Util.null2String(RecordSet.getString("remindjava"));
	    
	    conditionstype = Util.getIntValue(RecordSet.getString("conditionstype"),0);
	    conditionsfield = Util.null2String(RecordSet.getString("conditionsfield"));
	    conditionsfieldcn = Util.null2String(RecordSet.getString("conditionsfieldcn"));
	    conditionssql = Util.null2String(RecordSet.getString("conditionssql"));
	    conditionsjava = Util.null2String(RecordSet.getString("conditionsjava"));
	    
	    subject = Util.null2String(RecordSet.getString("subject"));
	    remindcontenttype = Util.getIntValue(RecordSet.getString("remindcontenttype"),0);
	    
	    remindcontentjava = Util.null2String(RecordSet.getString("remindcontentjava"));
	   
	    
	    receiverdetail = Util.null2String(RecordSet.getString("receiverdetail"));
	    receiverfieldtype = Util.getIntValue(RecordSet.getString("receiverfieldtype"),0);
	    receiverfield = Util.null2String(RecordSet.getString("receiverfield"));
	    
	    
	    triggerway = Util.getIntValue(RecordSet.getString("triggerway"),0);
	    triggertype = Util.getIntValue(RecordSet.getString("triggertype"),0);
	    triggerexpression = Util.null2String(RecordSet.getString("triggerexpression"));
	    triggercycletime = Util.getIntValue(RecordSet.getString("triggercycletime"),0);
	    
	    weeks = Util.null2String(RecordSet.getString("weeks"));
	    months = Util.null2String(RecordSet.getString("months"));
	    days = Util.null2String(RecordSet.getString("days"));
	    
	}
	List mustInputList = new ArrayList();
	mustInputList.add("name");
	mustInputList.add("formid");
	String needInputImg = "<img align='absMiddle' src='/images/BacoError_wev8.gif' >";
	
	String subCompanyIdsql = "SELECT b.subcompanyid FROM mode_remindjob a,modeTreeField b WHERE a.appid=b.id AND a.id="+id;
	RecordSet recordSet = new RecordSet();
	recordSet.executeSql(subCompanyIdsql);
	int subCompanyId = -1;
	if(recordSet.next()){
		subCompanyId = recordSet.getInt("subCompanyId");
	}
	if(subCompanyId==-1){
		AppInfoService appInfoService = new AppInfoService();
		Map<String, Object> appInfo = appInfoService.getAppInfoById(Util.getIntValue(appid));
		subCompanyId = Util.getIntValue(Util.null2String(appInfo.get("subcompanyid")),-1);
	}
	String userRightStr = "FORMMODEAPP:ALL";
	Map rightMap = getCheckRightSubCompanyParam(userRightStr,user,fmdetachable, subCompanyId,"",request,response,session);
	int operatelevel = Util.getIntValue(Util.null2String(rightMap.get("operatelevel")),-1);
	subCompanyId = Util.getIntValue(Util.null2String(rightMap.get("subCompanyId")),-1);
%>
<%if(isrefresh.equals("1")){%>
<script type="text/javascript">
jQuery(function($){
	parent.parent.refreshCustomPage("<%=id%>");
});
</script>
<%}%>

	<BODY>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		
		<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;//保存
				RCMenuHeight += RCMenuHeightStep;
		if(id.equals("0")){
			if(operatelevel>0){
				RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;//保存
				RCMenuHeight += RCMenuHeightStep;
			}
		}else{
			if(operatelevel>0){
				RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;//保存
				RCMenuHeight += RCMenuHeightStep;
			}
			if(operatelevel>1){
				RCMenu += "{"+SystemEnv.getHtmlLabelName(91,user.getLanguage())+",javascript:onDelete(),_self} " ;//删除
				RCMenuHeight += RCMenuHeightStep;
			}
			if(operatelevel>0){
				RCMenu += "{"+SystemEnv.getHtmlLabelName(82210,user.getLanguage())+",javaScript:doAdd(),_self} " ;//新建提醒
				RCMenuHeight += RCMenuHeightStep ;
			}
		}
		if(remindHZ==2){
			if(operatelevel>0){
				RCMenu += "{"+SystemEnv.getHtmlLabelName(82211,user.getLanguage())+",javaScript:initRemindData(),_self} " ;//初始化到期提醒
				RCMenuHeight += RCMenuHeightStep ;
			}
		}
		%>

		<FORM id=weaver name=frmMain action="/seahonor/remind/RemindJobSettingsAction.jsp" method=post>
			<input type="hidden" name="titleUrl" id="titleUrl" value="#seahonor#crm#CustomGroupDynamic.jsp##customID=<%=customID1%>">
			<input type="hidden" name="appid" id="appid" value="<%=appid %>">
			<input type="hidden" name="operation" id="operation" value="saveorupdate">
			<input type="hidden" name="uqid" id="uqid" value="<%=uqid%>">
			<input type="hidden" name="creator" id="creator" value="<%=user.getUID()%>">
			
			<wea:layout type="1col" attributes="{'expandAllGroup':'true'}">
				<wea:group context="基本信息" attributes="{'groupOperDisplay':none}">
					<wea:item>
				<TABLE class="e8_tblForm">
				<COLGROUP>
					<COL width="20%">
					<COL width="80%">
				</COLGROUP>
			  	<TBODY>
                    <TR>
                      <TD class="e8_tblForm_label">名称</TD>
                      <TD class="e8_tblForm_field">
                      		<INPUT type=text class=Inputstyle style="width:80%" id="title" name="title" onchange='checkinput("title","titleSpan")' value="<%=title%>">
                      		<SPAN id=titleSpan>
                      			<%if(title.equals("")){%>
                      				<%=needInputImg %>	
                      			<%}%>
                      		</SPAN>
                      </TD>
                    </TR> 
                    <TR>
                      <TD class="e8_tblForm_label">是否启用<!-- 是否启用 --></TD>
                      <TD class="e8_tblForm_field">
                      		<INPUT type="checkbox" class=Inputstyle <%if(over_active!=0){%>checked="checked"<%} %> style="width:80%" id="over_active" onclick="changeBoxVal(this)" name="over_active"  value="<%=over_active %>">
                      </TD>
                    </TR>
                    <TR>
                      <TD class="e8_tblForm_label">提醒类型<!-- 提醒类型 --></TD>
                      <TD class="e8_tblForm_field">
                      		<select name="remindHZ" id="remindHZ" onchange="remindtypeChange()" style="width: 200px;">
                      			<option value="1" <%if(remindHZ==1){%>selected="selected"<%} %> >即时提醒<!-- 即时提醒 --></option>
                      			<option value="2" <%if(remindHZ==2){%>selected="selected"<%} %> >到期提醒<!-- 到期提醒 --></option>
                      			<option value="3" <%if(remindHZ==3){%>selected="selected"<%} %> >循环提醒<!-- 循环提醒 --></option>
                      		</select>
                      </TD>
                    </TR>         
                      
                    <%
                    	String checkedStr1 = "";
                    	String checkedStr2 = "";
                    	String spanCss1 = "";
                    	String spanCss2 = "";
                    	if(remindtimetype==1||remindtimetype==0){
                    		checkedStr1 = "checked";
                    		spanCss2 = "display:none;";
                    	}else{
                    		checkedStr2 = "checked";
                    		spanCss1 = "display:none;";
                    	}
                    	String trCss1 = "display:none;";
                    	if(remindHZ==2){
                    		trCss1 = "";
                    	}
                    %>
                    
                    <TR style="<%=trCss1 %>" class="remindtimeTR1">
                      <TD class="e8_tblForm_label"><%=SystemEnv.getHtmlLabelName(82215,user.getLanguage())%><!-- 到期时间 -->
                      <div class="cbboxContainer">
							<span class="cbboxEntry">
								<input type="checkbox" name="remindtimetype" <%=checkedStr1 %> value="1" onclick="changeSCT(this)" /><span class="cbboxLabel">常量</span>
							</span>
							<span class="cbboxEntry">
								<input type="checkbox" name="remindtimetype" <%=checkedStr2 %> value="2" onclick="changeSCT(this)" /><span class="cbboxLabel">字段</span>
							</span>
						 </div>
                      </TD>
                      <TD class="e8_tblForm_field">
                      
                      <span id="remindtimetype_1"  class="remindtimetypeSpan" style="<%=spanCss1%>">
                  		<table>
                      		<tr>
                      			<td class="e8_tblForm_f"><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%><!-- 日期  --></td>
                      			<td class="e8_tblForm_f">
                      			<input name="deDate" class="calendar" style="width: 120px;" id="deDate" onclick="WdatePicker()" onchange="checkinput('deDate','deDateSpan')" type="text" value="<%=deDate %>">
                      			<span id="deDateSpan">
                      				<%if(deDate.equals("")){%>
                      					<%=needInputImg %>
                      				<%} %>
                      			</span>
							</td>
                      			<td class="e8_tblForm_f">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SystemEnv.getHtmlLabelName(277,user.getLanguage())%><!-- 时间 --> </td>
                      			<td class="e8_tblForm_f">
                      			<input name="deTime" class="calendar" style="width: 120px;" id="deTime" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" onchange="checkinput('deTime','deTimeSpan')" type="text" value="<%=deTime %>">
                      			<span id="deTimeSpan">
                      				<%if(deTime.equals("")){%>
                      					<%=needInputImg %>
                      				<%} %>
                      			</span>
							</td>
                      		</tr>
                      	</table>
                  	</span>
                  		<span id="remindtimetype_2"  class="remindtimetypeSpan" style="<%=spanCss2 %>">
                  		<table>
                      		<tr>
                      			<td class="e8_tblForm_f">日期字段</td>
                      			<td class="e8_tblForm_f">
                      				<input type="text" style="width: 100%;" name="dateField" id="dateField" value="<%=dateField %>" />		
                      			</td>
                      						
                      			<td class="e8_tblForm_f">时间字段</td>
                      			<td class="e8_tblForm_f">
                      				<input type="text" style="width: 100%;" name="timeField" id="timeField" value="<%=timeField %>" />
								</td>
									
								<td class="e8_tblForm_f">&nbsp;</td>
								<td class="e8_tblForm_f">相关表</td>
                      			<td class="e8_tblForm_f">
                      				<input type="text" style="width: 100%;" name="tableName" id="tableName" value="<%=tableName %>" />
								</td>
                      		</tr>
                      		<tr>
                      			<td class="e8_tblForm_f">相关条件<br>(需要where)</td>
                      			<td class="e8_tblForm_f" colspan="7">
                      				<input type="text" style="width: 100%;" name="infowhere" id="infowhere" value="<%=infowhere %>" />
								</td>
                      		</tr>
                      	</table>
                  	</span>					
                  		
                      </TD>
                    </TR>                      
                   
                   <tr style="<%=trCss1 %>" class="remindtimeTR2">
						<td class="e8_tblForm_label e8_tblForm_last"><%=SystemEnv.getHtmlLabelName(82219,user.getLanguage())%><!-- 时间增量 --></td>
						<td class="e8_tblForm_field e8_tblForm_last">
							<table style="width: 100%;">
								<colgroup>
									<col style="width: 20%">
									<col style="width: 20%">
									<col style="width: 25%">
									<col style="width: 30%">
								</colgroup>
								<tr>
									<td>
										<select name="incrementway" id="incrementway" style="width: 80px;">
											<option value=""></option>
											<option value="1" <%if(incrementway==1){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(17548,user.getLanguage())%><!-- 提前 --></option>
											<option value="2" <%if(incrementway==2){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(82220,user.getLanguage())%><!-- 延迟 --></option>
										</select>
									</td>
									<td>
										<select name="incrementtype" id="incrementtype" style="width: 80px;" onchange="changeIncrementtype();">
											<option value="1" <%if(incrementtype==1){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(82221,user.getLanguage())%><!-- 整数常量 --></option>
										<!--	<option value="2" <%if(incrementtype==2){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(82222,user.getLanguage())%> 整数字段 </option>-->
										</select>
									</td>
									<td>
										<span id="incrementSpan1" <%if(incrementtype==2){%>style="display: none;"<%} %>>
											<input type="text" style="width: 100%;" name="incrementnum" id="incrementnum" value="<%=incrementnum %>" onKeyPress="ItemCount_KeyPress()" /></span>
										<span id="incrementSpan2" <%if(incrementtype!=2){%>style="display: none;"<%} %>>
											<brow:browser viewType="0" id="tablekey" name="incrementfield" browserValue="<%=incrementfield+"" %>" 
						  		 				browserUrl="'+getShowUrl(3)+'"
												hasInput="false" isSingle="true" hasBrowser = "true" isMustInput="1"
												completeUrl="/data.jsp" linkUrl=""  width="222px"
												browserDialogWidth="510px"
												browserSpanValue="<%=getFieldShowName(incrementfield+"") %>"
											></brow:browser>
										</span>
									</td>
									<td>
										<select name="incrementunit" id="incrementunit" style="width: 80px;">
											<option value="1" <%if(incrementunit==1){%>selected="selected"<%} %>>分钟</option>
											<option value="2" <%if(incrementunit==2){%>selected="selected"<%} %>>小时</option>
											<option value="3" <%if(incrementunit==3){%>selected="selected"<%} %>>天</option>
											<option value="4" <%if(incrementunit==4){%>selected="selected"<%} %>>月</option>
										</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</TBODY>
					</TABLE>
					</wea:item>
				</wea:group>
			
				<wea:group context="<%=SystemEnv.getHtmlLabelName(18121,user.getLanguage())%>" attributes="{'groupOperDisplay':none}"><!-- 提醒信息 -->
					<wea:item>
					
			
			<TABLE class="e8_tblForm">
				<COLGROUP>
					<COL width="20%">
					<COL width="80%">
				</COLGROUP>
			  	<TBODY>
                   
	                    <%   
		                     String bname = "<IMG src=\"/images/BacoError_wev8.gif\" align=absMiddle>";
					  		 RecordSet.executeSql("select * from workflow_bill where id='"+formid+"'");
					 		 
				  		 %>
						          
                      
                    <%
                    	FieldInfo fieldInfo = new FieldInfo();
                    	String checkedStr1 = "";
                    	String checkedStr2 = "";
                    	String spanCss1 = "";
                    	String spanCss2 = "";
                    	if(id.equals("0")||remindtimetype==1){
                    		checkedStr1 = "checked";
                    		spanCss2 = "display:none;";
                    	}else{
                    		checkedStr2 = "checked";
                    		spanCss1 = "display:none;";
                    	}
                    %>
                           
                    
					<tr>       
					<%
						checkedStr1 = "";
	                	checkedStr2 = "";
	                	spanCss1 = "";
	                	spanCss2 = "";
	                	if(id.equals("0")||remindcontenttype==1){
	                		checkedStr1 = "checked";
	                		spanCss2 = "display:none;";
	                	}else{
	                		checkedStr2 = "checked";
	                		spanCss1 = "display:none;";
	                	}
                    %>          
                    <TD class="e8_tblForm_label">提醒内容</TD>
                      <TD class="e8_tblForm_field">
							<textarea name="remarks" id="remarks"  rows="3" style="width: 70%"><%=remarks %></textarea>
                      </TD>
                    </TR>  
                    
					<tr>                 
                    <TD class="e8_tblForm_label">
                      	<%=SystemEnv.getHtmlLabelName(26731,user.getLanguage())%><!-- 提醒人员 -->
                      </TD>
                      <TD class="e8_tblForm_field">
                      		<select name="areaType" id="areaType" onchange="changeReceivertype();" >  
					           <option value="1" <%if(areaType==1){%>selected="selected"<%} %> >人员</option> <!-- 人员 -->
					           <option value="2" <%if(areaType==2){%>selected="selected"<%} %>>分部</option><!-- 分部 -->
					           <option value="3" <%if(areaType==3){%>selected="selected"<%} %>>部门</option><!-- 部门 -->
					           <option value="4" <%if(areaType==4){%>selected="selected"<%} %>>角色</option><!-- 角色 -->
					           <option value="5" <%if(areaType==5){%>selected="selected"<%} %>>所有人</option><!-- 所有人 -->
					         </select>
					         	<span id="receiverfieldtypespan" <%if(receivertype!=1000){%>style="display: none;"<%} %>>
					            <span><%=SystemEnv.getHtmlLabelName(686,user.getLanguage())%></span><!-- 字段类型 -->
						         
						         <select style="width: 80px;" class=InputStyle id="receiverfieldtype" name="receiverfieldtype" onchange="changeFieldType(this)">
						         	<option value="1" <%if(receiverfieldtype==1){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(1867,user.getLanguage())%></option><!-- 人员 -->
						         	<option value="2" <%if(receiverfieldtype==2){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></option><!-- 部门 -->
						         	<option value="3" <%if(receiverfieldtype==3){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></option><!-- 分部 -->
						         </select>
						         </span>
                      </TD>
                    </TR> 
                    <TR id="browserTr">
                    	<%
                    		String showspan1Css = "display:none";
                    		String showspan2Css = "display:none";
                    		String showspan3Css = "display:none";
                    		String showspan4Css = "display:none";
                    		String showspan1000Css = "display:none";
                    		
                    		String value1 = "";
                    		String value2 = "";
                    		String value3 = "";
                    		String value4 = "";
                    		String value1000 = "";
                    		String showname1 = "";
                    		String showname2 = "";
                    		String showname3 = "";
                    		String showname4 = "";
                    		String showname1000 = "";
                    		receiverdetail = areaVal;
                    		int type = 0;
                    		if(id.equals("0")||areaType==1){//人力资源
                    			type = 17;
                    			showspan1Css = "";
                    			value1 = receiverdetail;
                    			showname1 = fieldInfo.getFieldName(receiverdetail, type, "");
                    		}else if(areaType==2){//分部
                    			type = 164;
                    			showspan2Css = "";
                    			value2 = receiverdetail;
                    			showname2 = fieldInfo.getFieldName(receiverdetail, type, "");
                    		}else if(areaType==3){//部门
                    			type = 57;
                    			showspan3Css = "";
                    			value3 = receiverdetail;
                    			showname3 = fieldInfo.getFieldName(receiverdetail, type, "");
                    		}else if(areaType==4){//角色
                    			type = 65;
                    			showspan4Css = "";
                    			value4 = receiverdetail;
                    			showname4 = fieldInfo.getFieldName(receiverdetail, type, "");
                    		}else if(areaType==5){//所有人
                    			
                    		}else if(areaType==1000){//字段
                    			value1000 = receiverdetail;
                    			showname1000 = getFieldShowName(receiverdetail);
                    			showspan1000Css = "";
                    		}
                    	%>
				     	<TD class="e8_tblForm_label" width="20%"><%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%><!-- 选择 --></TD>
				     	<TD class="e8_tblForm_field">
				     	 <span id="showspan1" style="<%=showspan1Css %>">
				         	<brow:browser viewType="0" name="relatedid1" browserValue="<%=value1 %>" browserOnClick="" 
				         		browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=" 
				         		hasInput="true"  width="50%" isSingle="false" hasBrowser="true" completeUrl="/data.jsp?type=17" browserSpanValue="<%=showname1 %>" isMustInput="2">
				         	</brow:browser>
				         </span>
				         <span id="showspan2" style="<%=showspan2Css %>">
				         	<brow:browser viewType="0" name="relatedid2" browserValue="<%=value2 %>" browserOnClick="" 
				         		browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids=&selectedDepartmentIds=" 
				         		hasInput="true"  width="50%" isSingle="false" hasBrowser="true" completeUrl="/data.jsp?type=194" browserSpanValue="<%=showname2 %>" isMustInput="2">
				         	</brow:browser>
				         </span>
				         <span id="showspan3" style="<%=showspan3Css %>">
				         	<brow:browser viewType="0" name="relatedid3" browserValue="<%=value3 %>" browserOnClick="" 
				         		browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids=" 
				         		hasInput="true"  width="50%" isSingle="false" hasBrowser="true" completeUrl="/data.jsp?type=57" browserSpanValue="<%=showname3 %>" isMustInput="2">
				         	</brow:browser>
				         </span>
				         <span id="showspan4" style="<%=showspan4Css %>">
				         	<brow:browser viewType="0" name="relatedid4" browserValue="<%=value4 %>" browserOnClick="" 
				         		browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/roles/HrmRolesBrowser.jsp" 
				         		hasInput="true"  width="50%" isSingle="true" hasBrowser="true" completeUrl="/data.jsp?type=65" browserSpanValue="<%=showname4 %>" isMustInput="2">
				         	</brow:browser>
				         </span>
				         <span id="showspan1000" style="<%=showspan1000Css %>">
				         	<brow:browser viewType="0" name="relatedid1000" browserValue="<%=value1000 %>" browserOnClick="" getBrowserUrlFn="modefiledChange" 
				         		hasInput="false"  width="50%" isSingle="false" hasBrowser="true" completeUrl="/data.jsp?type=10000" browserSpanValue="<%=showname1000 %>" isMustInput="2">
				         	</brow:browser>
				         </span>
				     	</TD>
				     </TR>
				     <TR  id=showlevel_tr name=showlevel_tr style="display:none;height: 1px">
				       <td class="e8_tblForm_label" width="20%"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></TD><!-- 安全级别 -->
				       <TD class="e8_tblForm_field">
				       	 <INPUT type=text name="level" id="level" class=InputStyle size=6 value="<%=level %>"  onKeyPress="ItemCount_KeyPress()">
				         <span id=receiverlevelimage></span>
				       </TD>
				     </TR>
				     </TBODY>
				   
				   <tr>
				   		<td>人员关系</td>
				   		<td><select name="LeadType" id="LeadType"  >  
					           <option value="1" <%if(LeadType==1){%>selected="selected"<%} %>>提醒人员本人</option>
					   		   <option value="2" <%if(LeadType==2){%>selected="selected"<%} %>>提醒人员下属</option>
					           <option value="3" <%if(LeadType==3){%>selected="selected"<%} %>>提醒人员上级</option>
					           <option value="4" <%if(LeadType==4){%>selected="selected"<%} %>>提醒人员上上级</option>
					   		   <option value="5" <%if(LeadType==5){%>selected="selected"<%} %>>提醒人员上上上级</option>
					         </select>
					   </td>
				   </tr>
				     </table>
				     </wea:item>
				</wea:group>
				
		     <wea:group context="<%=SystemEnv.getHtmlLabelName(82230,user.getLanguage())%>" attributes="{'groupOperDisplay':none}"><!-- 定时器 -->
				<wea:item>
				<TABLE class="e8_tblForm triggerTable">
				<COLGROUP>
					<COL width="20%">
					<COL width="80%">
				</COLGROUP>
			  	<TBODY>
				     <%
				 		String tr_1Css = "display:none";
                   		String tr0Css = "display:none";
                   		String tr1Css = "display:none";
                   		String tr2Css = "display:none";
                   		String tr3Css = "display:none";
                   		String tr4Css = "display:none";
                   		String tr5Css = "display:none";
                   		String tr6Css = "display:none";
						if(id.equals("0")||remindHZ==1){//即时提醒--全部隐藏
							
                   		}else if(triggerway==2){
                   			tr0Css = "";
                   			tr1Css = "";
                   			tr4Css = "";
                   			tr_1Css = "";
                   		}else{
                   			tr0Css = "";
                   			tr1Css = "";
                   			tr2Css = "";
                   			tr3Css = "";
                   			tr_1Css = "";
                   		}
                   	%>
                   	
                   		
				     <TR class="triggerTR1" style="<%=tr1Css %>">
                      <TD class="e8_tblForm_label">
                      	<%=SystemEnv.getHtmlLabelName(82231,user.getLanguage())%><!-- 定时器触发方式 -->
                      </TD>
                      <TD class="e8_tblForm_field">
                      		<select id="triggerway" name="triggerway" onchange="changeTriggerway();">
                      			<option value="1" <%if(id.equals("0")||triggerway==1){%>selected="selected"<%} %>><%=SystemEnv.getHtmlLabelName(82232,user.getLanguage())%><!-- 简单规则 --></option>
                      			<!-- <option value="2" <%if(triggerway==2){%>selected="selected"<%} %> ><%=SystemEnv.getHtmlLabelName(15636,user.getLanguage())%>表达式 </option>-->
                      		</select>
                      </TD>
                    </TR> 
                   	
                    <TR class="triggerTR2" style="<%=tr2Css %>">
                      <TD class="e8_tblForm_label">
                      	<%=SystemEnv.getHtmlLabelName(82233,user.getLanguage())%><!-- 定时器运行频率 -->
                      </TD>
                      <TD class="e8_tblForm_field">
                      		<input type="radio" <%if(id.equals("0")||triggertype==1){%>checked="checked"<%} %> name="triggertype" value="1" onclick="changeTriggertype(1)" ><%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%><!-- 分钟 -->
                      		<input type="radio" <%if(triggertype==2){%>checked="checked"<%} %> name="triggertype" value="2" onclick="changeTriggertype(2)" ><%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%><!-- 小时 -->
                      		<input type="radio" <%if(triggertype==3){%>checked="checked"<%} %> name="triggertype" value="3" onclick="changeTriggertype(3)" ><%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%><!-- 天 -->
                      		<input type="radio" <%if(triggertype==4){%>checked="checked"<%} %> name="triggertype" value="4" onclick="changeTriggertype(4)" ><%=SystemEnv.getHtmlLabelName(1926,user.getLanguage())%><!-- 周 -->
                      		<input type="radio" <%if(triggertype==5){%>checked="checked"<%} %> name="triggertype" value="5" onclick="changeTriggertype(5)" ><%=SystemEnv.getHtmlLabelName(6076,user.getLanguage())%><!-- 月 -->
                      		<input type="radio" <%if(triggertype==6){%>checked="checked"<%} %> name="triggertype" value="6" onclick="changeTriggertype(6)" ><%=SystemEnv.getHtmlLabelName(82234,user.getLanguage())%><!-- 仅一次 -->
                      </TD>
                    </TR>  
                    <TR class="triggerTR3" style="<%=tr3Css %>">
                      <TD class="e8_tblForm_label">
                      	<%=SystemEnv.getHtmlLabelName(82235,user.getLanguage())%><!-- 定时器循环周期 -->
                      </TD>
                      <TD class="e8_tblForm_field">
                      		<%if(id.equals("0")){
                      			triggercycletime = 5;
                      		} 
                      		String triggercycletimeStr = triggercycletime+"";
                      		if(triggercycletimeStr.equals("0")){
                      			triggercycletimeStr = "";
                      		}
                      		%>
                      		<%=SystemEnv.getHtmlLabelName(21977,user.getLanguage())%><!-- 每 -->
                      			<input type="text" style="width: 50px;" name="triggercycletime" id="triggercycletime" 
                      				onchange="checkinput('triggercycletime','triggercycletimeSpan')" value="<%=triggercycletimeStr %>" onKeyPress="ItemCount_KeyPress()" >
                      		<span id="triggercycletimeSpan0"><%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%><!-- 分钟 --></span>
                      		<span id="triggercycletimeSpan">
                      		<%if(triggercycletimeStr.equals("")){%>
                      			<%=needInputImg %>
                      		<%} %>
                      		</span>
                      </TD>
                    </TR>  
                    
                     <TR class="triggerTR4" style="<%=tr4Css %>">
                      <TD class="e8_tblForm_label">
                      	<%=SystemEnv.getHtmlLabelName(82236,user.getLanguage())%><!-- 定时器表达式 -->
                      </TD>
                      <TD class="e8_tblForm_field">
                      		<input type="text" name="triggerexpression" id="triggerexpression" style="width: 300px;">
                      </TD>
                    </TR>
                    
                    <tr class="triggerTR5" style="<%=tr5Css %>" >
						<td class="e8_tblForm_label"  ><%=SystemEnv.getHtmlLabelName(82237,user.getLanguage())%><!-- 星期选择 --></td>
						<td class="e8_tblForm_field" >
						
							<table  style="width: 350px">
								<colgroup>
									<col style="width: 50px;">
									<col style="width: 180px;">
									<col style="width: 50px;">
								</colgroup>
								<tr>
									<td><span><input type="checkbox" onclick="selectAllWeek(this)"/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%><!-- 全选 --></span></td>
									<td>
										<span id=weekdiv></span>
										<input type="hidden" name="weekval" id="weekval" onchange="checkinput('weekval','weekvalSpan')" value="<%=weeks %>">
									</td>
									<td>
										<span id="weekvalSpan">
											<%if(weeks.equals("")){%>
												<%=needInputImg %>
											<%}%>
										</span>
									
									</td>
								</tr>
							</table>
						</td>					
					</tr>
					<tr class="triggerTR6" style="<%=tr6Css %>" >
						<td class="e8_tblForm_label"  ><%=SystemEnv.getHtmlLabelName(82238,user.getLanguage())%><!-- 月份选择 --></td>
						<td class="e8_tblForm_field" >
						<table>
							<tr>
								<td width="80%" class="FieldValue" nowrap>
									<table  style="width: 380px">
										<colgroup>
											<col style="width: 50px;">
											<col style="width: 180px;">
											<col style="width: 50px;">
										</colgroup>
										<tr>
											<td><%=SystemEnv.getHtmlLabelName(887,user.getLanguage())%><!-- 月份 -->&nbsp;&nbsp;<input type="checkbox" onclick="selectAllMonth(this)"/><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%><!-- 全选 --></td>
											<td><span id="monthdiv"></span>
												<input type="hidden" name="monthval" id="monthval" onchange="checkinput('monthval','monthvalSpan0')" value="<%=months %>">
											</td>
											<td>
												<span id="monthvalSpan0">
													<%if(months.equals("")){%>
														<%=needInputImg %>
													<%} %>
												</span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="80%" class="FieldValue" nowrap>
									<table  style="width: 380px">
										<colgroup>
											<col style="width: 50px;">
											<col style="width: 180px;">
											<col style="width: 50px;">
										</colgroup>
										<tr>
											<td><%=SystemEnv.getHtmlLabelName(97,user.getLanguage())%><!-- 日期 -->&nbsp;&nbsp;<input type="checkbox" onclick="selectAllMonthday(this)" /><%=SystemEnv.getHtmlLabelName(556,user.getLanguage())%><!-- 全选 --></td>
											<td><span id=daydiv ></span>
												<input type="hidden" name="dayval" id="dayval" onchange="checkinput('dayval','dayvalSpan0')" value="<%=days %>">
											</td>
											<td>
												<span id="dayvalSpan0">
													<%if(days.equals("")){%>
														<%=needInputImg %>
													<%} %>
												</span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						</td>					
					</tr>
			 	</TBODY>
			</TABLE>
			</wea:item>
				</wea:group>
			</wea:layout>
			
			<div style="height: 40px;"></div>
		</FORM>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<script type="text/javascript">

jQuery(function($){
	$(".loading", window.parent.document).hide(); //隐藏加载图片
	if(jQuery("#areaType").val()==1000){
		var sb = jQuery("#receiverfieldtype").attr("sb");
		$("#sbHolderSpan_"+sb).width(80);
		$("#sbSelector_"+sb).width(80);
		$("#sbOptions_"+sb).width(80);
	}
	$(".codeDelFlag").click(function(e){
		window.top.Dialog.confirm("<%=SystemEnv.getHtmlLabelName(23271,user.getLanguage())%>",function(){
			$("#remindcontentjava_span").html("");
			$("#remindcontentjava").val("");
			$(".codeDelFlag").hide();
		});
		e.stopPropagation(); 
	});
	showLastLayoutTable();
	remindtypeChange();
	changeReceivertype();
	changeRemindway();
});

function showLastLayoutTable(){
	var table = $(".triggerTable");
	var intervalTR = $(".intervalTR[_samepair]");
	var triggerTr = $(intervalTR.get(intervalTR.length-1));
	var nextTr1 = triggerTr.next();
	var nextTr2 = nextTr1.next();
	triggerTr.addClass("triggerTR0");
	nextTr1.addClass("triggerTR0");
	nextTr2.addClass("triggerTR0");
	
}

function changeRemindway(){
	var remindway = getCheckBoxVal("remindway");
	if(remindway==2){
		$("#senderTR").show();
		$("#emailTR").hide();
		changeSenderType();
	}else if(remindway==3){
		$("#senderTR").hide();
		$("#emailTR").show();
		changeSenderType();
	}else {
		$("#emailTR").hide();
		$("#senderTR").hide();
	}
}

function changeSenderType(){
	var sendertype =  $("#sendertype").val();
	if(sendertype==1){
		$("#sendspan1").hide();
	}else{
		$("#sendspan1").show();
	}
}

function getShowUrl(type){
	var formid = $("#formid").val();
	var url = "/formmode/setup/RemindFieldBrowser.jsp?formid="+formid+"&type="+type;
	url = "/systeminfo/BrowserMain.jsp?url="+escape(url);
	return url;
}

function remindtypeChange(){
	var $ = jQuery;
	var remindtype = $("#remindHZ");
	if(remindtype.val()==1){//即时提醒 
		$(".triggerTR0").hide();
		$(".triggerTR1").hide();
		$(".triggerTR2").hide();
		$(".triggerTR3").hide();
		$(".triggerTR4").hide();
		$(".triggerTR5").hide();
		$(".triggerTR6").hide();
		$(".remindtimeTR1").hide();
		$(".remindtimeTR2").hide();
	}else 
	//if(remindtype.val()==2)
	{//到期提醒
		changeTriggerway();
		$(".triggerTR0").show();
		$(".triggerTR1").show();
		$(".triggerTR2").show();
		$(".remindtimeTR1").show();
		$(".remindtimeTR2").show();
//	}else{//循环提醒
//		changeTriggerway();
//		$(".triggerTR0").show();
//		$(".triggerTR1").show();
//		$(".triggerTR2").show();
//		$(".remindtimeTR1").hide();
//		$(".remindtimeTR2").hide();
	}
	
}

function changeTriggerway(){
	var triggerway = $("#triggerway").val();
	if(triggerway==2){
		$(".triggerTR2").hide();
		$(".triggerTR3").hide();
		$(".triggerTR4").show();
		$(".triggerTR5").hide();
		$(".triggerTR6").hide();
	}else{
		$(".triggerTR2").show();
		$(".triggerTR3").show();
		$(".triggerTR4").hide();
		var triggertype = jQuery("[name=triggertype]");
		for(var i=0;i<triggertype.length;i++){
			if(triggertype.get(i).checked){
				changeTriggertype(triggertype.get(i).value);
				break;
			}
		}
	}
}

function getOnShowConditionUrl(){
	<%if(id.equals("0")){%>
		window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(82239,user.getLanguage())%>");//请先保存，再设置条件！
		return false;
	<%}%>
	var url = escape("/formmode/setup/RemindJobcondition.jsp?isbill=1&formid=<%=formid%>&id=<%=id%>");
	url = "/systeminfo/BrowserMain.jsp?url="+url
    return url;
}

function reloadWin(){
	window.location.href = window.location.href;
}

function formidChange(){
	var $ = jQuery;
	var formid = $("#formid").val();
	getModesByFormId(formid);
	changeSenderField(formid);
}

function changeSenderField(formid){
	var $ = jQuery;
	$.ajax({
	   type: "POST",
	   url: "/formmode/setup/RemindJobSettingsAction.jsp?operation=getHrmFieldByFormId",
	   data: "formid="+formid, 
	   dataType:"json",
	   success: function(data){
			var senderfield = $("#senderfield");
			senderfield.selectbox("detach");//禁用
			senderfield.empty();
			var varItem = new Option("","");   
			senderfield.append("<option value=''></option>");  
			for(var i=0;i<data.length;i++){
				senderfield.append("<option value='"+data[i].id+"'>"+data[i].labelname+"</option>"); 
			}
			senderfield.selectbox("attach");//启用
			changeSenderType();
	   }
	});
}

function getModesByFormId(formid){
	var $ = jQuery;
	$.ajax({
	   type: "POST",
	   url: "/formmode/setup/RemindJobSettingsAction.jsp?operation=getModesByFormId",
	   data: "formid="+formid+"&fmdetachable=<%=fmdetachable%>&subCompanyId=<%=subCompanyId%>",
	   dataType:"json",
	   success: function(data){
			changeSelectItemData('modeid',data.modedata);
			jQuery("#modeidSpan").html("<%=needInputImg%>");
			changeSelectItemData('contentSelect',data.fielddata);
			changeSelectItemData('subjectSelect',data.fielddata);
	   }
	});
}

/**
 * 
 * @param {Object} selectid
 * @param {Object} dataArray  要求里面的obj对象的键为：value和text，分别对应select对象的value和text文本 
 */
function changeSelectItemData(selectid,dataArray){
	var $ = jQuery;
	var selectObj = $("#"+selectid);
	selectObj.selectbox("detach");//禁用
	selectObj.empty();
	var varItem = new Option("","");   
	selectObj.append("<option value=''></option>");  
	for(var i=0;i<dataArray.length;i++){
		selectObj.append("<option value='"+dataArray[i].value+"'>"+dataArray[i].text+"</option>"); 
	}
	selectObj.selectbox("attach");//启用
}

function varSelectChange(objid,targetid){
	var objvalue = $("#"+objid).val();
	if(objvalue==''){
		return;
	}
	var target = $("#"+targetid);
	target.val(target.val()+"$"+objvalue+"$");
	if('remarks' == targetid) {
		checkinput('remarks','remarksSpan')
	}
}

function changeSCT(cbObj){
	setTimeout(function(){	//checkbox用了插件，不延时checkbox的checked状态获取不准确
		var objV = cbObj.value;
		if(!cbObj.checked){
			changeCheckboxStatus(cbObj, true);
			return;
		}else{
			jQuery("input[type='checkbox'][name='"+cbObj.name+"']").each(function(){
				if(this.value != objV){
					changeCheckboxStatus(this, false);
				}
			});
		}
		
		jQuery("."+cbObj.name+"Span").hide();
		jQuery("#"+cbObj.name+"_"+objV).show();
	},100);
}

function changeIncrementtype(){
	var $ = jQuery;
	var incrementtype = $("#incrementtype").val();
	if(incrementtype==2){
		$("#incrementSpan1").hide();
		$("#incrementSpan2").show();
	}else{
		$("#incrementSpan1").show();
		$("#incrementSpan2").hide();
	}
	
}


function changeReceivertype(){
	var thisvalue=$GetEle("areaType").value;
    var strAlert= ""
    $("span[id^='showspan']").css('display','none');
	if(thisvalue==1 || thisvalue==2 || thisvalue==3 || thisvalue==4 || thisvalue==1000){//需要浏览框
		$GetEle("browserTr").style.display = '';
		$GetEle("showspan"+thisvalue).style.display='';	//浏览框
	}else{
		$GetEle("browserTr").style.display = 'none';
		//$GetEle("showspan").style.display='none';	//不需要浏览框
	}
	if(thisvalue == 1||thisvalue == 6 || thisvalue==1001){//人员、创建人/Java不需要安全级别
		$GetEle("showlevel_tr").style.display='none';	//安全级别
	}else{
		$GetEle("showlevel_tr").style.display='';	//安全级别
	}
	if(thisvalue==1000){
		jQuery("#receiverfieldtypespan").show();
		var sb = jQuery("#receiverfieldtype").attr("sb");
		$("#sbHolderSpan_"+sb).width(80);
		$("#sbSelector_"+sb).width(80);
		$("#sbOptions_"+sb).width(80);
		if(jQuery("#receiverfieldtype").val()=='1'){
			jQuery("#showlevel_tr").hide();
		}else{
			jQuery("#showlevel_tr").show();
		}
	}else{
		jQuery("#receiverfieldtypespan").hide();
	}
}

function changeFieldType(obj){
	if(obj.value=='1'){
		jQuery("#showlevel_tr").hide();
	}else{
		jQuery("#showlevel_tr").show();
	}
	$GetEle("showspan").style.display='';	//浏览框
	$GetEle("relatedid").value="";
	$GetEle("showrelatedname").innerHTML="<IMG src='/images/BacoError_wev8.gif' align=absMiddle>";
}

function modefiledChange(){
    var tmpval = $GetEle("receiverfieldtype").value;
    var modeid = $("#modeid").val();
    if(modeid==""){
    	Dialog.alert("<%=SystemEnv.getHtmlLabelName(82240,user.getLanguage())%>");//请先选择模块！
    	return;
    }
	var tempurl1 = "/systeminfo/BrowserMain.jsp?url=/formmode/setup/MultiFormmodeShareFieldBrowser.jsp?type="+tmpval+"&selectedids=&modeId="+modeid;
	return tempurl1;
}


function checkValues(ids,titles){
	for(var i=0;i<ids.length;i++){
		var id = ids[i];
		var title = titles[i];
		if($("#"+id).val()==""){
			Dialog.alert("["+title+"] <%=SystemEnv.getHtmlLabelName(82241,user.getLanguage())%>");//不能为空！
			return false;
		}
	}
	return true;
}

function submitData(){
	var ids = ["name"];
	var titles = ["<%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%>"];//名称
	ids.push("formid");
	titles.push("<%=SystemEnv.getHtmlLabelName(15451,user.getLanguage())%>");//表单名称
	if($("#remindtype").val()==1){
		ids.push("modeid");
		titles.push("<%=SystemEnv.getHtmlLabelName(28485,user.getLanguage())%>");//模块名称
	}else if($("#remindtype").val()==2){
		var remindtimetype = getCheckBoxVal("remindtimetype");
		if(remindtimetype==1){
			ids.push("reminddate");
			titles.push("<%=SystemEnv.getHtmlLabelName(82242,user.getLanguage())%>");//到期日期
			
			ids.push("remindtime");
			titles.push("<%=SystemEnv.getHtmlLabelName(82215,user.getLanguage())%>");//到期时间
		}else if(remindtimetype==2){
			ids.push("reminddatefield");
			titles.push("<%=SystemEnv.getHtmlLabelName(82243,user.getLanguage())%>");//到期日期字段
			
			ids.push("remindtimefield");
			titles.push("<%=SystemEnv.getHtmlLabelName(82244,user.getLanguage())%>");//到期时间字段
			
		}
	}
	var remindway = getCheckBoxVal("remindway");
	if(remindway==2){
		var sendertype = $("#sendertype").val();
		if(sendertype==3){
			ids.push("senderfield");
			titles.push("<%=SystemEnv.getHtmlLabelName(82245,user.getLanguage())%>");//短信发送人字段
		}
	}else if(remindway==3){
		ids.push("subject");
		titles.push("<%=SystemEnv.getHtmlLabelName(82223,user.getLanguage())%>");//邮件标题
	}
	var remindcontenttype =  getCheckBoxVal("remindcontenttype");
	if(remindcontenttype==1){
		ids.push("remindcontenttext");
		titles.push("<%=SystemEnv.getHtmlLabelName(27415,user.getLanguage())%>");//提醒内容
	}else{
		ids.push("remindcontentjava");
		titles.push("<%=SystemEnv.getHtmlLabelName(27415,user.getLanguage())%>");//提醒内容
	}
	ids.push("remindcontenttext");
	titles.push("<%=SystemEnv.getHtmlLabelName(27415,user.getLanguage())%>");//提醒内容
	var areaType = jQuery("#areaType").val();
	if(areaType==1){
		ids.push("relatedid1");
		titles.push("<%=SystemEnv.getHtmlLabelName(82246,user.getLanguage())%>");//人员选择
	}else if(areaType==2){
		ids.push("relatedid2");
		titles.push("<%=SystemEnv.getHtmlLabelName(82247,user.getLanguage())%>");//分部选择
	}else if(areaType==3){
		ids.push("relatedid3");
		titles.push("<%=SystemEnv.getHtmlLabelName(82248,user.getLanguage())%>");//部门选择
	}else if(areaType==4){
		ids.push("relatedid4");
		titles.push("<%=SystemEnv.getHtmlLabelName(82249,user.getLanguage())%>");//角色选择
	}else if(areaType==1000){
		ids.push("relatedid1000");
		titles.push("<%=SystemEnv.getHtmlLabelName(81438,user.getLanguage())%>");//模块主字段
	}
	if($("#remindtype").val()==2||$("#remindtype").val()==3){
		var triggerway = jQuery("#triggerway").val();
		if(triggerway==1){
			var triggertype = getCheckBoxVal("triggertype");
			if(triggertype<=3){
				ids.push("triggercycletime");
				titles.push("<%=SystemEnv.getHtmlLabelName(82235,user.getLanguage())%>");//定时器循环周期
			}else if(triggertype==4){
				ids.push("weeks");
				titles.push("<%=SystemEnv.getHtmlLabelName(82237,user.getLanguage())%>");//星期选择
			}else if(triggertype==5){
				ids.push("months");
				titles.push("<%=SystemEnv.getHtmlLabelName(887,user.getLanguage())%>");//月份
				ids.push("days");
				titles.push("<%=SystemEnv.getHtmlLabelName(82250,user.getLanguage())%>");//月份日期
			}
		}else if(triggerway==2){
			ids.push("triggerexpression");
			titles.push("<%=SystemEnv.getHtmlLabelName(82251,user.getLanguage())%>");//定时器表达式 
		}
	}
	jQuery("#weekval").val(week.getValue());
	jQuery("#monthval").val(month.getValue());
	jQuery("#dayval").val(monthday.getValue());
	if(checkValues(ids,titles)){
		$("#operation").val("saveorupdate");
        enableAllmenu();
        frmMain.submit();
        
	}
	window.close();
}

function getCheckBoxVal(name){
	var boxs = jQuery("input[name="+name+"]");
	for(var i=0;i<boxs.length;i++){
		if(jQuery(boxs[i]).attr("checked")==true){
			return jQuery(boxs[i]).val();
		}
	}
}
function changeBoxVal(obj){
	if(obj.checked){
		obj.value = 1;
	}else{
		obj.value = 0;
	}
}

var utilTextArr = ["<%=SystemEnv.getHtmlLabelName(15049,user.getLanguage())%>","<%=SystemEnv.getHtmlLabelName(391,user.getLanguage())%>","<%=SystemEnv.getHtmlLabelName(1925,user.getLanguage())%>","<%=SystemEnv.getHtmlLabelName(1926,user.getLanguage())%>","<%=SystemEnv.getHtmlLabelName(6076,user.getLanguage())%>"];//分钟,小时,天,周,月
function changeTriggertype(type){
	if(type<=3){
		$("#triggercycletimeSpan0").html(utilTextArr[type-1]);
		if(type==0){
			$(".triggerTR3").hide();
		}else{
			$(".triggerTR3").show();
		}
		$(".triggerTR5").hide();
		$(".triggerTR6").hide();
	}else if(type==4){
		$(".triggerTR3").hide();
		$(".triggerTR5").show();
		$(".triggerTR6").hide();
	}else if(type==5){
		$(".triggerTR3").hide();
		$(".triggerTR5").hide();
		$(".triggerTR6").show();
	}else{
		$(".triggerTR3").hide();
		$(".triggerTR5").hide();
		$(".triggerTR6").hide();
	}
}
var diag_vote;
function toformtab(formid,isvirtualform){
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;	
		var parm = "&formid="+formid;
		if(formid=='') {
			parm = '';
			diag_vote.Title = "<%=SystemEnv.getHtmlLabelName(82021,user.getLanguage())%>";//新建表单
		}else{
			diag_vote.Title = "<%=SystemEnv.getHtmlLabelName(82022,user.getLanguage())%>";//编辑表单
		}
		diag_vote.Width = 1000;
		diag_vote.Height = 380;
		diag_vote.Modal = true;
		
		diag_vote.URL = "/workflow/form/addDefineForm.jsp?dialog=1&isFromMode=1"+parm;
		diag_vote.isIframe=false;
		diag_vote.show();
}

function onDelete(){
	window.top.Dialog.confirm("<%=SystemEnv.getHtmlNoteName(7,user.getLanguage())%>",function(){
		enableAllmenu();
		document.frmMain.operation.value="delete";
		document.frmMain.submit();
	});
}

function checkSelect(objid,objspanid){
	var img = "<img align='absMiddle' src='/images/BacoError_wev8.gif'>";
	var modeid= jQuery("#"+objid).val();
	var modeidSpan = jQuery("#"+objspanid);
	if(modeid!=""){
		modeidSpan.html("");
	}else{
		modeidSpan.html(img);
	}
}

function initRemindData(){
	if(confirm("<%=SystemEnv.getHtmlLabelName(82252,user.getLanguage())%>")){//确定要初始化到期提醒数据？
		$(".loading", window.parent.document).show();
		$.ajax({
		   type: "POST",
		   url: "/formmode/setup/RemindJobSettingsAction.jsp",
		   data: "operation=initRemindData&id=<%=id%>",
		   success: function(msg){
		     setTimeout(function(){
		    	 $(".loading", window.parent.document).hide();
		     },800);
		   }
		});
	}
}


function openCodeEdit(){
	top.openCodeEdit({
		"type" : "7",
		"filename" : $("#remindcontentjava").val()
	}, function(result){
		if(result){
			var fName = result["fileName"];
			$("#remindcontentjava_span").html(fName);
			$("#remindcontentjava").val(fName);
			$(".codeDelFlag").show();
		}
	});
}



//------------------------------
		Ext.BLANK_IMAGE_URL = '/formmode/js/ext/resources/images/default/s_wev8.gif';
		
		Ext.override(Ext.ux.form.LovCombo, {
			beforeBlur: Ext.emptyFn
		});
		var week; 
		var month;
		var monthday;
		var trigtype = '';
		Ext.onReady(function() {
			week = new Ext.ux.form.LovCombo({
				 id:'weeks'
				,renderTo:'weekdiv'
				,width:200
				,editable:false
				,hideOnSelect:false
				,maxHeight:200
				,store:[
					 [0, '<%=SystemEnv.getHtmlLabelName(398,user.getLanguage())%>']//星期日
					,[1, '<%=SystemEnv.getHtmlLabelName(392,user.getLanguage())%>']//星期一
					,[2, '<%=SystemEnv.getHtmlLabelName(393,user.getLanguage())%>']//星期二
					,[3, '<%=SystemEnv.getHtmlLabelName(394,user.getLanguage())%>']//星期三
					,[4, '<%=SystemEnv.getHtmlLabelName(395,user.getLanguage())%>']//星期四
					,[5, '<%=SystemEnv.getHtmlLabelName(396,user.getLanguage())%>']//星期五
					,[6, '<%=SystemEnv.getHtmlLabelName(397,user.getLanguage())%>']//星期六
				]
				,triggerAction:'all'
				,mode:'local'
			});
			
			<%if(!weeks.equals("")){%>
				week.setValue('<%=weeks%>');
			<%}%>
			changeSpanImg('<%=weeks%>',"weekvalSpan");
			
			week.beforeBlur = function(){
				changeSpanImg(week.getValue(),"weekvalSpan");
			}
			
			month = new Ext.ux.form.LovCombo({
				 id:'months'
				,renderTo:'monthdiv'
				,width:200
				,hideOnSelect:false
				,editable:false
				,maxHeight:200
				,store:[
					 [1, '<%=SystemEnv.getHtmlLabelName(1492,user.getLanguage())%>']//一月
					,[2, '<%=SystemEnv.getHtmlLabelName(1493,user.getLanguage())%>']//二月
					,[3, '<%=SystemEnv.getHtmlLabelName(1494,user.getLanguage())%>']//三月
					,[4, '<%=SystemEnv.getHtmlLabelName(1495,user.getLanguage())%>']//四月
					,[5, '<%=SystemEnv.getHtmlLabelName(1496,user.getLanguage())%>']//五月
					,[6, '<%=SystemEnv.getHtmlLabelName(1497,user.getLanguage())%>']//六月
					,[7, '<%=SystemEnv.getHtmlLabelName(1498,user.getLanguage())%>']//七月
					,[8, '<%=SystemEnv.getHtmlLabelName(1499,user.getLanguage())%>']//八月
					,[9, '<%=SystemEnv.getHtmlLabelName(1800,user.getLanguage())%>']//九月
					,[10, '<%=SystemEnv.getHtmlLabelName(1801,user.getLanguage())%>']//十月
					,[11, '<%=SystemEnv.getHtmlLabelName(1802,user.getLanguage())%>']//十一月
					,[12, '<%=SystemEnv.getHtmlLabelName(1803,user.getLanguage())%>']//十二月
				]
				,triggerAction:'all'
				,mode:'local'
			});
			<%if(!months.equals("")){%>
				month.setValue('<%=months%>');
			<%}%>
			changeSpanImg('<%=months%>',"monthvalSpan0");
			month.beforeBlur = function(){
				changeSpanImg(month.getValue(),"monthvalSpan0");
			}
			
			monthday = new Ext.ux.form.LovCombo({
				 id:'days'
				,renderTo:'daydiv'
				,width:200
				,editable:false
				,hideOnSelect:false
				,maxHeight:200
				,store:[
					 [1,'1'],[2,'2'],[3,'3'],[4,'4'],[5,'5'],[6,'6'],[7,'7'],[8,'8'],[9,'9']
					,[10,'10'],[11,'11'],[12,'12'],[13,'13'],[14,'14'],[15,'15'],[16,'16'],[17,'17']
					,[18,'18'],[19,'19'],[20,'20'],[21,'21'],[22,'22'],[23,'23'],[24,'24'],[25,'25']
					,[26,'26'],[27,'27'],[28,'28'],[29,'29'],[30,'30'],[31,'31']
				]
				,triggerAction:'all'
				,mode:'local'
			});
			<%if(!days.equals("")){%>
				monthday.setValue('<%=days%>');
			<%}%>
			changeSpanImg('<%=days%>',"dayvalSpan0");
			monthday.beforeBlur = function(){
				changeSpanImg(monthday.getValue(),"dayvalSpan0");
			}
		});
		
		
		function changeSpanImg(value,spanid){
			if(value==""){
				$("#"+spanid).html("<%=needInputImg%>");
			}else{
				$("#"+spanid).html("");
			}
		}
		
		
		function selectAllWeek(obj) {
			if(obj.checked) {
				week.setValue('0,1,2,3,4,5,6');
				changeSpanImg('0,1,2,3,4,5,6',"weekvalSpan");
			} else {
				week.setValue('');
				changeSpanImg('',"weekvalSpan");
			}
		}
		
		function selectAllMonth(obj) {
			if(obj.checked) {
				month.setValue('1,2,3,4,5,6,7,8,9,10,11,12');
				changeSpanImg('1,2,3,4,5,6,7,8,9,10,11,12',"monthvalSpan0");
			} else {
				month.setValue('');
				changeSpanImg('',"monthvalSpan0");
			}
		}
		
		function selectAllMonthday(obj) {
			if(obj.checked) {
				monthday.setValue('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22.23,24,25,26,27,28,29,30,31');
				changeSpanImg('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22.23,24,25,26,27,28,29,30,31',"dayvalSpan0");
			} else {
				monthday.setValue('');
				changeSpanImg('',"dayvalSpan0");
			}
		}
		
		function insert(id,content) {
			document.getElementById(id).innerHTML=content;
			show(id);
		}
		
		function doAdd(){
			parent.location.href = "/formmode/setup/RemindJobInfo.jsp?appid=<%=appid%>";
		}
</script>
<style>
.Selected td.e8Selected input.inputStyle, .Selected td.e8Selected input.inputstyle, .Selected td.e8Selected input[type="text"], .Selected td.e8Selected input[type="password"], .Selected td.e8Selected input.Inputstyle, .Selected td.e8Selected input.InputStyle, .Selected td.e8Selected input.inputStyle, .Selected td.e8Selected .e8_innerShowContent, .Selected td.e8Selected textarea, .Selected td.e8Selected .sbHolder {
     border: 1px solid #e9e9e2;
}

.Selected td.e8Selected .e8_outScroll {
     border: 0px solid #e9e9e2;
}

.Selected td.e8Selected input.inputStyle, .Selected td.e8Selected input.inputstyle, .Selected td.e8Selected input[type="text"], .Selected td.e8Selected input[type="password"], .Selected td.e8Selected input.Inputstyle, .Selected td.e8Selected input.InputStyle, .Selected td.e8Selected input.inputStyle, .Selected td.e8Selected .e8_os, .Selected td.e8Selected textarea, .Selected td.e8Selected .sbHolder {
    border: 1px solid #e9e9e2;
}
</style>

</BODY></HTML>
