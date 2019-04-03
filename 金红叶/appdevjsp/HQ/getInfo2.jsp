<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.workflow.request.RequestCheckAddinRules" %>
	<%@page import="weaver.hrm.User"%>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
	<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>

<%
    RequestCheckAddinRules requestCheckAddinRules = new RequestCheckAddinRules();
          requestCheckAddinRules.resetParameter();

          requestCheckAddinRules.setTrack(true);//是否记录
          requestCheckAddinRules.setStart(true);//是否已流转
          requestCheckAddinRules.setNodeid(3213);//节点id

          requestCheckAddinRules.setRequestid(14355);//
          requestCheckAddinRules.setWorkflowid(1503);
          requestCheckAddinRules.setObjid(3213);//节点的id或者出口的id
          requestCheckAddinRules.setObjtype(1);//1：objid为节点id  0：objid为出口id
          //select workflowtype,formid,isbill,messageType,isModifyLog from workflow_base where id=1503
          requestCheckAddinRules.setIsbill(1);//是否为单据
          requestCheckAddinRules.setFormid(-304);
          requestCheckAddinRules.setIspreadd("1"); //1：节点前附加操作  0：节点后附加操作
          requestCheckAddinRules.setRequestManager(null);
          requestCheckAddinRules.setUser(user);
          requestCheckAddinRules.checkAddinRules();
%>