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
    String fysqlc = request.getParameter("fysqlc");
	 StringBuffer sb = new StringBuffer();
	 
	 String id="";
	 String mc="";
	 String km="";
	 String bxje="";
	 String xsxs="";
	 String wsxe="";
	 String hhao="";
	 String zfgs1="";
	 String sql="select b.id,b.mc,b.km,b.bxje,b.xsxs,b.wsxe,b.hhao,b.zfgs1 from formtable_main_50 a ,formtable_main_50_dt1 b where a.id=b.mainid and a.requestid='"+fysqlc+"' ";
     String sql_dt="";
    rs.executeSql(sql);
	while(rs.next()){
         id = Util.null2String(rs.getString("id"));
		 mc  = Util.null2String(rs.getString("mc"));
		 km = Util.null2String(rs.getString("km"));
		 bxje=Util.null2String(rs.getString("bxje"));
		 xsxs=Util.null2String(rs.getString("xsxs"));
		 wsxe=Util.null2String(rs.getString("wsxe"));
		  hhao=Util.null2String(rs.getString("hhao"));
		  zfgs1=Util.null2String(rs.getString("zfgs1"));
		sb.append(id);
		sb.append("###");
		sb.append(id);	
		sb.append("###");
		sb.append(mc);	
		sb.append("###");
		sb.append(km);	
		
		String kmname="";
		if(!"".equals(km)){
			sql_dt="select name from fnabudgetfeetype where id="+km;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				kmname  = Util.null2String(rs_dt.getString("name"));
			}
		}
		sb.append("###");
		sb.append(kmname);
		sb.append("###");
		sb.append(bxje);	
		sb.append("###");
		sb.append(xsxs);	
		sb.append("###");
		sb.append(wsxe);		
		sb.append("###");
		sb.append(hhao);	
		String chdm="";
		if(!"".equals(hhao)){
			sql_dt="select chdm from uf_SKUdangan where id="+hhao;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				chdm  = Util.null2String(rs_dt.getString("chdm"));
			}
		}
		sb.append("###");
		sb.append(chdm);

		sb.append("###");
		sb.append(zfgs1);	
		//String selectname="";
		//if(!"".equals(zfgs1)){
		//	sql_dt="select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='formtable_main_50' and a.fieldname='zfgs1' and a.detailtable='formtable_main_50_dt1' and selectvalue='"+zfgs1+"'";
		//	rs_dt.executeSql(sql_dt);
		//	if(rs_dt.next()){
		//		selectname  = Util.null2String(rs_dt.getString("selectname"));
		//	}
		//}
		//sb.append("###");
		//sb.append(selectname);
		sb.append("###");
		sb.append(bxje);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>