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
<%

	StringBuffer dataBuff = new StringBuffer();

    String qj_id = request.getParameter("id");//�ɹ���ID

	String requestId = "";//id
	String  Name  = "";//��Ʒ����ID
	String  goodname = "";//��Ʒ����
	String ActualNumbers = "";//�ƻ�����
	String Price = "";//�ƻ�����
	String haspurchasenum = "";//�Ѳɹ�����
	String sql = "";

   	String qjName = "";//ʱ��
	String jb = "";//�ٱ�
	String ks = "";//��ʼ����
	String kssj = "";//��ʼʱ��
	String js = "";//��������
	String jssj = "";//����ʱ��
	String unitname = "";//��λ
	String goodscatex = "";//�������id
	String catename = "";//�������
	String goodscatexID = "";//�������id
      //out.print("gw_id ="+gw_id);
      if(qj_id.length()>0){
     // String sql = " select f1.gwjn,f2.pxkc from formtable_main_235 f1 left join formtable_main_235_dt1 f2 on  f1.id = f2.mainid where f1.id = "+gw_id;

     //������java��ע��
	  /* String sql = " select f1.sy,f1.requestId,f2.SS,f2.SQSJ1,f2.SQSJ2,case f2.JB when '0' then '�¼�' when '1' then '����' when '2' then '���' when '3' then '���' when '4' then '����' when '5' then 'ɥ��' when '6' then '�ټ�' when '7' then '���˼�' when '8' then '�����' when '9' then '�����' when '10' then '���ݼ�' else '������' end jb,f2.SQSJ3,f2.SQSJ4 from formtable_main_58_dt1 f2 "
		+"left join formtable_main_58 f1  on  f1.id = f2.mainid where f2.mainid = (select id from formtable_main_58 where requestId = " +qj_id+ ")"; */

		/*String sql = " select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodsname,f2.ActualNumbers,f2.Price from formtable_main_45_dt1 f2 left join  formtable_main_45 f1 on f1.id = f2.mainid where f2.mainid = (select id from formtable_main_45 where requestId = " +qj_id+ ")";*/

		//formtable_main_74������ formtable_main_73���¶Ȳɹ���
		sql = "select * from (select sum(purchasenum) haspurchasenum,goodsname from formtable_main_74_dt1 "+
		"where mainid in (select id from formtable_main_74 where MonthPurchase ="+qj_id+" and "+
		"  requestid in(select requestid from workflow_requestbase where currentnodetype >0 )) group by goodsname) s1 "+
		"right join (select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodname,"+
		"f2.ActualNumbers,f2.Price from formtable_main_73_dt1 f2 left join  formtable_main_73 f1 on f1.id = f2.mainid"
		+" where f2.mainid = (select id from formtable_main_73 where requestId ="+qj_id+" )) s2 on s1.goodsname=s2.Name";

		//out.print("sql="+sql);

        rs.executeSql(sql);
		while( rs.next() ) {	

		ActualNumbers = Util.null2String(rs.getString("ActualNumbers"));
		haspurchasenum = Util.null2String(rs.getString("haspurchasenum"));

		if(ActualNumbers.equals(haspurchasenum))
			continue;

		Name = Util.null2String(rs.getString("Name"));
		dataBuff.append(Name);
		dataBuff.append("###");

		goodname = Util.null2String(rs.getString("goodname"));
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
			dataBuff.append("@@@");

			
		}
		out.print(dataBuff.toString());
   }
%>