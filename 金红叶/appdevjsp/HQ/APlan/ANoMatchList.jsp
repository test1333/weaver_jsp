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
			WIDTH: 1260px;
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
	String zt = Util.null2String(request.getParameter("zt"));
	String zb = Util.null2String(request.getParameter("zb"));
	String jcx = Util.null2String(request.getParameter("jcx"));
	String lcmc = Util.null2String(request.getParameter("lcmc"));
	String bfhxms = Util.null2String(request.getParameter("bfhxms"));
	String lcbxr = Util.null2String(request.getParameter("lcbxr"));
	
	String gzzt_0 = Util.null2String(request.getParameter("gzzt_0"));
	String gzzt_1 = Util.null2String(request.getParameter("gzzt_1"));
	String gzzt_2 = Util.null2String(request.getParameter("gzzt_2"));
	String gzzt_3 = Util.null2String(request.getParameter("gzzt_3"));
	String gzzt_4 = Util.null2String(request.getParameter("gzzt_4"));
	
	int number = new Random().nextInt(1000) + 1; 
	String num = number + "=" + number;

	String url_1 = "/appdevjsp/HQ/APlan/ANoMatchList.jsp";
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String showsql ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String out_pageId = "out_nomatch2";
	
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
		modeId="763";
		formId="-136";
		fieldid="11158";
    }
	else{
		modeId="281";
		formId="-125";
		fieldid="11238";
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
					<input type="button" value="新建不符合项" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 150px;" onclick="onBtnNewClick();"/>
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				
				<wea:item>状态</wea:item>
				<wea:item>
					<input type="checkbox"  value="true" <%=(gzzt_0.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'0')" notBeauty="true">打开&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_1.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'1')" notBeauty="true">改进中&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_2.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'2')" notBeauty="true">已解决&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_3.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'3')" notBeauty="true">已关闭&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox"  value="true" <%=(gzzt_4.equals("true")?"checked='checked'":"") %> onclick="gzzt_check(this,'4')" notBeauty="true">拒绝&nbsp;&nbsp;&nbsp;&nbsp;
					
					<input type="hidden" name="gzzt_0" id="gzzt_0" value="<%= gzzt_0%>"/>
					<input type="hidden" name="gzzt_1" id="gzzt_1" value="<%= gzzt_1%>"/>
					<input type="hidden" name="gzzt_2" id="gzzt_2" value="<%= gzzt_2%>"/>
					<input type="hidden" name="gzzt_3" id="gzzt_3" value="<%= gzzt_3%>"/>
					<input type="hidden" name="gzzt_4" id="gzzt_4" value="<%= gzzt_4%>"/>
				</wea:item>
				
				<wea:item>检查项</wea:item>
				<wea:item>
				<select class="e8_btn_top middle" name="jcx" id="jcx"> 
				<option value="" <%if("".equals(jcx)){%> selected<%} %>>
					<%=""%></option>
				<option value="0" <%if("0".equals(jcx)){%> selected<%} %>>
					<%="SOP"%></option>
				<option value="1" <%if("1".equals(jcx)){%> selected<%} %>>
					<%="流程"%></option>
				</select>
				</wea:item>	
				
				<wea:item>所属组别</wea:item>
				<wea:item>
				 <input name="zb" id="zb" class="InputStyle" type="text" value="<%=zb %>"/>
				</wea:item>
				
				<wea:item>流程名称</wea:item>
				<wea:item>
				 <input name="lcmc" id="lcmc" class="InputStyle" type="text" value="<%=lcmc %>"/>
				</wea:item>
				<wea:item>不符合项描述</wea:item>
				<wea:item>
				 <input name="bfhxms" id="bfhxms" class="InputStyle" type="text" value="<%=bfhxms %>"/>
				</wea:item>
				<wea:item>流程编写人</wea:item>
				<wea:item>
				 <input name="lcbxr" id="lcbxr" class="InputStyle" type="text" value="<%=lcbxr %>"/>
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
		String backfields = "a.ID,case when ZT='0' then '打开' when ZT='1' then '改进中' when ZT='2' then '已解决' when ZT='3' then '已关闭' when ZT='4' then '拒绝' end as ZT,"
				+"case when d.departmentname is null then '其他' when instr(d.departmentname,'-',1)>1 then substr(d.departmentname, 0,instr(d.departmentname,'-',1)-1) else d.departmentname end as ZB,"
				+"case when JCX='0' then 'SOP' when JCX='1' then '流程' end as JCX,"
				+"LCBH,LCMC,BFHXMS,b.lastname as LCBXR,JHWCRQ,SJWCRQ,BZ";
		String fromSql  = " uf_notmatch a ,HrmResource b,HrmDepartmentVirtual d ";
		
		String sqlWhere=" where "+num+" and a.lcbxr=b.id and a.zb=d.id(+) ";

		String orderby = " a.ID desc";
		String tableString = "";

		if("false".equals(gzzt_0)){
		  sqlWhere +=" and zt <> '0'";
		}
		if("false".equals(gzzt_1)){
		  sqlWhere +=" and zt <> '1'";
		}
		if("false".equals(gzzt_2)){
		  sqlWhere +=" and zt <> '2'";
		}
		if("false".equals(gzzt_3)){
		  sqlWhere +=" and zt <> '3'";
		}
		if("false".equals(gzzt_4)){
		  sqlWhere +=" and zt <> '4'";
		}
		
		if(!"".equals(jcx)){
		  sqlWhere +=" and jcx = '"+jcx+"'";
		}
		if(!"".equals(zb)){
		  sqlWhere +=" and d.departmentname like '%"+zb+"%'";
		}
		if(!"".equals(lcmc)){
		  sqlWhere +=" and lcmc like '%"+lcmc+"%'";
		}
		if(!"".equals(bfhxms)){
		  sqlWhere +=" and bfhxms like '%"+bfhxms+"%'";
		}
		if(!"".equals(lcbxr)){
		  sqlWhere +=" and b.lastname like '%"+lcbxr+"%'";
		}

		showsql = "select "+backfields+" from "+fromSql+sqlWhere+" order by "+orderby;
		String  operateString= "";  
		operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:view();\" linkkey=\"ztid\" linkvaluecolumn=\"ID\" text=\"查看\"  target=\"_fullwindow\" index=\"0\"/> "+
		                    "</operates>";             
		tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(out_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+out_pageId+"\" >"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.ID\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=  "<col width=\"8%\" text=\"序号\" column=\"ID\" orderkey=\"ID\"/>"+
			"               <col width=\"8%\" text=\"状态\" column=\"ZT\" orderkey=\"ZT\"/>"+
			"               <col width=\"8%\" text=\"组别\" column=\"ZB\" orderkey=\"ZB\"/>"+
			"               <col width=\"10%\" text=\"检查项\" column=\"JCX\" orderkey=\"JCX\"/>"+
			"               <col width=\"10%\" text=\"流程编号\" column=\"LCBH\" orderkey=\"LCBH\"/>"+
			"               <col width=\"10%\" text=\"流程名称\" column=\"LCMC\" orderkey=\"LCMC\"/>"+
			"               <col width=\"10%\" text=\"流程编写人\" column=\"LCBXR\" orderkey=\"LCBXR\"/>"+
			"               <col width=\"12%\" text=\"计划完成日期\" column=\"JHWCRQ\" orderkey=\"JHWCRQ\" />"+
			"               <col width=\"12%\" text=\"实际完成日期\" column=\"SJWCRQ\" orderkey=\"SJWCRQ\"/>"+
			"               <col width=\"12%\" text=\"不符合项描述\" column=\"BFHXMS\" orderkey=\"BFHXMS\"/>"+
			"               <col width=\"12%\" text=\"备注\" column=\"BZ\" orderkey=\"BZ\"/>"+
		"			</head>"+
	" </table>";
	%>

	<div>
		<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	</div>
	
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
        }
		function refersh() {
  			window.location.reload();
  		}
  		function onBtnNewClick() {
  		 var title = "";
		var url = "";
		title = "新建不符合项";
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