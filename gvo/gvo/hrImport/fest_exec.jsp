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
<%@ page import=" gvo.hrImport.ExcelImport"%>
	
<%
	if (!DiskFileUpload.isMultipartContent(request)) {
		out.println("ֻ�ܴ���multipart/form-data���͵�����!");
		return;
	}
	System.out.println("Test1 !! ");
	DiskFileUpload fu = new DiskFileUpload();
	fu.setSizeMax(1024 * 1024 * 50);
	fu.setSizeThreshold(1024 * 1024);
	fu.setHeaderEncoding("gbk");
	List fileItems = null;
	try {
		fileItems = fu.parseRequest(request);
	} catch (FileUploadException e) {
		out.println("��������ʱ�����������⣺");
		return;
	}
	System.out.println("Test2 !! ");
	// ����ÿ�����ֶ�
	Iterator i = fileItems.iterator();
	String who_oper = "";
	Sheet sheet = null;
	while (i.hasNext()) {
	FileItem fi = (FileItem) i.next();
	if (fi.isFormField()) {
		System.out.println("Test3 !! ");
		if("who_oper".equalsIgnoreCase(fi.getFieldName())){
			who_oper = fi.getString("GBK");
		}
	} else {
		try {
			System.out.println("Test4 !! ");
			String pathSrc = fi.getName();
			
			if (pathSrc.trim().equals("")) {
				continue;
			}
			InputStream is = fi.getInputStream();// �õ��ļ���
			Workbook wb = Workbook.getWorkbook(is);
			sheet = wb.getSheet(0);
		} catch (Exception e) {
			out.println("�洢�ļ�ʱ�����������⣺");
			return;
		} finally { // ��������ɾ��������ֶ����ݵ���ʱ�ļ�
			fi.delete();
		}
	}
}
		System.out.println("Test5 !! ");
		String flag = new ExcelImport().readAndExceSheet(sheet,who_oper);
		response.sendRedirect("fest.jsp?mess="+flag);
%>