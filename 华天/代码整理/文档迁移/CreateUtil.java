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
	 *    ɨ������ݿ⣺  10.160.1.7   sa/gemtek@ht123
	 *    ɨ���  TBLfile���ļ��洢��     �����ֶ�������
	 * @throws Exception 
	 *   
	 */
	public void getTBLfile() throws Exception{
	
		RecordSetDataSource rs = new RecordSetDataSource("Doc_Td");
		String jbbh="";//������
		String wjbh="";//�ļ����
		String wjmc="";//�ļ�����
		String wjnr="";//�ļ�����
		String wjlx="";//�ļ�����
		String scry="";//�ϴ���Ա 
		String createrId="1";
		int secID=502;
		int mainid=0;
		int subId=0;
		String name="";
		
		    String sql="select  top 10 ������,�ļ����,�ļ�����,�ļ�����,LEFT ( �ϴ���Ա , 6 ) as �ϴ���Ա  from TBLfile ";
					
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
	 * �����ĵ�
	 * @param mainId 1��Ŀ¼
	 * @param subId 2��Ŀ¼
	 * @param secID 3��Ŀ¼
	 * @param value �ĵ�base64λ���ܵ��ַ���
	 * @param createrid ������ID
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
	 * ��������Ŀ¼
	 *  TBLfiletype��Ŀ¼��      �����ֶ�������
	 *  ������,��������������������½�������ɾ���������Ч״̬
	 * @throws Exception 
	 */
	public void createDir() throws Exception{
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String sql="select  a.�ṹ����,a.�ϼ�����,a.������,a.��������,b.������ as sjjbbm from TBLfiletype a  left join TBLfiletype b  on a.�ϼ�����=b.�ṹ���� order by a.�ṹ���� asc";
		String sql1="";
		String jgbm="";//�ṹ����
		String sjbm="";//�ϼ�����
	    String jbbh="";//������
		String jbmc="";//��������
		String sjjbbm="";//�ϼ��������
		String parentid="";
		rsd.executeSql(sql);
		while(rsd.next()){
			jgbm = Util.null2String(rsd.getString("�ṹ����"));
			sjbm = Util.null2String(rsd.getString("�ϼ�����"));
			jbbh = Util.null2String(rsd.getString("������"));
			jbmc = Util.null2String(rsd.getString("��������"));
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
		  String OriSubId = "";//��ʱҳ���subId

		int secid = -1;

		  	String subcategoryid="-1";
		    String parentid = Util.null2String(sjml);//��Ŀ¼
		  	int subid = Util.getIntValue(subcategoryid,-1);
		    int mainid=Util.getIntValue(SubCategoryComInfo.getMainCategoryid(""+subid),0);
			String categoryname=mlmc.trim();//Ŀ¼����
			String coder=drcode;//Ŀ¼����
			String srccategoryname="";
			String docmouldid="0";
				
			String 	wordmouldid="0";
			String publishable="0";
			String replyable="0";
			String shareable="1";

			String cusertype="0";
			String cuserseclevel="0";//�û���ȫ����
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

		  //�����Ƿ��Ŀ¼��֣��Լ��Ƿ�������ֵ��ֶ�
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

		    //TD2858 �µ�����: ������ĵ���������ص�Ĭ�Ϲ���  
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
			
			float secorder = 0;//Ŀ¼˳��
			int dirmouldid = 0;

			int appointedWorkflowId = 0;	

		/** =========TD12005 �ĵ����ؿ���Ȩ��   ��ʼ=========*/
			int PCreaterDL = 0;
			int PCreaterManagerDL = 0;
			int PCreaterSubCompDL = 0;
			int PCreaterDepartDL = 0;
			int PCreaterWDL = 0;
			int PCreaterManagerWDL = 0;
		/** =========TD12005 �ĵ����ؿ���Ȩ��   ����=========*/

//		    String isUseFTPOfSystem=Util.null2String(request.getParameter("isUseFTPOfSystem"));//ecologyϵͳʹ��FTP���������ù���  true:����   false:��ʹ��
//		    String isUseFTP=Util.null2String(request.getParameter("isUseFTP"));//ָ���ĵ���Ŀ¼�Ƿ�����FTP����������
//		    int FTPConfigId=Util.getIntValue(request.getParameter("FTPConfigId"));//FTP������
		    
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
		         /*�Ƿ������ĵĴ��� start*/
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
		        
		        //TD2858 �µ�����: ������ĵ���������ص�Ĭ�Ϲ���  ��ʼ    
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
		        //TD2858 �µ�����: ������ĵ���������ص�Ĭ�Ϲ���  ����

				
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
	 * ���ݹ��Ż�ȡ�ĵ�������
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
	 * ���ݼ�������ȡ�ĵ�Ŀ¼
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
					"select  �ļ�����  from TBLfile a  where    �ļ���� ='"+wjbh+"' ");
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
	 * ͬ��Ȩ����
	 */
	public void getRoles(){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String rsd_sql="select distinct ������� as zb,LEFT ( ������� , 4 ) as zbmc from tblpeopleteam ";
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
	 * ������ɫ
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
	 * ����ɫ��������Ա
	 * @param roleid
	 * @param zb
	 */
	private void CreateRoleMember(String roleid,String zb){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String rsd_sql="select LEFT ( Ա������ , 6 ) as workcode from tblpeopleteam where ������� ='"+zb+"'";
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
	 * �����ļ���Ż�ȡȨ����
	 * @param wjbh
	 * @param docid
	 */
	private void docShare(String wjbh,String docid){
		RecordSet rs = new RecordSet();
		RecordSetDataSource rsd = new RecordSetDataSource("Doc_Td");
		String zbmc="";
		String sql="";
		String roleid="";
		String rsd_sql="select  distinct ��� as zbmc from TBLfileteam where �ļ���� ='"+wjbh+"'";
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
	 * ���ĵ��������ɫ
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
