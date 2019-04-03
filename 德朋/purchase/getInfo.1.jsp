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
    StringBuffer dataBuff = new StringBuffer();
    String qj_id = request.getParameter("id");
	 String sql="select b.gg,b.dw,b.shl,b.xqrq,b.bzh,b.km,b.bm,b.pm,b.bma,b.dj,b.je,b.val from uf_orders a,uf_orders_dt1 b where a.id=b.mainid and a.lastversion='1' and a.requestid="+qj_id;
     rs.executeSql(sql);
	 String valid="";
	 String pm = "";
	 String km = "";
	 String bma = "";
     String bm = "";
     String gg = "";
     String dw = "";
     String sl = "";
     String dj = "";
     String je = "";
     String xqrq = "";
     String bz = "";
	 while(rs.next()){
        valid = Util.null2String(rs.getString("val"));
		pm = Util.null2String(rs.getString("pm"));
		km = Util.null2String(rs.getString("km"));
		bma = Util.null2String(rs.getString("bma"));
		bm = Util.null2String(rs.getString("bm"));
		gg = Util.null2String(rs.getString("gg"));
		dw = Util.null2String(rs.getString("dw"));
		sl = Util.null2String(rs.getString("shl"));
		dj = Util.null2String(rs.getString("dj"));
		je = Util.null2String(rs.getString("je"));
		xqrq = Util.null2String(rs.getString("xqrq"));
		bz = Util.null2String(rs.getString("bzh"));

		dataBuff.append(valid);
		dataBuff.append("###");
		dataBuff.append(pm);
		dataBuff.append("###");
		dataBuff.append(km);
		dataBuff.append("###");
		dataBuff.append(bma);
		dataBuff.append("###");
		dataBuff.append(bm);
		dataBuff.append("###");
		dataBuff.append(gg);
		dataBuff.append("###");
		dataBuff.append(dw);
		dataBuff.append("###");
		dataBuff.append(sl);
		dataBuff.append("###");
		dataBuff.append(dj);
		dataBuff.append("###");
		dataBuff.append(je);
		dataBuff.append("###");
		dataBuff.append(xqrq);
		dataBuff.append("###");
		dataBuff.append(bz);
		dataBuff.append("@@@");
	 }
	out.print(dataBuff.toString());
%>