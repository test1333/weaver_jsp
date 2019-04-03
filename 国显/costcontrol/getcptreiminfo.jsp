<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.Util"%>
<%@page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="org.json.JSONObject"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%

BaseBean log = new BaseBean();
String cgddhs = Util.null2String(request.getParameter("cgddlcs"));
		String ysssqj = Util.null2String(request.getParameter("ysssqj"));
		String fycdbm = Util.null2String(request.getParameter("fycdbm"));
		String yskm = Util.null2String(request.getParameter("yskm"));
		if("".equals(cgddhs)||"".equals(ysssqj)||"".equals(fycdbm)||"".equals(yskm)){
			out.print("");
		}
		StringBuffer dataBuff = new StringBuffer();
		String tableName = "";
		String tableName2 = "";
		String podh = "";
		String yfxmbhs = "";//研发项目编号
		String nbddhs = "";//内部订单号
		String zcchs = "";//主资产号
		String flag = "";
		String  sql="select tablename from workflow_bill where id in (select formid from workflow_base where id = (select distinct workflowid from workflow_requestbase where requestid in("+cgddhs+")))";
		rs.executeSql(sql);
		if(rs.next()){
			tableName = Util.null2String(rs.getString("tablename"));
		}
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		sql="select a.orderNo||'-'||b.project as dh,b.purrequest,b.reqproject from "+tableName+" a,"+tableName+"_dt1 b where a.id=b.mainid and a.requestid in("+cgddhs+") and substr(b.fyqj,0,4)='"+ysssqj.substring(0,4)+"' and fykm='"+yskm+"' and fycdbm='"+fycdbm+"'";
		rs.executeSql(sql);
		while(rs.next()){
			podh = podh + flag +Util.null2String(rs.getString("dh"));
			flag=",";
			Map<String, String> map = new HashMap<String, String>();
			map.put("purrequest", Util.null2String(rs.getString("purrequest")));
			map.put("reqproject", Util.null2String(rs.getString("reqproject")));
			list.add(map);
		}
		
		for(Map<String,String> map:list){
			String purrequest = map.get("purrequest");
			String reqproject = map.get("reqproject");
			String lcid = "";
			sql="select lcid from uf_pr_budget where cgsqdh='"+purrequest+"' and mxhid='"+reqproject+"' order by id asc";
			rs.executeSql(sql);
			if(rs.next()){
				lcid = Util.null2String(rs.getString("lcid"));
			}
			if(!"".equals(lcid)){
				sql="select tablename from workflow_bill where id in (select formid from workflow_base where id = (select distinct workflowid from workflow_requestbase where requestid in("+lcid+")))";
				rs.executeSql(sql);
				if(rs.next()){
					tableName2 = Util.null2String(rs.getString("tablename"));
				}
				sql="select distinct a.yfxmbh,b.nbddh,b.zcch from "+tableName2+" a,"+tableName2+"_dt1 b where a.id=b.mainid and a.requestid="+lcid;
				rs.executeSql(sql);
				while(rs.next()){
					String yfxmbh = Util.null2String(rs.getString("yfxmbh"));
					String nbddh = Util.null2String(rs.getString("nbddh"));
					String zcch = Util.null2String(rs.getString("zcch"));
					if(!"".equals(yfxmbh)){
						if("".equals(yfxmbhs)){
							yfxmbhs = yfxmbh; 
						}else{
							if((","+yfxmbhs+",").indexOf(","+yfxmbh+",")<0){
								yfxmbhs = yfxmbhs+","+yfxmbh; 
							}
						}
					}
					
					if(!"".equals(nbddh)){
						if("".equals(nbddhs)){
							nbddhs = nbddh; 
						}else{
							if((","+nbddhs+",").indexOf(","+nbddh+",")<0){
								nbddhs = nbddhs+","+nbddh; 
							}
						}
					}
					
					if(!"".equals(zcch)){
						if("".equals(zcchs)){
							zcchs = zcch; 
						}else{
							if((","+zcchs+",").indexOf(","+zcch+",")<0){
								zcchs = zcchs+","+zcch; 
							}
						}
					}
					
				}
			}
		}
	dataBuff.append(podh);
	dataBuff.append("###");
	dataBuff.append(yfxmbhs);
	dataBuff.append("###");
	dataBuff.append(nbddhs);
	dataBuff.append("###");
	dataBuff.append(zcchs);
    out.print(dataBuff.toString());
%>

