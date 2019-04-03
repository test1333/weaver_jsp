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
	String handleRecord_main = request.getParameter("handleRecord_main");
	String type = request.getParameter("type");
	String idkey = request.getParameter("idkey");
	String idx = handleRecord_main+"-1";

		if("0".equals(type)){
	    int num = 0;

	    String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=0";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);
		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=0";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = "delete from uf_InHandleRd where mainid in ("+idx+")";
		rs.executeSql(sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsIn.jsp?idkey="+idkey+"");

	}else if("1".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=1";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=1";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = "delete from uf_BorrowHandleRd where mainid in ("+idx+")";
		rs.executeSql(sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsBorrow.jsp?idkey="+idkey+"");


	}
	else if("2".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=2";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=2";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_ReturnHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsReturn.jsp?idkey="+idkey+"");

	}
	else if("3".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=3";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=3 ";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_ReceiveHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsReceive.jsp?idkey="+idkey+"");

	}
	else if("4".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=4";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock-"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=4";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_RbHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsReturnBack.jsp?idkey="+idkey+"");

	}
	else if("5".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=5";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=5 ";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_LossHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsLoss.jsp?idkey="+idkey+"");

	}
	else if("6".equals(type)){
		int num = 0;
		String sql_num = "select abs(sum(handlenum)) as totalnum from uf_differhandle where id in ("+idx+") and handletype=6";
		rs.executeSql(sql_num);
		if(rs.next()){
           num = rs.getInt("totalnum");
	    }
		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+"+num+" where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype=6 ";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_ScrapHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		response.sendRedirect("/seahonor/jsp/AssetsScrap.jsp?idkey="+idkey+"");

	}
	else if("7".equals(type)){
		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype= 7";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_RepairHandleRd where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+1 where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsRepair.jsp?idkey="+idkey+"");


	}else if("8".equals(type)){
		String sql_maindelrd = "delete from uf_differhandle where id in ("+idx+") and handletype= 8";
		rs.executeSql(sql_maindelrd);

		String sql_delrd = " delete from uf_CustomerReturn where Mainid in ("+idx+")";
		rs.executeSql(sql_delrd);
		out.println("sql_delrd="+sql_delrd);

		String sql_upstock = " update uf_checkrecord_dt1 set stock = stock+1 where id = "+idkey+"";
		rs.executeSql(sql_upstock);

		response.sendRedirect("/seahonor/jsp/AssetsCustomerReturn.jsp?idkey="+idkey+"");


	}
	
%>

