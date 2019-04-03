<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="org.json.JSONObject"%>
<%
BaseBean log = new BaseBean();
RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		RecordSet rs_dt2 = new RecordSet();
		String requestid="";
		String WPSQD_NEW = "";
		String mainid="";
		String sql_dt = "";
		String sql_dt2 = "";
		String sql="select distinct a.id,a.requestid,a.WPSQD_NEW from formtable_main_58 a,formtable_main_58_dt1 b where a.id=b.mainid and a.WPSQD_NEW is not null and b.mxids is null ";
		log.writeLog("sql:"+sql);
		rs.executeSql(sql);
	    while(rs.next()){
	    	requestid = Util.null2String(rs.getString("requestid"));
	    	WPSQD_NEW = Util.null2String(rs.getString("WPSQD_NEW"));
	    	mainid = Util.null2String(rs.getString("id"));
	    	String ids="";
	    	String kmid = "";
	    	String gys1id = "";
	    	String cbzx = "";
	    	String type1 = "";
	    	sql_dt = " select wm_concat(id) as ids,v.kmid ,v.gys1id, v.cbzx, max(v.exetype) as type1"
	    			  +"  from ( select dtl.id,'' as a ,dtl.ZCBH,dtl.YHZH,dtl.YHZHMS,t.shybm,dtl.kmid,dtl.gys1id,case when cpa.assortmentname in ('固定资产','待摊费用','长期待摊费用') then sys_guid()||'' else ' ' end as assortmentname ,dtl.HSZJ,dtl.ysxx,dtl.guige "
	    	                 +" ,dtl.danwei,t.fbdm,t.cbzx,t.syrcbzxmc,dtl.cptname,dtl.zcms,dtl.ywfw,dtl.ywfwmc,dtl.sm,dtl.shlv ,dtl.shj,dtl.nbdd,dtl.nbddms,decode(cpa.assortmentname,'固定资产','1','待摊费用','1','长期待摊费用','1','0') exetype,t.requestid,dtl.kq,dtl.qsyyf,dtl.jsyyf   from formtable_main_115 t  join  formtable_main_115_dt1 dtl on t.id=dtl.mainid"
	    	                 +" join cptcapital cp on dtl.zczl=cp.id join cptcapitalassortment cpa on cp.capitalgroupid=cpa.id where t.requestid in ("+WPSQD_NEW+") ) v  group by v.kmid,v.gys1id,v.assortmentname,v.cbzx ";
	    	log.writeLog("sql_dt:"+sql_dt);
			rs_dt.executeSql(sql_dt);
	    	while(rs_dt.next()){
	    		ids = Util.null2String(rs_dt.getString("ids"));
	    		kmid = Util.null2String(rs_dt.getString("kmid"));
	    		gys1id = Util.null2String(rs_dt.getString("gys1id"));
	    		cbzx = Util.null2String(rs_dt.getString("cbzx"));
	    		type1 = Util.null2String(rs_dt.getString("type1"));
	    		String dtid="";
	    		sql_dt2="select id from formtable_main_58_dt1 where mainid="+mainid+" and kmid='"+kmid+"' and gysbh='"+gys1id+"'and exetype='"+type1+"' and cbzx='"+cbzx+"' and mxids is null";
	    		log.writeLog("sql_dt2:"+sql_dt2);
				rs_dt2.executeSql(sql_dt2);
	    		if(rs_dt2.next()){
	    			dtid = Util.null2String(rs_dt2.getString("id"));
	    		}
	    		if(!"".equals(dtid)){
	    			sql_dt2="insert into ls_cpt_mxids(requestid,dtid) values('"+requestid+"','"+dtid+"')";
						log.writeLog("sql_dt2:"+sql_dt2);
	    			rs_dt2.executeSql(sql_dt2);
	    			sql_dt2="update formtable_main_58_dt1 set mxids='"+ids+"' where id="+dtid;
						log.writeLog("sql_dt2:"+sql_dt2);
	    			rs_dt2.executeSql(sql_dt2);
	    		}
	    	}
	    	
	    	
	    }

		out.print("success");
%>

