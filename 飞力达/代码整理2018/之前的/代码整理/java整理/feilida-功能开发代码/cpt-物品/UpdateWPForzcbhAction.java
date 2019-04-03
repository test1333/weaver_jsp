package feilida.cpt;

import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateWPForzcbhAction implements Action{
	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		String workflowID = info.getWorkflowid();// ��ȡ��������Workflowid��ֵ
		String requestid = info.getRequestid();
		RecordSet rs = new RecordSet();
		RecordSet rs_detail = new RecordSet();
		log.writeLog("��ʼ��д�ʲ����");
		String tableName = "";
		String mainID = "";
		String sql_detail="";
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
		String qfid="";
		String id="";
		String CFDD="";
		//���ʲ�ģ�����Ψһ��ʶ������ϸ����ʲ����
		sql="select * from "+tableName+"_dt1 where mainid="+mainID;
		rs.executeSql(sql);
		while(rs.next()){
			qfid=Util.null2String(rs.getString("qfid"));
			id=Util.null2String(rs.getString("id"));
			CFDD=Util.null2String(rs.getString("CFDD")); 
			if(!"".equals(qfid)){
				sql_detail="update "+tableName+"_dt1 set ZCBH =(select mark from cptcapital where location='"+qfid+"') where id="+id;
			    rs_detail.executeSql(sql_detail);
			    sql_detail="update cptcapital set location='"+CFDD+"' where location='"+qfid+"'";
			    rs_detail.executeSql(sql_detail);
			}
		}
		log.writeLog("��ʼ�ʲ���ŷ�д����");
		return SUCCESS;
	}

}
