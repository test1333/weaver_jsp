package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateRequestInfoAction implements Action{
	BaseBean log = new BaseBean();

	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String wllh="";
		String id="";
		String qgdbh = "";
		String qgdxc = "";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		sql = "select id from " + tableName + " where requestid= " + requestid;
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
		}
		sql="select * from "+tableName+"_dt1 where mainid="+mainId;
		rs.executeSql(sql);
		while(rs.next()){
			id =  Util.null2String(rs.getString("id"));
			wllh = Util.null2String(rs.getString("wllh"));
			qgdbh = Util.null2String(rs.getString("qgdbh"));
			qgdxc = Util.null2String(rs.getString("qgdxc"));
			updateWLInfo(wllh,id,qgdbh,qgdxc,tableName);
		}
		return SUCCESS;
	}
	
	public void updateWLInfo(String wllh,String id,String qgdbh,String qgdxc, String tableName){
		 RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		 RecordSetDataSource rsd1 = new RecordSetDataSource("KIN_REQUEST");
		 RecordSet rs1 = new RecordSet();
		 String lh="";
		 String wlmc = "";
		 String xh = "";
		 String gg = "";
		 String dw = "";
		 String dqcl = "0";
		 String sql="select a.F_101, b.FName,a.F_103 ,b.FModel,c.FUnitID from t_ICItemCustom a,T_ICItemCore b ,t_ICItemBase c where a.FItemID=b.FItemID  and b.FItemID = c.FItemID and b.FNumber='"+wllh+"'";
		 rsd.executeSql(sql);
		 if(rsd.next()){
			 lh =  Util.null2String(rsd.getString("F_101"));
			 wlmc =  Util.null2String(rsd.getString("FName"));
			 xh =  Util.null2String(rsd.getString("F_103"));
			 gg =  Util.null2String(rsd.getString("FModel"));
			 dw =  Util.null2String(rsd.getString("FUnitID"));
		 }
		 sql="select isnull(SUM(isnull(当前存量,0)),0) as dqcl from tblstocknum where 物料编号='"+wllh+"'";
		 rsd1.executeSql(sql);
		 if(rsd1.next()){
			 dqcl = Util.null2String(rsd1.getString("dqcl"));
		 }
		 if("".equals(dqcl)){
			 dqcl="0";
		 }
		 sql="update "+tableName+"_dt1 set lh='"+lh+"',wlmc='"+wlmc+"',xh='"+xh+"',gg='"+gg+"',dw='"+dw+"',dqcl='"+dqcl+"' where id="+id;
		 rs1.executeSql(sql); 
		 
	}
}
