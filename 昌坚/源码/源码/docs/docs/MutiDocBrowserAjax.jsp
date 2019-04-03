
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.docs.category.CategoryUtil"%>
<%@ page import="weaver.hrm.*"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="weaver.docs.docs.reply.DocReplyUtil"%>
<jsp:useBean id="MainCategoryComInfo"
	class="weaver.docs.category.MainCategoryComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo"
	class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DocSearchManage"
	class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="DocSearchComInfo"
	class="weaver.docs.search.DocSearchComInfo" scope="session" />
<jsp:useBean id="CustomerInfoComInfo"
	class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo"
	scope="page" />
<jsp:useBean id="dm" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%
    String isWord = Util.null2String(request.getParameter("isWord"));
	User user = HrmUserVarify.getUser(request, response);
	String src = Util.null2String(request.getParameter("src"));
	String documentids = Util.null2String(request
			.getParameter("systemIds"));
	if (documentids.trim().startsWith(",")) {
		documentids = documentids.substring(1);
	}
	if (src.equalsIgnoreCase("dest")) {
		JSONArray jsonArr = new JSONArray();
		JSONArray jsonArr_tmp = new JSONArray();
		JSONObject json = new JSONObject();
		if (!documentids.equals("")) {
			String sql = "select * from docdetail where id in ("
					+ documentids + ")";
			rs.executeSql(sql);
			while (rs.next()) {
				JSONObject tmp = new JSONObject();
				String usertype = rs.getString("usertype");
				tmp.put("id", rs.getString("id"));
				String docsubjecttemp=rs.getString("docsubject");
				if(docsubjecttemp!=null){
					docsubjecttemp=docsubjecttemp.replaceAll(",","，");
				}
				tmp.put("subject", docsubjecttemp);
				//tmp.put("mainid",MainCategoryComInfo.getMainCategoryname(rs.getString("maincategory")));
				String createrid = rs.getString("ownerid");
				tmp.put("owner", (usertype.equals("1") ? Util.toScreen(
						ResourceComInfo.getResourcename(createrid),
						user.getLanguage()) : Util.toScreen(
						CustomerInfoComInfo
								.getCustomerInfoname(createrid), user
								.getLanguage())));
				tmp.put("modifydate",rs.getString("doclastmoddate")+" "+rs.getString("doclastmodtime"));
				jsonArr_tmp.add(tmp);
			}
			String[] documentidArr = Util.TokenizerString2(documentids,
					",");
			for (int i = 0; i < documentidArr.length; i++) {
				for (int j = 0; j < jsonArr_tmp.size(); j++) {
					JSONObject tmp = (JSONObject) jsonArr_tmp.get(j);
					if (tmp.get("id").equals(documentidArr[i])) {
						jsonArr.add(tmp);
					}
				}
			}

		}
		json.put("currentPage", 1);
		json.put("totalPage", 1);
		json.put("mapList", jsonArr.toString());
		out.println(json.toString());
		return;
	}
	Enumeration em = request.getParameterNames();
	boolean isinit = true;
	while (em.hasMoreElements()) {
		String paramName = (String) em.nextElement();
		if (!paramName.equals("") && !paramName.equals("splitflag"))
			isinit = false;
		break;
	}
	int date2during = Util.getIntValue(request
			.getParameter("date2during"), 0);
	int olddate2during = 0;
	BaseBean baseBean = new BaseBean();
	String date2durings = "";
	try {
		date2durings = Util.null2String(baseBean.getPropValue(
				"docdateduring", "date2during"));
	} catch (Exception e) {
	}
	String[] date2duringTokens = Util.TokenizerString2(date2durings,
			",");
	if (date2duringTokens.length > 0) {
		olddate2during = Util.getIntValue(date2duringTokens[0], 0);
	}
	if (olddate2during < 0 || olddate2during > 36) {
		olddate2during = 0;
	}
	if (isinit) {
		date2during = olddate2during;
	}

	int isgoveproj = Util.getIntValue(IsGovProj.getPath(), 0);//0:非政务系统，1：政务系统
	String islink = Util.null2String(request.getParameter("islink"));
	String searchid = Util
			.null2String(request.getParameter("searchid"));
	//String searchmainid = Util.null2String(request.getParameter("searchmainid"));
	String searchsubject = Util.null2String(request
			.getParameter("searchsubject"));
	String searchcreater = Util.null2String(request
			.getParameter("searchcreater"));
	String searchdatefrom = Util.null2String(request
			.getParameter("searchdatefrom"));
	String searchdateto = Util.null2String(request
			.getParameter("searchdateto"));
	String sqlwhere1 = Util.null2String(request
			.getParameter("sqlwhere"));
	String crmId = Util.null2String(request.getParameter("txtCrmId"));
	String sqlwhere = "";

	String secCategory = Util.null2String(request
			.getParameter("secCategory"));
	String path = Util.null2String(request.getParameter("path"));
	if (!secCategory.equals(""))
		path = "/"
				+ CategoryUtil.getCategoryPath(Util
						.getIntValue(secCategory));

	sqlwhere = " where 1=1 ";

	if (!islink.equals("1")) {
		DocSearchComInfo.resetSearchInfo();

		if (!searchid.equals(""))
			DocSearchComInfo.setDocid(searchid);
		//if(!searchmainid.equals("")) DocSearchComInfo.setMaincategory(searchmainid) ;
		if (!secCategory.equals(""))
			DocSearchComInfo.setSeccategory(secCategory);
		if (!searchsubject.equals(""))
			DocSearchComInfo.setDocsubject(searchsubject);
		if (!searchdatefrom.equals(""))
			DocSearchComInfo.setDoclastmoddateFrom(searchdatefrom);
		if (!searchdateto.equals(""))
			DocSearchComInfo.setDoclastmoddateTo(searchdateto);
		if (!searchcreater.equals("")) {
			DocSearchComInfo.setOwnerid(searchcreater);
			DocSearchComInfo.setUsertype("1");
		}
		if (!crmId.equals("")) {
			DocSearchComInfo.setDoccreaterid(crmId);
			DocSearchComInfo.setUsertype("2");
		}
		DocSearchComInfo.setOrderby("4");
	}

	String docstatus[] = new String[] { "1", "2", "5", "7" };
	for (int i = 0; i < docstatus.length; i++) {
		DocSearchComInfo.addDocstatus(docstatus[i]);
	}

	String tempsqlwhere = DocSearchComInfo.FormatSQLSearch(user
			.getLanguage());
	String orderclause = DocSearchComInfo.FormatSQLOrder();
	String orderclause2 = DocSearchComInfo.FormatSQLOrder2();

	if (!tempsqlwhere.equals(""))
		sqlwhere += " and " + tempsqlwhere;

	/* added by wdl 2007-03-16 涓嶆樉绀哄巻鍙茬増鏈?*/
	sqlwhere += " and (ishistory is null or ishistory = 0) ";
	/* added end */
	if(DocReplyUtil.isUseNewReply()) {
	    sqlwhere += " and  (isreply!=1 or isreply is null) ";
	}
	if("1".equals(isWord)){
		sqlwhere += " and doctype='2' and (docstatus !='3' and ((doccreaterid !="+user.getUID()+" and docstatus !='0') or doccreaterid ="+user.getUID()+")) and exists(select 1 from DocImageFile where docid=t1.id  and (isextfile <> '1' or isextfile is null) and docfileType='3') ";
	}		
	sqlwhere += dm.getDateDuringSql(date2during);

	//int perpage = 30 ;
	int perpage = Util
			.getIntValue(request.getParameter("pageSize"), 10);
	int pagenum = Util.getIntValue(request.getParameter("currentPage"),
			1);
	if (documentids.equals("")) {
		documentids = Util.null2String(request
				.getParameter("excludeId"));
	}
	if (!documentids.equals("")) {
		//sqlwhere += " and t1.id not in (" + documentids + ")";
	}
	//DocSearchManage.getSelectResultCount(sqlwhere, user);
	//int RecordSetCounts = DocSearchManage.getRecordersize();
	//int totalPage = RecordSetCounts / perpage;
	//if (totalPage % perpage > 0 || totalPage == 0) {
	//	totalPage++;
	//}

	//if(!check_per.equals(""))  
	//		check_per = "," + check_per + "," ;
	String docid = null;
	String mainid = null;
	String subject = null;
	String createrid = null;
	String usertype = null;

	int i = 0;
	DocSearchManage.setPagenum(pagenum);
	DocSearchManage.setPerpage(perpage);
	DocSearchManage.getSpu().setRecordCount(perpage);
	DocSearchManage.getSelectResult(sqlwhere, orderclause,
			orderclause2, user,false);
	JSONArray jsonArr = new JSONArray();
	JSONObject json = new JSONObject();
	while (DocSearchManage.next()) {
		docid = "" + DocSearchManage.getID();
		mainid = "" + DocSearchManage.getMainCategory();
		subject = DocSearchManage.getDocSubject();
		if(subject!=null){
			subject=subject.replaceAll(",","，");
		}
		createrid = "" + DocSearchManage.getOwnerId();
		String modifydate = DocSearchManage.getDocLastModDate();
		String modifytime = DocSearchManage.getDocLastModTime();
		usertype = Util.null2String(DocSearchManage.getUsertype());
		JSONObject tmp = new JSONObject();
		tmp.put("id", docid);
		tmp.put("subject", subject);
		//tmp.put("mainid",MainCategoryComInfo.getMainCategoryname(mainid));
		tmp.put("owner", (usertype.equals("1") ? Util.toScreen(
				ResourceComInfo.getResourcename(createrid), user
						.getLanguage()) : Util.toScreen(
				CustomerInfoComInfo.getCustomerInfoname(createrid),
				user.getLanguage())));
		tmp.put("modifydate",modifydate+" "+modifytime);
		jsonArr.add(tmp);
	}
	//json.put("currentPage", pagenum);
	//json.put("totalPage", totalPage);
	json.put("mapList", jsonArr.toString());
	out.println(json.toString());
%>
