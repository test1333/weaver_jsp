<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"type="text/css" />
<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet" type="text/css" />

<html>
<body>
		<%
			if(!HrmUserVarify.checkUserRight("License:manager", user)){
	    		response.sendRedirect("/notice/noright.jsp");
	    		return;
			}
			int opertype = 1;//操作类型
			boolean canEdit=true;			
  			
		%>
		
		<div style="height: 5px"></div>
		
		
		
		<!-- 查看文件权限开始 -->
		<FORM name="frmmain2"  id="frmmain2"  action="" method="post">
		<%
		opertype = 2;//操作类型
		%>
		<table style="width:100%;font-size: 12px" border="0" cellpadding="0" cellspacing="1" class="stripe OTable">
		  <colgroup> 
		  <col width="5%">
		  <col width="20%"> 
		  <col width="*">
		  <tr id="OTable2" class="cBlack"> 
		    <td colspan=3>
			
			  <ul class="FL">
				   <li style="font-weight: bold;font-size: 12px">  
				     		
				       <%if(canEdit){%>
						<input type="checkbox" name="chkDirAccessRightAll<%=opertype%>" onclick="chkDirAccessRightAllClick(this,'<%=opertype%>')">
					    <%}%>
					       <%=SystemEnv.getHtmlLabelName(30950,user.getLanguage())%>
					  
				   </li>			     
			    </ul>
			                               
			    <ul class="OContRightMsg2 FR" style="height: 20px">
					<li><a onclick="resDirAccessRightAdd('<%=opertype %>')" class="hover" style="font-size: 12px;color: #fff;cursor: pointer;"><div><div><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></div></div></a></li>
					<li><a onclick="onPermissionDel('<%=opertype%>','frmmain2','1');" class="hover" style="font-size: 12px;color: #fff;cursor: pointer;" href="javascript:void(0)"><div><div><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></div></div></a></li>
				    <li>&nbsp;</li>
				</ul>  
			
		    </td>
		  </tr>
		
		<%
		  RecordSet.executeSql("select * from  cpcominforight where comrright=2 and comallright=1");
		  while(RecordSet.next()){
		    if(RecordSet.getInt("permType")==1)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(DepartmentComInfo.getDepartmentname(RecordSet.getString("depid")),user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		
		<%}else if(RecordSet.getInt("permType")==2)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(RolesComInfo.getRolesRemark(RecordSet.getString("roleid")),user.getLanguage())%>
				/
				<% if(RecordSet.getInt("rolelevel")==0)%><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%>
				<% if(RecordSet.getInt("rolelevel")==1)%><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%>
				<% if(RecordSet.getInt("rolelevel")==2)%><%=SystemEnv.getHtmlLabelName(140,user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%}else if(RecordSet.getInt("permType")==3)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%}else if(RecordSet.getInt("permType")==4)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(7179,user.getLanguage())%></TD>
			  <TD class=Field>
			    <%=(RecordSet.getInt("usertype")==0)?SystemEnv.getHtmlLabelName(131,user.getLanguage()).trim():CustomerTypeComInfo.getCustomerTypename(RecordSet.getString("usertype"))%>
			    /
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%} else if(RecordSet.getInt("permType")==5)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></TD>
			  <TD class=Field>
			    <%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("userid")),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%} else if(RecordSet.getInt("permType")==6)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(SubCompanyComInfo.getSubCompanyname(RecordSet.getString("subcomid")),user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		
		<%}
		}%>
		</table>
		</FORM>		
		 
		 
		  <br>
		
		<!-- 查看文件权限开始 -->
		<FORM name="frmmain3"   id="frmmain3"   action="" method="post">
		<%
		opertype = 3;//操作类型
		%>
		<table style="width:100%;font-size: 12px" border="0" cellpadding="0" cellspacing="1" class="stripe OTable">
		  <colgroup> 
		  <col width="5%">
		  <col width="20%"> 
		  <col width="*">
		  <tr id="OTable2" class="cBlack"> 
		    <td colspan=3>
			
			  <ul class="FL">
				   <li style="font-weight: bold;font-size: 12px">  
				     		
				       <%if(canEdit){%>
						<input type="checkbox" name="chkDirAccessRightAll<%=opertype%>" onclick="chkDirAccessRightAllClick(this,'<%=opertype%>')">
					    <%}%>
					       <%=SystemEnv.getHtmlLabelName(30955,user.getLanguage())%>
					  
				   </li>			     
			    </ul>
			                               
			    <ul class="OContRightMsg2 FR" style="height: 20px">
					<li><a onclick="resDirAccessRightAdd('<%=opertype %>')" class="hover" style="font-size: 12px;color: #fff;cursor: pointer;"><div><div><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></div></div></a></li>
					<li><a onclick="onPermissionDel('<%=opertype%>','frmmain3','1');" class="hover" style="font-size: 12px;color: #fff;cursor: pointer;" href="javascript:void(0)"><div><div><%=SystemEnv.getHtmlLabelName(23777,user.getLanguage())%></div></div></a></li>
				    <li>&nbsp;</li>
				</ul>  
			
		    </td>
		  </tr>
		
		<%
		  RecordSet.executeSql("select * from  cpcominforight where comrright=3 and comallright=1");
		  while(RecordSet.next()){
		    if(RecordSet.getInt("permType")==1)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(DepartmentComInfo.getDepartmentname(RecordSet.getString("depid")),user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		
		<%}else if(RecordSet.getInt("permType")==2)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(RolesComInfo.getRolesRemark(RecordSet.getString("roleid")),user.getLanguage())%>
				/
				<% if(RecordSet.getInt("rolelevel")==0)%><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%>
				<% if(RecordSet.getInt("rolelevel")==1)%><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%>
				<% if(RecordSet.getInt("rolelevel")==2)%><%=SystemEnv.getHtmlLabelName(140,user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%}else if(RecordSet.getInt("permType")==3)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%}else if(RecordSet.getInt("permType")==4)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(7179,user.getLanguage())%></TD>
			  <TD class=Field>
			    <%=(RecordSet.getInt("usertype")==0)?SystemEnv.getHtmlLabelName(131,user.getLanguage()).trim():CustomerTypeComInfo.getCustomerTypename(RecordSet.getString("usertype"))%>
			    /
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%} else if(RecordSet.getInt("permType")==5)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></TD>
			  <TD class=Field>
			    <%=Util.toScreen(ResourceComInfo.getResourcename(RecordSet.getString("userid")),user.getLanguage())%>
			  </TD>
		    </TR>
		            
		<%} else if(RecordSet.getInt("permType")==6)	{%>
		    <TR>
		      <TD><INPUT TYPE='CHECKBOX'  CLASS='INPUTSTYLE' VALUE="<%=RecordSet.getInt("id")%>" NAME='chkDirAccessRightId<%=opertype%>' <%if(!canEdit) out.print("disabled");%>></TD>
		      <TD class=Field><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></TD>
			  <TD class=Field>
				<%=Util.toScreen(SubCompanyComInfo.getSubCompanyname(RecordSet.getString("subcomid")),user.getLanguage())%>
				/
				<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>
				:
				<%=Util.toScreen(RecordSet.getString("seclevel"),user.getLanguage())%>
			  </TD>
		    </TR>
		
		<%}
		}%>
		</table>
		</FORM>
		
		
		</div>
		
		
		 
		 
		 
	<script type="text/javascript">
	
	$(document).ready(function(){
		    $(document).bind("contextmenu",function(e){
		        return false;
		    });
		});
		
	function chkDirAccessRightAllClick(obj,opertype){
    var chks = document.getElementsByName("chkDirAccessRightId"+opertype);  
    for (var i=0;i<chks.length;i++){
        var chk = chks[i];
        chk.checked=obj.checked;
    }    
}
			
	function resDirAccessRightAdd(opertype){
    	var xposition=0; var yposition=0;
		if ((parseInt(navigator.appVersion) >= 4 ))
		{
			xposition = (screen.width - 500) / 2;
			yposition = (screen.height - 400) / 2;
		}
		var msg = window.showModalDialog("/cpcompanyinfo/ComcheckAccessRightAdd.jsp?opertype="+opertype+"&comallright=1",window, "dialogWidth:450px; dialogHeight:250px; dialogLeft:"+xposition+"px; dialogTop:"+yposition+"px; status:no;scroll:no;resizable=no;");
   	 	if(msg=='1'){
	  	window.location.reload();
		}
	
	}


function onPermissionDel(opertype,form,showjsp){
	var ids = "";
	var count = 0;
    var chks = document.getElementsByName("chkDirAccessRightId"+opertype);    
    for (var i=0;i<chks.length;i++){
        var chk = chks[i];
        if(chk.checked){
        	ids = ids + "," + chk.value;
            count ++;
        }
    }    
    if(count==0){
    	alert("<%=SystemEnv.getHtmlLabelName(30951,user.getLanguage())%>");
    	return false;
    }
   
    if(window.confirm("<%=SystemEnv.getHtmlLabelName(30695,user.getLanguage())%>?")){
    	var formObj =document.getElementById(form);
        formObj.action= "/cpcompanyinfo/ComAccessRightManage.jsp?method=delete&ids="+ids+"&showjsp="+showjsp;
        formObj.submit();
    }
}


	</script>		 
		
	
	
		
</body>

	
</html>