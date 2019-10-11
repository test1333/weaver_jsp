<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="weaver.general.Util" %>
<%@page import="adore.attend.SyncAttendRecord" %>
<%@page import="adore.attend.DoAttendDataAll" %>

<%
    String attendDay = Util.null2String(request.getParameter("attendDay"));
    SyncAttendRecord.syncAttendRecord(attendDay);
    DoAttendDataAll.doAttendDataAll(attendDay);
    out.print("_____________SUCCESS!!");
%>

