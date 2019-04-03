<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));	
int nodeid = Util.getIntValue(request.getParameter("nodeid"));

User usertemp = HrmUserVarify.getUser(request,response) ;
int userid=usertemp.getUID();
String dczj = "";
rs.executeSql(" select * from hrmroles t1,hrmrolemembers t2 where t1.id = t2.roleid and t1.id='622' and t2.resourceid = '"+userid+"' ");
if(rs.next()){
	dczj="1";
}else{
	dczj="0";
}

int ttrzj=-1;   
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("ttrzj".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		ttrzj=fieldid;
	}
}

%>

<script type="text/javascript">

	jQuery(document).ready(function(){
		var dczj = "<%=dczj%>";
		if(dczj=="1"){
			jQuery("#field<%=ttrzj%>").val("1");
		}else{
			jQuery("#field<%=ttrzj%>").val("0");
		}
	})

</script>
