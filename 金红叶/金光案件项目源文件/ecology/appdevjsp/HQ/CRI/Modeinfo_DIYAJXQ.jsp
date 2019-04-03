<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
String billid = "";
String xmbh =  Util.null2String(request.getParameter("xmbh")); 
String sql = " select id from uf_hq_cri_noticeoao where id = '"+xmbh+"' ";
rs.executeSql(sql);
if(rs.next()){
	billid = rs.getString("id");
}

%>

<script type="text/javascript">
	jQuery(document).ready(function(){
		window.location.href =  "/formmode/view/AddFormMode.jsp?type=0&modeId=851&formId=-150&billid=<%=billid%>&opentype=0&customid=862&viewfrom=fromsearchlist ";
	})
</script>