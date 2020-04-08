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
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page"/>
<%
	String ftlx = Util.null2String(request.getParameter("ftlx"));
	String dqxz = Util.null2String(request.getParameter("dqxz")); 
	 StringBuffer sb = new StringBuffer();
	 String sql = "";
	 String sql_dt = "";
	 if("0".equals(ftlx)){
		sql = "select bmmc as bm,convert(varchar(100) , cast(sum(convert(decimal(10,6),isnull(gsbl,'0'))) as numeric(10,6))) as bl from uf_gsft group by bmmc";
		rs.executeSql(sql);
		while(rs.next()){
			String bm = Util.null2String(rs.getString("bm"));
			String bl = Util.null2String(rs.getString("bl"));
			String bmdm = "";
			String bmname = "";
			sql_dt = "select bmdm,(select departmentname from hrmdepartment where id=a.bmmc) as bmname from uf_gsft a where bmmc='"+bm+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				bmdm = Util.null2String(rs_dt.getString("bmdm"));
				bmname = Util.null2String(rs_dt.getString("bmname"));
			}
			sb.append(bmdm);
			sb.append("###");
			sb.append(bm);		
			sb.append("###");
			sb.append(bmname);
			sb.append("###");
			sb.append(bl);
			sb.append("@@@");
		}
	 }else if("1".equals(ftlx)){
		sql = "select bmdm,bmmc AS bm ,(select departmentname from hrmdepartment where id=a.bmmc) as bmname,dqbl as bl from uf_gsft a where zd='"+dqxz+"'";
		rs.executeSql(sql);
		while(rs.next()){
			
			sb.append(Util.null2String(rs.getString("bmdm")));
			sb.append("###");
			sb.append(Util.null2String(rs.getString("bm")));		
			sb.append("###");
			sb.append(Util.null2String(rs.getString("bmname")));
			sb.append("###");
			sb.append(Util.null2String(rs.getString("bl")));
			sb.append("@@@");
		}
	 }
    //out.print(sql);
	

	out.print(sb.toString()); 
%>