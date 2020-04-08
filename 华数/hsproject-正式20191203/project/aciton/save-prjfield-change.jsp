<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="hsproject.impl.*" %>
<%@ page import="hsproject.dao.*" %>
<%@ page import="hsproject.bean.*" %>
<%@ page import="hsproject.util.*" %>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
	
<%
	int userid = user.getUID();
	
    String prjid = Util.null2String(request.getParameter("prjid"));
    String fieldid = Util.null2String(request.getParameter("fieldid"));
    String prjtype = Util.null2String(request.getParameter("prjtype"));
    String seqno = Util.null2String(request.getParameter("seqno"));
	String prjname = Util.null2String(request.getParameter("prjname"));
	String fieldname = Util.null2String(request.getParameter("fieldname"));
	String oldvalue = Util.null2String(request.getParameter("oldvalue"));
	ProjectFieldDao pfd = new ProjectFieldDao();
	ProjectFieldBean pfb = pfd.getPrjFieldBean(fieldid);
	String showfieldname=pfb.getFieldname();
	if(!"0".equals(pfb.getIscommon())){
		showfieldname="idef_"+pfb.getFieldname();
	}
	String newvalue = Util.null2String(request.getParameter(showfieldname));
	Map<String, String> map = new HashMap<String, String>();
	map.put("changetype","0");
	map.put("keyid",prjid);
	map.put("fieldid",fieldid);
	map.put("type",prjtype);
	map.put("seqno",seqno);
	map.put("name",prjname);
	map.put("fieldname",fieldname);
	map.put("oldvalue",oldvalue);
	map.put("newvalue",newvalue);
	InsertUtil iu = new InsertUtil();
	PrjChangeDetailDao pcdd = new PrjChangeDetailDao();
	String isexist=pcdd.checkChangeExist(seqno);
	if("1".equals(isexist)){
		iu.updateGen(map, "uf_prj_changedetail","seqno",seqno);
	}else{
		iu.insert(map, "uf_prj_changedetail");
	} 
	
	response.sendRedirect("/hsproject/project/view/hs-prj-field-change.jsp?prjid="+prjid+"&prjtype="+prjtype+"&fieldid="+fieldid+"&seqno="+seqno+"&issuccess=1");

%>	