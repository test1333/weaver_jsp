package gcl.doc.workflow;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class UpdateCyStatus implements Action {

    @Override
    public String execute(RequestInfo info) {
        BaseBean log = new BaseBean();
        RecordSet rs = new RecordSet();
        DocUtil du = new DocUtil();
        String workflowID = info.getWorkflowid();
        String requestid = info.getRequestid();
        String modeTable = du.getBillTableName("CY");
        String tableName = "";
        String sjcyid = "";
        String sql = " Select tablename From Workflow_bill Where id in ("
                + " Select formid From workflow_base Where id= " + workflowID
                + ")";
        rs.execute(sql);
        if (rs.next()) {
            tableName = Util.null2String(rs.getString("tablename"));
        }
        sql = "select * from " + tableName + " where requestid=" + requestid;
        rs.executeSql(sql);
        if (rs.next()) {
            sjcyid = Util.null2String(rs.getString("sjcyid"));
        }
        if (!"".equals(sjcyid)) {
            sql = "update " + modeTable + " set cllx='1' where id=" + sjcyid;
            rs.executeSql(sql);
        }

        return SUCCESS;
    }

}
