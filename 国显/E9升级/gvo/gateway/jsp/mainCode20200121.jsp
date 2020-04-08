<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.conn.*"%>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.file.Prop" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.page.interfaces.*"%>
<%@ page import="weaver.page.interfaces.commons.*"%>
<%@ page import="weaver.conn.RecordSetDataSource"%>
<%@ page import="weaver.systeminfo.setting.HrmUserSettingHandler" %>
<%@ page import="weaver.systeminfo.setting.HrmUserSetting" %>
<%@page import="weaver.systeminfo.setting.HrmUserSettingComInfo"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="shareManager" class="weaver.share.ShareManager"/>
<jsp:useBean id="dc" class="weaver.docs.docs.DocComInfo" scope="page"/>


<%!
		private String getImageFile(String imagefileid) {
	    	String imagefile = "/weaver/weaver.file.FileDownload?fileid=";
	    	if (!"".equals(imagefileid)) {
	            imagefile += imagefileid;
	    	}else{
	        	imagefile="/portal/plugin/images/opzm/icon.png";
	        }
	    	return imagefile;
		}
	%>
	<%
		
		//获取配置文件中各异构系统ip
		Prop prop = Prop.getInstance();
		String configfile = "VisionoxSystemLink";
		String PSLink = prop.getPropValue(configfile , "PSLink");
		String KnowledgeSystemLink = prop.getPropValue(configfile , "KnowledgeSystemLink");	
		
		String sql = "";//查询sql 
		String hotnewsNumberOA  = "";//待办数目
		String hotnewsNumberEC = "";//待办数目
		int hotnewsNumberSum ;//待办数目
		String todo = "";//我的待办
		String knowledge = "";//知识库
		String employeeHelp = ""; //员工自助
		String metting = "";//会议中心
		String noticeSum = "";//通知(更多)
		String companyNews="";//公司新闻(更多)
		String companyNew="";//公司新闻明细(json数组)
		String createNewRequest = "";//新建流程
		String system = "";//制度门户
		String companyWH = "";//企业文化
		String imgSrc = "";//背景图片的地址
		String fileWordSrc = "";//文档照片地址
		String qualityBulletin = "";//品质公告（更多）
		String corporateCultureMore = "";//企业文化（更多）
		JSONArray companyNewValue = new JSONArray();//公司新闻明细容器

		RecordSetDataSource rsx = new RecordSetDataSource("EC");
		User user = HrmUserVarify.getUser(request, response);	
		if (user == null) {
			response.sendRedirect("/wui/index.html#/?logintype=1");
			return;
		}
		int userid = user.getUID();
		
		//当前访问人分部id---V3控权
		boolean isV3 = false; //是否是V3人员
		
		boolean isKvi = false; //是否是维信诺科技人员
		
		if(userid != 1){
			int userSubCompany1 = user.getUserSubCompany1();
			if(userSubCompany1==301 || userSubCompany1==302 ){
				response.sendRedirect("/wui/index.html#/main");
			}
			if(userSubCompany1==401){
				isV3 = true;				
			}	
			//新增维信诺科技分部，需要增加条件，进行过滤
			if(userSubCompany1==1||userSubCompany1==21||userSubCompany1==181||userSubCompany1==284||userSubCompany1==461||userSubCompany1==462||userSubCompany1==261||userSubCompany1==285||userSubCompany1==981||userSubCompany1==982){
				isKvi = true;
			}
		}

		//=====================================待办数目 开始======================================================
		/*
			查询待办数目 OA
			流程待办按照国显提供需要排除的流程类型 进行统计
		*/
		sql=" select COUNT(a.requestid) hotnewsNumber from workflow_requestbase a,workflow_currentoperator b"
				+" where a.requestid = b.requestid and b.isremark not in(2,4,8,9) and b.islasttimes=1 "
				+"  and a.workflowid not in(641,13,1,2,3,4,9,741) and  nvl(b.takisremark,0) not in(-2) "
				+" and a.workflowid in(select id from workflow_base where (isvalid = '1' or isvalid = '3'))"
				+" and b.userid ="+userid;
		rs.executeSql(sql);
     	if(rs.next()){
	         hotnewsNumberOA = rs.getString("hotnewsNumber");

     	}
     	//查询统一待办流程
		sql = "select count(*) as ECNumber from ofs_todo_data where userid = '"+userid+"' and islasttimes=1 and isremark=0";
     	rs.executeSql(sql);
     	if(rs.next()){
	         	hotnewsNumberEC = rs.getString("ECNumber");
     	}
     	hotnewsNumberSum = Integer.parseInt(hotnewsNumberOA) + Integer.parseInt(hotnewsNumberEC);


     	//查询主从账号待办数量
     	String belongtoshow12 = "";
     	String idczh = "";
     	int hotnewsNumberOA_czh = 0;
     	int hotnewsNumberEC_czh = 0;
     	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
     	boolean isBelongtouser = false;
		RecordSet.executeSql("select count(1) from Hrmresource a where belongto="+userid+" and belongto > 0 and status<4");
		if(RecordSet.next()){
			if(RecordSet.getInt(1)>0){
				isBelongtouser = true;
			}
		} 
		RecordSet.executeSql("SELECT * FROM HrmUserSetting WHERE resourceId="+userid);
		if(RecordSet.next()){
			belongtoshow12 = Util.null2String(RecordSet.getString("belongtoshow"));
		}
     	if(flagaccount&&!user.getAccount_type().equals("1")&& isBelongtouser){
     		if(belongtoshow12.equals("1")){
	     		//查询从账号id
	     		RecordSet.executeSql("select id from Hrmresource a where belongto="+userid+" and belongto > 0 and status<4");
	     		while(RecordSet.next()){
	     			idczh = RecordSet.getString("id");

	     			sql=" select COUNT(a.requestid) hotnewsNumber from workflow_requestbase a,workflow_currentoperator b"
					+" where a.requestid = b.requestid and b.isremark not in(2,4,8,9) and b.islasttimes=1 "
					+"  and a.workflowid not in(641,13,1,2,3,4,9,741) and  nvl(b.takisremark,0) not in(-2) "
					+" and a.workflowid in(select id from workflow_base where (isvalid = '1' or isvalid = '3'))"
					+" and b.userid ="+idczh;
					rs.executeSql(sql);
			     	if(rs.next()){
				         hotnewsNumberOA_czh += Integer.parseInt(rs.getString("hotnewsNumber"));
			     	}


			     	//查询统一待办流程
					sql = "select count(*) as ECNumber from ofs_todo_data where userid = '"+idczh+"' and islasttimes=1 and isremark=0";
			     	rs.executeSql(sql);
			     	if(rs.next()){	
						//产品不支持异构系统次账号流程主账号显示	
				        //hotnewsNumberEC_czh += Integer.parseInt(rs.getString("ECNumber"));
			     	} 
	     		}

			
		     	hotnewsNumberSum = Integer.parseInt(hotnewsNumberOA) + Integer.parseInt(hotnewsNumberEC) +
		     						hotnewsNumberOA_czh + hotnewsNumberEC_czh;



			}
			
		}

		String lcNumber = "";
     	if(hotnewsNumberSum > 99){
     		lcNumber = "99+";
     	}else{
     		lcNumber = String.valueOf(hotnewsNumberSum) ;
    	}

		//=====================================待办数目 结束====================================================

     	
     	//系统导航
     	JSONArray navDivContent = new JSONArray();
     	sql = "select u.url,u.tbmc,b.title,c.imagefileid from uf_xtdh u left join uf_xtdh_dt1 b on u.id = b.mainid left join DocImageFile c on u.tp=c.docid where sffc = 0 order by u.px,u.id desc,u.url,u.tbmc,b.title,c.imagefileid ";
		rs.executeSql(sql);
		//out.print(sql);
		while(rs.next()){
		    String imageSrc ="background-image: url("+getImageFile(Util.null2String(rs.getString("imagefileid")))+");";
		    String name = rs.getString("tbmc");
			String url = rs.getString("url");
			JSONObject json = new JSONObject();
			json.put("imageSrc",imageSrc);
			json.put("name",name);
			json.put("url",url);
			navDivContent.put(json);
		}
		
		
		
		
		knowledge ="/gvo/ps/sendDocUrl.jsp?url="+KnowledgeSystemLink+"/OAProcess/OAWebSSO.ashx";
		metting = "/spa/meeting/static/index.html#/main/meeting/RoomPlan?canEdit=1";

		//V3控权新闻资讯和通知公告
		if(isV3){
			//V3新闻咨询和通知公告链接
			noticeSum = "/docs/search/DocSearchTab.jsp?urlType=16&eid=3453&tabid=1&date2during=0";
			companyNews = "/docs/search/DocSearchTab.jsp?urlType=16&eid=3448&tabid=1&date2during=0";
		} else {
			noticeSum = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2825&tabid=1&date2during=0";
			companyNews = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2800&tabid=1&date2during=0";
		}
		createNewRequest = "/workflow/request/RequestTypeShow.jsp?colnum4show=mulitcol&fromadvancedmenu=0&hrmid=3&usedtodo=-1";
		system = "/gvo/sendFor/sendDocUrl.jsp?url="+KnowledgeSystemLink+"/OAProcess/ECMPortalRedirect.ashx?method=zhidumenhu";
		todo = "/gvo/gateway/jsp/process.jsp";
		
		//维信诺科技控权质量通告更多
		if(isKvi==true){
			//质量通告集团旧版链接
			//qualityBulletin = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2825&tabid=1&date2during=0";
			qualityBulletin = "/docs/search/DocSearchTab.jsp?urlType=16&eid=17145&tabid=1&date2during=0";
		} else {
			qualityBulletin = "/formmode/search/CustomSearchBySimple.jsp?customid=33001";
		}	

		corporateCultureMore = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2798&tabid=3&date2during=0";
		employeeHelp = "/gvo/ps/sendPSUrl.jsp?url="+PSLink+"/psc/ps/EMPLOYEE/HRMS/s/WEBLIB_HPS_SSO.ISCRIPT1.FieldFormula.iScript_SSOHP";

		BaseBean bean = new BaseBean();
		Map param = new HashMap();
		param.put("user", user);
		DocumentInterface mdi =  new PageInterfaceFactory<DocumentInterface>().getImplementByInterface(DocumentInterface.class.getName());
		
		//公司新闻
		String companynewssec = "";
		if(isV3){
			//V3公司
			companynewssec = "266,272,1404,1406,1407,272,585,84,85,3366";
		} else {
			companynewssec = "266,272,1404,1406,1407,272,585,84,85";
		}

    	String companynewssize =  "5";
    	String companynewmore = "/docs/search/DocCommonContent.jsp?hasTab=1&officalType=-1&seccategory=266,167&urlType=6&loginType=1";
    	param.put("perpage", companynewssize);
    	param.put("pageIndex", 1);
    	param.put("docDirIds", companynewssec);
    	List companynewsList = mdi.getDocumentList(param);

    	//通知公告
    	String noticeBulletinSec = "";
		if(isV3){
			//V3公司
			noticeBulletinSec = "3365";
		} else {
			noticeBulletinSec =  "1327,1328,1329,81,271,584,86,3365";
		}
    	String noticeBulletinSize =  "5";
    	String noticeBulletinMore = "docs/search/DocCommonContent.jsp?hasTab=1&officalType=-1&seccategory=167&urlType=6&loginType=1";
    	param.put("perpage", noticeBulletinSize);
    	param.put("pageIndex", 1);
    	param.put("docDirIds", noticeBulletinSec);
    	List noticeBulletinList = mdi.getDocumentList(param);
    	
    	
    	
    	//最新文件
    	String regulationsBulletinSec = "";
    	String regulationsBulletinSize = "5";
    	String regulationsBulletinMore = "/formmode/custompage/CustomPageData.jsp?id=1"; //最新文件更多链接   

    	//获取最新文件数据
		JSONArray regulationsBulletin = new JSONArray();
		sql = "select filestatus,filenos,filename,lastoperatedate from vis_doc_file_update" +  
				" where rownum <=" + regulationsBulletinSize + " ";

		//out.print("sql"+sql);
		rs.executeSql(sql);
		while(rs.next()){
			String regultionsFileStatus = Util.null2String(rs.getString("filestatus"));//常用制度状态
			String regultionsFileNos = Util.null2String(rs.getString("filenos"));//常用制度编号
			String regultionsFileName = Util.null2String(rs.getString("filename"));//常用制度名
			String regultionsLastOperatedate = Util.null2String(rs.getString("lastoperatedate"));//常用制度归档日期

			JSONObject json = new JSONObject();
			
			json.put("regultionsFileStatus", regultionsFileStatus);//常用制度状态
			json.put("regultionsFileNos", regultionsFileNos);//常用制度编号		
			json.put("regultionsFileName", regultionsFileName);//常用制度名
			json.put("regultionsLastOperatedate", regultionsLastOperatedate);//常用制度归档日期
			
			regulationsBulletin.put(json);
			
		}



    		
		//品质公告->质量通告
		
    	//从OA系统获取数据  by likk 20190625
		String qualityBulletinSec =  "";
    	String qualityBulletinSize =  "";
    	String qualityBulletinMore = ""; 	
    	List qualityBulletinListOA = new ArrayList();
		JSONArray qualityBulletinListDCM = new JSONArray();
    	if(isKvi==true){
			qualityBulletinSec =  "13024";
	    	qualityBulletinSize =  "5";
	    	qualityBulletinMore = "/docs/search/DocSearchTab.jsp?urlType=16&eid=17145&tabid=1&date2during=0";
	    	param.put("perpage", qualityBulletinSize);
	    	param.put("pageIndex", 1);
	    	param.put("docDirIds", qualityBulletinSec);
	    	qualityBulletinListOA = mdi.getDocumentList(param);
	    	   		
    	}else{
	    	//从知识管理系统获取数据
	    	qualityBulletinSec = "";
	    	qualityBulletinSize = "5";
	    	qualityBulletinMore = "/formmode/search/CustomSearchBySimple.jsp?customid=33001"; //质量通告查询页面   
	
	    	//获取质量通告数据 by likk 20190625
			RecordSetDataSource docrs = new RecordSetDataSource("DOCSEC");
			sql = "select top " + qualityBulletinSize + " * from Sys_zltgfile sz order by sz.file_createTime desc";
	
			docrs.executeSql(sql);
			while(docrs.next()){
				String qualityBulletinFileID = Util.null2String(docrs.getString("file_id"));//文档ID
				String qualityBulletinFileName = Util.null2String(docrs.getString("filename1"));//质量通告文件名称
				String qualityBulletinFileCreateDate = Util.null2String(docrs.getString("file_createTime"));//质量通告文件创建日期
	
				JSONObject json = new JSONObject();
				
				json.put("qualityBulletinFileID", qualityBulletinFileID);//文档ID
				json.put("qualityBulletinFileName", qualityBulletinFileName);//质量通告文件名称	
				json.put("qualityBulletinFileCreateDate", qualityBulletinFileCreateDate);//质量通告文件创建日期
				qualityBulletinListDCM.put(json);
				
			}    	
    	}

    	//获取新手指南数据
		String newGuideSec =  "";
    	String newGuideSize =  "";
    	String newGuideMore = ""; 	
    	List newGuideList = new ArrayList();
    	newGuideSec =  "2404";
		newGuideSize =  "5";
		newGuideMore = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2649&tabid=4&date2during=0";
    	param.put("perpage", newGuideSize);
    	param.put("pageIndex", 1);
    	param.put("docDirIds", newGuideSec);
    	newGuideList = mdi.getDocumentList(param); 	  	
    	

    	
		
		//热点新闻目录
		String hotNewsSec =  "3304";
    	String hotNewsSize =  "3";
    	String hotNewsMore = "docs/search/DocCommonContent.jsp?hasTab=1&officalType=-1&seccategory=167&urlType=6&loginType=1";
    	param.put("perpage", hotNewsSize);
    	param.put("pageIndex", 1);
    	param.put("docDirIds", hotNewsSec);
    	List hotNewsList = mdi.getDocumentList(param);
   


    	//获取换肤的图片预览
		JSONArray background = new JSONArray();
		sql = " select uf_get.bjtpmc, uf_get.bjtpms,uf_get.scr,uf_get.bjtp, uf_get.sfqy,doc.imagefileid"+ 
					" from uf_geyBackgroundImg  uf_get, DocImageFile doc "+
					" where sfqy=0 and (scr = 1 or scr = "+userid+") and doc.docid = uf_get.bjtp "+
					" order by uf_get.id desc";


		rs.executeSql(sql);
		while(rs.next()){
			String bjtpmc  = Util.null2String(rs.getString("bjtpmc"));//背景图片名称
			String imagefileid  = getImageFile(Util.null2String(rs.getString("imagefileid")));//图片地址
			//String imageSrc ="background-image: url("+getImageFile(Util.null2String(rs.getString("imagefileid")))+");";

			JSONObject json = new JSONObject();
			
			json.put("bjtpmc", bjtpmc);//背景图片地址
			json.put("imagefileid", imagefileid);//图片地址
			background.put(json);
		}

		//背景图片
		String imageSrc = "";
		sql = " select backgroundSrc from uf_setBackground where hrmid="+userid;
		rs.executeSql(sql);	
		if(rs.next()){
			imageSrc  = rs.getString("backgroundSrc");//图片地址
		}
		
		//获取配置文件中门户配置情况
		String portalConfig = "VisionoxPortalSetting";
		String isCultureMX = prop.getPropValue(portalConfig , "isCultureMX");  //企业文化显示格式配置
		
    	//获取企业文化数据---从文档获取
		String newCultureSec =  "";
    	String newCultureSize =  "";
    	String newCultureMore = ""; 	
    	List newCultureList = new ArrayList();
    	newCultureSec =  "281";
		newCultureSize =  "5";
		newCultureMore = "/docs/search/DocSearchTab.jsp?urlType=16&eid=2798&tabid=3&date2during=0";
    	param.put("perpage", newCultureSize);
    	param.put("pageIndex", 1);
    	param.put("docDirIds", newCultureSec);
    	newCultureList = mdi.getDocumentList(param);
	    	
		//企业文化--从表单建模获取
		String corporateCulture = "";
		sql = "select qyywhnr from uf_corporatecultur where sfqy = 0 and sfqy = 0 and rownum=1";
		rs.executeSql(sql);	
		if(rs.next()){
			corporateCulture  = rs.getString("qyywhnr");//图片地址
		} 

		
		//侧边栏菜单(安卓)
		JSONArray android = new JSONArray();
		sql = "select Name,src from   uf_sideMenu where cdmc = 1 and sfqy = 0 and rownum=1 ";
		rs.executeSql(sql);	
		if(rs.next()){
			String androidName  = rs.getString("Name");//图片地址
			String androidSrc  = rs.getString("src");//图片地址
			
			JSONObject json = new JSONObject();

			json.put("androidName", androidName);//背景图片地址
			json.put("androidSrc", androidSrc);//图片地址
			android.put(json);
		} 

		//侧边栏菜单(微信)
		JSONArray weChat = new JSONArray();
		sql = "select Name,src from   uf_sideMenu where cdmc = 2 and sfqy = 0 and rownum=1 ";
		rs.executeSql(sql);	
		if(rs.next()){
			String weChatName  = rs.getString("Name");//图片地址
			String weChatSrc  = rs.getString("src");//图片地址
			
			JSONObject json = new JSONObject();

			json.put("androidName", weChatName);//背景图片地址
			json.put("androidSrc", weChatSrc);//图片地址
			weChat.put(json);
		} 
		//侧边栏菜单(微信公众号)
		JSONArray publicNumber = new JSONArray();
		sql = "select Name,src from uf_sideMenu where cdmc = 0 and sfqy = 0 and  rownum=1 ";
		rs.executeSql(sql);	
		if(rs.next()){
			String publicNumberName  = rs.getString("Name");//图片地址
			String publicNumberSec  = rs.getString("src");//图片地址
			
			JSONObject json = new JSONObject();

			json.put("androidName", publicNumberName);//背景图片地址
			json.put("androidSrc", publicNumberSec);//图片地址
			publicNumber.put(json);
		} 
		
		//EC流程
		JSONArray ECLC = new JSONArray();
		String ecworkcode = "";
		String ecid = "";
		String logintype = user.getLogintype();
		int usertype = 0;
		if(logintype.equals("2")){
    		usertype = 1;
    	}

    	sql = " select workcode from hrmresource where id='"+userid+"'";
    	rs.executeSql(sql);	
		if(rs.next()){
			ecworkcode  = rs.getString("workcode");//地址
		}

		sql = " select id from hrmresource where workcode='"+ecworkcode+"'";
    	rsx.executeSql(sql);	
		if(rsx.next()){
			ecid  = rsx.getString("id");//地址
		}
    	Calendar today = Calendar.getInstance();
			String currentdate = Util.add0(today.get(Calendar.YEAR), 4) + "-" +
                         Util.add0(today.get(Calendar.MONTH) + 1, 2) + "-" +
                         Util.add0(today.get(Calendar.DAY_OF_MONTH), 2) ;
			String currenttime = Util.add0(today.get(Calendar.HOUR_OF_DAY), 2) + ":" +
                         Util.add0(today.get(Calendar.MINUTE), 2) + ":" +
                         Util.add0(today.get(Calendar.SECOND), 2) ;
    	String agentWfcrtSqlWhere = shareManager.getWfShareSqlWhere(user, "t1");
    	sql = " select a.wfid,b.workflowname from "
    	+ " (SELECT * FROM (select (case when workflow_base.activeversionid is not null then workflow_base.activeversionid else workflow_base.id end) as wfid,WorkflowUseCount.userid,sum(count) as count from WorkflowUseCount inner join "
    	+" workflow_base on workflow_base.id = WorkflowUseCount.wfid " +
                                                      " where WorkflowUseCount.userid ="+ecid+" and (wfid in(select t2.id as workflowid from  ShareInnerWfCreate t1,workflow_base t2 where t1.workflowid=t2.id and t2.isvalid in ('1', '3') and (t2.activeversionid is null or exists (select 1 from workflow_base t3 where t2.activeversionid = t3.id and t3.isvalid = '1')) and t1.usertype = " + usertype+ " and " + agentWfcrtSqlWhere + " union all select t1.id as workflowid from workflow_agentConditionSet t,workflow_base t1 where exists (select * from HrmResource b where t.bagentuid=b.id and b.status<4) and (t1.activeversionid is null or exists (select 1 from workflow_base t3 where t1.activeversionid = t3.id and t3.isvalid = '1')) and  t.workflowid=t1.id and t.agenttype>'0' and t.iscreateagenter=1 and t.agentuid="+ecid+" and ((t.beginDate||t.beginTime||':00'<='"+currentdate+currenttime+"' and t.endDate||t.endTime||':00'>='"+currentdate+currenttime+"'))or(t.beginDate || t.beginTime='' and (t.endDate='' or t.endTime = '')))) " + 
                                                      " group by (case when workflow_base.activeversionid is not null then workflow_base.activeversionid else workflow_base.id end) ,WorkflowUseCount.userid " +
                                                      " order by count desc) WHERE ROWNUM <= 18 ORDER BY ROWNUM ASC )"
            +" a,workflow_base b where a.wfid = b.id ";
        rsx.executeSql(sql);
        while(rsx.next()){
		String wfid  = rsx.getString("wfid");//流程id
		String workflowname  = rsx.getString("workflowname");//流程id	

			JSONObject json = new JSONObject();
			
			json.put("wfid", wfid);
			json.put("workflowname", workflowname);

			ECLC.put(json);
		} 

		//OA流程
		JSONArray OALC = new JSONArray();
		sql = " select a.wfid,b.workflowname from "
    	+ " (SELECT * FROM (select (case when workflow_base.activeversionid is not null then workflow_base.activeversionid else workflow_base.id end) as wfid,WorkflowUseCount.userid,sum(count) as count from WorkflowUseCount inner join "
    	+" workflow_base on workflow_base.id = WorkflowUseCount.wfid " +
                                                      " where WorkflowUseCount.userid ="+userid+" and (wfid in(select t2.id as workflowid from  ShareInnerWfCreate t1,workflow_base t2 where t1.workflowid=t2.id and t2.isvalid in ('1', '3') and (t2.activeversionid is null or exists (select 1 from workflow_base t3 where t2.activeversionid = t3.id and t3.isvalid = '1')) and t1.usertype = " + usertype+ " and " + agentWfcrtSqlWhere + " union all select t1.id as workflowid from workflow_agentConditionSet t,workflow_base t1 where exists (select * from HrmResource b where t.bagentuid=b.id and b.status<4) and (t1.activeversionid is null or exists (select 1 from workflow_base t3 where t1.activeversionid = t3.id and t3.isvalid = '1')) and  t.workflowid=t1.id and t.agenttype>'0' and t.iscreateagenter=1 and t.agentuid="+userid+" and ((t.beginDate||t.beginTime||':00'<='"+currentdate+currenttime+"' and t.endDate||t.endTime||':00'>='"+currentdate+currenttime+"'))or(t.beginDate || t.beginTime='' and (t.endDate='' or t.endTime = '')))) " + 
                                                      " group by (case when workflow_base.activeversionid is not null then workflow_base.activeversionid else workflow_base.id end) ,WorkflowUseCount.userid " +
                                                      " order by count desc) WHERE ROWNUM <= 18 ORDER BY ROWNUM ASC )"
            +" a,workflow_base b where a.wfid = b.id ";
        rs.executeSql(sql);
        while(rs.next()){
			String wfid  = rs.getString("wfid");//流程id
			String workflowname  = rs.getString("workflowname");//流程id	

			JSONObject json = new JSONObject();
			
			json.put("wfid", wfid);
			json.put("workflowname", workflowname);
			
			OALC.put(json);
		}

		//轮播图（第一版三张图）
		JSONArray SowingMap = new JSONArray();
		sql = "select * from (select doc.imagefileid,slider.url from uf_newsslider slider, DocImageFile  doc where "
			+" slider.image = doc.docid  and slider.sfqy = 0  order by sx asc,slider.id desc) where rownum<=3 ";
		rs.executeSql(sql);

		//out.print(sql);
		while(rs.next()){
			String imagefileid  = rs.getString("imagefileid");//图片地址
			String url  = rs.getString("url");//链接地址
			
			JSONObject json = new JSONObject();

			json.put("imagefileid", imagefileid);//图片地址
			json.put("url", url);//链接地址
			SowingMap.put(json);
		} 


		//轮播图修改（第二版 多张进行切换）
		JSONArray SowingMap_v2 = new JSONArray();
		sql =	"select doc.imagefileid,slider.url "+
				"from uf_newsslider slider, DocImageFile  doc "+
				"where slider.image = doc.docid  and slider.sfqy = 0 "+ 
				"order by sx asc,slider.id desc ";
		rs.executeSql(sql);

		//out.print(sql);
		while(rs.next()){
			String imagefileid  = rs.getString("imagefileid");//图片地址
			String url  = rs.getString("url");//链接地址
			if("".equals(url)){//url为空时，不做链接
				url = "###";
			}

			
			JSONObject json = new JSONObject();

			json.put("imagefileid", imagefileid);//图片地址
			json.put("url", url);//链接地址
			
			SowingMap_v2.put(json);
		} 


		//out.print(SowingMap_v2);

		

	%>
