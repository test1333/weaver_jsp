<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	String type = request.getParameter("type");
	String idkey = request.getParameter("idkey");
	int userid = user.getUID();
	String layplace = "";
	String checkid = "";
    String assets = "";
    String goodsno = "";
    String createdate = "";
    String brand = "";
    String sizex = "";
    String configuration = "";
    float price = 0;
	String sql_checkid = "select * from uf_checkrecord_dt1 where id = "+idkey+"";
	rs.executeSql(sql_checkid);
	if(rs.next()){
		checkid =  Util.null2String(rs.getString("mainid"));
		assets =  Util.null2String(rs.getString("assets"));
	}
	String sql_layplace = "select id from uf_layplace where admin = "+userid+"";
	rs.executeSql(sql_layplace);
	if(rs.next()){
		layplace =  Util.null2String(rs.getString("id"));
	}
	int stockx = 0;
	String sql_stock = "select SUM(stock) as stock from uf_outinrecord where operaterecord = 0  and goodsname = "+assets+" and "+
						" layplace in (select id from uf_layplace where issealed =0 and admin = "+userid+")";
	rs.executeSql(sql_stock);
	if(rs.next()){
		stockx =  rs.getInt("stock");
    }
    	String infoid ="";
		String goodscate ="";
		String unit ="";
		String isindependent ="";
		String customerx ="";
		String status ="";
		String supplier ="";
		String supplieraddress ="";
		String suppliercontacts ="";
		String suppliertel ="";
		String sql_goodsinfo ="select * from uf_goodsinforecord where id = "+assets+"";
		rs.executeSql(sql_goodsinfo);
		if(rs.next()){
			infoid =  Util.null2String(rs.getString("infoid"));
			goodscate =  Util.null2String(rs.getString("goodscate"));
			unit =  Util.null2String(rs.getString("unit"));
			createdate =  Util.null2String(rs.getString("modedatacreatedate"));
			price =  rs.getFloat("price");
			brand =  Util.null2String(rs.getString("brand"));
			sizex =  Util.null2String(rs.getString("cate"));
			configuration =  Util.null2String(rs.getString("configuration"));
			goodsno =  Util.null2String(rs.getString("goodsno"));
			isindependent =  Util.null2String(rs.getString("isindependent"));
			status =  Util.null2String(rs.getString("status"));
			customerx =  Util.null2String(rs.getString("customer"));
			supplier =  Util.null2String(rs.getString("supplier"));
			supplieraddress =  Util.null2String(rs.getString("supplieraddress"));
			suppliercontacts =  Util.null2String(rs.getString("suppliercontacts"));
			suppliertel =  Util.null2String(rs.getString("suppliertel"));
		}

	if("0".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String origin = Util.null2String(request.getParameter("origin"));
		String customer = Util.null2String(request.getParameter("customer"));
		String currency = Util.null2String(request.getParameter("currency"));
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',0,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_In = "insert into uf_InHandleRd (CheckId,Idkey,Assetsname,Currency,InNum,Original,Customer,Remark,Mainid,AssetsCate,Unit,Account) "+
					" values("+checkid+","+idkey+","+infoid+",'"+currency+"',"+num+",'"+origin+"','"+customer+"','"+remark+"',"+main_handleid+",'"+goodscate+"',"+unit+","+currency+"*"+num+")";
		rs.executeSql(sql_insert_In);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsIn.jsp?idkey="+idkey+"");

	}else if("1".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String deTime = Util.null2String(request.getParameter("changedate"));
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',1,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_borrow = "insert into uf_BorrowHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,BorrowNum,ReturnDate,Remark,Mainid,AssetsCate,AssetsNo, "+
		 						   "Layplace,CreateDate,Price,Account,Stock,LeftStock,Brand,Sizex,Configuration)"+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+",'"+deTime+"','"+remark+"',"+main_handleid+",'"+goodscate+"',"+
								" '"+goodsno+"',"+layplace+",'"+createdate+"','"+price+"',"+price+"*"+num+","+stockx+","+stockx+"-"+num+",'"+brand+"','"+sizex+"','"+configuration+"')";
		rs.executeSql(sql_insert_borrow);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsBorrow.jsp?idkey="+idkey+"");

	}
	else if("2".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
					" values("+assets+",'"+goodsno+"',2,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}
		int num1 = 0;
        String sql_a = "select sum(num) as num1 from uf_goodsborrow where goodsname ="+assets+" and applicant = "+applicant+" and num!=isNull(alreadlyreturn,0) "+
					" and layplace in (select id from uf_layplace where issealed =0 and admin = "+userid+") and status =1";
		rs.executeSql(sql_a);
		if(rs.next()){
			num1 =  rs.getInt("num1");
		}
		int num2 = 0;
		String sql_b = "select sum(num-isnull(alreadlyreturn,0)) as num2 from uf_goodsborrow where "+
				" goodsname = "+assets+" and applicant ="+applicant+" and num !=isNull(alreadlyreturn,0) and layplace in (select id from uf_layplace where issealed =0 and admin ="+userid+") "+
					" and status =1";
		rs.executeSql(sql_a);
		if(rs.next()){
			num2 = rs.getInt("num2");
		}

		String sql_insert_return = "insert into uf_ReturnHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,ReturnNum,Remark,Mainid,AssetsCate,AssetsNo,ReurnDate,"+
								"  BorrowNum,AlreadlyReturnNum,Layplace,CreateDate) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+",'"+remark+"',"+main_handleid+",'"+goodscate+"','"+goodsno+"',"+
					" CONVERT(varchar(100), GETDATE(), 23),"+num1+","+num2+","+layplace+",'"+createdate+"')";
		rs.executeSql(sql_insert_return);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsReturn.jsp?idkey="+idkey+"");

	}
	else if("3".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String project = Util.null2String(request.getParameter("project"));
		String remark = Util.null2String(request.getParameter("desc"));

		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',3,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_Receive = "insert into uf_ReceiveHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,ReceiveNum,Project,Remark,Mainid," +
									" AssetsCate,Layplace,Price,Accout,Stock,LeftStock) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+","+project+",'"+remark+"',"+main_handleid+", "+
								" '"+goodscate+"',"+layplace+","+price+","+price+"*"+num+","+stockx+","+stockx+"-"+num+")";
		rs.executeSql(sql_insert_Receive);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsReceive.jsp?idkey="+idkey+"");

	}
	else if("4".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',4,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		int num1 = 0;
        String sql_a = "select sum(num) as num1 from uf_goodsreceive where goodsname ="+assets+" and applicant ="+applicant+" and num !=isNull(alreadlyreturn,0) "+
        				" and layplace in (select id from uf_layplace where issealed =0 and admin ="+userid+") and status =1";
		rs.executeSql(sql_a);
		if(rs.next()){
			num1 =  rs.getInt("num1");
		}
		int num2 = 0;
		String sql_b = "select sum(num-isnull(alreadlyreturn,0)) from  uf_goodsreceive  where goodsname ="+assets+" and  applicant ="+applicant+" and num!= isNULL(alreadlyreturn,0) "+
						" and layplace in (select id from uf_layplace where issealed =0 and admin ="+userid+") and status =1";
		rs.executeSql(sql_a);
		if(rs.next()){
			num2 = rs.getInt("num2");
		}

		String sql_insert_Rb = "insert into uf_RbHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,ReturnBackNum,Remark,Mainid,"+
		 						"  AssetsCate,AssetsNo,Layplace,ReceiveNum,AlreadlyRbNum,RbDate) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+",'"+remark+"',"+main_handleid+","+
								" '"+goodscate+"','"+goodsno+"',"+layplace+","+num1+","+num2+",CONVERT(varchar(100), GETDATE(), 23))";
		rs.executeSql(sql_insert_Rb);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsReturnBack.jsp?idkey="+idkey+"");

	}
	else if("5".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',5,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_Loss = "insert into uf_LossHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,LossNum,Remark,Mainid, "+
								 "AssetsCate,AssetsNo,Price,CreateDate,Layplace,Years,Status,Isindependent,Stock,LeftStock) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+",'"+remark+"',"+main_handleid+","+
								" '"+goodscate+"','"+goodsno+"',"+price+",'"+createdate+"',"+layplace+",dbo.diff_now("+assets+") ,"+
								" "+status+","+isindependent+","+stockx+","+stockx+"-"+num+")";
		rs.executeSql(sql_insert_Loss);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsLoss.jsp?idkey="+idkey+"");

	}
	else if("6".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String currency = Util.null2String(request.getParameter("currency"));
		String remark = Util.null2String(request.getParameter("desc"));

		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',6,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		int num1 = 0;
        String sql_a = "select SUM(stock) from uf_outinrecord where operaterecord = 0  and goodsname = "+assets+"";
		rs.executeSql(sql_a);
		if(rs.next()){
			num1 =  rs.getInt("num1");
		}

		String sql_insert_Scrap = "insert into uf_ScrapHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,ScrapNum,Account,Remark,Mainid,"+
								"	AssetsCate,AssetsNo,CreateDate,Years,Price,Stock) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+num+",'"+currency+"','"+remark+"',"+main_handleid+","+
								" '"+goodscate+"','"+goodsno+"','"+createdate+"',dbo.diff_now("+assets+"),"+price+","+num1+")";
		rs.executeSql(sql_insert_Scrap);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-abs("+num+") where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsScrap.jsp?idkey="+idkey+"");

	}
	else if("7".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String isindate = request.getParameter("isindate");
		String currency = request.getParameter("currency");
		String days = request.getParameter("days");
		String content = request.getParameter("content");
		String remark = Util.null2String(request.getParameter("desc"));

		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',7,"+userid+","+applicant+",1,'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_Repair = "insert into uf_RepairHandleRd (Applicant,Admin,CheckId,Idkey,Assetsname,isInPeriod,Account,RepairDays,Content,Remark,Mainid,"+
									"AssetsCate,AssetsNo,Status,Price,CreateDate,Years,supplier,supplieraddress,suppliercontacts,suppliertel) "+
					" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+","+isindate+",'"+currency+"',"+days+",'"+content+"','"+remark+"',"+main_handleid+","+
								" '"+goodscate+"','"+goodsno+"',"+status+","+price+",'"+createdate+"',dbo.diff_now("+assets+"),"+
								" '"+supplier+"','"+supplieraddress+"','"+suppliercontacts+"','"+suppliertel+"')";
		rs.executeSql(sql_insert_Repair);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-1 where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsRepair.jsp?idkey="+idkey+"");
	}
	else if("8".equals(type)){
		String main_handleid = "";
		String applicant = request.getParameter("applicant");
		String remark = Util.null2String(request.getParameter("desc"));
		String sql_insert_main = " insert into uf_differhandle (handleassets,handleno,handletype,creater,applicant,handlenum,handleremark,CheckID,IdKey)" +
								" values("+assets+",'"+goodsno+"',8,"+userid+","+applicant+",1,'"+remark+"',"+checkid+","+idkey+")";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_Loss = "insert into uf_CustomerReturn (Applicant,Admin,CheckId,Idkey,Assetsname,ReturnNum,Remark,Mainid, "+
								 "AssetsCate,AssetsNo,CreateDate,Brand,Sizex,Price,Customer) "+
								" values("+applicant+","+userid+","+checkid+","+idkey+","+assets+",1,'"+remark+"',"+main_handleid+","+
								" '"+goodscate+"','"+goodsno+"','"+createdate+"','"+brand+"','"+sizex+"',"+price+",'"+customerx+"')";
		rs.executeSql(sql_insert_Loss);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-1 where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsCustomerReturn.jsp?idkey="+idkey+"");

	}

%>
<script type="text/javascript">
	var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>
