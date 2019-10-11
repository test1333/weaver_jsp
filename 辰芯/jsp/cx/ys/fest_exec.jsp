<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import=" java.io.IOException"%>
<%@ page import=" java.io.InputStream"%>
<%@ page import=" java.io.PrintWriter"%>
<%@ page import=" java.util.Iterator"%>
<%@ page import=" java.util.List"%>
<%@ page import=" jxl.Sheet"%>
<%@ page import=" jxl.Workbook"%>
<%@ page import=" org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import=" org.apache.commons.fileupload.FileItem"%>
<%@ page import=" org.apache.commons.fileupload.FileUploadException"%>
<%@ page import=" morningcore.ys.ExcelImport"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
	
<%
	if (!DiskFileUpload.isMultipartContent(request)) {
		out.println("Can only handle multipart/form-data type data!");
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
	int userid = user.getUID();
	Iterator i = fileItems.iterator();
	String year = "";
	Sheet sheet = null;		
	while (i.hasNext()) {
		FileItem fi = (FileItem) i.next();
		if (fi.isFormField()) {
				if("year".equalsIgnoreCase(fi.getFieldName())){
					year = fi.getString("GBK");
				}
		}else{
			try {
				String pathSrc = fi.getName();
						
				if (pathSrc.trim().equals("")) {
					continue;
				}
				InputStream is = fi.getInputStream();
				Workbook wb = Workbook.getWorkbook(is);
				sheet = wb.getSheet(0);
			}catch (Exception e) {
				out.println("Error storing file");
				return;
			}finally { // 总是立即删除保存表单字段内容的临时文件
				fi.delete();
			}
		}
	}
	String result = new ExcelImport().readAndExceSheet(sheet,userid,year);
	if("-1".equals(result)){
		result="导入失败，请检查模板";
	}else if("1".equals(result)){
		result="导入成功，请在权限更新页面更新导入的数据权限";
	}
	out.print(result);
%>
<script type="text/javascript">
	var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>