<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.TimeUtil" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="seahonor.util.InsertUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />

<%
    String sql = "";
    String ids = request.getParameter("ids");
    
    String supplierID = "";//
    String requestid = "";//
    String name = "";//供应商名称 
    String gname = "";//商品名称
    String storeNum = "";//当前库存
    String avgprice = "";//平均单价
    String countNum = "";//复核数量
    String supplierprice = "";//供应商单价
    String total = "";//金额
    String remark = "";//备注
    String index[] = request.getParameterValues("index");
    
    name = request.getParameter("sname");
    //out.println("name="+name);

    supplierID = request.getParameter("supplierID");
    requestid = request.getParameter("requestid");

    String goodsname[] = request.getParameterValues("goodsname");
    String Stock[] = request.getParameterValues("Stock");//getParameterValues获取数组元素
    String AvgPrice[] = request.getParameterValues("AvgPrice");
    String count[] = request.getParameterValues("count");
    String SupplierPrice[] = request.getParameterValues("SupplierPrice");
    String Total[] = request.getParameterValues("Total");
    String Remark[] = request.getParameterValues("Remark");
    for(int i=0;i<goodsname.length;i++){
         gname = goodsname[i].toString();
         storeNum = Stock[i].toString();
         avgprice = AvgPrice[i].toString();
         countNum = count[i].toString();
         String tmp_index = index[i].toString();
         out.println("tmp_index="+tmp_index);
         supplierprice = SupplierPrice[i].toString();
         total = Total[i].toString();
         remark = Remark[i].toString();

         InsertUtil iu = new InsertUtil();
         Map<String,String> mapStr = new HashMap<String,String>();
         mapStr.put("supplier",supplierID);
         mapStr.put("requestid",requestid);
         mapStr.put("goodsname",gname);
         mapStr.put("Stock",storeNum);
         mapStr.put("AvgPrice",avgprice);
         mapStr.put("count",countNum);
         mapStr.put("SupplierPrice",supplierprice);
         mapStr.put("Total",total);
         mapStr.put("Remark",remark);
         mapStr.put("IndexNum",tmp_index);

         iu.insert(mapStr,"formtable_main_50");  

        /* out.println("gname="+gname);
        out.println("storeNum="+storeNum);
        out.println("avgprice="+avgprice);
        out.println("countNum="+countNum);
        out.println("supplierprice="+supplierprice);
        out.println("total="+total);
        out.println("remark="+remark); */
    }
    response.sendRedirect("QueryPrice.jsp?supplierID="+supplierID+"&requestid="+requestid);
    //response.sendRedirect("BonusPersonalAll.jsp?year_name="+year_name+"&month_name="+month_name+" ");
%>


