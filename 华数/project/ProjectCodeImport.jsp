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
String titlename = "��Ŀ�����ʹ�÷����ֹ�����" ;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<% 	
RCMenu += "{�ύ,javascript:onSyn(this),_self} " ;
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
      <td><nobr><b>��Ŀ�����ʹ�÷���Excel������</b></td>
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
      <td colspan=2><nobr><b>����ģ�弰ע������</b></td>
    </tr>
   <TR><TD class=Line1 colSpan=2></TD></TR> 
   <tr> 
      <td>�����Ҽ���'���Ϊ'����</td>
      <td><a href='/project/inputexcellfile/import.xls'>�����ļ�Excelģ��</a>&nbsp;</td>
    </tr> 
    <TR><TD class=Line1 colSpan=2></TD></TR> 
    <tr> 
      <td>ע������</td>
      <td>
       1������ʱ���������ݱ������뵼���ļ�Excelģ��ĵ�һ��sheet�С�<br><br>
       2��ģ���еĵ�һ��Ϊ�����У�����ռ�á����ݱ���ӵڶ��п�ʼ���м䲻���п���<br><br>
       3���������ݵ�Excel��ÿһ�����ݸ�ĸ�ʽ����Ϊ�ַ���<br><br>
       4���������ݵ�Excel�е�һ��ĳһ����Ŀ������Ϊ�գ��򲻼������µ���<br><br>
       5�������ݵ����Σ�������һ�ε��������Ϊ׼������������ʷ���ݡ�<br><br> 
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
    showreceiviedPopup("����ͬ�����벻Ҫ�뿪��ҳ�棬���Եȡ�����");
    document.all("returnMSg").innerHTML="";
    obj.disabled=true;
    dosubmit();
    /*
    var ajax=ajaxinit();
    ajax.open("POST", "ImportScheduleOperation.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("excelfile="+document.frmMain.excelfile.value);
    //��ȡִ��״̬
    ajax.onreadystatechange = function() {
        //���ִ��״̬�ɹ�����ô�Ͱѷ�����Ϣд��ָ���Ĳ���
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
    alert("�Բ���,�����ݵ���,����ִ��ͬ������!");
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
