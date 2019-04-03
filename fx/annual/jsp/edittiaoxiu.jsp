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
		<script language="javascript" src="/js/weaver_wev8.js"></script>
		<%
		 
		
		 String tiaoxiuid =Util.null2String(request.getParameter("tiaoxiuid"));
		 String lastname ="";
		 String overtime ="";
		  String sytime ="";
		   String overTimeUsed ="";
		 boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
		 String sql="select (select lastname from hrmresource where id=xm) lastname,ISNULL(overtime,0) overtime,isnull(overTimeUsed,0) overTimeUsed,convert(decimal(18,1),isnull(overTime,0)-isnull(overTimeUsed,0)) sytime from formtable_main_60 where id="+tiaoxiuid;
		 rs.execute(sql);
		 if(rs.next()){
			lastname = Util.null2String(rs.getString("lastname"));
			overtime = Util.null2String(rs.getString("overtime"));
			sytime = Util.null2String(rs.getString("sytime"));
			overTimeUsed = Util.null2String(rs.getString("overTimeUsed"));
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
				
				
				<input type="button" value="保存" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="onBtnSaveClick();"/>
				
				<span >&nbsp;&nbsp;&nbsp;&nbsp;</span>				 
			</div>
            <div align="center"><font class="reqname">调休信息</font></div>
            <title></title>
			<FORM id=report1 name=report1 action="" method=post>
            <input type="hidden" id="tiaoxiuid" name="tiaoxiuid" value="<%=tiaoxiuid%>">
			<table class="ViewForm1  maintable">			
                <colgroup>  <col width="100px"></col><col width="175px"></col> <col width="275px"></col><col width="100px"></col> </colgroup>
                <tbody>
                    <tr>			
			
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;员工姓名</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=lastname%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;原调休总时数</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=overtime%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;调休已用时数</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=overTimeUsed%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;调休剩余时数</td>
                        <td class="fvalue">&nbsp;&nbsp;<%=sytime%></td>                                               
	                    <td>&nbsp;</td>		
                 </tr>
				
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;新调休总时数</td>				
                        <td class="fvalue">&nbsp;&nbsp;<input maxLength=10 size=30 id="overtimenew"  name="overtimenew" value="<%=overtime%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,1)" onBlur="checknumber1(this)"></td>                                               
	                  
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
		
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			var overtimenew=jQuery("#overtimenew").val();
			var tiaoxiuid=jQuery("#tiaoxiuid").val();
			  jQuery.post("/fx/annual/jsp/updatetiaoxiu.jsp", {
                'tiaoxiuid': tiaoxiuid,
                'overtimenew': overtimenew
            }, function (data) {
              //alert(data);
                data = data.replace(/\n/g, "").replace(/\r/g, "");
			
				 alert(data);	  					  
				window.location.reload();                 
				
               
            });
		}
	   

	</script>
</BODY>
</HTML>