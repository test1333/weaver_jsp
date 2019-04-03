<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	StringBuffer dataBuff = new StringBuffer();



	
	
	String val = request.getParameter("val");
        sql ="select alarmid from uf_action_plan where id="+val;
		String alarmid="";
		rs.execute(sql);
		if(rs.next()){
		alarmid =  Util.null2String(rs.getString("alarmid"));
		}
	    sql = "delete from uf_action_plan where id="+val;
	    rs.executeSql(sql);       
	    sql="select count(1) as count from uf_action_plan where alarmid='"+alarmid+"'";
		int count=0;
		rs.executeSql(sql);  
		if(rs.next()){
		count =  rs.getInt("count");
		}

		if(count==0){
		 sql="update uf_alarm_info set approvestatus='0' where alarm_id='"+alarmid+"'";
		 rs.executeSql(sql);  
		}
				
	
		out.print("success");
	//}	
%>