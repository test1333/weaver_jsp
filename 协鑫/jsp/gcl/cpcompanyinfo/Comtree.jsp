<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.conn.RecordSet" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="CompanyUtil" class="weaver.company.CompanyUtil" scope="page"/>
<%

StringBuffer sb = new StringBuffer();
//������仰�������js�ؼ����ݻ���������
response.setContentType("text/xml");
sb = CompanyUtil.getXMLTree();
/* 
	 sb.append("<?xml version='1.0' encoding='GBK'?>\n");
	sb.append("<tree id=\"-1\">\n");			
	sb.append("<item text=\"44\" id=\"0\"></item>");
	sb.append("</tree>"); 
 */
out.clear();
out.print(sb.toString());
%>