<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.general.ProjectCodeImportUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.file.*," %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" /> 
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>  
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</head>
<%
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
    
	List Msglist = new ProjectCodeImportUtil().importBaseData(fu);
	
	Map<String,String> SynMsg = (Map<String,String>)Msglist.get(0);
    boolean hasHeader=false;
    boolean islight=false;
    String bgcolorvalue="#f5f5f5";
    ExcelSheet nces = new ExcelSheet() ;  // 初始化一个EXCEL的sheet对象
    //同步结果table
    out.println("<iframe id='NcExcelOut' name='NcExcelOut' border=0 frameborder=no noresize=NORESIZE height='0%' width='0%'></iframe>");
    out.println("<TABLE class=liststyle><COLGROUP><COL width='40%'><COL width='60%'><TR class=Title><TH colSpan=2>导入结果</TH></TR><TR class=Spacing><TD class=Line1 colSpan=2></TD></TR>");
 
    try{  
            out.println("<tr class=header>"); 
            out.println("<td>行数</td>"); 
            out.println("<td>导入情况</td>"); 
            out.println("</tr>");
            hasHeader=true;
            ExcelRow ncersub = nces.newExcelRow () ;  //准备新增EXCEL中的一行 
            ncersub.addStringValue("行数"); 
            ncersub.addStringValue("导入情况"); 
            nces.addExcelRow(ncersub);
                 
        Iterator it = SynMsg.keySet().iterator();
        int i=0;
        while (it.hasNext()) {            
            String key = (String)it.next();
            if(islight){
                bgcolorvalue="#f5f5f5";
                islight=!islight;
            }else{
                bgcolorvalue="#e7e7e7";
                islight=!islight;
            }
            ExcelRow ncessub[] = new ExcelRow[SynMsg.size()];
            ncessub[i] = nces.newExcelRow();
            ncessub[i].addStringValue(key);  
            ncessub[i].addStringValue(SynMsg.get(key));  
            nces.addExcelRow(ncessub[i]);
            out.println("<tr bgcolor="+bgcolorvalue+">"); 
            out.println("<td>"+ key+"</td>");
            out.println("<td>"+ SynMsg.get(key)+"</td>");
            out.println("</tr>"); 
            i++;
        }
    }catch(Exception e){}
   
    
    ExcelFile.init() ; 
	ExcelFile.setFilename("同步信息数据") ;
	ExcelFile.addSheet("sheet", nces) ; //为EXCEL文件插入一个SHEET
%>
<BODY>
</BODY>
</HTML>
