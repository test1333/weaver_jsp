<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
    BaseBean log = new BaseBean();
    String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));
  sqlwhere = URLDecoder.decode(sqlwhere);
    log.writeLog("test aa sqlwhere:"+sqlwhere);
	ExcelFile.init();
	String fileName ="公司信息";
	ExcelFile.setFilename(fileName) ;
	ExcelStyle excelStyle = ExcelFile.newExcelStyle("Header");
	excelStyle.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
	excelStyle.setFontbold(ExcelStyle.WeaverHeaderFontbold);
	excelStyle.setAlign(ExcelStyle.WeaverHeaderAlign);
	ExcelSheet es = ExcelFile.newExcelSheet(fileName);
	ExcelRow er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("统一社会信用代码", "Header"); 
	er.addStringValue("公司名称（中文）", "Header"); 
    er.addStringValue("公司名称（英文）", "Header"); 
    er.addStringValue("公司简称", "Header"); 
    er.addStringValue("公司类型", "Header"); 
    er.addStringValue("公司状态", "Header"); 
    er.addStringValue("注销进展状态", "Header"); 
    er.addStringValue("业务类型", "Header"); 
    er.addStringValue("一级类别", "Header"); 
    er.addStringValue("法人板块", "Header"); 
    er.addStringValue("管理板块", "Header"); 
    er.addStringValue("产业大类", "Header"); 
    er.addStringValue("产业细类", "Header"); 
    er.addStringValue("子业态", "Header"); 
    er.addStringValue("国家", "Header"); 
    er.addStringValue("省份", "Header"); 
    er.addStringValue("城市", "Header"); 
    er.addStringValue("币种", "Header"); 
    er.addStringValue("持股比例（板块持有）", "Header"); 
    er.addStringValue("持股比例（集团持板块）", "Header"); 
    er.addStringValue("持股比例（集团最终）", "Header"); 
    er.addStringValue("协鑫方母公司层面", "Header"); 
    er.addStringValue("统一社会信用代码", "Header"); 
    er.addStringValue("注册地境内/境外", "Header"); 
    er.addStringValue("登记机关", "Header"); 
    er.addStringValue("投资总额", "Header"); 
    er.addStringValue("注册资本（万元）", "Header"); 
    er.addStringValue("实收资本（万元）", "Header"); 
    er.addStringValue("注册日期", "Header"); 
    er.addStringValue("核准日期", "Header"); 
    er.addStringValue("经营范围", "Header"); 
    er.addStringValue("注册地址", "Header"); 
    er.addStringValue("办公地址", "Header"); 
    er.addStringValue("经营期限方式", "Header"); 
    er.addStringValue("经营期限开始", "Header"); 
    er.addStringValue("经营期限结束", "Header"); 
    er.addStringValue("法定代表人", "Header"); 
    er.addStringValue("董事长", "Header"); 
    er.addStringValue("总经理", "Header"); 
    er.addStringValue("财务负责人", "Header"); 
    er.addStringValue("副董事长", "Header"); 
    er.addStringValue("公章-全称", "Header"); 
    er.addStringValue("保管人", "Header"); 
    er.addStringValue("实际存放地", "Header"); 
    er.addStringValue("保管部门", "Header"); 
    er.addStringValue("法人章-全称", "Header"); 
    er.addStringValue("保管人", "Header"); 
    er.addStringValue("实际存放地", "Header"); 
    er.addStringValue("保管部门", "Header"); 
    er.addStringValue("财务章-全称", "Header"); 
    er.addStringValue("保管人", "Header"); 
    er.addStringValue("实际存放地", "Header"); 
    er.addStringValue("保管部门", "Header"); 
    er.addStringValue("合同章-全称", "Header"); 
    er.addStringValue("保管人", "Header"); 
    er.addStringValue("实际存放地", "Header"); 
    er.addStringValue("保管部门", "Header"); 
    er.addStringValue("SAP公司编码", "Header"); 
    er.addStringValue("是否有账套", "Header"); 
    er.addStringValue("ERP系统", "Header"); 
    er.addStringValue("ERP系统编码", "Header"); 
    er.addStringValue("是否已接入财务共享", "Header"); 
    er.addStringValue("接入时间", "Header"); 
    er.addStringValue("注册类型", "Header"); 
    er.addStringValue("联络人", "Header"); 
    er = es.newExcelRow() ;
    er.addStringValue("123"); 
    er.addStringValue(sqlwhere); 
	out.print("1");
%>