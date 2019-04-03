<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="MeetingUtil" class="weaver.meeting.MeetingUtil" scope="page" />
<%
char flag = Util.getSeparator();
String ProcPara = "";

String method = Util.null2String(request.getParameter("method"));
int subcompanyid = Util.getIntValue(request.getParameter("subcompanyid"),user.getUserSubCompany1());
if(method.equals("add"))
{
	String catalogpath = Util.null2String(request.getParameter("catalogpath")); 
	RecordSet.executeSql(" update wasu_projpath set prjpath='"+catalogpath+"' where typeid=1");
	return;
}

if(method.equals("edit"))
{
	String catalogpath = Util.null2String(request.getParameter("catalogpath")); 
	RecordSet.executeSql(" update wasu_projpath set prjpath='"+catalogpath+"' where typeid=1");
	response.sendRedirect("/project/setting/ProjectPathSetting.jsp"); 
	return;
}

if(method.equals("subcomsetting"))  
{
	rs.executeSql("DELETE FROM formtable_main_244_dt2 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] subcompanyids = request.getParameterValues("subcompanyid");
	for(int i=0; i<subcompanyids.length; i++) {  
		String catalogId = weaver.general.Util.null2String(subcompanyids[i]);
		if(catalogId.equals("")){ 
			continue; 
		} 
		String gs = weaver.general.Util.null2o(subcompanyids[i]);  
		   
		String sql = "INSERT INTO formtable_main_244_dt2(gs) VALUES ("+gs+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return;
}
if(method.equals("deptsetting"))   
{
	rs.executeSql("DELETE FROM formtable_main_244_dt1 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] subcompanyids = request.getParameterValues("departmentid");
	for(int i=0; i<subcompanyids.length; i++) {  
		String catalogId = weaver.general.Util.null2String(subcompanyids[i]);
		if(catalogId.equals("")){ 
			continue; 
		} 
		String gs = weaver.general.Util.null2o(subcompanyids[i]);  
		   
		String sql = "INSERT INTO formtable_main_244_dt1(bm) VALUES ("+gs+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}
if(method.equals("lxlzxssetting"))   
{
	//rs.executeSql("DELETE FROM formtable_main_245_dt1 "); 
	int rownum = Util.getIntValue(request.getParameter("rownum"),0);  
	String[] ids = request.getParameterValues("id"); 
	String[] lzmcs = request.getParameterValues("lzmc");
	String[] pxs = request.getParameterValues("px");
	for(int i=0; i<rownum; i++) {   
		String id = Util.null2String(ids[i]);
		String gs = weaver.general.Util.null2o(lzmcs[i]);  
		String px = weaver.general.Util.null2o(pxs[i]);    
		String sql ="";
		if(id.equals("")){
			sql = "INSERT INTO formtable_main_245_dt1(lzmc,px) VALUES ('"+gs+"',"+px+")"; 
		}else{
			sql = " update  formtable_main_245_dt1  set lzmc='"+gs+"',px="+px+"  where id="+id; 
		} 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}
if(method.equals("lxlzflsetting"))     
{
	String lxlzwhformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh"));
	rs.executeSql("DELETE FROM formtable_main_"+lxlzwhformid+"_dt2 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] lbzms = request.getParameterValues("lbzm");
	String[] firstypes = request.getParameterValues("firsttype"); //add firstype 
	String[] lbmcs = request.getParameterValues("lbmc"); 
	String[] pxs = request.getParameterValues("sx");
	String[] ssgss = request.getParameterValues("ssgs");
	for(int i=0; i<lbzms.length; i++) {  
		String catalogId = weaver.general.Util.null2String(lbzms[i]); 
		if(catalogId.equals("")){ 
			continue; 
		} 
		String lbzm = weaver.general.Util.null2o(lbzms[i]);  
		String firstype = weaver.general.Util.null2o(firstypes[i]);     
		String lbmc = weaver.general.Util.null2o(lbmcs[i]);     
		String sx = weaver.general.Util.null2o(pxs[i]);   
		String ssgs = weaver.general.Util.null2o(ssgss[i]);     
		   
		String sql = "INSERT INTO formtable_main_"+lxlzwhformid+"_dt2(lbzm,ssgs,firsttype,lbmc,sx) VALUES ('"+lbzm+"','"+ssgs+"','"+firstype+"','"+lbmc+"',"+sx+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}
if(method.equals("mrlcbsetting"))     
{
	rs.executeSql("DELETE FROM formtable_main_246_dt1 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] lcbmcs = request.getParameterValues("lcbmc");
	String[] pxs = request.getParameterValues("sx");
	for(int i=0; i<lcbmcs.length; i++) {  
		String lcbmc = weaver.general.Util.null2String(lcbmcs[i]);
		if(lcbmc.equals("")){ 
			continue; 
		} 
		String sx = weaver.general.Util.null2o(pxs[i]);   
		   
		String sql = "INSERT INTO formtable_main_246_dt1(lcbmc,xh) VALUES ('"+lcbmc+"',"+sx+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}else if(method.equals("firsttypesetting")){
	rs.executeSql("DELETE FROM firsttype "); 
	String[] ids = request.getParameterValues("id"); 
	String[] typevalues = request.getParameterValues("typevalue");
	String[] dsporders = request.getParameterValues("dsporder");
	for(int i=0; i<typevalues.length; i++) {  
		String typevalue = weaver.general.Util.null2String(typevalues[i]);
		if(typevalue.equals("")){ 
			continue; 
		} 
		String sx = weaver.general.Util.null2o(dsporders[i]);   
		   
		String sql = "INSERT INTO firsttype(typename,typevalue,dsporder) VALUES ('"+typevalue+"','"+typevalue+"',"+sx+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}
if(method.equals("rwwdflsetting"))     
{
	rs.executeSql("DELETE FROM formtable_main_248_dt1 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] lcbmcs = request.getParameterValues("flmc"); 
	String[] pxs = request.getParameterValues("sx");
	for(int i=0; i<lcbmcs.length; i++) {  
		String lcbmc = weaver.general.Util.null2String(lcbmcs[i]);
		if(lcbmc.equals("")){ 
			continue; 
		} 
		String sx = weaver.general.Util.null2o(pxs[i]);    
		   
		String sql = "INSERT INTO formtable_main_248_dt1(flmc,sx) VALUES ('"+lcbmc+"',"+sx+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}
if(method.equals("rwwdfjsetting"))     
{
	rs.executeSql("DELETE FROM formtable_main_247_dt1 "); 
	String[] ids = request.getParameterValues("id"); 
	String[] flmcs = request.getParameterValues("flmc"); 
	String[] fjfls = request.getParameterValues("fjfl"); 
	String[] sjkzds = request.getParameterValues("sjkzd"); 
	String[] sys = request.getParameterValues("sy");
	for(int i=0; i<flmcs.length; i++) {  
		String flmc = weaver.general.Util.null2String(flmcs[i]);
		if(flmc.equals("")){ 
			continue; 
		} 
		String fjfl = weaver.general.Util.null2o(fjfls[i]);    
		String sjkzd = weaver.general.Util.null2o(sjkzds[i]);    
		String sy = weaver.general.Util.null2o(sys[i]);     
		   
		String sql = "INSERT INTO formtable_main_247_dt1(flmc,fjfl,sjkzd,sy) VALUES ('"+flmc+"','"+fjfl+"','"+sjkzd+"',"+sy+")"; 
		rs.executeSql(sql); 
	}  
	response.sendRedirect("/project/setting/"+method+".jsp");  
	return; 
}

%>
