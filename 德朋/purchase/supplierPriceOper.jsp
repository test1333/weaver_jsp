<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="dp.util.InsertUtil"%>
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
    String sql="";
	String mainid="";
	String dtid="";
	String reID = Util.null2String(request.getParameter("reID"));
	String roleID = Util.null2String(request.getParameter("roleID"));
	String xjr = Util.null2String(request.getParameter("xjr"));
	String nodeid = Util.null2String(request.getParameter("nodeid"));
	String selCheck1 = Util.null2String(request.getParameter("selCheck1"));
	String selCheck2 = Util.null2String(request.getParameter("selCheck2"));
	String selCheck3 = Util.null2String(request.getParameter("selCheck3"));
	String gys1 = Util.null2String(request.getParameter("gys1"));
	String gys2 = Util.null2String(request.getParameter("gys2"));
	String gys3 = Util.null2String(request.getParameter("gys3"));
	String jg1 = Util.null2String(request.getParameter("jg1"));
	String jg2 = Util.null2String(request.getParameter("jg2"));
	String jg3 = Util.null2String(request.getParameter("jg3"));
	String bz1 = Util.null2String(request.getParameter("bz1"));
	String bz2 = Util.null2String(request.getParameter("bz2"));
	String bz3 = Util.null2String(request.getParameter("bz3"));
	//jspLog.writeLog("deRemark = " + deRemark);
	InsertUtil iu = new InsertUtil();
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
	
	
	

	if(!"1".equals(selCheck1))  selCheck1 = "0";
	if(!"1".equals(selCheck2))  selCheck2 = "0";
	if(!"1".equals(selCheck3))  selCheck3 = "0";
	
	//InsertUtil iu = new InsertUtil();
	boolean isUpdate = false;
	String tmp_sql = "select count(id) as count_cc from uf_inquiryPrice where deRemark="+deRemark;
	rs.executeSql(tmp_sql);
	if(rs.next()) {
		int flag_s = rs.getInt("count_cc");
		if(flag_s > 0) isUpdate = true;
	}
	if(isUpdate){
        Map<String, String> mapStr = new HashMap<String, String>();
		mapStr.put("deRemark", deRemark);
		mapStr.put("name", pro_name);
		mapStr.put("reID", reID);		
		iu.updateGen(mapStr, "uf_inquiryPrice","deRemark",deRemark);
		sql="select id from uf_inquiryPrice where deRemark="+deRemark;
		mainid="";
		rs.executeSql(sql);
		if(rs.next()){
           mainid = Util.null2String(rs.getString("id"));
		}
			Map<String, String> mapStr_dt1 = new HashMap<String, String>();
			mapStr_dt1.put("gys", gys1);
			mapStr_dt1.put("jg", jg1);
			mapStr_dt1.put("bz", bz1);
			mapStr_dt1.put("xjr", xjr);
			mapStr_dt1.put("nodeid", nodeid);
			mapStr_dt1.put("selcheck", selCheck1);
			mapStr_dt1.put("mainid", mainid);
			sql="select id from uf_inquiryPrice_dt1 where mainid="+mainid+" and seqno='1'";
		    dtid="";
			rs.executeSql(sql);
			if(rs.next()){
          	 dtid = Util.null2String(rs.getString("id"));
			}
			iu.updateGen(mapStr_dt1, "uf_inquiryPrice_dt1","id",dtid);
			Map<String, String> mapStr_dt2 = new HashMap<String, String>();
			mapStr_dt2.put("gys", gys2);
			mapStr_dt2.put("jg", jg2);
			mapStr_dt2.put("bz", bz2);
			mapStr_dt2.put("xjr", xjr);
			mapStr_dt2.put("nodeid", nodeid);
			mapStr_dt2.put("selcheck", selCheck2);
			mapStr_dt2.put("mainid", mainid);
			sql="select id from uf_inquiryPrice_dt1 where mainid="+mainid+" and seqno='2'";
		    dtid="";
			rs.executeSql(sql);
			if(rs.next()){
          	 dtid = Util.null2String(rs.getString("id"));
			}
			iu.updateGen(mapStr_dt2, "uf_inquiryPrice_dt1","id",dtid);
			Map<String, String> mapStr_dt3 = new HashMap<String, String>();
			mapStr_dt3.put("gys", gys3);
			mapStr_dt3.put("jg", jg3);
			mapStr_dt3.put("bz", bz3);
			mapStr_dt3.put("xjr", xjr);
			mapStr_dt3.put("nodeid", nodeid);
			mapStr_dt3.put("selcheck", selCheck3);
			mapStr_dt2.put("mainid", mainid);
			sql="select id from uf_inquiryPrice_dt1 where mainid="+mainid+" and seqno='3'";
		    dtid="";
			rs.executeSql(sql);
			if(rs.next()){
          	 dtid = Util.null2String(rs.getString("id"));
			}
			iu.updateGen(mapStr_dt3, "uf_inquiryPrice_dt1","id",dtid);

     
	 	
	}else{
		Map<String, String> mapStr = new HashMap<String, String>();
		mapStr.put("deRemark", deRemark);
		mapStr.put("name", pro_name);
		mapStr.put("reID", reID);		
		iu.insert(mapStr, "uf_inquiryPrice");
		sql="select id from uf_inquiryPrice where deRemark="+deRemark;
		 mainid="";
		rs.executeSql(sql);
		if(rs.next()){
           mainid = Util.null2String(rs.getString("id"));
		}
			Map<String, String> mapStr_dt1 = new HashMap<String, String>();
			mapStr_dt1.put("gys", gys1);
			mapStr_dt1.put("jg", jg1);
			mapStr_dt1.put("bz", bz1);
			mapStr_dt1.put("seqno", "1");
			mapStr_dt1.put("xjr", xjr);
			mapStr_dt1.put("nodeid", nodeid);
			mapStr_dt1.put("selcheck", selCheck1);
			mapStr_dt1.put("mainid", mainid);
			iu.insert(mapStr_dt1, "uf_inquiryPrice_dt1");
			Map<String, String> mapStr_dt2 = new HashMap<String, String>();
			mapStr_dt2.put("gys", gys2);
			mapStr_dt2.put("jg", jg2);
			mapStr_dt2.put("bz", bz2);
			mapStr_dt2.put("seqno", "2");
			mapStr_dt2.put("xjr", xjr);
			mapStr_dt2.put("nodeid", nodeid);
			mapStr_dt2.put("selcheck", selCheck2);
			mapStr_dt2.put("mainid", mainid);
			iu.insert(mapStr_dt2, "uf_inquiryPrice_dt1");
			Map<String, String> mapStr_dt3 = new HashMap<String, String>();
			mapStr_dt3.put("gys", gys3);
			mapStr_dt3.put("jg", jg3);
			mapStr_dt3.put("bz", bz3);
			mapStr_dt3.put("seqno", "3");
			mapStr_dt3.put("xjr", xjr);
			mapStr_dt3.put("nodeid", nodeid);
			mapStr_dt3.put("selcheck", selCheck3);
			mapStr_dt3.put("mainid", mainid);
			iu.insert(mapStr_dt3, "uf_inquiryPrice_dt1");

	}
	String supplier_x = "";
	String price_x = "";
	String otherPrice_x = "";
if("1".equals(selCheck1)){
		supplier_x = gys1;
		price_x = jg1;
	}else if("1".equals(selCheck2)){
		supplier_x = gys2;
		price_x = jg2;
	}else if("1".equals(selCheck3)){
		supplier_x = gys3;
		price_x = jg3;
	}
	
	Map<String, String> mapStr1 = new HashMap<String, String>();

	mapStr1.put("gysh", supplier_x);
	mapStr1.put("cgdj", price_x);

		
	iu.updateGen(mapStr1, "formtable_main_23_dt1","val",deRemark);
	
	//jspLog.writeLog("roleID = " + roleID + " ; " + roleID.length());
	if(!"sr".equals(savaType)){
	 
		response.sendRedirect("/dp/purchase/supplierPrice.jsp");
		
		
	}else{
		 String url_a = "<script>window.parent.location='"+ro_url+"'</script>";
	    response.getWriter().write(url_a);
		return;
		//String url_a=" <script> window.open( '"+ro_url+"', '_parent') </script> ";
	    //response.Write(url_a);
		//response.sendRedirect(ro_url);
	}

%>
	


	