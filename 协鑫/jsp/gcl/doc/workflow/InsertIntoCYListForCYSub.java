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

public class InsertIntoCYListForCYSub implements Action {

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
        String sjcylcid = "";//上级传阅id，通过该数据去表单建模表反查本层级数据，插入到该纪录的上级数据中
        String parentrequestid = "";//写入数据的流程的上级触发流程，反查拿到requestid，更新到该字段
        String sjzzcyr = "";//上级组织传阅人
        String sjzzcybm = "";//上级组织传阅部门
        String sjzzcyfb = "";//上级组织传阅分部
        String sjzzjsrq = "";//上级组织接收日期
        String sjzzjssj = "";//上级组织接收时间
        String sjzzcyrq = "";//上级组织传阅日期
        String sjzzcysj = "";//上级组织传阅时间
        String zcfwrqid = "";//最初发文流程id
        String xjzzcyfw = "";//下级组织传阅范围
        String gwlx = "";//公文类型
        String modeTable = du.getBillTableName("CY");// 传阅列表
        writeLog("start InsertIntoCYListForCYSub");
        InsertUtil iu = new InsertUtil();
        String modeid = du.getModeId(modeTable);
        String sql = " Select tablename From Workflow_bill Where id in ("
                + " Select formid From workflow_base Where id= " + workflowID
                + ")";
        rs.execute(sql);
        if (rs.next()) {
            tableName = Util.null2String(rs.getString("tablename"));
        }


        String billtable = du.getBillTableName("CY");
        String wfid = du.getWfid("CY");
        String wftable = du.getWfTableName("CY");

        String billid = "";
        String bcjzzcyrq = "";//传阅日期
        int count = 0;
        sql = "select * from " + wftable + " where requestid = " + requestid;
        rs.executeSql(sql);
        if (rs.next()) {
            billid = Util.null2String(rs.getString("sjcyid"));
        }
        sql = "select * from " + billtable + " where id="+billid;
        rs.executeSql(sql);
        if(rs.next()) {
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


        String Cyzlcfqbm = "";
        String Cyzlcfqfb = "";
        String Cyzlcfqr = "";
        writeLog("start tableName:" + tableName);
        sql = "select * from " + tableName + " where requestid=" + requestid;
        rs.executeSql(sql);
        if (rs.next()) {
            gwbh = Util.null2String(rs.getString("gwbh"));
            fwbh = Util.null2String(rs.getString("fwbh"));
            gwlx = Util.null2String(rs.getString("gwlx"));
            fwrq = Util.null2String(rs.getString("fwrq"));
            wjbt = Util.null2String(rs.getString("wjbt"));
            fwzt = Util.null2String(rs.getString("fwzt"));
            tjbm = Util.null2String(rs.getString("tjbm"));
            tjfb = Util.null2String(rs.getString("tjfb"));
            tjren = Util.null2String(rs.getString("tjren"));
            Cyzlcfqr = Util.null2String(rs.getString("Cyzlcfqr"));
            tjrq = Util.null2String(rs.getString("tjrq"));
            mj = Util.null2String(rs.getString("mj"));
            mjts = Util.null2String(rs.getString("mjts"));
            jjcd = Util.null2String(rs.getString("jjcd"));
            jjcdts = Util.null2String(rs.getString("jjcdts"));
            zsdw = Util.null2String(rs.getString("zsdw"));
            csdw = Util.null2String(rs.getString("csdw"));
            spr = Util.null2String(rs.getString("spr"));
            lwnrkxz = Util.null2String(rs.getString("kxzwj"));
            lwnrbkxz = Util.null2String(rs.getString("bkxzwj"));
            sjcylcid = Util.null2String(rs.getString("sjcyid"));
            xjzzcyfw = Util.null2String(rs.getString("xjzzcyfw"));
        }
        writeLog("sjcylcid:" +sjcylcid);
        sql = "select * from " + modeTable + " where id = " + sjcylcid;
        rs.executeSql(sql);
        if (rs.next()) {
            parentrequestid = Util.null2String(rs.getString("requestid"));//写入数据的流程的上级触发流程，反查拿到requestid，更新到该字段
            sjzzcyr = Util.null2String(rs.getString("bcjzzcyr"));
            sjzzcybm = Util.null2String(rs.getString("bcjzzcybm"));
            sjzzcyfb = Util.null2String(rs.getString("bcjzzcyfb"));
            sjzzjsrq = Util.null2String(rs.getString("bcjzzjsrq"));
            sjzzjssj = Util.null2String(rs.getString("bcjzzjssj"));
            sjzzcyrq = Util.null2String(rs.getString("bcjzzcyrq"));
            sjzzcysj = Util.null2String(rs.getString("bcjzzcysj"));
            zcfwrqid = Util.null2String(rs.getString("zcfwrqid"));
        }
        writeLog("tjrq:" + tjrq + ",fwrq:" + fwrq + ",sjzzcyr:" +sjzzcyr + ",sjzzcybm:" + sjzzcybm + ",sjzzcyfb:"+sjzzcyfb + ",sjzzjsrq:"+
                sjzzjsrq+",sjzzjssj:"+sjzzjssj+",sjzzcyrq:"+sjzzcyrq+",sjzzcysj:"+sjzzcysj+",zcfwrqid:"+zcfwrqid+"xjzzcyfw:"+xjzzcyfw);
        String[] str = xjzzcyfw.split(",");
        if(str.length>0){
            for (int i = 0; i < str.length; i++) {
                if("".equals(str[i])){
                    continue;
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
                mapStr.put("gwlx", gwlx);
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

                mapStr.put("zcfwrqid", zcfwrqid);
                mapStr.put("parentrequestid", parentrequestid);
                mapStr.put("sjzzcyr", sjzzcyr);//上级组织传阅人
                mapStr.put("sjzzcybm", sjzzcybm);//上级组织传阅部门
                mapStr.put("sjzzcyfb", sjzzcyfb);//上级组织传阅分部
                mapStr.put("sjzzjsrq", sjzzjsrq);//上级组织接收日期
                mapStr.put("sjzzjssj", sjzzjssj);//上级组织接收时间
                mapStr.put("sjzzcyrq", sjzzcyrq);//上级组织传阅日期
                mapStr.put("sjzzcysj", sjzzcysj);//上级组织传阅时间

                mapStr.put("bcjzzcyr", str[i]);//本层级组织传阅人

                String bcjzzcybm = "";
                String bcjzzcyfb = "";
                writeLog("str[]:" + str[i]);
                String sql_dt = "select * from hrmresource where id=" + str[i];
                rs.executeSql(sql_dt);
                if (rs.next()) {
                    bcjzzcybm = Util.null2String(rs.getString("departmentid"));
                    bcjzzcyfb = Util.null2String(rs.getString("subcompanyid1"));
                }
                mapStr.put("bcjzzcybm", bcjzzcybm);//本层级组织传阅部门
                mapStr.put("bcjzzcyfb", bcjzzcyfb);//本层级组织传阅分部
                mapStr.put("bcjzzjsrq", nowDate);//本层级组织接收日期
                mapStr.put("bcjzzjssj", time);//本层级组织接收时间
                //mapStr.put("bcjzzcyrq", requestid);//本层级组织传阅日期
                //mapStr.put("bcjzzcysj", requestid);//本层级组织传阅时间
                mapStr.put("lylcid", requestid);//来源流程
                mapStr.put("cylctjr", Cyzlcfqr);
                mapStr.put("cllx", "0");//处理类型
                mapStr.put("lylx", "1");//来源类型
                mapStr.put("modedatacreatedate", nowDate);
                mapStr.put("modedatacreater", str[i]);//？？机要秘书
                mapStr.put("modedatacreatertype", "0");
                mapStr.put("formmodeid", modeid);
                writeLog("mapStr:" + mapStr);
                iu.insert(mapStr, modeTable);
                String cyid = "";
                sql = "select max(id) as id from " + modeTable + " where requestid='" + requestid + "'";
                rs.executeSql(sql);
                if (rs.next()) {
                    cyid = Util.null2String(rs.getString("id"));
                }
                if (!"".equals(cyid)) {
                    ModeRightInfo ModeRightInfo = new ModeRightInfo();
                    ModeRightInfo.editModeDataShare(Integer.valueOf(str[i]), Integer.valueOf(modeid),
                            Integer.valueOf(cyid));

                }

            }
        }

        if (!"".equals(sjcylcid)) {
            sql = "update " + modeTable + " set cllx='1' where id=" + sjcylcid;
            rs.executeSql(sql);
        }
        return SUCCESS;
    }

    private void writeLog(Object obj) {
        if (true) {
            new BaseBean().writeLog(this.getClass().getName(), obj);
        }
    }

}
