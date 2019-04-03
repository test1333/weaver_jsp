package htkj.doc;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.axis.encoding.Base64;

import sun.misc.BASE64Decoder;
import weaver.conn.RecordSet;
import weaver.conn.RecordSetDataSource;
import weaver.docs.category.CategoryManager;
import weaver.docs.category.DocTreelistComInfo;
import weaver.docs.category.MainCategoryComInfo;
import weaver.docs.category.SecCategoryComInfo;
import weaver.docs.category.SecCategoryCustomSearchComInfo;
import weaver.docs.category.SecCategoryDocPropertiesComInfo;
import weaver.docs.category.SecCategoryManager;
import weaver.docs.category.SubCategoryComInfo;
import weaver.docs.category.security.MultiAclManager;
import weaver.docs.docs.SecShareableCominfo;
import weaver.docs.webservices.DocAttachment;
import weaver.docs.webservices.DocInfo;
import weaver.docs.webservices.DocServiceImpl;
import weaver.general.BaseBean;
import weaver.general.StaticObj;
import weaver.general.Util;
import weaver.hrm.User;
import weaver.interfaces.datasource.DataSource;
import weaver.systeminfo.SysMaintenanceLog;

public class CreateUtil {

	BaseBean log =new BaseBean();
	
	
	/**
	 *    扫描表数据库：  10.160.1.7   sa/gemtek@ht123
	 *    扫描表：  TBLfile【文件存储表】     表中字段是中文
	 * @throws Exception 
	 *   
	 */
	public void getTBLfile() throws Exception{
	
		RecordSetDataSource rs = new RecordSetDataSource("Doc_Td");
		String jbbh="";//级别编号
		String wjbh="";//文件编号
		String wjmc="";//文件名称
		String wjnr="";//文件内容
		String wjlx="";//文件类型
		String scry="";//上传人员 
		String createrId="1";
		int secID=502;
		int mainid=0;
		int subId=0;
		String name="";
		
		    String sql="select  top 10 级别编号,文件编号,文件名称,文件类型,LEFT ( 上传人员 , 6 ) as 上传人员  from TBLfile ";
					
			rs.executeSql(sql);
			while(rs.next()){
		    	jbbh = Util.null2String(rs.getString(1));
		    	wjbh = Util.null2String(rs.getString(2));
		    	wjmc = Util.null2String(rs.getString(3));
		    	wjlx = Util.null2String(rs.getString(4));
		    	scry = Util.null2String(rs.getString(5));
		    	scry=scry.trim().substring(scry.trim().length()-5, scry.trim().length());
		    	if(hasCreate(wjbh)){
		    		continue;
		    	}
		    	name=wjmc+wjlx;
		    	createrId = getCreater(scry);
		    	secID = getSecID(jbbh);
		    	String docid=createDoc(wjbh,mainid,subId,secID,name,createrId);
		    	docShare(wjbh,docid);
		    	
		    	
		    }
		
		
		
		
	}
	/**
	 * 创建文档
	 * @param mainId 1级目录
	 * @param subId 2级目录
	 * @param secID 3级目录
	 * @param value 文档base64位加密的字符串
	 * @param createrid 创建人ID
	 */
	public  String getDocId(int mainId,int subId,int secID,String name,
				String value,String createrid,String doccode) throws Exception {
		String docId = "";
		DocInfo di= new DocInfo();
		di.setMaincategory(mainId);
		di.setSubcategory(subId);
		di.setSeccategory(secID);	
		di.setDocSubject(name.substring(0, name.lastIndexOf(".")));	
		DocAttachment doca = new DocAttachment();
		doca.setFilename(name);
		byte[] buffer = new BASE64Decoder().decodeBuffer(value);
		String encode=Base64.encode(buffer);
		doca.setFilecontent(encode);
		DocAttachment[] docs= new DocAttachment[1];
		docs[0]=doca;
		di.setAttachments(docs);
		String departmentId="-1";
		String sql="select departmentid from hrmresource where id="+createrid;
		RecordSet rs = new RecordSet();
		rs.executeSql(sql);
		User user = new User();
		if(rs.next()){
			departmentId = Util.null2String(rs.getString("departmentid"));
		}	
		user.setUid(Integer.parseInt(createrid));
		user.setUserDepartment(Integer.parseInt(departmentId));
		user.setLanguage(7);
		user.setLogintype("1");
		user.setLoginip("127.0.0.1");
		DocServiceImpl ds = new DocServiceImpl();
		try {
			docId=String.valueOf(ds.createDocByUser(di, user));
			sql="update docdetail set doccode='"+doccode+"' where id="+docId;
			rs.executeSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return docId;
	}
	/**
	 * 遍历创建目录
	 *  TBLfiletype【目录表】      表中字段是中文
	 *  创建表,如果存在跳过，不存在新建；不会删除或更新无效状态
	 * @throws Exception 
	 */
	public void createDir() throws Exception{
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String sql="select  a.结构编码,a.上级编码,a.级别编号,a.级别名称,b.级别编号 as sjjbbm from TBLfiletype a  left join TBLfiletype b  on a.上级编码=b.结构编码 order by a.结构编码 asc";
		String sql1="";
		String jgbm="";//结构编码
		String sjbm="";//上级编码
	    String jbbh="";//级别编号
		String jbmc="";//级别名称
		String sjjbbm="";//上级级别编码
		String parentid="";
		rsd.executeSql(sql);
		while(rsd.next()){
			jgbm = Util.null2String(rsd.getString("结构编码"));
			sjbm = Util.null2String(rsd.getString("上级编码"));
			jbbh = Util.null2String(rsd.getString("级别编号"));
			jbmc = Util.null2String(rsd.getString("级别名称"));
			sjjbbm = Util.null2String(rsd.getString("sjjbbm"));
			 sql1 = "select count(1) as count from DocSecCategory where coder='"+jbbh+"'";
			 rs.executeSql(sql1);
			 if(rs.next()){
				 if(rs.getInt("count")>0){
					 continue;
				 }
			 }
			 
			if("0".equals(sjbm)){
				parentid="502";
			}else{
				sql1="select max(id) as id from DocSecCategory where coder='"+sjjbbm+"'";
				rs.executeSql(sql1);
				if(rs.next()){
					parentid = Util.null2String(rs.getString("id"));
				}else{
					continue;
				}
			}
			CreateDR(1,parentid,jbmc,jbbh);
		}
	}
	
	public String  CreateDR(int sqr,String sjml,String mlmc,String drcode) throws Exception{
		DocTreelistComInfo DocTreelistComInfo = new DocTreelistComInfo();
		MainCategoryComInfo MainCategoryComInfo = new MainCategoryComInfo();
		SubCategoryComInfo SubCategoryComInfo = new SubCategoryComInfo();
		SecCategoryComInfo SecCategoryComInfo = new SecCategoryComInfo();
		SecCategoryManager scm = new SecCategoryManager();
		RecordSet RecordSet = new RecordSet();
		RecordSet RecordSet1 = new RecordSet();
		SysMaintenanceLog log = new SysMaintenanceLog();
		SecCategoryDocPropertiesComInfo SecCategoryDocPropertiesComInfo = new SecCategoryDocPropertiesComInfo();
		SecCategoryCustomSearchComInfo SecCategoryCustomSearchComInfo = new SecCategoryCustomSearchComInfo();
		SecShareableCominfo SecShareableCominfo = new SecShareableCominfo();
		
		
		 char flag=Util.getSeparator();
		  int userid=sqr;
		  MultiAclManager am = new MultiAclManager();
		  CategoryManager cm = new CategoryManager();
		  String isDialog = "1";
		  String isEntryDetail = "0";
		  String from = "subedit";
		  int fromTab = 0;
		  String OriSubId = "";//来时页面的subId

		int secid = -1;

		  	String subcategoryid="-1";
		    String parentid = Util.null2String(sjml);//父目录
		  	int subid = Util.getIntValue(subcategoryid,-1);
		    int mainid=Util.getIntValue(SubCategoryComInfo.getMainCategoryid(""+subid),0);
			String categoryname=mlmc.trim();//目录名称
			String coder=drcode;//目录编码
			String srccategoryname="";
			String docmouldid="0";
				
			String 	wordmouldid="0";
			String publishable="0";
			String replyable="0";
			String shareable="1";

			String cusertype="0";
			String cuserseclevel="0";//用户安全级别
			String cdepartmentid1="0";
			String cdepseclevel1="0";
			String cdepartmentid2="0";
			String cdepseclevel2="0";
			String croleid1="0";
			String crolelevel1="";
			String croleid2="0";
			String crolelevel2="";
			String croleid3="0";
			String crolelevel3="";
			String approvewfid="24";
			String hasaccessory="0";
			String accessorynum="";
			String hasasset="";
			String assetlabel="";
			String hasitems="";
			String itemlabel="";
			String hashrmres="";
			String hrmreslabel="";
			String hascrm="";
			String crmlabel="";
			String hasproject="";
			String projectlabel="";
			String hasfinance="";
			String financelabel="";

		  //增加是否此目录打分，以及是否匿名打分等字段
		    int markable=0;
		    int markAnonymity=0;
		    int orderable=0;
		    int defaultLockedDoc=0;
		    int isSetShare=0;

		    int allownModiMShareL=0;
		    int allownModiMShareW=0;
		    String allowShareTypeStrs = "";

//		    String[] allowAddSharers = request.getParameterValues("allowAddSharer");
//		    if (allowAddSharers!=null) {
//		        for (int i=0;i<allowAddSharers.length;i++){
//		            allowShareTypeStrs+=allowAddSharers[i]+",";
//		        }
//		    }

		    int maxOfficeDocFileSize = 8;
		    int maxUploadFileSize = 20;
		  
			
		    int noDownload = 0;
			int noRepeatedName = 0;
			int bacthDownload = 0;
			int isControledByDir = 0;
			int pubOperation = 0;
			int childDocReadRemind = 0;

			String isPrintControl = "";
			int printApplyWorkflowId = 0;

		    String isLogControl = "";

			int readOpterCanPrint = 0;
			
			int logviewtype = 0;

		    //TD2858 新的需求: 添加与文档创建人相关的默认共享  
		    int PCreater=0;
		    int PCreaterManager=0;
		    int PCreaterJmanager=0;
		    int PCreaterDownOwner=0;
		    int PCreaterSubComp=0;
		    int PCreaterDepart=0;
		    
		    int PCreaterDownOwnerLS=0;
		    int PCreaterSubCompLS=0;
		    int PCreaterDepartLS=0; 

		    int PDocCreaterW=0;
		    int PCreaterManagerW=0;
		    int PCreaterJmanagerW=0;

			String defaultDummyCata="";
			 int relationable =0;
			
			float secorder = 0;//目录顺序
			int dirmouldid = 0;

			int appointedWorkflowId = 0;	

		/** =========TD12005 文档下载控制权限   开始=========*/
			int PCreaterDL = 0;
			int PCreaterManagerDL = 0;
			int PCreaterSubCompDL = 0;
			int PCreaterDepartDL = 0;
			int PCreaterWDL = 0;
			int PCreaterManagerWDL = 0;
		/** =========TD12005 文档下载控制权限   结束=========*/

//		    String isUseFTPOfSystem=Util.null2String(request.getParameter("isUseFTPOfSystem"));//ecology系统使用FTP服务器设置功能  true:启用   false:不使用
//		    String isUseFTP=Util.null2String(request.getParameter("isUseFTP"));//指定文档子目录是否启用FTP服务器设置
//		    int FTPConfigId=Util.getIntValue(request.getParameter("FTPConfigId"));//FTP服务器
		    
		    int isOpenAttachment = 0;
		    
		    int isAutoExtendInfo = 0;
		    
		    int subcompanyId = -1;
		    
		    if(Util.getIntValue(parentid)>0){
				subcompanyId = 0;
			}
		    
		    int level = 0;
		    
		    level = SecCategoryComInfo.getLevel(parentid,true);
 
			    String extendParentAttr = "1";  
		        String checkSql = "select count(id) from DocSecCategory where categoryname = '"+categoryname+"'";
		        if(Util.getIntValue(parentid)>0){
		        	checkSql = checkSql + " and parentid="+parentid; 
		        }else{
		        	checkSql = checkSql + " and (parentid is null or parentid<=0) "; 
				}
		        RecordSet.executeSql(checkSql);
		        if(RecordSet.next()){
		        	if(RecordSet.getInt(1)>0){
		          return "false";	
		        	}
		        }
				String ParaStr=subcategoryid+flag+categoryname+flag+docmouldid+flag+publishable+flag+replyable+flag+shareable+flag+
							cusertype+flag+cuserseclevel+flag+cdepartmentid1+flag+cdepseclevel1+flag+cdepartmentid2+flag+
							cdepseclevel2+flag+croleid1+flag+crolelevel1+flag+croleid2+flag+crolelevel2+flag+croleid3+flag+
							crolelevel3+flag+hasaccessory+flag+accessorynum+flag+
							hasasset+flag+assetlabel+flag+hasitems+flag+itemlabel+flag+hashrmres+flag+hrmreslabel+flag+hascrm+flag+
							crmlabel+flag+hasproject+flag+projectlabel+flag+hasfinance+flag+financelabel+flag+approvewfid+flag+markable+flag+markAnonymity+flag+orderable+flag+defaultLockedDoc+flag+""+allownModiMShareL+flag+""+allownModiMShareW+flag+
							maxUploadFileSize+flag+wordmouldid+flag+isSetShare+flag+
							noDownload+flag+noRepeatedName+flag+isControledByDir+flag+pubOperation+flag+childDocReadRemind+flag+readOpterCanPrint+flag+isLogControl;
				if(extendParentAttr.equals("1")){
					ParaStr = scm.copyAttrFromParent(ParaStr,parentid,categoryname,noRepeatedName);
				}
				
				ParaStr = ParaStr + flag + subcompanyId+flag+level+flag+parentid+flag+secorder;
				RecordSet.executeProc("Doc_SecCategory_Insert_New",ParaStr);
				
				if(!RecordSet.next()){
				
		            return "false";
				}
		        int id=RecordSet.getInt(1);
				int newid=RecordSet.getInt(1);
		         /*是否允许订阅的处理 start*/
		        if (orderable ==1) {
		            RecordSet1.executeSql("update docdetail set orderable='1' where seccategory = "+id ); 
		        }
		        //RecordSet1.executeSql("update DocSecCategory set secorder="+secorder+",defaultDummyCata='"+defaultDummyCata+"',logviewtype="+logviewtype+",appliedTemplateId="+dirmouldid+",coder='"+coder+"',appointedWorkflowId="+appointedWorkflowId+",isPrintControl='"+isPrintControl+"',printApplyWorkflowId="+printApplyWorkflowId+",relationable='"+relationable+"',isOpenAttachment="+isOpenAttachment+",isAutoExtendInfo="+isAutoExtendInfo+",maxOfficeDocFileSize="+maxOfficeDocFileSize+",bacthDownload="+bacthDownload+" where id = "+id );
		        if(extendParentAttr.equals("1")){
					boolean result = scm.copyOtherInfoFromParent(id,parentid,level);
		        }
		        RecordSet1.executeSql("update DocSecCategory set secorder="+secorder+",coder='"+coder+"' where id = "+id );
		        SecShareableCominfo.addSecShareInfoCache(""+id);    
		        secid = newid;
				cm.addSecidToSuperiorSubCategory(newid);
				log.resetParameter();
		        log.setRelatedId(newid);
		        log.setRelatedName(categoryname);
		        log.setOperateType("1");
		        log.setOperateDesc("Doc_SecCategory_Insert");
		        log.setOperateItem("3");
		        log.setOperateUserid(userid);
		        log.setClientAddress("127.0.0.1");
		        log.setSysLogInfo();
		        
		        //TD2858 新的需求: 添加与文档创建人相关的默认共享  开始    
				if(!extendParentAttr.equals("1")){
				String strSqlInsert ="insert into DocSecCategoryShare (seccategoryid,sharetype,sharelevel,downloadlevel,operategroup)values("+newid+",1,3,1,1)";        
		        RecordSet.executeSql(strSqlInsert);  
				strSqlInsert="insert into DocSecCategoryShare (seccategoryid,sharetype,sharelevel,downloadlevel,operategroup)values("+newid+",2,1,1,1)";
			    RecordSet.executeSql(strSqlInsert);
				strSqlInsert="insert into DocSecCategoryShare (seccategoryid,sharetype,sharelevel,downloadlevel,operategroup)values("+newid+",1,3,1,2)";
			    RecordSet.executeSql(strSqlInsert);
				strSqlInsert="insert into DocSecCategoryShare (seccategoryid,sharetype,sharelevel,downloadlevel,operategroup)values("+newid+",2,1,1,2)";
			    RecordSet.executeSql(strSqlInsert);

		        //System.out.println(strSqlInsert);   
		        //TD2858 新的需求: 添加与文档创建人相关的默认共享  结束

				
				}
				MainCategoryComInfo.removeMainCategoryCache();
		        SubCategoryComInfo.removeMainCategoryCache();
		    	SecCategoryComInfo.removeMainCategoryCache();
		    	SecCategoryDocPropertiesComInfo.removeCache();
		    	SecCategoryDocPropertiesComInfo.addDefaultDocProperties(secid);
		    	SecCategoryCustomSearchComInfo.checkDefaultCustomSearch(secid);
				DocTreelistComInfo.removeGetDocListInfordCache();
				
				return String.valueOf(secid);
				
		    
	}
	/**
	 * 根据工号获取文档创建人
	 * @param workcode
	 * @return
	 */
	private String getCreater(String workcode){
		RecordSet rs = new RecordSet();

		String createrID="";
		String sql="select id from hrmresource where status<4 and workcode='"+workcode+"' and (accounttype is null or accounttype='' )";
		rs.executeSql(sql);
		if(rs.next()){
			createrID = Util.null2String(rs.getString("id"));
		}else{
			createrID = "1";
		}
		
		return createrID;
	
	}
	/**
	 * 根据级别编码获取文档目录
	 * @param workcode
	 * @return
	 */
	private int getSecID(String jbbh){
		RecordSet rs = new RecordSet();

		int secID=502;
		String sql="select id from DocSecCategory where coder='"+jbbh+"'";
		rs.executeSql(sql);
		if(rs.next()){
			secID = rs.getInt("id");
		}else{
			secID = 502;
		}
		
		return secID;
	
	}
	
	private boolean hasCreate(String wjbh){
		RecordSet rs = new RecordSet();

		int count=0;
		String sql="select count(1) as count from docdetail where doccode='"+wjbh+"'";
		rs.executeSql(sql);
		if(rs.next()){
			count = rs.getInt("count");
		}
		if(count>0){
			return true;
		}
		
		return false;
	
	}
	public String createDoc(String wjbh,int mainid,int subId,int secID ,String name,String createrId) throws Exception{
		log.writeLog("wjbh"+wjbh);
		String docid = "";
		DataSource ds = (DataSource) StaticObj.getServiceByFullname(
				("datasource.Doc_Td"), DataSource.class);
		String uploadBuffer ="";

		Connection conn = null;
		
		conn = ds.getConnection();
		ResultSet rs;
		try {
			rs = conn.createStatement().executeQuery(
					"select  文件内容  from TBLfile a  where    文件编号 ='"+wjbh+"' ");
			InputStream aa = null;
			if(rs.next()){
				aa= rs.getBinaryStream(1);
			}
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			
			 byte[] buffer = new byte[1024];
			 int count = 0;
			 while((count = aa.read(buffer)) >= 0){
			 baos.write(buffer, 0, count);
			 }
			 uploadBuffer = new String(Base64.encode(baos.toByteArray()));
			 docid=getDocId(mainid, subId, secID, name, uploadBuffer, createrId,wjbh);

				log.writeLog("docid"+docid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("errror"+e);
		}finally{
			conn.close();
		}
		return docid;
	}
	/**
	 * 同步权限组
	 */
	public void getRoles(){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String rsd_sql="select distinct 组别名称 as zb,LEFT ( 组别名称 , 4 ) as zbmc from tblpeopleteam ";
		String zbmc="";
		String zb="";
		rsd.execute(rsd_sql);
		String roleid="";
		while(rsd.next()){
			zb = Util.null2String(rsd.getString("zb"));
			zbmc = Util.null2String(rsd.getString("zbmc"));
			roleid=CreateRole(zb,zbmc);
			CreateRoleMember(roleid,zb);
		}
	}
	/**
	 * 创建角色
	 * @param zbmc
	 * @return
	 */
	private String CreateRole(String zb,String zbmc){
		String roleid="";
		RecordSet rs = new RecordSet();
		String sql="select id from hrmroles where rolesmark='"+zb+"'";
		log.writeLog("searchrole+sql:"+sql);
		rs.executeSql(sql);
		if(rs.next()){
			roleid = Util.null2String(rs.getString("id"));
			return roleid;
		}
		sql="insert into hrmroles(rolesmark,rolesname,docid,type,ecology_pinyin_search) values('"+zb+"','"+zbmc+"',0,0,'"+zbmc+"')";
		log.writeLog("insertrole+sql:"+sql);
		rs.executeSql(sql);
		sql="select id from hrmroles where rolesmark='"+zb+"'";
		log.writeLog("searchrole+sql:"+sql);
		rs.executeSql(sql);
		if(rs.next()){
			roleid = Util.null2String(rs.getString("id"));		
		}
		return roleid;
	}
	/**
	 * 往角色中增加人员
	 * @param roleid
	 * @param zb
	 */
	private void CreateRoleMember(String roleid,String zb){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String rsd_sql="select LEFT ( 员工名称 , 6 ) as workcode from tblpeopleteam where 组别名称 ='"+zb+"'";
        String workcode="";
        String rolemember="";
        String sql="";
		rsd.executeSql(rsd_sql);
		while(rsd.next()){
			workcode = Util.null2String(rsd.getString("workcode"));
			workcode=workcode.trim().substring(workcode.trim().length()-5, workcode.trim().length());
			rolemember = getCreater(workcode);
			if("1".equals(rolemember)){
				continue;
			}
			sql="select * from hrmrolemembers where roleid="+roleid+" and resourceid="+rolemember;
			log.writeLog("searchmember+sql:"+sql);
			rs.executeSql(sql);
			if(rs.next()){
				continue;
			}
			sql="insert into hrmrolemembers(roleid,resourceid,rolelevel) values("+roleid+","+rolemember+",2)";
			log.writeLog("insertmember+sql:"+sql);
			rs.execute(sql);
		}
	}
	/**
	 * 根据文件编号获取权限组
	 * @param wjbh
	 * @param docid
	 */
	private void docShare(String wjbh,String docid){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String zbmc="";
		String sql="";
		String roleid="";
		String rsd_sql="select  distinct 组别 as zbmc from TBLfileteam where 文件编号 ='"+wjbh+"'";
		rsd.executeSql(rsd_sql);
		while(rsd.next()){
			zbmc = Util.null2String(rsd.getString("zbmc"));
			sql="select id from hrmroles where rolesname='"+zbmc+"'";
			rs.executeSql(sql);
			while(rs.next()){
				roleid = Util.null2String(rs.getString("id"));
				addRole(roleid,docid);
			}
			
		}
	}
	/**
	 * 将文档共享给角色
	 * @param roleid
	 * @param docid
	 */
	private void addRole(String roleid,String docid){
		RecordSet rs = new RecordSet();
		String content=roleid+"2";
		String sql="insert into docshare(docid,sharetype,seclevel,rolelevel,sharelevel,roleid,downloadlevel,seclevelmax) values("+docid+",4,10,2,1,"+roleid+",1,100)";
		rs.executeSql(sql);
		sql="insert into shareinnerdoc(sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel,seclevelmax) values("+docid+",4,"+content+",10,1,4,"+roleid+",0,1,100)";
		rs.executeSql(sql);
	}
}
