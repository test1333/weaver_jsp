<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String idkey = request.getParameter("idkey");//idֵ
String actualcheck = request.getParameter("name");//ʵ�����
String remark = request.getParameter("desc");//��ע

String sql = "update uf_checkrecord_dt1 set actual ='"+actualcheck+"',remark = '"+remark+"' where id = "+idkey+"";
    rs.executeSql(sql);
    //rs.executeSql("update uf_checkrecord_dt1 set monitornum ='"+actualcheck+"' where commenton is not null and id = "+idkey+"");
    rs.executeSql("update uf_checkrecord_dt1 set commenton = null where  id = "+idkey+"");

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
