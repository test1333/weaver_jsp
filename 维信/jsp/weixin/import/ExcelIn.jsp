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
String titlename = "Input" ;
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
<wea:group context="Input Excel" attributes="test">

<wea:item>Time</wea:item>
<wea:item> <%=dateNowStr%></wea:item>
<wea:item>Input Type</wea:item>
<wea:item><select id="importType" name="importType" style="width: 100px">
      			<option value="update">Create</option>
      		</select></wea:item>
<wea:item>Excel File</wea:item>
<wea:item> 
<input name="excelfile" id="excelfile" style="display: none;" onchange="$('#filepath').html(this.value);" type="file" size="35">
<input id="filebutton" style="width: 100px; height: 22px;" onclick="excelfile.click()" type="button" value="Select File ">
<span id="filepath">No files are selected. </span>
</wea:item>
<wea:item></wea:item>
<wea:item> <button type=submit class=btnSave onclick="loadIn(this); style="width:200px"" 
                        title="start import">
                        <!-- 开始导入-->
                        &nbsp;start import
                      </button></wea:item>
		


</wea:group>
</wea:layout>	
      	  
  </FORM>
<Script language=javascript>
	  
  jQuery(document).ready(fucntion(){
    var file1=jQuery("input[name='excelfile']")[0].val();
    
  })
	function viewBasicInfo(){
		parent.getDialog(window).close();
	}
	  
	function Chk(){
		if(document.frmMain.excelfile.value==""){
			alert("The file must not be empty！");
			return false;
		}
	}

  function loadIn(){
      $('#frmMain').submit();  
    }
</script>


</BODY>
</HTML>