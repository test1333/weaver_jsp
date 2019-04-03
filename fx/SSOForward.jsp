<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/fx/init.jsp" %>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
<%
String type = Util.null2String(request.getParameter("type")); //类型
int fromUserId = Util.getIntValue(request.getParameter("fromUserId"), 0); //来源用户
String id = Util.null2String(request.getParameter("id")); //ID
String toUrl = "";
if("DOC".equals(type)) toUrl = "/docs/docs/DocDsp.jsp?id="+id;
else if("WFL".equals(type)) toUrl = "/workflow/request/ViewRequest.jsp?requestid="+Util.null2String(request.getParameter("requestid"))+"&isovertime=";
else if("COWORK".equals(type)) toUrl = "/cowork/ViewCoWork.jsp?id="+id+"&view=yes";
%>
<script>
function openFullWindow() {
  var redirectUrl = "<%=toUrl%>";
  var width = screen.width ;
  var height = screen.height ;
  if (height == 768 ) height -= 75 ;
  if (height == 600 ) height -= 60 ;
  var szFeatures = "top=0," ; 
  szFeatures +="left=0," ;
  szFeatures +="width="+width+"," ;
  szFeatures +="height="+height+"," ;
  szFeatures +="directories=no," ;
  szFeatures +="status=yes," ;
  szFeatures +="menubar=no," ;

  if (height <= 600 ) szFeatures +="scrollbars=yes," ;
  else szFeatures +="scrollbars=no," ;

  szFeatures +="resizable=yes" ; //channelmode
  var newwin = window.open(redirectUrl,"",szFeatures) ;
  if(newwin==null) {
	  location.href = redirectUrl;
  }
  else {
	window.opener='ecology';
  	window.open('','_self');
  	window.close();
  }
}
<%
if(user.getUID()==fromUserId) {
%>
	<%if("DOC".equals(type)){%>
	openFullWindow();
	<%}else{%>
	location.href = "<%=toUrl%>";
	<%}%>
<%
}
else {
%>
	$.post('/login/IdentityShift.jsp?shiftid=<%=fromUserId%>', function(data){
		<%if("DOC".equals(type)){%>
		openFullWindow();
		<%}else{%>
		location.href = "<%=toUrl%>";
		<%}%>
	});
<%
}
%>
</script>
<img src="/images/homepage/style/style1/loading2.gif" style="vertical-align:middle;"><%=SystemEnv.getHtmlLabelName(22911,user.getLanguage())%>......