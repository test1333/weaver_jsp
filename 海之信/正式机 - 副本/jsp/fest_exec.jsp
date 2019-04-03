<%@ page import="weaver.general.Util" %>
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
<%@ page import=" seahonor.action.assets.ExcelImport"%>
	
<%
	if (!DiskFileUpload.isMultipartContent(request)) {
		out.println("只能处理multipart/form-data类型的数据!");
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
		out.println("解析数据时出现如下问题：");
		return;
	}
	// 处理每个表单字段
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
				InputStream is = fi.getInputStream();// 得到文件流
				Workbook wb = Workbook.getWorkbook(is);
				sheet = wb.getSheet(0);
			}catch (Exception e) {
				out.println("存储文件时出现如下问题：");
				return;
			}finally { // 总是立即删除保存表单字段内容的临时文件
				fi.delete();
			}
		}
	}
	String flag = new ExcelImport().readAndExceSheet(sheet);
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