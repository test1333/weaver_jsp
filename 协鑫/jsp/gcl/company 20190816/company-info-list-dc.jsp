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
	String fileName ="��˾��Ϣ";
	ExcelFile.setFilename(fileName) ;
	ExcelStyle excelStyle = ExcelFile.newExcelStyle("Header");
	excelStyle.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
	excelStyle.setFontbold(ExcelStyle.WeaverHeaderFontbold);
	excelStyle.setAlign(ExcelStyle.WeaverHeaderAlign);
	ExcelSheet es = ExcelFile.newExcelSheet(fileName);
	ExcelRow er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("ͳһ������ô���", "Header"); 
	er.addStringValue("��˾���ƣ����ģ�", "Header"); 
    er.addStringValue("��˾���ƣ�Ӣ�ģ�", "Header"); 
    er.addStringValue("��˾���", "Header"); 
    er.addStringValue("��˾����", "Header"); 
    er.addStringValue("��˾״̬", "Header"); 
    er.addStringValue("ע����չ״̬", "Header"); 
    er.addStringValue("ҵ������", "Header"); 
    er.addStringValue("һ�����", "Header"); 
    er.addStringValue("���˰��", "Header"); 
    er.addStringValue("������", "Header"); 
    er.addStringValue("��ҵ����", "Header"); 
    er.addStringValue("��ҵϸ��", "Header"); 
    er.addStringValue("��ҵ̬", "Header"); 
    er.addStringValue("����", "Header"); 
    er.addStringValue("ʡ��", "Header"); 
    er.addStringValue("����", "Header"); 
    er.addStringValue("����", "Header"); 
    er.addStringValue("�ֹɱ����������У�", "Header"); 
    er.addStringValue("�ֹɱ��������ųְ�飩", "Header"); 
    er.addStringValue("�ֹɱ������������գ�", "Header"); 
    er.addStringValue("Э�η�ĸ��˾����", "Header"); 
    er.addStringValue("ͳһ������ô���", "Header"); 
    er.addStringValue("ע��ؾ���/����", "Header"); 
    er.addStringValue("�Ǽǻ���", "Header"); 
    er.addStringValue("Ͷ���ܶ�", "Header"); 
    er.addStringValue("ע���ʱ�����Ԫ��", "Header"); 
    er.addStringValue("ʵ���ʱ�����Ԫ��", "Header"); 
    er.addStringValue("ע������", "Header"); 
    er.addStringValue("��׼����", "Header"); 
    er.addStringValue("��Ӫ��Χ", "Header"); 
    er.addStringValue("ע���ַ", "Header"); 
    er.addStringValue("�칫��ַ", "Header"); 
    er.addStringValue("��Ӫ���޷�ʽ", "Header"); 
    er.addStringValue("��Ӫ���޿�ʼ", "Header"); 
    er.addStringValue("��Ӫ���޽���", "Header"); 
    er.addStringValue("����������", "Header"); 
    er.addStringValue("���³�", "Header"); 
    er.addStringValue("�ܾ���", "Header"); 
    er.addStringValue("��������", "Header"); 
    er.addStringValue("�����³�", "Header"); 
    er.addStringValue("����-ȫ��", "Header"); 
    er.addStringValue("������", "Header"); 
    er.addStringValue("ʵ�ʴ�ŵ�", "Header"); 
    er.addStringValue("���ܲ���", "Header"); 
    er.addStringValue("������-ȫ��", "Header"); 
    er.addStringValue("������", "Header"); 
    er.addStringValue("ʵ�ʴ�ŵ�", "Header"); 
    er.addStringValue("���ܲ���", "Header"); 
    er.addStringValue("������-ȫ��", "Header"); 
    er.addStringValue("������", "Header"); 
    er.addStringValue("ʵ�ʴ�ŵ�", "Header"); 
    er.addStringValue("���ܲ���", "Header"); 
    er.addStringValue("��ͬ��-ȫ��", "Header"); 
    er.addStringValue("������", "Header"); 
    er.addStringValue("ʵ�ʴ�ŵ�", "Header"); 
    er.addStringValue("���ܲ���", "Header"); 
    er.addStringValue("SAP��˾����", "Header"); 
    er.addStringValue("�Ƿ�������", "Header"); 
    er.addStringValue("ERPϵͳ", "Header"); 
    er.addStringValue("ERPϵͳ����", "Header"); 
    er.addStringValue("�Ƿ��ѽ��������", "Header"); 
    er.addStringValue("����ʱ��", "Header"); 
    er.addStringValue("ע������", "Header"); 
    er.addStringValue("������", "Header"); 
    er = es.newExcelRow() ;
    er.addStringValue("123"); 
    er.addStringValue(sqlwhere); 
	out.print("1");
%>