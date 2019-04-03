package htkj.project;

import weaver.conn.RecordSet;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateXYSLAction implements Action{
	 public String execute(RequestInfo info) {
		 String requestid = info.getRequestid();
			String workflow_id = info.getWorkflowid();
			RecordSet rs = new RecordSet();
			 RecordSet res = new RecordSet();

			String tableName = "";
			String sql = "Select tablename From Workflow_bill Where id=(";
			sql += "Select formid From workflow_base Where id="+workflow_id+")";
			rs.executeSql(sql);
			if (rs.next()) {
				tableName = Util.null2String(rs.getString("tablename"));
			}
			 sql = "select * from " + tableName + " where requestid = "+ requestid;
			 rs.executeSql(sql);
	         if (rs.next()) {
	        	 String project_name = Util.null2String(rs.getString("project_name"));
	        	 String yxycs = Util.null2String(rs.getString("yxycs"));
	        	 String yxysl = Util.null2String(rs.getString("yxysl"));
                 String sql_up = " update cus_fielddata set scysycs='"+yxycs+"',scysyps='"+yxysl+"'  where  id= "+project_name+" "
	                        +" and scope='ProjCustomFieldReal' and scopeid= 21 ";
                 res.executeSql(sql_up);
	         }
		 return SUCCESS;
	 }
}
