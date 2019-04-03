<%@page import="java.util.Map.Entry"%>
<%@page import="org.json.JSONObject"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.docs.category.security.AclManager " %>
<%@ page import="weaver.docs.category.* " %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.net.URLDecoder.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="MainCategoryComInfo" class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryComInfo" class="weaver.docs.category.SecCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryManager" class="weaver.docs.category.SecCategoryManager" scope="page" />
<jsp:useBean id="SubCategoryComInfo" class="weaver.docs.category.SubCategoryComInfo" scope="page" />
<jsp:useBean id="SecCategoryDocTypeComInfo" class="weaver.docs.category.SecCategoryDocTypeComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="MouldManager" class="weaver.docs.mouldfile.MouldManager" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="ProjectInfoComInfo" class="weaver.proj.Maint.ProjectInfoComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="CptFieldComInfo" class="weaver.proj.util.PrjFieldComInfo" scope="page" />
<%
String isclose = Util.null2String(request.getParameter("isclose"));
String isDialog = Util.null2String(request.getParameter("isdialog"));
String isFromTab=Util.null2String( request.getParameter("isFromTab"));
if(!"1".equals(isFromTab)){
	response.sendRedirect("/proj/imp/prjimp.jsp?isdialog="+isDialog) ;
	return ;
}
%>


<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script LANGUAGE="JavaScript" SRC="/js/checkinput_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script type="text/javascript">
var parentWin = parent.parent.getParentWindow(parent.window);
if("<%=isclose%>"=="1"){
	parentWin.onBtnSearchClick();
	parentWin.closeDialog();	
}

</script>
</head>
<%
 int isuse=0;
 String sql = "select * from Prj_Code";
 	rs.executeSql(sql);
 	while(rs.next()){
 	 isuse = rs.getInt("isuse");
 	}
%>
<%
/**if(!HrmUserVarify.checkUserRight("Prj:Imp",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }**/
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(81757,user.getLanguage());
String needfav ="1";
String needhelp ="";

String isGeneratedTemplateFile=Util.null2String( request.getParameter("isGeneratedTemplateFile"));
if(!"1".equals(isGeneratedTemplateFile)){
	response.sendRedirect("/proj/imp/prjimpopt.jsp?generateTemplateFile=1&isdata=1&isdialog="+isDialog+"&isuse="+isuse) ;
	return;
}

String nameQuery = Util.null2String(request.getParameter("nameQuery"));
%>

<BODY style="overflow-x:hidden;">
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:onSave(this),_top} " ;
RCMenuHeight += RCMenuHeightStep ;
//RCMenu += "{"+SystemEnv.getHtmlLabelName(19314,user.getLanguage())+",CapitalExcelToDB1.jsp,_top} " ;
//RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>



<FORM id=cms name=cms action="prjimpopt.jsp?isdata=1" method=post enctype="multipart/form-data">

<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right; width:500px!important">
			<input type="button" value="<%=SystemEnv.getHtmlLabelName( 615 ,user.getLanguage()) %>" class="e8_btn_top"  onclick="onSave(this)"/>
			<span id="advancedSearch" class="advancedSearch" style="display:none;"></span>
			<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>		
<div class="advancedSearchDiv" id="advancedSearchDiv" ></div>

<!-- listinfo -->
<wea:layout attributes="{'expandAllGroup':'true'}">
	<wea:group context='<%=SystemEnv.getHtmlLabelName(81757,user.getLanguage()) %>' attributes="{'groupDisplay':''}" >
		<wea:item><%=SystemEnv.getHtmlLabelName(16699,user.getLanguage())%></wea:item>
		<wea:item>
			<input class=InputStyle  type=file size=40 name="filename" id="filename">
		</wea:item>

<%
String msgtype=Util.null2String(request.getParameter("msgtype"));
//System.out.println("msgtype:"+msgtype);
String msg=Util.null2String(request.getParameter("msg"));
int msgsize;
if (Util.null2String(request.getParameter("msgsize"))==""){
   msgsize=0;
}else{
	msgsize=Integer.valueOf(Util.null2String(request.getParameter("msgsize"))).intValue();
}
if(!"".equalsIgnoreCase(msgtype)|| "success".equals(msg)||msgsize>0){
	%>
		<wea:item attributes="{'id':'msg','colspan':'full'}">
<font size="2" color="#FF0000">
<%


String msg1=Util.null2String((String)session.getAttribute("cptmsg1"));
String msg2=Util.null2String((String)session.getAttribute("cptmsg2"));
int    dotindex=0;
int    cellindex=0;
if("e5".equalsIgnoreCase(msgtype)){
	for (int i=0;i<msgsize;i++){
		dotindex=msg1.indexOf(",");
	    cellindex=msg2.indexOf(",");
		out.println(msg1.substring(0,dotindex)+"&nbsp;"+SystemEnv.getHtmlLabelName(18620,user.getLanguage())+"&nbsp;"+msg2.substring(0,cellindex)+"&nbsp;"+SystemEnv.getHtmlLabelName(18621,user.getLanguage())+"&nbsp;"+SystemEnv.getHtmlLabelNames("586,26161,21945",user.getLanguage())+" !"+"<br>");

		 msg1=msg1.substring(dotindex+1,msg1.length());
	     msg2=msg2.substring(cellindex+1,msg2.length());
	}
}else if("e4".equalsIgnoreCase(msgtype)){
	msg=SystemEnv.getHtmlLabelNames("64,26161,563",user.getLanguage())+" !";
}else if("e1".equalsIgnoreCase(msgtype)){
	msg=SystemEnv.getHtmlLabelNames("24652",user.getLanguage())+" !";
}else if (msg.equals("success")){
	msg=SystemEnv.getHtmlLabelName(28450,user.getLanguage());
}else{

for (int i=0;i<msgsize;i++){
	dotindex=msg1.indexOf(",");
    cellindex=msg2.indexOf(",");
	out.println(msg1.substring(0,dotindex)+"&nbsp;"+SystemEnv.getHtmlLabelName(18620,user.getLanguage())+"&nbsp;"+msg2.substring(0,cellindex)+"&nbsp;"+SystemEnv.getHtmlLabelName(18621,user.getLanguage())+"&nbsp;"+SystemEnv.getHtmlLabelName(19327,user.getLanguage())+"<br>");

	 msg1=msg1.substring(dotindex+1,msg1.length());
     msg2=msg2.substring(cellindex+1,msg2.length());
}

}

out.println(msg);
%></font>			
		</wea:item>	
	<%
}
%>
		
	</wea:group>
	
	<wea:group context='<%=SystemEnv.getHtmlLabelName(19010,user.getLanguage())%>'>
		<wea:item attributes="{'colspan':'full'}">
			<div>
				<br>
				<%=SystemEnv.getHtmlLabelName(28447,user.getLanguage())%>
				<%if(isuse==0 || isuse==1){%>
					<a style="color: #1d98f8;cursor: pointer;" href="prjimp_xlsnew.xls">
				<%}else{ %>
					<a style="color: #1d98f8;cursor: pointer;" href="prjimp_xlsnew1.xls">
				<%} %>
				<%=SystemEnv.getHtmlLabelName(28446,user.getLanguage())%></a>.
				<br><br>
				<%=SystemEnv.getHtmlLabelName(32986,user.getLanguage())%>.
				<br><br>
				<%=SystemEnv.getHtmlLabelName(32987,user.getLanguage())%>.
				<br><br>
				<%=SystemEnv.getHtmlLabelName(32988,user.getLanguage())%>.
				<br><br>
			</div>
		</wea:item>
	</wea:group>
	
	<wea:group context='<%=SystemEnv.getHtmlLabelNames("24962",user.getLanguage())%>'>
		<wea:item attributes="{'colspan':'full'}">
			<div>
				<br>
				<strong><%=SystemEnv.getHtmlLabelName(18617,user.getLanguage())%></strong>
				<br><br>
				<span style="color:#FF0000;">
					<%=SystemEnv.getHtmlLabelName(18019,user.getLanguage())%>:&nbsp;
					
					<%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(586,user.getLanguage())%>&nbsp;
					<%if(isuse==2){%>
					<%=SystemEnv.getHtmlLabelName(17852,user.getLanguage())%>&nbsp;
				    <%} %>
					<%=SystemEnv.getHtmlLabelName(144,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(18628,user.getLanguage())%>&nbsp;
					
				</span>	
					
					
<%
TreeMap<String, JSONObject> openfieldMap= CptFieldComInfo.getOpenFieldMapByPrjtype("-1");
TreeMap<String, JSONObject> mandfieldMap= new TreeMap<String, JSONObject>();
if(openfieldMap!=null && openfieldMap.size()>0){
	Iterator it1=openfieldMap.entrySet().iterator();
	int i=1;
	while(it1.hasNext()){
	Entry<String,JSONObject> entry1=(Entry<String,JSONObject>)it1.next();
	String k1= entry1.getKey();
	JSONObject v1= (JSONObject)entry1.getValue().clone();
		if(v1.getInt("ismand")==1){
			mandfieldMap.put(""+(i++), v1);
		}
	}
 if(mandfieldMap!=null && mandfieldMap.size()>0){
%>	
				<span style="color:#FF0000;">	
					<%=SystemEnv.getHtmlLabelName(17037,user.getLanguage())%>(&nbsp;
					
<%
	Iterator it=mandfieldMap.entrySet().iterator();
	while(it.hasNext()){
		Entry<String,JSONObject> entry=(Entry<String,JSONObject>)it.next();
		String k= entry.getKey();
		JSONObject v= entry.getValue();
%>			
					<%=SystemEnv.getHtmlLabelName(v.getInt("fieldlabel"),user.getLanguage()) %>&nbsp;
<%
	}
	%>
				)</span>
	<%
 }
}

%>
					
				
				<br><br>
				<span>
					<%=SystemEnv.getHtmlLabelName(375,user.getLanguage())%>:&nbsp;
					
					<%=SystemEnv.getHtmlLabelName(15486,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(432,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(783,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(15263,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(624,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(636,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(637,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(638,user.getLanguage())%>&nbsp;
					<%=SystemEnv.getHtmlLabelName(639,user.getLanguage())%>&nbsp;
					
				</span>

<%

if(openfieldMap!=null && openfieldMap.size()>0&&mandfieldMap!=null&&openfieldMap.size()>mandfieldMap.size()){
%>	
				<span >	
					<%=SystemEnv.getHtmlLabelName(17037,user.getLanguage())%>(&nbsp;
					
<%
	Iterator it=openfieldMap.entrySet().iterator();
	while(it.hasNext()){
		Entry<String,JSONObject> entry=(Entry<String,JSONObject>)it.next();
		String k= entry.getKey();
		JSONObject v= entry.getValue();
		if(v.getInt("ismand")!=1){
			
%>			
					<%=SystemEnv.getHtmlLabelName(v.getInt("fieldlabel"),user.getLanguage()) %>&nbsp;
<%
		}
	}
	%>
				)</span>
				<br><br>
	<%
}

%>
				
				
			</div>
		</wea:item>
	</wea:group>
	
</wea:layout>






<div id='_xTable' style='background:#FFFFFF;padding:3px;width:100%' valign='top'></div>

</FORM>
<script language="javascript">
function onSave(obj){
	if ($GetEle('filename').value=="" || $GetEle('filename').value.toLowerCase().indexOf(".xls")<0){
		window.top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(18618,user.getLanguage())%>");
	}else{
        var showTableDiv  = document.getElementById('_xTable');
		var message_table_Div = document.createElement("div");
		message_table_Div.id="message_table_Div";
		message_table_Div.className="xTable_message";
		showTableDiv.appendChild(message_table_Div);
		var message_table_Div  = document.getElementById("message_table_Div");
		message_table_Div.style.display="inline";
		message_table_Div.innerHTML="<%=SystemEnv.getHtmlLabelName(20904,user.getLanguage())%>....";
		var pTop= document.body.offsetHeight/2-60;
		var pLeft= document.body.offsetWidth/2-100;
		message_table_Div.style.position="absolute";
		message_table_Div.style.top=pTop;
		message_table_Div.style.left=pLeft;

		$GetEle('cms').submit();
		obj.disabled = true;
    }
}
</script>
<%
if("1".equals( isDialog)){
	%>
<div id="zDialog_div_bottom" class="zDialog_div_bottom">
	<wea:layout needImportDefaultJsAndCss="false">
		<wea:group context=""  attributes="{\"groupDisplay\":\"none\"}">
			<wea:item type="toolbar">
		    	<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parentWin.closeDialog();">
			</wea:item>
		</wea:group>
	</wea:layout>
</div>
	<%
}
%>

<script type="text/javascript">	
$(function(){
	try{
		parent.setTabObjName("<%=SystemEnv.getHtmlLabelName(81757,user.getLanguage()) %>");
	}catch(e){}
});
</script>
</body>
</HTML>
