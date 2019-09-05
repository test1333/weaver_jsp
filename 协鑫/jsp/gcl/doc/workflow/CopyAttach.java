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
 * Э��
 *
 * @author ����  ������
 * @version ����ʱ�䣺2019-3-12 ����11:36:17
 * ��˵��
 */
public class CopyAttach implements Action {
    @Override
    public String execute(RequestInfo info) {
        RecordSet rs = new RecordSet();
        BaseBean log = new BaseBean();
        String requestid = info.getRequestid();
        String tablename = info.getRequestManager().getBillTableName();
        String kxzs = "";//�������ĵ���ids
        String bkxzs = "";//���������ĵ���ids
        String kxzs_new = "";//�������ĵ���ids
        String bkxzs_new = "";//���������ĵ���ids
        int kxzmbml = 78703;//������Ŀ��Ŀ¼
        int bkxzmbml = 78704;//��������Ŀ��Ŀ¼
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
        //��������
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
        //������
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
     * @param @param  docStrs      �ĵ�ids
     * @param @param  seccategory  Ŀ¼id
     * @param @param  userid       ������
     * @param @return
     * @param @throws Exception
     * @return String             ��������
     * @Description: TODO(�����ĵ�)
     * @version ������  2019-3-12 ����11:42:16
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
            // ���Ŀ����Ŀ¼�����ļ����ظ�
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
            manager.copyMoveDocShareBySec(seccategory, docManager.getId());// DocManager.getId()��ȡ���Ƶ����ĵ���id
            newdocids = newdocids + flag + String.valueOf(docManager.getId());
            if (!"".equals(newdocids)) {
                flag = ",";
            }
        }
        return newdocids;
    }

}
