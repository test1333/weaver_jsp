
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<% 
boolean canedit = true;
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>

<%
	int msgid = Util.getIntValue(request.getParameter("msgid"), -1);
	String isclose = Util.null2String(request.getParameter("isclose"));

	boolean canEdit = true;
    String idx = Util.null2String(request.getParameter("id"));
	String commont = Util.null2String(request.getParameter("name"));//备注
	
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
<script language=javascript >

function checkSubmit(){
    $('#weaver').submit();	
	window.close();
}
if("<%=isclose%>"=="1"){
	parent.getParentWindow(window)._table.reLoad();
	parent.getDialog(window).close();
	
}

jQuery(function(){
	checkinput("name","nameimage");
});
</script>
</HEAD>
<%
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = "";
if (canEdit) 
	titlename = SystemEnv.getHtmlLabelName(93,user.getLanguage())
			+":"+SystemEnv.getHtmlLabelName(462,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage());
else 
	titlename = SystemEnv.getHtmlLabelName(367,user.getLanguage())
			+":"+SystemEnv.getHtmlLabelName(462,user.getLanguage())+SystemEnv.getHtmlLabelName(63,user.getLanguage());

String needfav ="1";
String needhelp ="";
%>
<BODY>

<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if (canEdit){  
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:checkSubmit(),''} " ;
	RCMenuHeight += RCMenuHeightStep ;
}
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<jsp:include page="/systeminfo/commonTabHead.jsp">
   <jsp:param name="mouldID" value="customer"/>
   <jsp:param name="navName" value="批注"/>
</jsp:include>

<wea:layout attributes="{layoutTableId:topTitle}">
	<wea:group context="" attributes="{groupDisplay:none}">
		<wea:item attributes="{'customAttrs':'class=rightSearchSpan'}">
			<%if (canEdit){  %>
			<input class="e8_btn_top middle" onclick="checkSubmit()" type="button"  value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage()) %>"/>
			<%} %>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</wea:item>
	</wea:group>
</wea:layout>

<wea:layout>
	<wea:group context="" attributes="{groupDisplay:none,itemAreaDisplay:none}">
		<%if (msgid != -1) {%>
		<wea:item><FONT color="red" size="2"><%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%></FONT></wea:item>
		<%}%>
	</wea:group>
</wea:layout>
	
<FORM id=weaver name="form1" action="CheckCommentEdit2.jsp" method=post >
<input type="hidden" name="idx" value="<%=idx%>">

<wea:layout>
	<wea:group context="<%= SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>">
        <!--批注-->
		<wea:item>批注</wea:item>
		<wea:item>
		<wea:required id="nameimage" required="true" value="">
			<% if(canedit) {%><TEXTAREA class=InputStyle ROWS="10"  STYLE="width:90%" 
			                  name="name" value="<%=commont%>"></TEXTAREA><%} 
			else {%><%=Util.toScreen(RecordSet.getString(3),user.getLanguage())%><%}%>
			</wea:required>
		</wea:item>

	</wea:group>
</wea:layout>

<div id="zDialog_div_bottom" class="zDialog_div_bottom">
	<wea:layout>
		<wea:group context="" attributes="{groupDisplay:none}">
			<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage()) %>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parent.getDialog(window).close();">
	    </wea:item>
		</wea:group>
	</wea:layout>
</div>
<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include>  
</FORM>
</BODY>

</HTML>
