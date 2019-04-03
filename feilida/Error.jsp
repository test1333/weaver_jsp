<%@ page import="weaver.general.Util" %>
<%@ page import="tmc.BringMainAndDetailByMain" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
	<%!

	public String getSub(String workflowId, String IV_DATUM){
	//	String workflowId = "1";
		java.util.Map<String, String> oaDatas = new java.util.HashMap<String, String>();
		oaDatas.put("IV_DATUM", IV_DATUM);

		tmc.BringMainAndDetailByMain bmb = new tmc.BringMainAndDetailByMain("1");
		String result = bmb.getReturn(oaDatas,workflowId);
		return result;
	}	

	//插入中间表
	public String doSub(String str){
		String sql = "";
		try {
			org.json.JSONObject json = new org.json.JSONObject(str);
			org.json.JSONArray jsonArr = json.getJSONObject("table").getJSONArray("main");	
			weaver.conn.RecordSet rs = new weaver.conn.RecordSet();
			
			for(int index=0;index<jsonArr.length();index++){
				org.json.JSONObject jsonx = (org.json.JSONObject)(jsonArr.get(index));
				
				// json的值是 tmc_sap_mapping 的OA字段
				//String OBJID = jsonx.getString("OBJID");
				//String SHORT = jsonx.getString("SHORT").replace("&","'||chr(38)||'");
				//String ZHBMM = jsonx.getString("ZHBMM");
				//String ZHBMS  = jsonx.getString("ZHBMS").replace("&","'||chr(38)||'");
				//String ZHZZLB = jsonx.getString("ZHZZLB");
				//String ZHZZLBMS = jsonx.getString("ZHZZLBMS");
				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return sql;
	}
	%>

	<%
	String str6 = getSub("1","0");
	out.println("sql(1)=" + str6+"<br>");
	String str1_sql = doSub(str6); out.println("str1_sql="+str1_sql+"<br>");
	out.println("---------------------------------人力资源插入成功----------------------------------------------------<br>");
	%>