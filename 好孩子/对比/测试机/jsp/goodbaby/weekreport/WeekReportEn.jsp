<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="goodbaby.weekreport.CreateDocFileEn" %>
<%@ page import="goodbaby.weekreport.GetWeekDay" %>

<%
    
		String docid = "";
        Date date = new Date();
        GetWeekDay gwd = new GetWeekDay();
        String year = gwd.getYear(date);
        String week = String.format("%02d", gwd.getWeek(date));
        CreateDocFileEn cdf = new CreateDocFileEn();
        try {
            docid = cdf.getDocId(year +" Weekly "+ week + " - Region China","1","94");
        } catch (Exception e) {
            e.printStackTrace();
        }
		out.print(docid);
	

%>


