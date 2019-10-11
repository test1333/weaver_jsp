<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="goodbaby.weekreport.CreateDocFileZh" %>
<%@ page import="goodbaby.weekreport.GetWeekDay" %>
<%@ page import="goodbaby.weekreport.ArbtoChinese" %>

<%
    
		String docid = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        GetWeekDay we = new GetWeekDay();
        Date date = new Date();
        int num = we.getWeek(date);
        String year= we.getYear(date);
        ArbtoChinese ac = new ArbtoChinese();
        String week = ac.convert(num);
        CreateDocFileZh cdf = new CreateDocFileZh();
        try {
            docid = cdf.getDocId(year + "第" + week + "周周报-中国区","1","93");
        } catch (Exception e) {
           e.printStackTrace();
        }
		out.print(docid);
	

%>


