<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="weaver.general.Util,weaver.file.*" %>
<%@ page import="java.util.*,weaver.hrm.common.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%!
	public String getdocName(String sid){
		String reName = "";
		String flag="";
		String sql="";
		RecordSet recordSet = new RecordSet();
		 String[] ids = sid.split(",");
		 for(String id:ids){
		   reName=reName+flag;
		   sql= "select docsubject from DocDetail where id ="+id;
		   recordSet.executeSql(sql);
		   if(recordSet.next()) {
		   	reName = reName+Util.null2String(recordSet.getString("docsubject"));			
		   }
		   flag=",";
		 }         		
		flag="";
		return reName;
	}
%>
<%!
	public String getdocRead(String sid){
		String reName = "";
		String sql="";
		RecordSet recordSet = new RecordSet();
		 String[] ids = sid.split(",");
		 for(String id:ids){		   
		   sql= "select docsubject from DocDetail where id ="+id;
		   recordSet.executeSql(sql);
		   if(recordSet.next()) {
		    reName=reName+"<a href=\"javascript:opendoc("+id+")\">"+Util.null2String(recordSet.getString("docsubject"))+"</a>     ";		   			
		   }
		   
		 }      
		return reName;
	}
%>
<%!
	public String getSupplierName(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select name from uf_supplier where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName = Util.null2String(recordSet.getString("name"));
		}
		return reName;
	}
%>
<%!
	public String getSupplierNameRead(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select name from uf_supplier where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName ="<a href=\"javascript:openSupplier("+sid+")\">"+Util.null2String(recordSet.getString("name"))+"</a>"; 
		}
		return reName;
	}
%>
<%!
	public String getProName(String sid){
		String reName = "";
		RecordSet recordSet = new RecordSet();
		String sql = "select goodsname from uf_goodsinfo where id='"+sid+"'";
		recordSet.executeSql(sql);
		if(recordSet.next()) {
			reName = Util.null2String(recordSet.getString("goodsname"));
		}
		return reName;
	}
%>

<%  
BaseBean jspLog = new BaseBean();  
String imagefilename = "/images/hdHRMCard_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(21590,user.getLanguage());
String deRemark =  (String)session.getAttribute("deRemark");

int userid  = user.getUID();

String pro_name = "";
String Numbers = "";
String Stock = "";
String AvgPrice = "";
String reID = "";

String supplier_01 = "";
String supplier_02 = "";
String supplier_03 = "";
String price_01 = "";
String price_02 = "";
String price_03 = "";
String selCheck1 = "";
String selCheck2 = "";
String selCheck3 = "";

String supplier_01_02 = "";
String supplier_01_03 = "";
String supplier_01_04 = "";
String price_01_02 = "";
String price_01_03 = "";
String price_01_04 = "";
String selCheck_01_02 = "";
String selCheck_01_03 = "";
String selCheck_01_04 = "";

String supplier_02_02 = "";
String supplier_02_03 = "";
String supplier_02_04 = "";
String price_02_02 = "";
String price_02_03 = "";
String price_02_04 = "";
String selCheck_02_02 = "";
String selCheck_02_03 = "";
String selCheck_02_04 = "";

String supplier_03_02 = "";
String supplier_03_03 = "";
String supplier_03_04 = "";
String price_03_02 = "";
String price_03_03 = "";
String price_03_04 = "";
String selCheck_03_02 = "";
String selCheck_03_03 = "";
String selCheck_03_04 = "";

String remark01 = "";
String remark02 = "";
String remark03 = "";

String brand101 = "";String brand102 = "";String brand103 = "";String brand104 = "";
String brand201 = "";String brand202 = "";String brand203 = "";String brand204 = "";
String brand301 = "";String brand302 = "";String brand303 = "";String brand304 = "";

String bxfw101 = "";String bxfw102 = "";String bxfw103 = "";String bxfw104 = "";
String bxfw201 = "";String bxfw202 = "";String bxfw203 = "";String bxfw204 = "";
String bxfw301 = "";String bxfw302 = "";String bxfw303 = "";String bxfw304 = "";

String xbnf101 = "";String xbnf102 = "";String xbnf103 = "";String xbnf104 = "";
String xbnf201 = "";String xbnf202 = "";String xbnf203 = "";String xbnf204 = "";
String xbnf301 = "";String xbnf302 = "";String xbnf303 = "";String xbnf304 = "";

String model101 = "";String model102 = "";String model103 = "";String model104 = "";
String model201 = "";String model202 = "";String model203 = "";String model204 = "";
String model301 = "";String model302 = "";String model303 = "";String model304 = "";

String conf101 = "";String conf102 = "";String conf103 = "";String conf104 = "";
String conf201 = "";String conf202 = "";String conf203 = "";String conf204 = "";
String conf301 = "";String conf302 = "";String conf303 = "";String conf304 = "";

String seq101 = "";String seq102 = "";String seq103 = "";
String seq201 = "";String seq202 = "";String seq203 = "";
String seq301 = "";String seq302 = "";String seq303 = "";

String Spec101 = "";String Spec102 = "";String Spec103 = "";
String Spec201 = "";String Spec202 = "";String Spec203 = "";
String Spec301 = "";String Spec302 = "";String Spec303 = "";

String guar101 = "";String guar102 = "";String guar103 = "";String guar104 = "";
String guar201 = "";String guar202 = "";String guar203 = "";String guar204 = "";
String guar301 = "";String guar302 = "";String guar303 = "";String guar304 = "";

String Discount101 = "";String Discount102 = "";String Discount103 = "";String Discount104 = "";
String Discount201 = "";String Discount202 = "";String Discount203 = "";String Discount204 = "";
String Discount301 = "";String Discount302 = "";String Discount303 = "";String Discount304 = "";

String original101 = "";String original102 = "";String original103 = "";String original104 = "";
String original201 = "";String original202 = "";String original203 = "";String original204 = "";
String original301 = "";String original302 = "";String original303 = "";String original304 = "";

String zxwd101 = "";String zxwd102 = "";String zxwd103 = "";String zxwd104 = "";
String zxwd201 = "";String zxwd202 = "";String zxwd203 = "";String zxwd204 = "";
String zxwd301 = "";String zxwd302 = "";String zxwd303 = "";String zxwd304 = "";

String remark = "";
String lastPrice = "";
String AvgNum = "";

boolean isUpdate = false;
String tmp_sql = "select count(id) as count_cc from uf_inquiryPrice where deRemark="+deRemark;
RecordSet.executeSql(tmp_sql);
if(RecordSet.next()) {
	int flag_s = RecordSet.getInt("count_cc");
	if(flag_s > 0) isUpdate = true;
}

if(isUpdate){
	String sql = "select * from uf_inquiryPrice where deRemark="+deRemark;
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		pro_name = Util.null2String(RecordSet.getString("proName"));
	//	Numbers = Util.null2String(RecordSet.getString("forNum"));
//		Stock = Util.null2String(RecordSet.getString("Stock"));
//		AvgPrice = Util.null2String(RecordSet.getString("threeAvg"));
		reID = Util.null2String(RecordSet.getString("reID"));
//		lastPrice = Util.null2String(RecordSet.getString("lastPrice"));
//		AvgNum = Util.null2String(RecordSet.getString("AvgNum"));
		
		//  第一个节点信息
		supplier_01 = Util.null2String(RecordSet.getString("supplier1"));
		supplier_02 = Util.null2String(RecordSet.getString("supplier2"));
		supplier_03 = Util.null2String(RecordSet.getString("supplier3"));
		price_01 = Util.null2String(RecordSet.getString("price1"));
		price_02 = Util.null2String(RecordSet.getString("price2"));
		price_03 = Util.null2String(RecordSet.getString("price3"));
		selCheck1 = Util.null2String(RecordSet.getString("selCheck1"));
		selCheck2 = Util.null2String(RecordSet.getString("selCheck2"));
		selCheck3 = Util.null2String(RecordSet.getString("selCheck3"));
		
		supplier_01_02 = Util.null2String(RecordSet.getString("supplier102"));
		supplier_01_03 = Util.null2String(RecordSet.getString("supplier103"));
		supplier_01_04 = Util.null2String(RecordSet.getString("supplier104"));
		price_01_02 = Util.null2String(RecordSet.getString("price102"));
		price_01_03 = Util.null2String(RecordSet.getString("price103"));
		price_01_04 = Util.null2String(RecordSet.getString("price104"));
		selCheck_01_02 = Util.null2String(RecordSet.getString("selCheck102"));
		selCheck_01_03 = Util.null2String(RecordSet.getString("selCheck103"));
		selCheck_01_04 = Util.null2String(RecordSet.getString("selCheck104"));

		supplier_02_02 = Util.null2String(RecordSet.getString("supplier202"));
		supplier_02_03 = Util.null2String(RecordSet.getString("supplier203"));
		supplier_02_04 = Util.null2String(RecordSet.getString("supplier204"));
		price_02_02 = Util.null2String(RecordSet.getString("price202"));
		price_02_03 = Util.null2String(RecordSet.getString("price203"));
		price_02_04 = Util.null2String(RecordSet.getString("price204"));
		selCheck_02_02 = Util.null2String(RecordSet.getString("selCheck202"));
		selCheck_02_03 = Util.null2String(RecordSet.getString("selCheck203"));
		selCheck_02_04 = Util.null2String(RecordSet.getString("selCheck204"));
		
		supplier_03_02 = Util.null2String(RecordSet.getString("supplier302"));
		supplier_03_03 = Util.null2String(RecordSet.getString("supplier303"));
		supplier_03_04 = Util.null2String(RecordSet.getString("supplier304"));
		price_03_02 = Util.null2String(RecordSet.getString("price302"));
		price_03_03 = Util.null2String(RecordSet.getString("price303"));
		price_03_04 = Util.null2String(RecordSet.getString("price304"));
		selCheck_03_02 = Util.null2String(RecordSet.getString("selCheck302"));
		selCheck_03_03 = Util.null2String(RecordSet.getString("selCheck303"));
		selCheck_03_04 = Util.null2String(RecordSet.getString("selCheck304"));
		
		remark01 = Util.null2String(RecordSet.getString("remark01"));
		remark02 = Util.null2String(RecordSet.getString("remark02"));
		remark03 = Util.null2String(RecordSet.getString("remark03"));
		
		remark = Util.null2String(RecordSet.getString("remark"));
		
		brand101 = Util.null2String(RecordSet.getString("brand101"));
		brand102 = Util.null2String(RecordSet.getString("brand102"));
		brand103 = Util.null2String(RecordSet.getString("brand103"));
		brand104 = Util.null2String(RecordSet.getString("brand104"));
		brand201 = Util.null2String(RecordSet.getString("brand201"));
		brand202 = Util.null2String(RecordSet.getString("brand202"));
		brand203 = Util.null2String(RecordSet.getString("brand203"));
		brand204 = Util.null2String(RecordSet.getString("brand204"));
		brand301 = Util.null2String(RecordSet.getString("brand301"));
		brand302 = Util.null2String(RecordSet.getString("brand302"));
		brand303 = Util.null2String(RecordSet.getString("brand303"));
		brand304 = Util.null2String(RecordSet.getString("brand304"));

		bxfw101 = Util.null2String(RecordSet.getString("bxfw101"));
		bxfw102 = Util.null2String(RecordSet.getString("bxfw102"));
		bxfw103 = Util.null2String(RecordSet.getString("bxfw103"));
		bxfw104 = Util.null2String(RecordSet.getString("bxfw104"));
		bxfw201 = Util.null2String(RecordSet.getString("bxfw201"));
		bxfw202 = Util.null2String(RecordSet.getString("bxfw202"));
		bxfw203 = Util.null2String(RecordSet.getString("bxfw203"));
		bxfw204 = Util.null2String(RecordSet.getString("bxfw204"));
		bxfw301 = Util.null2String(RecordSet.getString("bxfw301"));
		bxfw302 = Util.null2String(RecordSet.getString("bxfw302"));
		bxfw303 = Util.null2String(RecordSet.getString("bxfw303"));
		bxfw304 = Util.null2String(RecordSet.getString("bxfw304"));

		xbnf101 = Util.null2String(RecordSet.getString("xbnf101"));
		xbnf102 = Util.null2String(RecordSet.getString("xbnf102"));
		xbnf103 = Util.null2String(RecordSet.getString("xbnf103"));
		xbnf104 = Util.null2String(RecordSet.getString("xbnf104"));
		xbnf201 = Util.null2String(RecordSet.getString("xbnf201"));
		xbnf202 = Util.null2String(RecordSet.getString("xbnf202"));
		xbnf203 = Util.null2String(RecordSet.getString("xbnf203"));
		xbnf204 = Util.null2String(RecordSet.getString("xbnf204"));
		xbnf301 = Util.null2String(RecordSet.getString("xbnf301"));
		xbnf302 = Util.null2String(RecordSet.getString("xbnf302"));
		xbnf303 = Util.null2String(RecordSet.getString("xbnf303"));
		xbnf304 = Util.null2String(RecordSet.getString("xbnf304"));
		
		model101 = Util.null2String(RecordSet.getString("model101"));
		model102 = Util.null2String(RecordSet.getString("model102"));
		model103 = Util.null2String(RecordSet.getString("model103"));
		model104 = Util.null2String(RecordSet.getString("model104"));
		model201 = Util.null2String(RecordSet.getString("model201"));
		model202 = Util.null2String(RecordSet.getString("model202"));
		model203 = Util.null2String(RecordSet.getString("model203"));
		model204 = Util.null2String(RecordSet.getString("model204"));
		model301 = Util.null2String(RecordSet.getString("model301"));
		model302 = Util.null2String(RecordSet.getString("model302"));
		model303 = Util.null2String(RecordSet.getString("model303"));
		model304 = Util.null2String(RecordSet.getString("model304"));
		conf101 = Util.null2String(RecordSet.getString("conf101"));
		conf102 = Util.null2String(RecordSet.getString("conf102"));
		conf103 = Util.null2String(RecordSet.getString("conf103"));
		conf104 = Util.null2String(RecordSet.getString("conf104"));
		conf201 = Util.null2String(RecordSet.getString("conf201"));
		conf202 = Util.null2String(RecordSet.getString("conf202"));
		conf203 = Util.null2String(RecordSet.getString("conf203"));
		conf204 = Util.null2String(RecordSet.getString("conf204"));
		conf301 = Util.null2String(RecordSet.getString("conf301"));
		conf302 = Util.null2String(RecordSet.getString("conf302"));
		conf303 = Util.null2String(RecordSet.getString("conf303"));
		conf304 = Util.null2String(RecordSet.getString("conf304"));
		seq101 = Util.null2String(RecordSet.getString("seq101"));
		seq102 = Util.null2String(RecordSet.getString("seq102"));
		seq103 = Util.null2String(RecordSet.getString("seq103"));
		seq201 = Util.null2String(RecordSet.getString("seq201"));
		seq202 = Util.null2String(RecordSet.getString("seq202"));
		seq203 = Util.null2String(RecordSet.getString("seq203"));
		seq301 = Util.null2String(RecordSet.getString("seq301"));
		seq302 = Util.null2String(RecordSet.getString("seq302"));
		seq303 = Util.null2String(RecordSet.getString("seq303"));
		Spec101 = Util.null2String(RecordSet.getString("Spec101"));
		Spec102 = Util.null2String(RecordSet.getString("Spec102"));
		Spec103 = Util.null2String(RecordSet.getString("Spec103"));
		Spec201 = Util.null2String(RecordSet.getString("Spec201"));
		Spec202 = Util.null2String(RecordSet.getString("Spec202"));
		Spec203 = Util.null2String(RecordSet.getString("Spec203"));
		Spec301 = Util.null2String(RecordSet.getString("Spec301"));
		Spec302 = Util.null2String(RecordSet.getString("Spec302"));
		Spec303 = Util.null2String(RecordSet.getString("Spec303"));
		guar101 = Util.null2String(RecordSet.getString("guar101"));
		guar102 = Util.null2String(RecordSet.getString("guar102"));
		guar103 = Util.null2String(RecordSet.getString("guar103"));
		guar104 = Util.null2String(RecordSet.getString("guar104"));
		guar201 = Util.null2String(RecordSet.getString("guar201"));
		guar202 = Util.null2String(RecordSet.getString("guar202"));
		guar203 = Util.null2String(RecordSet.getString("guar203"));
		guar204 = Util.null2String(RecordSet.getString("guar204"));
		guar301 = Util.null2String(RecordSet.getString("guar301"));
		guar302 = Util.null2String(RecordSet.getString("guar302"));
		guar303 = Util.null2String(RecordSet.getString("guar303"));
		guar304 = Util.null2String(RecordSet.getString("guar304"));
		Discount101 = Util.null2String(RecordSet.getString("Discount101"));
		Discount102 = Util.null2String(RecordSet.getString("Discount102"));
		Discount103 = Util.null2String(RecordSet.getString("Discount103"));
		Discount104 = Util.null2String(RecordSet.getString("Discount104"));
		Discount201 = Util.null2String(RecordSet.getString("Discount201"));
		Discount202 = Util.null2String(RecordSet.getString("Discount202"));
		Discount203 = Util.null2String(RecordSet.getString("Discount203"));
		Discount204 = Util.null2String(RecordSet.getString("Discount204"));
		Discount301 = Util.null2String(RecordSet.getString("Discount301"));
		Discount302 = Util.null2String(RecordSet.getString("Discount302"));
		Discount303 = Util.null2String(RecordSet.getString("Discount303"));
		Discount304 = Util.null2String(RecordSet.getString("Discount304"));
		original101 = Util.null2String(RecordSet.getString("original101"));
		original102 = Util.null2String(RecordSet.getString("original102"));
		original103 = Util.null2String(RecordSet.getString("original103"));
		original104 = Util.null2String(RecordSet.getString("original104"));
		original201 = Util.null2String(RecordSet.getString("original201"));
		original202 = Util.null2String(RecordSet.getString("original202"));
		original203 = Util.null2String(RecordSet.getString("original203"));
		original204 = Util.null2String(RecordSet.getString("original204"));
		original301 = Util.null2String(RecordSet.getString("original301"));
		original302 = Util.null2String(RecordSet.getString("original302"));
		original303 = Util.null2String(RecordSet.getString("original303"));
		original304 = Util.null2String(RecordSet.getString("original304"));
		
		zxwd101 = Util.null2String(RecordSet.getString("zxwd101"));
		zxwd102 = Util.null2String(RecordSet.getString("zxwd102"));
		zxwd103 = Util.null2String(RecordSet.getString("zxwd103"));
		zxwd104 = Util.null2String(RecordSet.getString("zxwd104"));
		zxwd201 = Util.null2String(RecordSet.getString("zxwd201"));
		zxwd202 = Util.null2String(RecordSet.getString("zxwd202"));
		zxwd203 = Util.null2String(RecordSet.getString("zxwd203"));
		zxwd204 = Util.null2String(RecordSet.getString("zxwd204"));
		zxwd301 = Util.null2String(RecordSet.getString("zxwd301"));
		zxwd302 = Util.null2String(RecordSet.getString("zxwd302"));
		zxwd303 = Util.null2String(RecordSet.getString("zxwd303"));
		zxwd304 = Util.null2String(RecordSet.getString("zxwd304"));

	}
}else{
	String sql = " select Name,Numbers,Stock,AvgPrice,Supplier,SupplierPrice,lastPrice,AvgNum from  formtable_main_73_dt1 where val_1="+deRemark;
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		pro_name = Util.null2String(RecordSet.getString("Name"));
		Numbers = Util.null2String(RecordSet.getString("Numbers"));
		Stock = Util.null2String(RecordSet.getString("Stock"));
		AvgPrice = Util.null2String(RecordSet.getString("AvgPrice"));
		lastPrice = Util.null2String(RecordSet.getString("lastPrice"));
		AvgNum = Util.null2String(RecordSet.getString("AvgNum"));
	}
	
	sql = " select requestId from formtable_main_73 where id in(select max(mainid) from formtable_main_73_dt1 where val_1="+deRemark+")";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		reID = Util.null2String(RecordSet.getString("requestId"));
	}
}

if(Stock.length() < 1){
	String sql = "select sum(num) as sum_Stock from uf_goodsinforecord where infoid ="+pro_name+" and isnull(status,0) = 0 ";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		Stock = Util.null2String(RecordSet.getString("sum_Stock"));
	}
}
if(AvgPrice.length() < 1){
	String sql = "select convert(decimal(10,2),avg(s.price)) price from (select top 3 price from uf_outinrecord "
	+"where operaterecord=0 and origin=3 and goodsname in(select id from uf_goodsinforecord where infoid="+pro_name+")order by operatetime desc)s ";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		AvgPrice = Util.null2String(RecordSet.getString("price"));
	}
}
if(lastPrice.length() < 1){
	String sql = "select max(num) as sun_num from all_out_goods_view where goodsname in(select id from uf_goodsinforecord where infoid="+pro_name+")";
	jspLog.writeLog("sql = " + sql);
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		lastPrice = Util.null2String(RecordSet.getString("sun_num"));
	}
}
if(AvgNum.length() < 1){
	String sql = "select price from uf_outinrecord where id in(select MAX(id) from uf_outinrecord  where  operaterecord=0 and origin=3 "
		+"and goodsname in(select id from uf_goodsinforecord where infoid="+pro_name+") )  ";
	RecordSet.executeSql(sql);
	if(RecordSet.next()) {
		AvgNum = Util.null2String(RecordSet.getString("price"));
	}
}
if(lastPrice.length() < 1){
	lastPrice = "0";
}

int roleID = Integer.parseInt(session.getAttribute("roleID").toString());
String roleid2 = Util.null2String(request.getParameter("roleid2"));
if(!"".equals(roleid2)){
  roleID = Integer.parseInt(roleid2);

}

String recipient = "";
String needfav ="1";
String needhelp ="";
%>
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<style>
.btn_2k3
{
    border-right: #002D96 1px solid;
    padding-right: 2px;
    border-top: #002D96 1px solid;
    padding-left: 2px;
    font-size: 12px;
    FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,  StartColorStr=#FFFFFF,  EndColorStr=#9DBCEA);
    border-left: #002D96 1px solid;
    cursor: hand;
    color: black;
    padding-top: 2px;
    border-bottom: #002D96 1px solid;
}

</style>
<style type="text/css"> 
	body,table{ 
		font-size:12px; 
	} 
	table{ 
		table-layout:fixed; 
		empty-cells:show; 
		border-collapse: collapse; 
		margin:0 auto; 
	} 
	td{ 
		height:30px; 
	} 
	h1,h2,h3{ 
		font-size:12px; 
		margin:0; 
		padding:0; 
	} 
	.table{ 
		border:1px solid #cad9ea; 
		color:#666; 
	} 
	.table th { 
		background-repeat:repeat-x; 
		height:30px; 
		background-color:rgb(231, 243, 252);
	} 
	.table td,.table th{ 
		border:1px solid #cad9ea; 
		padding:0 1em 0; 
	} 
	.table tr.alter{ 
		background-color:rgb(231,243,252); 
	} 
</style> 	

<script language="javascript" src="/js/weaver_wev8.js"></script>
</HEAD>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if(roleID < 7 ){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	RCMenu += "{保存并返回,javascript:onSave1(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
}
RCMenu += "{返回,javascript:onSave2(),_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<form id=frmmain name=frmmain method=post action="supplierPriceOper.jsp">
	<input id="classDesc" type="hidden" name="deRemark" value="<%=deRemark%>" />
	<input id="classDesc" type="hidden" name="reID" value="<%=reID%>" />
	<input id="classDesc" type="hidden" name="savaType" />
	<input id="classDesc" type="hidden" name="roleID" value="<%=roleID%>" />
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<%if(roleID < 5 ){%>
     		<input type="button" value="保持" class="e8_btn_top_first" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;width:70px;height:30px;font-size:15px;" onclick="onSave();"/>
	 		<input type="button" value="保存并返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:100px;height:30px;font-size:15px;" onclick="onSave1();"/>
			<%}%>
			<input type="button" value="返回" class="e8_btn_top" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 100px;width:70px;height:30px;font-size:15px;" onclick="onSave2();"/>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>

<wea:layout type="4col" attributes="{'cw1':'16%','cw2':'28%','cw3':'28%','cw4':'28%'}">
	<wea:group context="商品信息" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>商品名称</wea:item>
		<wea:item><%=getProName(pro_name)%><input id="classDesc" type="hidden" name="pro_name" value="<%=pro_name%>" />	</wea:item>
	</wea:group>
</wea:layout>

<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商1" attributes="{'class':'e8_title'}">
	<wea:item>供应商名称(1)	</wea:item>
	<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="supplier_01" browserValue="<%=supplier_01 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_01),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand101" value="<%=brand101%>"></td>
					<td><input size=17 name="model101" value="<%=model101%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf101"><%=conf101%></textarea></td>				
					<td><input size=17 name="guar101" value="<%=guar101%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw101"><%=bxfw101%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf101" value="<%=xbnf101%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				</tr>
			</table>
		</wea:item>
	<%}%>
	<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
		<wea:item>
			<%=Util.toScreen(getSupplierNameRead(supplier_01),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand101%></td>
					<td><%=model101%></td>
					<td><%=model101%></td>
					<td><%=guar101%></td>
					<td><%=bxfw101%></td>
					<td><%=xbnf101%></td>
				</tr>
			</table>
		</wea:item>
	<%}%>
   	 <%if(roleID == 2){%>
	    <wea:item><brow:browser viewType="0"  name="supplier_01_02" browserValue="<%=supplier_01_02 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_01_02),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand102" value="<%=brand102%>"></td>
					<td><input size=17 name="model102" value="<%=model102%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf102"><%=conf102%></textarea></td>
					<td><input size=17 name="guar102" value="<%=guar102%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw102"><%=bxfw102%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf102" value="<%=xbnf102%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				</tr>
			</table>
		</wea:item>
	   <%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%>
			<wea:item><%=Util.toScreen(getSupplierNameRead(supplier_01_02),user.getLanguage())%>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand102%></td>
					<td><%=model102%></td>
					<td><%=conf102%></td>
					<td><%=guar102%></td>
					<td><%=bxfw102%></td>
					<td><%=xbnf102%></td>
				</tr>
			</table>
				</wea:item>
		<%}%>
	   	<%if(roleID == 3){%>
		<wea:item><brow:browser viewType="0"  name="supplier_01_03" browserValue="<%=supplier_01_03 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_01_03),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand103" value="<%=brand103%>"></td>
					<td><input size=17 name="model103" value="<%=model103%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf103"><%=conf103%></textarea></td>
					<td><input size=17 name="guar103" value="<%=guar103%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw103"><%=bxfw103%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf103" value="<%=xbnf103%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				</tr>
			</table>
		</wea:item>
	<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%>
			<wea:item><%=Util.toScreen(getSupplierNameRead(supplier_01_03),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand103%></td>
					<td><%=model103%></td>
					<td><%=conf103%></td>
					<td><%=guar103%></td>
					<td><%=bxfw103%></td>
					<td><%=xbnf103%></td>
				</tr>
			</table>
				</wea:item>
		<%}%>
		<%if(roleID == 4){%>
		<wea:item><brow:browser viewType="0"  name="supplier_01_04" browserValue="<%=supplier_01_04 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_01_04),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand104" value="<%=brand104%>"></td>
					<td><input size=17 name="model104" value="<%=model104%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf104"><%=conf104%></textarea></td>
					<td><input size=17 name="guar104" value="<%=guar104%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw104"><%=bxfw104%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf104" value="<%=xbnf104%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				</tr>
			</table>
		</wea:item>
	<%}%>
		<%if(roleID == 41  || roleID == 19){%>
			<wea:item><%=Util.toScreen(getSupplierNameRead(supplier_01_04),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand104%></td>
					<td><%=model104%></td>
					<td><%=conf104%></td>
					<td><%=guar104%></td>
					<td><%=bxfw104%></td>
					<td><%=xbnf104%></td>
				</tr>
			</table>
				</wea:item>
		<%}%>

		<wea:item>供应商单价(1)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original101" value="<%=original101%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount101"><%=Discount101%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_01" value="<%=price_01%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				    <td >
						<brow:browser viewType="0"  name="zxwd101" browserValue="<%=zxwd101 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd101),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
				
			</table>	
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%>
			<wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original101%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount101%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_01%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd101),user.getLanguage())%></td>
				</tr>
			</table></wea:item>
		<%}%>
   	 	<%if(roleID == 2){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original102" value="<%=original102%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>										
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount102"><%=Discount102%></textarea></td>
				   	<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_01_02" value="<%=price_01_02%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				 <td >
						<brow:browser viewType="0"  name="zxwd102" browserValue="<%=zxwd102 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd102),user.getLanguage())%>">
						</brow:browser>	
				    </td>					
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
			    <tr>					
					<td>挂牌单价</td>
					<td><%=original102%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount102%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_01_02%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd102),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original103" value="<%=original103%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount103"><%=Discount103%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_01_03" value="<%=price_01_03%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				    <td>
						<brow:browser viewType="0"  name="zxwd103" browserValue="<%=zxwd103 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd103),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original103%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount103%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_01_03%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd103),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 4){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original104" value="<%=original104%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount104"><%=Discount104%></textarea></td>
				     <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_01_04" value="<%=price_01_04%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				<td>
						<brow:browser viewType="0"  name="zxwd104" browserValue="<%=zxwd104 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd104),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original104%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount104%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_01_04%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd104),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<wea:item>选择该供应商(1)</wea:item><!-- 是否启用 -->
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck1" name="selCheck1" value="1" <%if(selCheck1.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%if(selCheck1.equals("1"))out.println("选中");%></wea:item><%}%>
   	 	<%if(roleID == 2){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_01_02" name="selCheck_01_02" value="1" <%if(selCheck_01_02.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><%if(selCheck_01_02.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_01_03" name="selCheck_01_03" value="1" <%if(selCheck_01_03.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><%if(selCheck_01_03.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 4){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_01_04" name="selCheck_01_04" value="1" <%if(selCheck_01_04.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><%if(selCheck_01_04.equals("1"))out.println("选中");%></wea:item><%}%>
	</wea:group>
</wea:layout>
					
<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商2" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>供应商名称(2)	</wea:item>
		<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="supplier_02" browserValue="<%=supplier_02 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_02),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand201" value="<%=brand201%>"></td>
					<td><input size=17 name="model201" value="<%=model201%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf201"><%=conf201%></textarea></td>
					<td><input size=17 name="guar201" value="<%=guar201%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw201"><%=bxfw201%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf201" value="<%=xbnf201%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>	
				</tr>
			</table>
			</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_02),user.getLanguage())%>
				<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand201%></td>
					<td><%=model201%></td>
					<td><%=conf201%></td>
					<td><%=guar201%></td>
					<td><%=bxfw201%></td>
					<td><%=xbnf201%></td>
				</tr>
			</table>
				</wea:item><%}%>
   	 	<%if(roleID == 2){%>
	    <wea:item><brow:browser viewType="0"  name="supplier_02_02" browserValue="<%=supplier_02_02 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_02_02),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand202" value="<%=brand202%>"></td>
					<td><input size=17 name="model202" value="<%=model202%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf202"><%=conf202%></textarea></td>
					<td><input size=17 name="guar202" value="<%=guar202%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw202"><%=bxfw202%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf202" value="<%=xbnf202%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_02_02),user.getLanguage())%>
				<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand202%></td>
					<td><%=model202%></td>
					<td><%=conf202%></td>
					<td><%=guar202%></td>
					<td><%=bxfw202%></td>
					<td><%=xbnf202%></td>
				</tr>
			</table>
				</wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item><brow:browser viewType="0"  name="supplier_02_03" browserValue="<%=supplier_02_03 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_02_03),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand203" value="<%=brand203%>"></td>
					<td><input size=17 name="model203" value="<%=model203%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf203"><%=conf203%></textarea></td>
					<td><input size=17 name="guar203" value="<%=guar203%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw203"><%=bxfw203%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf203" value="<%=xbnf203%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_02_03),user.getLanguage())%>
				<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand203%></td>
					<td><%=model203%></td>
					<td><%=conf203%></td>
					<td><%=guar203%></td>
					<td><%=bxfw203%></td>
					<td><%=xbnf203%></td>
				</tr>
			</table>
				</wea:item><%}%>

	    <%if(roleID == 4){%>
		<wea:item><brow:browser viewType="0"  name="supplier_02_04" browserValue="<%=supplier_02_04 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_02_04),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand204" value="<%=brand204%>"></td>
					<td><input size=17 name="model204" value="<%=model204%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf204"><%=conf204%></textarea></td>
					<td><input size=17 name="guar204" value="<%=guar204%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw204"><%=bxfw204%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf204" value="<%=xbnf204%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_02_04),user.getLanguage())%>
				<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand204%></td>
					<td><%=model204%></td>
					<td><%=conf204%></td>
					<td><%=guar204%></td>
					<td><%=bxfw204%></td>
					<td><%=xbnf204%></td>
				</tr>
			</table>
				</wea:item><%}%>
		<wea:item>供应商单价(2)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original201" value="<%=original201%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount201"><%=Discount201%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_02" value="<%=price_02%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				    <td>
						<brow:browser viewType="0"  name="zxwd201" browserValue="<%=zxwd201 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd201),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item>	<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original201%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount201%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_02%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd201),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 2){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original202" value="<%=original202%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount202"><%=Discount202%></textarea></td>
				      <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_02_02" value="<%=price_02_02%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				 <td>
						<brow:browser viewType="0"  name="zxwd202" browserValue="<%=zxwd202 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd202),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item>	<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original202%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount202%></td>
					 <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_02_02%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd202),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original203" value="<%=original203%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount203"><%=Discount203%></textarea></td>
				     <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_02_03" value="<%=price_02_03%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				 <td>
						<brow:browser viewType="0"  name="zxwd203" browserValue="<%=zxwd203 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd203),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original203%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount203%></td>
					 <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_02_03%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd203),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		
		<%if(roleID == 4){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original204" value="<%=original204%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount204"><%=Discount204%></textarea></td>
				 <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_02_04" value="<%=price_02_04%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				<td>
						<brow:browser viewType="0"  name="zxwd204" browserValue="<%=zxwd204 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd204),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original204%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount204%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_02_04%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd204),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		
		<wea:item>选择该供应商(2)</wea:item><!-- 是否启用 -->
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck2" name="selCheck2" value="1" <%if(selCheck2.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item><%if(selCheck2.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 2){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_02_02" name="selCheck_02_02" value="1" <%if(selCheck_02_02.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><%if(selCheck_02_02.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_02_03" name="selCheck_02_03" value="1" <%if(selCheck_02_03.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><%if(selCheck_02_03.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 4){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_02_04" name="selCheck_02_04" value="1" <%if(selCheck_02_03.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><%if(selCheck_02_04.equals("1"))out.println("选中");%></wea:item><%}%>
	</wea:group>
</wea:layout>
			
		
<wea:layout type="twoCol" attributes="{'expandAllGroup':'true'}">
	<wea:group context="供应商3" attributes="{'class':'e8_title e8_title_1'}">
		<wea:item>供应商名称(3)	</wea:item>
		<%if(roleID == 1){%>
		<wea:item><brow:browser viewType="0"  name="supplier_03" browserValue="<%=supplier_03 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_03),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>					
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand301" value="<%=brand301%>"></td>
					<td><input size=17 name="model301" value="<%=model301%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf301"><%=conf301%></textarea></td>
					<td><input size=17 name="guar301" value="<%=guar301%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw301"><%=bxfw301%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf301" value="<%=xbnf301%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ||  roleID ==18){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_03),user.getLanguage())%>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand301%></td>
					<td><%=model301%></td>
					<td><%=conf301%></td>
					<td><%=guar301%></td>
					<td><%=bxfw301%></td>
					<td><%=xbnf301%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 2){%>
	<wea:item><brow:browser viewType="0"  name="supplier_03_02" browserValue="<%=supplier_03_02 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_03_02),user.getLanguage())%>">
						</brow:browser>	<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand302" value="<%=brand302%>"></td>
					<td><input size=17 name="model302" value="<%=model302%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf302"><%=conf302%></textarea></td>
					<td><input size=17 name="guar302" value="<%=guar302%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw302"><%=bxfw302%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf302" value="<%=xbnf302%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>									
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_03_02),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand302%></td>
					<td><%=model302%></td>
					<td><%=conf302%></td>
					<td><%=guar302%></td>
					<td><%=bxfw302%></td>
					<td><%=xbnf302%></td>
				</tr>
			</table></wea:item><%}%>	
		<%if(roleID == 3){%>
		<wea:item><brow:browser viewType="0"  name="supplier_03_03" browserValue="<%=supplier_03_03 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_03_03),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand303" value="<%=brand303%>"></td>
					<td><input size=17 name="model303" value="<%=model303%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf303"><%=conf303%></textarea></td>
					<td><input size=17 name="guar303" value="<%=guar303%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw303"><%=bxfw303%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf303" value="<%=xbnf303%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_03_03),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand303%></td>
					<td><%=model303%></td>
					<td><%=conf303%></td>
					<td><%=guar303%></td>
					<td><%=bxfw303%></td>
					<td><%=xbnf303%></td>
				</tr>
			</table></wea:item><%}%>

		<%if(roleID == 4){%>
		<wea:item><brow:browser viewType="0"  name="supplier_03_04" browserValue="<%=supplier_03_04 %>"
							browserOnClick=""
							linkUrl="javascript:openSupplier($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Supplier"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp" width="165px"
							browserSpanValue="<%=Util.toScreen(getSupplierName(supplier_03_04),user.getLanguage())%>">
						</brow:browser>		<br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><input size=17 name="brand304" value="<%=brand304%>"></td>
					<td><input size=17 name="model304" value="<%=model304%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="conf304"><%=conf304%></textarea></td>
					<td><input size=17 name="guar304" value="<%=guar304%>"></td>
					<td><textarea class=inputstyle rows=1 cols=30 name="bxfw304"><%=bxfw304%></textarea></td>	
					<td><input maxLength=10 size=17 name="xbnf304" value="<%=xbnf304%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><%=Util.toScreen(getSupplierNameRead(supplier_03_04),user.getLanguage())%><br/>
			<table width=100% class="table">
				<colgroup>
					<col width="15%"/><col width="15%"/><col width="20%"/>
					<col width="15%"/><col width="20%"/><col width="15%"/>
				</colgroup>
				<tr><th>品牌</th><th>型号</th><th>配置</th><th>保修年限</th><th>保修范围</th><th>续保年费</th></tr>
				<tr>
					<td><%=brand304%></td>
					<td><%=model304%></td>
					<td><%=conf304%></td>
					<td><%=guar304%></td>
					<td><%=bxfw304%></td>
					<td><%=xbnf304%></td>
				</tr>
			</table></wea:item><%}%>

		<wea:item>供应商单价(3)</wea:item>
		<%if(roleID == 1){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original301" value="<%=original301%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount301"><%=Discount301%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_03" value="<%=price_03%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				    <td>
						<brow:browser viewType="0"  name="zxwd301" browserValue="<%=zxwd301 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd301),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ){%><wea:item>	<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original301%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount301%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_03%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd301),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 2){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original302" value="<%=original302%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount302"><%=Discount302%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_03_02" value="<%=price_03_02%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				     <td>
						<brow:browser viewType="0"  name="zxwd302" browserValue="<%=zxwd302 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd302),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original302%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount302%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_03_02%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd302),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original303" value="<%=original303%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount303"><%=Discount303%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_03_03" value="<%=price_03_03%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				     <td>
						<brow:browser viewType="0"  name="zxwd303" browserValue="<%=zxwd303 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd303),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original303%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount303%></td>
					 <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_03_03%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd303),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>

		<%if(roleID == 4){%>
		<wea:item>
			<table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>
					<td>挂牌单价</td>
					<td><input maxLength=10 size=30 name="original304" value="<%=original304%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>
				    <td rowspan="2">优惠信息</td>
					<td rowspan="2"><textarea class=inputstyle rows=3 cols=40 name="Discount304"><%=Discount304%></textarea></td>
				    <td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><input maxLength=10 size=30 name="price_03_04" value="<%=price_03_04%>"  onKeyPress="ItemDecimal_KeyPress(this.name,15,2)" onBlur="checknumber1(this)"></td>					
				    <td>
						<brow:browser viewType="0"  name="zxwd304" browserValue="<%=zxwd304 %>"
							browserOnClick=""
							linkUrl="javascript:opendoc($id$)"
							browserUrl="/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp"
							hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
							completeUrl="/data.jsp?type=9" width="80%"
							browserSpanValue="<%=Util.toScreen(getdocName(zxwd304),user.getLanguage())%>">
						</brow:browser>	
				    </td>	
				</tr>
			</table>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><table width=100% class="table">
				<colgroup><col width="10%"/><col width="25%"/><col width="10%"/><col width="30%"/><col width="25%"/></colgroup>
				<tr>					
					<td>挂牌单价</td>
					<td><%=original304%></td>
					<td rowspan="2">优惠信息</td>
					<td rowspan="2"><%=Discount304%></td>
					<td>在线文档</td>
				</tr>
				<tr>
					<td>采购单价</td>
					<td><%=price_03_04%> </td>
					<td><%=Util.toScreen(getdocRead(zxwd304),user.getLanguage())%></td>
				</tr>
			</table></wea:item><%}%>
			
		<wea:item>选择该供应商(3)</wea:item><!-- 是否启用 -->
		<%if(roleID == 1){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck3" name="selCheck3" value="1" <%if(selCheck3.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 11 || roleID == 6  || roleID == 16 ||  roleID ==18){%><wea:item><%if(selCheck3.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 2){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_03_02" name="selCheck_03_02" value="1" <%if(selCheck_03_02.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 21 || roleID == 7  || roleID == 17 ){%><wea:item><%if(selCheck_03_02.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 3){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_03_03" name="selCheck_03_03" value="1" <%if(selCheck_03_03.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 31 || roleID == 8  || roleID == 18){%><wea:item><%if(selCheck_03_03.equals("1"))out.println("选中");%></wea:item><%}%>
		<%if(roleID == 4){%>
		<wea:item>
				<input class="inputstyle" type=checkbox tzCheckbox='true' id="selCheck_03_04" name="selCheck_03_04" value="1" <%if(selCheck_03_04.equals("1"))out.println("checked"); %>>
		</wea:item>
		<%}%>
		<%if(roleID == 41  || roleID == 19){%><wea:item><%if(selCheck_03_04.equals("1"))out.println("选中");%></wea:item><%}%>
	</wea:group>
</wea:layout>
</form>
<script language=javascript>
	function onSave(){
		if(checkselect()){
		frmmain.submit();
	    }
	}
	
	function onSave1(){
		
		document.frmmain.savaType.value="sr";
	    if(checkselect()){
		frmmain.submit();
	    }
		
	}
	function onSave2(){
		document.frmmain.savaType.value="re";
	    frmmain.submit();
	}

    function checkselect(){
		var roleid=<%=roleID%>;
		var selCheck1 ="";
		var selCheck2="";
		var selCheck3="";
		if (roleid == "1"){
		 selCheck1  = document.getElementById('selCheck1');
		 selCheck2  = document.getElementById('selCheck2');
		 selCheck3  = document.getElementById('selCheck3');
		}
		if (roleid == "2"){
		 selCheck1  = document.getElementById('selCheck_01_02');
		 selCheck2  = document.getElementById('selCheck_02_02');
		 selCheck3  = document.getElementById('selCheck_03_02');
		}
		if (roleid == "3"){
		 selCheck1  = document.getElementById('selCheck_01_03');
		 selCheck2  = document.getElementById('selCheck_02_03');
		 selCheck3  = document.getElementById('selCheck_03_03');
		}
		if (roleid == "4"){
		 selCheck1  = document.getElementById('selCheck_01_04');
		 selCheck2  = document.getElementById('selCheck_02_04');
		 selCheck3  = document.getElementById('selCheck_03_04');
		}
		
		if(selCheck1.checked){
			if(selCheck2.checked|| selCheck3.checked){
				alert("您本次采购只能选择一个商家作为本次询价的供应商，目前您选择了多个供应商，不符合询价规则，请检查后提交。");
				return false;
			}
		}else if(selCheck2.checked && selCheck3.checked){
            alert("您本次采购只能选择一个商家作为本次询价的供应商，目前您选择了多个供应商，不符合询价规则，请检查后提交。");
				return false;
		}
		return true;
		 
	}

	function BatchProcess(){
	    document.frmmain.operation.value="batchprocess";
	    frmmain.submit();
	}
	function openSupplier(id){
		var title = "";
		var url = "";
		 
		title = "供应商";
		url="/formmode/view/ViewMode.jsp?type=0&modeId=50&formId=-57&opentype=0&customid=76&viewfrom=fromsearchlist&mainid=0&billid="+id;
		
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
	function opendoc(id){
		var title = "";
		var url = "";
		 
		title = "文档";
		url="/docs/docs/DocDsp.jsp?id="+id;
		
		window.open(url)
	}
	

</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" src="/seahonor/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/seahonor/attend/copytime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</HTML>
