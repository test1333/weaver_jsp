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
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	String model = Util.null2String(request.getParameter("model"));
	String gzlb = Util.null2String(request.getParameter("gzlb"));
	String jb = Util.null2String(request.getParameter("jb"));
	String gzsx = Util.null2String(request.getParameter("gzsx"));
	String tcr = Util.null2String(request.getParameter("tcr"));
	String fzr = Util.null2String(request.getParameter("fzr"));
	String fzz = Util.null2String(request.getParameter("fzz"));
	String tcdateb = Util.null2String(request.getParameter("tcdateb"));
	String tcdatee = Util.null2String(request.getParameter("tcdatee"));
	String wcdateb = Util.null2String(request.getParameter("wcdateb"));
	String wcdatee = Util.null2String(request.getParameter("wcdatee"));
	String fzrzg = Util.null2String(request.getParameter("fzrzg"));
	String ibmgw = Util.null2String(request.getParameter("ibmgw"));
	String gzzt_0 = Util.null2String(request.getParameter("gzzt_0"));
	String gzzt_1 = Util.null2String(request.getParameter("gzzt_1"));
	String gzzt_2 = Util.null2String(request.getParameter("gzzt_2"));
	String gzzt_3 = Util.null2String(request.getParameter("gzzt_3"));
	String gzzt_4 = Util.null2String(request.getParameter("gzzt_4"));
	String gzzt_5 = Util.null2String(request.getParameter("gzzt_5"));
	
	String url_1 = "/appdevjsp/HQ/issue/IssueReport.jsp?model="+model;
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String showsql ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String out_pageId = "out_wentiyudubanreport2";
	
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
		modeId="641";
		formId="-113";
		fieldid="10458";
    }
	else{
		modeId="281";
		formId="-125";
		fieldid="11238";
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
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
	
				<wea:item>工作类别</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="gzlb" id="gzlb"> 
				<option value="" <%if("".equals(gzlb)){%> selected<%} %>>
					<%=""%></option>
				<option value="0" <%if("0".equals(gzlb)){%> selected<%} %>>
					<%="督办"%></option>
				<option value="1" <%if("1".equals(gzlb)){%> selected<%} %>>
					<%="问题"%></option>
				</select>
				</wea:item>	
				
				<wea:item>级别</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="jb" id="jb"> 
				<option value="" <%if("".equals(jb)){%> selected<%} %>>
					<%=""%></option>
				<option value="0" <%if("0".equals(jb)){%> selected<%} %>>
					<%="组内跟踪"%></option>
				<option value="1" <%if("1".equals(jb)){%> selected<%} %>>
					<%="PMO协助"%></option>
				<option value="1" <%if("2".equals(jb)){%> selected<%} %>>
					<%="高层决策"%></option>
				</select>
				</wea:item>	
				
				<wea:item>工作状态</wea:item>
				<wea:item>
					<input type="checkbox"  value="true" <%=(gzzt_0.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'0')" notBeauty="true">未开始&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_1.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'1')" notBeauty="true">进行中&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_2.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'2')" notBeauty="true">已提交&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_5.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'5')" notBeauty="true">已延期<br>
					<input type="checkbox"  value="true" <%=(gzzt_3.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'3')" notBeauty="true">已关闭&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_4.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'4')" notBeauty="true">已取消&nbsp;&nbsp;&nbsp;&nbsp;
					
					<input type="hidden" name="gzzt_0" id="gzzt_0" value="<%= gzzt_0%>"/>
					<input type="hidden" name="gzzt_1" id="gzzt_1" value="<%= gzzt_1%>"/>
					<input type="hidden" name="gzzt_2" id="gzzt_2" value="<%= gzzt_2%>"/>
					<input type="hidden" name="gzzt_3" id="gzzt_3" value="<%= gzzt_3%>"/>
					<input type="hidden" name="gzzt_4" id="gzzt_4" value="<%= gzzt_4%>"/>
					<input type="hidden" name="gzzt_5" id="gzzt_5" value="<%= gzzt_5%>"/>
				</wea:item>
				<wea:item>提出人</wea:item>
				<wea:item>
				 <input name="tcr" id="tcr" class="InputStyle" type="text" value="<%=tcr %>"/>
				</wea:item>	
				<wea:item>所属组别</wea:item>
				<wea:item>
				 <input name="fzz" id="fzz" class="InputStyle" type="text" value="<%=fzz %>"/>
				</wea:item>
				<wea:item>APP负责人</wea:item>
				<wea:item>
				 <input name="fzrzg" id="fzrzg" class="InputStyle" type="text" value="<%=fzrzg %>"/>
				</wea:item>
				<wea:item>IBM顾问</wea:item>
				<wea:item>
				 <input name="ibmgw" id="ibmgw" class="InputStyle" type="text" value="<%=ibmgw %>"/>
				</wea:item>
				<wea:item>问题事项</wea:item>
				<wea:item>
				 <input name="gzsx" id="gzsx" class="InputStyle" type="text" value="<%=gzsx %>"/>
				 <input name="model" id="model" class="InputStyle" type="hidden" value="<%=model %>"/>
				</wea:item>	
				<wea:item>提出时间</wea:item>
				<wea:item>
                   <span id="tcdate"  >
					<button type="button" class="Calendar" id="SelectTCDateb" onclick="getDate(tcdatespanb,tcdateb)"></BUTTON> 
				  	<SPAN id="tcdatespanb"><%=tcdateb%></SPAN> 
			  		<INPUT type="hidden" name="tcdateb" value="<%=tcdateb%>">  
			  		<label>&nbsp;&nbsp;至&nbsp;&nbsp;</label>
			  		<button type="button" class="Calendar" id="SelectTCDatee" onclick="getDate(tcdatespane,tcdatee)"></BUTTON> 
				  	<SPAN id="tcdatespane"><%=tcdatee%></SPAN> 
			  		<INPUT type="hidden" name="tcdatee" value="<%=tcdatee%>">  				  		
				  </span>
                </wea:item>
                <wea:item>计划完成时间</wea:item>
				<wea:item>
                   <span id="wcdate"  >
					<button type="button" class="Calendar" id="SelectWCDateb" onclick="getDate(wcdatespanb,wcdateb)"></BUTTON> 
				  	<SPAN id="wcdatespanb"><%=wcdateb%></SPAN> 
			  		<INPUT type="hidden" name="wcdateb" value="<%=wcdateb%>">  
			  		<label>&nbsp;&nbsp;至&nbsp;&nbsp;</label>
			  		<button type="button" class="Calendar" id="SelectWCDatee" onclick="getDate(wcdatespane,wcdatee)"></BUTTON> 
				  	<SPAN id="wcdatespane"><%=wcdatee%></SPAN> 
			  		<INPUT type="hidden" name="wcdatee" value="<%=wcdatee%>">  				  		
				  </span>
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
		String backfields = " case when d.departmentname is null then '其他' when instr(d.departmentname,'-',1)>1 then substr(d.departmentname, 0,instr(d.departmentname,'-',1)-1) else d.departmentname end as fzz,"
		 +"case when GZZT='0' then '未开始' when GZZT='1' then '进行中' when GZZT='2' then '已提交' "
		 +"when GZZT='3' then '已关闭' when GZZT='4' then '已取消' when GZZT='5' then '已延期' end as GZZT,"
		 +"count(*) as sl ";

		String fromSql  = " uf_taskinfo a,HrmDepartmentVirtual d ";
		
		String sqlWhere=" where 1=1 and a.fzz=d.id(+) ";
		if("1".equals(model)){
			sqlWhere = sqlWhere+" and (modedatacreater='"+userid+"' or fzrzg='"+userid+"') " ;
		}
		if("2".equals(model)){
			sqlWhere = sqlWhere+" and (modedatacreater='"+userid+"' or tcr='"+userid+"' or fzr='"+userid+"' or fzrzg='"+userid+"' or xgcyry like '%"+userid+"%' ) ";
		}
		if("3".equals(model)){
			String glyjs="";
			rs.executeSql("select count(*) as glyjs from hrmrolemembers a,hrmroles b where a.roleid=b.id and b.rolesmark='Issue Super' and a.resourceid='"+userid+"'");
	    	while(rs.next()){
	    		glyjs = Util.null2String(rs.getString("glyjs"));
	    	}
	    	if("0".equals(glyjs)){
	    		response.sendRedirect("noright.jsp");
	    	}
		}
		String orderby = " fzz";
		String tableString = "";
		if(!"".equals(gzlb)){
		  sqlWhere +=" and gzlb = '"+gzlb+"'";
		}
		if(!"".equals(jb)){
		  sqlWhere +=" and jb = '"+jb+"'";
		}
		if("false".equals(gzzt_0)){
		  sqlWhere +=" and gzzt <> '0'";
		}
		if("false".equals(gzzt_1)){
		  sqlWhere +=" and gzzt <> '1'";
		}
		if("false".equals(gzzt_2)){
		  sqlWhere +=" and gzzt <> '2'";
		}
		if("false".equals(gzzt_3)){
		  sqlWhere +=" and gzzt <> '3'";
		}
		if("false".equals(gzzt_4)){
		  sqlWhere +=" and gzzt <> '4'";
		}
		if("false".equals(gzzt_5)){
		  sqlWhere +=" and gzzt <> '5'";
		}
		if(!"".equals(tcr)){
		  sqlWhere +=" and b.lastname like '%"+tcr+"%'";
		}
		if(!"".equals(fzrzg)){
		  sqlWhere +=" and e.lastname like '%"+fzrzg+"%'";
		}
		if(!"".equals(ibmgw)){
		  sqlWhere +=" and f.lastname like '%"+ibmgw+"%'";
		}
		if(!"".equals(fzz)){
		  sqlWhere +=" and d.departmentname like '%"+fzz+"%'";
		}
		if(!"".equals(gzsx)){
		  sqlWhere +=" and gzsx like '%"+gzsx+"%'";
		}
		if(!"".equals(tcdateb)){
		  sqlWhere +=" and tcsj >= '"+tcdateb+"'";
		}
		if(!"".equals(tcdatee)){
		  sqlWhere +=" and tcsj <= '"+tcdatee+"'";
		}
		if(!"".equals(wcdateb)){
		  sqlWhere +=" and jhwcsj >= '"+wcdateb+"'";
		}
		if(!"".equals(wcdatee)){
		  sqlWhere +=" and jhwcsj <= '"+wcdatee+"'";
		}
		sqlWhere +=" group by a.gzzt,departmentname ";
		showsql = "select "+backfields+" from "+fromSql+sqlWhere+" order by "+orderby;
		
		String backfields1=" rownum as id,FZZ,GZZT,SL ";
		String fromSql1=" ( "+showsql+") a";    
		String sqlWhere1= " where 1=1 "; 
		String orderby1= " id "; 
		String showsql1= "select "+backfields1+" from "+fromSql1+sqlWhere1+" order by "+orderby1;
		
		String operateString= "";
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\" sqlprimarykey=\"fzz\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=  "<col width=\"33%\" text=\"所属组别\" column=\"FZZ\" orderkey=\"FZZ\"/>"+
			"               <col width=\"33%\" text=\"工作状态\" column=\"GZZT\" orderkey=\"GZZT\" transmethod='APPDEV.HQ.issue.IssueListOperate.getGzzt'/>"+
			"               <col width=\"33%\" text=\"数量\" column=\"SL\" orderkey=\"SL\"/>"+
		"			</head>"+
	" </table>";
	%>

	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<script type="text/javascript">
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
        }
		function refersh() {
  			window.location.reload();
  		}
 
	</script>
	
  <SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
  <SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>