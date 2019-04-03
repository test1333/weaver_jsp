<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	String prjtype = "";
	String processtype = "";
	String sql_dt = "";
	String sql = "select a.id as prjtype from uf_project_type a where a.id not in(1)";
	rs.executeSql(sql);
	while(rs.next()){
		prjtype = Util.null2String(rs.getString("prjtype"));
		sql_dt	= "insert into uf_prj_syscptbus_mt(mark,prjtype,formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime，hour,type,remark,datasource,day,halfhour,month,mapsql, description,isused) "+
		"select 'gdzctb"+prjtype+"','"+prjtype+"',formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime，hour,type,remark,datasource,day,halfhour,month,mapsql, description,isused from uf_prj_syscptbus_mt where id=1";
		rs_dt.executeSql(sql_dt);
		String billid = "";
		sql_dt = "select id from uf_prj_syscptbus_mt where prjtype='"+prjtype+"' and type=0 and prjtype not in(1)";
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			billid = Util.null2String(rs_dt.getString("id"));
		}
		sql_dt="insert into uf_prj_syscptbus_mt_dt1(mainid,sysfiled,mapfield) select "+billid+",sysfiled,mapfield from uf_prj_syscptbus_mt_dt1 where mainid=1";
		rs_dt.executeSql(sql_dt);
	}
%>
