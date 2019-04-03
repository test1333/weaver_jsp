<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));
int sapsjzc=-1;   
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("sapsjzc".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		sapsjzc=fieldid;
	}
}

%>

<script type="text/javascript">

	jQuery(document).ready(function(){
		
	
	})

</script>
