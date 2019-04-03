<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_detail" class="weaver.conn.RecordSet" scope="page"/>
<%
	StringBuffer dataBuff = new StringBuffer();

    String qj_id = request.getParameter("id");//采购单ID

	String requestId = "";//id
	String  Name  = "";//商品名称ID
	String  goodname = "";//商品名称
	String ActualNumbers = "";//计划数量
	String Price = "";//计划单价
	String haspurchasenum = "";//已采购数量
	String sql = "";

   	String qjName = "";//时数
	String jb = "";//假别
	String ks = "";//开始日期
	String kssj = "";//开始时间
	String js = "";//结束日期
	String jssj = "";//结束时间
	String unitname = "";//单位
	String goodscatex = "";//类别名称id
	String catename = "";//所属类别
	String goodscatexID = "";//所属类别id
	String deremark = "";//商品标识
	String Supplier = "";//供应商
	String SupplierName = "";//供应商名
		
	String selCheck104= "";
	String selCheck204= "";
	String selCheck304= "";
	String brand= "";//品牌
	String model = "";//型号
	String conf = "";//配置
	String bxfw= "";//保修范围
	String xbnf = "";//续保年费
		
      //out.print("gw_id ="+gw_id);
      if(qj_id.length()>0){
     // String sql = " select f1.gwjn,f2.pxkc from formtable_main_235 f1 left join formtable_main_235_dt1 f2 on  f1.id = f2.mainid where f1.id = "+gw_id;

     //这是在java中注释
	  /* String sql = " select f1.sy,f1.requestId,f2.SS,f2.SQSJ1,f2.SQSJ2,case f2.JB when '0' then '事假' when '1' then '病假' when '2' then '年假' when '3' then '婚假' when '4' then '产假' when '5' then '丧假' when '6' then '寿假' when '7' then '工伤假' when '8' then '哺乳假' when '9' then '护理假' when '10' then '特休假' else '其他假' end jb,f2.SQSJ3,f2.SQSJ4 from formtable_main_58_dt1 f2 "
		+"left join formtable_main_58 f1  on  f1.id = f2.mainid where f2.mainid = (select id from formtable_main_58 where requestId = " +qj_id+ ")"; */

		/*String sql = " select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodsname,f2.ActualNumbers,f2.Price from formtable_main_45_dt1 f2 left join  formtable_main_45 f1 on f1.id = f2.mainid where f2.mainid = (select id from formtable_main_45 where requestId = " +qj_id+ ")";*/

		//formtable_main_74是入库表单 formtable_main_73是月度采购表单
		sql = "select * from (select sum(purchasenum) haspurchasenum,goodsname from formtable_main_74_dt1 "+
		"where mainid in (select id from formtable_main_74 where MonthPurchase ="+qj_id+" and "+
		"  requestid in(select requestid from workflow_requestbase where currentnodetype >0 )) group by goodsname) s1 "+
		"right join (select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodname,"+
		"f2.ActualNumbers,f2.Price,f2.val_1,f2.Supplier,(select name from uf_supplier where id = f2.Supplier) as SupplierName  from formtable_main_73_dt1 f2 left join  formtable_main_73 f1 on f1.id = f2.mainid"
		+" where f2.mainid = (select id from formtable_main_73 where requestId ="+qj_id+" )) s2 on s1.goodsname=s2.Name";

		//out.print("sql="+sql);
        rs.executeSql(sql);
		while( rs.next() ) {	
              
              deremark = Util.null2String(rs.getString("val_1"));
		ActualNumbers = Util.null2String(rs.getString("ActualNumbers"));
		haspurchasenum = Util.null2String(rs.getString("haspurchasenum"));

		if(ActualNumbers.equals(haspurchasenum))
			continue;

		Name = Util.null2String(rs.getString("Name"));
		dataBuff.append(Name);
		dataBuff.append("###");

		goodname = Util.null2String(rs.getString("goodname"));
		goodname = goodname.replaceAll("&nbsp;", " ");
		dataBuff.append(goodname);
		dataBuff.append("###");

		
		dataBuff.append(ActualNumbers);
		dataBuff.append("###");
	
		Price = Util.null2String(rs.getString("Price"));
   		dataBuff.append(Price);
		dataBuff.append("###");

		sql = "select id,unitname from LgcAssetUnit where id in(select unit from uf_goodsinfo where id="+Name+")";
		res.executeSql(sql);
		if(res.next()) {	
		   	unitname = Util.null2String(res.getString("unitname"));
					dataBuff.append(unitname);
					dataBuff.append("###");	 
                        String unitnID = Util.null2String(res.getString("ID"));
                         dataBuff.append(unitnID);
					dataBuff.append("###");	
                }
	
		sql = "select goodscatex from uf_goodsinfo where id="+Name+"";
		
		//out.print("sql="+sql);
		res.executeSql(sql);
		while(res.next()) {	
			goodscatexID = Util.null2String(res.getString("goodscatex"));
		   	goodscatex = Util.null2String(res.getString("goodscatex")).substring(3);

			//out.print("goodscatex="+goodscatex);
			
		   		String sql_1 = "select catename from uf_goodscate where id in ("+goodscatex+")";
		   		
   				rs2.executeSql(sql_1);
   					if(rs2.next()) {	
   						catename = Util.null2String(rs2.getString("catename"));
						dataBuff.append(catename);
						dataBuff.append("###");
						//dataBuff.append(goodscatex);
						dataBuff.append(goodscatexID);
						dataBuff.append("###");
                                                
					}	
		 }	



		haspurchasenum = Util.null2String(rs.getString("haspurchasenum"));
			if(haspurchasenum.equals("")){
				haspurchasenum = "0";
			}
	   		dataBuff.append(haspurchasenum);
	   		dataBuff.append("###");
	   		
	   		String sql_detail = "select * from uf_inquiryPrice where deremark= "+deremark+" and reID = "+qj_id;
	   		
	   		rs_detail.executeSql(sql_detail);
	   		if(rs_detail.next()){
	   			selCheck104 = Util.null2String(rs_detail.getString("selCheck104"));
	   			selCheck204 = Util.null2String(rs_detail.getString("selCheck204"));
	   			selCheck304 = Util.null2String(rs_detail.getString("selCheck304"));
	   			if("1".equals(selCheck104)){
	   				brand = Util.null2String(rs_detail.getString("brand104"));
	   				model = Util.null2String(rs_detail.getString("model104"));
	   				conf = Util.null2String(rs_detail.getString("conf104"));
	   				bxfw = Util.null2String(rs_detail.getString("bxfw104"));
	   				xbnf = Util.null2String(rs_detail.getString("xbnf104"));
	   			}
	   			if("1".equals(selCheck204)){
	   				brand = Util.null2String(rs_detail.getString("brand204"));
	   				model = Util.null2String(rs_detail.getString("model204"));
	   				conf = Util.null2String(rs_detail.getString("conf204"));
	   				bxfw = Util.null2String(rs_detail.getString("bxfw204"));
	   				xbnf = Util.null2String(rs_detail.getString("xbnf204"));
	   			}	
	   			if("1".equals(selCheck304)){
	   				brand = Util.null2String(rs_detail.getString("brand304"));
	   				model = Util.null2String(rs_detail.getString("model304"));
	   				conf = Util.null2String(rs_detail.getString("conf304"));
	   				bxfw = Util.null2String(rs_detail.getString("bxfw304"));
	   				xbnf = Util.null2String(rs_detail.getString("xbnf304"));
	   			}
	   			
	       	}
	       	dataBuff.append(brand);
	   		dataBuff.append("###");
	   		dataBuff.append(model);
	   		dataBuff.append("###");
	   		dataBuff.append(conf);
	   		dataBuff.append("###");
	   		dataBuff.append(bxfw);
	   		dataBuff.append("###");
	   		dataBuff.append(xbnf);
	   		dataBuff.append("###");
	   		
	   		Supplier = Util.null2String(rs.getString("Supplier"));
	       	dataBuff.append(Supplier);
	      	dataBuff.append("###");
	      	SupplierName = Util.null2String(rs.getString("SupplierName"));
	       	dataBuff.append(SupplierName);
			dataBuff.append("@@@");

			
		}
		out.print(dataBuff.toString());
   }
%>