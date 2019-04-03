package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class ImproveTechnology implements Action{

	@Override
	public String execute(RequestInfo info) {
		BaseBean log = new BaseBean();
		String requestid = info.getRequestid();
		String workflow_id = info.getWorkflowid();
		RecordSet rs = new RecordSet();
		String tableName = "";
		String sql = "Select tablename From Workflow_bill Where id=(";
		sql += "Select formid From workflow_base Where id="+workflow_id+")";
		rs.executeSql(sql);
		if (rs.next()) {
			tableName = Util.null2String(rs.getString("tablename"));
		}
		
		sql="select id from "+tableName+" where requestid="+requestid;
		String mainId="";
		rs.executeSql(sql);
		if(rs.next()){
			mainId = Util.null2String(rs.getString("id"));
		}
		sql="delete from "+tableName+"_dt3 where mainid='"+mainId+"'";
		rs.executeSql(sql);
		sql="insert into "+tableName+"_dt3(mainid,bm,bmfsblhj,bmkfjjblhj ,bmlcjjblhj) " +
				"select max(mainid) as main,(select departmentname from hrmdepartment " +
				"where id =bmid) as bm,sum(fsbl) as fsbl ,sum(kfjjbl) as kfjjbl ,sum(lcjjbl) as lcjjbl " +
				"from "+tableName+"_dt2 where mainid='"+mainId+"' group by bmid ";
		rs.executeSql(sql);
		
		return SUCCESS;
	}

}
