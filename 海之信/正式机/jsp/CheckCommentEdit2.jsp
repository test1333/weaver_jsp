<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String idx = request.getParameter("idx");//idÖµ
String comment = request.getParameter("name");//Åú×¢

String sql = "update uf_differhandle set commenton = '"+comment+"' where id = "+idx+"";
    rs.executeSql(sql);

%>
<script type="text/javascript">
	var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>
