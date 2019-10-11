<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
String ids = Util.null2String(request.getParameter("ids"));
String types = Util.null2String(request.getParameter("type"));
String wplx = Util.null2String(request.getParameter("wplx"));
String fphj = Util.null2String(request.getParameter("fphj"));
String fphm = Util.null2String(request.getParameter("fphm"));
String gsyids = Util.null2String(request.getParameter("gsyid"));
String xtgysids = Util.null2String(request.getParameter("xtgysid"));
String slc = Util.null2String(request.getParameter("slc"));
String sjc = Util.null2String(request.getParameter("sjc"));
String dgje = Util.null2String(request.getParameter("dgje"));
String zjlbm = Util.null2String(request.getParameter("zjlbm"));
if(fphm.length()>4){
	String ph[] =fphm.split(",");
	String slcs[] =slc.split(",");
	String sjcs[] =sjc.split(",");
	String dgjes[] =dgje.split(",");
	for(int i=0;i<ph.length;i++){
	String mainid = "";
	String sql1 = "insert into uf_invoice(zjlbm,gys,xtkh,fphm,fpze,whsj,formmodeid,modedatacreater,fplx,sl,sj) values ('"+zjlbm+"','"+gsyids+"','"+xtgysids+"','"+ph[i]+"','"+dgjes[i]+"',CONVERT(varchar(10),GETDATE(),120),60,1,";
	if(wplx.equals("lx")){
		sql1 = sql1+ "0,'"+slcs[i]+"','"+sjcs[i]+"')";
	}else{
		sql1 = sql1 + "1,'"+slcs[i]+"','"+sjcs[i]+"')";
	}
	
	//out.print("sql1----"+sql1+"----");
	rs.executeSql(sql1);
	sql1 = "select max(id) as mid from uf_invoice where gys='"+gsyids+"' and fphm = '"+ph[i]+"'  ";
	rs.executeSql(sql1);
	if(rs.next()){
		mainid = rs.getString("mid");
	}
	ModeRightInfo modeRightInfo = new ModeRightInfo();
	modeRightInfo.editModeDataShare(1, 60, Integer.parseInt(mainid));
	modeRightInfo.editModeDataShareForModeField(1, 60, Integer.parseInt(mainid));
	String sql2 = "select tt.id,tt.xtgys,tt.WLMC_1,tt.requestid,tt.cgsqd,tt.gys,tt.dwid,tt.RKDH,tt.SHCK,tt.rksj,tt.SJSHSL_1,tt.DJ_1,tt.JE_1,tt.WLBH_1,tt.lxmc,tt.lxid from (select a.id,a.requestid,a.xtgys,c.WLMC_1,c.gys,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id join uf_materialDatas um on um.WLLX = un.id where um.id =c.WLMC_1) as lxid,a.RKDH,(select WLLX from  uf_materialDatas um where um.id =c.WLMC_1)as npplx,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj,(select DW from uf_materialDatas where id = c.WLMC_1)as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,a.SHCK,c.WLBH_1,c.cgsqd from formtable_main_243 a join workflow_requestbase b on a.requestid=b.requestid join formtable_main_243_dt1 c on c.mainid = a.id where b.currentnodetype >= 3 ) tt where tt.id in("+ids+")";
	rs.executeSql(sql2);
	while(rs.next()){
		String id = Util.null2String(rs.getString("id"));
		String xtgys = Util.null2String(rs.getString("xtgys"));//id
		String WLMC_1 = Util.null2String(rs.getString("WLMC_1"));//id
		String RKDH = Util.null2String(rs.getString("RKDH"));
		String rksj = Util.null2String(rs.getString("rksj"));
		String dwid = Util.null2String(rs.getString("dwid"));//id
		String SJSHSL_1 = Util.null2String(rs.getString("SJSHSL_1"));
		String DJ_1 = Util.null2String(rs.getString("DJ_1"));
		String JE_1 = Util.null2String(rs.getString("JE_1"));
		String ckid = Util.null2String(rs.getString("SHCK"));//id
		String WLBH_1 = Util.null2String(rs.getString("WLBH_1"));
		String lxmc = Util.null2String(rs.getString("lxmc"));
		String lxid = Util.null2String(rs.getString("lxid"));
		String npplx = Util.null2String(rs.getString("npplx"));
		String cgsqd = Util.null2String(rs.getString("cgsqd"));		
		String ddlc = Util.null2String(rs.getString("cgsqd"));
		String rid = Util.null2String(rs.getString("requestid"));
		
		if(npplx.equals("")|| npplx==null  ){
			npplx = "0";
		}
		if(DJ_1.equals("")|| DJ_1==null  ){
			DJ_1 = "0.0";
		}
		String str ="insert into uf_invoice_dt1 (wlmc,wlbm,wllx,wllx1,rkdh,rkrq,rkdw,rksl,sjjg,ckmc,ddlc,rid,mainid) values('"+WLMC_1+"','"+WLBH_1+"','"+npplx+"','"+lxid+"','"+RKDH+"','"+rksj+"','"+dwid+"','"+SJSHSL_1+"','"+DJ_1+"','"+ckid+"','"+ddlc+"','"+rid+"','"+mainid+"')";
		rs.executeSql(str);		
		//out.print("str----"+str+"----");
	}
	
	
	
	
}




}
out.print("1");
%>