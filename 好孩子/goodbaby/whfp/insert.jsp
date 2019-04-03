<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="goodbaby.pz.GetGNSTableName"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="weaver.formmode.setup.ModeRightInfo"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%
BaseBean log = new BaseBean();
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
String fprqs = Util.null2String(request.getParameter("fprqs"));
String fpjehs = Util.null2String(request.getParameter("fpjehs"));
String fpbz = Util.null2String(request.getParameter("fpbz"));
GetGNSTableName gg = new GetGNSTableName();
String tablename =  gg.getTableName("RKD");
String cgddtable =  gg.getTableName("CGDD");
String kjtable = gg.getTableName("FKJHT");
String sql_dt = "";
String ddlcs="";
String flag = "";
if(fphm.length()>4){
	String ph[] =fphm.split(",");
	String slcs[] =slc.split(",");
	String sjcs[] =sjc.split(",");
	String dgjes[] =dgje.split(",");
	String fprqarr[] =fprqs.split(",");
	String fpjeharr[] =fpjehs.split(",");
	for(int i=0;i<ph.length;i++){
	String mainid = "";
	String cgdlm = "";
	String yjcbzxmain = "";
	String sql1 = "insert into uf_invoice(bz,fprq,fpjews,zjlbm,gys,xtkh,fphm,fpze,whsj,formmodeid,modedatacreater,fplx,sl,sj) values ('"+fpbz+"','"+fprqarr[i]+"','"+dgjes[i]+"','"+zjlbm+"','"+gsyids+"','"+xtgysids+"','"+ph[i]+"','"+fpjeharr[i]+"',CONVERT(varchar(10),GETDATE(),120),60,1,";
	
	if(wplx.equals("lx")){
		sql1 = sql1+ "0,'"+slcs[i]+"','"+sjcs[i]+"')";
	}else{
		sql1 = sql1 + "1,'"+slcs[i]+"','"+sjcs[i]+"')";
	}
	//log.writeLog("insert.jsp sql1="+sql1);
	//out.print("sql1----"+sql1+"----");
	rs.executeSql(sql1);
	sql1 = "select max(id) as mid from uf_invoice where gys='"+gsyids+"' and fphm = '"+ph[i]+"'  ";
	rs.executeSql(sql1);
	if(rs.next()){
		mainid = rs.getString("mid");
	}
	ddlcs="";
    flag = "";
	ModeRightInfo modeRightInfo = new ModeRightInfo();
	modeRightInfo.editModeDataShare(1, 60, Integer.parseInt(mainid));
	modeRightInfo.editModeDataShareForModeField(1, 60, Integer.parseInt(mainid));
	String sql2 = "select a.id,a.xtgys,c.WLMC_1,c.gys,d.wlmc ,(select ub.buydl from uf_buydl ub join uf_NPP un on un.buydl=ub.id where un.id=d.wllx ) as lxmc ,(select ub.id from uf_buydl ub join uf_NPP un on un.buydl=ub.id where un.id=d.wllx ) as lxid,a.RKDH,(select top 1 rkrq from uf_Stock where lch =a.requestid order by id desc ) as rksj ,(select dw from uf_unitForms where id= d.dw) as dw,d.dw as dwid,c.SJSHSL_1,c.DJ_1,c.JE_1,(select CKMC from uf_stocks where id = a.SHCK) as ck,a.SHCK,c.WLBH_1,c.cgsqd  "
				+" ,e.HL,e.taxRate,(select taxname from uf_tax_rate where id=e.taxRate) as taxname,e.BIZ,(select bz1 from uf_hl where id=e.BIZ) as bz,  cast(round(isnull(c.JE_1,0)/(1+isnull((select rate from uf_tax_rate where id=e.taxRate),0)),2)   as   numeric(12,2)) as wsje,contactDtId,(select rate from uf_tax_rate where id=e.taxRate) as rate,d.wllx as npplx,a.requestid,e.DDBH,a.cgdl,(select yjcbzx from uf_cbzx where id=a.cbzx) as yjcbzx "
				+" from  "+tablename+" a , workflow_requestbase b ,"+tablename+"_dt1 c ,uf_materialDatas d,"+cgddtable+" e"
				+" where  a.requestid=b.requestid"
				+" and c.mainid = a.id "
				+" and c.cgsqd=e.requestid"
				+" and c.wlmc_1 = d.id"
				+" and b.currentnodetype >= 3 "
				+" and a.id in("+ids+")";
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
		String HL = Util.null2String(rs.getString("HL"));
		String taxname = Util.null2String(rs.getString("taxname"));
		String bz = Util.null2String(rs.getString("bz"));
		String wsje = Util.null2String(rs.getString("wsje"));
		String rate = Util.null2String(rs.getString("rate"));
		String sj = "0.00";
		String rmbje = "0.00";
		String contactDtId =  Util.null2String(rs.getString("contactDtId"));
		String cgddbh =  Util.null2String(rs.getString("DDBH"));
		String cgdl = Util.null2String(rs.getString("cgdl"));
		String yjcbzx = Util.null2String(rs.getString("yjcbzx"));
		if("".equals(yjcbzxmain)){
			yjcbzxmain = yjcbzx;
		}
		if("".equals(cgdlm)){
			cgdlm = cgdl;
		}
		if(!"".equals(ddlc) && ddlcs.indexOf(ddlc)<0){
			ddlcs = ddlcs+flag+ddlc;
			flag = ",";
		}
		if(npplx.equals("")|| npplx==null  ){
			npplx = "0";
		}
		if("".equals(rate)){
			rate = "0";
		}
		if(DJ_1.length()<1){
			DJ_1 = "0.00";
		}
	
		if("".equals(HL)){
			HL="1.0000";
		}
		if("flx".equals(wplx)){
			JE_1 = "0.00";
			sql_dt = "select fkje,cast(round(isnull(fkje,0)/(1+"+rate+"),2)   as   numeric(12,2)) as wsje from "+kjtable+"_dt1 where id="+contactDtId;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				JE_1 =  Util.null2String(rs_dt.getString("fkje"));
				wsje =  Util.null2String(rs_dt.getString("wsje"));
			}
		}
		if(JE_1.length()<1){
			JE_1 = "0.00";
		}
		if("".equals(wsje)){
			wsje = "0.00";
		}
		sql_dt = "select   cast(round("+JE_1+"-"+wsje+",2) as numeric(12,2)) as sj,   cast(round("+JE_1+"*"+HL+",2)   as   numeric(12,2)) as rmbje ";
		//out.print(sql_dt);
		rs_dt.executeSql(sql_dt);
		if(rs_dt.next()){
			sj = Util.null2String(rs_dt.getString("sj"));
			rmbje = Util.null2String(rs_dt.getString("rmbje"));
		}
		
		sql_dt ="insert into uf_invoice_dt1 (wlmc,wlbm,wllx,wllx1,rkdh,rkrq,rkdw,rksl,sjjg,ckmc,ddlc,rid,mainid,taxname,sj,wsje,JE,bz,HL,rmbje,cgddbh,cgdl) values('"+WLMC_1+"','"+WLBH_1+"','"+npplx+"','"+lxid+"','"+RKDH+"','"+rksj+"','"+dwid+"','"+SJSHSL_1+"','"+DJ_1+"','"+ckid+"','"+ddlc+"','"+rid+"','"+mainid+"','"+taxname+"','"+sj+"','"+wsje+"','"+JE_1+"','"+bz+"','"+HL+"','"+rmbje+"','"+cgddbh+"','"+cgdl+"')";
		//log.writeLog("insert.jsp sql_dt:"+sql_dt);
		rs_dt.executeSql(sql_dt);		
		//out.print("str----"+str+"----");
	}
	String contactReq = "";
	sql1 = "select contactReq from uf_invoice_dt1 a,formtable_main_240 b where a.ddlc = b.requestid and contactdtid is not null and mainid="+mainid;
	rs.executeSql(sql1);
	if(rs.next()){
		contactReq = Util.null2String(rs.getString("contactReq"));
	}
	sql1 = "update uf_invoice set cgddlcs='"+ddlcs+"',cgdl='"+cgdlm+"',yjcbzx='"+yjcbzxmain+"',fljhtlc='"+contactReq+"' where id="+mainid;
	rs.executeSql(sql1);
	
	
}




}
out.print("1");
%>