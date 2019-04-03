<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.docs.networkdisk.server.UploadFileServer" %>
<%@ page import="weaver.conn.RecordSet" %>

<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
	FileOutputStream outputStream = null;
	InputStream inputStream = null;
	File file = null;
	String filesize = "-1";
	String startSize = "-2";
	 RecordSet rs = new RecordSet();
	try
	{
	 // 登录用户ID
		String loginid = request.getHeader("loginid");
		// 上传文件uid
		String uploadfileguid = request.getHeader("uploadfileguid");
		// 上传文件路径uid
		String filepathmd5 = request.getHeader("filepathmd5");
		
		// 文件大小
		filesize = request.getHeader("filesize");
		// 项目根目录
		String rootPath = GCONST.getRootPath();
		
		// 文件存放目录
		String filePath = rootPath+"networkuploadtemp";
		
        File _file = new File(filePath);
        //如果文件夹不存在则创建  
        if (!_file.exists() && !_file.isDirectory()) {
            _file.mkdir();
        }
		filePath += "\\"+filepathmd5+loginid+".temp";
		file = new File(filePath);
		// 文件流
		inputStream = request.getInputStream();
		outputStream = new FileOutputStream(filePath,true);

		int byteCount = 0;
		byte[] bytes = new byte[1024];
		int aa = 0;
		while ((byteCount = inputStream.read(bytes)) != -1)
		{
			outputStream.write(bytes, 0, byteCount);
			aa += byteCount;
		}
		
		startSize = String.valueOf(file.length());
		if(startSize.equals(filesize))
		{
		 // 文件上传接口
			UploadFileServer uploadFileServer = new UploadFileServer();
			uploadFileServer.finallyUpload(filePath,filepathmd5);
			response.setHeader("returnstatus", "0");
		}
		else
		{
			String updateSql = "update imagefilereftemp set uploadsize = "+startSize+" where filepathmd5 = '" + filepathmd5 +"'" ;
			
			rs.executeSql(updateSql);
			response.setHeader("startsize", startSize);
			response.setHeader("returnstatus", "1");
		}
	}
	catch(Exception ex)
	{
	    ex.printStackTrace();
	}
	finally
	{
	    if(outputStream != null)
	    {
			outputStream.close();
	    }
	    if(inputStream != null)
	    {
	        inputStream.close();
	    }
	    if(startSize.equals(filesize))
		{
	        if(file.exists())
		    {
		        file.delete();
		    } 
		}
	}
%>
