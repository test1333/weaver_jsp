<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%

	StringBuffer dataBuff = new StringBuffer();

    String qj_id = request.getParameter("id");//�ɹ���ID

	String requestId = "";//id
	String  Name  = "";//��Ʒ����ID
	String  goodname = "";//��Ʒ����
	String ActualNumbers = "";//�ƻ�����
	String Price = "";//�ƻ�����
	String haspurchasenum = "";//�Ѳɹ�����

   	String qjName = "";//ʱ��
	String jb = "";//�ٱ�
	String ks = "";//��ʼ����
	String kssj = "";//��ʼʱ��
	String js = "";//��������
	String jssj = "";//����ʱ��
      //out.print("gw_id ="+gw_id);
      if(qj_id.length()>0){
     // String sql = " select f1.gwjn,f2.pxkc from formtable_main_235 f1 left join formtable_main_235_dt1 f2 on  f1.id = f2.mainid where f1.id = "+gw_id;

     //������java��ע��
	  /* String sql = " select f1.sy,f1.requestId,f2.SS,f2.SQSJ1,f2.SQSJ2,case f2.JB when '0' then '�¼�' when '1' then '����' when '2' then '���' when '3' then '���' when '4' then '����' when '5' then 'ɥ��' when '6' then '�ټ�' when '7' then '���˼�' when '8' then '�����' when '9' then '�����' when '10' then '���ݼ�' else '������' end jb,f2.SQSJ3,f2.SQSJ4 from formtable_main_58_dt1 f2 "
		+"left join formtable_main_58 f1  on  f1.id = f2.mainid where f2.mainid = (select id from formtable_main_58 where requestId = " +qj_id+ ")"; */

		/*String sql = " select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodsname,f2.ActualNumbers,f2.Price from formtable_main_45_dt1 f2 left join  formtable_main_45 f1 on f1.id = f2.mainid where f2.mainid = (select id from formtable_main_45 where requestId = " +qj_id+ ")";*/

		//formtable_main_74������ formtable_main_73���¶Ȳɹ���
		//formtable_main_160�ǰ칫�豸�ɹ��������� ��formtable_main_153�ǰ칫�豸/�̶��ʲ���
		String sql = "select * from (select sum(purchasenum) haspurchasenum,goodsname from formtable_main_160_dt1 "+
		"where mainid in (select id from formtable_main_160 where selectpurchaseorder ="+qj_id+" and "+
		"  requestid in(select requestid from workflow_requestbase where currentnodetype >0 )) group by goodsname) s1 "+
		"right join (select f1.requestId,f2.Name,(select goodsname from uf_goodsinfo where id = f2.Name) as goodname,"+
		"f2.ActualNumbers,f2.Price from formtable_main_153_dt1 f2 left join  formtable_main_153 f1 on f1.id = f2.mainid"
		+" where f2.mainid = (select id from formtable_main_153 where requestId ="+qj_id+" )) s2 on s1.goodsname=s2.Name";

		//out.print("sql="+sql);

        rs.executeSql(sql);
		while( rs.next() ) {	

		Name = Util.null2String(rs.getString("Name"));
		dataBuff.append(Name);
		dataBuff.append("###");

		goodname = Util.null2String(rs.getString("goodname"));
		dataBuff.append(goodname);
		dataBuff.append("###");

		ActualNumbers = Util.null2String(rs.getString("ActualNumbers"));
		dataBuff.append(ActualNumbers);
		dataBuff.append("###");
	
		Price = Util.null2String(rs.getString("Price"));
   		dataBuff.append(Price);
		dataBuff.append("###");

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