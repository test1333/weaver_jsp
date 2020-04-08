package APPDEV.HQ.qiyuesuo.action;

import APPDEV.HQ.Contract.STP.util.CreateContractFileUtil;
import APPDEV.HQ.UTIL.AppWFUtil;
import APPDEV.HQ.qiyuesuo.docx.DocUtil;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 2020年电商平台销售授权书
 *
 * @author : adore
 * @version : v1.0
 * @since : 2019-07-30 15:04
 */

public class UpdateEBusinessAuthAction extends BaseBean implements Action {
    public String fieldName;

    @Override
    public String execute(RequestInfo info) {
        RecordSet rs = new RecordSet();
        DocUtil docUtil = new DocUtil();
        AppWFUtil wfUtil = new AppWFUtil();
        String requestid = Util.null2String(info.getRequestid());
        this.writeLog("2020年电商平台销售授权书 Action开始：" + requestid);
        String tableName = wfUtil.getTableName(requestid);
        String workflowID = wfUtil.getWorkflowid(requestid);
        String AuthoriDeptFrom = ""; // 借阅人
        String AuthoriDeptTo = ""; // 借阅日期
        String ecpt = "";
        String ecshop = "";
        String ValidDateB = "";
        String ValidDateE = "";
        String pic = "";
        String picName = "";
        String Applicant = "";
        String XTemp = ""; // 授权书不启用模板
        String fileName = "2020年电商平台销售授权书" + requestid;

        String pbzz = ""; // 真真
        String pbqf = ""; // 清风
        String pbvj = ""; // 唯洁雅
        String pbem = ""; // 铂丽雅
        String pbtotal = ""; // 合并授权

        String sql;
        if (!"".equals(tableName)) {
            sql = " select * from " + tableName + " where requestid= " + requestid;
            this.writeLog("流程主数据：" + sql);
            rs.execute(sql);
            if (rs.next()) {
                XTemp = Util.null2String(rs.getString("XTemp"));
                AuthoriDeptFrom = Util.null2String(rs.getString("AuthoriDeptFrom"));
                AuthoriDeptTo = Util.null2String(rs.getString("AuthoriDeptTo"));
                ecpt = Util.null2String(rs.getString("ecpt"));
                ecshop = Util.null2String(rs.getString("ecshop"));
                ValidDateB = Util.null2String(rs.getString("ValidDateB"));
                ValidDateE = Util.null2String(rs.getString("ValidDateE"));
                Applicant = Util.null2String(rs.getString("Applicant"));
                pbzz = Util.null2String(rs.getString("pbzz"));
                pbqf = Util.null2String(rs.getString("pbqf"));
                pbvj = Util.null2String(rs.getString("pbvj"));
                pbem = Util.null2String(rs.getString("pbem"));
                pbtotal = Util.null2String(rs.getString("pbtotal"));
            }

            if (!"1".equals(XTemp)) {

                // 文件目录
                String docCategory = "";
                sql = " select DOCCATEGORY from WORKFLOW_BASE where ID=" + workflowID;
                rs.execute(sql);
                if (rs.next()) {
                    String docCategories = Util.null2String(rs.getString("DOCCATEGORY"));
                    docCategory = docCategories.split(",")[2];
                }
                this.writeLog("docCategory:" + docCategory);

                List<Map<String, String>> mapList = new ArrayList<Map<String, String>>();
                if ("1".equals(pbzz)) {
                    pic = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/tempFile/pbzz.png";
                    picName = "真真";

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("pic", pic);
                    map.put("picName", picName);
                    map.put("fileName", fileName + picName + ".pdf");
                    mapList.add(map);
                }

                if ("1".equals(pbqf)) {
                    Map<String, String> map = new HashMap<String, String>();
                    pic = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/tempFile/pbqf.png";
                    picName = "清风";
                    map.put("pic", pic);
                    map.put("picName", picName);
                    map.put("fileName", fileName + picName + ".pdf");
                    mapList.add(map);
                }

                if ("1".equals(pbvj)) {
                    pic = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/tempFile/pbvj.png";
                    picName = "唯洁雅";

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("pic", pic);
                    map.put("picName", picName);
                    map.put("fileName", fileName + picName + ".pdf");
                    mapList.add(map);
                }

                if ("1".equals(pbem)) {
                    pic = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/tempFile/pbem.png";
                    picName = "铂丽雅";

                    Map<String, String> map = new HashMap<String, String>();
                    map.put("pic", pic);
                    map.put("picName", picName);
                    map.put("fileName", fileName + picName + ".pdf");
                    mapList.add(map);
                }

                if ("1".equals(pbtotal)) {
                    HashMap<String, String> map = new HashMap<String, String>();
                    map.put("rqid", requestid);
                    map.put("AuthoriDeptFrom", AuthoriDeptFrom);
                    map.put("AuthoriDeptFrom2", AuthoriDeptFrom);
                    map.put("AuthoriDeptTo", AuthoriDeptTo);
                    map.put("ecpt", ecpt);
                    map.put("ecshop", ecshop);
                    map.put("ValidDateB", ValidDateB);
                    map.put("ValidDateB2", ValidDateB);
                    map.put("ValidDateE", ValidDateE);

                    this.writeLog("map:" + map);
                    CreateContractFileUtil fileUtil = new CreateContractFileUtil();
                    String pdfPath = docUtil.createDoc(map, mapList);
                    this.writeLog("pdfPath:" + pdfPath);
                    if (!"".equals(pdfPath)) {
                        try {
                            String docid = fileUtil.createDoc(pdfPath, docCategory, fileName + "合并授权.pdf", Applicant);
                            this.writeLog("docid:" + docid);
                            if (!"-1".equals(docid)) {
                                String reqs = "";
                                sql = " select * from " + tableName + " where requestid=" + requestid;
                                rs.execute(sql);
                                if (rs.next()) {
                                    reqs = Util.null2String(rs.getString(fieldName));
                                }

                                if (!"".equals(reqs)) {
                                    reqs += "," + docid;
                                } else {
                                    reqs = docid;
                                }

                                sql = "update " + tableName + " set " + fieldName + "='" + reqs + "' where requestid=" + requestid;
                                writeLog("更新流程合同文档字段：" + sql);
                                rs.execute(sql);
                            }
                        } catch (Exception e) {
                            this.writeLog(e);
                        }
                    }
                } else {
                    if (mapList.size() > 0) {
                        for (int i = 0; i < mapList.size(); i++) {
                            HashMap<String, String> map = new HashMap<String, String>();
                            map.put("rqid", requestid);
                            map.put("AuthoriDeptFrom", AuthoriDeptFrom);
                            map.put("AuthoriDeptFrom2", AuthoriDeptFrom);
                            map.put("AuthoriDeptTo", AuthoriDeptTo);
                            map.put("ecpt", ecpt);
                            map.put("ecshop", ecshop);
                            map.put("ValidDateB", ValidDateB);
                            map.put("ValidDateB2", ValidDateB);
                            map.put("ValidDateE", ValidDateE);
                            List<Map<String, String>> list = new ArrayList<Map<String, String>>();
                            Map<String, String> picMap = new HashMap<String, String>();
                            picMap.put("pic", mapList.get(i).get("pic"));
                            picMap.put("picName", mapList.get(i).get("picName"));
                            list.add(picMap);

                            this.writeLog("map:" + map);
                            CreateContractFileUtil fileUtil = new CreateContractFileUtil();
                            String pdfPath = docUtil.createDoc(map, list);
                            this.writeLog("pdfPath:" + pdfPath);
                            if (!"".equals(pdfPath)) {
                                try {
                                    String docid = fileUtil.createDoc(pdfPath, docCategory, mapList.get(i).get("fileName"), Applicant);
                                    this.writeLog("docid:" + docid);
                                    if (!"-1".equals(docid)) {
                                        String reqs = "";
                                        sql = " select * from " + tableName + " where requestid=" + requestid;
                                        rs.execute(sql);
                                        if (rs.next()) {
                                            reqs = Util.null2String(rs.getString(fieldName));
                                        }

                                        if (!"".equals(reqs)) {
                                            reqs += "," + docid;
                                        } else {
                                            reqs = docid;
                                        }

                                        sql = "update " + tableName + " set " + fieldName + "='" + reqs + "' where requestid=" + requestid;
                                        writeLog("更新流程合同文档字段：" + sql);
                                        rs.execute(sql);
                                    }
                                } catch (Exception e) {
                                    this.writeLog(e);
                                }
                            }
                        }
                    }
                }
            } else {
                this.writeLog("授权书不启用模板");
            }
        } else {
            this.writeLog("表名获取失败：" + requestid);
        }
        this.writeLog("2020年电商平台销售授权书 Action结束：" + requestid);
        return Action.SUCCESS;
    }
}
