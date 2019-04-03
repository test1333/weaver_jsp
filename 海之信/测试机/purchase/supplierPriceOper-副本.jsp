<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="seahonor.util.InsertUtil"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
	BaseBean jspLog = new BaseBean();  
	String savaType = Util.null2String(request.getParameter("savaType"));
	String deRemark = Util.null2String(request.getParameter("deRemark"));
	String pro_name = Util.null2String(request.getParameter("pro_name"));
	String Stock = Util.null2String(request.getParameter("Stock"));
	String AvgPrice = Util.null2String(request.getParameter("AvgPrice"));
	String Numbers = Util.null2String(request.getParameter("Numbers"));
	String lastPrice = Util.null2String(request.getParameter("lastPrice"));
	String AvgNum = Util.null2String(request.getParameter("AvgNum"));
	String reID = Util.null2String(request.getParameter("reID"));
	String roleID = Util.null2String(request.getParameter("roleID"));
	
	jspLog.writeLog("deRemark = " + deRemark);
	
	String ro_url = "";
	if(roleID.length() > 1){
		ro_url = "/workflow/request/ViewRequestIframe.jsp?isovertime=0&requestid="+reID;
	}else{
		ro_url = "/workflow/request/ManageRequestNoFormIframe.jsp?f_weaver_belongto_usertype="
				+"0&isrequest=0&isovertime=0reEdit=1&seeflowdoc=0&isworkflowdoc=0&isfromtab=false&forward=1&submit=1&f_weaver_belongto_usertype=0&requestid="+reID;
	}
	
	
	if("re".equals(savaType)){
	    String url_a = "<script>window.parent.location='"+ro_url+"'</script>";
	    response.getWriter().write(url_a);
		//String url_a=" <script> window.open( '"+ro_url+"', '_parent') </script> ";
	    //response.Write(url_a);
		//response.sendRedirect(ro_url);
		return;
	}
	
	String supplier_01 = Util.null2String(request.getParameter("supplier_01"));
	String price_01 = Util.null2String(request.getParameter("price_01"));
	String supplier_02 = Util.null2String(request.getParameter("supplier_02"));
	String price_02 = Util.null2String(request.getParameter("price_02"));
	String supplier_03 = Util.null2String(request.getParameter("supplier_03"));
	String price_03 = Util.null2String(request.getParameter("price_03"));
	String selCheck1 = Util.null2String(request.getParameter("selCheck1"));
	String selCheck2 = Util.null2String(request.getParameter("selCheck2"));
	String selCheck3 = Util.null2String(request.getParameter("selCheck3"));
	// String remark = Util.null2String(request.getParameter("remark"));
	
	String supplier_01_02 = Util.null2String(request.getParameter("supplier_01_02"));
	String supplier_01_03 = Util.null2String(request.getParameter("supplier_01_03"));
	String supplier_01_04 = Util.null2String(request.getParameter("supplier_01_04"));
	String price_01_02 = Util.null2String(request.getParameter("price_01_02"));
	String price_01_03 = Util.null2String(request.getParameter("price_01_03"));
	String price_01_04 = Util.null2String(request.getParameter("price_01_04"));
	String selCheck_01_02 = Util.null2String(request.getParameter("selCheck_01_02"));
	String selCheck_01_03 = Util.null2String(request.getParameter("selCheck_01_03"));
	String selCheck_01_04 = Util.null2String(request.getParameter("selCheck_01_04"));
	
	String supplier_02_02 = Util.null2String(request.getParameter("supplier_02_02"));
	String supplier_02_03 = Util.null2String(request.getParameter("supplier_02_03"));
	String supplier_02_04 = Util.null2String(request.getParameter("supplier_02_04"));
	String price_02_02 = Util.null2String(request.getParameter("price_02_02"));
	String price_02_03 = Util.null2String(request.getParameter("price_02_03"));
	String price_02_04 = Util.null2String(request.getParameter("price_02_04"));
	String selCheck_02_02 = Util.null2String(request.getParameter("selCheck_02_02"));
	String selCheck_02_03 = Util.null2String(request.getParameter("selCheck_02_03"));
	String selCheck_02_04 = Util.null2String(request.getParameter("selCheck_02_04"));
	
	String supplier_03_02 = Util.null2String(request.getParameter("supplier_03_02"));
	String supplier_03_03 = Util.null2String(request.getParameter("supplier_03_03"));
	String supplier_03_04 = Util.null2String(request.getParameter("supplier_03_04"));
	String price_03_02 = Util.null2String(request.getParameter("price_03_02"));
	String price_03_03 = Util.null2String(request.getParameter("price_03_03"));
	String price_03_04 = Util.null2String(request.getParameter("price_03_04"));
	String selCheck_03_02 = Util.null2String(request.getParameter("selCheck_03_02"));
	String selCheck_03_03 = Util.null2String(request.getParameter("selCheck_03_03"));
	String selCheck_03_04 = Util.null2String(request.getParameter("selCheck_03_04"));
	
	String remark01 = Util.null2String(request.getParameter("remark01"));
	String remark02 = Util.null2String(request.getParameter("remark02"));
	String remark03 = Util.null2String(request.getParameter("remark03"));
	String remark = Util.null2String(request.getParameter("remark"));
	
	String brand101 = Util.null2String(request.getParameter("brand101"));
	String brand102 = Util.null2String(request.getParameter("brand102"));
	String brand103 = Util.null2String(request.getParameter("brand103"));
	String brand104 = Util.null2String(request.getParameter("brand104"));
	String brand201 = Util.null2String(request.getParameter("brand201"));
	String brand202 = Util.null2String(request.getParameter("brand202"));
	String brand203 = Util.null2String(request.getParameter("brand203"));
	String brand204 = Util.null2String(request.getParameter("brand204"));
	String brand301 = Util.null2String(request.getParameter("brand301"));
	String brand302 = Util.null2String(request.getParameter("brand302"));
	String brand303 = Util.null2String(request.getParameter("brand303"));
	String brand304 = Util.null2String(request.getParameter("brand304"));

	String bxfw101 = Util.null2String(request.getParameter("bxfw101"));
	String bxfw102 = Util.null2String(request.getParameter("bxfw102"));
	String bxfw103 = Util.null2String(request.getParameter("bxfw103"));
	String bxfw104 = Util.null2String(request.getParameter("bxfw104"));
	String bxfw201 = Util.null2String(request.getParameter("bxfw201"));
	String bxfw202 = Util.null2String(request.getParameter("bxfw202"));
	String bxfw203 = Util.null2String(request.getParameter("bxfw203"));
	String bxfw204 = Util.null2String(request.getParameter("bxfw204"));
	String bxfw301 = Util.null2String(request.getParameter("bxfw301"));
	String bxfw302 = Util.null2String(request.getParameter("bxfw302"));
	String bxfw303 = Util.null2String(request.getParameter("bxfw303"));
	String bxfw304 = Util.null2String(request.getParameter("bxfw304"));

	String xbnf101 = Util.null2String(request.getParameter("xbnf101"));
	String xbnf102 = Util.null2String(request.getParameter("xbnf102"));
	String xbnf103 = Util.null2String(request.getParameter("xbnf103"));
	String xbnf104 = Util.null2String(request.getParameter("xbnf104"));
	String xbnf201 = Util.null2String(request.getParameter("xbnf201"));
	String xbnf202 = Util.null2String(request.getParameter("xbnf202"));
	String xbnf203 = Util.null2String(request.getParameter("xbnf203"));
	String xbnf204 = Util.null2String(request.getParameter("xbnf204"));
	String xbnf301 = Util.null2String(request.getParameter("xbnf301"));
	String xbnf302 = Util.null2String(request.getParameter("xbnf302"));
	String xbnf303 = Util.null2String(request.getParameter("xbnf303"));
	String xbnf304 = Util.null2String(request.getParameter("xbnf304"));

	String model101 = Util.null2String(request.getParameter("model101"));
	String model102 = Util.null2String(request.getParameter("model102"));
	String model103 = Util.null2String(request.getParameter("model103"));
	String model104 = Util.null2String(request.getParameter("model104"));
	String model201 = Util.null2String(request.getParameter("model201"));
	String model202 = Util.null2String(request.getParameter("model202"));
	String model203 = Util.null2String(request.getParameter("model203"));
	String model204 = Util.null2String(request.getParameter("model204"));
	String model301 = Util.null2String(request.getParameter("model301"));
	String model302 = Util.null2String(request.getParameter("model302"));
	String model303 = Util.null2String(request.getParameter("model303"));
	String model304 = Util.null2String(request.getParameter("model304"));
	String conf101 = Util.null2String(request.getParameter("conf101"));
	String conf102 = Util.null2String(request.getParameter("conf102"));
	String conf103 = Util.null2String(request.getParameter("conf103"));
	String conf104 = Util.null2String(request.getParameter("conf104"));
	String conf201 = Util.null2String(request.getParameter("conf201"));
	String conf202 = Util.null2String(request.getParameter("conf202"));
	String conf203 = Util.null2String(request.getParameter("conf203"));
	String conf204 = Util.null2String(request.getParameter("conf204"));
	String conf301 = Util.null2String(request.getParameter("conf301"));
	String conf302 = Util.null2String(request.getParameter("conf302"));
	String conf303 = Util.null2String(request.getParameter("conf303"));
	String conf304 = Util.null2String(request.getParameter("conf304"));
	//String seq101 = Util.null2String(request.getParameter("seq101"));
	String seq101 ="";
	//String seq102 = Util.null2String(request.getParameter("seq102"));
	String seq102="";
	String seq103 = "";
	String seq201 = "";
	String seq202 = "";
	String seq203 = "";
	String seq301 = "";
	String seq302 = "";
	String seq303 = "";
	//String Spec101 = Util.null2String(request.getParameter("Spec101"));
	String Spec101="";
	//String Spec102 = Util.null2String(request.getParameter("Spec102"));
	String Spec102 ="";
	String Spec103 = "";
	String Spec201 = "";
	String Spec202 = "";
	String Spec203 = "";
	String Spec301 = "";
	String Spec302 = "";
	String Spec303 = "";
	String guar101 = Util.null2String(request.getParameter("guar101"));
	String guar102 = Util.null2String(request.getParameter("guar102"));
	String guar103 = Util.null2String(request.getParameter("guar103"));
	String guar104 = Util.null2String(request.getParameter("guar104"));
	String guar201 = Util.null2String(request.getParameter("guar201"));
	String guar202 = Util.null2String(request.getParameter("guar202"));
	String guar203 = Util.null2String(request.getParameter("guar203"));
	String guar204 = Util.null2String(request.getParameter("guar204"));
	String guar301 = Util.null2String(request.getParameter("guar301"));
	String guar302 = Util.null2String(request.getParameter("guar302"));
	String guar303 = Util.null2String(request.getParameter("guar303"));
	String guar304 = Util.null2String(request.getParameter("guar304"));
	String Discount101 = Util.null2String(request.getParameter("Discount101"));
	String Discount102 = Util.null2String(request.getParameter("Discount102"));
	String Discount103 = Util.null2String(request.getParameter("Discount103"));
	String Discount104 = Util.null2String(request.getParameter("Discount104"));
	String Discount201 = Util.null2String(request.getParameter("Discount201"));
	String Discount202 = Util.null2String(request.getParameter("Discount202"));
	String Discount203 = Util.null2String(request.getParameter("Discount203"));
	String Discount204 = Util.null2String(request.getParameter("Discount204"));
	String Discount301 = Util.null2String(request.getParameter("Discount301"));
	String Discount302 = Util.null2String(request.getParameter("Discount302"));
	String Discount303 = Util.null2String(request.getParameter("Discount303"));
	String Discount304 = Util.null2String(request.getParameter("Discount304"));
	String original101 = Util.null2String(request.getParameter("original101"));
	String original102 = Util.null2String(request.getParameter("original102"));
	String original103 = Util.null2String(request.getParameter("original103"));
	String original104 = Util.null2String(request.getParameter("original104"));
	String original201 = Util.null2String(request.getParameter("original201"));
	String original202 = Util.null2String(request.getParameter("original202"));
	String original203 = Util.null2String(request.getParameter("original203"));
	String original204 = Util.null2String(request.getParameter("original204"));
	String original301 = Util.null2String(request.getParameter("original301"));
	String original302 = Util.null2String(request.getParameter("original302"));
	String original303 = Util.null2String(request.getParameter("original303"));
	String original304 = Util.null2String(request.getParameter("original304"));


	
	if(!"1".equals(selCheck_03_02))  selCheck_03_02 = "0";
	if(!"1".equals(selCheck_03_03))  selCheck_03_03 = "0";
	if(!"1".equals(selCheck_03_04))  selCheck_03_04 = "0";
	if(!"1".equals(selCheck_02_02))  selCheck_02_02 = "0";
	if(!"1".equals(selCheck_02_03))  selCheck_02_03 = "0";
	if(!"1".equals(selCheck_02_04))  selCheck_02_04 = "0";
	if(!"1".equals(selCheck_01_02))  selCheck_01_02 = "0";
	if(!"1".equals(selCheck_01_03))  selCheck_01_03 = "0";
	if(!"1".equals(selCheck_01_04))  selCheck_01_04 = "0";
	if(!"1".equals(selCheck1))  selCheck1 = "0";
	if(!"1".equals(selCheck2))  selCheck2 = "0";
	if(!"1".equals(selCheck3))  selCheck3 = "0";
	
	InsertUtil iu = new InsertUtil();
	boolean isUpdate = false;
	String tmp_sql = "select count(id) as count_cc from uf_inquiryPrice where deRemark="+deRemark;
	rs.executeSql(tmp_sql);
	if(rs.next()) {
		int flag_s = rs.getInt("count_cc");
		if(flag_s > 0) isUpdate = true;
	}
	if(isUpdate){
		Map<String, String> mapStr = new HashMap<String, String>();
//		mapStr.put("deRemark", deRemark);
//		mapStr.put("proName", pro_name);
//		mapStr.put("stock", Stock);
//		mapStr.put("threeAvg", AvgPrice);
//		mapStr.put("forNum", Numbers);
      if("1".equals(roleID)){
		mapStr.put("reID", reID);
		
		mapStr.put("supplier1", supplier_01);
		mapStr.put("price1", price_01);
		mapStr.put("supplier2", supplier_02);
		mapStr.put("price2", price_02);
		mapStr.put("supplier3", supplier_03);
		mapStr.put("price3", price_03);
		mapStr.put("selCheck1", selCheck1);
		mapStr.put("selCheck2", selCheck2);
		mapStr.put("selCheck3", selCheck3);
		
		mapStr.put("supplier102", supplier_01);
		mapStr.put("price102", price_01);
		mapStr.put("supplier103", supplier_01);
		mapStr.put("supplier104", supplier_01);
		mapStr.put("price103", price_01);
		mapStr.put("price104", price_01);
		mapStr.put("selCheck102", selCheck1);
		mapStr.put("selCheck103", selCheck1);
		mapStr.put("selCheck104", selCheck1);
		
		mapStr.put("supplier202", supplier_02);
		mapStr.put("price202", price_02);
		mapStr.put("supplier203", supplier_02);
		mapStr.put("supplier204", supplier_02);
		mapStr.put("price203", price_02);
		mapStr.put("price204", price_02);
		mapStr.put("selCheck202", selCheck2);
		mapStr.put("selCheck203", selCheck2);
		mapStr.put("selCheck204", selCheck2);
		
		mapStr.put("supplier302", supplier_03);
		mapStr.put("price302", price_03);
		mapStr.put("supplier303", supplier_03);
		mapStr.put("supplier304", supplier_03);
		mapStr.put("price303", price_03);
		mapStr.put("price304", price_03);
		mapStr.put("selCheck302", selCheck3);
		mapStr.put("selCheck303", selCheck3);
		mapStr.put("selCheck304", selCheck3);
		
		mapStr.put("remark", remark);
		mapStr.put("remark01", remark01);
		mapStr.put("remark02", remark02);
		mapStr.put("remark03", remark03);
		mapStr.put("remark", remark);
		
		mapStr.put("brand101", brand101);
		mapStr.put("brand102", brand101);
		mapStr.put("brand103", brand101);
		mapStr.put("brand104", brand101);
		mapStr.put("brand201", brand201);
		mapStr.put("brand202", brand201);
		mapStr.put("brand203", brand201);
		mapStr.put("brand204", brand201);
		mapStr.put("brand301", brand301);
		mapStr.put("brand302", brand301);
		mapStr.put("brand303", brand301);
		mapStr.put("brand304", brand301);

		mapStr.put("bxfw101", bxfw101);
		mapStr.put("bxfw102", bxfw101);
		mapStr.put("bxfw103", bxfw101);
		mapStr.put("bxfw104", bxfw101);
		mapStr.put("bxfw201", bxfw201);
		mapStr.put("bxfw202", bxfw201);
		mapStr.put("bxfw203", bxfw201);
		mapStr.put("bxfw204", bxfw201);
		mapStr.put("bxfw301", bxfw301);
		mapStr.put("bxfw302", bxfw301);
		mapStr.put("bxfw303", bxfw301);
		mapStr.put("bxfw304", bxfw301);
		
		mapStr.put("xbnf101", xbnf101);
		mapStr.put("xbnf102", xbnf101);
		mapStr.put("xbnf103", xbnf101);
		mapStr.put("xbnf104", xbnf101);
		mapStr.put("xbnf201", xbnf201);
		mapStr.put("xbnf202", xbnf201);
		mapStr.put("xbnf203", xbnf201);
		mapStr.put("xbnf204", xbnf201);
		mapStr.put("xbnf301", xbnf301);
		mapStr.put("xbnf302", xbnf301);
		mapStr.put("xbnf303", xbnf301);
		mapStr.put("xbnf304", xbnf301);
		mapStr.put("model101", model101);
		mapStr.put("model102", model101);
		mapStr.put("model103", model101);
		mapStr.put("model104", model101);
		mapStr.put("model201", model201);
		mapStr.put("model202", model201);
		mapStr.put("model203", model201);
		mapStr.put("model204", model201);
		mapStr.put("model301", model301);
		mapStr.put("model302", model301);
		mapStr.put("model303", model301);
		mapStr.put("model304", model301);
		mapStr.put("conf101", conf101);
		mapStr.put("conf102", conf101);
		mapStr.put("conf103", conf101);
		mapStr.put("conf104", conf101);
		mapStr.put("conf201", conf201);
		mapStr.put("conf202", conf201);
		mapStr.put("conf203", conf201);
		mapStr.put("conf204", conf201);
		mapStr.put("conf301", conf301);
		mapStr.put("conf302", conf301);
		mapStr.put("conf303", conf301);
		mapStr.put("conf304", conf301);
		mapStr.put("seq101", seq101);
		mapStr.put("seq102", seq101);
		mapStr.put("seq103", seq101);
		mapStr.put("seq201", seq201);
		mapStr.put("seq202", seq201);
		mapStr.put("seq203", seq201);
		mapStr.put("seq301", seq301);
		mapStr.put("seq302", seq301);
		mapStr.put("seq303", seq301);
		mapStr.put("Spec101", Spec101);
		mapStr.put("Spec102", Spec101);
		mapStr.put("Spec103", Spec101);
		mapStr.put("Spec201", Spec201);
		mapStr.put("Spec202", Spec201);
		mapStr.put("Spec203", Spec201);
		mapStr.put("Spec301", Spec301);
		mapStr.put("Spec302", Spec301);
		mapStr.put("Spec303", Spec301);
		mapStr.put("guar101", guar101);
		mapStr.put("guar102", guar101);
		mapStr.put("guar103", guar101);
		mapStr.put("guar104", guar101);
		mapStr.put("guar201", guar201);
		mapStr.put("guar202", guar201);
		mapStr.put("guar203", guar201);
		mapStr.put("guar204", guar201);
		mapStr.put("guar301", guar301);
		mapStr.put("guar302", guar301);
		mapStr.put("guar303", guar301);
		mapStr.put("guar304", guar301);
		mapStr.put("Discount101", Discount101);
		mapStr.put("Discount102", Discount101);
		mapStr.put("Discount103", Discount101);
		mapStr.put("Discount104", Discount101);
		mapStr.put("Discount201", Discount201);
		mapStr.put("Discount202", Discount201);
		mapStr.put("Discount203", Discount201);
		mapStr.put("Discount204", Discount201);
		mapStr.put("Discount301", Discount301);
		mapStr.put("Discount302", Discount301);
		mapStr.put("Discount303", Discount301);
		mapStr.put("Discount304", Discount301);
		mapStr.put("original101", original101);
		mapStr.put("original102", original101);
		mapStr.put("original103", original101);
		mapStr.put("original104", original101);
		mapStr.put("original201", original201);
		mapStr.put("original202", original201);
		mapStr.put("original203", original201);
		mapStr.put("original204", original201);
		mapStr.put("original301", original301);
		mapStr.put("original302", original301);
		mapStr.put("original303", original301);
		mapStr.put("original304", original301);
      }else if("2".equals(roleID)){
		
		mapStr.put("supplier102", supplier_01_02);
		mapStr.put("price102", price_01_02);
		mapStr.put("supplier103", supplier_01_02);
		mapStr.put("supplier104", supplier_01_02);
		mapStr.put("price103", price_01_02);
		mapStr.put("price104", price_01_02);
		mapStr.put("selCheck102", selCheck_01_02);
		mapStr.put("selCheck103", selCheck_01_02);
		mapStr.put("selCheck104", selCheck_01_02);
		
		mapStr.put("supplier202", supplier_02_02);
		mapStr.put("price202", price_02_02);
		mapStr.put("supplier203", supplier_02_02);
		mapStr.put("supplier204", supplier_02_02);
		mapStr.put("price203", price_02_02);
		mapStr.put("price204", price_02_02);
		mapStr.put("selCheck202", selCheck_02_02);
		mapStr.put("selCheck203", selCheck_02_02);
		mapStr.put("selCheck204", selCheck_02_02);
		
		mapStr.put("supplier302", supplier_03_02);
		mapStr.put("price302", price_03_02);
		mapStr.put("supplier303", supplier_03_02);
		mapStr.put("supplier304", supplier_03_02);
		mapStr.put("price303", price_03_02);
		mapStr.put("price304", price_03_02);
		mapStr.put("selCheck302", selCheck_03_02);
		mapStr.put("selCheck303", selCheck_03_02);
		mapStr.put("selCheck304", selCheck_03_02);
		
		mapStr.put("remark", remark);
		mapStr.put("remark01", remark01);
		mapStr.put("remark02", remark02);
		mapStr.put("remark03", remark03);
		mapStr.put("remark", remark);
		
		mapStr.put("brand102", brand102);
		mapStr.put("brand103", brand102);
		mapStr.put("brand104", brand102);
		mapStr.put("brand202", brand202);
		mapStr.put("brand203", brand202);
		mapStr.put("brand204", brand202);
		mapStr.put("brand302", brand302);
		mapStr.put("brand303", brand302);
		mapStr.put("brand304", brand302);

		mapStr.put("bxfw102", bxfw102);
		mapStr.put("bxfw103", bxfw102);
		mapStr.put("bxfw104", bxfw102);
		mapStr.put("bxfw202", bxfw202);
		mapStr.put("bxfw203", bxfw202);
		mapStr.put("bxfw204", bxfw202);
		mapStr.put("bxfw302", bxfw302);
		mapStr.put("bxfw303", bxfw302);
		mapStr.put("bxfw304", bxfw302);
		
		mapStr.put("xbnf102", xbnf102);
		mapStr.put("xbnf103", xbnf102);
		mapStr.put("xbnf104", xbnf102);
		mapStr.put("xbnf202", xbnf202);
		mapStr.put("xbnf203", xbnf202);
		mapStr.put("xbnf204", xbnf202);
		mapStr.put("xbnf302", xbnf302);
		mapStr.put("xbnf303", xbnf302);
		mapStr.put("xbnf304", xbnf302);
		mapStr.put("model102", model102);
		mapStr.put("model103", model102);
		mapStr.put("model104", model102);
		mapStr.put("model202", model202);
		mapStr.put("model203", model202);
		mapStr.put("model204", model202);
		mapStr.put("model302", model302);
		mapStr.put("model303", model302);
		mapStr.put("model304", model302);
		mapStr.put("conf102", conf102);
		mapStr.put("conf103", conf102);
		mapStr.put("conf104", conf102);
		mapStr.put("conf202", conf202);
		mapStr.put("conf203", conf202);
		mapStr.put("conf204", conf202);
		mapStr.put("conf302", conf302);
		mapStr.put("conf303", conf302);
		mapStr.put("conf304", conf302);
		mapStr.put("seq102", seq102);
		mapStr.put("seq103", seq102);
		mapStr.put("seq202", seq202);
		mapStr.put("seq203", seq202);
		mapStr.put("seq302", seq302);
		mapStr.put("seq303", seq302);
		mapStr.put("Spec102", Spec102);
		mapStr.put("Spec103", Spec102);
		mapStr.put("Spec202", Spec202);
		mapStr.put("Spec203", Spec202);
		mapStr.put("Spec302", Spec302);
		mapStr.put("Spec303", Spec302);
		mapStr.put("guar102", guar102);
		mapStr.put("guar103", guar102);
		mapStr.put("guar104", guar102);
		mapStr.put("guar202", guar202);
		mapStr.put("guar203", guar202);
		mapStr.put("guar204", guar202);
		mapStr.put("guar302", guar302);
		mapStr.put("guar303", guar302);
		mapStr.put("guar304", guar302);
		mapStr.put("Discount102", Discount102);
		mapStr.put("Discount103", Discount102);
		mapStr.put("Discount104", Discount102);
		mapStr.put("Discount202", Discount202);
		mapStr.put("Discount203", Discount202);
		mapStr.put("Discount204", Discount202);
		mapStr.put("Discount302", Discount302);
		mapStr.put("Discount303", Discount302);
		mapStr.put("Discount304", Discount302);
		mapStr.put("original102", original102);
		mapStr.put("original103", original102);
		mapStr.put("original104", original102);
		mapStr.put("original202", original202);
		mapStr.put("original203", original202);
		mapStr.put("original204", original202);
		mapStr.put("original302", original302);
		mapStr.put("original303", original302);
		mapStr.put("original304", original302);
	  }else if("3".equals(roleID)){
		
		mapStr.put("supplier103", supplier_01_03);
		mapStr.put("supplier104", supplier_01_03);
		mapStr.put("price103", price_01_03);
		mapStr.put("price104", price_01_03);
		mapStr.put("selCheck103", selCheck_01_03);
		mapStr.put("selCheck104", selCheck_01_03);
		
		mapStr.put("supplier203", supplier_02_03);
		mapStr.put("supplier204", supplier_02_03);
		mapStr.put("price203", price_02_03);
		mapStr.put("price204", price_02_03);
		mapStr.put("selCheck203", selCheck_02_03);
		mapStr.put("selCheck204", selCheck_02_03);
		
		mapStr.put("supplier303", supplier_03_03);
		mapStr.put("supplier304", supplier_03_03);
		mapStr.put("price303", price_03_03);
		mapStr.put("price304", price_03_03);
		mapStr.put("selCheck303", selCheck_03_03);
		mapStr.put("selCheck304", selCheck_03_03);
		
		mapStr.put("remark", remark);
		mapStr.put("remark01", remark01);
		mapStr.put("remark02", remark02);
		mapStr.put("remark03", remark03);
		mapStr.put("remark", remark);
		
		mapStr.put("brand103", brand103);
		mapStr.put("brand104", brand103);
		mapStr.put("brand203", brand203);
		mapStr.put("brand204", brand203);
		mapStr.put("brand303", brand303);
		mapStr.put("brand304", brand303);

		mapStr.put("bxfw103", bxfw103);
		mapStr.put("bxfw104", bxfw103);
		mapStr.put("bxfw203", bxfw203);
		mapStr.put("bxfw204", bxfw203);
		mapStr.put("bxfw303", bxfw303);
		mapStr.put("bxfw304", bxfw303);
		
		mapStr.put("xbnf103", xbnf103);
		mapStr.put("xbnf104", xbnf103);
		mapStr.put("xbnf203", xbnf203);
		mapStr.put("xbnf204", xbnf203);
		mapStr.put("xbnf303", xbnf303);
		mapStr.put("xbnf304", xbnf303);
		mapStr.put("model103", model103);
		mapStr.put("model104", model103);
		mapStr.put("model203", model203);
		mapStr.put("model204", model203);
		mapStr.put("model303", model303);
		mapStr.put("model304", model303);
		mapStr.put("conf103", conf103);
		mapStr.put("conf104", conf103);
		mapStr.put("conf203", conf203);
		mapStr.put("conf204", conf203);
		mapStr.put("conf303", conf303);
		mapStr.put("conf304", conf303);
		mapStr.put("seq103", seq103);
		mapStr.put("seq203", seq203);
		mapStr.put("seq303", seq303);
		mapStr.put("Spec103", Spec103);
		mapStr.put("Spec203", Spec203);
		mapStr.put("Spec303", Spec303);
		mapStr.put("guar103", guar103);
		mapStr.put("guar104", guar103);
		mapStr.put("guar203", guar203);
		mapStr.put("guar204", guar203);
		mapStr.put("guar303", guar303);
		mapStr.put("guar304", guar303);
		mapStr.put("Discount103", Discount103);
		mapStr.put("Discount104", Discount103);
		mapStr.put("Discount203", Discount203);
		mapStr.put("Discount204", Discount203);
		mapStr.put("Discount303", Discount303);
		mapStr.put("Discount304", Discount303);
		mapStr.put("original103", original103);
		mapStr.put("original104", original103);
		mapStr.put("original203", original203);
		mapStr.put("original204", original203);
		mapStr.put("original303", original303);
		mapStr.put("original304", original303);
	  }else{
	    
		mapStr.put("supplier104", supplier_01_04);
		mapStr.put("price104", price_01_04);
		mapStr.put("selCheck104", selCheck_01_04);
		
		mapStr.put("supplier204", supplier_02_04);
		mapStr.put("price204", price_02_04);
		mapStr.put("selCheck204", selCheck_02_04);
		
		mapStr.put("supplier304", supplier_03_04);
		mapStr.put("price304", price_03_04);
		mapStr.put("selCheck304", selCheck_03_04);
		
		mapStr.put("remark", remark);
		mapStr.put("remark01", remark01);
		mapStr.put("remark02", remark02);
		mapStr.put("remark03", remark03);
		mapStr.put("remark", remark);
		
		mapStr.put("brand104", brand104);
		mapStr.put("brand204", brand204);
		mapStr.put("brand304", brand304);

		mapStr.put("bxfw104", bxfw104);
		mapStr.put("bxfw204", bxfw204);
		mapStr.put("bxfw304", bxfw304);
		
		mapStr.put("xbnf104", xbnf104);
		mapStr.put("xbnf204", xbnf204);
		mapStr.put("xbnf304", xbnf304);
		mapStr.put("model104", model104);
		mapStr.put("model204", model204);
		mapStr.put("model304", model304);
		mapStr.put("conf104", conf104);
		mapStr.put("conf204", conf204);
		mapStr.put("conf304", conf304);
		mapStr.put("guar104", guar104);
		mapStr.put("guar204", guar204);
		mapStr.put("guar304", guar304);
		mapStr.put("Discount104", Discount104);
		mapStr.put("Discount204", Discount204);
		mapStr.put("Discount304", Discount304);
		mapStr.put("original104", original104);
		mapStr.put("original204", original204);
		mapStr.put("original304", original304);
	  }
		iu.updateGen(mapStr, "uf_inquiryPrice","deRemark",deRemark);
		
	}else{
		Map<String, String> mapStr = new HashMap<String, String>();
		mapStr.put("deRemark", deRemark);
		mapStr.put("proName", pro_name);
		mapStr.put("stock", Stock);
		mapStr.put("threeAvg", AvgPrice);
		mapStr.put("forNum", Numbers);
		
		mapStr.put("lastPrice", lastPrice);
		mapStr.put("AvgNum", AvgNum);
		
		mapStr.put("reID", reID);
		mapStr.put("formmodeid", "113");
		mapStr.put("modedatacreatertype", "0");
		
		mapStr.put("supplier1", supplier_01);
		mapStr.put("price1", price_01);
		mapStr.put("supplier2", supplier_02);
		mapStr.put("price2", price_02);
		mapStr.put("supplier3", supplier_03);
		mapStr.put("price3", price_03);
		mapStr.put("selCheck1", selCheck1);
		mapStr.put("selCheck2", selCheck2);
		mapStr.put("selCheck3", selCheck3);
		mapStr.put("remark", remark);
		
		mapStr.put("supplier102", supplier_01);
		mapStr.put("price102", price_01);
		mapStr.put("supplier103", supplier_01);
		mapStr.put("supplier104", supplier_01);
		mapStr.put("price103", price_01);
		mapStr.put("price104", price_01);
		mapStr.put("selCheck102", selCheck1);
		mapStr.put("selCheck103", selCheck1);
		mapStr.put("selCheck104", selCheck1);
		
		mapStr.put("supplier202", supplier_02);
		mapStr.put("price202", price_02);
		mapStr.put("supplier203", supplier_02);
		mapStr.put("supplier204", supplier_02);
		mapStr.put("price203", price_02);
		mapStr.put("price204", price_02);
		mapStr.put("selCheck202", selCheck2);
		mapStr.put("selCheck203", selCheck2);
		mapStr.put("selCheck204", selCheck2);
		
		mapStr.put("supplier302", supplier_03);
		mapStr.put("price302", price_03);
		mapStr.put("supplier303", supplier_03);
		mapStr.put("supplier304", supplier_03);
		mapStr.put("price303", price_03);
		mapStr.put("price304", price_03);
		mapStr.put("selCheck302", selCheck3);
		mapStr.put("selCheck303", selCheck3);
		mapStr.put("selCheck304", selCheck3);
		
		mapStr.put("remark01", remark01);
		mapStr.put("remark02", remark02);
		mapStr.put("remark03", remark03);
		mapStr.put("remark", remark);
		
		mapStr.put("brand101", brand101);
		mapStr.put("brand102", brand101);
		mapStr.put("brand103", brand101);
		mapStr.put("brand104", brand101);
		mapStr.put("brand201", brand201);
		mapStr.put("brand202", brand201);
		mapStr.put("brand203", brand201);
		mapStr.put("brand204", brand201);
		mapStr.put("brand301", brand201);
		mapStr.put("brand302", brand301);
		mapStr.put("brand303", brand301);
		mapStr.put("brand304", brand301);

		mapStr.put("bxfw101", bxfw101);
		mapStr.put("bxfw102", bxfw101);
		mapStr.put("bxfw103", bxfw101);
		mapStr.put("bxfw104", bxfw101);
		mapStr.put("bxfw201", bxfw201);
		mapStr.put("bxfw202", bxfw201);
		mapStr.put("bxfw203", bxfw201);
		mapStr.put("bxfw204", bxfw201);
		mapStr.put("bxfw301", bxfw201);
		mapStr.put("bxfw302", bxfw301);
		mapStr.put("bxfw303", bxfw301);
		mapStr.put("bxfw304", bxfw301);

		mapStr.put("xbnf101", xbnf101);
		mapStr.put("xbnf102", xbnf101);
		mapStr.put("xbnf103", xbnf101);
		mapStr.put("xbnf104", xbnf101);
		mapStr.put("xbnf201", xbnf201);
		mapStr.put("xbnf202", xbnf201);
		mapStr.put("xbnf203", xbnf201);
		mapStr.put("xbnf204", xbnf201);
		mapStr.put("xbnf301", xbnf201);
		mapStr.put("xbnf302", xbnf301);
		mapStr.put("xbnf303", xbnf301);
		mapStr.put("xbnf304", xbnf301);

		mapStr.put("model101", model101);
		mapStr.put("model102", model101);
		mapStr.put("model103", model101);
		mapStr.put("model104", model101);
		mapStr.put("model201", model201);
		mapStr.put("model202", model201);
		mapStr.put("model203", model201);
		mapStr.put("model204", model201);
		mapStr.put("model301", model301);
		mapStr.put("model302", model301);
		mapStr.put("model303", model301);
		mapStr.put("model304", model301);
		mapStr.put("conf101", conf101);
		mapStr.put("conf102", conf101);
		mapStr.put("conf103", conf101);
		mapStr.put("conf104", conf101);
		mapStr.put("conf201", conf201);
		mapStr.put("conf202", conf201);
		mapStr.put("conf203", conf201);
		mapStr.put("conf204", conf201);
		mapStr.put("conf301", conf301);
		mapStr.put("conf302", conf301);
		mapStr.put("conf303", conf301);
		mapStr.put("conf304", conf301);
		mapStr.put("seq101", seq101);
		mapStr.put("seq102", seq101);
		mapStr.put("seq103", seq101);
		mapStr.put("seq201", seq201);
		mapStr.put("seq202", seq201);
		mapStr.put("seq203", seq201);
		mapStr.put("seq301", seq301);
		mapStr.put("seq302", seq301);
		mapStr.put("seq303", seq301);
		mapStr.put("Spec101", Spec101);
		mapStr.put("Spec102", Spec101);
		mapStr.put("Spec103", Spec101);
		mapStr.put("Spec201", Spec201);
		mapStr.put("Spec202", Spec201);
		mapStr.put("Spec203", Spec201);
		mapStr.put("Spec301", Spec301);
		mapStr.put("Spec302", Spec301);
		mapStr.put("Spec303", Spec301);
		mapStr.put("guar101", guar101);
		mapStr.put("guar102", guar101);
		mapStr.put("guar103", guar101);
		mapStr.put("guar104", guar101);
		mapStr.put("guar201", guar201);
		mapStr.put("guar202", guar201);
		mapStr.put("guar203", guar201);
		mapStr.put("guar204", guar201);
		mapStr.put("guar301", guar301);
		mapStr.put("guar302", guar301);
		mapStr.put("guar303", guar301);
		mapStr.put("guar304", guar301);
		mapStr.put("Discount101", Discount101);
		mapStr.put("Discount102", Discount101);
		mapStr.put("Discount103", Discount101);
		mapStr.put("Discount104", Discount101);
		mapStr.put("Discount201", Discount201);
		mapStr.put("Discount202", Discount201);
		mapStr.put("Discount203", Discount201);
		mapStr.put("Discount204", Discount201);
		mapStr.put("Discount301", Discount301);
		mapStr.put("Discount302", Discount301);
		mapStr.put("Discount303", Discount301);
		mapStr.put("Discount304", Discount301);
		mapStr.put("original101", original101);
		mapStr.put("original102", original101);
		mapStr.put("original103", original101);
		mapStr.put("original104", original101);
		mapStr.put("original201", original201);
		mapStr.put("original202", original201);
		mapStr.put("original203", original201);
		mapStr.put("original204", original201);
		mapStr.put("original301", original301);
		mapStr.put("original302", original301);
		mapStr.put("original303", original301);
		mapStr.put("original304", original301);
		
		iu.insert(mapStr, "uf_inquiryPrice");
	}
	String supplier_x = "";
	String price_x = "";
	
	if("1".equals(selCheck_01_04)){
		supplier_x = supplier_01_04;
		price_x	= price_01_04; 
	}else if("1".equals(selCheck_02_04)){
		supplier_x = supplier_02_04;
		price_x	= price_02_04; 
	}else if("1".equals(selCheck_03_04)){
		supplier_x = supplier_03_04;
		price_x	= price_03_04; 
	}else if("1".equals(selCheck_01_03)){
		supplier_x = supplier_01_03;
		price_x	= price_01_03; 
	}else if("1".equals(selCheck_02_03)){
		supplier_x = supplier_02_03;
		price_x	= price_02_03; 
	}else if("1".equals(selCheck_03_03)){
		supplier_x = supplier_03_03;
		price_x	= price_03_03; 
	}else if("1".equals(selCheck_01_02)){
		supplier_x = supplier_01_02;
		price_x	= price_01_02; 
	}else if("1".equals(selCheck_02_02)){
		supplier_x = supplier_02_02;
		price_x	= price_02_02; 
	}else if("1".equals(selCheck_03_02)){
		supplier_x = supplier_03_02;
		price_x	= price_03_02; 
	}else if("1".equals(selCheck1)){
		supplier_x = supplier_01;
		price_x	= price_01; 
	}else if("1".equals(selCheck2)){
		supplier_x = supplier_02;
		price_x	= price_02; 
	}else if("1".equals(selCheck3)){
		supplier_x = supplier_03;
		price_x	= price_03; 
	}
	
	Map<String, String> mapStr = new HashMap<String, String>();

	mapStr.put("Supplier", supplier_x);
	mapStr.put("Price", price_x);
	mapStr.put("AvgPrice", AvgPrice);
	mapStr.put("Stock", Stock);
	mapStr.put("Numbers", Numbers);
		
	iu.updateGen(mapStr, "formtable_main_73_dt1","val_1",deRemark);
	
	jspLog.writeLog("roleID = " + roleID + " ; " + roleID.length());
	if(!"sr".equals(savaType)){
	 
		response.sendRedirect("/seahonor/purchase/supplierPrice.jsp");
		
		
	}else{
		 String url_a = "<script>window.parent.location='"+ro_url+"'</script>";
	    response.getWriter().write(url_a);
		return;
		//String url_a=" <script> window.open( '"+ro_url+"', '_parent') </script> ";
	    //response.Write(url_a);
		//response.sendRedirect(ro_url);
	}

%>
	


	