<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET> 
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
if(!HrmUserVarify.checkUserRight("ProjectStone:Look", user)){
		response.sendRedirect("/notice/noright.jsp");
		return;
} 
String imagefilename = "/images/hdSystem.gif";
String titlename = "项目编号已使用费用手工导入" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 	
RCMenu += "{提交,javascript:onSyn(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="ImportProjectCodeOperation.jsp"  enctype="multipart/form-data">
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
<DIV>
<BUTTON class=btnSave accessKey=S onClick="onSyn(this)"><U>S</U>-<%=SystemEnv.getHtmlLabelName(615,user.getLanguage())%></BUTTON>
</DIV>
			 <table class=Viewform>
    <COLGROUP> <COL width="15%"> <COL width="85%"> <tbody> 
    <tr class=Title> 
      <td><nobr><b>项目编号已使用费用Excel导入表格</b></td>
      <td align=right></td>
    </tr>
    <tr class=spacing> 
      <td class=Line1 colspan=2></td>
    </tr>
    <tr class=spacing> 
      <td colspan=2 height=8></td>
    </tr>
     
    <TR><TD class=Line colSpan=2></TD></TR>
    <tr class=spacing> 
      <td><%=SystemEnv.getHtmlLabelName(16699,user.getLanguage())%></td>
      <td class=Field>
        <input class=inputstyle type="file" name="excelfile">
      </td>
    </tr>
    <TR><TD class=Line colSpan=2></TD></TR>
    </tbody> 
  </table>  
<br>
<div id="returnMSg" name="returnMSg">
<BR>
<BR>
<BR>
<table  >
<TBODY>
<TR><TD>
 <br>
  <table class=viewform>
    <COLGROUP> <COL width="30%"> <COL width="70%"><tbody> 
    <tr > 
      <td colspan=2><nobr><b>导入模板及注意事项</b></td>
    </tr>
   <TR><TD class=Line1 colSpan=2></TD></TR> 
   <tr> 
      <td>请点击右键用'另存为'下载</td>
      <td><a href='/project/inputexcellfile/import.xls'>导入文件Excel模板</a>&nbsp;</td>
    </tr> 
    <TR><TD class=Line1 colSpan=2></TD></TR> 
    <tr> 
      <td>注意事项</td>
      <td>
       1、导入时，基础数据必须填入导入文件Excel模板的第一个sheet中。<br><br>
       2、模板中的第一行为标题行，不能占用。数据必须从第二行开始，中间不能有空行<br><br>
       3、导入数据的Excel中每一个数据格的格式必须为字符型<br><br>
       4、导入数据的Excel中第一列某一行项目编号如果为空，则不继续往下导入<br><br>
       5、若数据导入多次，以最新一次导入的数据为准，并不保留历史数据。<br><br> 
      </td>
    </tr> 
    <TR><TD class=Line1 colSpan=2></TD></TR> 
    </tbody> 
  </table>
</TD>
</TR>
</TBODY>
</table>
</div>

		</td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
<div id='divshowreceivied' style="background:#FFFFFF;padding:3px;width:100%;display:none" valign='top'>
</div>
  </FORM>
</BODY>

<script language="javascript">
function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
var showTableDiv  = document.getElementById('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.all("returnMSg").offsetTop+30;
     var pLeft= document.body.offsetWidth/2-150;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
}
function onSyn(obj)
{
    showreceiviedPopup("正在同步，请不要离开该页面，请稍等。。。");
    document.all("returnMSg").innerHTML="";
    obj.disabled=true;
    dosubmit();
    /*
    var ajax=ajaxinit();
    ajax.open("POST", "ImportScheduleOperation.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("excelfile="+document.frmMain.excelfile.value);
    //获取执行状态
    ajax.onreadystatechange = function() {
        //如果执行状态成功，那么就把返回信息写到指定的层里
        if (ajax.readyState == 4 && ajax.status == 200) {
            try{
                document.all("returnMSg").innerHTML = ajax.responseText;
            }catch(e){}
            showTableDiv.style.display='none';
            oIframe.style.display='none';
            obj.disabled=false;
        }
    }
    */
}

function doExcel(){
  if(document.getElementById('NcExcelOut') == null || document.getElementById('NcExcelOut') == ""){
    alert("对不起,无数据导出,请先执行同步操作!");
  }else{
	location.href = "/weaver/weaver.file.ExcelOut";
    return;
  }
}
 
function dosubmit() {
    if(check_form(document.frmMain,'excelfile')) {
        document.frmMain.submit() ;
    }
}
 
</script>
</HTML>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
