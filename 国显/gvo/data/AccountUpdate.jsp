<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	
	String id = Util.null2String(request.getParameter("mid"));
	String account = Util.null2String(request.getParameter("account"));
	RecordSet.executeSql("update HrmResource set loginid ='"+account+"',account = '"+account+"' where id="+id);
    //	RecordSet.executeSql("update HrmResource set loginid ='"+account+"',account = '"+account+"' where id="+id);
	RecordSet.executeSql("update HrmResource set loginid =null where id!="+id +" and  loginid='"+account+"'");
	RecordSet.executeSql("update HrmResource set account=null where id!="+id +" and  account='"+account+"'");
%>

<script language="javascript">

    alert("���˻��޸ĳɹ���");

    window.opener.location.reload("/gvo/data/AccountInfo.jsp"); //ˢ�¸������е���ҳ
    window.open('','_self');//�ر�IE����
    window.close("/gvo/data/AccountUpdate.jsp");//�رյ�ǰ������

</script>