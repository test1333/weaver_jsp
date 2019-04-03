<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
String flag = "";
String billid = "";
String jbid =  Util.null2String(request.getParameter("jbid"));  
rs.executeSql(" select id from uf_hq_cri_noticeoao where dyjbbh ='"+jbid+"'  ");
if(rs.next()){
	billid = rs.getString("id");
	flag = "1";
}else{
	flag = "0";
}
%>

<script type="text/javascript">

	jQuery(document).ready(function(){
		
		var flags = "<%=flag%>";
		if(flags=="1"){
			//window.parent.close();
			window.location.href="/formmode/view/AddFormMode.jsp?type=0&modeId=851&formId=-150&billid=<%=billid%>&opentype=0&customid=862&viewfrom=fromsearchlist";
		}else{
			var jbid = "<%=jbid%>";
			//window.parent.close();
			window.location.href="/formmode/view/AddFormMode.jsp?mainid=0&modeId=851&formId=-150&type=1&jbid="+jbid;
		}
		
	})

</script>