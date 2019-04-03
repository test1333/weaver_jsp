<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="CapitalComInfo" class="weaver.cpt.capital.CapitalComInfo" scope="page"/>

<%
//获得当前的日期和时间
Calendar today = Calendar.getInstance();
String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                     Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                     Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
char flag=Util.getSeparator() ;
String ProcPara = "";
String meetingname = "";
String typeid = Util.null2String(request.getParameter("typeid")); 
String projid = Util.null2String(request.getParameter("projid")); 
String typename="";
if(typeid.equals("1")){
	typename="立项申请表";
}else if(typeid.equals("2")){
	typename="讲解PPT";
}else if(typeid.equals("3")){
	typename="立项报告";
}else if(typeid.equals("4")){
	typename="预算卡";
}else if(typeid.equals("5")){ 
	typename="重大项目申请";
}else if(typeid.equals("6")){
	typename="其他相关文件";
}

String mainId = "";
String subId = "";
String secId = "";
String maxsize = "";

RecordSet.executeSql(" select * from wasu_projpath where typeid=1");
if(RecordSet.next()){
 String category = Util.null2String(RecordSet.getString("prjpath")); 
 if(!category.equals("")){ 
     String[] categoryArr = Util.TokenizerString2(category,",");
     mainId = categoryArr[0];
     subId = categoryArr[1];
     secId = categoryArr[2]; 
  }
  if(!secId.equals(""))
	{
		RecordSet.executeSql("select maxUploadFileSize from DocSecCategory where id="+secId);
		RecordSet.next();
	    maxsize = Util.null2String(RecordSet.getString(1));
	}
}

 
%>
<base target="_self" />  
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</HEAD>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":"+typename;
String needfav ="1";
String needhelp ="";
int topicrows=0;
String needcheck="name,caller,contacter,begindate,begintime,enddate,endtime,totalmember";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{保存,javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;   
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
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
<FORM id=weaver name=weaver action="/project/DocUploadOperation.jsp" method=post enctype="multipart/form-data">
<input class=inputstyle type="hidden" name="method" value="add">
<input class=inputstyle type="hidden" name="typeid" value="<%=typeid%>">
<input class=inputstyle type="hidden" name="projid" value="<%=projid%>">
<input class=inputstyle type="hidden" name="topicrows" value="0">
<TABLE class=viewform>
  <COLGROUP>
  <COL width="49%">
  <COL width=10>
  <COL width="49%">
  <TBODY>
  <TR>
	<TD vAlign=top>
	新建：<%=typename %>
	 </TD>
	<TD></TD>
	<TD vAlign=top>
	</TD>
        </TR>
        </TBODY>
	  </TABLE>
 
	  <TABLE id=AccessoryTable class="ViewForm" style="margin-top:10px;">
	  	<COLGROUP>
		<COL width="15%">
  		<COL width="85%">
	  	<TR class=title>
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></TH><!-- 相关附件 -->
          </TR>
          <TR class=spacing>
          	<TD class=line1 colspan=2></TD></TR>
          <TR>
          <TR>
            <td></td>
            <td class=field id="divAccessory" name="divAccessory">
			 <%if(!"".equals(secId)){ %>
			    <input class=InputStyle type=file name="accessory1" onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=maxsize%>M)
	        	&nbsp;&nbsp;&nbsp;
		        <button class=AddDoc name="addacc" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
		        <input type=hidden id="accessory_num" name="accessory_num" value="1">
		        <input type=hidden id="mainId" name="mainId" value="<%=mainId%>">
		        <input type=hidden id="subId" name="subId" value="<%=subId%>">
		        <input type=hidden id="secId" name="secId" value="<%=secId%>">
		        <input type=hidden id="maxsize" name="maxsize" value="<%=maxsize%>">
		      <%}else{%>   
		        <font color=red>(<%=SystemEnv.getHtmlLabelName(20476,user.getLanguage())%>)</font>
		      <%}%>
    		</td>
          </TR>
          <TR><TD class=Line colspan=2></TD></TR>
        <TR>
	  </TABLE>
	  <TABLE class=viewForm>
        <COLGROUP>
		<COL width="15%">
  		<COL width="85%">
        <TBODY>
        <TR class=title>
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></TH>
          </TR>
        <TR class=spacing>
          <TD class=line1 colspan=2></TD></TR>
        <TR>
        <TR class=spacing>
          <TD height=10px colspan=2></TD></TR>
        <TR>
		  <td>
		  <textarea class=inputstyle rows=4 style="width:70%" name="desc"></textarea>
		  </TD>
        </TR>
        </TBODY>
	  </TABLE>
</FORM>

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
<%@ include file="/activex/target/ocxVersion.jsp" %>
<object ID="File" <%=strWeaverOcxInfo%> STYLE="height=0px;width=0px"></object>
<script language="JavaScript" src="/js/addRowBg.js" >   
</script>
<script language="JavaScript">  
function checkLength(){
    var items = 11;
    var tmpvalue;
    for(var i=0;i<items;i++){
        tmpvalue = document.getElementById("serviceother_"+i).value;
        if(realLength(tmpvalue)>255){
		alert("<%=SystemEnv.getHtmlLabelName(20246,user.getLanguage())%>255(<%=SystemEnv.getHtmlLabelName(20247,user.getLanguage())%>)");
		while(true){
			tmpvalue = tmpvalue.substring(0,tmpvalue.length-1);
			if(realLength(tmpvalue)<=255){
				document.getElementById("serviceother_"+i).value = tmpvalue;
				return;
			}
		}
		break;
	   }
    }
}
</script>
<script language=javascript>
accessorynum = 2 ;
function addannexRow(){
	var nrewardTable = document.getElementById("AccessoryTable");
	var maxsize = document.getElementById("maxsize").value;
	oRow = nrewardTable.insertRow();
	oRow.height=20;
	for(j=0; j<2; j++) {
		oCell = oRow.insertCell();
		switch(j) {
    		case 0:
				var sHtml = "";
				oCell.innerHTML = sHtml;
				break;
	        case 1:
	       		oCell.colSpan = 4;
	       		oCell.className = "field";
	            var sHtml = "<input class=InputStyle  type=file name='accessory"+accessorynum+"' onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:"+maxsize+"M)";
				oCell.innerHTML = sHtml;
				break;
		}
	}
	document.getElementById("accessory_num").value = accessorynum ;
	accessorynum = accessorynum*1 +1;
	oRow1 = nrewardTable.insertRow();
	for(j=0; j<2; j++) {
		oCell1 = oRow1.insertCell();
		switch(j) {
    		case 0:
				break;
        	case 1:
        		oCell1.colSpan = 2
        		oCell1.className = "Line";
				break;
		}
	}
}
function accesoryChanage(obj){
	var secId = '<%=secId%>';
	if(secId=="")
	{
		alert("<%=SystemEnv.getHtmlLabelName(24429,user.getLanguage())%>!");
		obj.value = "";
		createAndRemoveObj(obj);
		return;
	}
    var objValue = obj.value;
    if (objValue=="") return ;
    var fileLenth;
    try {
        File.FilePath=objValue;
        fileLenth= File.getFileSize();
    } catch (e){
    	if(e.message=="Type mismatch")
        alert("<%=SystemEnv.getHtmlLabelName(21015,user.getLanguage())%> ");
        else
        alert("<%=SystemEnv.getHtmlLabelName(21090,user.getLanguage())%> ");
        createAndRemoveObj(obj);
        return  ;
    }
    if (fileLenth==-1) {
        createAndRemoveObj(obj);
        return ;
    }
    //var fileLenthByM = (fileLenth/(1024*1024)).toFixed(1)
    var fileLenthByK =  fileLenth/1024;
		var fileLenthByM =  fileLenthByK/1024;
	
		var fileLenthName;
		if(fileLenthByM>=0.1){
			fileLenthName=fileLenthByM.toFixed(1)+"M";
		}else if(fileLenthByK>=0.1){
			fileLenthName=fileLenthByK.toFixed(1)+"K";
		}else{
			fileLenthName=fileLenth+"B";
		}
		maxsize = document.getElementById("maxsize").value;
    if (fileLenthByM>maxsize) {
        alert("<%=SystemEnv.getHtmlLabelName(20254,user.getLanguage())%>"+fileLenthByM+",<%=SystemEnv.getHtmlLabelName(20255,user.getLanguage())%>"+maxsize+"M<%=SystemEnv.getHtmlLabelName(20256,user.getLanguage())%>!");
        createAndRemoveObj(obj);
    }
} 
function createAndRemoveObj(obj){
    objName = obj.name;
    var  newObj = document.createElement("input");
    newObj.name=objName;
    newObj.className="InputStyle";
    newObj.type="file";
    newObj.onchange=function(){accesoryChanage(this);};

    var objParentNode = obj.parentNode;
    var objNextNode = obj.nextSibling;
    obj.removeNode();
    objParentNode.insertBefore(newObj,objNextNode);
}
 
var rowColor="" ;

function doSave(obj){
	document.weaver.submit();
}
 
function checkAddress()
{
	if("" == document.all("address").value && "" == document.all("customizeAddress").value)
	{
		alert("<%=SystemEnv.getHtmlLabelName(20393, user.getLanguage())%>");
		return false;
	}
	
	return true;
}

/*Check Date */
function compareDate(date1,time1,date2,time2){

	var ss1 = date1.split("-",3);
	var ss2 = date2.split("-",3);

	date1 = ss1[1]+"-"+ss1[2]+"-"+ss1[0] + " " +time1;
	date2 = ss2[1]+"-"+ss2[2]+"-"+ss2[0] + " " +time2;

	var t1,t2;
	t1 = Date.parse(date1);
	t2 = Date.parse(date2);
	if(t1==t2) return 0;
	if(t1>t2) return 1;
	if(t1<t2) return -1;

    return 0;
}
 

function ItemCount_KeyPress_Plus()
{
	if(!(window.event.keyCode >= 48 && window.event.keyCode <= 57))
	{
		window.event.keyCode = 0;
	}
}
</script>
<script language=vbs>

sub  onShowHrmCaller(spanname,inputename,needinput)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?sqlwhere=")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	document.all(spanname).innerHtml= "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>" 
	document.all(inputename).value=id(0)
	else 
	if needinput = "1" then
	document.all(spanname).innerHtml= "<IMG src='/images/BacoError.gif' align=absMiddle>"
	else
	document.all(spanname).innerHtml= ""
	end if
	document.all(inputename).value=""
	end if
	end if
end sub

sub onShowCaller()
   id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/meeting/data/CallerBrowser.jsp?sqlwhere=") 	
	 if (Not IsEmpty(id)) then
	 if id(0)<> "" then
         document.all("Callerspan").innerHtml= "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
         document.all("caller").value=id(0)
   else
   	document.all("Callerspan").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
   	document.all("caller").value = ""
   end if
	 end if
end sub   

sub onShowHrm(spanname,inputename,needinput)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	document.all(spanname).innerHtml= "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	document.all(inputename).value=id(0)
	else 
	if needinput = "1" then
	document.all(spanname).innerHtml= "<IMG src='/images/BacoError.gif' align=absMiddle>"
	else
	document.all(spanname).innerHtml= ""
	end if
	document.all(inputename).value=""
	end if
	end if
end sub

sub onShowProjectID(objval)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	projectidspan.innerHtml = "<A href='/proj/data/ViewProject.jsp?ProjID="&id(0)&"'>"&id(1)&"</A>"
	weaver.projectid.value=id(0)
	else 
	if objval="2" then
				projectidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
			else
				projectidspan.innerHtml =""
			end if
	weaver.projectid.value="0"
	end if
	end if
end sub

sub onShowMProj(spanname,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	document.all(spanname).innerHtml = "<A href='/proj/data/ViewProject.jsp?ProjID="&id(0)&"'>"&id(1)&"</A>"
	document.all(inputname).value=id(0)
	else 
	document.all(spanname).innerHtml =""
	document.all(inputname).value="0"
	end if
	end if
end sub

sub onShowMHrm(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
		    if (Not IsEmpty(id1)) then
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
					document.all(spanname).innerHtml = sHtml
					
				else
					document.all(spanname).innerHtml =""
					document.all(inputename).value=""
				end if
			end if
end sub

sub onShowMeetingHrm(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&tmpids)
		    if (Not IsEmpty(id1)) then
		     if (Len(id1(0)) > 2000) then '500为表结构文档字段的长度
			    result = msgbox("<%=SystemEnv.getHtmlLabelName(24476,user.getLanguage())%>",48,"<%=SystemEnv.getHtmlLabelName(18739,user.getLanguage())%>")
				 elseif id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href=/hrm/resource/HrmResource.jsp?id="&resourceids&">"&resourcename&"</a>&nbsp"
					document.all(spanname).innerHtml = sHtml
					
				else
					document.all(spanname).innerHtml ="<IMG src='/images/BacoError.gif' align=absMiddle>"
					document.all(inputename).value=""
				end if
			end if
end sub


sub onShowMCrm(spanname,inputename)
		tmpids = document.all(inputename).value
		id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids="&tmpids)
			if (Not IsEmpty(id1)) then	
				if id1(0)<> "" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all(inputename).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href=/CRM/data/ViewCustomer.jsp?CustomerID="&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href=/CRM/data/ViewCustomer.jsp?CustomerID="&resourceids&">"&resourcename&"</a>&nbsp"
					document.all(spanname).innerHtml = sHtml

				else
					document.all(spanname).innerHtml =""
					document.all(inputename).value=""
				end if
			end if
end sub

sub onShowAddress()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/meeting/Maint/MeetingRoomBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	addressspan.innerHtml ="<A href='/meeting/Maint/MeetingRoom.jsp'>"&id(1)&"</A>"
	weaver.address.value=id(0)
	customizeAddressspan.innerHtml = ""
	else
	addressspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.address.value=""
	customizeAddressspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	end if
	end if
end sub

</script>
</body>
</html>
<script language="javascript">
   function CheckOnShowAddress(){
	 if((document.weaver.customizeAddress.value!="")&&(document.getElementById("addressspan").innerHTML=="")){
     alert("<%=SystemEnv.getHtmlLabelName(20888, user.getLanguage())%>");   
	 }
	 onShowAddress();		 
   } 
  function omd(){
	  var addressspan = document.getElementById("addressspan").innerHTML;
      if(document.getElementById("addressspan").innerHTML!="" && addressspan.indexOf("BacoError")<=0 && document.weaver.customizeAddress.value==""){
          alert("<%=SystemEnv.getHtmlLabelName(20889, user.getLanguage())%>");
	}
}
function checkaddress(obj){
	var addressspan = document.getElementById("addressspan").innerHTML;
    if(document.getElementById("addressspan").innerHTML!="" && addressspan.indexOf("BacoError")<=0 && document.weaver.customizeAddress.value==""){
        document.getElementById("customizeAddress").viewtype = 0;
	}else{
		if((document.getElementById("addressspan").innerHTML!="" && addressspan.indexOf("BacoError")>0) || document.getElementById("addressspan").innerHTML==""){
			document.getElementById("customizeAddress").viewtype = 1;
		}
	}
	if(obj.value!=""){
		if(addressspan.indexOf("BacoError") > 0){
			document.getElementById("addressspan").innerHTML = "";
		}
	}else{
		if(addressspan=="" || addressspan.indexOf("BacoError")>0){
			document.getElementById("addressspan").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		}
	}
}
function showRemindTime(obj)
{
	if("1" == obj.value)
	{
		document.all("remindTime").style.display = "none";
		document.all("remindTimeLine").style.display = "none";
	}
	else
	{
		document.all("remindTime").style.display = "";
		document.all("remindTimeLine").style.display = "";
	}
}
  
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" src="/js/selectDateTime.js"></script>