<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.general.Util"%>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="FieldComInfo" class="weaver.workflow.field.FieldComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
 String  viewid=Util.null2String(request.getParameter("viewid"));
 String  setname=Util.null2String(request.getParameter("setname"));
 String  yanbiao=Util.null2String(request.getParameter("yanbiao"));
 String sql="";
 if(yanbiao.equals("yi")){  
	 if("".equals(viewid)){
		  sql="select * from zoa_wfcode_mapping where LC_TYPE='"+setname+"' and IsActive='1'";
	 }else{
		  sql="select * from zoa_wfcode_mapping where LC_TYPE='"+setname+"' and IsActive='1' and id not in ('"+viewid+"')";
	 }
	 rs.executeSql(sql);
	 if(rs.next()){
		 out.print("流程类型已存在，请重新填写!");
	 }else{
		 out.print("1");
	 }
 }else if(yanbiao.equals("er")){
	String LC_TYPE="";
	sql="select LC_TYPE from zoa_wfcode_mapping where id='"+viewid+"'";
	rs.executeSql(sql);
	if(rs.next()){
		LC_TYPE=Util.null2String(rs.getString("LC_TYPE"));
	 }
	sql="select * from zoa_wfcode_mapping where LC_TYPE='"+LC_TYPE+"' and IsActive='1' and id not in ('"+viewid+"')";
	rs.executeSql(sql);
	if(rs.next()){
		out.print("SAP流程类型已经存在活动的触发中，请使用新的SAP流程类型重新创建！");
	}else{
		out.print("1");
	}
	 
	 
	 
	 
	 
 }else if(yanbiao.equals("san")){
	 
	 
 }











%>
