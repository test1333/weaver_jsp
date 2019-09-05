<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />

<%
int comid = Util.getIntValue(request.getParameter("comid"),0);//公司id
int opertype = Util.getIntValue(request.getParameter("opertype"),1);//1是公司资源管理区后台维护权限|2是公司资源管理区证照维护权限..
int comallright=Util.getIntValue(request.getParameter("comallright"),0);//是否为全局的公司资料模块权限,1是全局的，0不是全局的
String ids=Util.null2String (request.getParameter("ids"));
String from=Util.null2String (request.getParameter("from"));

//    System.out.println("opertype:"+opertype);
//    System.out.println("ids:"+ids);
//    System.out.println("from:"+from);
%>
<HTML><HEAD>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"type="text/css" />
<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet" type="text/css" />
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>

<BODY>


<div style="height: 250px;overflow-y: auto;overflow-x: none">
<FORM id=mainform name=mainform  action="/cpcompanyinfo/ComAccessRightManage.jsp" target="iff" method=post >
  <input type="hidden" name="method" value="add">
  <input type="hidden" name="from" value="<%=from %>">
  <input type="hidden" name="ids" value="<%=ids %>">
  <input type="hidden" name="comid" value="<%=comid%>">
  <input type="hidden" name="opertype" value="<%=opertype%>">
  <input type="hidden" name="comallright" value="<%=comallright%>">
  <input type="hidden" name="mutil"  id="mutil"  value="0">
  <TABLE style="width:100%" border="0" cellpadding="0" cellspacing="1" class="stripe OTable" style="font-size:12px">
    <TBODY>
      <TR><TD >
      	 <%= SystemEnv.getHtmlLabelName(16815,user.getLanguage())%>：
        <SELECT class=InputStyle name=permtype onchange="onChangepermtype()">
          <option selected value="1"><%=SystemEnv.getHtmlLabelName(7175,user.getLanguage())%></option>
          <option value="6"><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%>＋<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
          <option value="2"><%=SystemEnv.getHtmlLabelName(7176,user.getLanguage())%></option>
          <option value="3"><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></option>
          <option value="5"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></option>
        </SELECT>
         </TD>
      </TR>
      <TR><TD class=field>
        <BUTTON class=Browser   type="button"   style="display:none" onClick="onShowSubcompany('showrelatedsharename','subcompanyid')" name=showsubcompany id=showsubcompany></BUTTON>
        <INPUT type=hidden name=subcompanyid  id=subcompanyid value="">
        <BUTTON class=Browser   type="button"   style="display:''" onClick="onShowDepartment('showrelatedsharename','departmentid')" name=showdepartment id=showdepartment></BUTTON>
        <INPUT type=hidden name=departmentid   id=departmentid   value="">
        <BUTTON class=Browser style="display:none"  type="button"   onclick="onShowRole('showrelatedsharename','roleid')" name=showrole id=showrole></BUTTON>
        <INPUT type=hidden name=roleid value=""  id=roleid>
        <BUTTON class=Browser style="display:none"   type="button"   onclick="onShowResource('showrelatedsharename','userid')" name=showuser id=showuser></BUTTON>
        <INPUT type=hidden name="userid"  id="userid" value="">
        <span id=showrelatedsharename name=showrelatedsharename></span>
        <span id=showusertype name=showusertype style="display:none">
          <%=SystemEnv.getHtmlLabelName(7179,user.getLanguage())%>:
          <SELECT  class=InputStyle name=usertype onchange="onChangeUserType()">
          <option selected value="0"><%=SystemEnv.getHtmlLabelName(131,user.getLanguage())%></option>
          <%while(CustomerTypeComInfo.next()){
        	  String curid=CustomerTypeComInfo.getCustomerTypeid();
        	  String curname=CustomerTypeComInfo.getCustomerTypename();
        	  String optionvalue=curid;
          %>
          <option value="<%=optionvalue%>"><%=Util.toScreen(curname,user.getLanguage())%></option>
          <%}%>
          </SELECT>
        </span>
      </TD>
      
      </tr>
		<TR>
		   <TD class=field>
		        <span id=showseclevel name=showseclevel style="display:''">
		        <%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>:
		        <INPUT type=text id=seclevel name=seclevel size=6 value="10" onblur="checkinput('seclevel','seclevelimage')" onKeyUp="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" onkeydown="if(event.keyCode == 13){doSave();return false;}"  maxlength="3">
		        <SPAN id=seclevelimage></SPAN>
		        </span>
		        <span id=showrolelevel name=showrolelevel style="display:none">
		          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		          <%=SystemEnv.getHtmlLabelName(139,user.getLanguage())%>:
		          <SELECT class=InputStyle name=rolelevel>
		            <option selected value="0"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%>
		            <option value="1"><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%>
		            <option value="2"><%=SystemEnv.getHtmlLabelName(140,user.getLanguage())%>
		          </SELECT>
		        </span>
         </TD>
		</TR>
		
		<%
			if(false && comallright==0)
			{
		 %>
		<TR>
		   <TD class=field>
		       	  <%= SystemEnv.getHtmlLabelName(30948,user.getLanguage())%>:   
		      
         	</TD>
		</TR>
		<TR>
		   <TD class=field>
		       
		       
		       	 <BUTTON class=Browser  onClick="onShowComSub()"  type="button"   ></BUTTON>
       			 <INPUT type=hidden name=rid   id=rid   value="">
          		
          		 <span id=rvalue name=rvalue></span>
          		 
         	</TD>
		</TR>
		
		<%
			}
		 %>
		<tr>
		   <td>
		      <ul class="OContRightMsg2 FR">
				<li><a onclick="doSave(this)" class="hover"><div><div> <%= SystemEnv.getHtmlLabelName(611,user.getLanguage())%></div></div></a></li>
				<li><a onclick="doCancel(this)" class="hover"><div><div> <%= SystemEnv.getHtmlLabelName(201,user.getLanguage())%></div></div></a></li>
			</ul>
		   </td>
		</tr>
    </TBODY>
  </TABLE>
<iframe name="iff" id="iff" style="display: none"></iframe>
</FORM>
</div>
<script language=javascript>

function onShowComSub()
{	
	
	var selevalue=document.getElementById("rid").value;
	var returnvalue=window.showModalDialog("/cpcompanyinfo/ComMutiSubcompanyBrowser.jsp?selevalue="+selevalue);
	//alert(returnvalue[0]);
	//alert(returnvalue[1]);
	if(returnvalue){
		if(typeof(returnvalue)!="undefined"&&returnvalue[1]!=""&&returnvalue[0]!="0")
		{
			document.getElementById("rvalue").innerHTML=returnvalue[0];
			document.getElementById("rid").value=returnvalue[1];
			
		}else if(returnvalue[0]!="0")
		{
			document.getElementById("rvalue").innerHTML="";
			document.getElementById("rid").value="";
		}
	}
	//window.showModalDialog("/strateOperat/ajaxManage.jsp?method=fileTransfer");
}

onChangepermtype();

function check_by_permtype() {
   
    if(document.mainform.seclevel.value !="" && document.mainform.seclevel.value>100){
	      alert("<%= SystemEnv.getHtmlLabelName(30949,user.getLanguage())%>");
	      return false;
    }
    if($.trim($("#seclevel").val())==""){
    	alert("<%= SystemEnv.getHtmlLabelName(15859,user.getLanguage())%>");
    	return false;
    }
    if (document.mainform.permtype.value == 1) {
        return check_form(mainform, "departmentid, seclevel")
    } else if (document.mainform.permtype.value == 2) {
        return check_form(mainform, "roleid, rolelevel, seclevel");
    } else if (document.mainform.permtype.value == 3) {
        return check_form(mainform, "seclevel");
    } else if (document.mainform.permtype.value == 4) {
        return check_form(mainform, "usertype, seclevel");
    } else if (document.mainform.permtype.value == 5) {
        return check_form(mainform, "userid");
    } else if (document.mainform.permtype.value == 6) {
        return check_form(mainform, "subcompanyid,seclevel")
    } else {
        return false;
    }
}

function doSave() {
    if (check_by_permtype()) {
	    document.mainform.submit();
	}
   
}

function doCancel(){
	//parentDialog.close();
	window.close();
}

function onChangepermtype() {
	thisvalue=document.mainform.permtype.value;
	document.mainform.departmentid.value="";
	document.mainform.roleid.value="";
	document.mainform.userid.value="";

	if (thisvalue == 1) {
	    document.all("showrelatedsharename").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
 		document.all("showsubcompany").style.display = 'none';
 		document.all("showdepartment").style.display = '';
 		document.all("showrole").style.display = 'none';
 		document.all("showusertype").style.display = 'none';
 		document.all("showrolelevel").style.display = 'none';
 		document.all("showuser").style.display = 'none';
 		document.all("showseclevel").style.display = '';
    }
	else if (thisvalue == 2) {
	    document.all("showrelatedsharename").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
 		document.all("showsubcompany").style.display = 'none';
 		document.all("showdepartment").style.display = 'none';
 		document.all("showrole").style.display = '';
 		document.all("showusertype").style.display = 'none';
 		document.all("showrolelevel").style.display = '';
 		document.all("showuser").style.display = 'none';
 		document.all("showseclevel").style.display = '';
	}
	else if (thisvalue == 3) {
	    document.all("showrelatedsharename").innerHTML = ""
 		document.all("showsubcompany").style.display = 'none';
 		document.all("showdepartment").style.display = 'none';
 		document.all("showrole").style.display = 'none';
 		document.all("showusertype").style.display = 'none';
 		document.all("showrolelevel").style.display = 'none';
 		document.all("showuser").style.display = 'none';
 		document.all("showseclevel").style.display = '';
	}
	else if (thisvalue == 4) {
	    document.all("showrelatedsharename").innerHTML = "";
 		document.all("showsubcompany").style.display = 'none';
 		document.all("showdepartment").style.display = 'none';
 		document.all("showrole").style.display = 'none';
 		document.all("showusertype").style.display = '';
 		document.all("showrolelevel").style.display = 'none';
 		document.all("showuser").style.display = 'none';
 		document.all("showseclevel").style.display = '';
	}
	else if (thisvalue == 5) {
	    document.all("showrelatedsharename").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
 		document.all("showsubcompany").style.display = 'none';
 		document.all("showdepartment").style.display = 'none';
 		document.all("showrole").style.display = 'none';
 		document.all("showusertype").style.display = 'none';
 		document.all("showrolelevel").style.display = 'none';
 		document.all("showuser").style.display = '';
 		document.all("showseclevel").style.display = 'none';
	}
	else if (thisvalue == 6) {
	    document.all("showrelatedsharename").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>"
 		document.all("showsubcompany").style.display = '';
 		document.all("showdepartment").style.display = 'none';
 		document.all("showrole").style.display = 'none';
 		document.all("showusertype").style.display = 'none';
 		document.all("showrolelevel").style.display = 'none';
 		document.all("showuser").style.display = 'none';
 		document.all("showseclevel").style.display = '';
	}
}

function onChangeUserType() {
    thisvalue = document.all("usertype").value;
    if (thisvalue == "0") {
        document.all("seclevel").value = "10";
    } else {
        document.all("seclevel").value = "0";
    }
}


 function onShowDepartment(spanid,inputid){
	    var currentids=jQuery("#"+inputid).val();
	    var id1=window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="+currentids);
	 if(id1){
	       var ids=id1.id;
	       var names=id1.name;
	       if(ids.length>0){
	          var tempids=ids.split(",");
	          var tempnames=names.split(",");
	          var sHtml="";
	          for(var i=0;i<tempids.length;i++){
	              var tempid=tempids[i];
	              var tempname=tempnames[i];
	              if(tempid!='')
	                sHtml = sHtml+"<a href='javascript:void(0)' onclick=openFullWindowForXtable('/hrm/company/HrmDepartmentDsp.jsp?id="+tempid+"')>"+tempname+"</a>&nbsp;";
	          }
	          ids=ids+",";
	          jQuery("#"+inputid).val(ids);
	          jQuery("#"+spanid).html(sHtml);
	           jQuery("#mutil").val ("1");
	       }else{
	          jQuery("#"+inputid).val("");
	           jQuery("#"+spanid).html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	       }
       } 
	}
	 function onShowSubcompany(spanid,inputid){
	   var currentids=jQuery("#"+inputid).val();
	   var id1=window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="+currentids);
	   if(id1){
	       var ids=id1.id;
	       var names=id1.name;
	       if(ids.length>0){
	          var tempids=ids.split(",");
	          var tempnames=names.split(",");
	          var sHtml="";
	          for(var i=0;i<tempids.length;i++){
	              var tempid=tempids[i];
	              var tempname=tempnames[i];
	              if(tempid!='')
	                sHtml = sHtml+"<a href='javascript:void(0)' onclick=openFullWindowForXtable('/hrm/company/HrmSubCompanyDsp.jsp?id="+tempid+"')>"+tempname+"</a>&nbsp;";
	          }
	          ids=ids+",";
	          jQuery("#"+inputid).val(ids);
	          jQuery("#"+spanid).html(sHtml);
	          jQuery("#mutil").val ("1");
	       }else{
	          jQuery("#"+inputid).val("");
	           jQuery("#"+spanid).html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	       }
       }
	}
	function onShowRole(spanid,inputid){
	   var id1=window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/roles/HrmRolesBrowser.jsp");
	   if(id1){
	       var ids=id1.id;
	       var names=id1.name;
	       if(ids.length>0){
	          jQuery("#"+inputid).val(ids);
	          jQuery("#"+spanid).html(names);
	       }else{
	          jQuery("#"+inputid).val("");
	          jQuery("#"+spanid).html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	       }
       }
	}
	function onShowResource(spanid,inputid){
	   var currentids=jQuery("#"+inputid).val();
	   var id1=window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+currentids);
	   if(id1){
	       var ids=id1.id;
	       var names=id1.name;
	       if(ids.length>0){
	          var tempids=ids.split(",");
	          var tempnames=names.split(",");
	          var sHtml="";
	          for(var i=0;i<tempids.length;i++){
	              var tempid=tempids[i];
	              var tempname=tempnames[i];
	              if(tempid!='')
	                sHtml = sHtml+"<a href='javascript:void(0)' onclick=openFullWindowForXtable('/hrm/resource/HrmResource.jsp?id="+tempid+"')>"+tempname+"</a>&nbsp;";
	          }
	          ids=ids+",";
	          jQuery("#"+inputid).val(ids);
	          jQuery("#"+spanid).html(sHtml);
	       }else{
	          jQuery("#"+inputid).val("");
	          jQuery("#"+spanid).html("<img align=\"absMiddle\" src=\"/images/BacoError.gif\"/>");
	       }
       }
	}
	
</script>
</BODY>
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
</HTML>
