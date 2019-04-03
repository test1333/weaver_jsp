<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.docs.networkdisk.server.UploadFileServer" %>
<%@ page import="weaver.docs.networkdisk.bean.DocAttachment"%>
<%@ page import="weaver.docs.networkdisk.tools.FileMIMEUtil"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.docs.docs.ImageFileIdUpdate" %>
<%@ page import="org.apache.axis.encoding.Base64" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.Util" %>

<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
	User user  = HrmUserVarify.getUser (request , response) ;
	String filemd5 = request.getParameter("fileMd5");
	byte[] decoded_filePath = Base64.decode(request.getParameter("filePath"));
	String filePath = new String(decoded_filePath, "utf8");
	// 文件名
	String fileName = filePath.substring(filePath.lastIndexOf(File.separator)+1);
	String uploadtype = request.getParameter("uploadtype");
	String categoryid = request.getParameter("categoryid");
	String mdate = request.getParameter("mdate");
	String mtime = request.getParameter("mtime");
	
	int isSystemDoc = Util.getIntValue(request.getParameter("isSystemDoc"),0);


	RecordSet rs = new RecordSet();
	if(isSystemDoc == 0 && (categoryid.isEmpty() || categoryid.equals("0")))
	{
		String sql = "select id from DocPrivateSecCategory where categoryname = '" + user.getUID() + "_" + user.getLastname() + "' and parentid=0";
        rs.execute(sql);
        if(rs.next()){
            categoryid = rs.getString("id");
        }
	}
	boolean isadd = true;
	JSONObject jsonObj = new JSONObject();
	//String sql = "select id from imagefilereftemp where filepathmd5 = '" + filemd5 +"' and categoryid = '"+categoryid+"'";
	//rs.executeSql(sql);
	//if(rs.next()){
	//	jsonObj.put("fileuploadstatus","4"); //已有
	//	isadd = false;
	//}
	if(isadd)
	{
		// 文件上传接口
		UploadFileServer uploadFileServer = new UploadFileServer();
		
		String ishave = "";
		if(isSystemDoc == 0){ //不是系统目录上传文件
			ishave = uploadFileServer.isHaveFile(filemd5,"");
		}
		
		if(!ishave.isEmpty())
		{
			String ishaveInCategory = uploadFileServer.isHaveFile(filemd5,categoryid);
			if(ishaveInCategory.isEmpty())
			{
				Map<String, String> _rmap = uploadFileServer.copyRelationship(user,ishave,categoryid,false);
				jsonObj.put("fileuploadstatus","1");//成功
				jsonObj.put("imageFileId",_rmap.get("imagefileid"));
				jsonObj.put("networklogid",_rmap.get("logid"));
			}
			else
			{
				if(uploadtype.equals("upload"))
				{
					jsonObj.put("fileuploadstatus","0"); // 已存在
				}
				else
				{
					String sql = "select id,modifydate,modifytime from imagefileref where id = "+ishave+" and ((modifydate < '"+mdate+"') or (modifydate = '"+mdate+"' and modifytime < '"+mtime+"'))";
					 rs.execute(sql);
					 if(rs.next()){
						jsonObj.put("fileuploadstatus","2"); //需要同步
					 }
					 else
					 {
						jsonObj.put("fileuploadstatus","3"); //不需要同步
					 }
				}
			}
			out.println(jsonObj.toString());
		}
		else
		{
			// 封装文件上传对象
			DocAttachment attInfo = new DocAttachment();
			// 文件路径MD5值
			attInfo.setFilePathMd5(filemd5);
			// 文档创建人
			attInfo.setCreaterId(user.getUID()+"");
			// 创建日期
			attInfo.setCreateDate(request.getParameter("cdate"));
			// 创建时间
			attInfo.setCreateTime(request.getParameter("ctime"));
			// 最后修改人
			attInfo.setModifierId(user.getUID() + "");
			// 最后修改日期
			attInfo.setModifyDate(mdate);
			// 最后修改时间
			attInfo.setModifyTime(mtime);
			// 所在目录
			attInfo.setCategoryid(categoryid);
			attInfo.setDiskPath(filePath);
			attInfo.setFileName(fileName);
			// 文件类型
			attInfo.setFileType(FileMIMEUtil.getMIMEType(fileName.substring(fileName.lastIndexOf("."))));
			// 文件大小
			attInfo.setFileSize(Long.valueOf(request.getParameter("fileSize")));
			// 客户端GUID
			attInfo.setComputerCode(request.getParameter("clientguid"));
			// 获取imagefileid
			ImageFileIdUpdate imageFileIdUpdate = new ImageFileIdUpdate();
			int imageid = imageFileIdUpdate.getImageFileNewId();
			// 文件id
			attInfo.setImageFileId(imageid+"");
			// 来源于上传，1：上传，3：同步
			attInfo.setComefrom(uploadtype.equals("upload") ? 1 : 3);
			//是否是私人目录
			attInfo.setIsSystemDoc(isSystemDoc);
			
			if(attInfo.getComefrom() == 3)
            {
               String sql = "select * from ImageFileRef where comefrom = 3 and diskPath = '"+filePath+"' " +
                " and computercode = '"+request.getParameter("clientguid")+"' and categoryid = '"+categoryid+"' and createrid = '"+user.getUID()+"' ";
               
                rs.executeSql(sql);
				
                if(rs.next())
                {
                    String old_modifydate = rs.getString("modifydate");
                    String old_modifytime = rs.getString("modifytime");
                    String old_imagefileid = rs.getString("imagefileid");
                    if((old_modifydate.compareTo(mdate) < 0 ) || (old_modifydate.equals(mdate) && old_modifytime.compareTo(mtime) < 0) )
                    {
            			attInfo.setImageFileId("-"+old_imagefileid);
            			// 创建 GUID 对象
            			UUID uuid = UUID.randomUUID();
            			// 得到对象产生的ID
            			String uploadfileguid = uuid.toString();
            			// 转换为大写
            			uploadfileguid = uploadfileguid.toUpperCase();
            			attInfo.setUploadfileguid(uploadfileguid.toString());
            			// 添加到临时文件
            			uploadFileServer.addImageFileReftemp(attInfo);
            			
            			out.println(jsonObj.fromObject(attInfo).toString());
                    }
                    else
                    {
                        jsonObj.put("fileuploadstatus","3"); //不需要同步
                        out.println(jsonObj.toString());
                    }
                }
                else
                {
                 	// 创建 GUID 对象
        			UUID uuid = UUID.randomUUID();
        			// 得到对象产生的ID
        			String uploadfileguid = uuid.toString();
        			// 转换为大写
        			uploadfileguid = uploadfileguid.toUpperCase();
        			attInfo.setUploadfileguid(uploadfileguid.toString());
        			// 添加到临时文件
        			uploadFileServer.addImageFileReftemp(attInfo);
        			
        			out.println(jsonObj.fromObject(attInfo).toString());
                }
            }
			else
			{
			 	// 创建 GUID 对象
				UUID uuid = UUID.randomUUID();
				// 得到对象产生的ID
				String uploadfileguid = uuid.toString();
				// 转换为大写
				uploadfileguid = uploadfileguid.toUpperCase();
				attInfo.setUploadfileguid(uploadfileguid.toString());
				// 添加到临时文件
				uploadFileServer.addImageFileReftemp(attInfo);
				
				out.println(jsonObj.fromObject(attInfo).toString());
			}
			
		}
	}
	else
	{
		out.println(jsonObj.toString());
	}
%>
