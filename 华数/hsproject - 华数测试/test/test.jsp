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
	String sql = "select a.id as prjtype,b.id as processtype from uf_project_type a,uf_prj_process b where a.id=b.prjtype and a.id not in(1) ";
	rs.executeSql(sql);
	while(rs.next()){
		prjtype = Util.null2String(rs.getString("prjtype"));
		processtype = Util.null2String(rs.getString("processtype"));
		sql_dt	= "insert into uf_prj_porcessfield(formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,dsporder,iscommon,isedit,isreadonly,description,selectbutton,groupinfo,isused,ismust,isexists,projecttype,processtype,fieldname,showname,fieldtype,texttype,buttontype,textlength,floatdigit) "+
			"select formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,dsporder,iscommon,isedit,isreadonly,description,selectbutton,groupinfo,isused,ismust,isexists,"+prjtype+","+processtype+",fieldname,showname,fieldtype,texttype,buttontype,textlength,floatdigit from uf_prj_porcessfield where projecttype=1 and processtype=1";
		rs_dt.executeSql(sql_dt);
	}
%>
