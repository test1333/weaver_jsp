<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
    BaseBean log = new BaseBean();
	 log.writeLog("校验目录"+request.getParameter("mlmc"));
	String sjml_val =  Util.null2String(request.getParameter("sjml"));
	 String mlmc_val =  Util.null2String(request.getParameter("mlmc"));
	 String sql="";
	 int count=0;
	 String flag="0";
	 sql="select count(id) from DocSecCategory where categoryname = '"+mlmc_val+"'";
     if("".equals(sjml_val)){
        sql = sql + " and (parentid is null or parentid<=0) "; 
	 }else{
		 sql = sql + " and parentid="+sjml_val; 
	 }
	  log.writeLog("校验目录sql"+sql);
	  RecordSet.executeSql(sql);
	  if(RecordSet.next()){
		  count = RecordSet.getInt(1);
	  }
		if(count >0){
         flag = "1";
		}

	out.print(flag);
%>