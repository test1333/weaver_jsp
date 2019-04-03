<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
weaver.general.AccountType.langId.set(lg);
String sopname = Util.null2String(request.getParameter("sopname"));
String sopname_val = "";
String lcmc = Util.null2String(request.getParameter("lcmc"));
String lcmc_val="";
String zlcmc = Util.null2String(request.getParameter("zlcmc"));
String zlcmc_val="";
String comzb = Util.null2String(request.getParameter("comzb"));
String comzb_val="";
String prjstatus = Util.null2String(request.getParameter("prjstatus"));
String prjstatus_val="";
String sopstatus = Util.null2String(request.getParameter("sopstatus"));
String sopstatus_val="";
String dhcolor = Util.null2String(request.getParameter("dhcolor"));
String xgry=Util.null2String(request.getParameter("xgry"));
String sql="select a.name,a.id from prj_projectinfo a,cus_fielddata b where a.id=b.id  and b.scopeid='1' and a.id="+sopname;
rs.executeSql(sql);
if(rs.next()){
	sopname_val = Util.null2String(rs.getString("name"));
}

int count=0;
sql="select count(1) as count from  HrmRoleMembers where roleid=441 and resourceid ="+user_id;
rs.executeSql(sql);
if(rs.next()){
	count = rs.getInt("count");
}
if(count == 0 && user_id !=0){
	xgry = user_id+"";
}

sql="select b.sop_business_flow from prj_projectinfo a,cus_fielddata b where a.id=b.id  and b.scopeid='1' and a.id="+lcmc;
rs.executeSql(sql);
if(rs.next()){
	lcmc_val = Util.null2String(rs.getString("sop_business_flow"));
}
sql="select b.sop_sub_flow from prj_projectinfo a,cus_fielddata b where a.id=b.id  and b.scopeid='1' and a.id="+zlcmc;
rs.executeSql(sql);
if(rs.next()){
	zlcmc_val = Util.null2String(rs.getString("sop_sub_flow"));
}
sql="select name from uf_it_basedata where type = 'CMOTEAM' and rownum=1 and code='"+comzb+"'";

rs.executeSql(sql);
if(rs.next()){
	comzb_val = Util.null2String(rs.getString("name"));
}

sql="select description from prj_projectstatus where id="+prjstatus;
rs.executeSql(sql);
if(rs.next()){
	prjstatus_val = Util.null2String(rs.getString("description"));
}

sql="select b.selectname from cus_formdict a, cus_selectitem b where a.id = b.fieldid and Upper(a.fieldname) = Upper('sop_status') and b.selectvalue='"+sopstatus+"' and rownum=1";

rs.executeSql(sql);
if(rs.next()){
	sopstatus_val = Util.null2String(rs.getString("selectname"));
}

%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 3100px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		.table-head{padding-right:17px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/appdevjsp/HQ/SOP/sopReport.jsp" method=post>
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
				<wea:group context="查询条件">
				<wea:item>相关人员</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="xgry" browserValue="<%=xgry %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=1" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(xgry),user.getLanguage())%>">
				</brow:browser>
				</wea:item>				
				 <wea:item>SOP名称</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="sopname" browserValue="<%=sopname%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_sop_title"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=sopname_val %>">
				</brow:browser>
				</wea:item>
				 <wea:item>流程名称</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="lcmc" browserValue="<%=lcmc%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_business_flow"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=lcmc_val %>">
				</brow:browser>
				</wea:item>
				<wea:item>子流程名称</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="zlcmc" browserValue="<%=zlcmc%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_sub_flow"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=zlcmc_val %>">
				</brow:browser>
				</wea:item>
                
					<wea:item>COM组别</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="comzb" browserValue="<%=comzb%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_cmo_team"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=comzb_val %>">
				</brow:browser>
				</wea:item>
                
				<wea:item>项目状态</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="prjstatus" browserValue="<%=prjstatus%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.project_status"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=prjstatus_val %>">
				</brow:browser>
				</wea:item>

                <wea:item>进展状态</wea:item>
				 <wea:item>
				<brow:browser viewType="0"  name="sopstatus" browserValue="<%=sopstatus%>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.sop_status"
			  hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
				 width="120px"
			    linkUrl=""
			    browserSpanValue="<%=sopstatus_val %>">
				</brow:browser>
				</wea:item>
                <wea:item>灯号</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="dhcolor" id="dhcolor"> 
				<option value="" <%if("".equals(dhcolor)){%> selected<%} %>>
					<%=""%></option>
				<option value="1" <%if("1".equals(dhcolor)){%> selected<%} %>>
					<%="白色"%></option>
				<option value="2" <%if("2".equals(dhcolor)){%> selected<%} %>>
					<%="黄色"%></option>
				<option value="3" <%if("3".equals(dhcolor)){%> selected<%} %>>
					<%="粉色"%></option>
				<option value="4" <%if("4".equals(dhcolor)){%> selected<%} %>>
					<%="红色"%></option>
				<option value="-1" <%if("-1".equals(dhcolor)){%> selected<%} %>>
					<%="绿色"%></option>
				</select>
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
	
	<div style="width:3120px; ">	
	<div class="table-head" style="width:3100px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="80px"></col><col width="100px"></col><col width="120px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				            <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				 </colgroup>
                <tbody>
					 <tr>
					    
	                    <td class="fname" rowspan="2" align="center">灯号</td>
						<td class="fname" rowspan="2" align="center">SOP状态</td>
						<td class="fname" rowspan="2" align="center">SOP ID</td>
						<td class="fname" rowspan="2" align="center">SOP名称</td>
						<td class="fname" rowspan="2" align="center">SOP负责人</td>
						<td class="fname" rowspan="2" align="center">SOP负责人工厂</td>
						<td class="fname" rowspan="2" align="center">业务流程</td>
						<td class="fname" rowspan="2" align="center">流程负责人</td>
						<td class="fname" rowspan="2" align="center">流程负责人工厂</td>
						<td class="fname" rowspan="2" align="center">子流程</td>
						<td class="fname" rowspan="2" align="center">子流程负责人</td>
						<td class="fname" rowspan="2" align="center">子流程负责人工厂</td>
						<td class="fname" rowspan="2" align="center">CMO组别</td>
						<td class="fname" rowspan="2" align="center">CMO组别负责人</td>
						<td class="fname" colspan="3" align="center">(40%)草案完成</td>
						<td class="fname" colspan="3" align="center">(50%)与各部门讨论完成</td>
						<td class="fname" colspan="3" align="center">(70%)向股东报告</td>
						<td class="fname" colspan="3" align="center">(90%)完成完整SOP</td>
						<td class="fname" colspan="3" align="center">(100%)书面呈准</td>						
                       	
                 </tr>
				 <tr>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
					  <td class="fname">&nbsp;&nbsp;预计</td>
					  <td class="fname">&nbsp;&nbsp;实际</td>
					  <td class="fname">&nbsp;&nbsp;目前完成%</td>
				</tr>
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:3120px; ">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto">
                <colgroup>  <col width="80px"></col> <col width="100px"></col><col width="120px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				            <col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
							<col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col><col width="100px"></col>
				 </colgroup>
                <tbody>
					 
					<% 	
                    String color="";
					String prjid="";
					String sop_sop_title="";
					String sop_sop_contact="";
					String sub_contact="";
					String sop_business_flow="";
					String sop_flow_contact="";
					String sub_flow="";
					String sop_sub_flow="";
					String sop_sub_flow_contact="";
					String sub_sub_flow_contact="";
					String sop_cmo_team="";
					String sop_cmo_team_leader="";
					String yj1="";
					String sj1="";
					String mqwc1="";
					String yj2="";
					String sj2="";
					String mqwc2="";
					String yj3="";
					String sj3="";
					String mqwc3="";
					String yj4="";
					String sj4="";
					String mqwc4="";
					String yj5="";
					String sj5="";
					String mqwc5="";
					String sop_status = "";
					int colorflag = -1;
					String backfields = " select f_get_taskinfo(a.id,b.sop_status,'4') as color,f_get_HRSName(b.sop_status,'3','sop_status') as sop_status,b.sop_status as colorflag,a.id,a.procode,a.name,f_get_HRSName(b.sop_sop_contact,'1','') as sop_sop_contact,"+
							"f_get_HRSName(b.sop_sop_contact,'2','') as sub_contact,b.sop_business_flow,"+
							"f_get_HRSName(b.sop_flow_contact,'1','') as sop_flow_contact,f_get_HRSName(b.sop_flow_contact,'2','') as sub_flow,b.sop_sub_flow,f_get_HRSName(b.sop_sub_flow_contact,'1','') as sop_sub_flow_contact,f_get_HRSName(b.sop_sub_flow_contact,'2','') as sub_sub_flow_contact,"+
							"f_get_HRSName(b.sop_cmo_team,'4','') as sop_cmo_team,f_get_HRSName(b.sop_cmo_team_leader,'1','') as sop_cmo_team_leader,f_get_taskinfo(a.id,'0','1') yj1,f_get_taskinfo(a.id,'0','2') sj1,f_get_taskinfo(a.id,'0','3') mqwc1,"+
							"f_get_taskinfo(a.id,'1','1') yj2,f_get_taskinfo(a.id,'1','2') sj2,f_get_taskinfo(a.id,'1','3') mqwc2,f_get_taskinfo(a.id,'2','1') yj3,f_get_taskinfo(a.id,'2','2') sj3,f_get_taskinfo(a.id,'2','3') mqwc3,"+
							"f_get_taskinfo(a.id,'3','1') yj4,f_get_taskinfo(a.id,'3','2') sj4,f_get_taskinfo(a.id,'3','3') mqwc4,f_get_taskinfo(a.id,'4','1') yj5,f_get_taskinfo(a.id,'4','2') sj5,f_get_taskinfo(a.id,'4','3') mqwc5";
														
					String fromSql  = " from prj_projectinfo a,cus_fielddata b ";
					String sqlWhere = " where a.id=b.id  and b.scopeid='1' and a.parentid=81";
					if(!"".equals(sopname)){
						sqlWhere +=" and a.name = '"+sopname_val+"' ";
					}
					if(!"".equals(lcmc)){
						sqlWhere +=" and b.sop_business_flow = '"+lcmc_val+"' ";
					}
					if(!"".equals(zlcmc)){
						sqlWhere +=" and b.sop_sub_flow = '"+zlcmc_val+"' ";
					}
					if(!"".equals(comzb)){
						sqlWhere +=" and b.sop_cmo_team = '"+comzb+"' ";
					}
					if(!"".equals(prjstatus)){
						sqlWhere +=" and a.status = '"+prjstatus+"' ";
					}
					if(!"".equals(sopstatus)){
						sqlWhere +=" and b.sop_status = '"+sopstatus+"' ";
					}
					if(!"".equals(dhcolor)){
						sqlWhere +=" and f_get_taskinfo(a.id,b.sop_status,'4') = '"+dhcolor+"' ";
					}
					if(!"".equals(xgry)){
					    sqlWhere +=" and (a.members like '%"+xgry+"%' or a.manager = '"+xgry+"' or "+
 									" b.sop_cmo_team_leader = '"+xgry+"' or "+
      								" b.sop_sop_contact = '"+xgry+"' or b.sop_cmo_contact = '"+xgry+"' or "+
      								" b.sop_flow_contact = '"+xgry+"' or "+
       								" b.sop_sub_flow_contact = '"+xgry+"' or "+
       								" exists(select 1 from prj_taskprocess c where c.prjid=a.id and c.hrmid='"+xgry+"')) ";
					}
					String orderby = " order by a.procode asc";
					String tableString = backfields+fromSql+sqlWhere+orderby;
				   // out.print(tableString);
					rs.executeSql(tableString);
                    while(rs.next()){
                          color = Util.null2String(rs.getString("color"));
						  prjid = Util.null2String(rs.getString("procode"));
						  sop_sop_title = Util.null2String(rs.getString("name"));
						  sop_sop_contact = Util.null2String(rs.getString("sop_sop_contact"));
						  sub_contact = Util.null2String(rs.getString("sub_contact"));
						  sop_business_flow = Util.null2String(rs.getString("sop_business_flow"));
						  sop_flow_contact = Util.null2String(rs.getString("sop_flow_contact"));
						  sub_flow = Util.null2String(rs.getString("sub_flow"));
						  sop_sub_flow = Util.null2String(rs.getString("sop_sub_flow"));
						  sop_sub_flow_contact = Util.null2String(rs.getString("sop_sub_flow_contact"));
						  sub_sub_flow_contact = Util.null2String(rs.getString("sub_sub_flow_contact"));
						  sop_cmo_team = Util.null2String(rs.getString("sop_cmo_team"));
						  sop_cmo_team_leader = Util.null2String(rs.getString("sop_cmo_team_leader"));
						  yj1 = Util.null2String(rs.getString("yj1"));
						  sj1 = Util.null2String(rs.getString("sj1"));
						  mqwc1 = Util.null2String(rs.getString("mqwc1"));
						  yj2 = Util.null2String(rs.getString("yj2"));
						  sj2 = Util.null2String(rs.getString("sj2"));
						  mqwc2 = Util.null2String(rs.getString("mqwc2"));
						  yj3 = Util.null2String(rs.getString("yj3"));
						  sj3 = Util.null2String(rs.getString("sj3"));
						  mqwc3 = Util.null2String(rs.getString("mqwc3"));
						  yj4 = Util.null2String(rs.getString("yj4"));
						  sj4 = Util.null2String(rs.getString("sj4"));
						  mqwc4 = Util.null2String(rs.getString("mqwc4"));
						  yj5 = Util.null2String(rs.getString("yj5"));
						  sj5 = Util.null2String(rs.getString("sj5"));
						  mqwc5 = Util.null2String(rs.getString("mqwc5"));
						  sop_status = Util.null2String(rs.getString("sop_status"));
						  colorflag = Integer.valueOf(Util.null2String(rs.getString("colorflag")));
				

					  
					%>
                    <tr>
						
						<%if("1".equals(color)){ %>
                           <td class="fvalue" bgcolor="#ffffff">&nbsp;&nbsp;</td>
						<% }else if("2".equals(color)){%>
                           <td class="fvalue" bgcolor="yellow">&nbsp;&nbsp;</td>
						<% }else if("3".equals(color)){ %>
						   <td class="fvalue" bgcolor="#FFC0CB">&nbsp;&nbsp;</td>
						<% }else if("-1".equals(color)){ %>
						   <td class="fvalue" bgcolor="green">&nbsp;&nbsp;</td>
						 <% }else{ %>
                           <td class="fvalue" bgcolor="red">&nbsp;&nbsp;</td>
						<% }
 
						%>
	                    <td class="fvalue">&nbsp;&nbsp;<%=sop_status%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=prjid%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_sop_title%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_sop_contact%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sub_contact%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_business_flow%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_flow_contact%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sub_flow%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_sub_flow%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_sub_flow_contact%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sub_sub_flow_contact%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_cmo_team%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sop_cmo_team_leader%></td>

						<%if(colorflag >0){%>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=yj1%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=sj1%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=mqwc1%></td>
						<%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=yj1%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sj1%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=mqwc1%></td>
                        <%}%>

						<%if(colorflag >1){%>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=yj2%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=sj2%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=mqwc2%></td>
						<%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=yj2%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sj2%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=mqwc2%></td>
						<%}%>

						<%if(colorflag >2){%>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=yj3%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=sj3%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=mqwc3%></td>
						<%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=yj3%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sj3%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=mqwc3%></td>
						<%}%>

						<%if(colorflag >3){%>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=yj4%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=sj4%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=mqwc4%></td>
						<%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=yj4%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sj4%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=mqwc4%></td>
						<%}%>

						<%if(colorflag >4){%>						
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=yj5%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=sj5%></td>
						<td class="fvalue" bgcolor="green">&nbsp;&nbsp;<%=mqwc5%></td>
						<%}else{%>
						<td class="fvalue">&nbsp;&nbsp;<%=yj5%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=sj5%></td>
						<td class="fvalue">&nbsp;&nbsp;<%=mqwc5%></td>
						<%}%>
                 </tr>
				 <%}%>
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	
	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	   

	</script>
</BODY>
</HTML>