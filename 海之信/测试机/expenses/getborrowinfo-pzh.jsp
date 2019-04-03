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
    String jkrid = Util.null2String(request.getParameter("jkrid"));
	String bz_1 =  Util.null2String(request.getParameter("bz1"));
    String jkksrq =  Util.null2String(request.getParameter("jkksrq"));
	  String jkjsrq =  Util.null2String(request.getParameter("jkjsrq"));
	  String lcdh =  Util.null2String(request.getParameter("lcdh"));
	   String pzh =  Util.null2String(request.getParameter("pzh"));
	 StringBuffer sb = new StringBuffer();
	 
	 String bz="";
	 String jkje = "";
	 String pzhm = "";
	 String jkdqr = "";
	 String jksm = "";
	 String jkid="";
	  String sql="";
	if("0".equals(bz_1)){
	 sql="select bz,jkje,pzhm,jkdqr,jksm,id from uf_personal_borrow where   bz='0' ";
	}else{
		  sql="select bz,jkje,pzhm,jkdqr,jksm,id from uf_personal_borrow where    bz<>'0' ";
	}
	if(!"".equals(jkrid)){
		sql=sql+" and  jkr in ("+jkrid+") ";
	}
	if(!"".equals(jkksrq)){
		sql=sql+" and jkrq>='"+jkksrq+"'";
	}
	if(!"".equals(jkjsrq)){
		sql=sql+" and jkrq<='"+jkjsrq+"'";
	}
	if(!"".equals(lcdh)){
		sql=sql+" and xglc='"+lcdh+"'";
	}
	if(!"".equals(pzh)){
		sql=sql+" and pzhm like '%"+pzh+"%'";
	}
	sql=sql+" order by id desc ";
    rs.executeSql(sql);
	int i=1;
	while(rs.next()){
	  if(i>=100){
		  break;
	  }
         bz = Util.null2String(rs.getString("bz"));
		 jkje = Util.null2String(rs.getString("jkje"));
		 pzhm = Util.null2String(rs.getString("pzhm"));
		 jkdqr = Util.null2String(rs.getString("jkdqr"));
		 jksm = Util.null2String(rs.getString("jksm"));
		 jkid = Util.null2String(rs.getString("id"));
		
		  
		sb.append(bz);
		sb.append("###");
		sb.append(jkje);
		sb.append("###");
		sb.append(pzhm);
		sb.append("###");
		sb.append(jkdqr);
		sb.append("###");
		sb.append(jksm);
		sb.append("###");
		sb.append(jkid);
		sb.append("@@@");
			i=i+1;
	}

	out.print(sb.toString()); 
%>