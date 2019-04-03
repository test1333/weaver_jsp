package htkj.materiel;

import java.util.HashMap;
import java.util.Map;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class InsertQGDataModeAction implements Action{
	BaseBean log = new BaseBean();
	@Override
	public String execute(RequestInfo info) {
		InsertUtil iu = new InsertUtil();
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		RecordSet rs_dt = new RecordSet();
		String sql_dt="";
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String tableName = "";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		String qgdbh="";
		String qgrq="";
		String qgbm="";
		String qgr="";
		String bsfs="";
		String qgrgh="";
		String shr1="";
		String shr2="";
		String shr3="";
		String sh1zh="";
		String sh2zh="";
		String sh3zh="";
		
		sql = "select *  from " + tableName + " where requestid= " + requestid;
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
			qgdbh = Util.null2String(rs.getString("qgdbh"));
			qgrq = Util.null2String(rs.getString("qgrq"));
			qgbm = Util.null2String(rs.getString("qgbm"));
			qgr = Util.null2String(rs.getString("qgr"));
			bsfs = Util.null2String(rs.getString("bsfs"));			
			qgrgh = Util.null2String(rs.getString("qgrgh"));
			
			shr1 = Util.null2String(rs.getString("shr1"));
			shr2 = Util.null2String(rs.getString("shr2"));
			shr3 = Util.null2String(rs.getString("shr3"));
			sh1zh = Util.null2String(rs.getString("sh1zh"));
			sh2zh = Util.null2String(rs.getString("sh2zh"));			
			sh3zh = Util.null2String(rs.getString("sh3zh"));
		}
		String id="";
		String lh="";
		String wlmc="";
		String xh="";
		String gg="";
		String th="";
		String sl="";
		String fx="";
		String yt="";
		String xqrq="";
		String gx="";
		String jhy="";
		String bz="";
		String dw="";
		String wllh="";
		String qgdxc="";
		String dqcl="";
		String seqno="";
		String dwzw = "";
		sql="select * from "+ tableName + "_dt1 where mainid="+mainId;
		rs.execute(sql);
		while(rs.next()){
			id = Util.null2String(rs.getString("id"));
			lh = Util.null2String(rs.getString("lh"));
			wlmc = Util.null2String(rs.getString("wlmc"));
			xh = Util.null2String(rs.getString("xh"));
			gg = Util.null2String(rs.getString("gg"));
			th = Util.null2String(rs.getString("th"));
			sl = Util.null2String(rs.getString("sl"));
			fx = Util.null2String(rs.getString("fx"));
			yt = Util.null2String(rs.getString("yt"));
			xqrq = Util.null2String(rs.getString("xqrq"));
			gx = Util.null2String(rs.getString("gx"));
			jhy = Util.null2String(rs.getString("jhy"));
			bz = Util.null2String(rs.getString("bz"));
			dw = Util.null2String(rs.getString("dw"));
			wllh = Util.null2String(rs.getString("wllh"));
			qgdxc = Util.null2String(rs.getString("qgdxc"));
			dqcl = Util.null2String(rs.getString("dqcl"));
			dwzw=getDwZW(dw);
			seqno=requestid+"_"+id;
			Map<String, String> mapStr = new HashMap<String, String>();
			mapStr.put("qgdbh", qgdbh);
			mapStr.put("qgrq", qgrq);
			mapStr.put("qgbm", qgbm);
			mapStr.put("qgr", qgr);
			mapStr.put("bsfs", bsfs);
			mapStr.put("qgrgh", qgrgh);
			
			mapStr.put("shr1", shr1);
			mapStr.put("shr2", shr2);
			mapStr.put("shr3", shr3);
			mapStr.put("sh1zh", sh1zh);
			mapStr.put("sh2zh",sh2zh);
			mapStr.put("sh3zh",sh3zh);
			
			mapStr.put("lh",lh);
			mapStr.put("wlmc",wlmc);
			mapStr.put("xh",xh);
			mapStr.put("gg",gg);
			mapStr.put("th",th);
			mapStr.put("sl",sl);
			
			mapStr.put("fx",fx);
			mapStr.put("yt",yt);
			mapStr.put("xqrq",xqrq);
			mapStr.put("gx",gx);
			mapStr.put("jhy",jhy);
			mapStr.put("bz",bz);
			
			mapStr.put("dw",dw);
			mapStr.put("wllh",wllh);
			mapStr.put("qgdxc",qgdxc);
			mapStr.put("dqcl",dqcl);
			mapStr.put("dwzw",dwzw);
			mapStr.put("seqno",seqno);
			mapStr.put("status","0");
			mapStr.put("requestid",requestid);
			mapStr.put("modedatacreater", "1");
			mapStr.put("modedatacreatertype", "0");
			mapStr.put("formmodeid", "182");
			iu.insert(mapStr, "uf_data_qinggou");
			sql_dt = "select * from uf_data_qinggou where seqno='" + seqno + "'";
			rs_dt.executeSql(sql_dt);
			log.writeLog("开始插入请购数据" + sql_dt);
            String qinggouId="";
			if (rs_dt.next()) {
				qinggouId = Util.null2String(rs_dt.getString("id"));
			}
			ModeRightInfo ModeRightInfo = new ModeRightInfo();
			ModeRightInfo.editModeDataShare(Integer.valueOf("1"), 182,
					Integer.valueOf(qinggouId));
			
			
		}
		
		return SUCCESS;
	}
	
	private String getDwZW(String dw){
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql="select FName from t_MeasureUnit where FDeleted=0 and FItemID="+dw;
		String dwzw="";
		rsd.executeSql(sql);
		if(rsd.next()){
			dwzw = Util.null2String(rsd.getString("FName"));
		}
		
		return dwzw;
	}

}
