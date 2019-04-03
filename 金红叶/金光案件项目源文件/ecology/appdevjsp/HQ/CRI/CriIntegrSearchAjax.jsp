<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.file.ExcelStyle" %>
<%@ page import="weaver.file.ExcelSheet" %>
<%@ page import="weaver.file.ExcelRow" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.general.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.formmode.setup.ModeRightInfo" %>
<%@ page import="weaver.hrm.resource.ResourceComInfo" %>
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BaseBean" class="weaver.general.BaseBean" scope="page" />
<style type="text/css">
.rowcss:hover{
  background:#f8f8f8;
}
table{
	width:100%;
}
.xh{
	width:10px;
	text-align:center;
	padding:5px!important;
}
.td1{
	width:50px;
	text-align:center;
	padding:5px!important;
}
.td2{
	width:20px;
	text-align:center;
	font-weight:bold;
	background-color:#f8f8f8;
}
</style>
<%
String key = Util.null2String(request.getParameter("key"));
String nowdate=TimeUtil.getCurrentDateString();
String nowtime=TimeUtil.getCurrentTimeString();
String time = nowtime.substring(11,nowtime.length());
nowtime = nowtime.substring(11,16);

String userid=user.getUID()+"";
List<Map<String,String>> list=new ArrayList<Map<String,String>>();	
//作案手法
rs.executeSql(" select id from uf__hq_cri_thecrime where Upper(zasf) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id   and   instr(','||t1.zasf||',' , ',"+id+",' )>0  ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("id",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11234, user.getLanguage()));
		list.add(map);
	}
}

//关键词列表	
rs.executeSql(" select id from uf_hq_cri_keyword where Upper(gjc) like '%'||Upper('"+key+"')||'%'  ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.gjclb||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-10952, user.getLanguage()));
		list.add(map);
	}
}


//案件名称	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.xmmc) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11594, user.getLanguage()));
	list.add(map);
}
	
//举报摘要	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.jbzy) like '%'||Upper('"+key+"')||'%'    ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11216, user.getLanguage()));
	list.add(map);
}

//涉案单位	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(gsmc) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.sadw||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11237, user.getLanguage()));
		list.add(map);
	}
}

//涉案事业部	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.sasyb) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11238, user.getLanguage()));
	list.add(map);
}

//关联案件	
rs.executeSql(" select id from uf_hq_cri_noticeoao where Upper(xmmc) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.glaj||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11240, user.getLanguage()));
		list.add(map);
	}
}


//关联单位	
rs.executeSql(" select id from uf_hq_cri_involcomp where Upper(gsmc)  like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.qtgldw||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11188, user.getLanguage()));
		list.add(map);
	}
}


//关联人员	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.qtglry||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11152, user.getLanguage()));
		list.add(map);
	}
}


//对应举报人	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.dyjbr||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11213, user.getLanguage()));
		list.add(map);
	}
}

//对应被举报对象	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.dybjbdx||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11214, user.getLanguage()));
		list.add(map);
	}
}

//对应证人	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.dyzr||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11243, user.getLanguage()));
		list.add(map);
	}
}

//对应举报编号	
rs.executeSql(" select id from uf_hq_cri_reporthp where Upper(jbbh) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.dyjbbh||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11426, user.getLanguage()));
		list.add(map);
	}
}

//嫌疑对象	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.xydx||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-11245, user.getLanguage()));
		list.add(map);
	}
}

//证人	
rs.executeSql(" select id from uf_hq_cri_involpers where Upper(xm) like '%'||Upper('"+key+"')||'%' ");
while(rs.next()){
	String id=rs.getString("id");
	rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  instr(','||t1.zr||',' , ',"+id+",' )>0 ");
	while(rs1.next()){
		Map<String,String> map=new HashMap<String,String>();
		String dataid=rs1.getString("dataid");
		String xmbh=rs1.getString("xmbh");
		String xmmc=rs1.getString("xmmc");
		String dcqdrq=rs1.getString("dcqdrq");
		String dcy=rs1.getString("dcy");
		map.put("dataid",dataid);
		map.put("xmbh",xmbh);
		map.put("xmmc",xmmc);
		map.put("dcqdrq",dcqdrq);
		map.put("dcy",dcy);
		map.put("mzzd",SystemEnv.getHtmlLabelName(-10926, user.getLanguage()));
		list.add(map);
	}
}

//举报接收方	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.jbjsf) like '%'||Upper('"+key+"')||'%'    ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11204, user.getLanguage()));
	list.add(map);
}

//调查计划	
rs1.executeSql(" select t4.id as dataid,t2.* from uf_hq_cri_casedp t4,  uf_hq_cri_surveypla t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.xmbh=t2.id  and  ( Upper(t1.sjqtwb) like '%'||Upper('"+key+"')||'%'  or   Upper(t1.jaqtwb) like '%'||Upper('"+key+"')||'%' or   Upper(t1.bz) like '%'||Upper('"+key+"')||'%' )  ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11031, user.getLanguage()));
	list.add(map);
}

//每周追踪	
rs1.executeSql(" select t4.id as dataid ,t2.* from  uf_hq_cri_casedp t4, uf_hq_cri_weeklytra t1 , uf_hq_cri_weeklytra_dt1 t3  ,uf_hq_cri_noticeoao t2  where  t4.xmbh=t2.id and   t1.id=t3.mainid and  t1.xmbh=t2.id  and  ( Upper(t3.bzwc) like '%'||Upper('"+key+"')||'%'  or   Upper(t3.xzjh) like '%'||Upper('"+key+"')||'%' or   Upper(t3.zs) like '%'||Upper('"+key+"')||'%' or   Upper(t3.nz) like '%'||Upper('"+key+"')||'%'   )  ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11034, user.getLanguage()));
	list.add(map);
}


//确认损失说明	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.qrsssm) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11249, user.getLanguage()));
	list.add(map);
}


//预防损失（估算）说明	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.yfssgssm) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-10967, user.getLanguage()));
	list.add(map);
}


//追回损失（估算）说明	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.zhssgssm) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11254, user.getLanguage()));
	list.add(map);
}

//流程缺失说明	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.lcqssm) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11257, user.getLanguage()));
	list.add(map);
}


//电脑取证发现有价值数据概述	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.dnqznr) like '%'||Upper('"+key+"')||'%'  ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11261, user.getLanguage()));
	list.add(map);
}


//备注	
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(t1.bz) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(28108, user.getLanguage()));
	list.add(map);
}

//案件背景	
rs1.executeSql(" select t4.id as dataid , t2.* from uf_hq_cri_casedp t4 , uf_hq_cri_summarysr t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.ajbj) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11299, user.getLanguage()));
	list.add(map);
}

//调查概述	
rs1.executeSql(" select t4.id as dataid, t2.* from uf_hq_cri_casedp t4, uf_hq_cri_summarysr t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.dcgs) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11301, user.getLanguage()));
	list.add(map);
}

//主要证据列表
rs1.executeSql(" select t1.id as dataid ,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(sasyb) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11598, user.getLanguage()));
	list.add(map);
}

//人事支持	
rs1.executeSql(" select t4.id as dataid,t2.* from uf_hq_cri_casedp t4 , uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh =t2.id and  t1.xmbh=t2.id  and  Upper(t1.rszc) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11309, user.getLanguage()));
	list.add(map);
}

//调查背景	
rs1.executeSql(" select t4.id as dataid,t2.* from uf_hq_cri_casedp t4 , uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.tcbj) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11311, user.getLanguage()));
	list.add(map);
}

//调查的职权范围	
rs1.executeSql(" select t4.id as dataid, t2.* from  uf_hq_cri_casedp t4,  uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.tcdzqfw) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11312, user.getLanguage()));
	list.add(map);
}

//调查过程	
rs1.executeSql(" select t4.id as dataid, t2.* from uf_hq_cri_casedp t4,  uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where  t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.tcgc) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11313, user.getLanguage()));
	list.add(map);
}

//调查发现	
rs1.executeSql(" select t4.id as dataid, t2.* from uf_hq_cri_casedp t4,  uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where  t4.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.tcfx) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11314, user.getLanguage()));
	list.add(map);
}

//结论和建议	
rs1.executeSql(" select t4.id as dataid,t2.* from uf_hq_cri_casedp t4, uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and t1.xmbh=t2.id  and  Upper(t1.jlhjy) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11315, user.getLanguage()));
	list.add(map);
}


//员工纪录处分（员工姓名、过错\违规、处理意见和建议）	
rs1.executeSql(" select t4.id as dataid,t2.* from uf_hq_cri_casedp t4, uf_hq_cri_investiga t1 , uf_hq_cri_investiga_dt1 t3  ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.id=t3.mainid and    t1.xmbh=t2.id  and  (  t3.ygxm  in ( select id from uf_hq_cri_involpers t4  where Upper(t4.xm) like '%'||Upper('"+key+"')||'%' )  or  Upper(t3.gcwg) like '%'||Upper('"+key+"')||'%'   or  '极其严重'  like '%"+key+"%'   or  '严重'  like '%"+key+"%'   or  '中等'  like '%"+key+"%'   or  '轻度'  like '%"+key+"%')   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11599, user.getLanguage()));
	list.add(map);
}


//其他	
rs1.executeSql(" select t3.id as dataid,t2.* from uf_hq_cri_casedp t3, uf_hq_cri_investiga t1 ,uf_hq_cri_noticeoao t2  where t3.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.qt) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(25740, user.getLanguage()));
	list.add(map);
}

//第X周-本周完成	
rs1.executeSql(" select t4.id as dataid,t2.* from  uf_hq_cri_casedp t4 , uf_hq_cri_weeklytra t1 ,  uf_hq_cri_weeklytra_dt1  t3  ,uf_hq_cri_noticeoao t2  where  t4.xmbh=t2.id and   t1.xmbh=t2.id  and  Upper(t3.bzwc) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11600, user.getLanguage()));
	list.add(map);
}


//第X周-下周计划	
rs1.executeSql(" select t4.id as dataid ,t2.* from  uf_hq_cri_casedp t4 , uf_hq_cri_weeklytra t1 ,  uf_hq_cri_weeklytra_dt1  t3  ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and t1.xmbh=t2.id  and  Upper(t3.xzjh) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11601, user.getLanguage()));
	list.add(map);
}


//人员处理（姓名、最终处理结果、人事支持、附件上传）	
rs1.executeSql(" select t4.id as dataid, t2.* from uf_hq_cri_casedp t4 ,  uf_hq_cri_citabapo t1 , uf_hq_cri_citabapo_dt1 t3  ,uf_hq_cri_noticeoao t2  where t4.xmbh=t2.id and  t1.id=t3.mainid and   t1.xmbh=t2.id  and  ( t3.xm in ( select id from uf_hq_cri_involpers t4 where  Upper(t4.xm) like '%'||Upper('"+key+"')||'%' )  or  Upper(t3.zzcljg) like '%'||Upper('"+key+"')||'%'  or  t3.rszc in ( select id from hrmresource where Upper(lastname) like '%'||Upper('"+key+"')||'%' )  )   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11259, user.getLanguage()));
	list.add(map);
}


//流程缺失追踪（增补、修改说明、附件上传）	
rs1.executeSql(" select t1.id as dataid,t2.* from uf_hq_cri_casedp t1 ,uf_hq_cri_noticeoao t2  where  t1.xmbh=t2.id  and  Upper(sasyb) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11602, user.getLanguage()));
	list.add(map);
}


//移交警方（执法单位名称、办案人员、联系方式、移交警方概述）	
rs1.executeSql(" select t3.id as dataid ,t2.* from uf_hq_cri_casedp t3 ,uf_hq_cri_citabapo t1 ,uf_hq_cri_noticeoao t2  where t3.xmbh=t2.id and  t1.xmbh=t2.id  and  Upper(t1.yjjfgs) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11338, user.getLanguage()));
	list.add(map);
}


//其它情况说明	
rs1.executeSql(" select t3.id as dataid ,t2.* from  uf_hq_cri_casedp t3 ,  uf_hq_cri_citabapo t1 ,uf_hq_cri_noticeoao t2  where  t3.xmbh=t2.id and   t1.xmbh=t2.id  and  Upper(t1.qtqhsm) like '%'||Upper('"+key+"')||'%'   ");
while(rs1.next()){
	Map<String,String> map=new HashMap<String,String>();
	String dataid=rs1.getString("dataid");
	String xmbh=rs1.getString("xmbh");
	String xmmc=rs1.getString("xmmc");
	String dcqdrq=rs1.getString("dcqdrq");
	String dcy=rs1.getString("dcy");
	map.put("dataid",dataid);
	map.put("xmbh",xmbh);
	map.put("xmmc",xmmc);
	map.put("dcqdrq",dcqdrq);
	map.put("dcy",dcy);
	map.put("mzzd",SystemEnv.getHtmlLabelName(-11334, user.getLanguage()));
	list.add(map);
}
UUID uuid = UUID.randomUUID();  
String str = uuid.toString();  
for(int i=0;i<list.size();i++){
	Map<String,String> maptemp=(Map<String,String>)list.get(i);
	String dataid=(String)maptemp.get("dataid");
	String xmbh=(String)maptemp.get("xmbh");
	String xmmc=(String)maptemp.get("xmmc");
	String dcqdrq=(String)maptemp.get("dcqdrq");
	String dcy=getLastname((String)maptemp.get("dcy"));
	String mzzd=(String)maptemp.get("mzzd");
	rs.executeSql(" insert into uf_ajzhss(formmodeid,modedatacreater,modedatacreatertype,modedatacreatedate,modedatacreatetime,keywords,ajID,mzzd,ssrq,sssj,UUID,ssr,xmbh,xmmc,dcqdrq,dcy) "+
		" values ('1004','1','0','"+nowdate+"','"+time+"','"+key+"','"+dataid+"','"+mzzd+"','"+nowdate+"','"+nowtime+"','"+str+"','"+userid+"','"+xmbh+"','"+xmmc+"','"+dcqdrq+"','"+dcy+"'  ) ");
	rs.executeSql(" select max(id) as maxid from uf_ajzhss ");
	if(rs.next()){
		int maxid=rs.getInt("maxid");
		ModeRightInfo rightinfo = new ModeRightInfo();
		rightinfo.editModeDataShare(1,1004,maxid);
	}
}

%>
 <table border="1px" bordercolor="#e6e6e6" cellspacing="0px" style="border-collapse:collapse">
	<tr>
		<td align="left"  colspan="6" style="font-weight:bold;padding-left:20px;"><input type="hidden" id="aj" value="<%=str%>"/><%=SystemEnv.getHtmlLabelName(-11595, user.getLanguage())%><span style="color:#30b5ff;">:&nbsp;<%=list.size()%></span>&nbsp;<%=SystemEnv.getHtmlLabelName(-11603, user.getLanguage())%>!</td>
	</tr>
	<%if(list.size()>0){%>
	<tr>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(126028, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11593, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11594, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-10935, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-10936, user.getLanguage())%></td>
		<td class="td2" align="center" style="font-weight:bold;"><%=SystemEnv.getHtmlLabelName(-11582, user.getLanguage())%></td>
	</tr>
	 <%
		int num=0;
		rs.executeSql(" select * from uf_ajzhss where uuid='"+str+"' order by xmbh desc ");
		while(rs.next()){
			String ajID=rs.getString("ajID");
			String xmbh=rs.getString("xmbh");
			String xmmc=rs.getString("xmmc");
			String dcqdrq=rs.getString("dcqdrq");
			String dcy=rs.getString("dcy");
			String mzzd=rs.getString("mzzd");
		%>		
			<tr class='rowcss <%if(num>5){out.print("hiderow");}%>' >
				<td class='xh' align='center'><%=num+1%></td>
				<td class='td1' align='center'><a  target="_blank" href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid=<%=ajID%>&opentype=0&customid=882&viewfrom=fromsearchlist'><%=xmbh%></a></td>
				<td class='td1' align='center'><a  target="_blank" href='/formmode/view/ViewMode.jsp?type=0&modeId=852&formId=-151&billid=<%=ajID%>&opentype=0&customid=882&viewfrom=fromsearchlist'><%=xmmc%></a></td>
				<td class='td1' align='center'><%=dcqdrq%></td>
				<td class='td1' align='center'><%=dcy%></td>
				<td class='td1' align='center'><%=mzzd%></td>
			</tr>
		 <%
			num=num+1;
		}	
		if( list.size()>5 ){
		%>	
			<tr class='rowcss'  >
				<td class='td1'  colspan="6" align='center' >
					<input  id='showALL' type="button" value="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..." class="e8_btn_top_first" title="<%=SystemEnv.getHtmlLabelName(20234, user.getLanguage())%>..."  onclick="showALL()"  style="max-width: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"/>
				</td>
			</tr>
		<%
		}
	}
		%>		
</table>
<%!
public String getLastname(String dcy){
	String dcyname="";
	if(!"".equals(dcy.trim())){
		RecordSet rs=new RecordSet();
		rs.executeSql(" select wm_concat(lastname) dcyname from hrmresource where workcode in ("+dcy+") ");
		if(rs.next()){
			dcyname=rs.getString("dcyname");
		}
	}
	return dcyname;
}
%>