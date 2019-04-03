package htkj.materiel;

import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class updateRequestSHR2Action implements Action{
	public String execute(RequestInfo info) {
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
	    RecordSetDataSource rsd = new RecordSetDataSource("KIN_REQUEST");
		String tableName = "";
		String sql = "Select tablename,id From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id=" + workflow_id + ")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		String mainId = "";
		String qgdbh ="";
		String shr2 = "";
		String shrq = "";
		sql = "select id,qgdbh,shr2,to_char(sysdate,'yyyy-mm-dd HH24:mi:ss')||'.000' as shrq  from " + tableName + " where requestid= " + requestid;
		rs.executeSql(sql);
		if (rs.next()) {
			mainId = Util.null2String(rs.getString("id"));
			qgdbh = Util.null2String(rs.getString("qgdbh"));
			shr2 = Util.null2String(rs.getString("shr2"));
			shrq = Util.null2String(rs.getString("shrq"));
		}
		sql="select workcode||' '||lastname as shr2 from hrmresource where id="+shr2;
		rs.executeSql(sql);
		if (rs.next()) {
			shr2 = Util.null2String(rs.getString("shr2"));
		}
		sql="update tblcrequest set …Û∫À»À2='"+shr2+"',…Û∫À»’∆⁄2='"+shrq+"',…Û∫À±Íº«='2' where «Îπ∫µ•±‡∫≈='"+qgdbh+"'";
		rsd.executeSql(sql);
		return SUCCESS;
	}

}
