package APPDEV.HQ.qiyuesuo.docx;


import org.apache.commons.io.IOUtils;
import org.docx4j.Docx4J;
import org.docx4j.TraversalUtil;
import org.docx4j.XmlUtils;
import org.docx4j.convert.out.FOSettings;
import org.docx4j.dml.Graphic;
import org.docx4j.dml.GraphicData;
import org.docx4j.dml.picture.Pic;
import org.docx4j.dml.wordprocessingDrawing.Anchor;
import org.docx4j.dml.wordprocessingDrawing.Inline;
import org.docx4j.finders.RangeFinder;
import org.docx4j.fonts.IdentityPlusMapper;
import org.docx4j.fonts.Mapper;
import org.docx4j.fonts.PhysicalFont;
import org.docx4j.fonts.PhysicalFonts;
import org.docx4j.jaxb.Context;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.JaxbXmlPart;
import org.docx4j.openpackaging.parts.WordprocessingML.BinaryPartAbstractImage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.openpackaging.parts.relationships.RelationshipsPart;
import org.docx4j.relationships.Relationship;
import org.docx4j.wml.*;
import weaver.general.BaseBean;
import weaver.general.TimeUtil;

import javax.xml.bind.JAXBElement;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author : adore
 * @version :
 * @since : 2019-12-29 18:28
 */

public class Tool extends BaseBean {

    /**
     * 在标签处插入替换内容
     *
     * @param bm     书签
     * @param object 书签内容
     */
    public void replaceText(CTBookmark bm, Object object) {
        if (object == null) {
            return;
        }
        if (bm.getName() == null) {
            return;
        }
        String value = object.toString();
        try {
            List<Object> theList = null;
            ParaRPr rpr = null;
            if (bm.getParent() instanceof P) {
                PPr pprTemp = ((P) (bm.getParent())).getPPr();
                if (pprTemp == null) {
                    rpr = null;
                } else {
                    rpr = ((P) (bm.getParent())).getPPr().getRPr();
                }
                theList = ((ContentAccessor) (bm.getParent())).getContent();
            } else {
                return;
            }
            int rangeStart = -1;
            int rangeEnd = -1;
            int i = 0;
            for (Object ox : theList) {
                Object listEntry = XmlUtils.unwrap(ox);
                if (listEntry.equals(bm)) {
                    if (((CTBookmark) listEntry).getName() != null) {
                        rangeStart = i + 1;
                    }
                } else if (listEntry instanceof CTMarkupRange) {
                    if (((CTMarkupRange) listEntry).getId().equals(bm.getId())) {
                        rangeEnd = i - 1;
                        break;
                    }
                }
                i++;
            }
            int x = i - 1;
            for (int j = x; j >= rangeStart; j--) {
                theList.remove(j);
            }

            ObjectFactory factory = Context.getWmlObjectFactory();
            org.docx4j.wml.R run = factory.createR();
            org.docx4j.wml.Text t = factory.createText();
            t.setValue(value);
            run.getContent().add(t);
            theList.add(rangeStart, run);
        } catch (ClassCastException cce) {

        }
    }

    /**
     * 替换image
     *
     * @param wPackage
     * @param bm
     * @param file
     */
    public void addImage(WordprocessingMLPackage wPackage, CTBookmark bm, String file) {
        System.out.println("开始替换图片:" + TimeUtil.getCurrentTimeString());
        // 新增image
        ObjectFactory factory = Context.getWmlObjectFactory();
        P p = (P) (bm.getParent());
        R run = factory.createR();
        byte[] bytes;
        Long newCx = 0L;
        Long newCy = 0L;
        String newRelId = null;
        try {
            bytes = IOUtils.toByteArray(new FileInputStream(file));
            BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(wPackage, bytes);
            //随机数ID
            int id = (int) (Math.random() * 10000);
            //这里的id不重复即可
            Inline newInline = imagePart.createImageInline("image", "image", id, id * 2, false);

            // 获取CX 、CY
            newCx = newInline.getExtent().getCx();
            newCy = newInline.getExtent().getCy();

            // 获取relId
            Graphic newg = newInline.getGraphic();
            GraphicData graphicdata = newg.getGraphicData();
            Object o = graphicdata.getAny().get(0);
            Pic pic = (Pic) XmlUtils.unwrap(o);
            newRelId = pic.getBlipFill().getBlip().getEmbed();
            // System.out.println("newRelId:" + newRelId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 获取模板图片的CX 、CY 、relId
        Object parent = (P) bm.getParent();
        System.out.println("parent:" + parent);
        List<Object> rList = getAllElementFromObject(parent, R.class);
        for (Object robj : rList) {
            if (robj instanceof R) {
                R r = (R) robj;
                List<Object> drawList = getAllElementFromObject(r, Drawing.class);
                for (Object dobj : drawList) {
                    System.out.println("dobj:" + dobj);
                    if (dobj instanceof Drawing) {
                        Drawing d = (Drawing) dobj;
                        // Inline inline = new Inline();
                        Anchor inline;
                        // for (int i = 0; i < d.getAnchorOrInline().size(); i++) {
                        System.out.println(d.getAnchorOrInline().get(0));
                        if (d.getAnchorOrInline().get(0) instanceof Anchor) {
                            inline = (Anchor) d.getAnchorOrInline().get(0);
                            // 获取CX 、CY
                            Long cx = inline.getExtent().getCx();
                            Long cy = inline.getExtent().getCy();
                            System.out.println("cx:" + cx);
                            System.out.println("cy:" + cy);

                            // 获取relId
                            Graphic g = inline.getGraphic();
                            GraphicData graphicdata = g.getGraphicData();
                            Object o = graphicdata.getAny().get(0);
                            Pic pic = (Pic) XmlUtils.unwrap(o);
                            String relId = pic.getBlipFill().getBlip().getEmbed();
                            System.out.println("relId:" + relId);

                            // 替换relId
                            pic.getBlipFill().getBlip().setEmbed(newRelId);
                            // 处理CX、CY
                            Map<String, Long> map = dealCxy(cx, cy, newCx, newCy);

                            // 更改cx、cy
                            inline.getExtent().setCx(map.get("setCx"));
                            inline.getExtent().setCy(map.get("setCy"));
                        }
                        // }
                    } else {
                        System.out.println("出错了");
                    }
                }
            }
        }
    }

    /**
     * 处理图片适应大小
     *
     * @param cx
     * @param cy
     * @param newCx
     * @param newCy
     */
    public Map<String, Long> dealCxy(Long cx, Long cy, Long newCx, Long newCy) {
        Map<String, Long> map = new HashMap<String, Long>();
        Long setCx;
        Long setCy;

        if (newCx > cx) {
            if (newCy <= cy) {
                setCx = cx;
                setCy = newCy / (newCx / cx);
            } else {
                if ((newCx / cx) > (newCy / cy)) {
                    setCx = cx;
                    setCy = newCy / (newCx / cx);
                } else {
                    setCy = cy;
                    setCx = newCx / (newCy / cy);
                }
            }
        } else {   // newCx < cx
            if (newCy > cy) {
                setCx = cx;
                setCy = newCy * (cx / newCx);
            } else {
                if ((cx / newCx) > (cy / newCy)) {
                    setCx = cx;
                    setCy = newCy * (cx / newCx);
                } else {
                    setCy = cy;
                    setCx = newCy * (cy / newCy);
                }
            }
        }
        map.put("setCx", setCx);
        map.put("setCy", setCy);
        return map;
    }


    /**
     * 得到指定类型的元素
     *
     * @param obj
     * @param toSearch
     * @return
     */
    public List<Object> getAllElementFromObject(Object obj, Class<?> toSearch) {
        List<Object> result = new ArrayList<Object>();
        if (obj instanceof JAXBElement)
            obj = ((JAXBElement<?>) obj).getValue();
        if (obj.getClass().equals(toSearch))
            result.add(obj);
        else if (obj instanceof ContentAccessor) {
            List<?> children = ((ContentAccessor) obj).getContent();
            for (Object child : children) {
                result.addAll(getAllElementFromObject(child, toSearch));
            }
        }
        return result;
    }

    /**
     * word 转换 pdf （实际是没有用到的）
     *
     * @param docxPath
     * @param pdfPath
     * @throws Exception
     */
    public void convertDocxToPDF(String docxPath, String pdfPath) {
        OutputStream os = null;
        try {
            WordprocessingMLPackage mlPackage = WordprocessingMLPackage.load(new File(docxPath));
            Mapper fontMapper = new IdentityPlusMapper();
            fontMapper.put("隶书", PhysicalFonts.get("LiSu"));
            fontMapper.put("宋体", PhysicalFonts.get("SimSun"));
            fontMapper.put("微软雅黑", PhysicalFonts.get("Microsoft Yahei"));
            fontMapper.put("黑体", PhysicalFonts.get("SimHei"));
            fontMapper.put("楷体", PhysicalFonts.get("KaiTi"));
            fontMapper.put("新宋体", PhysicalFonts.get("NSimSun"));
            fontMapper.put("华文行楷", PhysicalFonts.get("STXingkai"));
            fontMapper.put("华文仿宋", PhysicalFonts.get("STFangsong"));
            fontMapper.put("宋体扩展", PhysicalFonts.get("simsun-extB"));
            fontMapper.put("仿宋", PhysicalFonts.get("FangSong"));
            fontMapper.put("仿宋_GB2312", PhysicalFonts.get("FangSong_GB2312"));
            fontMapper.put("幼圆", PhysicalFonts.get("YouYuan"));
            fontMapper.put("华文宋体", PhysicalFonts.get("STSong"));
            fontMapper.put("华文中宋", PhysicalFonts.get("STZhongsong"));
            mlPackage.setFontMapper(fontMapper);

            os = new java.io.FileOutputStream(pdfPath);

            FOSettings foSettings = Docx4J.createFOSettings();
            foSettings.setWmlPackage(mlPackage);
            Docx4J.toFO(foSettings, os, Docx4J.FLAG_EXPORT_PREFER_XSL);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            IOUtils.closeQuietly(os);
        }
    }

    /**
     * 下载PDF文件（实际是没有用到的）
     *
     * @param wordMLPackage
     * @param os
     * @throws Exception
     */
    public void pdfFile(WordprocessingMLPackage wordMLPackage, OutputStream os) throws Exception {

        String regex = null;
        Mapper fontMapper = new IdentityPlusMapper();
        wordMLPackage.setFontMapper(fontMapper);
        PhysicalFont font = PhysicalFonts.get("Arial Unicode MS");
        String directory = "D:\\upload\\pdf";
        String fileName = "OUT_ConvertInXHTMLURL.pdf";
        File f = new File(directory, fileName);
        if (f.exists()) {
            // 文件已经存在，输出文件的相关信息
            System.out.println(f.getAbsolutePath());
            System.out.println(f.getName());
            System.out.println(f.length());
        } else {
            //  先创建文件所在的目录
            f.getParentFile().mkdirs();
        }
        File file = new File(directory + "/" + fileName);
        OutputStream os34 = new java.io.FileOutputStream(file);
        Docx4J.toPDF(wordMLPackage, os34);
        os.flush();
        os.close();
        wordMLPackage = null;
    }

    /**
     * Method Description:使用docx4j插入图片
     *
     * @param templatePath // 模板文件路径
     * @param targetPath   // 生成的文件路径
     * @param bookmarkName // 书签名
     * @param lists        map // 图片路径和文字说明
     */
    public void insertPicture(String templatePath, String targetPath, String bookmarkName, List<Map<String, String>> lists) {
        try {
            // 载入模板文件
            WordprocessingMLPackage wPackage = WordprocessingMLPackage.load(new FileInputStream(templatePath));
            // 提取正文
            MainDocumentPart mainDocumentPart = wPackage.getMainDocumentPart();
            Document wmlDoc = mainDocumentPart.getContents();
            Body body = wmlDoc.getBody();
            // 提取正文中所有段落
            List<Object> paragraphs = body.getContent();
            // 提取书签并创建书签的游标
            RangeFinder rt = new RangeFinder("CTBookmark", "CTMarkupRange");
            new TraversalUtil(paragraphs, rt);
            // 遍历书签
            for (CTBookmark bm : rt.getStarts()) {
                // 这儿可以对单个书签进行操作，也可以用一个map对所有的书签进行处理
                if (bm.getName().equals(bookmarkName)) {
                    for (Map<String, String> map : lists) {
                        String imagePath = map.get("pic");
                        String picName = map.get("picName");
                        // 读入图片并转化为字节数组，因为docx4j只能字节数组的方式插入图片
                        InputStream is = new FileInputStream(imagePath);
                        byte[] bytes = IOUtils.toByteArray(is);
                        // 创建一个行内图片
                        BinaryPartAbstractImage imagePart = BinaryPartAbstractImage.createImagePart(wPackage, bytes);
                        // createImageInline函数的前四个参数我都没有找到具体啥意思
                        // 最有一个是限制图片的宽度，缩放的依据
                        long cy = 252160L;
                        Inline inline = imagePart.createImageInline("image", "image", 0, 2, false);
                        long newCx = inline.getExtent().getCx();
                        long newCy = inline.getExtent().getCy();
                        // 更改cx、cy
                        inline.getExtent().setCx(newCx/(newCy/cy));
                        inline.getExtent().setCy(cy);

                        // 获取该书签的父级段落
                        P p = (P) (bm.getParent());
                        ObjectFactory factory = new ObjectFactory();
                        // R对象是匿名的复杂类型，然而我并不知道具体啥意思，估计这个要好好去看看ooxml才知道
                        R run = factory.createR();
                        // drawing理解为画布 这里插入图片
                        Drawing drawing = factory.createDrawing();
                        drawing.getAnchorOrInline().add(inline);
                        run.getContent().add(drawing);
                        p.getContent().add(run);

                        // 这里插入文字
                        Text t = factory.createText();
                        t.setValue(picName);
                        run.getContent().add(t);
                    }
                }
            }
            wPackage.save(new FileOutputStream(targetPath));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public WordprocessingMLPackage replaceContentByBookmark(WordprocessingMLPackage wPackage, Map<String, String> map, ArrayList<String> bmList) {
        try {
            // 提取正文
            MainDocumentPart main = wPackage.getMainDocumentPart();
            Document doc = main.getContents();
            Body body = doc.getBody();

            // 获取段落
            List<Object> paragraphs = body.getContent();

            // 提取书签并获取书签的游标
            RangeFinder rt = new RangeFinder("CTBookmark", "CTMarkupRange");
            new TraversalUtil(paragraphs, rt);

            // 遍历书签
            for (CTBookmark bm : rt.getStarts()) {
                // 替换文本内容
                for (String bmName : bmList) {
                    System.out.println("mark:" + bm.getName());
                    if (bm.getName().equals(bmName)) {
                        this.replaceText(bm, map.get(bm.getName()));
                    }
                }

                // 替换image
                if (bm.getName().equals("pic")) {
                    System.out.println("替换pic");
                    this.addImage(wPackage, bm, map.get("pic"));
                }

                if (bm.getName().equals("pic2")) {
                    System.out.println("替换pic2");
                    this.addImage(wPackage, bm, map.get("pic2"));
                }
            }

        } catch (Exception e) {
            // handle exception
        }

        return wPackage;
    }

    // 2019-12-31 10:02:27
    public void replaceElementFromFooter(WordprocessingMLPackage template, String nameplace, String placeholder, String newValue) throws Docx4JException {
        List<Object> result = new ArrayList<Object>();
        RelationshipsPart relationshipPart = template.getMainDocumentPart().getRelationshipsPart();

        List<Relationship> relationships = relationshipPart.getRelationships().getRelationship();
        System.out.println("替换页眉----------------开始");
        for (Relationship r : relationships) {
            System.out.println(r.getType());
            if (r.getType().equals(nameplace)) {

                JaxbXmlPart part = (JaxbXmlPart) relationshipPart.getPart(r);

                List<Object> texts = this.getAllElementFromObject(part.getContents(), Text.class);

                replaceTextElement(texts, placeholder, newValue);
            }

        }
        System.out.println("替换页眉----------------结束");
        // return result;
    }


    private static void replaceTextElement(List<Object> texts, String placeholder, String newValue) {
        System.out.println("替换页眉中----------------");
        for (Object element : texts) {
            Text textElement = (Text) element;
            if (textElement.getValue().contains(placeholder)) {
                String replacedValue = textElement.getValue().replaceAll(placeholder, newValue);
                System.out.println("replacedValue：" + replacedValue);
                textElement.setValue(replacedValue);
            }
        }
    }
}
