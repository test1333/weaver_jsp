<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
    String gsid = request.getParameter("gsid");
	   RecordSet rs1= new RecordSet();
	    RecordSet rs_dt1= new RecordSet();
	   String flag = "0";
	 	String tablename="";//表名
		String zdm="";//字段名
		String keyzd="";//关键字段
		String kmm="";//科目名
		String url = "";//连接URL
		String glbm = "";//关联表名
		String glzd = "";//关联字段
		String glbmkey = "";//关联表key
		String urlzd = "";//Url字段
		String sfmxb = "";//是否明细表
		String jmxsbm = "";
		String jmxszdm = "";
		String jmxskey = "";
		String jmxsglzd = "";		
		String kmm_dt="";
		String name_dt="";
		String url_dt="";
		String sql="select * from uf_delcontact_table";
		StringBuffer sb= new StringBuffer();
		String sql_dt="";
		rs1.executeSql(sql);
		while(rs1.next()){
			String query="";
			tablename = Util.null2String(rs1.getString("tablename"));
			zdm = Util.null2String(rs1.getString("zdm"));
			keyzd = Util.null2String(rs1.getString("keyzd"));
			kmm = Util.null2String(rs1.getString("kmm"));
			url = Util.null2String(rs1.getString("url"));
			glbm = Util.null2String(rs1.getString("glbm"));
			glzd = Util.null2String(rs1.getString("glzd"));
			glbmkey = Util.null2String(rs1.getString("glbmkey"));
			urlzd = Util.null2String(rs1.getString("urlzd"));
			sfmxb = Util.null2String(rs1.getString("sfmxb"));
			jmxsbm = Util.null2String(rs1.getString("jmxsbm"));
			jmxszdm = Util.null2String(rs1.getString("jmxszdm"));
			jmxskey = Util.null2String(rs1.getString("jmxskey"));
			jmxsglzd = Util.null2String(rs1.getString("jmxsglzd"));
		
			if("1".equals(sfmxb)){
				query="select '"+kmm+"' as kmm from "+glbm+" a,"+tablename+" b " +
								"where a."+glbmkey+"=b."+glzd+" and   ','+CAST(b."+zdm+" as varchar(8000))+','   like '%,"+gsid+",%'";
			
			}else{
				query="select '"+kmm+"' as kmm  from "+tablename+"  a where  ','+CAST(a."+zdm+" as varchar(8000))+','   like '%,"+gsid+",%'";
			
			}
			sql_dt="select count(1) as count from ( "+query+") a";
			
			rs_dt1.executeSql(sql_dt);
			int count=0;
			if(rs_dt1.next()){
				count = rs_dt1.getInt("count");
			}
			if(count > 0){
				flag= "1";
				break;
			}
		}
		out.print(flag);

   
%>
