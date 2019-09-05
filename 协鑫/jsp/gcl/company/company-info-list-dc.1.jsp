<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="gcl.company.CompanyChangeUtil" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
    BaseBean log = new BaseBean();
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    CompanyChangeUtil ccu = new CompanyChangeUtil();
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
    er.addStringValue("SAP公司编码", "Header"); 
    er.addStringValue("是否有账套", "Header"); 
    er.addStringValue("ERP系统", "Header"); 
    er.addStringValue("ERP系统编码", "Header"); 
    er.addStringValue("是否已接入财务共享", "Header"); 
    er.addStringValue("接入时间", "Header"); 
    er.addStringValue("注册类型", "Header"); 
    er.addStringValue("联络人", "Header"); 
    String sql = "select * from "+tablename+" where "+sqlwhere+" order by id desc";
    rs.executeSql(sql);
    int count = 1;
    while(rs.next()){
        er = es.newExcelRow() ;
        er.addStringValue(count+""); 
        er.addStringValue(Util.null2String(rs.getString("tyshxydm"))); 
        er.addStringValue(Util.null2String(rs.getString("gsmc"))); 
        er.addStringValue(Util.null2String(rs.getString("gsmcyw"))); 
        er.addStringValue(Util.null2String(rs.getString("gsjc")));
        er.addStringValue(ccu.getSelectNameMain(tablename,"gslx",Util.null2String(rs.getString("gslx"))));
        er.addStringValue(ccu.getSelectNameMain(tablename,"gszt",Util.null2String(rs.getString("gszt"))));
        er.addStringValue(ccu.getSelectNameMain(tablename,"zxjzzt",Util.null2String(rs.getString("zxjzzt"))));
        er.addStringValue(ccu.getSelectNameMain(tablename,"ywlx",Util.null2String(rs.getString("ywlx"))));
        er.addStringValue(ccu.getYjlb(Util.null2String(rs.getString("yjlb"))));
        er.addStringValue(ccu.getFrbk(Util.null2String(rs.getString("frbk"))));
        er.addStringValue(ccu.getGlbk(Util.null2String(rs.getString("glbk"))));
        er.addStringValue(ccu.getCydl(Util.null2String(rs.getString("cydl"))));
        er.addStringValue(ccu.getCyxl(Util.null2String(rs.getString("cyxl"))));
        er.addStringValue(ccu.getZyt(Util.null2String(rs.getString("zyt"))));
        er.addStringValue(Util.null2String(rs.getString("guojia")));
        er.addStringValue(Util.null2String(rs.getString("shengfeng")));
        er.addStringValue(ccu.getCityName(Util.null2String(rs.getString("city"))));
        er.addStringValue(ccu.getBzName(Util.null2String(rs.getString("zczbbz"))));
        er.addStringValue(Util.null2String(rs.getString("cgblbk")));
        er.addStringValue(Util.null2String(rs.getString("cgbljt")));
        er.addStringValue(Util.null2String(rs.getString("cggbljtzz")));
        er.addStringValue(ccu.getSelectNameMain(tablename,"xxfmgscm",Util.null2String(rs.getString("xxfmgscm"))));
        er.addStringValue(ccu.getSelectNameMain(tablename,"zcdjnw",Util.null2String(rs.getString("zcdjnw"))));    
        er.addStringValue(Util.null2String(rs.getString("djjg")));
        er.addStringValue(Util.null2String(rs.getString("tzze")));
        er.addStringValue(Util.null2String(rs.getString("zczbwy")));
        er.addStringValue(Util.null2String(rs.getString("sszb")));
        er.addStringValue(Util.null2String(rs.getString("zcrq")));
        er.addStringValue(Util.null2String(rs.getString("hzrq")));
        er.addStringValue(Util.null2String(rs.getString("jyfw")));
        er.addStringValue(Util.null2String(rs.getString("zcdz")));
        er.addStringValue(Util.null2String(rs.getString("bgdz")));
        er.addStringValue(ccu.getSelectNameMain(tablename,"jyqxxzfs",Util.null2String(rs.getString("jyqxxzfs"))));
        er.addStringValue(Util.null2String(rs.getString("jyqxks")));
        er.addStringValue(Util.null2String(rs.getString("jyqxjs")));
        er.addStringValue(ccu.getDJGXM(Util.null2String(rs.getString("fddbr"))));
        er.addStringValue(ccu.getDJGXM(Util.null2String(rs.getString("dsz"))));
        er.addStringValue(ccu.getDJGXM(Util.null2String(rs.getString("zjl"))));
        er.addStringValue(ccu.getDJGXM(Util.null2String(rs.getString("cwfzr"))));
        er.addStringValue(Util.null2String(rs.getString("fdsz")));
        er.addStringValue(Util.null2String(rs.getString("sapgsbm")));
        er.addStringValue(Util.null2String(rs.getString("sfyzt")));
        er.addStringValue(Util.null2String(rs.getString("erpxt")));
        er.addStringValue(Util.null2String(rs.getString("erpxtbm")));
        er.addStringValue(Util.null2String(rs.getString("sfyjrcwgx")));
        er.addStringValue(Util.null2String(rs.getString("jrsj")));
        er.addStringValue(Util.null2String(rs.getString("zclx")));
        er.addStringValue(Util.null2String(rs.getString("cwllr")));
        count++;
    }
   
	out.print("1");
%>