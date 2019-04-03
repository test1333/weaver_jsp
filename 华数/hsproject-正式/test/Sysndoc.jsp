<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="hsproject.impl.AddDocShare" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	String prjid = "";
	String procode = "";
	String begindate = "";
	String xmprjid = "";
	String sql_dt = "";
	String flag = "";
	String prjattach = "";
	AddDocShare ads = new AddDocShare();
	String sql="select id,procode,begindate from hs_projectinfo";
	rs.execute(sql);
	while(rs.next()){
			flag = "";
			prjid = Util.null2String(rs.getString("id"));
			procode = Util.null2String(rs.getString("procode"));
			begindate = Util.null2String(rs.getString("begindate"));
			xmprjid = "";
			sql_dt = "select id from wasu_projectbase where xmcode='"+procode+"' and sqrq='"+begindate+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()) {
				xmprjid = Util.null2String(rs_dt.getString("id"));
			}
			if("".equals(xmprjid)) {
				continue;
			}
			prjattach = "";
			sql_dt="select fileid from wasu_projfiles where projid="+xmprjid;
			rs_dt.executeSql(sql_dt);
			while(rs_dt.next()) {
				prjattach = prjattach+flag+Util.null2String(rs_dt.getString("fileid"));
				flag = ",";
				
			}
			if("".equals(prjattach)){
				continue;
			}
			sql_dt="update hs_projectinfo set attach='"+prjattach+"' where id="+prjid;
			rs_dt.executeSql(sql_dt);
			ads.addShare(prjid, prjattach);
	}
	
	 // pid.sysprocess();
%>
