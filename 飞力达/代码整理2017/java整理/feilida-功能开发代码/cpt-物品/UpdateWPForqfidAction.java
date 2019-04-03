package feilida.cpt;

import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateWPForqfidAction implements Action{
	public String execute(RequestInfo info) {
		String workflowID = info.getWorkflowid();// ��ȡ��������Workflowid��ֵ
		String requestid = info.getRequestid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String tableNamedt = "";
		String mainID = "";
		String sql = " Select tablename From Workflow_bill Where id in ("
				+ " Select formid From workflow_base Where id= " + workflowID
				+ ")";
		rs.execute(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		
		sql="select id from "+tableName+" where requestid="+requestid;
		rs.execute(sql);
		if (rs.next()) {
			mainID = Util.null2String(rs.getString("id"));
		}
		//����Ʒ�������̵�ÿ����ϸ����һ��Ψһ������id�������ʲ���ŵķ��ر�ʶ
		sql="update "+tableName+"_dt1 set qfid=id||'"+requestid+"' where mainid="+mainID;
		rs.execute(sql);
		return SUCCESS;
	}

}
