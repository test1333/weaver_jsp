<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="weaver.general.Util" %>
<%@ page import="weaver.formmode.setup.ModeRightInfo" %>

<%
    String formmodeid = Util.null2String(request.getParameter("formmodeid"));
    int modeid = Integer.parseInt(formmodeid);
    String dataid = Util.null2String(request.getParameter("id"));
    // 表单建模数据权限重构
    ModeRightInfo modeRightInfo = new ModeRightInfo();
    modeRightInfo.editModeDataShare(1, modeid, Integer.parseInt(dataid));
    modeRightInfo.editModeDataShareForModeField(1, modeid, Integer.parseInt(dataid));
    out.print("_____________modeid="+modeid);
    out.print("_____________dataid="+dataid);
    out.print("_____________SUCCESS!!");
%>

