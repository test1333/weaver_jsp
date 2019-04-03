<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%

int formid = Util.getIntValue(request.getParameter("formid"));	
int billid = Util.getIntValue(request.getParameter("billid"));	
int xmid = Util.getIntValue(request.getParameter("xmid"));	

int xmbh=-1;   
rs.executeSql(" select * from  workflow_billfield where billid ='"+formid+"'  ");
while(rs.next()){
	int fieldid=rs.getInt("id");
	String fieldname=rs.getString("fieldname");
	String detailtable=rs.getString("detailtable");
	if("xmbh".equals(fieldname.toLowerCase()) && "".equals(detailtable) ){
		xmbh=fieldid;
	}
}

String xmmc = "";
rs.executeSql(" select * from uf_hq_cri_noticeoao where id = '"+xmid+"' ");
if(rs.next()){
	xmmc = rs.getString("xmbh");
}

%>

<script type="text/javascript">

	jQuery(document).ready(function(){
		
		var billid = "<%=xmid%>";
		var xmmc = "<%=xmmc%>";
		var html = "<span class='e8_showNameClass'><a title='' href='/formmode/view/AddFormMode.jsp?type=0&amp;modeId=851&amp;formId=-150&amp;billid="+billid+"' target='_blank'>"+xmmc+"</a>&nbsp;<span class='e8_delClass' id="+billid+" onclick='del(event,this,1,false,{});' style='opacity: 1; visibility: hidden;'>&nbsp;x&nbsp;</span></span> ";
		
		//jQuery("#field<%=xmbh%>").val(billid);
		//jQuery("#field<%=xmbh%>span").html(html);
		
	})
	
	

</script>
