<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.general.Util"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="weaver.email.MailCommonUtils"%>


<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs3" class="weaver.conn.RecordSet" scope="page"/>
<%

User user = HrmUserVarify.getUser (request , response) ;
int userid =user.getUID();
String status = Util.null2String(request.getParameter("status"));//踩赞
String itemId = Util.null2String(request.getParameter("itemId"));//主题ID
String discussid = Util.null2String(request.getParameter("discussid"));//楼层ID
String sql="";
int votetype=0;//踩赞类型
JSONObject results=new JSONObject();

String selectsql="select status,id from cowork_cream where itemId="+itemId+" and discussid="+discussid;
rs.execute(selectsql);

int votes=rs.getCounts();

if(0==votes){
	 String date = MailCommonUtils.getTodaySendDate();
     sql="insert into  cowork_cream(itemid,userid,status,discussid,createtime) values "+"("+itemId+","+userid+","+status+","+discussid+",'"+date+"')";
     if("0".equals(status)){
         votetype=0;
     }else{
         votetype=1;
     }
}else{
    // sql="delete from  cowork_votes where itemId="+itemId+" and userid="+userid +" and status="+status+" and discussid="+discussid;
    String id = "";
    String sstatus = "";
	if(rs.next()){
		sstatus = rs.getString("status");
		id = rs.getString("id");
	}
	if("1".equals(sstatus)){
		sstatus = "0";
	}else{
		sstatus = "1";
	}
	status = sstatus;
     sql="update cowork_cream set status = "+sstatus+" where id = "+id;
     votetype=Integer.parseInt(status);
}
rs1.execute(sql);
 

results.put("votetype",votetype);
results.put("votetypestatus",status);

out.print(results);
%>