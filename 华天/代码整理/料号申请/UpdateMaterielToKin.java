package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateMaterielToKin implements Action{
	BaseBean log = new BaseBean();
	@Override
	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		sql = "select id from " + tableName + " where requestid= " + requestid;
		//log.writeLog("开始更新物料sql" + sql);
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
		}
		sql = "select * from " + tableName + "_dt1 where mainid=" + mainId;
		rs.executeSql(sql);
		String fItemID = "";
		String lhzt="";
		while (rs.next()) {
			lhzt =Util.null2String(rs.getString("lhzt"));
			fItemID = Util.null2String(rs.getString("FItemID"));
			if(!"".equals(lhzt)&& !"".equals(fItemID)){
			updateMaterielInfo(fItemID,lhzt);
			}
		}
		return SUCCESS;
	}
    
	public void updateMaterielInfo(String fItemID,String lhzt){
		RecordSetDataSource rsd = new RecordSetDataSource("Kingdee_fin_new");
		String sql="";
		if("1".equals(lhzt)){
		sql="update t_ICItem set FDeleted='1' where FItemID="+fItemID;
		}else{
			sql="update t_ICItem set FDeleted='0' where FItemID="+fItemID;	
		}
		//log.writeLog("更新状态sql:"+sql);
		rsd.executeSql(sql);
		if("1".equals(lhzt)){
		sql="update t_item set FDeleted='1' where FItemID="+fItemID;
		}else{
		sql="update t_item set FDeleted='0' where FItemID="+fItemID;
		}
		//log.writeLog("更新状态sql1:"+sql);
		rsd.executeSql(sql);
	}
}
