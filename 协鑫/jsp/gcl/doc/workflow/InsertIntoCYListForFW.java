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
        String gwbh = "";//公文编号
        String fwbh = "";//公文文号
        String fwrq = "";//发文日期
        String wjbt = "";//公文标题
        String fwzt = "";//发文主体
        String tjbm = "";//提交部门
        String tjfb = "";//提交分部
        String tjren = "";//提交人
        String tjrq = "";//提交日期
        String mj = "";//密级
        String mjts = "";//密级提示
        String jjcd = "";//紧急程度
        String jjcdts = "";//紧急提示
        String zsdw = "";//主送单位
        String csdw = "";//抄送单位
        String spr = "";//审批人/签发人
        String lwnrkxz = "";//可下载文件
        String lwnrbkxz = "";//不可下载文件
        String gwcyblr = "";//公文传阅办理人
        String gwcyblbm = "";//公文传阅办理部门
        String gwcyblfb = "";//公文传阅办理分部
        String gwlx = "";//公文类型
        String modeTable = du.getBillTableName("CY");// 传阅列表
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
        //mapStr.put("sjzzcyr", requestid);//上级组织传阅人
        //mapStr.put("sjzzcybm", requestid);//上级组织传阅部门
        //mapStr.put("sjzzcyfb", requestid);//上级组织传阅分部
        //mapStr.put("sjzzjsrq", requestid);//上级组织接收日期
        //mapStr.put("sjzzjssj", requestid);//上级组织接收时间
        //mapStr.put("sjzzcyrq", requestid);//上级组织传阅日期
        //mapStr.put("sjzzcysj", requestid);//上级组织传阅时间
        mapStr.put("bcjzzcyr", gwcyblr);//本层级组织传阅人
        mapStr.put("bcjzzcybm", gwcyblbm);//本层级组织传阅部门
        mapStr.put("bcjzzcyfb", gwcyblfb);//本层级组织传阅分部
        mapStr.put("bcjzzjsrq", nowDate);//本层级组织接收日期
        mapStr.put("bcjzzjssj", time);//本层级组织接收时间
        //mapStr.put("bcjzzcyrq", requestid);//本层级组织传阅日期
        //mapStr.put("bcjzzcysj", requestid);//本层级组织传阅时间
        mapStr.put("lylcid", requestid);//来源流程
        mapStr.put("parentrequestid", "");//parentrequestid
        mapStr.put("cylctjr", gwcyblr);
        mapStr.put("cllx", "0");//处理类型
        mapStr.put("lylx", "0");//来源类型
        mapStr.put("modedatacreatedate", nowDate);
        mapStr.put("modedatacreater", gwcyblr);//？？机要秘书
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
