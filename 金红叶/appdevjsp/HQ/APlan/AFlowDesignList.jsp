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
			WIDTH: 2460px;
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
	String yjlc = Util.null2String(request.getParameter("yjlc"));
	String ejlc = Util.null2String(request.getParameter("ejlc"));
	String tjlc = Util.null2String(request.getParameter("tjlc"));
	String sjlc = Util.null2String(request.getParameter("sjlc"));
	String appfzr = Util.null2String(request.getParameter("appfzr"));
	String ibmgw = Util.null2String(request.getParameter("ibmgw"));
	String yqts = Util.null2String(request.getParameter("yqts"));
	String zb = Util.null2String(request.getParameter("zb"));
	
	String gzzt_0 = Util.null2String(request.getParameter("gzzt_0"));
	String gzzt_1 = Util.null2String(request.getParameter("gzzt_1"));
	String gzzt_2 = Util.null2String(request.getParameter("gzzt_2"));
	String gzzt_3 = Util.null2String(request.getParameter("gzzt_3"));
	String gzzt_4 = Util.null2String(request.getParameter("gzzt_4"));
	String gzzt_5 = Util.null2String(request.getParameter("gzzt_5"));
	String gzzt_6 = Util.null2String(request.getParameter("gzzt_6"));
	String gzzt_7 = Util.null2String(request.getParameter("gzzt_7"));
	String gzzt_8 = Util.null2String(request.getParameter("gzzt_8"));
	
	int number = new Random().nextInt(1000) + 1; 
	String num = number + "=" + number;

	String url_1 = "/appdevjsp/HQ/APlan/AFlowDesignList.jsp";
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String showsql ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String out_pageId = "out_liuchengshejijihua3";
	
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
		modeId="762";
		formId="-135";
		fieldid="11186";
    }
	else{
		modeId="362";
		formId="-190";
		fieldid="14736";
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
					<input type="button" value="新建流程" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 150px;" onclick="onBtnNewClick();"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				<wea:item>一级流程</wea:item>
				<wea:item>
				 <input name="yjlc" id="yjlc" class="InputStyle" type="text" value="<%=yjlc %>"/>
				</wea:item>
				<wea:item>二级流程</wea:item>
				<wea:item>
				 <input name="ejlc" id="ejlc" class="InputStyle" type="text" value="<%=ejlc %>"/>
				</wea:item>
				<wea:item>三级流程</wea:item>
				<wea:item>
				 <input name="tjlc" id="tjlc" class="InputStyle" type="text" value="<%=tjlc %>"/>
				</wea:item>
				<wea:item>四级流程</wea:item>
				<wea:item>
				 <input name="sjlc" id="sjlc" class="InputStyle" type="text" value="<%=sjlc %>"/>
				</wea:item>
				<wea:item>当前状态</wea:item>
				<wea:item>
					<input type="checkbox"  value="true" <%=(gzzt_0.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'0')" notBeauty="true">讨论开始&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_1.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'1')" notBeauty="true">流程小组共识&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_2.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'2')" notBeauty="true">流程OM&PMO&nbsp;&nbsp;&nbsp;&nbsp;<br>
					<input type="checkbox"  value="true" <%=(gzzt_3.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'3')" notBeauty="true">流程项目总监&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_4.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'4')" notBeauty="true">SOP小组共识&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_5.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'5')" notBeauty="true">SOP OM&PMO&nbsp;&nbsp;&nbsp;&nbsp;<br>
					<input type="checkbox"  value="true" <%=(gzzt_6.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'6')" notBeauty="true">SOP 项目总监&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_7.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'7')" notBeauty="true">完成&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_8.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'8')" notBeauty="true">未开始&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="hidden" name="gzzt_0" id="gzzt_0" value="<%= gzzt_0%>"/>
					<input type="hidden" name="gzzt_1" id="gzzt_1" value="<%= gzzt_1%>"/>
					<input type="hidden" name="gzzt_2" id="gzzt_2" value="<%= gzzt_2%>"/>
					<input type="hidden" name="gzzt_3" id="gzzt_3" value="<%= gzzt_3%>"/>
					<input type="hidden" name="gzzt_4" id="gzzt_4" value="<%= gzzt_4%>"/>
					<input type="hidden" name="gzzt_5" id="gzzt_5" value="<%= gzzt_5%>"/>
					<input type="hidden" name="gzzt_6" id="gzzt_6" value="<%= gzzt_6%>"/>
					<input type="hidden" name="gzzt_7" id="gzzt_7" value="<%= gzzt_7%>"/>
					<input type="hidden" name="gzzt_8" id="gzzt_8" value="<%= gzzt_8%>"/>
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
				<wea:item>APP负责人</wea:item>
				<wea:item>
				 <input name="appfzr" id="appfzr" class="InputStyle" type="text" value="<%=appfzr %>"/>
				</wea:item>
				<wea:item>IBM顾问</wea:item>
				<wea:item>
				 <input name="ibmgw" id="ibmgw" class="InputStyle" type="text" value="<%=ibmgw %>"/>
				</wea:item>
				<wea:item>所属组别</wea:item>
				<wea:item>
				 <input name="zb" id="zb" class="InputStyle" type="text" value="<%=zb %>"/>
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
		String backfields = " ID,YJBH,YJLC,EJBH,EJLC,TJBH,TJLC,SJBH,SJLC,APPFZR,IBMGW,zb,zb1,"
				+"JHTLKS,JHLCTXZGS,JHLCTOMPMO,JHLCTXMZJ,JHSOPXZGS,JHSOPOMPMO,JHSOPXMZJ,"
				+"SJTLKS,SJLCTXZGS,SJLCTOMPMO,SJLCTXMZJ,SJSOPXZGS,SJSOPOMPMO,SJSOPXMZJ,"
				+"cyxz,yqxsm,dqzt,dqztrq,yqts,tlksdh,lctxzgsdh,lctompmodh,lctxmzjdh,sopxzgsdh,sopompmodh,sopxmzjdh ";
				
		String fromSql  = " uf_flowdesign_view a ";
	
		String sqlWhere=" where "+num;

		String orderby = " yjbh,ejbh,sjbh,sjbh";
		String tableString = "";
		if(!"".equals(yjlc)){
		  sqlWhere +=" and yjlc like '%"+yjlc+"%'";
		}
		if(!"".equals(ejlc)){
		  sqlWhere +=" and ejlc like '%"+ejlc+"%'";
		}
		if(!"".equals(tjlc)){
		  sqlWhere +=" and tjlc like '%"+tjlc+"%'";
		}
		if(!"".equals(sjlc)){
		  sqlWhere +=" and sjlc like '%"+sjlc+"%'";
		}
		if(!"".equals(appfzr)){
		  sqlWhere +=" and appfzr like '%"+appfzr+"%'";
		}
		if(!"".equals(ibmgw)){
		  sqlWhere +=" and ibmgw like '%"+ibmgw+"%'";
		}
		if(!"".equals(zb)){
		  sqlWhere +=" and zb like '%"+zb+"%'";
		}
		if("0".equals(glyjs)){
	      sqlWhere +=" and zb like '%"+zb1+"%'";	
	    }
		if("false".equals(gzzt_0)){
		  sqlWhere +=" and dqzt <>  '讨论开始'";
		}
		if("false".equals(gzzt_1)){
		  sqlWhere +=" and dqzt <>  '流程小组共识'";
		}
		if("false".equals(gzzt_2)){
		  sqlWhere +=" and dqzt <>  '流程OM&PMO'";
		}
		if("false".equals(gzzt_3)){
		  sqlWhere +=" and dqzt <>  '流程项目总监'";
		}
		if("false".equals(gzzt_4)){
		  sqlWhere +=" and dqzt <>  'SOP小组共识'";
		}
		if("false".equals(gzzt_5)){
		  sqlWhere +=" and dqzt <>  'SOP OM&PMO'";
		}
		if("false".equals(gzzt_6)){
		  sqlWhere +=" and dqzt <>  'SOP项目总监'";
		}
		if("false".equals(gzzt_7)){
		  sqlWhere +=" and dqzt <>  '完成'";
		}
		if("false".equals(gzzt_8)){
		  sqlWhere +=" and dqzt <>  '未开始'";
		}
		if(!"".equals(yqts)){
			if("0".equals(yqts)){
				sqlWhere +=" and yqts >= 0 and  yqts <= 5 and SJSOPXMZJ is null ";
			}
			if("1".equals(yqts)){
				sqlWhere +=" and yqts > 5 and SJSOPXMZJ is null ";
			}
	      	if("2".equals(yqts)){
				sqlWhere +=" and yqts >= 0 and SJSOPXMZJ is null ";
			}
	    }

		showsql = "select "+backfields+" from "+fromSql+sqlWhere+" order by "+orderby;
		String  operateString= "";  
		operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:view();\" linkkey=\"ztid\" linkvaluecolumn=\"ID\" text=\"查看\"  target=\"_fullwindow\" index=\"0\"/> "+
		                    "</operates>";             
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"ID\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=  "<col width=\"10%\" text=\"序号\" column=\"ID\" orderkey=\"ID\"/>"+
			"               <col width=\"10%\" text=\"当前状态\" column=\"DQZT\" orderkey=\"DQZT\"/>"+
			"               <col width=\"10%\" text=\"一级编号\" column=\"YJBH\" orderkey=\"YJBH\"/>"+
			"               <col width=\"10%\" text=\"一级流程\" column=\"YJLC\" orderkey=\"YJLC\"/>"+
			"               <col width=\"10%\" text=\"二级编号\" column=\"EJBH\" orderkey=\"EJBH\"/>"+
			"               <col width=\"10%\" text=\"二级流程\" column=\"EJLC\" orderkey=\"EJLC\"/>"+
			"               <col width=\"10%\" text=\"三级编号\" column=\"TJBH\" orderkey=\"TJBH\"/>"+
			"               <col width=\"10%\" text=\"三级流程\" column=\"TJLC\" orderkey=\"TJLC\"/>"+
			"               <col width=\"10%\" text=\"四级编号\" column=\"SJBH\" orderkey=\"SJBH\"/>"+
			"               <col width=\"10%\" text=\"四级流程\" column=\"SJLC\" orderkey=\"SJLC\"/>"+
			"               <col width=\"10%\" text=\"组别\" column=\"ZB\" orderkey=\"ZB\"/>"+
			"               <col width=\"10%\" text=\"参与小组\" column=\"CYXZ\" orderkey=\"CYXZ\"/>"+
			"               <col width=\"10%\" text=\"IBM顾问\" column=\"IBMGW\" orderkey=\"IBMGW\" />"+
			"               <col width=\"10%\" text=\"APP负责人\" column=\"APPFZR\" orderkey=\"APPFZR\"/>"+
			"               <col width=\"10%\" text=\"计划讨论开始\" column=\"JHTLKS\" orderkey=\"JHTLKS\"/>"+
			"               <col width=\"10%\" text=\"流程计划小组共识\" column=\"JHLCTXZGS\" orderkey=\"JHLCTXZGS\"/>"+
			"               <col width=\"10%\" text=\"流程计划OMPMO\" column=\"JHLCTOMPMO\" orderkey=\"JHLCTOMPMO\"/>"+
			"               <col width=\"10%\" text=\"流程计划项目总监\" column=\"JHLCTXMZJ\" orderkey=\"JHLCTXMZJ\"/>"+
			"               <col width=\"10%\" text=\"SOP计划小组共识\" column=\"JHSOPXZGS\" orderkey=\"JHSOPXZGS\"/>"+
			"               <col width=\"10%\" text=\"SOP计划OMPMO\" column=\"JHSOPOMPMO\" orderkey=\"JHSOPOMPMO\"/>"+
			"               <col width=\"10%\" text=\"SOP计划项目总监\" column=\"JHSOPXMZJ\" orderkey=\"JHSOPXMZJ\"/>"+
			"               <col width=\"10%\" text=\"流程实际小组共识\" column=\"SJLCTXZGS\" orderkey=\"SJLCTXZGS\"/>"+
			"               <col width=\"10%\" text=\"流程实际OMPMO\" column=\"SJLCTOMPMO\" orderkey=\"SJLCTOMPMO\"/>"+
			"               <col width=\"10%\" text=\"流程实际项目总监\" column=\"SJLCTXMZJ\" orderkey=\"SJLCTXMZJ\"/>"+
			"               <col width=\"10%\" text=\"SOP实际小组共识\" column=\"SJSOPXZGS\" orderkey=\"SJSOPXZGS\"/>"+
			"               <col width=\"10%\" text=\"SOP实际OMPMO\" column=\"SJSOPOMPMO\" orderkey=\"SJSOPOMPMO\"/>"+
			"               <col width=\"10%\" text=\"SOP实际项目总监\" column=\"SJSOPXMZJ\" orderkey=\"SJSOPXMZJ\"/>"+
			"               <col width=\"10%\" text=\"延期天数\" column=\"YQTS\" orderkey=\"YQTS\"/>"+
			"               <col width=\"10%\" text=\"延期项说明\" column=\"YQXSM\" orderkey=\"YQXSM\"/>"+
		"			</head>"+
	" </table>";
	%>
	<div style="display:none">
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	</div>
	<div style="width:2460px; ">	
		<div class="table-head" style="width:2460px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
			    <tbody>		
			        <tr>			
			            <td>
			            <table class="ViewForm1  maintable" scrolling="auto">
			                <colgroup>  
				                <col width="60px"></col>
				                <col width="100px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
								<col width="60px"></col>
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
									<td class="fname" rowspan="3" align="center">序号</td>
									<td class="fname" rowspan="3" align="center">当前状态</td>
									<td class="fname" rowspan="3" align="center">一级编号</td>
									<td class="fname" rowspan="3" align="center">一级流程</td>
									<td class="fname" rowspan="3" align="center">二级编号</td>
									<td class="fname" rowspan="3" align="center">二级流程</td>
									<td class="fname" rowspan="3" align="center">三级编号</td>
									<td class="fname" rowspan="3" align="center">三级流程</td>
									<td class="fname" rowspan="3" align="center">四级编号</td>
									<td class="fname" rowspan="3" align="center">四级流程<br><font color="red">(点击编辑)</font></td>
									<td class="fname" rowspan="3" align="center">组别</td>
									<td class="fname" rowspan="3" align="center">参与小组</td>
									<td class="fname" rowspan="3" align="center">IBM顾问</td>
									<td class="fname" rowspan="3" align="center">APP负责人</td>
									<td class="fname" colspan="7" align="center">计划时间</td>
									<td class="fname" colspan="7" align="center">实际时间</td>	
									<td class="fname" rowspan="3" align="center">延期天数</td>
									<td class="fname" rowspan="3" align="center">延期项说明</td>    	
			                 </tr>
							 <tr>
								  <td class="fname" rowspan="2" align="center">&nbsp;&nbsp;讨论开始</td>
								  <td class="fname" colspan="3" align="center">&nbsp;&nbsp;流程图确认</td>
								  <td class="fname" colspan="3" align="center">&nbsp;&nbsp;SOP确认</td>
								  <td class="fname" rowspan="2" align="center">&nbsp;&nbsp;讨论开始</td>
								  <td class="fname" colspan="3" align="center">&nbsp;&nbsp;流程图确认</td>
								  <td class="fname" colspan="3" align="center">&nbsp;&nbsp;SOP确认</td>
							 </tr>
							 <tr>
								  <td class="fname" align="center">&nbsp;&nbsp;小组共识</td>
								  <td class="fname" align="center">&nbsp;&nbsp;OM&PMO</td>
								  <td class="fname" align="center">&nbsp;&nbsp;项目总监</td>
								  <td class="fname" align="center">&nbsp;&nbsp;小组共识</td>
								  <td class="fname" align="center">&nbsp;&nbsp;OM&PMO</td>
								  <td class="fname" align="center">&nbsp;&nbsp;项目总监</td>
								  <td class="fname" align="center">&nbsp;&nbsp;小组共识</td>
								  <td class="fname" align="center">&nbsp;&nbsp;OM&PMO</td>
								  <td class="fname" align="center">&nbsp;&nbsp;项目总监</td>
								  <td class="fname" align="center">&nbsp;&nbsp;小组共识</td>
								  <td class="fname" align="center">&nbsp;&nbsp;OM&PMO</td>
								  <td class="fname" align="center">&nbsp;&nbsp;项目总监</td>
							 </tr>
							</tbody>
			            </table>
			            </td>
			        </tr>
			    </tbody>
			</table>
		</div>
		<div class="table-body" id="div22" style="width:2460px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
		    <tbody>		
		        <tr>			
		            <td>
			            <table class="ViewForm1  maintable" scrolling="auto">
			                <colgroup>  
								<col width="60px"></col>
				                <col width="100px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
				                <col width="60px"></col>
				                <col width="80px"></col>
								<col width="60px"></col>
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
								String YJBH="";
								String YJLC="";
								String EJBH="";
								String EJLC="";
								String TJBH="";
								String TJLC="";
								String SJBH="";
								String SJLC="";
								String APPFZR="";
								String ZB="";
								String CYXZ="";
								String IBMGW="";
								String JHTLKS="";
								String JHLCTXZGS="";
								String JHLCTOMPMO="";
								String JHLCTXMZJ="";
								String JHSOPXZGS="";
								String JHSOPOMPMO="";
								String JHSOPXMZJ="";
								String SJTLKS="";
								String SJLCTXZGS="";
								String SJLCTOMPMO="";
								String SJLCTXMZJ="";
								String SJSOPXZGS="";
								String SJSOPOMPMO="";
								String SJSOPXMZJ="";
								String YQXSM="";
								String DQZT="";
								String dqztrq="";
								String YQTS="";
								String tlksdh="";
								String lctxzgsdh="";
								String lctompmodh="";
								String lctxmzjdh="";
								String sopxzgsdh="";
								String sopompmodh="";
								String sopxmzjdh="";

								rs.executeSql(showsql);
			                    while(rs.next()){
								    ID=Util.null2String(rs.getString("ID"));
									YJBH=Util.null2String(rs.getString("YJBH"));
									YJLC=Util.null2String(rs.getString("YJLC"));
									EJBH=Util.null2String(rs.getString("EJBH"));
									EJLC=Util.null2String(rs.getString("EJLC"));
									TJBH=Util.null2String(rs.getString("TJBH"));
									TJLC=Util.null2String(rs.getString("TJLC"));
									SJBH=Util.null2String(rs.getString("SJBH"));
									SJLC=Util.null2String(rs.getString("SJLC"));
									APPFZR=Util.null2String(rs.getString("APPFZR"));
									ZB=Util.null2String(rs.getString("ZB"));
									CYXZ=Util.null2String(rs.getString("CYXZ"));
									IBMGW=Util.null2String(rs.getString("IBMGW"));
									JHTLKS=Util.null2String(rs.getString("JHTLKS"));
									JHLCTXZGS=Util.null2String(rs.getString("JHLCTXZGS"));
									JHLCTOMPMO=Util.null2String(rs.getString("JHLCTOMPMO"));
									JHLCTXMZJ=Util.null2String(rs.getString("JHLCTXMZJ"));
									JHSOPXZGS=Util.null2String(rs.getString("JHSOPXZGS"));
									JHSOPOMPMO=Util.null2String(rs.getString("JHSOPOMPMO"));
									JHSOPXMZJ=Util.null2String(rs.getString("JHSOPXMZJ"));
									SJTLKS=Util.null2String(rs.getString("SJTLKS"));
									SJLCTXZGS=Util.null2String(rs.getString("SJLCTXZGS"));
									SJLCTOMPMO=Util.null2String(rs.getString("SJLCTOMPMO"));
									SJLCTXMZJ=Util.null2String(rs.getString("SJLCTXMZJ"));
									SJSOPXZGS=Util.null2String(rs.getString("SJSOPXZGS"));
									SJSOPOMPMO=Util.null2String(rs.getString("SJSOPOMPMO"));
									SJSOPXMZJ=Util.null2String(rs.getString("SJSOPXMZJ"));
									YQXSM=Util.null2String(rs.getString("YQXSM"));
									DQZT=Util.null2String(rs.getString("DQZT"));
									dqztrq=Util.null2String(rs.getString("dqztrq"));
									YQTS=Util.null2String(rs.getString("YQTS"));
									tlksdh=Util.null2String(rs.getString("tlksdh"));
									lctxzgsdh=Util.null2String(rs.getString("lctxzgsdh"));
									lctompmodh=Util.null2String(rs.getString("lctompmodh"));
									lctxmzjdh=Util.null2String(rs.getString("lctxmzjdh"));
									sopxzgsdh=Util.null2String(rs.getString("sopxzgsdh"));
									sopompmodh=Util.null2String(rs.getString("sopompmodh"));
									sopxmzjdh=Util.null2String(rs.getString("sopxmzjdh"));
								%>
								
			                    <tr>
				                    <td class="fvalue">&nbsp;&nbsp;<%=ID%><input type="button" value="复制" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 150px;" onclick="copy(<%=ID%>);"/></td>
									
									<%if(Long.parseLong(YQTS)<=0&&!"".equals(SJSOPXMZJ)){ %>	
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
									
									<td class="fvalue">&nbsp;&nbsp;<%=YJBH%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=YJLC%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=EJBH%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=EJLC%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=TJBH%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=TJLC%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=SJBH%></td>
									<td class="fvalue">&nbsp;&nbsp;<a href='javaScript:edit(<%=ID%>);'><font color="#5169fb"><%=SJLC%></font></a></td>
									<td class="fvalue">&nbsp;&nbsp;<%=ZB%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=CYXZ%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=IBMGW%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=APPFZR%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHTLKS%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHLCTXZGS%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHLCTOMPMO%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHLCTXMZJ%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHSOPXZGS%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHSOPOMPMO%></td>
									<td class="fvalue">&nbsp;&nbsp;<%=JHSOPXMZJ%></td>

									<%if("1".equals(tlksdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJTLKS%></td>
									<% }else if("2".equals(tlksdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJTLKS%></td>
									<% }else if("3".equals(tlksdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJTLKS%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJTLKS%></td>
									<% }%>
									
									<%if("1".equals(lctxzgsdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJLCTXZGS%></td>
									<% }else if("2".equals(lctxzgsdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJLCTXZGS%></td>
									<% }else if("3".equals(lctxzgsdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJLCTXZGS%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJLCTXZGS%></td>
									<% }%>
									
									<%if("1".equals(lctompmodh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJLCTOMPMO%></td>
									<% }else if("2".equals(lctompmodh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJLCTOMPMO%></td>
									<% }else if("3".equals(lctompmodh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJLCTOMPMO%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJLCTOMPMO%></td>
									<% }%>
									
									<%if("1".equals(lctxmzjdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJLCTXMZJ%></td>
									<% }else if("2".equals(lctxmzjdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJLCTXMZJ%></td>
									<% }else if("3".equals(lctxmzjdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJLCTXMZJ%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJLCTXMZJ%></td>
									<% }%>
									
									<%if("1".equals(sopxzgsdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJSOPXZGS%></td>
									<% }else if("2".equals(sopxzgsdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJSOPXZGS%></td>
									<% }else if("3".equals(sopxzgsdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJSOPXZGS%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJSOPXZGS%></td>
									<% }%>
									
									<%if("1".equals(sopompmodh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJSOPOMPMO%></td>
									<% }else if("2".equals(sopompmodh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJSOPOMPMO%></td>
									<% }else if("3".equals(sopompmodh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJSOPOMPMO%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJSOPOMPMO%></td>
									<% }%>
									
									<%if("1".equals(sopxmzjdh)){ %>	
			                           <td class="fvalue" bgcolor="#8efb8e">&nbsp;&nbsp;<%=SJSOPXMZJ%></td>
									<% }else if("2".equals(sopxmzjdh)){%>
			                           <td class="fvalue" bgcolor="#f6f8b6">&nbsp;&nbsp;<%=SJSOPXMZJ%></td>
									<% }else if("3".equals(sopxmzjdh)){ %>
									   <td class="fvalue" bgcolor="#fcc3e3">&nbsp;&nbsp;<%=SJSOPXMZJ%></td>
									 <% }else{%>
			                           <td class="fvalue">&nbsp;&nbsp;<%=SJSOPXMZJ%></td>
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
          if(ty=='5'){
          	if(vi.checked){
        		document.getElementById("gzzt_5").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_5").value= "false";
        	}
          }
          if(ty=='6'){
          	if(vi.checked){
        		document.getElementById("gzzt_6").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_6").value= "false";
        	}
          }
          if(ty=='7'){
          	if(vi.checked){
        		document.getElementById("gzzt_7").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_7").value= "false";
        	}
          }
          if(ty=='8'){
          	if(vi.checked){
        		document.getElementById("gzzt_8").value= "true";
        	}
        	else{
        		document.getElementById("gzzt_8").value= "false";
        	}
          }
        }
		function refersh() {
  			window.location.reload();
  		}
  		function onBtnNewClick() {
  		 var title = "";
		var url = "";
		title = "新建流程讨论计划";
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
			title = "编辑流程讨论计划";
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
			title = "查看流程讨论计划";
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
			title = "复制流程讨论计划";
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