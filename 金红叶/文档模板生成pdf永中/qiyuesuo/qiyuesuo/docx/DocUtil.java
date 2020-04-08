package APPDEV.HQ.qiyuesuo.docx;

import APPDEV.HQ.qiyuesuo.docx.util.WordToPdf;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import weaver.general.BaseBean;

import java.io.File;
import java.util.*;

/**
 * 契约锁文档方法
 *
 * @author : adore
 * @version : v1.0
 * @since : 2019-12-29 21:34
 */

public class DocUtil extends BaseBean {
    public String createDoc(HashMap<String, String> map, List<Map<String, String>> lists) {
        try {
            // 文件源目录
            String srcPath = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/tempFile/2020E-platformSaletarget.docx";
            // String srcPath = "/Users/adore/Desktop/test11/9999.docx";
            // 目标文件目录
            UUID uuid = UUID.randomUUID();
            System.out.println(uuid.toString());
            String destPath = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/file/" + uuid.toString() + ".docx";
            String pdfPath = "/weaver/ecology/appdevjsp/HQ/Contract/qiyuesuo/file/" + uuid.toString() + ".pdf";
            // String destPath = "/Users/adore/Desktop/test11/" + uuid.toString() + ".docx";
            // String destPath2 = "/Users/adore/Desktop/test11/" + uuid.toString() + "_new.docx";
            // String pdfPath = " /Users/adore/Desktop/test11/" + uuid.toString() + ".pdf";

            // 打开一个存在的word
            // 作word处理
            Tool tool = new Tool();
            // 替换图片和文字说明
            tool.insertPicture(srcPath, destPath, "pic", lists);

            // 替换正文文字
            WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(new java.io.File(destPath));
            MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
            documentPart.variableReplace(map);
            wordMLPackage.save(new File(destPath));
            // 替换页眉和页脚
            wordMLPackage = WordprocessingMLPackage.load(new java.io.File(destPath));
            String namePlace = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/header";
            tool.replaceElementFromFooter(wordMLPackage, namePlace, "rqid", map.get("rqid"));
            // Save it
            wordMLPackage.save(new File(destPath));
            // DocPreviewWithPDF withPDF = new DocPreviewWithPDF();
            WordToPdf toPdf = new WordToPdf();
            int result = toPdf.office2PDF(destPath, pdfPath);
            this.writeLog("result:" + result);
            if (result >= 0) {
                return pdfPath;
            }
        } catch (Exception e) {
            this.writeLog(e);
        }
        return "";
    }

    public static void main(String[] args) {
        DocUtil docUtil = new DocUtil();
        HashMap<String, String> hashMap = new HashMap<String, String>();
        hashMap.put("rqid", "123456");
        hashMap.put("pic", "/Users/adore/Desktop/test11/pbzz.png");
        List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("pic", "/Users/adore/Desktop/test11/pbzz.png");
        map.put("picName", "真真");
        lists.add(map);

        Map<String, String> map1 = new HashMap<String, String>();
        map1.put("pic", "/Users/adore/Desktop/test11/pbqf.png");
        map1.put("picName", "清风");
        lists.add(map1);

        Map<String, String> map2 = new HashMap<String, String>();
        map2.put("pic", "/Users/adore/Desktop/test11/pbvj.png");
        map2.put("picName", "唯洁雅");
        lists.add(map2);

        Map<String, String> map3 = new HashMap<String, String>();
        map3.put("pic", "/Users/adore/Desktop/test11/pbem.png");
        map3.put("picName", "铂丽雅");
        lists.add(map3);

        docUtil.createDoc(hashMap, lists);
    }
}
