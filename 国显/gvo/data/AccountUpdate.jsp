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

    alert("域账户修改成功！");

    window.opener.location.reload("/gvo/data/AccountInfo.jsp"); //刷新父窗口中的网页
    window.open('','_self');//关闭IE提醒
    window.close("/gvo/data/AccountUpdate.jsp");//关闭当前窗窗口

</script>