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
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM id=frmMain name=frmMain action="fest_exec.jsp" method=post enctype="multipart/form-data" target="_self" onsubmit="return Chk();">

      	  
  <TABLE class=ViewForm>
    <COLGROUP> <COL width="15%"> <COL width="85%"><TBODY> 
    <TR class=Title
    </TR>
    <TR class=Spacing style="height: 1px"> 
      <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR style="height: 2px"><TD class=Line colSpan=2></TD></TR> 
      <tr> 
      <td>操作月份 </td> 
      	<td class=Field> <%=dateNowStr%>
      </td>
    </tr>
      <TR style="height: 1px"><TD class=Line colSpan=2></TD></TR> 
	<tr> 
      <td>导入类型</td> 
      	<td class=Field>
      		<select id="importType" name="importType" style="width: 100px">
      			<option value="update">新增</option>
      		</select>
      	  <div><font color="FF0000">说明：选择"更新"操作,在原有的数据上新增</font></div>
      </td>
    </tr>
      <TR style="height: 1px"><TD class=Line colSpan=2></TD></TR> 
           <tr class=spacing> 
      <td>Excel文件</td>
      <td class=Field>
        <input class=inputstyle style="width: 360px" type="file" name="excelfile" onchange='checkinput("excelfile","excelfilespan");this.value=trim(this.value)'><SPAN id=excelfilespan>
              </SPAN>
      </td>
    </tr>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
    <tr><TD></TD>
    <td class=Field>
      <button type=submit class=btnSave onclick="loadIn(this);" 
                          title="<%=SystemEnv.getHtmlLabelName(25649,user.getLanguage())%>">
                        <!-- 开始导入-->
                        <%=SystemEnv.getHtmlLabelName(25649,user.getLanguage())%>
                      </button></td></tr> 
    <TR style="height: 2px"><TD class=Line colSpan=2></TD></TR> 
    </TBODY> 
  </TABLE>
</FORM>
</td>
</tr>
</TABLE>
<div id="zDialog_div_bottom" class="zDialog_div_bottom">
  <wea:layout>
    <wea:group context="" attributes="{groupDisplay:none}">
      <wea:item type="toolbar">
        <input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage()) %>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parent.getDialog(window).close();">
      </wea:item>
    </wea:group>
  </wea:layout>
</div>
</td>	
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
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
      $('#weaver').submit();  
      window.close();
    }
</script>


</BODY>
</HTML>