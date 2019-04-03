package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class ProjectITAction implements Action {

	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		
		log.writeLog("ProjectITAction____Start");
		
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		rs.executeSql(sql);
		log.writeLog("sql ---------" + sql);
	//	rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}

		if (!" ".equals(tableName)) {
			String emp_1 = "";
			// 获取责任人
			sql = "select * from "+tableName+"_dt1 where mainid in(Select id from "+tableName
					+" where  requestId="+requestid+") and fromWhat=2";
			log.writeLog("sql ---------" + sql);
			rs.executeSql(sql);
			String flag = "";
			while(rs.next()){
				
				String creator = Util.null2String(rs.getString("creator"));
				if("".equals(creator)) creator = "1";
				
				emp_1 = emp_1 + flag + creator; flag = ",";
			}
			
			sql = "select id from HrmResource where id in("+emp_1+")";
			log.writeLog("sql ---------" + sql);
			rs.executeSql(sql);
			flag = "";
			String emp_2 = "";
			while(rs.next()){
				String tmp_emp = Util.null2String(rs.getString("id"));
				emp_2 = emp_2 + flag + tmp_emp;
				flag = ",";
			}
			sql = "update "+tableName+" set itm='"+emp_2 +"' where requestId="+requestid;
			log.writeLog("sql ---------" + sql);
			rs.executeSql(sql);
		}
		return SUCCESS;
	}

}
