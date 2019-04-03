<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<%

      String identity = request.getParameter("identity");
      String type = request.getParameter("type");
      if("1".equals(type)){
      //Ã÷Ï¸1
       StringBuffer buff = new StringBuffer();
      String XXQR = "";
      String XXZR = "";
      String BYYX = "";
      String ZY = "";
      String XL = "";
      String XLBM = "";
      String XW = "";
      String XWBM = "";
      String DD = "";
      String RXZK = "";
      String RXZKBM = "";
      String BYZK = "";
      String BYZKBM = "";


      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt1 where mainid = "+identity+" ";
      rs.executeSql(sql);
		while(rs.next()) {
         XXQR =Util.null2String(rs.getString("XXQR"));
   		XXZR =Util.null2String(rs.getString("XXZR"));
         BYYX =Util.null2String(rs.getString("BYYX"));
         ZY =Util.null2String(rs.getString("ZY"));
         XL =Util.null2String(rs.getString("XL"));
         XLBM =Util.null2String(rs.getString("XLBM"));
         XW =Util.null2String(rs.getString("XW"));
         XWBM =Util.null2String(rs.getString("XWBM"));
         DD =Util.null2String(rs.getString("DD"));
         RXZK =Util.null2String(rs.getString("RXZK"));
         RXZKBM =Util.null2String(rs.getString("RXZKBM"));
         BYZK =Util.null2String(rs.getString("BYZK"));
         BYZKBM =Util.null2String(rs.getString("BYZKBM"));

            buff.append(XXQR);buff.append("###");
            buff.append(XXZR);buff.append("###");
            buff.append(BYYX);buff.append("###");
            buff.append(ZY);buff.append("###");
            buff.append(XL);buff.append("###");
            buff.append(XLBM);buff.append("###");
            buff.append(XW);buff.append("###");
            buff.append(XWBM);buff.append("###");
            buff.append(DD);buff.append("###");
            buff.append(RXZK);buff.append("###");
            buff.append(RXZKBM);buff.append("###");
            buff.append(BYZK);buff.append("###");
            buff.append(BYZKBM);buff.append("@@@");
		}
		out.print(buff.toString());
     }
  }else if("2".equals(type)){
    //Ã÷Ï¸2
     	StringBuffer buff = new StringBuffer();
      String ybrgx_dt2 = "";
      String xm_dt2 = "";
      String zjlb_dt2 = "";
      String zjhm_dt2 = "";
      String csrq_dt2 = "";
      String xl_dt2 = "";
      String zy_dt2= "";
      String gzdw_dt2 = "";
      String zjlbbm_dt2 = "";
      String xlbm_dt2 = "";
      String lxdh_dt2 = "";


      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt2 where mainid = "+identity+" ";
      rs.executeSql(sql);
		while(rs.next()) {
         ybrgx_dt2 =Util.null2String(rs.getString("YBRGX"));
   		xm_dt2 =Util.null2String(rs.getString("XM"));
         zjlb_dt2 =Util.null2String(rs.getString("RFCZJLB"));
         zjhm_dt2 =Util.null2String(rs.getString("ZJHM"));
         csrq_dt2 =Util.null2String(rs.getString("CSNY"));
         xl_dt2 =Util.null2String(rs.getString("XL"));
         zy_dt2 =Util.null2String(rs.getString("ZY"));
         gzdw_dt2 =Util.null2String(rs.getString("GZDW"));
         zjlbbm_dt2 =Util.null2String(rs.getString("ZJLBBM"));
         xlbm_dt2 =Util.null2String(rs.getString("RFCXL"));
         lxdh_dt2 =Util.null2String(rs.getString("LXDH"));

            buff.append(ybrgx_dt2);buff.append("###");
            buff.append(xm_dt2);buff.append("###");
            buff.append(zjlb_dt2);buff.append("###");
            buff.append(zjhm_dt2);buff.append("###");
            buff.append(csrq_dt2);buff.append("###");
            buff.append(xl_dt2);buff.append("###");
            buff.append(zy_dt2);buff.append("###");
            buff.append(gzdw_dt2);buff.append("###");
            buff.append(zjlbbm_dt2);buff.append("###");
            buff.append(xlbm_dt2);buff.append("###");
            buff.append(lxdh_dt2);buff.append("@@@");
		}
		out.print("aaaaa");
     }
 } 

%>
