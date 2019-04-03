<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="tmc.BringMainAndDetailByMain" %>
<%@ page import="CHQ.InsertUtil" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%!
	public String getAlarmInfo(String alermID){
		String workflowId = "7";
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
	//	oaDatas.put("ID", alermID);

		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain();
		String result = bmb.getReturn(oaDatas,workflowId);
		return result;
	}
%>
<%!
	public String insertInto(String result){
			if(result.length() < 1) return "";
			String tableName = "uf_mainAlarm";
			String sql = "update uf_mainAlarm set active=1 where nvl(active,0)=0 ";
			weaver.conn.RecordSet rs1 = new weaver.conn.RecordSet();
			rs1.execute(sql);
			CHQ.InsertUtil iu = new CHQ.InsertUtil();
			try {
				org.json.JSONObject json = new org.json.JSONObject(result);
				org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
				weaver.conn.RecordSet rs = new weaver.conn.RecordSet();

				for(int index=0;index<jsonArr.length();index++){
					org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
					String TYPE = jsonx.getString("TYPE");
					String LANGU = jsonx.getString("LANGU");
					String KEY = jsonx.getString("KEY");
					String VALUE = jsonx.getString("VALUE");
					
					java.util.Map<String, String> mapStr = new java.util.HashMap<String, String>();
					
					mapStr.put("TYPE", TYPE);
					mapStr.put("LANGUAGE", LANGU);
					mapStr.put("CODE", KEY);
					mapStr.put("TEXT", VALUE);
					mapStr.put("active", "0");
					mapStr.put("operTime", "##to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')");
					
					iu.insert(mapStr,tableName);
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		return "S";
	}
%>

<%
	String alermID="Y";
	
	String result=getAlarmInfo(alermID);
	
	out.println("result=" + result+"<br>");
	
	out.println(" Start !!<br>");
	insertInto(result);
	out.println(" over !!<br>");
%>