<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="APPDEV.HQ.DECODE.EncodeUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);

	String fmid = request.getParameter("fmid");
	String newfieldname = request.getParameter("newfieldname");
	String oldfieldname = request.getParameter("oldfieldname");
	String newfieldtype = request.getParameter("newfieldtype");
	String oldfieldtype = request.getParameter("oldfieldtype");
	String fielddbtype = "";
	String sql="select fielddbtype from workflow_billfield where billid="+fmid+" and Upper(fieldname)=Upper('"+oldfieldname+"')";
	rs.executeSql(sql);
	if(rs.next()){
		fielddbtype = Util.null2String(rs.getString("fielddbtype"));
	}else{
		out.print("字段"+oldfieldname+"在表中不存在，请检查");
		return;
	}
	if("clob".equals(fielddbtype) && !"0".equals(oldfieldtype)){
		out.print("取值字段类型不正确，请检查");
		return;
	}else if(!"clob".equals(fielddbtype) && "0".equals(oldfieldtype)){
		out.print("取值字段类型不正确，请检查");
		return;
	}
	sql="select fielddbtype from workflow_billfield where billid="+fmid+" and Upper(fieldname)=Upper('"+newfieldname+"')";
	rs.executeSql(sql);
	if(rs.next()){
		fielddbtype = Util.null2String(rs.getString("fielddbtype"));
	}else{
		out.print("字段"+newfieldname+"在表中不存在，请检查");
		return;
	}
	if("clob".equals(fielddbtype) && !"0".equals(newfieldtype)){
		out.print("赋值字段类型不正确，请检查");
		return;
	}else if(!"clob".equals(fielddbtype) && "0".equals(newfieldtype)){
		out.print("赋值字段类型不正确，请检查");
		return;
	}
	EncodeUtil eu = new EncodeUtil();
	eu.updateHistoryInfo(fmid,newfieldname,oldfieldname,newfieldtype,oldfieldtype);
	out.print("更新历史数据成功"); 
%>