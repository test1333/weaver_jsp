package gcl.doc.workflow;


import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * ��������������
 *
 * @author tangj
 */
public class CreateCYWorkFLow{
    /**
     * @param billid  ��ģ����id
     * @param creater ������
     */
    public String CreateWF(String billid,String creater){
        RecordSet rs = new RecordSet();
        DocUtil du = new DocUtil();
        String billtable = du.getBillTableName("CY");
        String wfid = du.getWfid("CY");
        String wftable = du.getWfTableName("CY");
        String swtable = du.getBillTableName("GWLX");
        SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = dateFormate.format(new Date());
        String time = sf.format(new Date());
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
        String kxzwj = "";//�������ļ�
        String bkxzwj = "";//���������ļ�
        String bcjzzcyrq = "";//��������
        String cylcid = "";//��������
        String gwlx = "";//��������
//        String tjrq = "";//
        int count = 0;

        String sql = "select * from " + billtable + " where id=" + billid;
        rs.executeSql(sql);
        if(rs.next()){
            gwbh = Util.null2String(rs.getString("gwbh"));
            fwbh = Util.null2String(rs.getString("fwbh"));
            fwrq = Util.null2String(rs.getString("fwrq"));
            tjrq = Util.null2String(rs.getString("tjrq"));
            wjbt = Util.null2String(rs.getString("wjbt"));
            fwzt = Util.null2String(rs.getString("fwzt"));
            gwlx = Util.null2String(rs.getString("gwlx"));
            tjbm = Util.null2String(rs.getString("tjbm"));
            tjfb = Util.null2String(rs.getString("tjrfb"));
            tjren = Util.null2String(rs.getString("tjren"));
            mj = Util.null2String(rs.getString("mj"));
            mjts = Util.null2String(rs.getString("mjts"));
            jjcdts = Util.null2String(rs.getString("jjcdts"));
            jjcd = Util.null2String(rs.getString("jjcd"));
            zsdw = Util.null2String(rs.getString("zsdw"));
            csdw = Util.null2String(rs.getString("csdw"));
            spr = Util.null2String(rs.getString("spr"));
            kxzwj = Util.null2String(rs.getString("kxzwj"));
            bkxzwj = Util.null2String(rs.getString("bkxzwj"));
            bcjzzcyrq = Util.null2String(rs.getString("bcjzzcyrq"));
            cylcid = Util.null2String(rs.getString("cylcid"));
        }
        sql = "select count(1) as count from " + wftable + " where sjcyid='" + billid + "'";
        rs.executeSql(sql);
        if(rs.next()){
            count = rs.getInt("count");
        }
        String Cyzlcfqbm = "";
        String Cyzlcfqfb = "";
        sql = "select * from hrmresource where id = " + creater;
        rs.executeSql(sql);
        if(rs.next()){
            Cyzlcfqbm = Util.null2String(rs.getString("DEPARTMENTID"));
            Cyzlcfqfb = Util.null2String(rs.getString("SUBCOMPANYID1"));
        }
        JSONObject jsonObject = new JSONObject();
        JSONObject header = new JSONObject();
        JSONObject arr = new JSONObject();
        String result = "";
        String rqid = "-1";
        try{
            jsonObject.put("HEADER",header);
            jsonObject.put("DETAILS",arr);
            header.put("gwbh",gwbh);
            header.put("fwbh",fwbh);
            header.put("gwlx",gwlx);
            header.put("fwrq",fwrq);
            header.put("Cyzlcfqr",creater);
            header.put("Cyzlcfqbm",Cyzlcfqbm);
            header.put("Cyzlcfqfb",Cyzlcfqfb);
            header.put("cylctjsj",time);
            header.put("cylctjrq",nowDate);
            header.put("tjrq",tjrq);
            header.put("wjbt",wjbt);
            header.put("fwzt",fwzt);
            header.put("tjbm",tjbm);
            header.put("tjfb",tjfb);
            header.put("tjren",tjren);
            header.put("mj",mj);
            header.put("mjts",mjts);
            header.put("jjcdts",jjcdts);
            header.put("jjcd",jjcd);
            header.put("zsdw",zsdw);
            header.put("csdw",csdw);
            header.put("spr",spr);
            header.put("kxzwj",kxzwj);
            //			header.put("bkxzwj", bkxzwj);
            header.put("bkxzwj",bkxzwj);
            header.put("sjcyid",billid);

            AutoRequestService au = new AutoRequestService();
            result = au.createRequest(wfid,jsonObject.toString(),creater,"0");
            JSONObject jo = new JSONObject(result);
            String OA_ID = jo.getString("OA_ID");
            if(Util.getIntValue(OA_ID,0) > 0){
                rqid = OA_ID;
                if(!"".equals(cylcid)){
                    cylcid = cylcid + "," + rqid;
                }else{
                    cylcid = rqid;
                }

                sql = "update " + billtable + " set cylcid='" + cylcid + "' where id=" + billid;
                rs.executeSql(sql);
                String gwlxwb = "";
                sql = "select * from " + swtable + " where id=" + gwlx;
                rs.executeSql(sql);
                if(rs.next()){
                    gwlxwb = Util.null2String(rs.getString("gwlx"));
                }
                sql = "update workflow_requestbase set requestname='��" + gwlxwb + "��" + wjbt + "' where requestid=" + rqid;
                rs.executeSql(sql);
//							if(count <=0 || "".equals(bcjzzcyrq)){
//									sql = "update " + billtable + " set bcjzzcyrq='"+nowDate+"',bcjzzcysj='"+time+"' where id="+billid;
//									rs.executeSql(sql);
//							}
            }else{
                rqid = "-1";
            }
        }catch(Exception e){
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return rqid;
    }

    /**
     * @param billid  ��ģ����id
     * @param creater ������
     */
    public String CreateSW(String billid,String creater){
        RecordSet rs = new RecordSet();
        DocUtil du = new DocUtil();
        String billtable = du.getBillTableName("CY");
        String wfid = du.getWfid("SW");
        String wftable = du.getWfTableName("SW");
        String swtable = du.getBillTableName("GWLX");
        SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = dateFormate.format(new Date());
        String time = sf.format(new Date());
        writeLog("billid=" + billid + ",wfid=" + wfid + ",wftable=" + wftable + ",swtable=" + swtable + ",creater=" + creater);
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
        String kxzwj = "";//�������ļ�
        String bkxzwj = "";//���������ļ�
        String bcjzzcyrq = "";//��������
        String cylcid = "";//��������
        String gwlx = "";//��������
//        String tjrq = "";//
        int count = 0;

        String sql = "select * from " + billtable + " where id=" + billid;
        rs.executeSql(sql);
        writeLog("sql2=" + sql);
        if(rs.next()){
            gwbh = Util.null2String(rs.getString("gwbh"));
            fwbh = Util.null2String(rs.getString("fwbh"));
            fwrq = Util.null2String(rs.getString("fwrq"));
            tjrq = Util.null2String(rs.getString("tjrq"));
            wjbt = Util.null2String(rs.getString("wjbt"));
            fwzt = Util.null2String(rs.getString("fwzt"));
            gwlx = Util.null2String(rs.getString("gwlx"));

            tjbm = Util.null2String(rs.getString("tjbm"));
            tjfb = Util.null2String(rs.getString("tjrfb"));
            tjren = Util.null2String(rs.getString("tjren"));
            mj = Util.null2String(rs.getString("mj"));
            mjts = Util.null2String(rs.getString("mjts"));
            jjcdts = Util.null2String(rs.getString("jjcdts"));
            jjcd = Util.null2String(rs.getString("jjcd"));
            zsdw = Util.null2String(rs.getString("zsdw"));
            csdw = Util.null2String(rs.getString("csdw"));
            spr = Util.null2String(rs.getString("spr"));
            kxzwj = Util.null2String(rs.getString("kxzwj"));
            bkxzwj = Util.null2String(rs.getString("bkxzwj"));
            bcjzzcyrq = Util.null2String(rs.getString("bcjzzcyrq"));
            cylcid = Util.null2String(rs.getString("cylcid"));
            writeLog("gwbh=" + gwbh + ",wjbt=" + wjbt + ",mjts=" + mjts + ",kxzwj=" + kxzwj + ",gwlx=" + gwlx);

        }
        sql = "select count(1) as count from " + wftable + " where sjcyid='" + billid + "'";
        rs.executeSql(sql);
        if(rs.next()){
            count = rs.getInt("count");
        }
        String Cyzlcfqbm = "";
        String Cyzlcfqfb = "";
        sql = "select * from hrmresource where id = " + creater;
        rs.executeSql(sql);
        if(rs.next()){
            Cyzlcfqbm = Util.null2String(rs.getString("DEPARTMENTID"));
            Cyzlcfqfb = Util.null2String(rs.getString("SUBCOMPANYID1"));
        }
        JSONObject jsonObject = new JSONObject();
        JSONObject header = new JSONObject();
        JSONObject arr = new JSONObject();
        String result = "";
        String rqid = "-1";
        try{
            jsonObject.put("HEADER",header);
            jsonObject.put("DETAILS",arr);
            header.put("gwbh",gwbh);
            header.put("gwlx",gwlx);
            header.put("fwbh",fwbh);
            header.put("fwrq",fwrq);
            header.put("Cyzlcfqr",creater);
            header.put("Cyzlcfqbm",Cyzlcfqbm);
            header.put("Cyzlcfqfb",Cyzlcfqfb);
            header.put("cylctjsj",time);
            header.put("cylctjrq",nowDate);
            header.put("tjrq",tjrq);
            header.put("wjbt",wjbt);
            header.put("fwzt",fwzt);
            header.put("tjbm",tjbm);
            header.put("tjfb",tjfb);
            header.put("tjren",tjren);
            header.put("mj",mj);
            header.put("mjts",mjts);
            header.put("jjcdts",jjcdts);
            header.put("jjcd",jjcd);
            header.put("zsdw",zsdw);
            header.put("csdw",csdw);
            header.put("spr",spr);
            header.put("kxzwj",kxzwj);
            header.put("swrq",nowDate);
            header.put("bkxzwj",bkxzwj);
            header.put("sjcyid",billid);
            writeLog("jsonObject=" + jsonObject.toString());
            AutoRequestService au = new AutoRequestService();
            result = au.createRequest(wfid,jsonObject.toString(),creater,"0");
            writeLog("result=" + result);
            JSONObject jo = new JSONObject(result);
            String OA_ID = jo.getString("OA_ID");
            if(Util.getIntValue(OA_ID,0) > 0){
                rqid = OA_ID;
                sql = "update " + billtable + " set swlcid='" + rqid + "' where id=" + billid;
                rs.executeSql(sql);
                writeLog("sql3=" + sql);
                String gwlxwb = "";
                sql = "select * from " + swtable + " where id=" + gwlx;
                rs.executeSql(sql);
                if(rs.next()){
                    gwlxwb = Util.null2String(rs.getString("gwlx"));
                }
                sql = "update workflow_requestbase set requestname='��" + gwlxwb + "��" + wjbt + "' where requestid=" + rqid;
                rs.executeSql(sql);
                writeLog("sql1=" + sql);
//							if(count <=0 || "".equals(bcjzzcyrq)){
//									sql = "update " + billtable + " set bcjzzcyrq='"+nowDate+"',bcjzzcysj='"+time+"' where id="+billid;
//									rs.executeSql(sql);
//							}
            }else{
                rqid = "-1";
            }
        }catch(Exception e){
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return rqid;
    }

    private void writeLog(Object obj){
        if(true){
            new BaseBean().writeLog(this.getClass().getName(),obj);
        }
    }
}
