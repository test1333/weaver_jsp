<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);

	/*
	code 2001:requestid未找到
	code 2002:流程未找到
	code 2003:字段未找到
	*/
	JSONObject ot_json = new JSONObject();
	String requestid_def = request.getParameter("requestid_def");
	if("".equals(requestid_def)){
		ot_json.put("status", "error");
		ot_json.put("code", "2001");
	}else{
		String formid="";
		String sql=" select formid From workflow_base where id in (select workflowid from workflow_requestbase where requestid ="+requestid_def+")";
		rs.execute(sql);
		if(rs.next()){
			formid = Util.null2String(rs.getString("formid"));
		}
		
		if("".equals(formid)){
			ot_json.put("status", "error");
			ot_json.put("code", "2002");
		}else{
			JSONObject field_json = new JSONObject();
			sql =" select filedname,ftype from uf_des_mapping_dt1 where mainid in (select id from uf_des_mapping where isactive =0 and workflowid="+formid+") ";
			rs_dt.execute(sql);
			while(rs_dt.next()){
				String filedname = Util.null2String(rs_dt.getString("filedname"));
				String ftype = Util.null2String(rs_dt.getString("ftype"));
				field_json.put(filedname,ftype);
			}

			if("".equals(field_json.toString())){
				ot_json.put("status", "error");
				ot_json.put("code", "2003");	
			}else{
				ot_json.put("status", "success");
				ot_json.put("code",field_json);		
			}
		}

    }

	out.print(ot_json.toString()); 
%>