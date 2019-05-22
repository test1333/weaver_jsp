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
<%@ page import=" seahonor.action.documents.FileDataExcelImport"%>
<%
	if (!DiskFileUpload.isMultipartContent(request)) {
		out.println("ֻ�ܴ���multipart/form-data���͵�����!");
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
		out.println("��������ʱ�����������⣺");
		return;
	}
	// ����ÿ�����ֶ�
	Iterator i = fileItems.iterator();
	String workflow = "";		//�̵�����
	String type = "";		//��������
	Sheet sheet = null;		
	while (i.hasNext()) {
		FileItem fi = (FileItem) i.next();
		if (fi.isFormField()) {
			if("workflow".equalsIgnoreCase(fi.getFieldName())){
				workflow = fi.getString("GBK");
			}
			if("type".equalsIgnoreCase(fi.getFieldName())){
				type = fi.getString("GBK");
			}
		}else{
			try {
				String pathSrc = fi.getName();
						
				if (pathSrc.trim().equals("")) {
					continue;
				}
				InputStream is = fi.getInputStream();// �õ��ļ���
				Workbook wb = Workbook.getWorkbook(is);
				sheet = wb.getSheet(0);
			}catch (Exception e) {
				out.println("�洢�ļ�ʱ�����������⣺");
				return;
			}finally { // ��������ɾ��������ֶ����ݵ���ʱ�ļ�
				fi.delete();
			}
		}
	}
	//out.println("sheet="+sheet);
	if(sheet!=null){
		String flag = new FileDataExcelImport().readAndExceSheet(sheet,workflow,type);
	}
%>
<script type="text/javascript">
	parent.getDialog(window).close();
</script>