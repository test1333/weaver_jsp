package gcl.doc.workflow;

import weaver.conn.RecordSet;
import weaver.formmode.setup.ModeRightInfo;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class InsertIntoCYListForFW implements Action {

    @Override
    public String execute(RequestInfo info) {
        BaseBean log = new BaseBean();
        RecordSet rs = new RecordSet();
        DocUtil du = new DocUtil();
        String workflowID = info.getWorkflowid();
        String requestid = info.getRequestid();
        SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = dateFormate.format(new Date());
        String time = sf.format(new Date());
        String tableName = "";
        String gwbh = "";//���ı��
        String fwbh = "";//�����ĺ�
        String fwrq = "";//��������
        String wjbt = "";//���ı���
        String fwzt = "";//��������
        String tjbm = "";//�ύ����
        String tjfb = "";//�ύ�ֲ�
        String tjren = "";//�ύ��
        String tjrq = "";//�ύ����
        String mj = "";//�ܼ�
        String mjts = "";//�ܼ���ʾ
        String jjcd = "";//�����̶�
        String jjcdts = "";//������ʾ
        String zsdw = "";//���͵�λ
        String csdw = "";//���͵�λ
        String spr = "";//������/ǩ����
        String lwnrkxz = "";//�������ļ�
        String lwnrbkxz = "";//���������ļ�
        String gwcyblr = "";//���Ĵ��İ�����
        String gwcyblbm = "";//���Ĵ��İ�����
        String gwcyblfb = "";//���Ĵ��İ���ֲ�
        String gwlx = "";//��������
        String modeTable = du.getBillTableName("CY");// �����б�
        writeLog("start InsertIntoCYListForFW");
        InsertUtil iu = new InsertUtil();
        String modeid = du.getModeId(modeTable);
        String sql = " Select tablename From Workflow_bill Where id in ("
                + " Select formid From workflow_base Where id= " + workflowID
                + ")";
        rs.execute(sql);
        if (rs.next()) {
            tableName = Util.null2String(rs.getString("tablename"));
        }
        writeLog("start tableName:" + tableName);
        sql = "select * from " + tableName + " where requestid=" + requestid;
        rs.executeSql(sql);
        if (rs.next()) {
            gwbh = Util.null2String(rs.getString("gwbh"));
            fwbh = Util.null2String(rs.getString("fwbh"));
            fwrq = Util.null2String(rs.getString("fwrq"));
            wjbt = Util.null2String(rs.getString("wjbt"));
            gwlx = Util.null2String(rs.getString("gwlx"));
            fwzt = Util.null2String(rs.getString("fwzt"));
            tjbm = Util.null2String(rs.getString("tjbm"));
            tjfb = Util.null2String(rs.getString("tjfb"));
            tjren = Util.null2String(rs.getString("tjren"));
            tjrq = Util.null2String(rs.getString("tjrq"));
            mj = Util.null2String(rs.getString("mj"));
            mjts = Util.null2String(rs.getString("mjts"));
            jjcd = Util.null2String(rs.getString("jjcd"));
            jjcdts = Util.null2String(rs.getString("jjcdts"));
            zsdw = Util.null2String(rs.getString("zsdw"));
            csdw = Util.null2String(rs.getString("csdw"));
            spr = Util.null2String(rs.getString("spr"));
            lwnrkxz = Util.null2String(rs.getString("lwnrkxz"));
            lwnrbkxz = Util.null2String(rs.getString("lwnrbkxz"));
            gwcyblr = Util.null2String(rs.getString("gwcyblr"));
            gwcyblbm = Util.null2String(rs.getString("gwcyblbm"));
            gwcyblfb = Util.null2String(rs.getString("gwcyblfb"));
        }
        Map<String, String> mapStr = new HashMap<String, String>();
        mapStr.put("gwbh", gwbh);
        mapStr.put("fwbh", fwbh);
        mapStr.put("fwrq", fwrq);
        mapStr.put("wjbt", wjbt);
        mapStr.put("fwzt", fwzt);
        mapStr.put("tjbm", tjbm);
        mapStr.put("tjrfb", tjfb);
        mapStr.put("tjren", tjren);
        mapStr.put("tjrq", tjrq);
        mapStr.put("mj", mj);
        mapStr.put("mjts", mjts);
        mapStr.put("jjcd", jjcd);
        mapStr.put("jjcdts", jjcdts);
        mapStr.put("zsdw", zsdw);
        mapStr.put("csdw", csdw);
        mapStr.put("spr", spr);
        mapStr.put("kxzwj", lwnrkxz);
        mapStr.put("bkxzwj", lwnrbkxz);
        mapStr.put("requestid", requestid);
        mapStr.put("zcfwrqid", requestid);
        mapStr.put("gwlx", gwlx);
        //mapStr.put("sjzzcyr", requestid);//�ϼ���֯������
        //mapStr.put("sjzzcybm", requestid);//�ϼ���֯���Ĳ���
        //mapStr.put("sjzzcyfb", requestid);//�ϼ���֯���ķֲ�
        //mapStr.put("sjzzjsrq", requestid);//�ϼ���֯��������
        //mapStr.put("sjzzjssj", requestid);//�ϼ���֯����ʱ��
        //mapStr.put("sjzzcyrq", requestid);//�ϼ���֯��������
        //mapStr.put("sjzzcysj", requestid);//�ϼ���֯����ʱ��
        mapStr.put("bcjzzcyr", gwcyblr);//���㼶��֯������
        mapStr.put("bcjzzcybm", gwcyblbm);//���㼶��֯���Ĳ���
        mapStr.put("bcjzzcyfb", gwcyblfb);//���㼶��֯���ķֲ�
        mapStr.put("bcjzzjsrq", nowDate);//���㼶��֯��������
        mapStr.put("bcjzzjssj", time);//���㼶��֯����ʱ��
        //mapStr.put("bcjzzcyrq", requestid);//���㼶��֯��������
        //mapStr.put("bcjzzcysj", requestid);//���㼶��֯����ʱ��
        mapStr.put("lylcid", requestid);//��Դ����
        mapStr.put("parentrequestid", "");//parentrequestid
        mapStr.put("cylctjr", gwcyblr);
        mapStr.put("cllx", "0");//��������
        mapStr.put("lylx", "0");//��Դ����
        mapStr.put("modedatacreatedate", nowDate);
        mapStr.put("modedatacreater", gwcyblr);//������Ҫ����
        mapStr.put("modedatacreatertype", "0");
        mapStr.put("formmodeid", modeid);
        iu.insert(mapStr, modeTable);
        String cyid = "";
        sql = "select id from " + modeTable + " where requestid='" + requestid + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            cyid = Util.null2String(rs.getString("id"));
        }
        if (!"".equals(cyid)) {
            sql = "update " + tableName + " set jksfzx = '1' where requestid=" + requestid;
            writeLog("sql:" + sql);
            rs.executeSql(sql);
            ModeRightInfo ModeRightInfo = new ModeRightInfo();
            ModeRightInfo.editModeDataShare(Integer.valueOf(gwcyblr), Integer.valueOf(modeid),
                    Integer.valueOf(cyid));

        }
        return SUCCESS;
    }

    private void writeLog(Object obj) {
        if (true) {
            new BaseBean().writeLog(this.getClass().getName(), obj);
        }
    }

}
