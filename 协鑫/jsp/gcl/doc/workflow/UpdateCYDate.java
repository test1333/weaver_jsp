package gcl.doc.workflow;


import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 创建传阅子流程
 *
 * @author tangj
 */
public class UpdateCYDate extends BaseBean implements Action {

//

    @Override
    public String execute(RequestInfo requestInfo) {
        RecordSet rs = new RecordSet();
        DocUtil du = new DocUtil();
        String billtable = du.getBillTableName("CY");
        String wfid = du.getWfid("CY");
        String wftable = du.getWfTableName("CY");
        SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = dateFormate.format(new Date());
        String time = sf.format(new Date());
        String billid = "";
        String bcjzzcyrq = "";//传阅日期
        int count = 0;
        String sql = "select * from " + wftable + " where requestid = " + requestInfo.getRequestid();
        rs.executeSql(sql);
        if (rs.next()) {
            billid = Util.null2String(rs.getString("sjcyid"));

        }
        sql = "select * from " + billtable + " where id=" + billid;
        rs.executeSql(sql);
        if (rs.next()) {
            bcjzzcyrq = Util.null2String(rs.getString("bcjzzcyrq"));
        }
        sql = "select count(1) as count from " + wftable + " where sjcyid='" + billid + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            count = rs.getInt("count");
        }
        if (count <= 0 || "".equals(bcjzzcyrq)) {
            sql = "update " + billtable + " set bcjzzcyrq='" + nowDate + "',bcjzzcysj='" + time + "' where id=" + billid;
            rs.executeSql(sql);
        }


        return SUCCESS;
    }
}
