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
String meetingtype = Util.null2String(request.getParameter("meetingtype"));
RecordSet.execute("select * from Meeting_Type where id = "+meetingtype);
if(RecordSet.next()){
    meetingname = Util.null2String(RecordSet.getString("name"));
}
String mainId = "";
String subId = "";
String secId = "";
String maxsize = "8";
 
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language=javascript src="/js/weaver.js"></script>
</HEAD>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":"+SystemEnv.getHtmlLabelName(2103,user.getLanguage());
String needfav ="1";
String needhelp ="";
int topicrows=0;
String needcheck="name,caller,contacter,begindate,begintime,enddate,endtime,totalmember";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(220,user.getLanguage())+",javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:doSubmit(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",javascript:submitData(),_self} " ;
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
<FORM id=weaver name=weaver action="/meeting/data/MeetingOperation.jsp" method=post enctype="multipart/form-data">
<input class=inputstyle type="hidden" name="method" value="add">
<input class=inputstyle type="hidden" name="meetingtype" value="<%=meetingtype%>">
<input class=inputstyle type="hidden" name="topicrows" value="0">
<TABLE class=viewform>
  <COLGROUP>
  <COL width="49%">
  <COL width=10>
  <COL width="49%">
  <TBODY>
  <TR>
	<TD vAlign=top>
	 </TD>
	<TD></TD>
	<TD vAlign=top>
	</TD>
        </TR>
        </TBODY>
	  </TABLE>

	  <TABLE class=viewForm>
        <TBODY>
        <TR class=title>
            <TH><%=SystemEnv.getHtmlLabelName(2169,user.getLanguage())%></TH>
            <Td align=right>
				<A href="javascript:addRow();"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></A>
				<A href="javascript:if(isdel()){deleteRow1();}"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></A>	
			</Td>
          </TR>
        <TR class=spacing>
          <TD class=line1 colspan=2></TD></TR>
        <tr><td colspan=2>
          <table class=liststyle cellspacing=1>
            <COLGROUP>
    		<COL width="44%">
    		<COL width="20%">
    		<COL width="15%">
    		<COL width="15%">
    		<COL width="6%">
    		<tr class=header>
    		   <td><%=SystemEnv.getHtmlLabelName(344,user.getLanguage())%></td>
    		   <td><%=SystemEnv.getHtmlLabelName(2097,user.getLanguage())%></td>
			   <%if(isgoveproj==0){%>
    		   <td><%if(software.equals("ALL") || software.equals("CRM")){%><%=SystemEnv.getHtmlLabelName(782,user.getLanguage())%><%}%>&nbsp</td>
    		   <td><%if(software.equals("ALL") || software.equals("CRM")){%><%=SystemEnv.getHtmlLabelName(783,user.getLanguage())%><%}%>&nbsp</td>
    		   <%}else{%>
			   <td>&nbsp</td>
    		   <td>&nbsp</td>
			   <%}%>
			   <td><%=SystemEnv.getHtmlLabelName(2161,user.getLanguage())%></td>
    		</tr>
          </table>
        </td></tr>
        
        <TR>
          <TD colspan=2>   
	  <TABLE class=viewForm cellpadding=1  cols=6 id="oTable">
      	<COLGROUP>
      	<COL width="4%">
		<COL width="40%">
		<COL width="20%">
		<COL width="15%">
		<COL width="15%">
		<COL width="6%">
        <TBODY>
        </TBODY>
	  </TABLE>		  
		  
		  </TD>
        </TR>
        </TBODY>
	  </TABLE>
<%
int servicerows=0;
RecordSet.executeProc("Meeting_Service_SelectAll",meetingtype);
if(RecordSet.getCounts()>0){
%>
	  <TABLE class=viewForm>
        <COLGROUP>
		<COL width="15%">
  		<COL width="85%">
        <TBODY>
        <TR class=title>
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(2107,user.getLanguage())%></TH>
          </TR>
        <TR class=spacing>
          <TD class=Sep1 colspan=2></TD></TR>
<%
while(RecordSet.next()){
%>
        <TR>
		  <td><%=RecordSet.getString("name")%></td>
          <TD> 
		  <input class=inputstyle type=hidden name=servicename_<%=servicerows%> value="<%=RecordSet.getString("name")%>">
		  <input class=inputstyle type=hidden name=servicehrm_<%=servicerows%> value="<%=RecordSet.getString("hrmid")%>">
	  <TABLE class=viewForm>
        <TBODY>
        <TR>
          <TD class=Field>
<%
	ArrayList serviceitems = Util.TokenizerString(RecordSet.getString("desc_n"),",");
	for(int i=0;i<serviceitems.size();i++){
		//String id = RecordSet.getString("id");	
		String serviceitem = URLEncoder.encode((String)serviceitems.get(i),"GBK");
%>
		  <input class=inputstyle type=checkbox name=serviceitem_<%=servicerows%> value="<%=serviceitem%>" ><%=serviceitems.get(i)%>&nbsp&nbsp
<%
	}
%>
		  </TD>
        </TR>
        <TR>
          <TD class=Field><%=SystemEnv.getHtmlLabelName(375,user.getLanguage())%>：<input class=inputstyle name=serviceother_<%=servicerows%> maxlength="255" onchange="checkLength()"  style="width:90%"></TD>
        </TR>
        </TBODY>
	  </TABLE>		  
		  
		  </TD>
        </TR>
<%
	servicerows+=1;
}
%>
        </TBODY>
	  </TABLE>
<%}%>
	  <input class=inputstyle type="hidden" name="servicerows" value="<%=servicerows%>">
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
		  <td>
		  <textarea class=inputstyle rows=5 style="width:100%" name="desc"></textarea>
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
    var items = <%=servicerows%>;
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
function submitData() {
 window.history.back();
}
var rowColor="" ;
rowindex = "<%=topicrows%>";
function addRow()
{
	ncol = oTable.cols;
	rowColor = getRowBg();
	oRow = oTable.insertRow();
	
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		oCell.style.wordBreak = "break-all";
		switch(j) {
			case 0:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox' name='check_node' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type='input' maxlength='200' style=width:99%  name='topicsubject_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<button class=Browser onClick=onShowMHrm('topichrmids_"+rowindex+"span','topichrmids_"+rowindex+"')></button> " + 
        					"<span class=inputStyle id=topichrmids_"+rowindex+"span></span> "+
        					"<input class=inputstyle type='hidden' name='topichrmids_"+rowindex+"' id='topichrmids_"+rowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
            case 3: 
				var oDiv = document.createElement("div"); 
				<%if(isgoveproj==0){%>
				var sHtml = "<button class=Browser onClick=onShowMProj('topicprojid_"+rowindex+"span','topicprojid_"+rowindex+"')></button> " + 
        		<%}else{%>
				var sHtml = " " + 
				<%}%>
				"<span class=inputStyle id=topicprojid_"+rowindex+"span></span> "+
        					"<input class=inputstyle type='hidden' name='topicprojid_"+rowindex+"' id='topicprojid_"+rowindex+"'>";
<%if(software.equals("ALL") || software.equals("CRM")){%>
				oDiv.innerHTML = sHtml;   
<%}%>
				oCell.appendChild(oDiv);  
				break;
		    case 4: 
				var oDiv = document.createElement("div"); 
				<%if(isgoveproj==0){%>
				var sHtml = "<button class=Browser onClick=onShowMCrm('topiccrmid_"+rowindex+"span','topiccrmid_"+rowindex+"')></button> " + 
        		<%}else{%>
					var sHtml = " " + 
					<%}%>
				"<span class=inputStyle id=topiccrmid_"+rowindex+"span></span> "+
        					"<input class=inputstyle type='hidden' name='topiccrmid_"+rowindex+"' id='topiccrmid_"+rowindex+"'>";
<%if(software.equals("ALL") || software.equals("CRM")){%>
				oDiv.innerHTML = sHtml;   
<%}%>
				oCell.appendChild(oDiv);  
				break;
			case 5: 
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox' name='topicopen_"+rowindex+"' value='1'>公开"; //文字
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
	
		}
	}
	rowindex = rowindex*1 +1;
	
}

function deleteRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_node'){
			if(document.forms[0].elements[i].checked==true) {
				oTable.deleteRow(rowsum1-1);	
			}
			rowsum1 -=1;
		}
	
	}	
}	

function checkuse(){
    <%
    String tempbegindate="";
    String tempenddate="";
    String tempbegintime="";
    String tempendtime="";
    String tempAddress="0";
    RecordSet.executeSql("select Address,begindate,enddate,begintime,endtime from meeting where meetingstatus=2 and isdecision<2 and (cancel is null or cancel<>'1') and begindate>='"+currentdate+"'");
    while(RecordSet.next()){
        tempAddress=RecordSet.getString("Address");
        tempbegindate=RecordSet.getString("begindate");
        tempenddate=RecordSet.getString("enddate");
        tempbegintime=RecordSet.getString("begintime");
        tempendtime=RecordSet.getString("endtime");
   %>
   if(document.weaver.address.value=="<%=tempAddress%>"){
       if(!(document.weaver.begindate.value+" "+document.weaver.begintime.value>"<%=tempenddate+' '+tempendtime%>" || document.weaver.enddate.value+" "+document.weaver.endtime.value<"<%=tempbegindate+' '+tempbegintime%>")){
           return true;
       }
   }
   <%
    }
    %>
    return false;
}

function doSave(obj){
	if(check_form(document.weaver,'<%=needcheck%>')&&checkAddress()&&checkDateValidity(weaver.begindate.value,weaver.begintime.value,weaver.enddate.value,weaver.endtime.value,"<%=SystemEnv.getHtmlLabelName(16722,user.getLanguage())%>")){
		if((document.all("hrmids02").value!="" && document.all("hrmids02").value.length>0) || (document.all("crmids02").value!="" && document.all("crmids02").value.length>0) || checkHrm() || checkCrm()){
		var hashrmids=false;
        var lens = document.forms[0].elements.length;
        for(var i=0; i < lens;i++) {
            if ((document.forms[0].elements[i].name=='hrmids01' || document.forms[0].elements[i].name=='crmids01') && document.forms[0].elements[i].checked==true){
                hashrmids=true;
                break;
            }
        }
		if(document.weaver.hrmids02.value!="" || document.weaver.crmids02.value!="" || hashrmids){
	        enableAllmenu();
			document.weaver.topicrows.value=rowindex;
			setRemindData();
			document.weaver.submit();
		}else{
            alert("<%=SystemEnv.getHtmlLabelName(20118,user.getLanguage())%>");
        }
		}else{
			alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage())%>");
		}
	}
}

function doSubmit(obj){
    if(check_form(document.weaver,'<%=needcheck%>')&&checkAddress()&&checkDateValidity(weaver.begindate.value,weaver.begintime.value,weaver.enddate.value,weaver.endtime.value,"<%=SystemEnv.getHtmlLabelName(16722,user.getLanguage())%>")){
		if((document.all("hrmids02").value!="" && document.all("hrmids02").value.length>0) || (document.all("crmids02").value!="" && document.all("crmids02").value.length>0) || checkHrm() || checkCrm()){
	         var hashrmids=false;
	        var lens = document.weaver.elements.length;
	        for(var i=0; i < lens;i++) {
	            if ((document.weaver.elements[i].name=='hrmids01' || document.weaver.elements[i].name=='crmids01') && document.weaver.elements[i].checked==true){
	                hashrmids=true;
	                break;
	            }
	        }
	        if(checkuse()){
	            if(confirm("<%=SystemEnv.getHtmlLabelName(19095,user.getLanguage())%>")){
	                if(document.weaver.hrmids02.value!="" || document.weaver.crmids02.value!="" || hashrmids){
	                enableAllmenu();
	                document.weaver.topicrows.value=rowindex;
	                document.weaver.method.value = "addSubmit";
	                setRemindData();
	                document.weaver.submit();
	                }else{
	                    alert("<%=SystemEnv.getHtmlLabelName(20118,user.getLanguage())%>");
	                }
	            }
	        }else{
	            if(document.weaver.hrmids02.value!="" || document.weaver.crmids02.value!="" || hashrmids || document.weaver.hrmids01.value!=""){
	                enableAllmenu();
	                document.weaver.topicrows.value=rowindex;
	                document.weaver.method.value = "addSubmit";
	                setRemindData();
	                document.weaver.submit();
	                }else{
	                    alert("<%=SystemEnv.getHtmlLabelName(20118,user.getLanguage())%>");
	                }
	        }
			}else{
				alert("<%=SystemEnv.getHtmlLabelName(15859,user.getLanguage())%>");
		  }
	}
}
function checkHrm(){
	var hashrmchecked = new Array();
	var hashrmid = false;
	hashrmchecked = document.getElementsByName("hrmids01");
	for(var i = 0; i < hashrmchecked.length; i++)
	{
		if(hashrmchecked[i].checked)
		{
			hashrmid = true;
		}
	}
	return hashrmid;
}
function checkCrm(){
	var hascrmchecked = new Array();
	var hascrmid = false;
	hascrmchecked = document.getElementsByName("crmids01");
	for(var i = 0; i < hascrmchecked.length; i++)
	{
		if(hascrmchecked[i].checked)
		{
			hascrmid = true;
		}
	}
	return hascrmid;
}

function checkDateValidity(begindate,begintime,enddate,endtime,errormsg){
	var isValid = true;
	if(compareDate(begindate,begintime,enddate,endtime) == 1){
		alert(errormsg);
		isValid = false;
	}
	return isValid;
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
function setRemindData()
{
	var remindBeforeStart = document.getElementById("remindBeforeStart");
	var remindDateBeforeStart = document.getElementById("remindDateBeforeStart");
	var remindTimeBeforeStart = document.getElementById("remindTimeBeforeStart");
	
	var remindBeforeEnd = document.getElementById("remindBeforeEnd");
	var remindDateBeforeEnd = document.getElementById("remindDateBeforeEnd");
	var remindTimeBeforeEnd = document.getElementById("remindTimeBeforeEnd");
	if(remindBeforeStart&&remindBeforeStart.checked)
	{
		remindBeforeStart.value = 1;
	}
	else if(remindBeforeStart&&!remindBeforeStart.checked)
	{
		remindBeforeStart.value = 0;
		if(remindDateBeforeStart)
		{
			remindDateBeforeStart.value=0;
		}
		if(remindTimeBeforeStart)
		{
			remindTimeBeforeStart.value=10;
		}
	}
	if(remindBeforeEnd&&remindBeforeEnd.checked)
	{
		remindBeforeEnd.value = 1;
	}
	else if(remindBeforeEnd&&!remindBeforeEnd.checked)
	{
		remindBeforeEnd.value = 0;
		if(remindDateBeforeEnd)
		{
			remindDateBeforeEnd.value=0;
		}
		if(remindTimeBeforeEnd)
		{
			remindTimeBeforeEnd.value=10;
		}
	}	
}
function countAttend()
{
	var count = 0;
	var pageArray = new Array();
	var countArray = new Array();
	var finalArray = new Array();
	var hascheckhrm = false;
	var hascheckcrm = false;
	
	if("" != document.all("hrmids02").value)
	{
		pageArray = document.all("hrmids02").value.split(",");
		countArray = countArray.concat(pageArray);
	}
	pageArray = document.getElementsByName("hrmids01");
	for(var i = 0; i < pageArray.length; i++)
	{
		if(pageArray[i].checked)
		{
			hascheckhrm = true;
			countArray.push(pageArray[i].value);
		}
	}
	for(var i = 0; i < countArray.length; i++)
	{
		var flag = true;
		var countString = countArray[i];
		for(var j = 0; j < finalArray.length; j++)
		{
			var finalString = finalArray[j];
			if(countString == finalString)
			{
				flag = false;
				break;
			}

		}
		if(flag)
		{
			finalArray.push(countString);
		}
	}
	count += finalArray.length;
	
	pageArray = new Array();
	countArray = new Array();
	finalArray = new Array();
	if("" != document.all("crmids02").value)
	{
		pageArray = document.all("crmids02").value.split(",");
		countArray = countArray.concat(pageArray);
	}
	pageArray = document.getElementsByName("crmids01");
	for(var i = 0; i < pageArray.length; i++)
	{
		if(pageArray[i].checked)
		{
			hascheckcrm = true;
			countArray.push(pageArray[i].value);
		}
	}
	//if(hascheckhrm == true){
		//if(document.all("crmids02").value==null || document.all("crmids02").value==""){
			//document.all("crmids02span").innerHTML = "";
		//}
	//}else{
		//if(document.all("crmids02").value==null || document.all("crmids02").value==""){
			//document.all("crmids02span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
		//}
	//}
	if(hascheckhrm==true || hascheckcrm==true || (document.all("hrmids02").value!="" && document.all("hrmids02").value.length>0) || (document.all("crmids02").value!="" && document.all("crmids02").value.length>0)){
		if(document.all("hrmids02").value==null || document.all("hrmids02").value==""){
			document.all("hrmids02span").innerHTML = "";
		}
	}else{
		document.all("hrmids02span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	}
	
	for(var i = 0; i < countArray.length; i++)
	{
		var flag = true;
		var countString = countArray[i];
		for(var j = 0; j < finalArray.length; j++)
		{
			var finalString = finalArray[j];
			if(countString == finalString)
			{
				flag = false;
				break;
			}

		}
		if(flag)
		{
			finalArray.push(countString);
		}
	}
	count += finalArray.length;
	if(count<1)
		document.all("totalmemberspan").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
	else
		document.all("totalmemberspan").innerHTML = "";
	document.all("totalmember").value = count;
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
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?sqlwhere=<%=whereclause%>")
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
   id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/meeting/data/CallerBrowser.jsp?sqlwhere=<%=whereclause%>") 	
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