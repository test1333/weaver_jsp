<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

		StringBuffer dataBuff = new StringBuffer();
      String gw_id = request.getParameter("id");//岗位ID
      String gwName = "";//岗位技能
      //out.print("gw_id ="+gw_id);
      if(gw_id.length()>0){
      String sql = " select f1.gwjn,f2.pxkc from formtable_main_302 f1 left join formtable_main_302_dt1 f2 on  f1.id = f2.mainid where f1.id = "+gw_id;
      rs.executeSql(sql);
		while( rs.next() ) {

   			gwName = Util.null2String(rs.getString("pxkc"));
   			dataBuff.append(gwName);dataBuff.append("###");
		}
		out.print(dataBuff.toString());
   }
%>