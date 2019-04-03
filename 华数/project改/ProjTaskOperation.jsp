<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="weaver.docs.docs.DocExtUtil" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="weaver.general.BaseBean" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%! 
public void saveAccessory(FileUpload fu,User user,RecordSet RecordSet,String projid,String fjhzname,String fieldname,String taskid)
{
	//System.out.println("fieldname:"+fieldname);
	int accessorynum = Util.getIntValue(fu.getParameter("accessory_num"+fjhzname),0);
	String bz = Util.null2String(fu.getParameter("desc"));
	Date newdate = new Date() ;
	long datetime = newdate.getTime() ;
	Timestamp timestamp = new Timestamp(datetime) ;
	String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
	//附件上传
	String tempAccessory = "";
	if(accessorynum>0){
		String[] uploadField=new String[accessorynum];
		for(int i=0;i<accessorynum;i++){
			uploadField[i]="accessory"+(i+1)+fjhzname;
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
						/* String sql = "insert into  wasu_projfiles(projid,typeid,creater,fileid,createdate,bz) values("+projid+","+typeid+","+user.getUID()+",'"+returnarry[j]+"','"+CurrentDate+"','"+bz+"') ";
						RecordSet.executeSql(sql); */ 
				}
			} 
			System.out.println("---------------->"+tempAccessory);
			if(!tempAccessory.equals("")){ 
				RecordSet.executeSql(" update wasu_projtask set "+fieldname+"='"+tempAccessory+"' where id="+taskid); 
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

if(method.equals("add") || method.equals("addSubmit"))
{
	String projid=Util.null2String(fu.getParameter("projid"));
	String xmstatus=Util.null2String(fu.getParameter("xmstatus"));
	String wdfl=Util.null2String(fu.getParameter("wdfl"));
	String creater=Util.null2String(fu.getParameter("creater"));
	String sqrq=Util.null2String(fu.getParameter("sqrq"));
	String taskname=Util.null2String(fu.getParameter("taskname"));
	boolean ok=rs.executeSql(" insert into wasu_projtask (projid,projstatus,taskname,tasklb,creater,createdate) values("+  
			""+projid +","+xmstatus+",'"+taskname+"',"+wdfl+",'"+creater+"','"+sqrq+"')");    
	
	rs.executeSql("SELECT id from wasu_projtask ORDER BY id desc ");  
	rs.next();
	String taskid=rs.getString("id");
	
	int fjcount = Util.getIntValue(fu.getParameter("fjcount")); 
	
	java.util.Map fieldMap = new java.util.HashMap();
	String wdflfjformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdflfj")); 
	RecordSet.executeSql(" select * from formtable_main_"+wdflfjformid+"_dt1 where flmc="+wdfl+" order by id asc ");  
	while(RecordSet.next()){
		fieldMap.put(RecordSet.getString("sy"), RecordSet.getString("sjkzd")); 
		rs.executeSql("select * from syscolumns t1,sysobjects t2 where t1.id=t2.id and t2.name='wasu_projtask' and t1.name='"+RecordSet.getString("sjkzd")+"'");
		if(!rs.next()){
			rs.executeSql(" alter table wasu_projtask add "+RecordSet.getString("sjkzd")+" varchar(300) ");
			System.out.println("已增加字段:"+RecordSet.getString("sjkzd"));
		}  
	}
	
	//保存附件信息
	for(int i=0;i<fjcount;i++){
		if(fieldMap.containsKey(i+"")){
			saveAccessory(fu,user,RecordSet,projid,"_"+i,(String)fieldMap.get(""+i),taskid);   
		}
	}
	saveAccessory(fu,user,RecordSet,projid,"qt","qtfj",taskid);     
	response.sendRedirect("/project/Projtasklist.jsp?log=n&projid="+projid); 
	return ;
}

//修改
if(method.equals("edit"))
{
	String name=Util.null2String(fu.getParameter("name"));
 	
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
<script language=VBS>
     window.parent.returnvalue = Array("","")
     window.parent.close
</script>  
<script type=text/javascript> 
     window.parent.close();
</script> 