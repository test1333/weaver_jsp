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
	String radetailid = Util.null2String(fu.getParameter("radetailid"));
	String syjg = Util.null2String(fu.getParameter("syjg"));
	String syzt = Util.null2String(fu.getParameter("syzt"));
	String xplx = Util.null2String(fu.getParameter("xplx"));
	String CG = Util.null2String(fu.getParameter("CG"));
	String ypsl = Util.null2String(fu.getParameter("ypsl"));

	String xcsj = Util.null2String(fu.getParameter("xcsj"));
	String wd = Util.null2String(fu.getParameter("wd"));

	String sd = Util.null2String(fu.getParameter("sd"));
	String sdms = Util.null2String(fu.getParameter("sdms"));
	String qsdy = Util.null2String(fu.getParameter("qsdy"));
	String jsdy = Util.null2String(fu.getParameter("jsdy"));


	String mdcs = Util.null2String(fu.getParameter("mdcs"));
	String tj = Util.null2String(fu.getParameter("tj"));

	String dj = Util.null2String(fu.getParameter("dj"));
	String cscode = Util.null2String(fu.getParameter("cscode"));
	String Tpcode = Util.null2String(fu.getParameter("Tpcode"));
	String jzsj = Util.null2String(fu.getParameter("jzsj"));
	String lh = Util.null2String(fu.getParameter("lh"));
	String sctrsj = Util.null2String(fu.getParameter("sctrsj"));
	String sctrsj1 = Util.null2String(fu.getParameter("sctrsj1"));
	String scclsj = Util.null2String(fu.getParameter("scclsj"));
	String scclsj1 = Util.null2String(fu.getParameter("scclsj1"));
	String clxss = Util.null2String(fu.getParameter("clxss"));
	String yjcl = Util.null2String(fu.getParameter("yjcl"));
	String yjcl1 = Util.null2String(fu.getParameter("yjcl1"));
	String yjwc = Util.null2String(fu.getParameter("yjwc"));
	String yjwc1 = Util.null2String(fu.getParameter("yjwc1"));
	String sjsj = Util.null2String(fu.getParameter("sjsj"));

	String sjsj1 = Util.null2String(fu.getParameter("sjsj1"));
	String sccls = Util.null2String(fu.getParameter("sccls"));
	String FAILps = Util.null2String(fu.getParameter("FAILps"));
	String FAILbl = Util.null2String(fu.getParameter("FAILbl"));
	String FAILbl1 = Util.null2String(fu.getParameter("FAILbl1"));
	String yctp = Util.null2String(fu.getParameter("yctp"));

	String nz = Util.null2String(fu.getParameter("nz"));

	Map<String, String> map = new HashMap<String, String>();
	map.put("syjg",syjg);
	map.put("syzt",syzt);
	map.put("xplx",xplx);
	map.put("CG",CG);
	map.put("ypsl",ypsl);
	map.put("xcsj",xcsj);
	map.put("wd",wd);
	map.put("sd",sd);
	map.put("sdms",sdms);
	map.put("qsdy",qsdy);

	map.put("jsdy",jsdy);
	map.put("mdcs",mdcs);
	map.put("tj",tj);
	//map.put("dj",dj);
	map.put("cscode",cscode);
	map.put("Tpcode",Tpcode);
	map.put("jzsj",jzsj);
	map.put("lh",lh);
	map.put("sctrsj",sctrsj);
	map.put("sctrsj1",sctrsj1);
	map.put("scclsj",scclsj);
	map.put("scclsj1",scclsj1);
	map.put("clxss",clxss);
	
	map.put("yjcl",yjcl);
	map.put("yjcl1",yjcl1);
	map.put("yjwc",yjwc);
	map.put("yjwc1",yjwc1);
	map.put("sjsj",sjsj);
	map.put("sjsj1",sjsj1);
	map.put("sccls",sccls);
	map.put("FAILps",FAILps);
	map.put("FAILbl",FAILbl);
	map.put("FAILbl1",FAILbl1);
	map.put("yctp",yctp);
	map.put("nz",nz);
	InsertUtil iu  = new InsertUtil();
	//iu.updateGenold(map,"uf_zy","id",raid);可以看到log
	iu.updateGen(map,"uf_ycjm","id",radetailid);
	
	
%>	
<script type="text/javascript">
window.close();
</script>