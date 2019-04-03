<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
    String checkids = Util.null2String(request.getParameter("checkids"));
	 
	 String cgz="";
	 String wlz = "";
	 String dw = "";
	 StringBuffer sb = new StringBuffer();
	 String sql="select id,hxmbh,cgz,sqr,(select lastname from hrmresource where id=a.sqr) as sqrname,kmfplb,cgxmms,gc,nbgcysdm,wlz,sqsl,dw,dj,je,yjjhrq,cgpzzdxmlb,cbzx,(select departmentname from HrmDepartment where id=a.cbzx) as cbzxname,jtid,zzch,zczbh,ysbm,epcno,kyxmbm,gdzcsblb"+
				" from formtable_main_16_dt2 a where id in("+checkids+") order by id asc";
    //out.print(sql);
	rs.executeSql(sql);
	while(rs.next()){
         
		sb.append(Util.null2String(rs.getString("cgz")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("wlz")));		
		sb.append("###");
		sb.append(Util.null2String(rs.getString("dw")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("cbzx")));
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>