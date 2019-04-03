<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
   
    char flag = Util.getSeparator() ;
    
    String dateNowStr = Util.null2String(request.getParameter("dateNowStr"));
    if("".equals(dateNowStr)){
		java.util.Calendar now = java.util.Calendar.getInstance();
		int now_year = now.get(Calendar.YEAR);
		int now_month = now.get(Calendar.MONDAY)+1;
		int now_day = now.get(Calendar.DAY_OF_MONTH);
		
		dateNowStr = now_year + "-" + (now_month<10?"0"+now_month:""+now_month);
	}
    
	// dateNowStr = "2014-08";
	int who_oper = user.getUID();
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
String imagefilename = "/images/hdReport_wev8.gif";
String titlename = "导入" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%

RCMenu += "{返回,javascript:viewBasicInfo(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>


<FORM id=frmMain name=frmMain action="fest_exec.jsp" method=post enctype="multipart/form-data" target="_self" onsubmit="return Chk();">
  <wea:layout type="2col">
<wea:group context="导入流程" attributes="test">

<wea:item>操作月份</wea:item>
<wea:item> <%=dateNowStr%></wea:item>
<wea:item>导入类型</wea:item>
<wea:item><select id="importType" name="importType" style="width: 100px">
      			<option value="update">创建流程</option>
      		</select></wea:item>
<wea:item>Excel文件</wea:item>
<wea:item> <input class=inputstyle style="width: 360px" type="file" name="excelfile" onchange='checkinput("excelfile","excelfilespan");this.value=trim(this.value)'><SPAN id=excelfilespan></wea:item>
<wea:item></wea:item>
<wea:item> <button type=submit class=btnSave onclick="loadIn(this);" 
                          title="<%=SystemEnv.getHtmlLabelName(25649,user.getLanguage())%>">
                        <!-- 开始导入-->
                        <%=SystemEnv.getHtmlLabelName(25649,user.getLanguage())%>
                      </button></td></tr> </wea:item>
		


</wea:group>
</wea:layout>	
      	  
  </FORM>
<Script language=javascript>
	  
	function viewBasicInfo(){
		parent.getDialog(window).close();
	}
	  
	function Chk(){
		if(document.frmMain.excelfile.value==""){
			alert("文件不能为空！");
			return false;
		}
	}

  function loadIn(){
      $('#frmMain').submit();  
    }
</script>


</BODY>
</HTML>