<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import=" java.io.IOException"%>
<%@ page import=" java.io.InputStream"%>
<%@ page import=" java.io.PrintWriter"%>
<%@ page import=" java.util.*"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.ss.usermodel.Cell"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.ss.usermodel.Row"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import=" com.fr.third.v2.org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@ page import=" org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import=" org.apache.commons.fileupload.FileItem"%>
<%@ page import=" org.apache.commons.fileupload.FileUploadException"%>
<%@ page import="weixin.importflow.ExcelImport"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>

	
<%
	int userid = user.getUID();
	String errormark ="0";
	String errormsg="";
	String MSG_TYPE = "";
	String MSG_CONTENT = "";
	String OA_ID = "";
		out.print("123");
	for(int i=0;i<1;i++){
		out.print("123");
	if (!DiskFileUpload.isMultipartContent(request)) {
		errormark = "1";
		errormsg = "ֻ只能处理multipart/form-data类型的数据!";
		out.print(errormsg);
		break;
	}
	DiskFileUpload fu = new DiskFileUpload();
	fu.setSizeMax(1024 * 1024 * 50);
	fu.setSizeThreshold(1024 * 1024);
	fu.setHeaderEncoding("gbk");
	List fileItems = null;
	try {
		fileItems = fu.parseRequest(request);
	}catch (FileUploadException e) {
		errormark = "1";
		errormsg = "ֻ解析数据出错";
		break;
	}
	Iterator i = fileItems.iterator();
	String who_oper = "";
	Sheet sheet = null;		
	while (i.hasNext()) {
		FileItem fi = (FileItem) i.next();
		if (fi.isFormField()) {
				if("who_oper".equalsIgnoreCase(fi.getFieldName())){
					who_oper = fi.getString("GBK");
				}
		}else{
			try {
				String pathSrc = fi.getName();
						
				if (pathSrc.trim().equals("")) {
					continue;
				}
				InputStream is = fi.getInputStream();
				Workbook wb = new XSSFWorkbook(is);
				sheet = wb.getSheetAt(1);
			}catch (Exception e) {
				errormark = "1";
				errormsg = "ֻ存储文件时出错";
				break;
			}finally { // 总是立即删除保存表单字段内容的临时文件
				fi.delete();
			}
		}
	}
	//out.print(123);
	Map<String,String> resultMap = new ExcelImport().readAndExceSheet(sheet,String.valueOf(userid),"1782");
	 MSG_TYPE = resultMap.get("MSG_TYPE");
	 MSG_CONTENT = resultMap.get("MSG_CONTENT");
	 OA_ID = resultMap.get("OA_ID");
	}
	//out.print("MSG_TYPE:"+MSG_TYPE);
	//out.print("MSG_CONTENT:"+MSG_CONTENT);
	//out.print("OA_ID:"+OA_ID);

%>
<script language="javascript" src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
<script type="text/javascript">
    var errormark ="<%=errormark%>";
	var errormsg = "<%=errormsg%>";
	if(errormark == "1"){
		alert(errormsg);
		window.location.href = "/systeminfo/BrowserMain.jsp?url=/weixin/import/ExcelIn.jsp";
	}
 	var MSG_TYPE = "<%=MSG_TYPE%>";
	var MSG_CONTENT = "<%=MSG_CONTENT%>";
	var OA_ID = "<%=OA_ID%>";
	if(MSG_TYPE == "S"){
		alert("创建流程成功");
		openFullWindowForXtable("/workflow/request/ViewRequest.jsp?requestid="+OA_ID);
	}else{
		alert("创建流程失败："+MSG_CONTENT);
		
	}
	window.location.href = "/systeminfo/BrowserMain.jsp?url=/weixin/import/ExcelIn.jsp";
	//var parentWin;
	//try{
	//	parentWin = parent.getParentWindow(window);
	//	parentWin.closeDlgARfsh();
	//}catch(e){
	//	window.close();
	//}
	//window.close();
</script>