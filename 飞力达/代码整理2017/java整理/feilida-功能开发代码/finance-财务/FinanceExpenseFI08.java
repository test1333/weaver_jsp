package feilida.finance;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * Updated by adore on 2017/01/11.
 * ƾ֤ժҪ
 * 1.����������й�ѡ�
 * ���ɹ���һ��������������"D01-��ͨ�౨����D03-ҵ���д��ѣ�D04-��Ѷ����-��������Ѻ�ά���ѡ���
 * ��OAԤ���������š�+�������ڡ��·ݡ�+����Ӧ�����ơ�+������Ŀ���ơ�
 * ���ɹ��򣨶���������������" D02-�ʲ��౨��������OAԤ���������š�+�������ڡ��·ݡ�+����Ӧ�����ơ�+�ʲ�������
 * <p>
 * 2.����������޹�ѡ�
 * ���ɹ���һ��������������"D01-��ͨ�౨����D03-ҵ���д��ѣ�D04-��Ѷ����-��������Ѻ�ά���ѡ���
 * �������ڡ��·ݡ�+����Ӧ�����ơ�+������Ŀ���ơ�
 * ���ɹ��򣨶���������������" D02-�ʲ��౨�������������ڡ��·ݡ�+����Ӧ�����ơ�+�ʲ�������
 */

public class FinanceExpenseFI08 implements Action {

    BaseBean log = new BaseBean();//����д����־�Ķ���

    public String execute(RequestInfo info) {
        log.writeLog("FinanceExpenseFI08������������");

        String workflowID = info.getWorkflowid();
        String requestid = info.getRequestid();//��ȡ��������ID��requestIDֵ

        RecordSet rs = new RecordSet();
        RecordSet rs_dt = new RecordSet();

        String tableName = "";
        String tableNamedt = "";
        String tableNamedt3 = "";
        String mainID = "";
        String expType = "";//��������
        String applyDate = "";//��������

        String sql = " Select tablename From Workflow_bill Where id in ("
                + " Select formid From workflow_base Where id= "
                + workflowID + ")";

        rs.execute(sql);
        if (rs.next()) {
            tableName = Util.null2String(rs.getString("tablename"));
        }

        if (!"".equals(tableName)) {
            String PZZY = "";//ƾ֤ժҪ
            tableNamedt = tableName + "_dt1";
            tableNamedt3 = tableName + "_dt3";

            // ��ѯ����
            sql = "select * from " + tableName + " where requestid=" + requestid;
            rs.execute(sql);
            if (rs.next()) {
                mainID = Util.null2String(rs.getString("ID"));
                expType = Util.null2String(rs.getString("BXLX"));
                //applyDate = Util.null2String(rs.getString("GZRQ"));
                applyDate = Util.null2String(rs.getString("BXRQ"));
                if (!"".equals(applyDate)) {
                    applyDate = applyDate.substring(5, 7);
                }
            }

            //�����Ƿ��й�ѡ
            int isExist = 0;
            sql = " select count(1) as isExist from " + tableNamedt3 + " where mainid = " + mainID + " and XZ = 1 ";
            rs.execute(sql);
            log.writeLog("�Ƿ����:" + sql);
            if (rs.next()) {
                isExist = rs.getInt("isExist");
            }

            if (isExist > 0) {
                //��ѯ��ϸ��3
                String applyNum = "";//OAԤ����������
                sql = "select * from " + tableNamedt3 + " where mainid=" + mainID;
                rs_dt.execute(sql);
                log.writeLog("OAԤ����������:" + sql);
                while (rs_dt.next()) {
                    applyNum = Util.null2String(rs_dt.getString("YFKBH"));
                }

                //��ѯ��ϸ��1
                sql = "select * from " + tableNamedt + " where mainid=" + mainID;
                rs_dt.execute(sql);
                log.writeLog("��ѯ���ÿ�Ŀ:" + sql);
                while (rs_dt.next()) {
                    String zcms = Util.null2String(rs_dt.getString("ZCMS"));
                    String pro_id = Util.null2String(rs_dt.getString("FYXMMC"));
                    String supllierName = Util.null2String(rs_dt.getString("GYSMC"));
                    String dtid = Util.null2String(rs_dt.getString("id"));
                    String sql_name = " select fyxmmc from uf_fyxmdzb where id=" + pro_id;
                    String pro_name = "";
                    rs.executeSql(sql_name);
                    if (rs.next()) {
                        pro_name = Util.null2String(rs.getString("fyxmmc"));

                    }
                    if ("1".equals(expType)) {
                        PZZY = applyNum + applyDate + supllierName + zcms;
                    } else {
                        PZZY = applyNum + applyDate + supllierName + pro_name;
                    }
                    String sql_update_dt1 = " update " + tableNamedt + " set PZZY='" + PZZY + "' where id= " + dtid;
                    rs.executeSql(sql_update_dt1);
                }

            } else {
                //��ѯ��ϸ��1
                sql = "select * from " + tableNamedt + " where mainid=" + mainID;
                rs_dt.execute(sql);
                log.writeLog("��ѯ���ÿ�Ŀ:" + sql);
                while (rs_dt.next()) {
                    String zcms = Util.null2String(rs_dt.getString("ZCMS"));
                    String pro_id = Util.null2String(rs_dt.getString("FYXMMC"));
                    String supllierName = Util.null2String(rs_dt.getString("GYSMC"));
                    String dtid = Util.null2String(rs_dt.getString("id"));
                    String sql_name = " select fyxmmc from uf_fyxmdzb where id=" + pro_id;
                    String pro_name = "";
                    rs.executeSql(sql_name);
                    if (rs.next()) {
                        pro_name = Util.null2String(rs.getString("fyxmmc"));

                    }
                    if ("1".equals(expType)) {
                        PZZY = applyDate + supllierName + zcms;
                    } else {
                        PZZY = applyDate + supllierName + pro_name;
                    }
                    String sql_update_dt1 = " update " + tableNamedt + " set PZZY='" + PZZY + "' where id= " + dtid;
                    rs.executeSql(sql_update_dt1);
                    log.writeLog("sql_update=" + sql_update_dt1);
                }
                
            }
            
            sql = " delete from " + tableNamedt3 + " where mainid = " + mainID + " and XZ = 0";
            rs.execute(sql);
            log.writeLog("��ϸɾ��:" + sql);
            
        } else {

            return "-1";
        }
        return SUCCESS;
    }

}

