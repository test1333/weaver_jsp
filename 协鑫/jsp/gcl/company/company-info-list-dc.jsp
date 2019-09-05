<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="gcl.company.CompanyChangeUtil" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>

<%
    BaseBean log = new BaseBean();
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    String tablenameYjlb = du.getBillTableName("GSYJLB");
    String tablenameFrbk = du.getBillTableName("GSFRBK");
    String tablenameGLBK = du.getBillTableName("GSGLBK");
    String tablenameCYDL = du.getBillTableName("GSCYDL");
    String tablenameCYXL = du.getBillTableName("GSCYXL");
    String tablenameZYT = du.getBillTableName("GSZYT");
    String tablenameCITY = du.getBillTableName("GSCITY");
    String tablenameBz = du.getBillTableName("GSBZ");
    String tablenameDJG = du.getBillTableName("DJG");
    String tablenameWbgd = du.getBillTableName("GSWBGD");
    CompanyChangeUtil ccu = new CompanyChangeUtil();
    String sqlwhere = Util.null2String(request.getParameter("sqlwhere"));
    log.writeLog("test aa sqlwhere1:"+sqlwhere);
    sqlwhere = URLDecoder.decode(URLDecoder.decode(sqlwhere));
    log.writeLog("test aa sqlwhere:"+sqlwhere);
	ExcelFile.init();
    String mainids = "";
    String flag = ",";
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
    String sql = "select id,tyshxydm,gsmc,gsmcyw,gsjc,(select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='gslx' and c.selectvalue=t.gslx )  as gslx,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='gszt' and c.selectvalue=t.gszt )  as gszt ,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='zxjzzt' and c.selectvalue=t.zxjzzt )  as zxjzzt ,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='ywlx' and c.selectvalue=t.ywlx )  as ywlx ,"+
                " (select yjlb from "+tablenameYjlb+" where id=t.yjlb) as yjlb,"+
                " (select bkmc from "+tablenameFrbk+" where id=t.frbk) as frbk,"+
                " (select bkmc from "+tablenameGLBK+" where id=t.glbk) as glbk,"+
                " (select dlmc from "+tablenameCYDL+" where id=t.cydl) as cydl,"+
                " (select cyxl from "+tablenameCYXL+" where id=t.cyxl) as cylx,"+
                " (select zyt from "+tablenameZYT+" where id=t.zyt) as zyt,guojia,shengfeng,"+
                " (select cs from "+tablenameCITY+" where id=t.city) as city,"+
                " (select bz from "+tablenameBz+" where id=t.zczbbz) as zczbbz,cgblbk,cgbljt,cggbljtzz,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='xxfmgscm' and c.selectvalue=t.xxfmgscm )  as xxfmgscm ,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='zcdjnw' and c.selectvalue=t.zcdjnw )  as zcdjnw, djjg,tzze,zczbwy,sszb,zcrq,hzrq,jyfw,zcdz,bgdz,"+
                " (select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='jyqxxzfs' and c.selectvalue=t.jyqxxzfs )  as jyqxxzfs ,jyqxks,jyqxjs,"+
                " (select xm from "+tablenameDJG+" where id=t.fddbr) as fddbr,"+
                " (select xm from "+tablenameDJG+" where id=t.dsz) as dsz,"+
                " (select xm from "+tablenameDJG+" where id=t.zjl) as zjl,"+
                " (select xm from "+tablenameDJG+" where id=t.cwfzr) as cwfzr,fdsz,sapgsbm,sfyzt,erpxt,erpxtbm,sfyjrcwgx,jrsj,zclx,cwllr"+
                 " from "+tablename+" t where "+sqlwhere+" order by id desc";
    rs.executeSql(sql);
    int count = 1;
    while(rs.next()){
        mainids = mainids+flag+Util.null2String(rs.getString("id"));
        flag = ",";
        er = es.newExcelRow() ;
        er.addStringValue(count+""); 
        er.addStringValue(Util.null2String(rs.getString("tyshxydm"))); 
        er.addStringValue(Util.null2String(rs.getString("gsmc"))); 
        er.addStringValue(Util.null2String(rs.getString("gsmcyw"))); 
        er.addStringValue(Util.null2String(rs.getString("gsjc")));
        er.addStringValue(Util.null2String(rs.getString("gslx")));
        er.addStringValue(Util.null2String(rs.getString("gszt")));
        er.addStringValue(Util.null2String(rs.getString("zxjzzt")));
        er.addStringValue(Util.null2String(rs.getString("ywlx")));
        er.addStringValue(Util.null2String(rs.getString("yjlb")));
        er.addStringValue(Util.null2String(rs.getString("frbk")));
        er.addStringValue(Util.null2String(rs.getString("glbk")));
        er.addStringValue(Util.null2String(rs.getString("cydl")));
        er.addStringValue(Util.null2String(rs.getString("cyxl")));
        er.addStringValue(Util.null2String(rs.getString("zyt")));
        er.addStringValue(Util.null2String(rs.getString("guojia")));
        er.addStringValue(Util.null2String(rs.getString("shengfeng")));
        er.addStringValue(Util.null2String(rs.getString("city")));
        er.addStringValue(Util.null2String(rs.getString("zczbbz")));
        er.addStringValue(Util.null2String(rs.getString("cgblbk")));
        er.addStringValue(Util.null2String(rs.getString("cgbljt")));
        er.addStringValue(Util.null2String(rs.getString("cggbljtzz")));
        er.addStringValue(Util.null2String(rs.getString("xxfmgscm")));
        er.addStringValue(Util.null2String(rs.getString("zcdjnw")));    
        er.addStringValue(Util.null2String(rs.getString("djjg")));
        er.addStringValue(Util.null2String(rs.getString("tzze")));
        er.addStringValue(Util.null2String(rs.getString("zczbwy")));
        er.addStringValue(Util.null2String(rs.getString("sszb")));
        er.addStringValue(Util.null2String(rs.getString("zcrq")));
        er.addStringValue(Util.null2String(rs.getString("hzrq")));
        er.addStringValue(Util.null2String(rs.getString("jyfw")));
        er.addStringValue(Util.null2String(rs.getString("zcdz")));
        er.addStringValue(Util.null2String(rs.getString("bgdz")));
        er.addStringValue(Util.null2String(rs.getString("jyqxxzfs")));
        er.addStringValue(Util.null2String(rs.getString("jyqxks")));
        er.addStringValue(Util.null2String(rs.getString("jyqxjs")));
        er.addStringValue(Util.null2String(rs.getString("fddbr")));
        er.addStringValue(Util.null2String(rs.getString("dsz")));
        er.addStringValue(Util.null2String(rs.getString("zjl")));
        er.addStringValue(Util.null2String(rs.getString("cwfzr")));
        er.addStringValue(Util.null2String(rs.getString("fdsz")));
        er.addStringValue(Util.null2String(rs.getString("sapgsbm")));
        er.addStringValue(Util.null2String(rs.getString("sfyzt")));
        er.addStringValue(Util.null2String(rs.getString("erpxt")));
        er.addStringValue(Util.null2String(rs.getString("erpxtbm")));
        er.addStringValue(Util.null2String(rs.getString("sfyjrcwgx")));
        er.addStringValue(Util.null2String(rs.getString("jrsj")));
        er.addStringValue(Util.null2String(rs.getString("zclx")));
        er.addStringValue(new ResourceComInfo().getLastnames(Util.null2String(rs.getString("cwllr"))));
        count++;
    }
    es = ExcelFile.newExcelSheet("股东信息");
    er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("公司名称", "Header"); 
	er.addStringValue("投资方", "Header"); 
    er.addStringValue("外部或自然人股东", "Header"); 
    er.addStringValue("投资比例(%)", "Header"); 
    er.addStringValue("认缴金额", "Header"); 
    if(!"".equals(mainids)){
         count = 1;
         String mainidarr[] = mainids.split(",");
         for(String mainid : mainidarr){
             sql = "select a.gsmc,(select gsmc from "+tablename+" where id=b.tzf) as tzf,(select mc from "+tablenameWbgd+" where id=b.wbhzrrgd) as wbhzrrgd,tzbl,rjcze  from "+tablename+" a,"+tablename+"_dt1 b where a.id=b.mainid and b.mainid="+mainid;
             rs.execute(sql);
             while(rs.next()){
                 er = es.newExcelRow() ;
                 er.addStringValue(count+""); 
                 er.addStringValue(Util.null2String(rs.getString("gsmc"))); 
                 er.addStringValue(Util.null2String(rs.getString("tzf"))); 
                 er.addStringValue(Util.null2String(rs.getString("wbhzrrgd"))); 
                 er.addStringValue(Util.null2String(rs.getString("tzbl")));
                 er.addStringValue(Util.null2String(rs.getString("rjcze")));
                 count++;
             }
         }
         
    }
    es = ExcelFile.newExcelSheet("董监高");
    er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("公司名称", "Header"); 
	er.addStringValue("董事/监事", "Header"); 
    er.addStringValue("类型", "Header"); 
    er.addStringValue("开始日期", "Header"); 
    er.addStringValue("结束日期", "Header"); 
    if(!"".equals(mainids)){
         count = 1;
         String mainidarr[] = mainids.split(",");
         for(String mainid : mainidarr){
             sql = "select a.gsmc,(select xm from "+tablenameDJG+" where id=b.ds) as ds,ksrq,jsrq  from "+tablename+" a,"+tablename+"_dt2 b where a.id=b.mainid and b.mainid="+mainid;
             rs.execute(sql);
             while(rs.next()){
                 er = es.newExcelRow() ;
                 er.addStringValue(count+""); 
                 er.addStringValue(Util.null2String(rs.getString("gsmc"))); 
                 er.addStringValue(Util.null2String(rs.getString("ds"))); 
                 er.addStringValue("董事"); 
                 er.addStringValue(Util.null2String(rs.getString("ksrq")));
                 er.addStringValue(Util.null2String(rs.getString("jsrq")));
                 count++;
             }
             sql = "select a.gsmc,(select xm from "+tablenameDJG+" where id=b.js) as js,ksrq,jsrq   from "+tablename+" a,"+tablename+"_dt3 b where a.id=b.mainid and b.mainid="+mainid;
             rs.execute(sql);
             while(rs.next()){
                 er = es.newExcelRow() ;
                 er.addStringValue(count+""); 
                 er.addStringValue(Util.null2String(rs.getString("gsmc"))); 
                 er.addStringValue(Util.null2String(rs.getString("js"))); 
                 er.addStringValue("监事"); 
                 er.addStringValue(Util.null2String(rs.getString("ksrq")));
                 er.addStringValue(Util.null2String(rs.getString("jsrq")));
                 count++;
             }
         }
         
    }
	out.print("1");
%>