<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%
String imagefilename = "/images/hdHRM.gif";
String titlename = "";
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="JavaScript">
var contentUrl = (window.location+"").substring(0,(window.location+"").lastIndexOf("/")+1)+"/hrm/search/HrmResourceSearchTmp.jsp";
//alert(contentUrl);
</script>
</HEAD>
<body>
<TABLE class=viewform width=100% id=oTable1 height=100%>
<TBODY>
<tr>
<td width="24%" height=100% id=oTd1 name=oTd1>
<IFRAME name=leftframe id=leftframe src="/empolder/finance/firstDepLeft.jsp" width="100%" height="100%" frameborder=no scrolling=auto>
浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</IFRAME>
</td>
<td width="1%" height=100% id=oTd0 name=oTd0 align=center>
<IFRAME name=middleframe id=middleframe   src="\framemiddle.jsp" width="100%" height="100%" frameborder=no scrolling=no noresize>
浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</IFRAME>
</td>
<td width="75%" height=100% id=oTd2 name=oTd2>
<IFRAME name=contentframe id=contentframe src="/empolder/finance/firstDepList.jsp" width="100%" height="100%" frameborder=no scrolling=yes>
浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</IFRAME>
</td>
</tr>
</TBODY>
</TABLE>
</body>

</html>