<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.docs.docs.DocExtUtil" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.sql.Timestamp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%!
public void saveAccessory(FileUpload fu,User user,RecordSet RecordSet,String meetingid)
{
	int accessorynum = Util.getIntValue(fu.getParameter("accessory_num"),0);
	String bz = Util.null2String(fu.getParameter("desc"));
	//附件上传
	String tempAccessory = "";
	if(accessorynum>0){
		String[] uploadField=new String[accessorynum];
		for(int i=0;i<accessorynum;i++){
			uploadField[i]="accessory"+(i+1);
		}
		DocExtUtil mDocExtUtil=new DocExtUtil();
		int[] returnarry = mDocExtUtil.uploadDocsToImgs(fu,user,uploadField);
		if(returnarry != null){
			for(int j=0;j<returnarry.length;j++){
				if(returnarry[j] != -1){
						//新建时赋予创建者对附件文档的权限，而不是对所有参与者赋权。
						RecordSet.executeSql("insert into shareinnerdoc(sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource)values("+returnarry[j]+",1,"+user.getUID()+",0,1,1,"+user.getUID()+",1)");
						if(tempAccessory.equals(""))
						{
							tempAccessory = String.valueOf(returnarry[j]);
						}
						else
						{
							tempAccessory += "," + String.valueOf(returnarry[j]);
						}  
				}
			} 
			RecordSet.executeSql(" update projmeeting set fjids='"+tempAccessory+"' where id="+meetingid);  
		}
	}
}

public void editAccessory(FileUpload fu,User user,RecordSet RecordSet,String meetingid)
{
	int accessorynum = Util.getIntValue(fu.getParameter("accessory_num"),0);
	String bz = Util.null2String(fu.getParameter("desc"));
	//附件上传
	String tempAccessory = "";
	if(accessorynum>0){
		String[] uploadField=new String[accessorynum];
		for(int i=0;i<accessorynum;i++){
			uploadField[i]="accessory"+(i+1);
		}
		DocExtUtil mDocExtUtil=new DocExtUtil();
		int[] returnarry = mDocExtUtil.uploadDocsToImgs(fu,user,uploadField);
		if(returnarry != null){
			for(int j=0;j<returnarry.length;j++){
				if(returnarry[j] != -1){ 
						//新建时赋予创建者对附件文档的权限，而不是对所有参与者赋权。
						RecordSet.executeSql("insert into shareinnerdoc(sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource)values("+returnarry[j]+",1,"+user.getUID()+",0,1,1,"+user.getUID()+",1)");
						if(tempAccessory.equals(""))
						{
							tempAccessory = String.valueOf(returnarry[j]);
						}
						else
						{
							tempAccessory += "," + String.valueOf(returnarry[j]);
						}  
				}
			} 
			
			if(RecordSet.getDBType().equalsIgnoreCase("sqlserver")){ 
				RecordSet.executeSql(" update projmeeting set fjids=fjids+',"+tempAccessory+"' where id="+meetingid);  
			}else{
				RecordSet.executeSql(" update projmeeting set fjids=fjids||',"+tempAccessory+"' where id="+meetingid);  
			}
		}
	}
}

%>
<%
FileUpload fu = new FileUpload(request);
String CurrentUser = ""+user.getUID();
String CurrentUserName = ""+user.getUsername();
String SubmiterType = ""+user.getLogintype();
String ClientIP = fu.getRemoteAddr();

Date newdate = new Date();
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

char flag = 2;
String ProcPara = "";
String Sql="";

String method = Util.null2String(fu.getParameter("method"));
String meetingtype=Util.null2String(fu.getParameter("meetingtype"));
String meetingid=Util.null2String(fu.getParameter("meetingid"));

String approvewfid ="";

if(method.equals("add"))
{
	String meetingname=Util.null2String(fu.getParameter("meetingname"));
	String meetingtime=Util.null2String(fu.getParameter("meetingtime"));
	String meetingprojids=Util.null2String(fu.getParameter("meetingprojids"));
	RecordSet.executeSql(" insert into projmeeting(projids,meetingname,meetingtime) values('"+meetingprojids+"','"+meetingname+"','"+meetingtime+"')");  
	RecordSet.executeSql(" select max(id) as meetingid from projmeeting ");
	RecordSet.next();
	String mid=RecordSet.getString("meetingid");
	
	//保存附件信息
	saveAccessory(fu,user,RecordSet,mid); 
	 
	response.sendRedirect("/project/Projmeetinglist.jsp");
	return;
}

//修改
if(method.equals("edit"))
{
	String meetingname=Util.null2String(fu.getParameter("meetingname"));
	String meetingtime=Util.null2String(fu.getParameter("meetingtime"));
	String meetingprojids=Util.null2String(fu.getParameter("meetingprojids"));
	if(meetingid.equals("")){
		meetingid = Util.null2String(fu.getParameter("id")); 
	}
	RecordSet.executeSql(" update projmeeting set projids='"+meetingprojids+"',meetingname='"+meetingname+"',meetingtime='"+meetingtime+"'  where id="+meetingid);  
	 
	//保存附件信息
	editAccessory(fu,user,RecordSet,meetingid);   
	 
	response.sendRedirect("/project/Projmeetinglist.jsp");
	return;
 	
}

if(method.equals("delete"))
{ 
	String projid=Util.null2String(fu.getParameter("projid"));
	String typeid=Util.null2String(fu.getParameter("typeid"));
	int fileid=Util.getIntValue(fu.getParameter("fileid"),0);
	RecordSet.executeSql(" select * from docdetail where id="+fileid);
	if(RecordSet.next()){
		weaver.docs.docs.DocManager docmanager = new weaver.docs.docs.DocManager();
		docmanager.setId(fileid);
		docmanager.setDocsubject(RecordSet.getString("docsubject"));
		docmanager.setUserid(user.getUID());
		docmanager.setUsertype("1");
		docmanager.setClientAddress(fu.getRemoteAddr());
		docmanager.setDoccreaterid(RecordSet.getInt("doccreaterid"));
		docmanager.setDocCreaterType("1"); 
		docmanager.DeleteDocInfo();
		
		RecordSet.executeSql(" delete from wasu_projfiles where projid="+projid+" and fileid="+fileid); 
	}
	
	
}
%>
 