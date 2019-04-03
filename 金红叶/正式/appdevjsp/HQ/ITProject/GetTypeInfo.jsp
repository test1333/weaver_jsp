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
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	StringBuffer dataBuff = new StringBuffer();
  
	String typeid  = "";
	String typedec  = "";
	
	String xmlx = request.getParameter("xmlx");
	String xmjl = request.getParameter("xmjl");

	sql = "select distinct a.code,a.name from uf_IT_basedata a where a.project='ITZL' and a.type='ITPRO_STATUS' and a.remark="+xmlx+" order by a.code";
 
	    rs.executeSql(sql);       
	    //out.print("sql="+sql);
	    log.writeLog("sql="+sql);   
		while( rs.next() ) {	

		typeid = Util.null2String(rs.getString("code"));
		dataBuff.append(typeid);
		dataBuff.append("###");

		typedec = Util.null2String(rs.getString("name"));
		dataBuff.append(typedec);
		dataBuff.append("###");

		dataBuff.append(xmjl);
		dataBuff.append("@@@");
			
		}

		out.print(dataBuff.toString());
	//}	
%>