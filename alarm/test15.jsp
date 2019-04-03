<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@page import="weaver.soa.workflow.request.*" %>
<%@page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
		String workflowID = "11";
		String creater = "88800503";
		String requestLevel = "0";
		String remindType = "0";
		String requestid = "";

		// 根据 workflowCode 查询实际的流程
		
		RequestInfo requestinfo = new RequestInfo();
		
		// 放主表数据
		MainTableInfo mti = new MainTableInfo();
		Property properties[] = new Property[2];
		Property property = new Property();
		property.setName("description");
		property.setValue("111");
		properties[0]=property;
		Property property1 = new Property();
		property1.setName("amount");
		property1.setValue("1112");
		properties[1]=property1;

		mti.setProperty(properties);
		
		// 存放明细表数据
		DetailTableInfo dti = new DetailTableInfo();
		requestinfo.setMainTableInfo(mti);
		requestinfo.setCreatorid(creater);
		requestinfo.setWorkflowid(workflowID);
		requestinfo.setIsNextFlow("0");
		requestinfo.setRequestlevel(requestLevel);
		requestinfo.setRemindtype(remindType);
		RequestService res=new RequestService();
		try {
			requestid =  res.createRequest(requestinfo);
		} catch (Exception e) {
			out.println("e = " + e.getMessage());
			e.printStackTrace();
		}
		out.println("requestid = "+ requestid);

%>