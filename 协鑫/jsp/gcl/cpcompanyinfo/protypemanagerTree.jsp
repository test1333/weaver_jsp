<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=gbk"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="cu" class="weaver.company.CompanyUtil" scope="page" />
<html>
<head>
<title>��˾����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<%
	if(!HrmUserVarify.checkUserRight("License:manager", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
	}
%>
<script type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
<frameset rows="*" cols="230,*" framespacing="1" frameborder="no" border="0" id="sec">


 	 <frame src="/cpcompanyinfo/CommanagerTreeLeft.jsp" name="frm_right_left"   frameborder="0" scrolling="auto"> 	
 	 <frame src="/cpcompanyinfo/CommanagerTreeRight.jsp" id="frm_right_right" name="frm_right_right" frameborder="0" noresize="noresize" >
 	
</frameset>
<noframes>
<body bgcolor="#ffffff">
�����������֧��iframe��ʽ��ʾ����������������ie5.0���ϡ�
</body>
</noframes>
</html>
