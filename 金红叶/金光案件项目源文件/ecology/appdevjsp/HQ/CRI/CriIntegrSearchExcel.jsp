<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<%
String aj = Util.null2String(request.getParameter("aj"));
String person = Util.null2String(request.getParameter("person"));
String unit = Util.null2String(request.getParameter("unit"));
ExcelFile.init();
String fileName ="案件综合搜索";
ExcelFile.setFilename(fileName) ;
ExcelStyle excelStyle = ExcelFile.newExcelStyle("Header");
excelStyle.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
excelStyle.setFontbold(ExcelStyle.WeaverHeaderFontbold);
excelStyle.setAlign(ExcelStyle.WeaverHeaderAlign);
ExcelSheet es = ExcelFile.newExcelSheet(fileName);
ExcelRow er = es.newExcelRow() ;
er.addStringValue(SystemEnv.getHtmlLabelName(-11590, user.getLanguage()) , "Header"); //案件查询结果
er = es.newExcelRow() ;
er.addStringValue(SystemEnv.getHtmlLabelName(-11593, user.getLanguage()), "Header"); 
er.addStringValue(SystemEnv.getHtmlLabelName(-11594, user.getLanguage()), "Header"); 
er.addStringValue(SystemEnv.getHtmlLabelName(-10935, user.getLanguage()), "Header"); 
er.addStringValue(SystemEnv.getHtmlLabelName(-10936, user.getLanguage()), "Header"); 
er.addStringValue(SystemEnv.getHtmlLabelName(-11582, user.getLanguage()), "Header"); 

rs.executeSql(" select * from uf_ajzhss where uuid='"+aj+"' order by xmbh desc ");
while(rs.next()){
	String ajID=rs.getString("ajID");
	String xmbh=rs.getString("xmbh");
	String xmmc=rs.getString("xmmc");
	String dcqdrq=rs.getString("dcqdrq");
	String dcy=rs.getString("dcy");
	String mzzd=rs.getString("mzzd");
	er = es.newExcelRow() ;
	er.addStringValue(xmbh, ""); 
	er.addStringValue(xmmc, ""); 
	er.addStringValue(dcqdrq, ""); 
	er.addStringValue(dcy, ""); 
	er.addStringValue(mzzd, "");
}

rs.executeSql(" select t2.id, t2.xm , t1.mzzd from uf_ajzhss t1, uf_hq_cri_involpers t2  where t1.uuid='"+person+"' and t1.sary=t2.id  order by t1.xmbh desc ");
if(rs.getCounts()>0){
	er = es.newExcelRow() ;
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11591, user.getLanguage()) , "Header"); //涉案人员查询结果
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11125, user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11582, user.getLanguage()), "Header"); 
}
while(rs.next()){
	String xm=rs.getString("xm");
	String mzzd=rs.getString("mzzd");
	er = es.newExcelRow() ;
	er.addStringValue(xm,""); 
	er.addStringValue(mzzd,""); 
}

rs.executeSql(" select t2.id, t2.gsmc , t1.mzzd from uf_ajzhss t1, uf_hq_cri_involcomp t2 where t1.uuid='"+unit+"' and t1.sadw=t2.id  order by xmbh desc ");
if(rs.getCounts()>0){
	er = es.newExcelRow() ;
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11592, user.getLanguage()) , "Header"); //涉案单位查询结果
	er = es.newExcelRow() ;
	er.addStringValue(SystemEnv.getHtmlLabelName(-11126, user.getLanguage()), "Header"); 
	er.addStringValue(SystemEnv.getHtmlLabelName(-11582, user.getLanguage()), "Header"); 
}
while(rs.next()){
	String gsmc=rs.getString("gsmc");
	String mzzd=rs.getString("mzzd");
	er = es.newExcelRow() ;
	er.addStringValue(gsmc, ""); 
	er.addStringValue(mzzd, "");
}
out.print("ok");		
%>		
<%!
public String getLastname(String dcy){
	String dcyname="";
	if(!"".equals(dcy.trim())){
		RecordSet rs=new RecordSet();
		rs.executeSql(" select wm_concat(lastname) dcyname from hrmresource where workcode in ("+dcy+") ");
		if(rs.next()){
			dcyname=rs.getString("dcyname");
		}
	}
	return dcyname;
}
%>