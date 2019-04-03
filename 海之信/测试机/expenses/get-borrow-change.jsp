<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />

<%
    String jkrid = request.getParameter("jkrid");
	String bz_1 = request.getParameter("bz1");

	 StringBuffer sb = new StringBuffer();
	 
	 String id="";
	  String sql="";
	if("0".equals(bz_1)){
	 sql="select id,bz,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_personal_borrow' and a.fieldname= 'bz' and c.selectvalue=bz) as bzname,jkje,jkdqr,jksm from uf_personal_borrow  where jkr='"+jkrid+"' and bz='0' and ISNULL(jkye,0)>0  ";
	}else{
		  sql="select id,bz,(select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_personal_borrow' and a.fieldname= 'bz' and c.selectvalue=bz) as bzname,jkje,jkdqr,jksm  from uf_personal_borrow  where jkr='"+jkrid+"' and bz <>'0' and ISNULL(jkye,0)>0  ";
	}
    rs.executeSql(sql);
	while(rs.next()){
         id = Util.null2String(rs.getString("id"));
		
		  
		sb.append(id);
		sb.append("###");
		sb.append(Util.null2String(rs.getString("bz")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("bzname")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("jkje")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("jkdqr")));
		sb.append("###");
		sb.append(Util.null2String(rs.getString("jksm")));
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>