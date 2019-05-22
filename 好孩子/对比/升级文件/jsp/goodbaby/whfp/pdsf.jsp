<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ page import="goodbaby.pz.*"%>
<jsp:useBean id="res" class="weaver.conn.RecordSet" scope="page" />
<%
	GetGNSTableName gg = new GetGNSTableName();
	String tablename_rksq = gg.getTableName("FKSQD");
	String fphm = Util.null2String(request.getParameter("fphm"));
	String types = Util.null2String(request.getParameter("type"));
	String ids = Util.null2String(request.getParameter("ids"));
	//out.print("fphm--"+fphm+"--types--"+types+"--ids--"+ids);
	if(types.equals("insert")){
		String ph [] = fphm.split(",");
		int con = 0;
		
		for(int i=0;i<ph.length;i++){
			String sql = "select count(id)as con from uf_invoice where fphm ='"+ph[i]+"'";
			res.executeSql(sql);
			if(res.next()){
				con = res.getInt("con");
			}
			if(con>0){
				out.print("1");
				return;
			}		
			
		}
		
		
	}else if(types.equals("edit")){
		int con = 0;
		String sql = "select count(id) as cons from "+tablename_rksq+"_dt1  where fphm ='"+ids+"' ";
		res.executeSql(sql);
		if(res.next()){
			con = res.getInt("cons");
		}
		if(con>0){
			out.print("1");
		}
	}else if(types.equals("delete")){
		int con = 0;
		String sql = "select count(id) as cons from "+tablename_rksq+"_dt1  where fphm ='"+ids+"' ";
		res.executeSql(sql);
		if(res.next()){
			con = res.getInt("cons");
		}
		if(con>0){
			out.print("1");
		}	
	}
		
	


%>