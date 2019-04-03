<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="hhgd.util.InsertUtil" %>
<%@ page import="weaver.file.FileUpload" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
	
<%
	FileUpload fu = new FileUpload(request);
	String raid = Util.null2String(fu.getParameter("raid"));
    String rabdbh = Util.null2String(fu.getParameter("rabdbh"));
	String cc = Util.null2String(fu.getParameter("cc"));
	String kh = Util.null2String(fu.getParameter("kh"));
	String cpxhjb = Util.null2String(fu.getParameter("cpxhjb"));
	String syzsl = Util.null2String(fu.getParameter("syzsl"));
	String syzslp = Util.null2String(fu.getParameter("syzslp"));

	String cldj = Util.null2String(fu.getParameter("cldj"));
	String syzl = Util.null2String(fu.getParameter("syzl"));
	String syjd = Util.null2String(fu.getParameter("syjd"));
	String yzxh = Util.null2String(fu.getParameter("yzxh"));
	String ecbh = Util.null2String(fu.getParameter("ecbh"));
	String dcbh = Util.null2String(fu.getParameter("dcbh"));


	String sjxyx = Util.null2String(fu.getParameter("sjxyx"));
	String sfxytp = Util.null2String(fu.getParameter("sfxytp"));

	String gx = Util.null2String(fu.getParameter("gx"));
	String gh1 = Util.null2String(fu.getParameter("gh1"));
	String tp = Util.null2String(fu.getParameter("tp"));

	String hz = Util.null2String(fu.getParameter("hz"));
	String wg = Util.null2String(fu.getParameter("wg"));
	String sj1 = Util.null2String(fu.getParameter("sj1"));
	String sj2 = Util.null2String(fu.getParameter("sj2"));
	String sj3 = Util.null2String(fu.getParameter("sj3"));
	String sj4 = Util.null2String(fu.getParameter("sj4"));
	String qt = Util.null2String(fu.getParameter("qt"));
	String jcsj = Util.null2String(fu.getParameter("jcsj"));
	String sqrlxfs = Util.null2String(fu.getParameter("sqrlxfs"));

	String bgyylb = Util.null2String(fu.getParameter("bgyylb"));
	String sqjjcd = Util.null2String(fu.getParameter("sqjjcd"));
	String csyy = Util.null2String(fu.getParameter("csyy"));
	String bgqsm = Util.null2String(fu.getParameter("bgqsm"));
	String bghsm = Util.null2String(fu.getParameter("bghsm"));

	String xsjg = Util.null2String(fu.getParameter("xsjg"));
	String xsjg1 = Util.null2String(fu.getParameter("xsjg1"));
	String czr = Util.null2String(fu.getParameter("czr"));
	String czsm = Util.null2String(fu.getParameter("czsm"));
	String yaqzsj = Util.null2String(fu.getParameter("yaqzsj"));
	String scx = Util.null2String(fu.getParameter("scx"));
	String scip = Util.null2String(fu.getParameter("scip"));
	String scjh = Util.null2String(fu.getParameter("scjh"));
	String csbg = Util.null2String(fu.getParameter("csbg"));

	Map<String, String> map = new HashMap<String, String>();
	map.put("cc",cc);
	map.put("kh",kh);
	map.put("cpxhjb",cpxhjb);
	map.put("syzsl",syzsl);
	map.put("syzslp",syzslp);
	map.put("cldj",cldj);
	map.put("syzl",syzl);
	map.put("syjd",syjd);
	map.put("yzxh",yzxh);
	map.put("ecbh",ecbh);

	map.put("dcbh",dcbh);
	map.put("sjxyx",sjxyx);
	map.put("sfxytp",sfxytp);
	map.put("gx",gx);
	map.put("gh1",gh1);
	map.put("tp",tp);
	map.put("hz",hz);
	map.put("wg",wg);
	map.put("sj1",sj1);
	map.put("sj2",sj2);
	map.put("sj3",sj3);
	map.put("sj4",sj4);
	map.put("qt",qt);

	map.put("jcsj",jcsj);
	map.put("sqrlxfs",sqrlxfs);
	map.put("bgyylb",bgyylb);
	map.put("sqjjcd",sqjjcd);
	map.put("csyy",csyy);
	map.put("bgqsm",bgqsm);
	map.put("bghsm",bghsm);
	map.put("xsjg",xsjg);
	map.put("xsjg1",xsjg1);
	map.put("czr",czr);
	map.put("czsm",czsm);
	map.put("yaqzsj",yaqzsj);
	map.put("scx",scx);
	map.put("scip",scip);
	map.put("scjh",scjh);
	map.put("csbg",csbg);
	InsertUtil iu  = new InsertUtil();
	//iu.updateGenold(map,"uf_zy","id",raid);可以看到log
	iu.updateGen(map,"uf_zy","id",raid);
	response.sendRedirect("/hehui/qa/ra/qaRAListOther.jsp?bdbh="+rabdbh);
	
%>	