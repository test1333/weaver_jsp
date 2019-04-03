<%@page import="weaver.general.Util"%>
<%@page import="weaver.general.BaseBean"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

String checkid = request.getParameter("checkid");
  String admin = "";
  String applicant = "";
  String id0 = "";
  String id1 = "";
  String id2 = "";
  String id3 = "";
  String id4 = "";
  String id5 = "";
  String id6 = "";
  String id7 = "";
  String id8 = "";

  int total0=0;
  int total1=0;
  int total2=0;
  int total3=0;
  int total4=0;
  int total5=0;
  int total6=0;
  int total7=0;
  int total8=0;

  String sql_checkinfo = "select * from uf_checkrecord where id = "+checkid+"";
  rs.executeSql(sql_checkinfo);
  if(rs.next()){
       admin = Util.null2String(rs.getString("checkstock")); 
       applicant = Util.null2String(rs.getString("admin"));   
  }

    //入库
    String sql_0 = " select count(id) as total0 from uf_InHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_0);
    if(rs.next()){
	       total0 = rs.getInt("total0");
	   }
	if(total0>0){
  	String sql_tow0 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",0,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow0);
    String update_0 = "update  uf_InHandleRd  set ToWFId = (select max(id) from uf_HandleDataToWF where Type=0) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_0);
	}


    //借用
    String sql_1 = " select count(id) as total1 from uf_BorrowHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_1);
    if(rs.next()){
	       total1 = rs.getInt("total1");
	   }
	if(total1>0){
    String sql_tow1 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",1,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow1);
    String update_1 = "update   uf_BorrowHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=1) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_1);
	}


    //归还
    String sql_2 = " select count(id) as total2 from uf_ReturnHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_2);
    if(rs.next()){
	       total2 = rs.getInt("total2");
	   }
	if(total2>0){
    String sql_tow2 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",2,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow2);
    String update_2 = "update uf_ReturnHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=2) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_2);
	}

    //领用
    String sql_3 = " select count(id) as total3 from uf_ReceiveHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_3);
    if(rs.next()){
	       total3 = rs.getInt("total3");
	   }
	if(total3>0){
    String sql_tow3 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",3,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow3);
    String update_3 = "update  uf_ReceiveHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=3) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_3);
	}

    //退还
    String sql_4 = " select count(id) as total4 from uf_RbHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_4);
    if(rs.next()){
	       total4 = rs.getInt("total4");
	   }
	if(total4>0){
    String sql_tow4 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",4,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow4);
    String update_4 = "update  uf_RbHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=4) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_4);
	}

    //报损
    String sql_5 = " select count(id) as total5 from uf_LossHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_5);
    if(rs.next()){
	       total5 = rs.getInt("total5");
	   }
	if(total5>0){
    String sql_tow5 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",5,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow5);
    String update_5 = "update  uf_LossHandleRd  set ToWFId = (select max(id) from uf_HandleDataToWF where Type=5) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_5);
	}

    //报废
    String sql_6 = " select count(id) as total6 from uf_ScrapHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_6);
    if(rs.next()){
	       total6 = rs.getInt("total6");
	   }
	if(total6>0){
    String sql_tow6 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",6,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow6);
    String update_6 = "update  uf_ScrapHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=6) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_6);
 	}

    //维修
    String sql_7 = " select count(id) as total7 from uf_RepairHandleRd where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_7);
    if(rs.next()){
	       total7 = rs.getInt("total7");
	   }
	if(total7>0){
    String sql_tow7 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",7,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow7);
    String update_7 = "update  uf_RepairHandleRd set ToWFId = (select max(id) from uf_HandleDataToWF where Type=7) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_7);
	}

      //归还客户
    String sql_8 = " select count(id) as total8 from  uf_CustomerReturn where ToWFId is null and checkid = "+checkid+" ";
    rs.executeSql(sql_8);
    if(rs.next()){
         total8 = rs.getInt("total8");
     }
  if(total8>0){
    String sql_tow7 = " insert into uf_HandleDataToWF (CheckId,Type,Admin,Importance,Emergency,createdate,createtime,createweek,applicantdate,applicanttime,applicantweek,applicant) "+
                      " values("+checkid+",8,"+admin+",0,0,CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()), "+
                      " CONVERT(varchar(100), GETDATE(), 23), left(CONVERT(varchar(100), GETDATE(), 108),5),datename(weekday, getdate()),"+applicant+")";
    rs.executeSql(sql_tow7);
    String update_7 = "update uf_CustomerReturn set ToWFId = (select max(id) from uf_HandleDataToWF where Type=8) where ToWFId is null and checkid = "+checkid+"";
    rs.executeSql(update_7);
  }


	String sql =" update uf_checkrecord set workprocess = 2 where id in ("+checkid+")";
    rs.executeSql(sql);

   response.sendRedirect("/seahonor/jsp/AssetsCheck.jsp?Checkid="+checkid+"");

%>

