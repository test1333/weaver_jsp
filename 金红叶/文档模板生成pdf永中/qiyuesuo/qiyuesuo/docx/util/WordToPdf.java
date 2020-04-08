package APPDEV.HQ.qiyuesuo.docx.util;

import APPDEV.HQ.UTIL.GetMachineUtil;
import com.api.doc.detail.util.PdfConvertUtil;
import org.apache.axis.encoding.Base64;
import sun.misc.BASE64Decoder;
import weaver.conn.RecordSet;
import weaver.docs.webservices.DocAttachment;
import weaver.docs.webservices.DocInfo;
import weaver.docs.webservices.DocServiceImpl;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.hrm.User;

import java.io.*;
import java.util.UUID;
import java.util.zip.ZipInputStream;

public class WordToPdf extends BaseBean {

    public int office2PDF(String sourceFile, String destFile) {
        this.writeLog("开始转换pdf");
        PdfConvertUtil convertUtil = new PdfConvertUtil();
        int result = -1;
        if (!"".equals(sourceFile) && !"".equals(destFile)) {
            UUID uuid = UUID.randomUUID();
            String docCategory = "";
            String machine = GetMachineUtil.getMachine();
            if ("PRO".equals(machine)) {
                docCategory = "2742";
            } else if ("QAS".equals(machine)) {
                docCategory = "4184";
            }
            String fileName = uuid.toString() + ".docx";
            String docid = this.createDoc(sourceFile, docCategory, fileName, "52001991");
            this.writeLog("docid:" + docid);
            if (!"-1".equals(docid) && !"".equals(docid)) {
                RecordSet rs = new RecordSet();
                String imagefileid = "";
                String sql = " select IMAGEFILEID from DOCIMAGEFILE where DOCID='" + docid + "' ";
                this.writeLog("sql1:" + sql);
                rs.execute(sql);
                if (rs.next()) {
                    imagefileid = Util.null2String(rs.getString("IMAGEFILEID"));
                }

                this.writeLog("imagefileid:" + imagefileid);

                if (!"".equals(imagefileid)) {
                    int pdfid = convertUtil.convertPdf(Util.getIntValue(imagefileid));
                    this.writeLog("pdfid:" + pdfid);
                    if (pdfid > 0) {
                        this.getPdfFile(destFile, pdfid + "");
                        result = 0;
                    }
                }
            }
        }
        this.writeLog("完成转换pdf");
        return result;
    }

    /**
     * 创建系统文档
     *
     * @param fileUrl     生成的PDF文档路径
     * @param docCategory 文档目录id
     * @param filename    文档名称
     * @param createrid   创建人id
     * @return 文档id
     */
    private String createDoc(String fileUrl, String docCategory, String filename, String createrid) {
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
            writeLog("uploadBuffer:" + uploadBuffer.length());
            docid = getDocId(filename, uploadBuffer, createrid, docCategory);
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
     * @throws Exception 异常
     */
    private String getDocId(String name, String value, String createrid, String seccategory) throws Exception {
        String docId = "";
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
        this.writeLog("sql:" + sql);
        RecordSet rs = new RecordSet();
        rs.execute(sql);
        User user = new User();
        if (rs.next()) {
            departmentId = Util.null2String(rs.getString("departmentid"));
        }
        this.writeLog("departmentId:" + departmentId);
        user.setUid(Util.getIntValue(createrid));
        user.setUserDepartment(Util.getIntValue(departmentId));
        user.setLanguage(7);
        user.setLogintype("1");
        user.setLoginip("127.0.0.1");
        DocServiceImpl ds = new DocServiceImpl();
        try {
            docId = String.valueOf(ds.createDocByUser(di, user));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return docId;
    }

    private void getPdfFile(String filePath, String docid) {
        try {
            RecordSet rs = new RecordSet();
            String filerealpath = "";
            String iszip = "";
            InputStream is;
            String sql = " select FILEREALPATH,ISZIP,IMAGEFILENAME,IMAGEFILEID from IMAGEFILE where IMAGEFILEID= " + docid;
            rs.execute(sql);
            this.writeLog("sql:" + sql);
            if (rs.next()) {
                filerealpath = Util.null2String(rs.getString("FILEREALPATH"));
                iszip = Util.null2String(rs.getString("ISZIP"));
            }
            File file = new File(filePath);
            if (!"".equals(filerealpath) && !"".equals(iszip)) {
                is = getFile(filerealpath, iszip);
                inputStream2File(is, file);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据系统文档存放路径 获取文档流
     *
     * @param filerealpath 文档存放路径
     * @param iszip        是否压缩包
     * @return InputStream
     * @throws Exception
     */
    private InputStream getFile(String filerealpath, String iszip)
            throws Exception {
        ZipInputStream zin = null;
        InputStream imagefile = null;
        File thefile = new File(filerealpath);
        if (iszip.equals("1")) {
            zin = new ZipInputStream(new FileInputStream(thefile));
            if (zin.getNextEntry() != null)
                imagefile = new BufferedInputStream(zin);
        } else {
            imagefile = new BufferedInputStream(new FileInputStream(thefile));
        }
        return imagefile;
    }

    /**
     * InputStream --> File
     *
     * @param ins  InputStream
     * @param file File
     * @throws Exception IOException
     */
    private static void inputStream2File(InputStream ins, File file) throws Exception {
        OutputStream os = new FileOutputStream(file);
        int bytesRead = 0;
        byte[] buffer = new byte[8192];
        while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
            os.write(buffer, 0, bytesRead);
        }
        os.close();
        ins.close();
    }
}
