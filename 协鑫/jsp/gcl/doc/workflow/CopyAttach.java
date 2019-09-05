package gcl.doc.workflow;

import weaver.conn.RecordSet;
import weaver.docs.docs.DocComInfo;
import weaver.docs.docs.DocManager;
import weaver.docs.docs.ShareManageDocOperation;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 协鑫
 *
 * @author 作者  张瑞坤
 * @version 创建时间：2019-3-12 上午11:36:17
 * 类说明
 */
public class CopyAttach implements Action {
    @Override
    public String execute(RequestInfo info) {
        RecordSet rs = new RecordSet();
        BaseBean log = new BaseBean();
        String requestid = info.getRequestid();
        String tablename = info.getRequestManager().getBillTableName();
        String kxzs = "";//可下载文档的ids
        String bkxzs = "";//不可下载文档的ids
        String kxzs_new = "";//可下载文档的ids
        String bkxzs_new = "";//不可下载文档的ids
        int kxzmbml = 78703;//可下载目标目录
        int bkxzmbml = 78704;//不可下载目标目录
        String flag = "";
        String sql = "select lwnrkxz,lwnrbkxz from " + tablename + " where requestid = '" + requestid + "'";
        rs.executeSql(sql);
        log.writeLog("sql----------" + sql);
        if (rs.next()) {
            bkxzs = Util.null2String(rs.getString("lwnrbkxz"));
            kxzs = Util.null2String(rs.getString("lwnrkxz"));
        }
        if (bkxzs.length() < 1 && kxzs.length() < 1) {
            return SUCCESS;
        }
        //不可下载
        String bkxz[] = bkxzs.split(",");
        for (int i = 0; i < bkxz.length; i++) {
            sql = "select seccategory ,doccreaterid from docdetail where id = '" + bkxz[i] + "'";
            rs.executeSql(sql);
            if (rs.next()) {
//				String seccategory = rs.getString("seccategory");
                String doccreaterid = rs.getString("doccreaterid");
                try {
                    bkxzs_new = bkxzs_new + flag + copyFile(bkxz[i], bkxzmbml, Util.getIntValue(doccreaterid, 0), 28529);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            if (!"".equals(bkxzs_new)) {
                flag = ",";
            }

        }
        log.writeLog("bkxzs_new----------" + bkxzs_new);
        if (bkxzs_new.length() > 1) {
            sql = "update " + tablename + " set  lwnrbkxz= '" + bkxzs_new + "' where requestid = '" + requestid + "'";
            log.writeLog("updateSQLBKXZ------" + sql);
            rs.executeSql(sql);
        }
        //可下载
        String kxz[] = kxzs.split(",");
        flag = "";
        for (int i = 0; i < kxz.length; i++) {
            sql = "select seccategory ,doccreaterid from docdetail where id = '" + kxz[i] + "'";
            rs.executeSql(sql);
            if (rs.next()) {
//				String seccategory = rs.getString("seccategory");
                String doccreaterid = rs.getString("doccreaterid");
                try {
                    kxzs_new = kxzs_new + flag + copyFile(kxz[i], kxzmbml, Util.getIntValue(doccreaterid, 0), 28528);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            if (!"".equals(kxzs_new)) {
                flag = ",";
            }

        }
        if (kxzs_new.length() > 1) {
            sql = "update " + tablename + " set  lwnrkxz= '" + kxzs_new + "' where requestid = '" + requestid + "'";
            log.writeLog("updateSQLKXZ------" + sql);
            rs.executeSql(sql);
        }
        return SUCCESS;
    }

    /**
     * @param @param  docStrs      文档ids
     * @param @param  seccategory  目录id
     * @param @param  userid       创建人
     * @param @return
     * @param @throws Exception
     * @return String             返回类型
     * @Description: TODO(复制文档)
     * @version 张瑞坤  2019-3-12 上午11:42:16
     */
    public String copyFile(String docStrs, int seccategory, int userid, int Subcategory) throws Exception {
        if ("".equals(Util.null2String(docStrs))) {
            return "";
        }
        BaseBean log = new BaseBean();
        log.writeLog("docStrs+seccategory+userid----------" + docStrs + seccategory + userid);
        DocManager docManager = new DocManager();
        DocComInfo dci = new DocComInfo();
        //MultiAclManager am = new MultiAclManager();
        ShareManageDocOperation manager = new ShareManageDocOperation();
        String docids[] = Util.TokenizerString2(docStrs, ",");
        String newdocids = "";
        String flag = "";
        for (int i = 0; i < docids.length; i++) {
            int docid = 0;
            String subject = "";
            docid = Util.getIntValue(docids[i], 0);
            subject = Util.null2String(dci.getDocname(docids[i]));
            // 如果目标子目录允许文件名重复
            //DocUtil docUtil = new DocUtil();
            docManager.setId(docid);
            docManager.setUserid(userid);
            docManager.setUsertype("1");
            docManager.setDocsubject(subject);
            docManager.setClientAddress("127.0.0.1");
            docManager.setMaincategory(14838);
            docManager.setSubcategory(Subcategory);
            docManager.setSeccategory(seccategory);
            docManager.copyDoc();
            manager.copyMoveDocShareBySec(seccategory, docManager.getId());// DocManager.getId()获取复制的新文档的id
            newdocids = newdocids + flag + String.valueOf(docManager.getId());
            if (!"".equals(newdocids)) {
                flag = ",";
            }
        }
        return newdocids;
    }

}
