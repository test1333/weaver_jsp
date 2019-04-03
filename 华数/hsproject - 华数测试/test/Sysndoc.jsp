<%@ page import="weaver.general.Util" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="hsproject.impl.AddDocShare" %>
<%@ page import="hsproject.impl.ProjectInfoImpl" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%!

	public void sysndoc() {
		RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		String sql = "";
		String sql_dt = "";
		String prjid = "";
		String procode = "";
		String begindate = "";
		String xmprjid = "";
		sql="select id,procode,begindate from hs_projectinfo";
		rs.executeSql(sql);
		while(rs.next()) {
			prjid = Util.null2String(rs.getString("id"));
			procode = Util.null2String(rs.getString("procode"));
			begindate = Util.null2String(rs.getString("begindate"));
			sql_dt = "select id from wasu_projectbase where xmcode='"+procode+"' and sqrq='"+begindate+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()) {
				xmprjid = Util.null2String(rs_dt.getString("id"));
			}
			if("".equals(xmprjid)) {
				continue;
			}
			updatefile(prjid,xmprjid);
		}
	}
	 // pid.sysprocess();
%>
<%!
	public void updatefile(String prjid,String xmprjid) {
		RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		AddDocShare ads = new AddDocShare();
		String prjattach = "";
		String tableName2 = "uf_prj_check_doc";
		String modeId = "";
		String name = "";
		String type = "";
		String checktype = "";
		String attach = "";
		String cjr = "";
		String cjrq = "";
		String flag = ",";
		String sql_dt = "";
		String sql="select fileid from wasu_projfiles where projid="+xmprjid;
		rs.executeSql(sql);
		while(rs.next()) {
			if("".equals(prjattach)) {
				prjattach = Util.null2String(rs.getString("fileid"));
			}else {
				prjattach = prjattach+","+Util.null2String(rs.getString("fileid"));
			}
		}
		sql="update hs_projectinfo set attach='"+prjattach+"' where id="+prjid;
		rs.executeSql(sql);
		ads.addShare(prjid, prjattach);		
		
		
	}
	%>
	<%
		sysndoc();
		out.print("SUCCESS");
	%>

