<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.fr.third.org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="xerium.choosebank.excel.CreateExcel" %>

<%@ page import="java.io.OutputStream" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rci" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>

<%
    String dtId = Util.null2String(request.getParameter("ids"));//主键
    String fkyh = Util.null2String(request.getParameter("fkyh"));//付款银行id
    String fkrq = Util.null2String(request.getParameter("sjrq"));//付款日期
    CreateExcel ce = new CreateExcel();
    HSSFWorkbook workbook = ce.createExcel(dtId, fkyh, fkrq);
    response.reset();
    out.clear();
    String fileName = "付款清单" + System.currentTimeMillis() + ".xls"; //文件名
    String file_name = URLEncoder.encode(fileName, "UTF-8");
    response.setContentType("application/octet-stream;charset=ISO8859-1");
//    response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
    response.setHeader("Content-disposition", "attachment;filename="+file_name);

    OutputStream os = response.getOutputStream();
    workbook.write(os);
    os.flush();
    os.close();
%>
