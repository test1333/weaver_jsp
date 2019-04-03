<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,weaver.conn.*" %>
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
 
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<SCRIPT language="javascript" src="/js/jquery/jquery.js"></script> 
<script language=javascript >
function checkSubmit(obj){
	window.onbeforeunload=null;
	if(check_form(weaver,"Name")){ 
		obj.disabled = true; // added by 徐蔚绛 for td:1553 on 2005-03-22
		weaver.submit();
	}
}
 
</script>

</HEAD>
<%
String projid = Util.null2String(request.getParameter("projid"));
String taskname = Util.null2String(request.getParameter("name1"));
 
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":任务文档"; 
String needfav ="1";
String needhelp =""; 
String beginDate=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

rs.executeSql(" select * from wasu_projectbase where id="+projid);
rs.next();
String projname=rs.getString("name");
int xmstatus=rs.getInt("xmstatus");
String xmcstatus="";
if(xmstatus<=0){
		xmcstatus="<font color=red>未立项</font>"; 
	}else if(xmstatus==1){
		xmcstatus="<font color=red>立项</font>";
	}else if(xmstatus==2){
		xmcstatus="<font color=red>在建</font>";
	}else if(xmstatus==3){
		xmcstatus="<font color=red>验收期</font>";
	}else if(xmstatus==4){
		xmcstatus="<font color=red>完成</font>";
	}else if(xmstatus==5){
		xmcstatus="<font color=red>终止</font>";
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
<BODY onbeforeunload="protectCus()">
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %> 
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSave(this),_top} " ;
RCMenuHeight += RCMenuHeightStep ; 
RCMenu += "{返回,javascript:returnBack(),_top} " ;
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

<FORM id=weaver name= weaver action="/project/ProjTaskOperation.jsp" method=post onsubmit='return check_form(this,"Name")' enctype="multipart/form-data">
<input type="hidden" name="method" value="add">
<input type="hidden" name="projid" value="<%=projid%>"> 
<input type="hidden" name="xmstatus" value="<%=xmstatus%>"> 
	
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="20%">
  		<COL width="30%">
  		<COL width="15%">
  		<COL width="35%">
        <TBODY>
        <TR class=Title>
            <TH colSpan=4>任务文档基本信息</TH>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=4></TD></TR>
          
        <TR>
          <TD>任务名称</TD> 
          <TD class=Field>
          <INPUT class=InputStyle maxLength=50 name="taskname" onchange='checkinput("taskname","tasknameimage")' STYLE="width:95%" value='<%=Util.toScreen(taskname,user.getLanguage(),"0")%>'>
          <SPAN id=tasknameimage><%if(taskname=="") {%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN>
          </TD>
       		<TD>所属项目</TD>
          	<TD class=Field><%="<font color=red>"+projname+"</font>" %></TD>
        </TR><tr><td class=Line colspan=4></td></tr> 
        <TR>
          
        </TR><tr><td class=Line colspan=4></td></tr>
         <TR>
          <TD>创建人</TD>
          <TD class=Field>
           <BUTTON class=Browser id=xmjlid onClick="onShowResourceID()"></BUTTON> 
           <span  id=createridspan><%=user.getUsername()%></span> 
              <INPUT class=InputStyle type=hidden name=creater value="<%=user.getUID()%>">
              <TD>创建日期</TD>
          <TD class=Field> 
               <BUTTON class="Calendar" id="selectBeginDate" onclick="onshowPlanDate(sqrq, selectBeginDateSpan)"></BUTTON> 
				<SPAN id="selectBeginDateSpan">
				 <%=beginDate %>
				</SPAN> 
				<INPUT type="hidden" name="sqrq" value="<%=beginDate%>">    
              
        </TD>
        </TR><tr><td class=Line colspan=4></td></tr> 
         <TR>
          <TD>当前项目状态</TD> 
          <TD class=Field>  
              <%=xmcstatus %>
        </TD>
         <TD>文档分类</TD> 
          <TD class=Field>  
                 <select name="wdfl"  id=wdfl >
			       <option	value=-1></option>
			        <%  
			        String wdflformid = Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdfl"));
			        rs.executeSql(" select * from formtable_main_"+wdflformid+"_dt1 order by sx asc "); 
			                    while(rs.next()){ 
			                %> 
                   <option value=<%=rs.getString("id") %>  ><%=rs.getString("flmc") %></option>
               		 <%}  %>  
      			 </select>  <IMG src="/images/BacoError.gif" align=absMiddle>
        </TD>
        </TR><tr><td class=Line colspan=4></td></tr>   
       	<%  
       	  String wdflfjformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdflfj"));
       	  rs.executeSql(" select * from formtable_main_"+wdflfjformid+"_dt1 order by id asc "); 
       	  int fjindex=0;
       	  while(rs.next()){fjindex++;
       	 %> 
       		  <TR style="display:none" id="fj_<%=rs.getString("flmc") %>"> 
          <TD><%=rs.getString("fjfl") %></TD> 
          <TD class=Field colspan=3>
          
           <TABLE id=AccessoryTable_<%=fjindex %> class="ViewForm" style="margin-top:10px;">
	  	<COLGROUP>
		<COL width="5%">
  		<COL width="95%">  
          <TR class=spacing>
          	<TD class=line1 colspan=2></TD></TR>
          <TR>
          <TR>
            <td></td> 
             <td class=field id="divAccessory_<%=fjindex %>" name="divAccessory_<%=fjindex %>">
          <%if(!"".equals(secId)){ %>
			    <input class=InputStyle type=file name="accessory1_<%=fjindex %>" onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=maxsize%>M)
	        	&nbsp;&nbsp;&nbsp;
		        <button class=AddDoc name="addacc" onclick="addannexRow('_<%=fjindex %>')"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
		        <input type=hidden id="accessory_num_<%=fjindex %>" name="accessory_num_<%=fjindex %>" value="1">
		        <input type=hidden id="mainId_<%=fjindex %>" name="mainId_<%=fjindex %>" value="<%=mainId%>">
		        <input type=hidden id="subId_<%=fjindex %>" name="subId_<%=fjindex %>" value="<%=subId%>">
		        <input type=hidden id="secId_<%=fjindex %>" name="secId_<%=fjindex %>" value="<%=secId%>">
		        <input type=hidden id="maxsize_<%=fjindex %>" name="maxsize_<%=fjindex %>" value="<%=maxsize%>">
		      <%}else{%>   
		        <font color=red>(<%=SystemEnv.getHtmlLabelName(20476,user.getLanguage())%>)</font>
		      <%}%>
		      </td>
	          </TR>
	        <TR>
		  </TABLE>
          </TD>
        </TR>
             <tr style="display:none" id="fj_<%=rs.getString("flmc") %>_line"><td class=Line colspan=4></td></tr>   
             <%} %>
             <tr style="display:none" >
             <td class=Line colspan=4> 
             <input type=hidden name=fjcount value=<%=fjindex %> > 
             </td></tr>   
             
        <TR>
          <TD>其他附件</TD> 
          <TD class=Field colspan=3> 
          
           <TABLE id=AccessoryTableqt class="ViewForm" style="margin-top:10px;">
	  	<COLGROUP>
		<COL width="5%">
  		<COL width="95%"> 
          <TR class=spacing>
          	<TD class=line1 colspan=2></TD></TR>
          <TR>
            <td></td> 
             <td class=field id="divAccessoryqt" name="divAccessoryqt"> 
          <%if(!"".equals(secId)){ %>
			    <input class=InputStyle type=file name="accessory1qt" onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=maxsize%>M)
	        	&nbsp;&nbsp;&nbsp;
		        <button class=AddDoc name="addacc" onclick="addannexRow('qt')"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
		        <input type=hidden id="accessory_num" name="accessory_numqt" value="1">
		        <input type=hidden id="mainIdqt" name="mainIdqt" value="<%=mainId%>">
		        <input type=hidden id="subIdqt" name="subIdqt" value="<%=subId%>">
		        <input type=hidden id="secIdqt" name="secIdqt" value="<%=secId%>">
		        <input type=hidden id="maxsizeqt" name="maxsizeqt" value="<%=maxsize%>">
		      <%}else{%>   
		        <font color=red>(<%=SystemEnv.getHtmlLabelName(20476,user.getLanguage())%>)</font>
		      <%}%>
		      
		       </td>
	          </TR>
	        <TR>
		  </TABLE>
		  
          </TD>
        </TR> 
        <tr><td class=Line colspan=4></td></tr>        
        <tr><td class=Line colspan=4></td></tr>     
         
        </TBODY>
	  </TABLE>
	</TD>
    <TD></TD>
	<TD vAlign=top>
	</TD>
  </TR>
  </TBODY>
</TABLE>
</FORM>
<script language=vbs>
sub onShowResourceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	createridspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaver.creater.value=id(0)
	else 
	createridspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.creater.value=""
	end if
	end if
end sub
</script> 

		</td>
		</tr>
		</TABLE>
</BODY>
<%@ include file="/activex/target/ocxVersion.jsp" %>
<object ID="File" <%=strWeaverOcxInfo%> STYLE="height=0px;width=0px"></object>
<script language="JavaScript" src="/js/addRowBg.js" ></script>  

<script language=javascript> 
accessorynum = 2 ;
function addannexRow(tablenamediff){
	var nrewardTable = document.getElementById("AccessoryTable"+tablenamediff);
	var maxsize = document.getElementById("maxsize"+tablenamediff).value;
	//alert(nrewardTable);  
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
	       		//oCell.colSpan = 4;
	       		oCell.className = "field";
	            var sHtml = "<input class=InputStyle  type=file name='accessory"+accessorynum+tablenamediff+"' onchange='accesoryChanage(this)'>(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:"+maxsize+"M)";
				oCell.innerHTML = sHtml;
				break;
		}
	}
	document.getElementById("accessory_num"+tablenamediff).value = accessorynum ;
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
function addannexRow1(){
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
	obj.disabled=true;
	document.weaver.submit();
}
 
 function returnBack(){
	 window.location="/project/Projtasklist.jsp?projid=<%=projid%>";
 }
 
function ItemCount_KeyPress_Plus()
{
	if(!(window.event.keyCode >= 48 && window.event.keyCode <= 57))
	{
		window.event.keyCode = 0;
	}
}
</script>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#wdfl").bind("change",function(){
		var wdflid=jQuery("#wdfl").val();
		jQuery("[id^=fj_]").hide(); 
		jQuery("[id^=fj_"+wdflid+"]").show();  
		jQuery("[id^=fj_"+wdflid+"_line]").show(); 
	});
	
});
</script>

<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/project/WdatePicker.js"></script>
<!-- added by cyril on 2008-06-12 for td8828-->
<script language=javascript src="/js/checkData.js"></script>
<!-- end by cyril on 2008-06-12 for td8828-->
</HTML>
