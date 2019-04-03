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
		
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 1400px;
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
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String rwxm = Util.null2String(request.getParameter("rwxm"));
	String zzt = Util.null2String(request.getParameter("zzt"));
	String zb = Util.null2String(request.getParameter("zb"));
	String appzrr = Util.null2String(request.getParameter("appzrr"));
	String ibmgw = Util.null2String(request.getParameter("ibmgw"));
	String yqts = Util.null2String(request.getParameter("yqts"));
	
	String gzzt_0 = Util.null2String(request.getParameter("gzzt_0"));
	String gzzt_1 = Util.null2String(request.getParameter("gzzt_1"));
	String gzzt_2 = Util.null2String(request.getParameter("gzzt_2"));
	String gzzt_3 = Util.null2String(request.getParameter("gzzt_3"));
	String gzzt_4 = Util.null2String(request.getParameter("gzzt_4"));
	
	int number = new Random().nextInt(1000) + 1; 
	String num = number + "=" + number;

	String url_1 = "/appdevjsp/HQ/APlan/APlanList.jsp";
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String showsql ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String out_pageId = "out_zhuantijihua3";
	
	String sql = "select machine from uf_machine ";
	rs.execute(sql);
	String machine="";
	String modeId="";
	String formId="";
	String fieldid="";
	
	if(rs.next()){
		machine=Util.null2String(rs.getString("machine"));
	}
	if("DEV".equals(machine)){
		modeId="741";
		formId="-133";
		fieldid="11158";
		
    }
	else{
		modeId="361";
		formId="-191";
		fieldid="14752";
	}
	String zb1="";
	rs.executeSql("select zb from workcode_virtualdept_view a where workcode='"+userid+"'");
	   	while(rs.next()){
	   		zb1 = Util.null2String(rs.getString("zb"));
	   	}
	   	
	String glyjs="";
	rs.executeSql("select count(*) as glyjs from hrmrolemembers a,hrmroles b where a.roleid=b.id and b.rolesmark='Issue Super' and a.resourceid='"+userid+"'");
   	while(rs.next()){
   		glyjs = Util.null2String(rs.getString("glyjs"));
   	}	
	
	%>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
    <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
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
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action=<%=url_1 %> method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<input type="button" value="新建专题讨论" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 150px;" onclick="onBtnNewClick();"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				<wea:item>任务项目</wea:item>
				<wea:item>
				 <input name="rwxm" id="rwxm" class="InputStyle" type="text" value="<%=rwxm %>"/>
				</wea:item>
				<wea:item>子专题</wea:item>
				<wea:item>
				 <input name="zzt" id="zzt" class="InputStyle" type="text" value="<%=zzt %>"/>
				</wea:item>
				<wea:item>当前状态</wea:item>
				<wea:item>
					<input type="checkbox"  value="true" <%=(gzzt_0.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'0')" notBeauty="true">讨论开始&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_1.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'1')" notBeauty="true">小组共识&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_2.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'2')" notBeauty="true">审核确认&nbsp;&nbsp;&nbsp;&nbsp;<br>
					<input type="checkbox"  value="true" <%=(gzzt_3.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'3')" notBeauty="true">完成&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_4.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'4')" notBeauty="true">未开始&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="hidden" name="gzzt_0" id="gzzt_0" value="<%= gzzt_0%>"/>
					<input type="hidden" name="gzzt_1" id="gzzt_1" value="<%= gzzt_1%>"/>
					<input type="hidden" name="gzzt_2" id="gzzt_2" value="<%= gzzt_2%>"/>
					<input type="hidden" name="gzzt_3" id="gzzt_3" value="<%= gzzt_3%>"/>
					<input type="hidden" name="gzzt_4" id="gzzt_4" value="<%= gzzt_4%>"/>
				</wea:item>
				
				<wea:item>延期状态</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="yqts" id="yqts"> 
				<option value="" <%if("".equals(yqts)){%> selected<%} %>>
					<%=""%></option>
				<option value="0" <%if("0".equals(yqts)){%> selected<%} %>>
					<%="黄(延期0~5天)"%></option>
				<option value="1" <%if("1".equals(yqts)){%> selected<%} %>>
					<%="红(延期大于5天)"%></option>
				<option value="2" <%if("2".equals(yqts)){%> selected<%} %>>
					<%="黄/红(延期大于0天)"%></option>
				</select>
				</wea:item>

				<wea:item>所属组别</wea:item>
				<wea:item>
				 <input name="zb" id="zb" class="InputStyle" type="text" value="<%=zb %>"/>
				</wea:item>
				<wea:item>APP负责人</wea:item>
				<wea:item>
				 <input name="appzrr" id="appzrr" class="InputStyle" type="text" value="<%=appzrr %>"/>
				</wea:item>
				<wea:item>IBM顾问</wea:item>
				<wea:item>
				 <input name="ibmgw" id="ibmgw" class="InputStyle" type="text" value="<%=ibmgw %>"/>
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

		<%
		String backfields = "id,RWXM,ZZT,ZB,ZB1,DQZT,DQZTRQ,YQXSM,YQTS,"
				+"CYXZ,IBMGW,APPZRR,JHTLKSSJ,JHDCXZGSSJ,JHSHQRSJ,SJTLKSSJ,SJDCXZGSSJ,SJSHQRSJ,tlksdh,dcczgsdh,shqrdh";
		String fromSql  = " uf_ztjhtl_view2 a ";
		
		String sqlWhere=" where 1=1 and "+num;

		String orderby = " a.ID ";
		String tableString = "";
		if(!"".equals(rwxm)){
		  sqlWhere +=" and rwxm like '%"+rwxm+"%'";
		}
		if(!"".equals(zzt)){
		  sqlWhere +=" and zzt like '%"+zzt+"%'";
		}
		
		if(!"".equals(zb)){
		  sqlWhere +=" and zb like '%"+zb+"%'";
		}
		if(!"".equals(appzrr)){
		  sqlWhere +=" and appzrr like '%"+appzrr+"%'";
		}
		if(!"".equals(ibmgw)){
		  sqlWhere +=" and ibmgw like '%"+ibmgw+"%'";
		}
		if("0".equals(glyjs)){
	      sqlWhere +=" and zb like '%"+zb1+"%'";	
	    }
	    if("false".equals(gzzt_0)){
		  sqlWhere +=" and dqzt <>  '讨论开始'";
		}
		if("false".equals(gzzt_1)){
		  sqlWhere +=" and dqzt <>  '小组共识'";
		}
		if("false".equals(gzzt_2)){
		  sqlWhere +=" and dqzt <>  '审核确认'";
		}
		if("false".equals(gzzt_3)){
		  sqlWhere +=" and dqzt <>  '完成'";
		}
		if("false".equals(gzzt_4)){
		  sqlWhere +=" and dqzt <>  '未开始'";
		}
		if(!"".equals(yqts)){
			if("0".equals(yqts)){
				sqlWhere +=" and yqts >= 0 and  yqts <= 5 and SJSHQRSJ is null ";
			}
			if("1".equals(yqts)){
				sqlWhere +=" and yqts > 5 and SJSHQRSJ is null ";
			}
	      	if("2".equals(yqts)){
				sqlWhere +=" and yqts >= 0 and SJSHQRSJ is null ";
			}
	    }
		showsql = "select "+backfields+" from "+fromSql+sqlWhere+" order by "+orderby;
		String  operateString= "";  
		operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:view();\" linkkey=\"ztid\" linkvaluecolumn=\"ID\" text=\"查看\"  target=\"_fullwindow\" index=\"0\"/> "+
		                    "</operates>";             
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=  "<col width=\"10%\" text=\"序号\" column=\"ID\" orderkey=\"ID\"/>"+
			"               <col width=\"10%\" text=\"当前状态\" column=\"DQZT\" orderkey=\"DQZT\"/>"+
			"               <col width=\"10%\" text=\"任务项目\" column=\"RWXM\" orderkey=\"RWXM\"/>"+
			"               <col width=\"10%\" text=\"子专题\" column=\"ZZT\" orderkey=\"ZZT\"/>"+
			"               <col width=\"10%\" text=\"组别\" column=\"ZB\" orderkey=\"ZB\"/>"+
			"               <col width=\"10%\" text=\"参与小组\" column=\"CYXZ\" orderkey=\"CYXZ\"/>"+
			"               <col width=\"10%\" text=\"IBM顾问\" column=\"IBMGW\" orderkey=\"IBMGW\" />"+
			"               <col width=\"10%\" text=\"APP责任人\" column=\"APPZRR\" orderkey=\"APPZRR\"/>"+
			"               <col width=\"10%\" text=\"计划讨论开始时间\" column=\"JHTLKSSJ\" orderkey=\"JHTLKSSJ\"/>"+
			"               <col width=\"10%\" text=\"计划达成小组共识时间\" column=\"JHDCXZGSSJ\" orderkey=\"JHDCXZGSSJ\"/>"+
			"               <col width=\"10%\" text=\"计划审核确认时间\" column=\"JHSHQRSJ\" orderkey=\"JHSHQRSJ\"/>"+
			"               <col width=\"10%\" text=\"实际讨论开始时间\" column=\"SJTLKSSJ\" orderkey=\"SJTLKSSJ\"/>"+
			"               <col width=\"10%\" text=\"实际达成小组共识时间\" column=\"SJDCXZGSSJ\" orderkey=\"SJDCXZGSSJ\"/>"+
			"               <col width=\"10%\" text=\"实际审核确认时间\" column=\"SJSHQRSJ\" orderkey=\"SJSHQRSJ\"/>"+
			"               <col width=\"10%\" text=\"延期天数\" column=\"YQTS\" orderkey=\"YQTS\"/>"+
			"               <col width=\"10%\" text=\"延期项说明\" column=\"YQXSM\" orderkey=\"YQXSM\"/>"+
		"			</head>"+
	" </table>";
	%>

	<div style="display:none">
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	</div>
	<div style="width:1400px; ">	
		<div class="table-head" style="width:1400px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
			    <tbody>		
			        <tr>			
			            <td>
			            <table class="ViewForm1  maintable" scrolling="auto">
			                <colgroup>  
				                <col width="60px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
				                <col width="150px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="150px"></col>
							 </colgroup>
			                <tbody>
								 <tr>
									<td class="fname" rowspan="2" align="center">序号</td>
									<td class="fname" rowspan="2" align="center">当前状态</td>
									<td class="fname" rowspan="2" align="center">任务项目</td>
									<td class="fname" rowspan="2" align="center">子专题<br><font color="red">(点击编辑)</font></td>
									<td class="fname" rowspan="2" align="center">组别</td>
									<td class="fname" rowspan="2" align="center">参与小组</td>
									<td class="fname" rowspan="2" align="center">IBM顾问</td>
									<td class="fname" rowspan="2" align="center">APP责任人</td>
									<td class="fname" colspan="3" align="center">计划时间</td>
									<td class="fname" colspan="3" align="center">实际时间</td>	
									<td class="fname" rowspan="2" align="center">延期天数</td>   
									<td class="fname" rowspan="2" align="center">延期项说明</td>  	
			                 </tr>
							 <tr>
								  <td class="fname">&nbsp;&nbsp;讨论开始</td>
								  <td class="fname">&nbsp;&nbsp;小组共识</td>
								  <td class="fname">&nbsp;&nbsp;审核确认</td>
								  <td class="fname">&nbsp;&nbsp;讨论开始</td>
								  <td class="fname">&nbsp;&nbsp;小组共识</td>
								  <td class="fname">&nbsp;&nbsp;审核确认</td>
							</tr>
							</tbody>
			            </table>
			            </td>
			        </tr>
			    </tbody>
			</table>
		</div>
		<div class="table-body" id="div22" style="width:1400px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
		    <tbody>		
		        <tr>			
		            <td>
			            <table class="ViewForm1  maintable" scrolling="auto">
			                <colgroup>  
								<col width="60px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
				                <col width="150px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
				                <col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="80px"></col>
								<col width="150px"></col>
							 </colgroup>
			                <tbody>
								 
								<% 	
								String ID="";
								String DQZT="";
								String RWXM="";
								String ZZT="";
								String ZB="";
								String CYXZ="";
								String IBMGW="";
								String APPZRR="";
								String JHTLKSSJ="";
								String JHDCXZGSSJ="";
								String JHSHQRSJ="";
								String SJTLKSSJ="";
								String SJDCXZGSSJ="";
								String SJSHQRSJ="";
								String YQTS="";
								String YQXSM="";
								String tlksdh="";
								String dcczgsdh="";
								String shqrdh="";
								rs.executeSql(showsql);
			                    while(rs.next()){
									  ID = Util.null2String(rs.getString("ID"));
									  DQZT = Util.null2String(rs.getString("DQZT"));
									  RWXM = Util.null2String(rs.getString("RWXM"));
									  ZZT = Util.null2String(rs.getString("ZZT"));
									  ZB = Util.null2String(rs.getString("ZB"));
									  CYXZ = Util.null2String(rs.getString("CYXZ"));
									  IBMGW = Util.null2String(rs.getString("IBMGW"));
									  APPZRR = Util.null2String(rs.getString("APPZRR"));
									  JHTLKSSJ = Util.null2String(rs.getString("JHTLKSSJ"));
									  JHDCXZGSSJ = Util.null2String(rs.getString("JHDCXZGSSJ"));
									  JHSHQRSJ = Util.null2String(rs.getString("JHSHQRSJ"));
									  SJTLKSSJ = Util.null2String(rs.getString("SJTLKSSJ"));
									  SJDCXZGSSJ = Util.null2String(rs.getString("SJDCXZGSSJ"));
									  SJSHQRSJ = Util.null2String(rs.getString("SJSHQRSJ"));
									  YQTS = Util.null2String(rs.getString("YQTS"));
									  YQXSM = Util.null2String(rs.getString("YQXSM"));
									  tlksdh= Util.null2String(rs.getString("tlksdh"));
									  dcczgsdh= Util.null2String(rs.getString("dcczgsdh"));
									  shqrdh= Util.null2String(rs.getString("shqrdh"));

								%>
			                    <tr>
				                    <td class="fvalue">&nbsp;&nbsp;<%=ID%><input type="button" value="复制" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 150px;" onclick="copy(<%=ID%>);"/></td>

									<%if(Long.parseLong(YQTS)<=0&&!"".equals(SJSHQRSJ)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=DQZT%></td>
									<% }else if(Long.parseLong(YQTS)>=0&&Long.parseLong(YQTS)<=5){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=DQZT%></td>
									<% }else if(Long.parseLong(YQTS)>5){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=DQZT%></td>
									<% }else if(Long.parseLong(YQTS)<0 && !"未开始".equals(DQZT)){ %>
									   <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=DQZT%></td>   
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=DQZT%></td>
									<% }%>
									
									<td class="fvalue">&nbsp;&nbsp;<%=RWXM%></td>
									<td class="fvalue">&nbsp;&nbsp;<a href='javaScript:edit(<%=ID%>);'><font color="#5169fb"><%=ZZT%></font></a></td>
									<td class="fvalue">&nbsp;&nbsp;<%=ZB%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=CYXZ%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=IBMGW%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=APPZRR%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHTLKSSJ%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHDCXZGSSJ%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHSHQRSJ%></td>

									<%if("1".equals(tlksdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJTLKSSJ%></td>
									<% }else if("2".equals(tlksdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJTLKSSJ%></td>
									<% }else if("3".equals(tlksdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJTLKSSJ%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJTLKSSJ%></td>
									<% }%>
									
									<%if("1".equals(dcczgsdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJDCXZGSSJ%></td>
									<% }else if("2".equals(dcczgsdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJDCXZGSSJ%></td>
									<% }else if("3".equals(dcczgsdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJDCXZGSSJ%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJDCXZGSSJ%></td>
									<% }%>
									
									<%if("1".equals(shqrdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJSHQRSJ%></td>
									<% }else if("2".equals(shqrdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJSHQRSJ%></td>
									<% }else if("3".equals(shqrdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJSHQRSJ%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJSHQRSJ%></td>
									<% }%>
									
									<td class="fvalue">&nbsp;&nbsp;<%=YQTS%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=YQXSM%></td>
			
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
		function onBtnSearchClick() {
			report.submit();
		}
        
		function refersh() {
  			window.location.reload();
  		}
  		
  		function gzzt_check(vi,ty){
          if(ty=='0'){
          	if(vi.checked){
        		document.getElementById("gzzt_0").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_0").value= "false";
        	}
          }
          if(ty=='1'){
          	if(vi.checked){
        		document.getElementById("gzzt_1").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_1").value= "false";
        	}
          }
          if(ty=='2'){
          	if(vi.checked){
        		document.getElementById("gzzt_2").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_2").value= "false";
        	}
          }
          if(ty=='3'){
          	if(vi.checked){
        		document.getElementById("gzzt_3").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_3").value= "false";
        	}
          }
          if(ty=='4'){
          	if(vi.checked){
        		document.getElementById("gzzt_4").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_4").value= "false";
        	}
          }
        }
        
  		function onBtnNewClick() {
  		 var title = "";
		var url = "";
		title = "新建专题讨论计划";
		url="/formmode/view/AddFormMode.jsp?mainid=0&modeId="+<%=modeId %>+"&formId="+<%=formId %>+"&type=1";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 700;
		diag_vote.Model = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show("");	
	    }
	    
  		function edit(ztid) {
			var title = "";
			var url = "";
			title = "编辑专题讨论计划";
			url="/formmode/view/AddFormMode.jsp?mainid=0&modeId="+<%=modeId %>+"&formId="+<%=formId %>+"&type=2&Id=3&billid="+ztid+"";
			
			if(window.top.Dialog){
			diag_vote = new window.top.Dialog();
		    } else {
			    diag_vote = new Dialog();
		    };
		    diag_vote.currentWindow = window;
			diag_vote.Width = 900;
			diag_vote.Height = 800;
			diag_vote.Model = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
			diag_vote.show("");	
	   }
	   
	   function view(ztid) {
			var title = "";
			var url = "";
			title = "查看专题讨论计划";
			url="/formmode/view/AddFormMode.jsp?mainid=0&modeId="+<%=modeId %>+"&formId="+<%=formId %>+"&type=0&billid="+ztid+"";
			
			if(window.top.Dialog){
			diag_vote = new window.top.Dialog();
		    } else {
			    diag_vote = new Dialog();
		    };
		    diag_vote.currentWindow = window;
			diag_vote.Width = 900;
			diag_vote.Height = 800;
			diag_vote.Model = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
			diag_vote.show("");	
	   }
	   
	   function copy(ztid) {
			var title = "";
			var url = "";
			title = "复制专题讨论计划";
			url="/formmode/view/AddFormMode.jsp?mainid=0&modeId="+<%=modeId %>+"&formId="+<%=formId %>+"&type=1&field"+<%=fieldid %>+"="+ztid+"";
			if(window.top.Dialog){
			diag_vote = new window.top.Dialog();
		    } else {
			    diag_vote = new Dialog();
		    };
		    diag_vote.currentWindow = window;
			diag_vote.Width = 900;
			diag_vote.Height = 800;
			diag_vote.Model = true;
			diag_vote.Title = title;
			diag_vote.URL = url;
			diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
			diag_vote.show("");	
	   }
	   
	   function deleteplan(sopid){
			var xhr = null;
			if(!window.confirm('是否需要删除？')){
	                 return false;
	         }
			if (window.ActiveXObject) {//IE浏览器
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
			}
			if (null != xhr) {
				xhr.open("GET","/appdevjsp/HQ/SOP/deletesop.jsp?val="+sopid, false);
				xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
			 	 if (xhr.status == 200) {
			         window.location.reload();
			      }
			    }
			   }
			   xhr.send(null);
	      }

	}
	    
	</script>
	
  <SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
  <SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>