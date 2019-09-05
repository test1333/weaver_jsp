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
    er.addStringValue("SAP��˾����", "Header"); 
    er.addStringValue("�Ƿ�������", "Header"); 
    er.addStringValue("ERPϵͳ", "Header"); 
    er.addStringValue("ERPϵͳ����", "Header"); 
    er.addStringValue("�Ƿ��ѽ��������", "Header"); 
    er.addStringValue("����ʱ��", "Header"); 
    er.addStringValue("ע������", "Header"); 
    er.addStringValue("������", "Header"); 
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
    es = ExcelFile.newExcelSheet("�ɶ���Ϣ");
    er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("��˾����", "Header"); 
	er.addStringValue("Ͷ�ʷ�", "Header"); 
    er.addStringValue("�ⲿ����Ȼ�˹ɶ�", "Header"); 
    er.addStringValue("Ͷ�ʱ���(%)", "Header"); 
    er.addStringValue("�Ͻɽ��", "Header"); 
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
    es = ExcelFile.newExcelSheet("�����");
    er = es.newExcelRow() ;
	er.addStringValue("ID", "Header"); 
    er.addStringValue("��˾����", "Header"); 
	er.addStringValue("����/����", "Header"); 
    er.addStringValue("����", "Header"); 
    er.addStringValue("��ʼ����", "Header"); 
    er.addStringValue("��������", "Header"); 
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
                 er.addStringValue("����"); 
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
                 er.addStringValue("����"); 
                 er.addStringValue(Util.null2String(rs.getString("ksrq")));
                 er.addStringValue(Util.null2String(rs.getString("jsrq")));
                 count++;
             }
         }
         
    }
	out.print("1");
%>