<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSetDataSource" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="feilida.finance.adore.GetCostCenterFI08" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page"/>
<%

	  StringBuffer dataBuff = new StringBuffer();
      String reqid = request.getParameter("reqid");//requestId
	  GetCostCenterFI08 gccf = new GetCostCenterFI08();
      if(reqid.length()>0){
		String tmp_reqid = reqid+",0";
      	String sql = " select m.requestid,m.fbdm,decode(m.cgmsh,0,m.shqbm,1,m.shybm,'') as dept,dt.guige,dt.danwei,dt.shl,dt.ysxx,dt.bz,dt.km,dt.cptname,dt.YSjine,"
		  +" dt.nbdd,dt.nbddms,dt.ywfw,dt.ywfwmc,dt.sm,dt.shlv,dt.shj,dt.zcms from formtable_main_115 m left join formtable_main_115_dt1 dt "
		  +" on m.id=dt.mainid where requestid in("+tmp_reqid+") ";
      	//out.print("sql ="+sql);
	  	rs.executeSql(sql);
	 	while(rs.next()) {
			String fbdm = Util.null2String(rs.getString("fbdm"));
   			String dept = Util.null2String(rs.getString("dept"));
			String sql_dept = "select departmentname from hrmdepartment where id="+dept;
			res.executeSql(sql_dept);
			//log.writeLog("sql_1="+sql_1);
			if(res.next()){
				String deptname = Util.null2String(res.getString("departmentname"));
				dataBuff.append(deptname);
				dataBuff.append("###");
				String costCenter = gccf.getCostCenter(fbdm,deptname);
				dataBuff.append(costCenter);
			}
			//dataBuff.append(dept);
			dataBuff.append("###");

			String cptid = Util.null2String(rs.getString("cptname"));
			String sql_cpt = " select name,capitalspec from Cptcapital where id="+cptid;
			res.executeSql(sql_cpt);
			//log.writeLog("sql_1="+sql_1);
			if(res.next()){
				String cptname = Util.null2String(res.getString("name"));
				//String cptms = Util.null2String(res.getString("capitalspec"));
				dataBuff.append(cptname);
				//dataBuff.append("###");
				//dataBuff.append(cptms);
			}
			dataBuff.append("###");

			String zcms = Util.null2String(rs.getString("zcms"));
			dataBuff.append(zcms);
			dataBuff.append("###");

			String ysje = Util.null2String(rs.getString("YSjine"));
			dataBuff.append(ysje);
			dataBuff.append("###");

			String ysxx = Util.null2String(rs.getString("ysxx"));
			dataBuff.append(ysxx);
			dataBuff.append("###");

			String ywfw = Util.null2String(rs.getString("ywfw"));
			dataBuff.append(ywfw);
			dataBuff.append("###");

			String ywfwmc = Util.null2String(rs.getString("ywfwmc"));
			dataBuff.append(ywfwmc);
			dataBuff.append("###");

			String sm = Util.null2String(rs.getString("sm"));
			dataBuff.append(sm);
			dataBuff.append("###");

			String shlv = Util.null2String(rs.getString("shlv"));
			dataBuff.append(shlv);
			dataBuff.append("###");

			String shj = Util.null2String(rs.getString("shj"));
			dataBuff.append(shj);
			dataBuff.append("###");

			String nbdd = Util.null2String(rs.getString("nbdd"));
			dataBuff.append(nbdd);
			dataBuff.append("###");

			String nbddms = Util.null2String(rs.getString("nbddms"));
			dataBuff.append(nbddms);
			dataBuff.append("@@@");
			}
		}
		out.print(dataBuff.toString());
%>