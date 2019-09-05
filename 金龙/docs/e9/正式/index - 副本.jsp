<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.conn.*"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="java.util.regex.Matcher,java.util.regex.Pattern" %>
<%@ page import="java.util.Map,java.util.HashMap,java.util.Hashtable,java.util.List,java.util.ArrayList" %>
<%@ page import="weaver.docs.pdf.docpreview.ConvertPDFUtil"%>
<%@ page import="weaver.docs.pdf.docpreview.ConvertPDFTools" %>
<%@ page import="com.api.doc.detail.service.DocDetailService"%>
<%@ page import="weaver.docs.category.SecCategoryDocPropertiesComInfo"%>
<%@ page import="weaver.docs.category.SecCategoryComInfo"%>
<%@ page import="weaver.docs.mould.MouldManager"%>
<%@ page import="weaver.systeminfo.SystemEnv"%>
<%@ page import="com.api.doc.detail.service.DocViewPermission"%>
<%@ page import="weaver.docs.category.security.MultiAclManager"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.api.doc.search.util.DocSptm"%>
<%@page import="com.api.doc.category.service.CategoryService"%>
<%@page import="com.api.doc.detail.service.DocSaveService"%>
<%@ page import="com.api.doc.detail.util.ImageConvertUtil"%>
<%@page import="com.engine.doc.util.IWebOfficeConf"%>
<%@page import="com.engine.hrm.biz.HrmClassifiedProtectionBiz"%>
<%@ page import="com.engine.doc.util.DocPlugUtil" %>
<%@ page import="com.api.doc.detail.util.DocDetailUtil" %>
<%@ page import="org.apache.xpath.operations.Bool" %>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page"/>
<jsp:useBean id="DocPreviewHtmlManager" class="weaver.docs.docpreview.DocPreviewHtmlManager" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="DocMouldComInfo" class="weaver.docs.mouldfile.DocMouldComInfo" scope="page" />


<%
	response.setHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    User user = null;
    if("1".equals(request.getParameter("outNews"))){
    	user = new User();
    }else{
    	user = HrmUserVarify.getUser (request , response);
		if(user==null){
			response.sendRedirect("/wui/index.html");
			return ;
		}
    }
   	int languageid = user == null ? DocSptm.getDefaultLanguage() : user.getLanguage();
    
    long time0 = 0;
    long time1 = 0;
    long time2 = 0;
    long time3 = 0;
    
	Date d0 = new Date();

    // 文档ID
    int docid = Util.getIntValue(request.getParameter("id"),-1);
    int secid = Util.getIntValue(request.getParameter("secid"),-1);	//目录id
    boolean isEdit = "1".equals(request.getParameter("isEdit"));	//是否是新建或者编辑
    boolean isEditOffice = "1".equals(request.getParameter("isOffice")); //是否是 office
    boolean isCAPDF = "1".equals(request.getParameter("isCAPDF")); //是否使用北京capdf插件
    String officeType = request.getParameter("officeType"); //新建office类型
    
    int imagefileId = Util.getIntValue(request.getParameter("imagefileId"),-1);
    int versionId = Util.getIntValue(request.getParameter("versionId"),-1);
	Boolean docisLock = DocDetailUtil.isopendoclock(docid+"","doc");

    
    String _convertFile = Util.null2String(request.getParameter("convertFile"));
    BaseBean baseBean = new BaseBean();

    
    String checkOutStatus = "";
    int checkOutUserId = -1;
    String checkOutUserType = "";
    
    /*** 其他模块跳转过来的时候，不带路由，这里统一加上 ***/
    String router = request.getParameter(DocSptm.DOC_ROOT_FLAG);
    if(router == null){
	  %>
	 <script>
	 	var _href = location.href;
	 	if(_href.indexOf("#/main/document/detail") == -1 && _href.indexOf("#/main/document/edit") == -1){
	 		location.href = _href + "&<%=DocSptm.DOC_ROOT_FLAG%>=1" + "#/main/document/" + "<%=isEdit ? "edit" : "detail"%>";
	 	}else{
	 		location.href = _href.replace("#/main/document/detail","&<%=DocSptm.DOC_ROOT_FLAG%>=1#/main/document/detail")
	 							.replace("#/main/document/edit","&<%=DocSptm.DOC_ROOT_FLAG%>=1#/main/document/edit");
	 	}
	 </script>
	  
	  <%
	  return;
    }
    
    //流程新建完成，关闭当前页面
    String blnOsp = request.getParameter("blnOsp");
    String moudleFrom = request.getParameter("moudleFrom");
    if(!isEdit && !"1".equals(blnOsp) && 
    		("workflow".equals(moudleFrom) || "cube".equals(moudleFrom) || "task".equals(moudleFrom))){
    	RecordSet rs = new RecordSet();
    	rs.executeQuery("select docsubject,docstatus from docdetail where id=" + docid);
    	String docsubject = "";
    	String docstatus = "";
    	if(rs.next()){
    		docsubject = rs.getString("docsubject").replaceAll("'","\'").replaceAll("\n", "");
    		docstatus = rs.getString("docstatus");
    	}

    	/*if("1".equals(docstatus)){*/
	    	%>
	    		<script>
		    		try{
		    			if(opener && opener.__createDocFn){
							opener.__createDocFn({docid : "<%=docid%>",docSubject : "<%=docsubject%>"});
			   	  		}
		    		}catch(e){
					}finally{
                        window.close();
					}
	    		</script>
	    	<%
	    	return;
    	/*}*/
    }
    // 附件版本ID
    if(docid < 0 && imagefileId < 0 && !isEdit)
    {
        response.sendRedirect("/notice/noright.jsp?line=1") ;
        return ;
    }
    
    
    if(docid <= 0 && imagefileId > 0){
    	RecordSet rs = new RecordSet();
    	rs.executeQuery("select docid,versionId from DocImageFile where imagefileid=" + imagefileId + (versionId > 0 ? (" and versionid=" + versionId) : ""));
    	if(rs.next()){
    		docid = rs.getInt("docid");
    		versionId = rs.getInt("versionId");
    	}
    	if(docid < 0){
    		response.sendRedirect("/notice/noright.jsp?line=2") ;
    	    return ;
    	}
    }
    
    Map<String,String> rightParams = new HashMap<String,String>(); 
    rightParams.put("useNew","1");
    
    boolean canEdit = false;
    DocViewPermission dvps = new DocViewPermission();
    
  	//其他模块参数集
    String moudleParams = dvps.getMoudleParams(request);
  	
    if(docid > 0){ //密级判断
    	if(!dvps.hasRightForSecret(user,docid)){
    		response.sendRedirect("/notice/noright.jsp?secretNotEnough=1") ;
    		return;
    	}
    }
  	
    Map<String,Boolean> levelMap = dvps.getShareLevel(docid,user,false);
    if(!levelMap.get(DocViewPermission.READ)){ //知识没有权限，判断是否是其他模板
    	levelMap.put(DocViewPermission.READ,dvps.hasRightFromOtherMould(docid,user,request));
    }
    if(!levelMap.get(DocViewPermission.EDIT)){ //知识没有权限，判断是否是其他模块
    	dvps.hasEditRightFromOtherMould(docid,levelMap,user,request);
    }
    canEdit = levelMap.get(DocViewPermission.EDIT);
    
  	//判断浏览器类型，版本，多少位
    String agent = request.getHeader("user-agent");
    //如果非IE
    boolean canIWebOffice = true;
    boolean isIE = true;
    if((agent.contains("Firefox")||agent.contains(" Chrome")||agent.contains("Safari") )|| agent.contains("Edge")){
    	canIWebOffice = false;
    	isIE = false;
    }
    
    boolean useYozoView = false;
    if(!canIWebOffice || agent.indexOf(" like Gecko") > -1){ //非IE或者ie11以上
    	useYozoView = true;
    }
    if(useYozoView){
    	useYozoView = ImageConvertUtil.canEditForYozo("doc",user);
    }
    
    //文件类型
    int docfileType = -1;
    //OFD页面跳转地址
    String ofdContent = "";
	//new BaseBean().writeLog("docid=======================================" + docid);
    if(docid>0 && imagefileId>0){
    	RecordSet rs = new RecordSet();
    	rs.executeQuery("select docfiletype,versionId from docimagefile where docid=? and imagefileid=?",docid,imagefileId);
    	if(rs.next()){
    		docfileType = Util.getIntValue(rs.getString(1), -1);
    		versionId = versionId<=0 ? Util.getIntValue(rs.getString(2), -1) : versionId;
    	}
    }else if(docid>0){
    	RecordSet rs = new RecordSet();
    	rs.executeQuery("select imagefileid,docfiletype from docimagefile where docid=? and docfiletype = 13",docid);
    	if(rs.next()){
    		docfileType = rs.getInt("docfiletype");
			imagefileId = rs.getInt("imagefileid");
    	}
		
	}
	if(!canIWebOffice){
		//canIWebOffice = IWebOfficeConf.canIwebOffice();
		canIWebOffice = IWebOfficeConf.canIwebOffice(agent,null);
	}
    if(docfileType == 13){
        if(!canIWebOffice)
		{
			ofdContent = "<iframe src=\"/docs/ofd/sysRemind.jsp?labelid=666\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
		}else {
			Boolean editCan=levelMap.get(DocViewPermission.EDIT);
			if (!editCan){
				RecordSet rs = new RecordSet();
				RecordSet rss = new RecordSet();
				rs.executeQuery("select d.docstatus from DocDetail d " +
						" where d.id=" + docid);
				String docstatus = "-1";
				if(rs.next()){
					docstatus = Util.null2String(rs.getString("docstatus"));

				}
				if ("9".equals(docstatus)){
					editCan=true;
				}
			}
			String requestid = Util.null2String(request.getParameter("requestid"));
			ofdContent = "<iframe id=\"ofdshow\" src=\"/docs/ofd/OfdShow.jsp?docid="+docid+"&imagefileId="+imagefileId+"&isEdit="+editCan+"&requestId="+ requestid +"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
		}

	}
    
    if(isEdit){
    	
    	
    	if(docid > 0){  //编辑
	    	RecordSet rs = new RecordSet();
    		rs.executeQuery("select doctype,docextendname,checkOutStatus,checkOutUserId,checkOutUserType from DocDetail where id=" + docid);
        	if(rs.next()){
        		String doctype = rs.getString("doctype");
       			String docextendname = "." + rs.getString("docextendname");
       			checkOutStatus = rs.getString("checkOutStatus");
    			checkOutUserId = rs.getInt("checkOutUserId");
    			checkOutUserType = rs.getString("checkOutUserType");
    			if(checkOutStatus!=null&&(checkOutStatus.equals("1")||checkOutStatus.equals("2"))&&!(checkOutUserId==user.getUID()&&checkOutUserType!=	null&&checkOutUserType.equals(user.getLogintype()))){
    				//签出状态的文档，跳转详情页
    				response.sendRedirect(DocSptm.DOC_DETAIL_LINK + "?id=" + docid + "&warmMessageStatus=checkout" + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE + DocSptm.DOC_DETAIL_ROUT) ;
    				return;
    			}
				RecordSet rs1 = new RecordSet();
				rs1.executeQuery("select imagefileid,docfiletype from docimagefile where docid=? and docfiletype = 12 ",docid);
				String docfiletype = "";
				String imagefileid = "";
				if(rs1.next()){
				    docfiletype = rs1.getString("docfiletype");
				    imagefileid = rs1.getString("imagefileid");
				}
        		if("2".equals(doctype) && !".pdf".equals(officeType)){
        			if(!canIWebOffice && !useYozoView){
        				response.sendRedirect(DocSptm.DOC_DETAIL_LINK + "?id=" + docid + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE + DocSptm.DOC_DETAIL_ROUT) ;
        				return;
        			}else if(!isEditOffice || !docextendname.equals(officeType)){
    	    			response.sendRedirect(DocSptm.DOC_EDIT_LINK + "?id=" + docid + "&isOffice=1&isEdit=1&officeType=" + docextendname + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE + DocSptm.DOC_EDIT_ROUT) ;
    	    			return;
        			}
        		}else if("12".equals(docfiletype) && DocPlugUtil.isopenbjca() && DocPlugUtil.isIE(request)){
				    if(!isEditOffice || !docextendname.equals(officeType) || !isCAPDF){
						response.sendRedirect(DocSptm.DOC_EDIT_LINK + "?id=" + docid + "&isCAPDF=1&isOffice=1&isEdit=1&officeType=" + docextendname + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE + DocSptm.DOC_EDIT_ROUT) ;
						return;
					}
				} else{
					isCAPDF = false;
        			isEditOffice = false;
        		}

        	}


    		canEdit = levelMap.get(DocViewPermission.EDIT);
    	}else if(secid > 0){//新增
    		MultiAclManager am = new MultiAclManager();
    		canEdit = am.hasPermission(secid, MultiAclManager.CATEGORYTYPE_SEC, user.getUID(), user.getType(), 
    				Integer.parseInt(user.getSeclevel()), MultiAclManager.OPERATION_CREATEDOC);
    	}else{
    		canEdit = true;
    	}
    	String requestDoc = Util.null2String(request.getParameter("requestDoc"));

		if(requestDoc.equals("1")){
			canEdit = true;
		}
	    if(!canEdit){
	    	response.sendRedirect("/notice/noright.jsp?line=3") ;
	    	return ;
	    }
	    //增加到常用目录
	    CategoryService categoryService = new CategoryService();
	    categoryService.addCommonUse(secid,user);
    }
    
    boolean canRead = false;
    /**判断文档查看权限*/
    if(!isEdit && docid > 0){
    	canRead = levelMap.get(DocViewPermission.READ);
    }
    
    
    if(!isEdit && !canRead){   //没有权限
    	RecordSet rs = new RecordSet();
    	rs.executeQuery("select ishistory,doceditionid from DocDetail where id=" + docid);
    	int ishistory = 0;
    	int doceditionid = 0;
    	if(rs.next()){
    		ishistory = rs.getInt("ishistory");
    		doceditionid = rs.getInt("doceditionid");
    	}
    	if(ishistory != 1){  //不是历史文档
	    	response.sendRedirect("/notice/noright.jsp?line=4") ;
    	}else{
    		int newestid = 0;
    		
    		rs.executeQuery("select id from DocDetail where doceditionid = " + doceditionid + " and ishistory=0 and id<>"+docid+"  order by docedition desc ");
    		if(rs.next()){
    			newestid = rs.getInt("id");
    		}
    		
    		if(newestid <= 0 || newestid == docid){
    			response.sendRedirect("/notice/noright.jsp?line=5") ;
    	    	return ;
    		}
    		
    		String linkNewestDoc = DocSptm.DOC_DETAIL_LINK + "?id=" + newestid + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE+DocSptm.DOC_DETAIL_ROUT;
    		%>
    		<html>
    		<head>
    		<script language=javascript>
    			if(confirm("<%=SystemEnv.getHtmlLabelName(20300,languageid)%><%=SystemEnv.getHtmlLabelName(19986,languageid)%>")) {
					location="<%=linkNewestDoc%>";
		        }else{
					location="/notice/noright.jsp??line=6";
				}
    		</script>
    		</head>
    		<body></body>
    		</html>
    		<%
    	}
    	return;
	}


	if(docisLock && levelMap.get(DocViewPermission.EDIT)){
		docisLock = false;
	}
    
    Date d1 = new Date();
    time0 = d1.getTime() - d0.getTime();
    
    
    // 标题
    String docsubject = "";
    //最后修改人id
    int doclastmoduserid = 0;
	// 最后修改人
	String username = "";
    // 修改日期+时间
    String modifyDate = "";
    // 修改日期
    String doclastmoddate = "";
    // 修改时间
    String doclastmodtime = "";
    // 加载内容
    String docContent = "";
    // 文档类型
    int doctype = -1;   
    //文档目录
    int seccategory = -1;
    //文档状态
    String docstatus = "0"; 
    //失效日期
    String invalidationdate = ""; 
    //文档所属部门
    String docdepartmentid = ""; 
    //是否是历史文档
    int ishistory = -1; 
    //版本号
    int doceditionid = -1;
    //最新版本id
    int newestid = -1;
    //新闻模板
    int selectedpubmouldid = -1; 
    //创建人
    int doccreaterid = -1;
    //创建人类型
    String usertype = "";
    //创建日期
    String doccreatedate = "";
    // 文档语言
    int doclangurage = 7;
    //文档编号
    String docCode = "";
    //回复文档id
    int replydocid = 0;
    //审批日期
    String docapprovedate = "";
    //发布类型
    String docpublishtype = "";
    //关键字
	String keyword = "";
	//摘要
	String docMain = "";
	//密级
	String secretLevel = "";

    String prevname = SystemEnv.getHtmlLabelName(156,languageid);
    String imagefilename = "";
    
    boolean isOpenAcc = false; // 是否单附件打开
    String OpenAccOfFileid = "";   //单附件打开的附件id
    String OpenAccOfFilename = "";   //单附件打开的附件名称
    String OpenAccOfFiletype = "";   //单附件打开的附件类型
    String OpenAccOfVersionid = "";   //单附件打开的附件版本
    int OpenAccOfFileSize = 0;  //单附件打开的附件大小
    boolean isAutoExtendInfo = false;  //有附件时展开文档附件属性
	String OpenAccOfcomefrom = "";   //单附件打开的附件来源
	boolean showByHtml = false;  //是否是html模式展示
	String convertFile = "";  //转换文件  空-不转换，html-转成html，pdf-转成pdf
    
    
	boolean canPrint = dvps.getPrint(docid,user,levelMap,null);
	boolean canDownload = levelMap.get(DocViewPermission.DOWNLOAD);
	String moudlePictureIds = "";
    //选择显示模版的ID
    String selectedpubmould = Util.null2String(request.getParameter("selectedpubmould")); 
    
    if(isEdit){
    	
    }else if(imagefileId > 0){
    	
    }else{
    	
	    List<String> columns = new ArrayList<String>();
	    columns.add("doctype");   
	    columns.add("seccategory");
	    columns.add("docstatus");
	    columns.add("invalidationdate");
	    columns.add("docdepartmentid");
	    columns.add("ishistory");
	    columns.add("doceditionid");
	    columns.add("selectedpubmouldid");
	    columns.add("doccreaterid");
	    columns.add("usertype");
	    columns.add("doccreatedate");
	    columns.add("doclangurage");
	    columns.add("docCode");
	    columns.add("replydocid");
	    columns.add("docapprovedate");
	    columns.add("docpublishtype");
	    columns.add("checkOutStatus");
	    columns.add("checkOutUserId");
	    columns.add("checkOutUserType");
		columns.add("keyword");
		columns.add("secretLevel");
//		columns.add("docMain");
	    DocDetailService detailService = new DocDetailService();
	    Map<String,Object> baseInfo = detailService.getBasicInfoNoRight(docid,user,columns);
		Date d2 = new Date();
		time1 = d2.getTime() - d1.getTime();
	    if(baseInfo != null && baseInfo.get("data") != null){
		    Map data = (Map)baseInfo.get("data");
		   
		    docsubject = Util.null2String(data.get("docSubject").toString(),"");
		    doclastmoduserid = Util.getIntValue(data.get("doclastmoduserid").toString(),0);
		    username = Util.null2String(data.get("doclastmoduser").toString(),"");
		    modifyDate = Util.null2String(data.get("doclastmoddatetime").toString(),"");
		    doclastmoddate = Util.null2String(data.get("doclastmoddate").toString(),"");
		    doclastmodtime = Util.null2String(data.get("doclastmodtime").toString(),"");
		    doctype = Util.getIntValue(data.get("doctype").toString(),-1);
		    seccategory = Util.getIntValue(data.get("seccategory").toString(),-1);
		    docstatus = Util.null2String(data.get("docstatus").toString(),"");
		    invalidationdate = Util.null2String(data.get("invalidationdate").toString(),"");
		    docdepartmentid = Util.null2String(data.get("docdepartmentid").toString(),"");
		    ishistory = Util.getIntValue(data.get("ishistory").toString(),-1);
		    doceditionid = Util.getIntValue(data.get("doceditionid").toString(),-1);
		    selectedpubmouldid = Util.getIntValue(data.get("selectedpubmouldid").toString(),-1);
		    doccreaterid = Util.getIntValue(data.get("doccreaterid").toString(),-1);
		    usertype = Util.null2String(data.get("usertype").toString(),"");
		    doccreatedate = Util.null2String(data.get("doccreatedate").toString(),"");
		    doclangurage = Util.getIntValue(data.get("doclangurage").toString(),7);
		    docCode = Util.null2String(data.get("docCode").toString(),"");
		    doclangurage = Util.getIntValue(data.get("replydocid").toString(),0);
		    docapprovedate = Util.null2String(data.get("docapprovedate").toString(),"");
		    docpublishtype = Util.null2String(data.get("docpublishtype").toString(),"");
		    checkOutUserId = Util.getIntValue(data.get("checkOutUserId").toString(),-1);
		    checkOutUserType = Util.null2String(data.get("checkOutUserType").toString(),"");
			keyword = Util.null2String(data.get("keyword").toString(),"");
			docMain = Util.null2String(data.get("docMain").toString(),"");
			secretLevel = Util.null2String(data.get("secretLevel").toString(),"");
	    }
	    
	    RecordSet rs = new RecordSet();
        rs.executeSql("select isOpenAttachment,isAutoExtendInfo from docseccategory where id=" + seccategory);
        if(rs.next()){ 
        	if("1".equals(rs.getString("isOpenAttachment")) && doctype == 1){ //目录是否开启单附件打开
        		isOpenAcc = true;
        	}
        	isAutoExtendInfo = "1".equals(rs.getString("isAutoExtendInfo"));
        }
        
	    //html文档
	    if(doctype == 1){
	    	docContent = detailService.getDocContent(docid,user);
			Date d3 = new Date();
			time2 = d3.getTime() - d2.getTime();
	    	//if(contentMap != null && contentMap.get("data") != null){
	    	//	Map data = (Map)contentMap.get("data");
		    //	docContent = Util.null2String(data.get("doccontent"));
	    	//}
	    	
	        if(DocDetailService.ifContentEmpty(docContent)){
	            //根据目录判断是否单附件直接打开,附件类型是不是word,excel,pdf，ppt
	           
	            if(isOpenAcc){  //目录是否开启单附件打开

		            rs.executeSql("select a.id,a.imagefileid,a.imagefilename,a.docfiletype,a.versionId,b.filesize,b.comefrom from docimagefile a,imagefile b " +
		            		" where a.imagefileid=b.imagefileid and a.docid=" + docid + " order by versionid desc");
		            String id = "";
		            int fileCount = 0;
		            while(rs.next()){   //是否是单附件
		            	fileCount++;
		            	if("".equals(id)){
		            		id = rs.getString("id");
		            		OpenAccOfFileid = rs.getString("imagefileid");
		            		OpenAccOfFilename = rs.getString("imagefilename");
		            		OpenAccOfFiletype = rs.getString("docfiletype");
		            		OpenAccOfVersionid = rs.getString("versionId");
		            		OpenAccOfFileSize = rs.getInt("filesize");
							OpenAccOfcomefrom = rs.getString("comefrom");
		            	}
		            	if(!id.equals(rs.getString("id"))){
		            		isOpenAcc = false;
		            	}

		            }
					if(fileCount == 0){
						isOpenAcc = false;
					}

	            }


	        }else{
	        	isOpenAcc = false;
	        }
	        
			if(!isOpenAcc){
				showByHtml = true;
	        	SecCategoryDocPropertiesComInfo scdpc = new SecCategoryDocPropertiesComInfo();

	        	int docmouldid = -1;

	        	if(scdpc.getDocProperties(""+seccategory,"10") && "1".equals(scdpc.getVisible())){
	        		rs.executeSql("select t1.* from DocSecCategoryMould t1 right join DocMould t2 on t1.mouldId = t2.id where t1.secCategoryId = "+seccategory+" and t1.mouldType=1 order by t1.id");
	        		int selectMouldType = 0;
	        		int selectDefaultMould = 0;
	        		while(rs.next()){
	       				String moduleid=rs.getString("mouldId");
	       				String modulebind = rs.getString("mouldBind");
	       				int isDefault = Util.getIntValue(rs.getString("isDefault"),0);

	       				if(invalidationdate !=null && !"".equals(invalidationdate)){

	       					if(Util.getIntValue(modulebind,1)==3){
	       					    selectMouldType = 3;
	       					    selectDefaultMould = Util.getIntValue(moduleid);
	       				    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
	       				        if(selectMouldType==0){
	       					        selectMouldType = 1;
	       						    selectDefaultMould = Util.getIntValue(moduleid);
	       				        }
	       				    }

	       				} else {

	       					if(Util.getIntValue(modulebind,1)==2){
	       					    selectMouldType = 2;
	       					    selectDefaultMould = Util.getIntValue(moduleid);
	       				    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
	       				        selectMouldType = 1;
	       					    selectDefaultMould = Util.getIntValue(moduleid);
	       				    }
	       				}
	       			}

	       			if(user != null && HrmUserVarify.checkUserRight("DocEdit:Publish",user,docdepartmentid) && docstatus.equals("6") && (ishistory!=1) && docstatus.equals("6")){
	       			    if(Util.getIntValue(Util.null2String(selectedpubmould),0)<=0){
	       					if(selectMouldType>0){
	       					    docmouldid = selectDefaultMould;
	       					}
	       			    } else {
	       			        docmouldid = Util.getIntValue(selectedpubmould);
	       			    }
	       			} else {
	       			    if(Util.getIntValue(Util.null2String(selectedpubmould),0)<=0){
	       			    	if(selectedpubmouldid<=0){
	       			    	    if(selectMouldType>0)
	       			    	        docmouldid = selectDefaultMould;
	       			    	} else {
	       			    	    docmouldid = selectedpubmouldid;
	       			    	}
	       			    } else {
	       			        docmouldid = Util.getIntValue(selectedpubmould);
	       			    }
	       			}
	       		}

	        	MouldManager mouldManager = new MouldManager();
				if(docmouldid<=0)
	        	    docmouldid = mouldManager.getDefaultMouldId();
	        	mouldManager.setId(docmouldid);
	        	mouldManager.getMouldInfoById();
	        	String mouldtext = mouldManager.getMouldText();
	        	moudlePictureIds =mouldManager.getMouldPicId();
	        	
	        	try{
		        	int contentIndex = mouldtext.indexOf("$DOC_Content");
		        	if(contentIndex > -1){
		        		int contentPStartIndex = mouldtext.lastIndexOf("<p ", contentIndex);
		        		if(contentPStartIndex < -1){
		        			contentPStartIndex = mouldtext.lastIndexOf("<p>", contentIndex);
		        		}
		        		int contentPEndIndex = mouldtext.indexOf("</p>", contentIndex);
		        		if(contentPStartIndex > -1 && contentPEndIndex > -1){
		            		String preMouldtext = mouldtext.substring(0,contentPStartIndex);
		            		String cenMouldtext = mouldtext.substring(contentPStartIndex,contentPEndIndex + 4);
		            		String endMouldtext = mouldtext.substring(contentPEndIndex + 4);
		            		
		            		cenMouldtext = "<div " + cenMouldtext.substring(2,cenMouldtext.length() - 4) + "</div>";
		            		mouldtext = preMouldtext + cenMouldtext + endMouldtext;
		        		}
		        	}
	        	}catch(Exception e){
	        		
	        	}
	        	
	        	Hashtable<String,String> hr = new Hashtable<String,String>();
	        	SecCategoryComInfo scci = new SecCategoryComInfo();
	        	hr.put("DOC_SecCategory",Util.null2String(scci.getSecCategoryname(""+seccategory)));
	        	hr.put("DOC_Department",Util.null2String("<a href='/hrm/company/HrmDepartmentDsp.jsp?id="+docdepartmentid+"'>"+Util.toScreen(DepartmentComInfo.getDepartmentname(""+docdepartmentid),languageid)+"</a>"));
	        	
	        	
	        	if(docContent != null){
	    		    if(docContent.contains("<body>") && docContent.contains("</body>")){
	    		    	docContent = docContent.replace("<body>","").replace("</body>","");
	    		    }
	    		    docContent = "<div id=\"weaDocDetailHtmlContent\">" + docContent + "</div>";
	    		    
	    		    Pattern p = Pattern.compile("<link\\s[^>]+\\s?\\/>");
	    	        Matcher m = p.matcher(docContent);
	    	       
	    	        while(m.find()){
	    	            String link = m.group(0);
	    	            docContent = docContent.replace(link, "");
	    	        }
	    	        
	    	        int tmppos = docContent.indexOf("<title>");
	    	        while (tmppos != -1) {
	    	            int endpos = docContent.lastIndexOf("</title>", tmppos);
	    	            if ((endpos - tmppos) > 1) {
	    	                String tmpcontent = docContent.substring(0, tmppos);
	    	                tmpcontent += tmpcontent.substring(endpos + 8);
	    	                docContent = tmpcontent;
	    	            } else if(endpos < 0){
	    	            	docContent = docContent.replace("<title>","");
	    	            }
	    	            tmppos = docContent.indexOf("<title>");
	    	        }
	        	} 
	        	
	        	hr.put("DOC_Content",Util.null2String(docContent));
	        	
	        	HrmClassifiedProtectionBiz hcpb = new HrmClassifiedProtectionBiz();
	        	hr.put("DOC_SecretLevel",hcpb.getResourceSecLevelShowName(secretLevel, user.getLanguage() + ""));

	        	if(usertype.equals("2"))  {
	        	    hr.put("DOC_CreatedBy",Util.null2String(Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),languageid)));
	        	    hr.put("DOC_CreatedByLink",Util.null2String("<a href='/CRM/data/ViewCustomer.jsp?CustomerID="+doccreaterid+"'>"+Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),languageid)+"</a>"));
	        	    hr.put("DOC_CreatedByFull",Util.null2String(Util.toScreen(CustomerInfoComInfo.getCustomerInfoname(""+doccreaterid),languageid)));
	        	}else {
	        	    hr.put("DOC_CreatedBy",Util.null2String(Util.toScreen(ResourceComInfo.getFirstname(""+doccreaterid),languageid)));
	        	    hr.put("DOC_CreatedByLink",Util.null2String("<a href='javaScript:openhrm("+doccreaterid+");' onclick='pointerXY(event);'>"+Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),languageid)+"</a>"));
	        	    hr.put("DOC_CreatedByFull",Util.null2String(Util.toScreen(ResourceComInfo.getResourcename(""+doccreaterid),languageid)));
	        	}

	        	hr.put("DOC_CreatedDate",Util.null2String(doccreatedate));
	        	hr.put("DOC_DocId",Util.null2String(Util.add0(docid,12)));
	        	hr.put("DOC_ModifiedBy",Util.null2String(Util.toScreen(ResourceComInfo.getFirstname(""+doclastmoduserid),languageid)));
	        	hr.put("DOC_ModifiedDate",Util.null2String(doclastmoddate));
	        	hr.put("DOC_Language",Util.null2String(LanguageComInfo.getLanguagename(""+doclangurage)));
	        	hr.put("DOC_ParentId",Util.null2String(Util.add0(replydocid,12)));
	        	String docstatusname = DocComInfo.getStatusView(docid,languageid);
	        	hr.put("DOC_Status",Util.null2String(docstatusname));
	        	hr.put("DOC_Subject",Util.null2String(docsubject));
	        	String tmppublishtype="";
	        	if(docpublishtype.equals("2")) tmppublishtype=SystemEnv.getHtmlLabelName(227,languageid);
	        	else if(docpublishtype.equals("3")) tmppublishtype=SystemEnv.getHtmlLabelName(229,languageid);
	        	else tmppublishtype=SystemEnv.getHtmlLabelName(58,languageid);
	        	hr.put("DOC_Publish",Util.null2String(tmppublishtype));
	        	hr.put("DOC_ApproveDate",Util.null2String(docapprovedate));
	        	hr.put("DOC_Doccode", Util.null2String(docCode)) ;
				hr.put("DOC_Keyword", Util.null2String(keyword)) ;
				hr.put("DOC_Summary", Util.null2String(docMain)) ;
	        	String doccontentbackgroud="";
	        	int strindex = docContent.indexOf("data-background=");
	        	if(strindex!=-1){
	        		strindex = docContent.indexOf("\"", docContent.indexOf("data-background="))+1;
	        		doccontentbackgroud=docContent.substring(strindex, docContent.indexOf("\"", strindex));
	        	}

	        	if("".equals(doccontentbackgroud)){
	        		int strindextemp=mouldtext.indexOf("data-background=");
	        		if(strindextemp!=-1){
	        			strindextemp=mouldtext.indexOf("\"", strindextemp)+1;
	        			doccontentbackgroud=mouldtext.substring(strindextemp, mouldtext.indexOf("\"", strindextemp));
	        		}
	        	}

	        	    mouldManager.closeStatement();
	        		mouldtext = Util.fillValuesToString(mouldtext,hr);

	        		docContent = mouldtext != null ? mouldtext : docContent;
	        }
	    }else if(doctype == 12){  //pdf文档
	    	rs.executeSql("select a.id,a.imagefileid,a.imagefilename,a.docfiletype,a.versionId,b.filesize,b.comefrom from docimagefile a,imagefile b " +
	            		" where a.imagefileid=b.imagefileid and (a.isextfile <> '1' or a.isextfile is null) and a.docid=" + docid + " order by versionid desc");
	    	if(rs.next()){
	    		OpenAccOfFileid = rs.getString("imagefileid");
	    		OpenAccOfFilename = rs.getString("imagefilename");
	    		OpenAccOfFiletype = rs.getString("docfiletype");
	    		OpenAccOfVersionid = rs.getString("versionId");
	    		OpenAccOfFileSize = rs.getInt("filesize");
				OpenAccOfcomefrom = rs.getString("comefrom");
	    		isOpenAcc = true;
	    	}
	    }

    }
    
    ImageConvertUtil icu = new ImageConvertUtil();
    String waterContent = icu.getWatermark(user,new HashMap<String,String>(),false); //水印内容
    if(waterContent.startsWith("&watermark_txt=")){
    	waterContent = waterContent.substring(15);
    }

	    // office文件：正文word、excel   或者是单附件打开
	    if(!isEdit && (doctype == 2  || isOpenAcc || imagefileId > 0))
	    {
	        // 附件ID
	        String imageFileid = "";
	        // 模板ID
	        String mTemplate = "";
	        // 附件名称
	    	String imageFileName="";
	        // 附件类型
	    	String fileType="";
	        // 操作用户
	    	String mUserName = user == null ? "" : user.getLastname();
	        // 编辑状态
	        String editType = "4";
	        // 附件类型标识
	    	int docFileType = 0;
	        // 附件大小
	        int filesize = 0;
	        // 是否文件过大
	        boolean isToLarge = false;
	        String comefrom = "";

	        RecordSet rs = new RecordSet();
	        String sql = "";
			 if(imagefileId > 0){
	        	 sql = "select a.imagefileid,a.imagefilename,a.docfiletype,a.versionId,b.filesize,b.comefrom from DocImageFile a,Imagefile b " +
	        	 " where a.imagefileid=b.imagefileid and a.imagefileid="+imagefileId+
	        	 (versionId > 0 ? " and a.versionId=" + versionId : "")
	        	 +" order by versionId desc";
			     rs.executeSql(sql);
	        	if(rs.next()){
	        		imageFileName = Util.null2String(rs.getString("imagefilename"),"");
		            docFileType = Util.getIntValue(rs.getString("docfiletype"),0);
		            filesize = Util.getIntValue(rs.getString("filesize"),0);
					comefrom = Util.null2s(rs.getString("comefrom"),"");
	        	}
	        	 imageFileid = imagefileId + "";
	        	 imagefilename = imageFileName;
	        }else if(doctype == 2){  // office文件
		        sql = "select a.imagefileid,a.imagefilename,a.docfiletype,a.versionId,b.filesize,b.comefrom from DocImageFile a,Imagefile b " +
		        	" where a.imagefileid=b.imagefileid and a.docid="+docid+" and (a.isextfile <> '1' or a.isextfile is null) order by a.versionId desc";
		        rs.executeSql(sql);
		        if(rs.next())
		        {
		            imageFileid = Util.null2String(rs.getString("imagefileid"),"");
		            imageFileName = Util.null2String(rs.getString("imagefilename"),"");
		            docFileType = Util.getIntValue(rs.getString("docfiletype"),0);
		            versionId = Util.getIntValue(rs.getString("versionId"),0);
		            filesize = Util.getIntValue(rs.getString("filesize"),0);
					comefrom = Util.null2s(rs.getString("comefrom"),"");
		        }
		        imagefileId = Util.getIntValue(imageFileid);
	        }else if(isOpenAcc){  //单附件打开

	            imageFileid = OpenAccOfFileid;
	            imageFileName = OpenAccOfFilename;
	            docFileType = Util.getIntValue(OpenAccOfFiletype,0);
	            versionId = Util.getIntValue(OpenAccOfVersionid,0);
	            filesize = OpenAccOfFileSize;
	            imagefileId = Util.getIntValue(imageFileid);
	            comefrom = OpenAccOfcomefrom;
	        }
	        String extname = imageFileName.indexOf(".") > -1 ? imageFileName.substring(imageFileName.lastIndexOf(".")+ 1) : "";
	        extname = extname.toLowerCase();
	        boolean IsUseDocPreviewForIE = "1".equals(rs.getPropValue("docpreview","IsUseDocPreviewForIE"));
	        boolean IsUseDocPreview = "1".equals(rs.getPropValue("docpreview","IsUseDocPreview"));  //是否开启预览
	        
	        boolean tifReadOnline = false;
	        if(extname.equals("tif") || extname.equals("tiff")){
	        	tifReadOnline = "1".equals(rs.getPropValue("docpreview","tifReadOnline"));
	        }
	        
	        useYozoView = false;
	        if(extname.equals("jpg") || extname.equals("jpeg") || extname.equals("png") || extname.equals("gif")){
				docContent = "<table style='width:100%;height:100%;background-color:#ffffff'><tr><td style='height:100%; vertical-align:middle; text-align:center;'><img style='vertical-align:middle;' src='/weaver/weaver.file.FileDownload?fileid=" + imageFileid +moudleParams+ "&nolog=1'/></td></tr></table>";
			}else if(extname.equals("pdf")){
				String pdfConvert = rs.getPropValue("doc_custom_for_weaver", "pdfConvert");
				String _clientAddress = icu.getConvertIp();
				
				boolean isUseIwebPdf = false;
				if(isIE){
					isUseIwebPdf = "1".equals(rs.getPropValue("weaver_iWebPDF", "isUseiWebPDF"));
				}
				
				if(isUseIwebPdf){  // iwebpdf
					String sessionParaPDF=""+docid+"_"+imagefileId+"_"+user.getUID()+"_"+user.getLogintype();
					session.setAttribute("canView_"+sessionParaPDF,canRead ? "1" : "0");
					session.setAttribute("canEdit_"+sessionParaPDF,canEdit ? "1" : "0");
					session.setAttribute("canPrint_"+sessionParaPDF,canPrint ? "1" : "0");
					
					
				
					docContent = "<iframe id=\"webOffice\" src=\"/docs/e9/iwebpdf.jsp?docid="+docid +"&imagefileid="+imagefileId + moudleParams + "\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
				}else if("1".equals(pdfConvert) && !_clientAddress.isEmpty()){	//移动端只判断pdfConvert，PC端需要同时判断单独转换服务器不为空时，pdf也会在单独服务器预览
					convertFile = "pdf";
					if(DocPlugUtil.isopenbjca()&&DocPlugUtil.isIE(request)){
						docContent = "<iframe id='pdfshow' src='/docs/pdfofca/pdfShow.jsp?docid="+docid+"&imagefileId="+imagefileId+"&isEdit="+isEdit+"' style='display: block;width: 100%;height: 100%; border:0'></iframe>";
					}else{
						docContent = "<iframe id=\"officeShow\" src=\"/docs/pdfview/web/sysRemind.jsp?labelid=996\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
					}
				}else{
					if(DocPlugUtil.isopenbjca()&&DocPlugUtil.isIE(request)){
						docContent = "<iframe id='pdfshow' src='/docs/pdfofca/pdfShow.jsp?docid="+docid+"&imagefileId="+imagefileId+"&isEdit="+isEdit+"' style='display: block;width: 100%;height: 100%; border:0'></iframe>";
					}else{
						docContent = "<iframe id='officeShow' src=\"/docs/pdfview/web/pdfViewer.jsp?canPrint="+canPrint+"&docisLock="+docisLock+"&canDownload="+canDownload+"&pdfimagefileid="+imageFileid+moudleParams+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
					}
				}
				//docContent = "<iframe src=\"/docs/pdfview/web/pdfViewer.jsp?canPrint="+canPrint+"&canDownload="+canDownload+"&pdfimagefileid="+imageFileid+moudleParams+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
            }else if(extname.equals("ofd") && canIWebOffice){
            	ofdContent = "<iframe id=\"ofdshow\" src=\"/docs/ofd/OfdShow.jsp?docid="+docid+"&imagefileId="+imagefileId+"&isEdit="+false+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
            }else if(tifReadOnline || "WorkflowToDoc".equals(comefrom)){
            	docContent = "<iframe src=\"/weaver/weaver.file.FileDownload?fileid=" + imageFileid + moudleParams + "&nolog=1\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
            }else if(!IsUseDocPreview && !canIWebOffice){  //未开启转换预览,且该浏览器不支持插件
	        	String sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129757";
            	if(levelMap.get(DocViewPermission.DOWNLOAD)){
            		sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129755&line=1";
            	}
            	docContent = "<iframe src=\""+sysremindurl+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	        }else if(useYozoView){	//永中在线预览office文档
	        	docContent = "<iframe src=\"/spa/document/weboffice.jsp?fileid="+imageFileid+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	        }else if(IsUseDocPreview && (!canIWebOffice || IsUseDocPreviewForIE)){  //开启预览，非ie浏览器或者ie下开启预览
	            //是否开启PDF转换
	            boolean isUsePDFViewer = ConvertPDFUtil.isUsePDFViewer();
	          	//是否是支持转换的文档
	           	boolean canConvert = ImageConvertUtil.canConvertType(extname);
	           	
	           	if(extname.equals("zip") ||extname.equals("rar")){ //不开启单独转换，不支持压缩包
	           		String _clientAddress = icu.getConvertIp();
	           		if(_clientAddress.isEmpty()){
	           			canConvert = false;
	           		}
	           	}
	           	
	           	// 采用转换PDF预览
	            if(isUsePDFViewer && canConvert){
	            	
					isToLarge = icu.isTooLarge(extname,filesize + "");

					if(!isToLarge){
					    convertFile = "pdf";
					}
	           		if(isToLarge){
	           			//文件过大
	           			docContent = "<iframe src=\"/docs/pdfview/web/sysRemind.jsp?labelid=999\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	           		}else{
						if(DocPlugUtil.isopenbjca()&&DocPlugUtil.isIE(request)){
							docContent = "<iframe id='pdfshow' src='/docs/pdfofca/pdfShow.jsp?docid="+docid+"&imagefileId="+imagefileId+"&isEdit="+isEdit+"' style='display: block;width: 100%;height: 100%; border:0'></iframe>";
						}else{
							docContent = "<iframe id=\"officeShow\" src=\"/docs/pdfview/web/sysRemind.jsp?labelid=996\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
						}
	           		}
	           		if(extname.equals("pdf")){
	           			waterContent = "";
	           		}
	            }
	           	// 采用转换html查看
	            else if(extname.equals("doc") ||
	            		extname.equals("docx") ||
	            		extname.equals("xls") ||
	            		extname.equals("xlsx"))
	            {
	            	convertFile = "html";
	                ///weaver/weaver.file.FileDownload?fileid="+htmlFileId+ moudleParams +"
	                docContent = "<iframe id=\"officeShow\" src=\"/docs/pdfview/web/sysRemind.jsp?labelid=996\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	            }else{
	            	//不支持的格式
	            	String sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129757";
	            	if(levelMap.get(DocViewPermission.DOWNLOAD)){
	            		sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129755&line=2";
	            	}
	            	docContent = "<iframe src=\""+sysremindurl+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	            }
	        }
	        // IE 32 内核，直接加载控件
	        else
	        {
	        	waterContent = "";
	            String mFileType = "";
	            if(docFileType == 3)
	            {
	                mFileType = ".doc";
	            }
	            else if(docFileType == 7)
	            {
	                mFileType = ".docx";
	            }
	            else if(docFileType == 4)
	            {
	                mFileType = ".xls";
	            }
	            else if(docFileType == 8)
	            {
	                mFileType = ".xlsx";
	            }else if(extname.equals("wps") || extname.equals("ppt") || extname.equals("pptx") || extname.equals("et")){
	            	mFileType = "." + extname;
	            }else if(extname.equals("uot")){
	            	mFileType = ".doc";
	            }
	            
	            if(selectedpubmouldid > 0){
	        		mTemplate = selectedpubmouldid + "";
	        	}else if(mFileType.equals(".doc")||mFileType.equals(".wps")){
	    			int  tempMouldType=3;//3：WORD显示模版
	    			if(mFileType.equals(".wps")){
	    				tempMouldType=7;//7：WPS显示模版
	    			}
	    			int selectMouldType = 0;
	    			int mouldid = 0;
	    			rs.executeQuery("select * from DocSecCategoryMould where secCategoryId = "+secid+" and mouldType=" + tempMouldType + " order by id ");
	    			while(rs.next()){
	    				String moduleid=rs.getString("mouldId");
	    				String mType = DocMouldComInfo.getDocMouldType(moduleid);
	    				String modulebind = rs.getString("mouldBind");
	    				int isDefault = Util.getIntValue(rs.getString("isDefault"),0);
    					if(Util.getIntValue(modulebind,1)==2){
    					    selectMouldType = 2;
    					    mouldid = Util.getIntValue(moduleid);
    				    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
    					    if(selectMouldType==0){
    					        selectMouldType = 1;
    					        mouldid = Util.getIntValue(moduleid);
    					    }
    				    } 
	    			}
	    			mTemplate = mouldid > 0 ? (mouldid + "") : "";
	        	}
	            
	            if(!mFileType.isEmpty()){
	                if(docisLock){
	                    editType = "0";
					}
					docContent = "<iframe src=\"/spa/document/office.jsp?isofficeview=1&mRecordID="+versionId +"_"+docid+"&mTemplate=" + mTemplate +"&canPrint="+canPrint+"&mFileName=" + imageFileName +"&mFileType=" + mFileType +"&mEditType=" + editType + moudleParams + "\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	            }else{
	            	//不支持的格式
	            	String sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129757";
	            	if(levelMap.get(DocViewPermission.DOWNLOAD)){
	            		sysremindurl="/wui/common/page/sysRemind.jsp?labelid=129755&line=3";
	            	}
	            	docContent = "<iframe src=\""+sysremindurl+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	            	//docContent = "<iframe src=\"/docs/pdfview/web/sysRemind.jsp?labelid=997\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	            } 
	       }
	    }
	    
	    //新建、编辑office
	    if(isEdit && isEditOffice){
	    	
	    	waterContent = "";
	    	 // 模板ID
	        String mTemplate = "";
	        // 附件名称
	    	String imageFileName="";
	        // 编辑状态
	        String editType = docid > 0 ? "-1,0,1,1,0,0,1" : "1";
	        //文档类型
	        String mFileType = "";
	        //附件id
	        String imagefileid = "";
	        
	        RecordSet rs = new RecordSet();
	        RecordSet rs1 = new RecordSet();
	        //rs.executeQuery("select ")
	        if(docid > 0){
	        	 String sql = "select a.imagefileid,a.imagefilename,a.docfiletype,a.versionId,b.filesize from DocImageFile a,Imagefile b " +
		        	" where a.imagefileid=b.imagefileid and a.docid="+docid+" and (a.isextfile <> '1' or a.isextfile is null) order by a.versionId desc";
	        	rs.executeQuery(sql);
				rs1.executeQuery("select imagefileid,docfiletype from docimagefile where docid=? and docfiletype =12 ",docid);
				if(!rs.next() && !rs1.next()){
	        		response.sendRedirect("/notice/noright.jsp?line=7") ;
	        		return ;
	        	}
	        	int docFileType = rs.getInt("docfiletype");
	        	imageFileName = rs.getString("imagefilename");
	        	versionId = rs.getInt("versionId");
	        	imagefileid = rs.getString("imagefileid");
		        if(docFileType == 3){
	                mFileType = ".doc";
	            } else if(docFileType == 7){
	                mFileType = ".docx";
	            }else if(docFileType == 4){
	                mFileType = ".xls";
	            } else if(docFileType == 8){
	                mFileType = ".xlsx";
	            }else if(docFileType == 6){
	            	mFileType = ".wps";
	            }else if(docFileType == 10){
	            	mFileType = ".et";
	            }else if(docFileType == 12){
					mFileType = ".html";
				}else if(imageFileName.toLowerCase().endsWith(".uot")){
					mFileType = ".doc";
				}
	        }else{
	        	mFileType = officeType;
	        	if(mFileType.equals(".doc")||mFileType.equals(".xls")||mFileType.equals(".wps")||mFileType.equals(".et")){
	    			int  tempMouldType=4;//4：WORD编辑模版
	    			if(mFileType.equals(".xls")){
	    				tempMouldType=6;//6：EXCEL编辑模版
	    			}else if(mFileType.equals(".wps")){
	    				tempMouldType=8;//8：WPS文字编辑模版
	    			}else if(mFileType.equals(".et")){
	    				tempMouldType=10;//10：et表格编辑模版
	    			}else if(mFileType.equals(".html")){
						tempMouldType=12;
					}
	    			int selectMouldType = 0;
	    			int mouldid = 0;
	    			rs.executeQuery("select * from DocSecCategoryMould where secCategoryId = "+secid+" and mouldType=" + tempMouldType + " order by id ");
	    			while(rs.next()){
	    				String moduleid=rs.getString("mouldId");
	    				String mType = DocMouldComInfo.getDocMouldType(moduleid);
	    				String modulebind = rs.getString("mouldBind");
	    				int isDefault = Util.getIntValue(rs.getString("isDefault"),0);
    					if(Util.getIntValue(modulebind,1)==2){
    					    selectMouldType = 2;
    					    mouldid = Util.getIntValue(moduleid);
    				    } else if(Util.getIntValue(modulebind,1)==1&&isDefault==1){
    					    if(selectMouldType==0){
    					        selectMouldType = 1;
    					        mouldid = Util.getIntValue(moduleid);
    					    }
    				    } 
	    			}
	    			mTemplate = mouldid > 0 ? (mouldid + "") : "";
	    		}
	        }
	        if(useYozoView && 
	        		(mFileType.equals(".doc") || 
	        				mFileType.equals(".docx") || 
	        				mFileType.equals(".xls") || 
	        				mFileType.equals(".xlsx") || 
	        				mFileType.equals(".ppt") ||
	        				mFileType.equals(".pptx"))){	//永中在线预览office文档
				int _fileid = Util.getIntValue(request.getParameter("fileid"));
	        	if(_fileid > 0 && Util.getIntValue(imagefileid) <= 0){
	        		imagefileid = _fileid + "";
	        	}			
	        	docContent = "<iframe id=\"webOffice\" src=\"/spa/document/weboffice.jsp?fileid="+imagefileid+"&isEdit=1&mFileType="+mFileType+"\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	        }else if(mFileType.equals(".html") && DocPlugUtil.isopenbjca()){
	            RecordSet recordSet = new RecordSet();
	            String sql = "select imagefileid from docimagefile where docid=? and docfiletype =12 order by imagefileid desc";
	            recordSet.executeQuery(sql,docid);
	            String fileid = "";
	            if(recordSet.next()){
	                fileid = recordSet.getString("imagefileid");
				}
				docContent = "<iframe id='pdfshow' src='/docs/pdfofca/pdfShow.jsp?docid="+docid+"&imagefileId="+fileid+"&isEdit="+isEdit+"' style='display: block;width: 100%;height: 100%; border:0'></iframe>";
			}else{
	            if(docisLock){
	                editType = "0";
				}
	            
	            int maxFileSize = 0;
	            if(secid > 0){
	            	rs.executeQuery("select maxofficedocfilesize from DocSecCategory where id=?",secid);
	            }else{
	            	rs.executeQuery("select a.maxofficedocfilesize from DocSecCategory a,DocDetail b where a.id=b.seccategory and b.id=?",docid);
	            }
	            if(rs.next()){
	            	maxFileSize = rs.getInt("maxofficedocfilesize");
	            }
	            
	    		docContent = "<iframe id=\"webOffice\" src=\"/spa/document/office.jsp?isofficeview=0&mRecordID="+versionId +"_"+docid+"&maxFileSize="+maxFileSize+"&mTemplate=" + mTemplate +"&mFileName=" + imageFileName +"&mFileType=" + mFileType +"&mEditType=" + editType + moudleParams + "\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
	        }
	    }
	    
	    
	//    String htmlcontent = docContent;
	    
	//    session.setAttribute("doccontent_" + user.getUID() + "_" + user.getLogintype() + "_" + docid,docContent);

	    if(showByHtml){
	 //   	docContent = "<iframe src=\"/spa/document/htmlcontent.jsp?docid=" + docid + "\" style=\"display: block;width: 100%;height: 100%; border:0\"></iframe>";
		}

	    Date d4 = new Date();
	    time3 = d4.getTime()-d1.getTime();
	    String linkNewestDoc = "";
		if(ishistory == 1){
			RecordSet rs = new RecordSet();
			rs.executeQuery("select id from DocDetail where doceditionid = " + doceditionid + " and ishistory=0 and id<>"+docid+"  order by docedition desc ");
    		if(rs.next()){
    			newestid = rs.getInt("id");
    		}
    		if(newestid > 0 && newestid != docid){
	    		linkNewestDoc = DocSptm.DOC_DETAIL_LINK + "?id=" + newestid + moudleParams + DocSptm.DOC_ROOT_FLAG_VALUE+DocSptm.DOC_DETAIL_ROUT;
    		}else{
    			linkNewestDoc = "/notice/noright.jsp?line=8";
    		}
		}
		
		if(isEdit && !"1".equals(checkOutStatus)&&!"2".equals(checkOutStatus)){
			DocSaveService dss = new DocSaveService();
           	dss.checkOut(docid,docsubject,doccreaterid,usertype,request.getRemoteAddr(),user);
    	}
		//checkout
	    String warmMessageStatus = Util.null2String(request.getParameter("warmMessageStatus"));
	    String warmMessage = "";
	    if("checkout".equals(warmMessageStatus)){
	    	String checkOutUserName = ResourceComInfo.getLastname(checkOutUserId + "");
	    	warmMessage = SystemEnv.getHtmlLabelName(19695,user.getLanguage())+SystemEnv.getHtmlLabelName(19690,user.getLanguage())+"："+checkOutUserName;
	    }
		
		
		if(_convertFile != null && !_convertFile.isEmpty()){
			if("jpg".equals(_convertFile) || "pdf".equals(_convertFile) || "html".equals(_convertFile)){
				convertFile = _convertFile;
			}
		}
		
%>
<!--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">-->
<html>

	<head>
		<script>
			var __href = location.href;
			if(__href.indexOf("#/main/document/detail") == -1 && __href.indexOf("#/main/document/edit") == -1){
				//alert(location.href);
				//location.href = location.href.substring(0,location.href.indexOf("&router=1"));
				if(__href.indexOf("#/") == -1){
					location.href = __href.replace("&router=1","");
				}else{
					__href = __href.replace("&router=1","");
					location.href = __href.substring(0,__href.indexOf("#/"));

				}
				
			}
		</script>
		
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<title><%= docsubject %></title>
		<link rel="stylesheet" type="text/css" href="/cloudstore/resource/pc/com/v1/index.min.css?v=20170904">
		<link rel="stylesheet" type="text/css" href="/cloudstore/resource/pc/com/v1/ecCom.min.css?v=20170904">
		<link rel="stylesheet" type="text/css" href="/spa/document/static4Detail/index.css?v=20170811">
		<script type="text/javascript" src="/cloudstore/resource/pc/jquery/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="/js/weaver_wev8.js"></script>
		<script type="text/javascript" src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
		<script type="text/javascript" src="/js/ecology8/lang/weaver_lang_<%=languageid%>_wev8.js"></script>
		
		<script type="text/javascript" src="/docs/e9/pagewatermark_canvas.js"></script>
		
		<script>
			/**分享*/
			function onDocShare(){
				var message='[{"shareid":<%=docid%>,"sharetitle":"<%= docsubject %>","sharetype":"doc","objectname":"FW:CustomShareMsg"}]';
				socialshareToEmessage(message);
			}
			/**调用子层office保存*/
			function saveDocument(docsubject){
				try{
					if(<%=isCAPDF && DocPlugUtil.isopenbjca()%>){
                        var bjcasave = document.getElementById("pdfshow").contentWindow.save_pdf();
                        if(bjcasave.off_status == 0){
                            bjcasave.msg = "<%=SystemEnv.getHtmlLabelName(84544, user.getLanguage())%>";
                        }else if(bjcasave.off_status == 1){
                            bjcasave.msg = "保存成功!";
						}
                        return bjcasave;
					}else{
                        var obj = document.getElementById("webOffice").contentWindow.toSaveDocument({fileName : docsubject});

                        if(obj.off_status == 0){
                            obj.msg = obj.off_msg ? obj.off_msg : "<%=SystemEnv.getHtmlLabelName(84544, user.getLanguage())%>";
                        }
                        return obj;
					}

				}catch(e){
					return {off_status : 0};
				}
			}
			/**子层office调用保存事件是，保存office*/
			function __saveDocument(){
				var obj = document.getElementById("webOffice").contentWindow.SaveDocument();
			}
			/**调用子层office保存草稿*/
			function saveDocumentAsDraft(){
				return saveDocument();
			}
			/**子层office调用保存草稿事件是，保存office*/
			function __saveDocumentAsDraft(){
				
			}
			
			function changeOfficeMould(mouldid){
				//mTemplate
				
				try{
					var _src = document.getElementById("webOffice").src;
					_src = _src.replace(/&mTemplate=-?\d*/g,"&mTemplate=" + mouldid);
					document.getElementById("webOffice").src = _src;
				}catch(e){}
				
			}
			function changeOfficeFile(fileid,fileExtendName){
			
				if("<%=isEditOffice ? "1" : "0"%>" == "0"){
					location.href = location.href.replace("&router=1","&router=1&fileid=" + fileid+"&isOffice=1&officeType=."+fileExtendName.toLocaleLowerCase());
					return;
				}
			
				try{
					var _src = document.getElementById("webOffice").src;
					_src = _src.replace(/&fileid=-?\d*/g,"&fileid=" + fileid);
					_src = _src.replace(/\?fileid=-?\d*/g,"?fileid=" + fileid);
					document.getElementById("webOffice").src = _src;
				}catch(e){}
			}
			
			//异步加载完附件之后
			function afterConvertFile (data){
				if(!data)
					return;
				var _src = "";
				if(data.convert == "client"){
					if(data.result == "0"){
						if(data.data[0].path){
							_src = data.data[0].path;
						}else{
							if("<%=convertFile%>" == "pdf"){
                                if(<%=DocPlugUtil.isopenbjca()&&DocPlugUtil.isIE(request)%>){
                                    _src = "/docs/pdfofca/pdfShow.jsp?docid=<%=docid%>&imagefileId=<%=imagefileId%>&isEdit=<%=isEdit%>";
                                }else{
                                    _src = "/docs/pdfview/web/pdfViewer.jsp?canPrint=<%=canPrint%>&docisLock=<%=docisLock%>&canDownload=<%=canDownload%><%=moudleParams%>&pdfimagefileid="+data.data[0].id;
                                }
							}else if("<%=convertFile%>" == "html"){
								_src = "/weaver/weaver.file.FileDownload?fileid="+data.data[0].id+ "<%=moudleParams%>&nolog=1" ;
							}
						}
					}else{
						_src = "/wui/common/page/sysRemindDocpreview.jsp?labelid=" + data.message;
					}
				}else{
					if(data.status == "1"){
						if("<%=convertFile%>" == "pdf"){
                            if(<%=DocPlugUtil.isopenbjca()&&DocPlugUtil.isIE(request)%>){
                                _src = "/docs/pdfofca/pdfShow.jsp?docid=<%=docid%>&imagefileId=<%=imagefileId%>&isEdit=<%=isEdit%>";
                            }else{
                                _src = "/docs/pdfview/web/pdfViewer.jsp?canPrint=<%=canPrint%>&docisLock=<%=docisLock%>&canDownload=<%=canDownload%><%=moudleParams%>&pdfimagefileid="+data.convertId;
                            }
						}else if("<%=convertFile%>" == "html"){
							_src = "/weaver/weaver.file.FileDownload?fileid="+data.convertId+ "<%=moudleParams%>&nolog=1" ;
						}
					} if(data.status == "-1"){
						_src = "/docs/pdfview/web/sysRemind.jsp?labelid=998";
					}else if(data.status == "-2"){
						_src = "/wui/common/page/sysRemindDocpreview.jsp?labelid=" + data.msg;
					}	
				}
				if(_src != ""){
					document.getElementById("officeShow").src = _src;
				}
			}	
			
			function initFlashVideo(){}
			
			//打开应用连接
			function openAppLink(obj,linkid){

				var linkType=jQuery(obj).attr("linkType");
				if(linkType=="doc")
					window.open("/docs/docs/DocDsp.jsp?id="+linkid);
				else if(linkType=="task")
					window.open("/proj/process/ViewTask.jsp?taskrecordid="+linkid);
				else if(linkType=="crm")
					window.open("/CRM/data/ViewCustomer.jsp?CustomerID="+linkid);
				else if(linkType=="workflow")
					window.open("/workflow/request/ViewRequest.jsp?requestid="+linkid);
				else if(linkType=="project")
					window.open("/proj/data/ViewProject.jsp?ProjID="+linkid);
				else if(linkType=="workplan")
					window.open("/workplan/data/WorkPlanDetail.jsp?workid="+linkid);
				return false;
			}
			//打开留言附件(回复)
			function openReplyAcc(url,fileid){
				window.open(url);
			}
			//下载附件(回复)
			function downloadFile(url,fileid){
				window.open(url);
			}
			function docPrint(){
				var $obj = document.getElementById("webOffice");
				if(!$obj || $obj.length == 0){
					$obj = document.getElementById("officeShow");					
				}
				if(!$obj || $obj.length == 0){
					$obj = document.getElementById("previewDoc").contentWindow.document.getElementById("officeShow");
				}
				if($obj){
					if($obj.src && $obj.src.indexOf("/weaver/weaver.file.FileDownload") != -1){
						$obj.contentWindow.print();
					}else{
						$obj.contentWindow.docPrint();
					}
				}
				
			}
		</script>
    <style type="text/css">
      body{
        margin: 0;
        overflow: hidden;
      }
      .chatImgPagWrap  .carousel-fullpane .control-pane .ctrlbtn {
        margin: 0
      }
      .wea-doc-detail-content-main img{
      	max-width:1024px;
      }
      .wea-doc-detail-content-main ul,.wea-doc-detail-content-main ol{
      	padding-left:40px;
      	list-style: decimal;
      }
      #weaDocDetailHtmlContent p{
      	line-height: normal;
      }
    </style>
	</head>
		<body>
		
		<input type="hidden" id="isOffice" value="<%=isEditOffice ? 1 : 0%>"/>
		<input type="hidden" name="docid" value="<%=docid %>"/>
		
		
	<div id="container" style="height:100%;">
		
	</div>
	<div id="docContentPre" style="display: none;">
		<%if(!"".equals(ofdContent)){%>
			<%= ofdContent %>
		<%}else{%>
			<%= docContent %>
		<%}%>

	</div>
		<script type="text/javascript">
			window.__time0 = "判断权限耗时：<%=time0%>";
			window.__time1 = "获取属性耗时：<%=time1%>";
			window.__time2 = "获取正文耗时：<%=time2%>";
			window.__time3 = "业务逻辑总耗时：<%=time3%>";

			window.__imagefilename = "<%=imagefilename%>";
			window.__showByHtml = "<%=showByHtml ? 1 : 0%>";	//文档类型是html
			window.__moudleParams = "<%=moudleParams %>";		//其他模块参数集
            window.__moudlePicIds = "<%=moudlePictureIds %>";		//文档显示模板图片id
			window.__hasNewestWarm = "<%=ishistory == 1 ? 1 : 0%>";	//是否给出有最新文档的提示
			window.__linkNewestDoc = "<%=linkNewestDoc%>";		//跳转到最新版本文档的链接
			window.__isAutoExtendInfo = "<%=isAutoExtendInfo ? 1 : 0%>";//有附件时展开文档附件属性
			window.__warmMessage = "<%=warmMessage%>";//弹出提示语
			window.__currentUser = "<%=user == null ? 0 : user.getUID()%>";
			if("<%=convertFile%>" != ""){
				window.__convertFile = "convertFile=<%=convertFile%>&converSelf=<%=_convertFile%>&fileid=<%=imagefileId%>&docid=<%=docid%>&versionId=<%=versionId%>";		//是否需要异步转换文档
			}
			if(<%=docisLock%>){
                var ifmObj = window.document.body;
                ifmObj.style.cssText += ';-moz-user-select: none;-webkit-user-select: none;-ms-user-select: none;-khtml-user-select: none;user-select: none;unselectable:on;';
                ifmObj.onselectstart = function(){return false};
			}
            if(jQuery("#frame1").length > 0){
				
			}else{
				jQuery("table[id='content']").show();
			}
			
			jQuery(document).ready(function(){
						//不修改人力资源链接的target属性
				jQuery("a").each(function(){
					var _this=jQuery(this);
					var href=_this.attr("href");
					if(href){
						href = href.toLowerCase();
						if(-1 == href.indexOf("javascript:openhrm(")){
							_this.attr("target","_blank");
						}else if(href.indexOf("openfullwindowforxtable(")>0){
							_this.attr("target","_self");
						}else if(href.indexOf("#")==0){
							_this.attr("target","_self");
						}
					}
				});
			
			
			<%if(!waterContent.isEmpty()){%>
				window.waterInterval = setInterval(function(){
					doWater();
				},100)	
			<%}%>
      });
      
      function doWater(){
      		if(!document.getElementById("weaDocDetailHtmlContent"))
      			return;
			clearInterval(window.waterInterval)
      		var markUrl = new Object();
			markUrl.watermark_txt="<%=waterContent%>";
			watermark(markUrl,document.getElementById("weaDocDetailHtmlContent"));
      }
      window.__docsubject = '<%=docsubject.replace("'","\\'")%>';
      //window.__preTitle = $('.wea-new-top-req-title-text').html();// 应该没用了，就先去掉好了 by caoyun 20180830
      window.__preContent = $('#docContentPre').html();
	  $('#docContentPre').remove();
		</script>
    <script type="text/javascript" src="/cloudstore/resource/pc/polyfill/polyfill.min.js"></script>
		<!--[if lt IE 10]>
    <script type="text/javascript" src="/cloudstore/resource/pc/shim/shim.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
      jQuery.browser.msie && parseInt(jQuery.browser.version, 10) < 9 && (
        window.location.href = '/login/Login.jsp'
      );
    </script>
    <!-- 底层库 -->
    <!-- <script type="text/javascript" src="/cloudstore/resource/pc/react16/react.development.js"></script>
    <script type="text/javascript" src="/cloudstore/resource/pc/react16/react-dom.development.js"></script> -->
    <script type="text/javascript" src="/cloudstore/resource/pc/react16/react.production.min.js"></script>
    <script type="text/javascript" src="/cloudstore/resource/pc/react16/react-dom.production.min.js"></script>
    <script type="text/javascript" src="/cloudstore/resource/pc/react16/prop-types.min.js"></script>
    <script type="text/javascript" src="/cloudstore/resource/pc/react16/create-react-class.min.js"></script>
    <script>
      //console.log(createReactClass);
      React.PropTypes = PropTypes;
      React.createClass = createReactClass;
    </script>
		<!-- <script type="text/javascript" src="/cloudstore/resource/pc/react/react-with-addons.min.js"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/react/react-dom.min.js"></script> -->
		<!-- 组件库 -->
		<script type="text/javascript" src="/cloudstore/resource/pc/promise/promise.min.js"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/fetch/fetch.min.js"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/ckeditor-4.6.2/ckeditor.js"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/plupload-2.3.1/js/plupload.full.min.js?v=20180830"></script>
		<script type="text/javascript" src="/spa/moduleConfig.js?v=1560540617484"></script>
		<script type="text/javascript" src="/spa/coms/ssoConfig/config.js?v=1560540617484"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/com/v1/index.min.js?v=20170904"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/com/v1/ecCom.min.js?v=20170904"></script>
		<!-- mobx -->
		<script type="text/javascript" src="/cloudstore/resource/pc/mobx-3.1.16/mobx.umd.js"></script>
		<script type="text/javascript" src="/cloudstore/resource/pc/mobx-react-4.2.1/index.js"></script>
    	<script type="text/javascript" src="/cloudstore/resource/pc/react-router/ReactRouter.min.js"></script>
		<script type="text/javascript" src="/spa/coms/index.mobx.js?v=20180320"></script>
		
    <!-- 图片轮播 -->
    <script type="text/javascript" src="/social/js/drageasy/drageasy.js"></script>
    <script type="text/javascript" src="/social/js/bootstrap/js/bootstrap.js?v=20171218"></script>
    <script type="text/javascript" src="/social/im/js/IMUtil_wev8.js"></script>
    <script type="text/javascript" src="/social/js/imcarousel/imcarousel.js"></script>
	<!-- spa -->
	<script type="text/javascript" src="/spa/document/static4Detail/index.js?v=20170811"></script>
	<script type="text/javascript" src="/spa/document/static4Detail/index4single.js?v=20170811"></script>
	</body>

</html>
