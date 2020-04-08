package APPDEV.HQ.Contract.STP.util;

import org.apache.axis.encoding.Base64;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import sun.misc.BASE64Decoder;
import weaver.conn.RecordSet;
import weaver.docs.webservices.DocAttachment;
import weaver.docs.webservices.DocInfo;
import weaver.docs.webservices.DocServiceImpl;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.User;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.util.Enumeration;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

/**
 * @Description: 合同文档创建方法合集
 * @Author: adore
 * @DateTime: 2018-10-31 11:49 AM
 * @Version: v1.0
 */

public class CreateContractFileUtil {

    /**
     * 生成doc文档
     *
     * @param FileUrl     模板路径
     * @param bookMarkMap 书签内容map集合
     * @param outFileUrl  输出路径
     */
    public void modifyDocumentAndSave(String FileUrl, Map<String, String> bookMarkMap, String outFileUrl) {
        try {
            writeLog("modifyDocumentAndSave### start");
            // 使用java.util打开文件
            File file = new File(FileUrl);
            boolean exist = file.exists();
            boolean read = file.canRead();
            boolean write = file.canWrite();
            //D:\\test\\2017年AFH订制品合同模板.docx
            ZipFile docxFile = new ZipFile(file);
            // 返回ZipEntry应用程序接口
            ZipEntry documentXML = docxFile.getEntry("word/document.xml");

            InputStream documentXMLIS = docxFile.getInputStream(documentXML);

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

            Document doc = dbf.newDocumentBuilder().parse(documentXMLIS);

            /**
             * 书签列表
             */

            Element child1 = null;
            Element child2 = null;
            NodeList this_book_list = doc.getElementsByTagName("w:bookmarkStart");
            if (this_book_list.getLength() != 0) {
                for (int j = 0; j < this_book_list.getLength(); j++) {
                    // 获取每个书签
                    Element oldBookStart = (Element) this_book_list.item(j);
                    // 书签名
                    String bookMarkName = oldBookStart.getAttribute("w:name");
                    // writeLog("bookMarkName:" + bookMarkName);
//                if (mxstart.equals(bookMarkName)) {
//                    child1 = (Element) oldBookStart.getParentNode().getNextSibling();
//                }
//                if (mxend.equals(bookMarkName)) {
//                    child2 = (Element) oldBookStart.getParentNode();
//                }


                    // 书签名，跟需要替换的书签传入的map集合比较
                    for (Map.Entry<String, String> entry : bookMarkMap.entrySet()) {
                        // 书签处值开始
                        Node wr = doc.createElement("w:r");
                        Node wt = doc.createElement("w:t");
                        String entryVal = Util.null2String(entry.getValue());
                        // writeLog("entryVal：" + entryVal); 添加节点前要除去null值，防止异常
                        if (!"".equals(entryVal)) {
                            Node wt_text = doc.createTextNode(entry.getValue());
                            wt.appendChild(wt_text);
                            wr.appendChild(wt);
                            // 书签处值结束
                            if (entry.getKey().equals(bookMarkName)) {
                                writeLog("书签名：" + entry.getKey());
                                Element node = (Element) oldBookStart.getNextSibling();// 获取兄弟节点w:r
                                // 如果书签处无文字,则在书签处添加需要替换的内容，如果书签处存在描述文字，则替换内容,用w:r
                                NodeList wtList = node.getElementsByTagName("w:t");// 获取w:r标签下的显示书签处内容标签w:t
                                if (wtList.getLength() == 0) { // 如果不存在，即，书签处本来就无内容，则添加需要替换的内容
                                    oldBookStart.appendChild(wr);
                                    writeLog("书签值:" + wt_text.getNodeValue());
                                } else { // 如果书签处有内容，则直接替换内容
                                    Element wtNode = (Element) wtList.item(0);
                                    wtNode.setTextContent(entry.getValue());
                                    writeLog("变更书签内容：" + entry.getValue());
                                }
                            }
                        }
                    }
                }
                // doDetail(child1, child2, tableName, requestid);
            }

            // writeLog("书签值处理完成，next:" + doc.toString());
            Transformer t = TransformerFactory.newInstance().newTransformer();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            t.transform(new DOMSource(doc), new StreamResult(baos));
            //D:\\test\\response.docx
            ZipOutputStream docxOutFile = new ZipOutputStream(new FileOutputStream(
                    outFileUrl));
            // writeLog("docxOutFile，next:" + docxOutFile);
            Enumeration entriesIter = docxFile.entries();
            // writeLog("即将开始循环，next");
            while (entriesIter.hasMoreElements()) {
                ZipEntry entry = (ZipEntry) entriesIter.nextElement();
                // 如果是document.xml则修改，别的文件直接拷贝，不改变word的样式
                if (entry.getName().equals("word/document.xml")) {
                    byte[] data = baos.toByteArray();
                    docxOutFile.putNextEntry(new ZipEntry(entry.getName()));
                    docxOutFile.write(data, 0, data.length);
                    docxOutFile.closeEntry();
                } else {
                    InputStream incoming = docxFile.getInputStream(entry);
                    ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int len = -1;
                    while ((len = incoming.read(buffer)) != -1) {
                        outSteam.write(buffer, 0, len);
                    }
                    outSteam.close();
                    incoming.close();

                    docxOutFile.putNextEntry(new ZipEntry(entry.getName()));
                    docxOutFile.write(outSteam.toByteArray(), 0, (int) entry.getSize());
                    docxOutFile.closeEntry();
                }
            }
            docxOutFile.close();
        } catch (Exception e) {
            this.writeLog(e);
        }
    }

    /**
     * 创建系统文档
     *
     * @param fileUrl     生成的PDF文档路径
     * @param docCategory 文档目录id
     * @param filename    文档名称
     * @param createrid   创建人id
     * @return 文档id
     * @throws Exception 创建失败
     */
    public String createDoc(String fileUrl, String docCategory, String filename, String createrid) {
        String docid = "";
        try {
            String uploadBuffer = "";
            FileInputStream fi = new FileInputStream(new File(fileUrl));
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int count = 0;
            while ((count = fi.read(buffer)) >= 0) {
                baos.write(buffer, 0, count);
            }
            uploadBuffer = Base64.encode(baos.toByteArray());
            // log.writeLog("uploadBuffer:"+uploadBuffer.length());
            docid = getDocId(filename, uploadBuffer, createrid, docCategory);
        } catch (Exception e) {
            this.writeLog(e);
        }
        return docid;
    }

    public String createDocAttachment(int imagefileid, String createrid, String docCategory) {
        String docid = "";
        try {
            RecordSet rs1 = new RecordSet();
            String sql1 = "select IMAGEFILENAME,FILEREALPATH,ISZIP from IMAGEFILE where IMAGEFILEID='" + imagefileid + "' ";
            rs1.execute(sql1);
            if (rs1.next()) {
                String fileName = Util.null2String(rs1.getString("IMAGEFILENAME"));
                String filePath = Util.null2String(rs1.getString("FILEREALPATH"));
                String iszip = Util.null2String(rs1.getString("iszip"));
                String uploadBuffer = "";
                // FileInputStream fi = new FileInputStream(new File(fileUrl));
                InputStream fi = this.getFile(filePath, iszip);
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                byte[] buffer = new byte[1024];
                int count = 0;
                while ((count = fi.read(buffer)) >= 0) {
                    baos.write(buffer, 0, count);
                }
                uploadBuffer = Base64.encode(baos.toByteArray());
                // log.writeLog("uploadBuffer:"+uploadBuffer.length());
                docid = getDocId(fileName, uploadBuffer, createrid, docCategory);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return docid;
    }

    /**
     * 获取文档id
     *
     * @param name        文档名称
     * @param value       文档内容
     * @param createrid   创建人id
     * @param seccategory 目录
     * @return docId 文档id，-1失败
     */
    private String getDocId(String name, String value, String createrid, String seccategory) {
        String docId = "";
        try {
            DocInfo di = new DocInfo();
            di.setMaincategory(0);
            di.setSubcategory(0);
            di.setSeccategory(Util.getIntValue(seccategory));
            di.setDocSubject(name.substring(0, name.lastIndexOf(".")));
            DocAttachment doca = new DocAttachment();
            doca.setFilename(name);
            byte[] buffer = new BASE64Decoder().decodeBuffer(value);
            String encode = Base64.encode(buffer);
            doca.setFilecontent(encode);
            DocAttachment[] docs = new DocAttachment[1];
            docs[0] = doca;
            di.setAttachments(docs);
            String departmentId = "-1";
            String sql = "select departmentid from hrmresource where id=" + createrid;
            RecordSet rs = new RecordSet();
            rs.execute(sql);
            User user = new User();
            if (rs.next()) {
                departmentId = Util.null2String(rs.getString("departmentid"));
            }
            user.setUid(Util.getIntValue(createrid));
            user.setUserDepartment(Util.getIntValue(departmentId));
            user.setLanguage(7);
            user.setLogintype("1");
            user.setLoginip("127.0.0.1");
            DocServiceImpl ds = new DocServiceImpl();
            docId = String.valueOf(ds.createDocByUser(di, user));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return docId;
    }

    public String word2Pdf(String filePath, String docid) {
        this.writeLog("开始----");
        RecordSet rs = new RecordSet();
        String filerealpath = "";
        String iszip = "";
        String fileType = "";
        InputStream is;
        String sql = " select b.filerealpath,b.iszip,b.imagefilename,b.imagefileid from imagefile b " +
                " where b.imagefileid in(select imagefileid from docimagefile where docid =" + docid + ") ";
        this.writeLog("sql----" + sql);
        rs.execute(sql);
        if (rs.next()) {
            filerealpath = Util.null2String(rs.getString("filerealpath"));
            iszip = Util.null2String(rs.getString("iszip"));
            fileType = Util.null2String(rs.getString("imagefilename"));
        }
        filePath += fileType.substring(fileType.lastIndexOf("."));
        writeLog("filePath:" + filePath);
        File file = new File(filePath);
        if (!"".equals(filerealpath) && !"".equals(iszip)) {
            try {
                is = getFile(filerealpath, iszip);
                inputStream2File(is, file);
            } catch (Exception e) {
                this.writeLog(e);
            }
        }
        this.writeLog("完成----");
        return fileType.substring(fileType.lastIndexOf("."));
    }

    /**
     * 根据系统文档存放路径 获取文档流
     *
     * @param filerealpath 文档存放路径
     * @param iszip        是否压缩包
     * @return InputStream
     * @throws Exception
     */
    private InputStream getFile(String filerealpath, String iszip) {
        ZipInputStream zin = null;
        InputStream imagefile = null;
        try {
            File thefile = new File(filerealpath);
            if (iszip.equals("1")) {
                zin = new ZipInputStream(new FileInputStream(thefile));
                if (zin.getNextEntry() != null)
                    imagefile = new BufferedInputStream(zin);
            } else {
                imagefile = new BufferedInputStream(new FileInputStream(thefile));
            }
        } catch (Exception e) {
            this.writeLog(e);
        }
        return imagefile;
    }

    /**
     * InputStream --> File
     *
     * @param ins  InputStream
     * @param file File
     */
    private void inputStream2File(InputStream ins, File file) {
        try {
            OutputStream os = new FileOutputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.close();
            ins.close();
        } catch (Exception e) {
            this.writeLog(e);
        }
    }


    /**
     * 开发技巧，一键开关日志，if(true)开启；if(false)关闭
     *
     * @param obj 日志内容
     */
    private void writeLog(Object obj) {
        if (false) {
            new BaseBean().writeLog(this.getClass().getName(), obj);
        }
    }
}
