<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="jcifs.*" %>
<%@ page import="jcifs.smb.SmbFileInputStream" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
String path="smb://10.9.2.57/Object/ISO/Attach2/ISO_Attach_Modify_2014227144226_146.xls";
out.println(path+"\n");
NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication("10.9.2.57", "administrator", "sa@12345");
InetAddress ip = InetAddress.getByName("10.9.2.57"); 
UniAddress myDomain = new UniAddress(ip);
SmbSession.logon(myDomain,auth); 
SmbFile file = new SmbFile(path,auth);
//File oldfile=new File(path);
out.print("是否存在"+file.exists()+"\n");
SmbFileInputStream fi = new SmbFileInputStream(file);

path="D:\\WEAVER\\ecology\\hhgd\\doc\\test.jsp";
out.println(path+"\n");
File oldfile1=new File(path);
out.print("是否存在"+oldfile1.exists());
  //FileInputStream fi = new FileInputStream(new File(fileUrl));
	
	 

	out.print("123");
%>