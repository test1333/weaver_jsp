<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util"%>
<%@ page import="com.opentext.ecm.lea.common.ALHttpMethod"%>
<%@ page import="com.opentext.ecm.lea.common.ICSException"%>
<%@ page import="com.opentext.ecm.leaclient.ArchiveLinkClient"%>
<HTML>
<HEAD></head>
<BODY> 
	<%
		//String url = "http://172.18.95.157:8080/archive?get&pVersion=0045&contRep=SS&docId=aafjeiagbiqvtqfmena141nmcjpz1";
		String url = "http://172.18.95.47:8080/archive?get&pVersion=0045&contRep=EA&docId=005056A878BB1EE7B6C6C1828655E609";
		String fileName = "APP.pem";
		String homePath = System.getProperty("java.home");
		String file = homePath + "/" + fileName;
		String urlx="";
		try {
			 urlx=ArchiveLinkClient.getSignature4Url(url,ALHttpMethod.GET,30,file);
		} catch (ICSException e) {
			e.printStackTrace();
			out.println(e);
		}
		response.sendRedirect(urlx);
	%>
</BODY>
