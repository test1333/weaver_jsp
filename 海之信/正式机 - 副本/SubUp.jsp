<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_d" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="langChg" class="seahonor.util.CnToEn" scope="page"/>
<%

        String customer="";
        String infoid="";
        int isshow=0;
		String title_temp="";
        String superid="";
        String catename="";
        String catename2="";
		String sql = " select * from uf_goodsinforecord where isindependent=1 ";
		rs_dt.executeSql(sql);
    	while(rs_dt.next()){
    	            customer = Util.null2String(rs_dt.getString("customer"));
    	            infoid = Util.null2String(rs_dt.getString("infoid"));
    	            isshow=rs_dt.getInt("isshow");


    	        if("".equals(customer)){
					title_temp = "HZX";
				}else{
					title_temp = "KH";
				}

    	        String sql2= "select * from uf_goodscate where id in (select goodscateid from uf_goodsinfo where id = "+infoid+")";
				rs.execute(sql2);
				if(rs.next()){
					superid = Util.null2String(rs.getString("superid"));
					catename2 = Util.null2String(rs.getString("catename"));
				}
				
				while(!"".equals(superid)){
					String sql_x = "select * from uf_goodscate where id = "+superid+"";
					rs_d.execute(sql_x);
					if(rs_d.next()){
						superid = Util.null2String(rs_d.getString("superid"));
						catename = Util.null2String(rs_d.getString("catename"));
					}
				}

				String temp_index = String.format("%04d",isshow);
				String lan_temp = langChg.getFirstLetter(catename);
				String cate_temp = langChg.getFirstLetter(catename2);
				String str=""+title_temp+""+"-"+""+cate_temp+""+"-"+""+lan_temp+""+"-1607-"+temp_index+"";
				String sq = "update uf_goodsinforecord set goodsnum = '"+str+"' where isshow = '"+isshow+"'";
				rs.executeSql(sq);
				out.println("sql="+sq);

    	}

%>
