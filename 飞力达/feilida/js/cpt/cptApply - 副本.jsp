<%@ page language="java" contentType="text/html; charset=utf-8" %>
    <%@ page import="weaver.general.Util" %>
        <%@ page import="weaver.conn.RecordSetDataSource" %>
            <%@ page import="weaver.general.BaseBean" %>
                <jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
                <jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
                <%
      BaseBean log = new BaseBean();
	  StringBuffer dataBuff = new StringBuffer();
      String reqid = request.getParameter("reqid");//requestId
	  log.writeLog("费用报销sql ="+reqid);
      if(reqid.length()>0){
		String tmp_reqid = reqid+",0";
		  String sql = " select max(v.shybm) as shybm ,v.kmid ,v.gys1id ,sum(v.je) as JE ,count(*) as cnt,max(v.cptname) cptname,v.cbzx,max(v.zcms) zcms,max(v.ywfw) ywfw,max(v.ywfwmc) ywfwmc,max(v.sm) sm,max(v.shlv) shlv,max(v.shj) shj,max(v.nbdd) nbdd,max(v.nbddms) nbddms, "
		  +" max(v.requestid) requestid, max(v.exetype) as type1 ,max(v.syrcbzxmc) as syrcbzxmc"
		  +"  from ( select '' as a ,t.shybm,dtl.kmid,dtl.gys1id,case when cpa.assortmentname ='固定资产' then sys_guid()||'' else ' ' end as assortmentname ,dtl.JE,dtl.ysxx,dtl.guige "
                 +" ,dtl.danwei,t.fbdm,t.cbzx,t.syrcbzxmc,dtl.cptname,dtl.zcms,dtl.ywfw,dtl.ywfwmc,dtl.sm,dtl.shlv ,dtl.shj,dtl.nbdd,dtl.nbddms,decode(cpa.assortmentname,'固定资产','1','0') exetype,t.requestid   from formtable_main_115 t  join  formtable_main_115_dt1 dtl on t.id=dtl.mainid"
                 +" join cptcapital cp on dtl.zczl=cp.id join cptcapitalassortment cpa on cp.capitalgroupid=cpa.id where t.requestid in ("+reqid+") ) v  group by v.kmid,v.gys1id,v.assortmentname,v.cbzx ";
		  log.writeLog("费用报销sql ="+sql);
		  //out.print();
	  	rs.executeSql(sql);
	 	while(rs.next()) {
   			String dept = Util.null2String(rs.getString("shybm"));
			String syrcbzxmc = Util.null2String(rs.getString("syrcbzxmc"));
			String CBZX = Util.null2String(rs.getString("cbzx"));
		    int exetype1 = rs.getInt("type1");
			dataBuff.append(syrcbzxmc);
			dataBuff.append("###");
			dataBuff.append(CBZX);
			
			dataBuff.append("###");

			String cptid = Util.null2String(rs.getString("cptname"));
			String sql_cpt = " select name,capitalspec from Cptcapital where id="+cptid;
			res.executeSql(sql_cpt);
			//log.writeLog("sql_1="+sql_1);
			if(res.next()){
				String cptname = Util.null2String(res.getString("name"));
				dataBuff.append(cptname);
			}else{
				dataBuff.append("");
			}
			dataBuff.append("###");

			String zcms = Util.null2String(rs.getString("zcms"));
			dataBuff.append(zcms);
			dataBuff.append("###");

			//String ysje = Util.null2String(rs.getString("YSjine"));
			dataBuff.append("");
			dataBuff.append("###");

			String ysxx = Util.null2String(rs.getString("ysxx"));
			dataBuff.append(ysxx);
			dataBuff.append("###");

			String ywfw = Util.null2String(rs.getString("ywfw"));
			dataBuff.append(ywfw);
			dataBuff.append("###");

			String ywfwmc = Util.null2String(rs.getString("ywfwmc"));
			dataBuff.append(ywfwmc);
			dataBuff.append("###");

			String sm = Util.null2String(rs.getString("sm"));
			dataBuff.append(sm);
			dataBuff.append("###");

			String shlv = Util.null2String(rs.getString("shlv"));
			dataBuff.append(shlv);
			dataBuff.append("###");

			String shj = Util.null2String(rs.getString("shj"));
			dataBuff.append(shj);
			dataBuff.append("###");

			String nbdd = Util.null2String(rs.getString("nbdd"));
			dataBuff.append(nbdd);
			dataBuff.append("###");

			String nbddms = Util.null2String(rs.getString("nbddms"));
			dataBuff.append(nbddms);
			dataBuff.append("###");

			String kmid = Util.null2String(rs.getString("kmid"));
			dataBuff.append(kmid);
			dataBuff.append("###");

            //String keyNum = Util.null2String(rs.getString("keyNum"));
			dataBuff.append("");
			dataBuff.append("###");

			String je = Util.null2String(rs.getString("JE"));
			dataBuff.append(je);
			dataBuff.append("###");

			String reqid_dt = Util.null2String(rs.getString("requestid"));
			dataBuff.append(reqid_dt);
			dataBuff.append("###");
			dataBuff.append(dept);
			dataBuff.append("###");
			
			dataBuff.append(exetype1);
			dataBuff.append("###");
			String gys1id = Util.null2String(rs.getString("gys1id"));
			dataBuff.append(gys1id);
			dataBuff.append("###");
			String sql_gys= "select * from IT_CRM_SUPPLIER where status=1 and supplierkey='"+gys1id+"'";
			res.executeSql(sql_gys);
		    if(res.next()){
                String gysname=Util.null2String(res.getString("SUPPLIERNAME"));
				dataBuff.append(gysname);
		    }else{
				dataBuff.append("");
			}
			dataBuff.append("@@@");
			}
		}
		log.writeLog("费用报销sql ="+dataBuff.toString());
		out.print(dataBuff.toString());
%>