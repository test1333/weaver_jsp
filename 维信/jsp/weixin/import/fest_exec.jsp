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
	if (!DiskFileUpload.isMultipartContent(request)) {
		out.println("ֻCan only handle data of multipart/form-data type!");
		return;
	}
	DiskFileUpload fu = new DiskFileUpload();
	fu.setSizeMax(1024 * 1024 * 50);
	fu.setSizeThreshold(1024 * 1024);
	fu.setHeaderEncoding("gbk");
	List fileItems = null;
	try {
		fileItems = fu.parseRequest(request);
	}catch (FileUploadException e) {
		out.println("Error in parsing data");
		return;
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
	            for(int j=0;j<wb.getNumberOfSheets();j++) {
	            	if("Quotation Form".equals(wb.getSheetName(j))) {
	            		sheet = wb.getSheetAt(j);
	            		break;
	            	}
	           	}
			}catch (Exception e) {
				out.println("Error storing file");
				return;
			}finally { // 总是立即删除保存表单字段内容的临时文件
				fi.delete();
			}
		}
	}
	//out.print(123);
	Map<String,String> resultMap = new ExcelImport().readAndExceSheet(sheet,String.valueOf(userid),"2601");
	String MSG_TYPE = resultMap.get("MSG_TYPE");
	String MSG_CONTENT = resultMap.get("MSG_CONTENT");
	String OA_ID = resultMap.get("OA_ID");
	//out.print("MSG_TYPE:"+MSG_TYPE);
	//out.print("MSG_CONTENT:"+MSG_CONTENT);
	//out.print("OA_ID:"+OA_ID);

%>
<script type="text/javascript">
 	var MSG_TYPE = "<%=MSG_TYPE%>";
	var MSG_CONTENT = "<%=MSG_CONTENT%>";
	var OA_ID = "<%=OA_ID%>";
	if(MSG_TYPE == "S"){
		//window.top.Dialog.alert("Submitted successfully");
		openFullWindowForXtable("/workflow/request/ViewRequest.jsp?requestid="+OA_ID);
		window.location.href = "/weixin/import/ExcelIn.jsp";
	}else{
		window.top.Dialog.alert("Submitted fail："+MSG_CONTENT);
		window.location.href = "/weixin/import/ExcelIn.jsp";
	}
	//window.location.href = "/systeminfo/BrowserMain.jsp?url=/weixin/import/ExcelIn.jsp";

	
</script>