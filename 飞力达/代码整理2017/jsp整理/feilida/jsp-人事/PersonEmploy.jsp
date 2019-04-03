<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<%

      String identity = request.getParameter("identity");
         StringBuffer buff = new StringBuffer();
      String type = request.getParameter("type");
      if("1".equals(type)){
      //明细1 
    
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
	
     }
  }else if("2".equals(type)){
    //明细2
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
     }
 }else if("3".equals(type)){
     //明细3
      String GZQR3 = "";
      String GZZR3 = "";
      String GSMC3 = "";
      String DD3 = "";
      String ZW3 = "";
      String XZ3 = "";
      String ZGXM3= "";
      String ZGZW3 = "";
      String LXDH3 = "";
      String LZYY3 = "";


      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt3 where mainid = "+identity+" ";
      rs.executeSql(sql);
      while(rs.next()) {
         GZQR3 =Util.null2String(rs.getString("GZQR"));
         GZZR3 =Util.null2String(rs.getString("GZZR"));
         GSMC3 =Util.null2String(rs.getString("GSMC"));
         DD3 =Util.null2String(rs.getString("DD"));
         ZW3 =Util.null2String(rs.getString("ZW"));
         XZ3 =Util.null2String(rs.getString("XZNEW"));
         ZGXM3 =Util.null2String(rs.getString("ZGXM"));
         ZGZW3 =Util.null2String(rs.getString("ZGZW"));
         LXDH3 =Util.null2String(rs.getString("LXDH"));
         LZYY3 =Util.null2String(rs.getString("LZYY"));

            buff.append(GZQR3);buff.append("###");
            buff.append(GZZR3);buff.append("###");
            buff.append(GSMC3);buff.append("###");
            buff.append(DD3);buff.append("###");
            buff.append(ZW3);buff.append("###");
            buff.append(XZ3);buff.append("###");
            buff.append(ZGXM3);buff.append("###");
            buff.append(ZGZW3);buff.append("###");
            buff.append(LXDH3);buff.append("###");
            buff.append(LZYY3);buff.append("@@@");
      }
     }

}else if("4".equals(type)){
      //明细4
      String PXQS4 = "";
      String PXQZ4 = "";
      String PXJG4 = "";
      String PXNR4 = "";
      String ZGZS4 = "";
      String ZGZSDJ4 = "";
      String ZYZS4= "";
      String ZYZSDJ4 = "";
      String PFRQ4 = "";
      String ZSYXQ4 = "";


      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt4 where mainid = "+identity+" ";
      rs.executeSql(sql);
      while(rs.next()) {
         PXQS4 =Util.null2String(rs.getString("PXQS"));
         PXQZ4 =Util.null2String(rs.getString("PXQZ"));
         PXJG4 =Util.null2String(rs.getString("PXJG"));
         PXNR4 =Util.null2String(rs.getString("PXNR"));
         ZGZS4 =Util.null2String(rs.getString("ZGZS"));
         ZGZSDJ4 =Util.null2String(rs.getString("ZGZSDJ"));
         ZYZS4 =Util.null2String(rs.getString("ZYZS"));
         ZYZSDJ4 =Util.null2String(rs.getString("ZYZSDJ"));
         PFRQ4 =Util.null2String(rs.getString("PFRQ"));
         ZSYXQ4 =Util.null2String(rs.getString("ZSYXQ"));

            buff.append(PXQS4);buff.append("###");
            buff.append(PXQZ4);buff.append("###");
            buff.append(PXJG4);buff.append("###");
            buff.append(PXNR4);buff.append("###");
            buff.append(ZGZS4);buff.append("###");
            buff.append(ZGZSDJ4);buff.append("###");
            buff.append(ZYZS4);buff.append("###");
            buff.append(ZYZSDJ4);buff.append("###");
            buff.append(PFRQ4);buff.append("###");
            buff.append(ZSYXQ4);buff.append("@@@");
      }
     }  
}else if("5".equals(type)){
     //明细4
      String ZSYXQ5 = "";
      String WYDJ5 = "";
      String ZSMC5 = "";
      String HZSJ5 = "";
      String MQSLD5 = "";
      String MQSLDBM5 = "";
      String ZSMCBM5= "";
      String WYDJBM5 = "";

      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt5 where mainid = "+identity+" ";
      rs.executeSql(sql);
      while(rs.next()) {
         ZSYXQ5 =Util.null2String(rs.getString("ZSYXQ"));
         WYDJ5 =Util.null2String(rs.getString("WYDJ"));
         ZSMC5 =Util.null2String(rs.getString("ZSMC"));
         HZSJ5 =Util.null2String(rs.getString("HZSJ"));
         MQSLD5 =Util.null2String(rs.getString("MQSLD"));
         MQSLDBM5 =Util.null2String(rs.getString("MQSLDBM"));
         ZSMCBM5 =Util.null2String(rs.getString("ZSMCBM"));
         WYDJBM5 =Util.null2String(rs.getString("WYDJBM"));

         buff.append(ZSYXQ5);buff.append("###");
         buff.append(WYDJ5);buff.append("###");
         buff.append(ZSMC5);buff.append("###");
         buff.append(HZSJ5);buff.append("###");
         buff.append(MQSLD5);buff.append("###");
         buff.append(MQSLDBM5);buff.append("###");
         buff.append(ZSMCBM5);buff.append("###");
         buff.append(WYDJBM5);buff.append("@@@");
      }
     }  
}
else if("6".equals(type)){
     //明细6
      String JSJCZRJ6 = "";
      String ZSMC6 = "";
      String ZSDJ6 = "";
      String HZSJ6 = "";

      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt6 where mainid = "+identity+" ";
      rs.executeSql(sql);
      while(rs.next()) {
         JSJCZRJ6 =Util.null2String(rs.getString("JSJCZRJ"));
         ZSMC6 =Util.null2String(rs.getString("ZSMC"));
         ZSDJ6 =Util.null2String(rs.getString("ZSDJ"));
         HZSJ6 =Util.null2String(rs.getString("HZSJ"));

            buff.append(JSJCZRJ6);buff.append("###");
            buff.append(ZSMC6);buff.append("###");
            buff.append(ZSDJ6);buff.append("###");
            buff.append(HZSJ6);buff.append("@@@");
      }
     }  
}
else if("7".equals(type)){
     //明细7
      String QTZS7 = "";
      String ZSMC7 = "";
      String ZSDJ7 = "";
      String HZSJ7 = "";

      if(identity.length()>0){
      String sql = " select * from formtable_main_41_dt7 where mainid = "+identity+" ";
      rs.executeSql(sql);
      while(rs.next()) {
         QTZS7 =Util.null2String(rs.getString("QTZS"));
         ZSMC7 =Util.null2String(rs.getString("ZSMC"));
         ZSDJ7 =Util.null2String(rs.getString("ZSDJ"));
         HZSJ7 =Util.null2String(rs.getString("HZSJ"));

            buff.append(QTZS7);buff.append("###");
            buff.append(ZSMC7);buff.append("###");
            buff.append(ZSDJ7);buff.append("###");
            buff.append(HZSJ7);buff.append("@@@");
      }
     }  
}
 	out.print(buff.toString());

%>
