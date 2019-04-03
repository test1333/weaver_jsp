package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class CheckModeInfoAction implements Action{

	@Override
	public String execute(RequestInfo info) {
		// TODO Auto-generated method stub
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		RecordSet rs_detail = new RecordSet();
		String tableName = "";
		String sql_detail="";
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
		String xh = "";
		String id="";
		while (rs.next()) {
			id = Util.null2String(rs.getString("id"));
			xh = Util.null2String(rs.getString("xh")).replaceAll(" ", "").toUpperCase();
			sql_detail = "update " + tableName + "_dt1 set xh='"+xh+"' where id="+id;
			rs_detail.execute(sql_detail);
		}
		return SUCCESS;
	}

}
