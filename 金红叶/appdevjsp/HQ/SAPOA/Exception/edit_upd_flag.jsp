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
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 100%;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		</style>
		<%
		 
		
		 String lc_no=Util.null2String(request.getParameter("lc_no"));
		
		
		
		 boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
		 String sql="select MANDT,LC_TYPE,REF_NO,INDEX_NO,upd_flag from zoat00020 where lc_no='"+lc_no+"'";
         String upd_flag="";
		 String LC_TYPE="";
		 String REF_NO="";
		 String INDEX_NO="";
		 String MANDT="";
		 rs.execute(sql);
		 if(rs.next()){
		   upd_flag = Util.null2String(rs.getString("upd_flag"));
		   LC_TYPE=  Util.null2String(rs.getString("LC_TYPE"));
		   REF_NO=  Util.null2String(rs.getString("REF_NO"));
		   INDEX_NO=  Util.null2String(rs.getString("INDEX_NO"));
		   MANDT=  Util.null2String(rs.getString("MANDT"));
		 }
		
		  
		  
		%>
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
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table  cellpadding="0" cellspacing="0">
				<tr>
					
				</tr>
			</table>
			
			<% // 查询条件 %>
			
		</FORM>
		<%
		 
		String backfields = "";
														
		String fromSql  = " ";
		String sqlWhere = "";
		String orderby = " ";
		String tableString = "";
	
		%>
		
	<table class="ViewForm1  outertable" >
    <tbody>
        <tr>			
            <td><br />
			
			<div align="right"> 
				<input type="button" value="保存" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnSaveClick();"
				<span >&nbsp;&nbsp;&nbsp;&nbsp;</span>				 
			</div>
            <div align="center"><font class="reqname"></font></div>
            <title></title>
			<FORM id=report1 name=report1 action="/appdevjsp/HQ/SAPOA/Exception/refresh.jsp" method=post>
            <input  id="lc_no" type="text" value="<%=lc_no%>" name="lc_no" hidden="ture"/>
            <table class="ViewForm1  maintable">
				<input type="text" value="1" id="flag" name="flag" hidden="true">
                <colgroup>  <col width="100px"></col><col width="175px"></col> <col width="275px"></col><col width="100px"></col> </colgroup>
                <tbody>
				<tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;客户端</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=MANDT%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				<tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;流程类型</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=LC_TYPE%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;单据编号</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=REF_NO%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;SAP流水号</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=INDEX_NO%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
                    <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;UPD_FLAG</td>
                        <td class="fvalue">&nbsp;&nbsp;
						<select class="e8_btn_top middle" name="upd_flag" id="upd_flag"> 
							<option value="N" <%if("N".equals(upd_flag)||"".equals(upd_flag)){%> selected<%} %>>
								<%="不需要"%></option>
							<option value="Y" <%if("Y".equals(upd_flag)){%> selected<%} %>>
								<%="需要"%></option>
							</select></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
</FORM>
	<script type="text/javascript">
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