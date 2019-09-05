<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"type="text/css" />
<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet" type="text/css" />
<link href="/cpcompanyinfo/style/Business.css" rel="stylesheet" type="text/css" />

<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script type="text/javascript" language="javascript" src="/js/jquery/jquery.js"></script>

</head>
<%

	if(!HrmUserVarify.checkUserRight("License:manager", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
	
	String sql = " SELECT * FROM CPCOMPANYTIMEOVER ";
	rs.execute(sql);
	String toid = "";
	String tofaren = "";
	String todsh = "";
	String tozhzh ="";
	String tozhch = "";
	String tonjian = "";
	String chzhzh = "";
	String chgd = "";
	String chdsh = "";
	String chzhch = "";
	String chxgs ="";
	if(rs.next()){
		toid = rs.getString("id");
		tofaren = rs.getString("tofaren");
		todsh = rs.getString("todsh");
		tozhzh = rs.getString("tozhzh");
		tozhch = rs.getString("tozhch");
		tonjian = rs.getString("tonjian");
		chzhzh = rs.getString("chzhzh");
		chgd = rs.getString("chgd");
		chdsh = rs.getString("chdsh");
		chzhch = rs.getString("chzhch");
		chxgs = rs.getString("chxgs");
	}

String flag=Util.null2String(request.getParameter("flag"));
String imagefilename = "/images/hdSystem.gif";
String titlename = ""+SystemEnv.getHtmlLabelName(18818,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>

<BODY>

<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(30986,user.getLanguage())+",javascript:onSave(),_self} " ;    
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>


<FORM style="MARGIN-TOP: 0px" name=frmMain method=post action="action/CPCompanySetOperate.jsp">
 <input type=hidden name=method value="overtime2Save">
 <input type=hidden name="toid" value="<%=toid %>"/>
 
 <table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
</colgroup>
<tr>
	<td height="10" colspan="3"></td>
</tr>

<tr>
	<td ></td>
	<td valign="top">
		
		<TABLE class=ViewForm>

               
				<TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
			
				<tr>
                
                  <td><%=SystemEnv.getHtmlLabelName(31090,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(17548,user.getLanguage()) %> <input type="text" name="tofaren" value="<%=tofaren %>" class="BoxW60"    onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31091,user.getLanguage()) %>
				  </td>
				</tr>
				<TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
				
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31092,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(17548,user.getLanguage()) %>  <input type="text" name="todsh" value="<%=todsh %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31091,user.getLanguage()) %>
				  </td>
				</tr>
              <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                 <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31093,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(17548,user.getLanguage()) %> <input type="text" name="tozhzh" value="<%=tozhzh %>" class="BoxW60"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31091,user.getLanguage()) %>
				  </td>
				</tr>
                <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                 <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31094,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(17548,user.getLanguage()) %> <input type="text" name="tozhch" value="<%=tozhch %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/>
				  		 <%=SystemEnv.getHtmlLabelName(31091,user.getLanguage()) %>
				  </td>
				</tr>
               <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                 <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31095,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(17548,user.getLanguage()) %> <input type="text" name="tonjian" value="<%=tonjian %>" class="BoxW60"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31096,user.getLanguage()) %>
				  </td>
				</tr>
                <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31758,user.getLanguage()) %></td>
				  <td class=Field>
				  	 <%=SystemEnv.getHtmlLabelName(31097,user.getLanguage()) %>
				  	 	<input type="text" name="chzhzh" value="<%=chzhzh %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/>
				  	  <%=SystemEnv.getHtmlLabelName(31098,user.getLanguage()) %>
				  </td>
				</tr>
               <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31759,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(31097,user.getLanguage()) %> <input type="text" name="chgd" value="<%=chgd %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/>
				  		<%=SystemEnv.getHtmlLabelName(31099,user.getLanguage()) %>
				  </td>
				</tr>
               <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31070,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(31097,user.getLanguage()) %> <input type="text" name="chdsh" value="<%=chdsh %>" class="BoxW60"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31100,user.getLanguage()) %>
				  		
				  </td>
				</tr>
                <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31071,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(31097,user.getLanguage()) %> <input type="text" name="chzhch" value="<%=chzhch %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31101,user.getLanguage()) %>
				  </td>
				</tr>
                <TR  style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
                <tr>
				  <td><%=SystemEnv.getHtmlLabelName(31072,user.getLanguage()) %></td>
				  <td class=Field>
				  		<%=SystemEnv.getHtmlLabelName(31593,user.getLanguage()) %> <input type="text" name="chxgs" value="<%=chxgs %>" class="BoxW60" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"   onpaste="javascript: return false;"  maxlength="5"/> 
				  		<%=SystemEnv.getHtmlLabelName(31102,user.getLanguage()) %>
				  </td>
				</tr>
                <TR    style="height:1px"><TD class=Line colSpan=2  ></TD></TR>
					

        </TBODY>
			 
        </TABLE>
      
	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>

  </FORM>
</BODY>

<script language="javascript">
	jQuery(document).ready(function(){
			<%
				if(!"".equals(flag)){
				out.println("alert('"+SystemEnv.getHtmlLabelName(30992,user.getLanguage())+"')");
				}
			%>
		});
	function onSave(){
		frmMain.submit();
	}
</script>
<style>
.Nav{
	cursor: pointer;
}
</style>
</HTML>
