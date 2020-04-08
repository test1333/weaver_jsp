<%@page language="java" contentType="application/x-msdownload" pageEncoding="UTF-8"%>
<%@ page import="com.fr.third.v2.org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="weaver.general.Util" %>

<%@ page import="kstjj.doc.report.*" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    String year = Util.null2String(request.getParameter("year"));
	String type = Util.null2String(request.getParameter("type"));
    String fileName = "导出.xls";
    HSSFWorkbook workbook = null;
    if("0".equals(type)){
     DocReportGetExcelForXm ce = new DocReportGetExcelForXm();
     workbook = ce.createExcel(year);
     fileName = "按姓名数量统计表.xls";
    }else if("1".equals(type)){
     DocReportGetExcelForKs ce = new DocReportGetExcelForKs();
     workbook = ce.createExcel(year);
     fileName = "按科室数量统计表.xls";
    }else if("2".equals(type)){
     DocReportGetExcelForYf ce = new DocReportGetExcelForYf();
     workbook = ce.createExcel(year);
     fileName = "按月份数量统计表.xls";
    }else if("3".equals(type)){
     DocReportGetExcelForLb ce = new DocReportGetExcelForLb();
     workbook = ce.createExcel(year);
     fileName = "按类别数量统计表.xls";
    }
  
    response.reset();
    out.clear();
    String file_name = URLEncoder.encode(fileName, "UTF-8");
    response.setContentType("application/octet-stream;charset=ISO8859-1");
//    response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
    response.setHeader("Content-disposition", "attachment;filename="+file_name);

    OutputStream os = response.getOutputStream();
    workbook.write(os);
    os.flush();
    os.close();

%>
