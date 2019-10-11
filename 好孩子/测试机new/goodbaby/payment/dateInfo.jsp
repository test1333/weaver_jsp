<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="goodbaby.pz.*"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	GetGNSTableName gg = new GetGNSTableName();
	String tablename_pk = gg.getTableName("PKLC");
	String type = Util.null2String(request.getParameter("type"));//
	
	if(type.equals("check")){//检查是否都是一个流程的数据
		String ids = Util.null2String(request.getParameter("ids"));//
		int a = 0;
		String id[] = ids.split(",");
		if(id.length>1){
			
			List<String> list = new ArrayList<String>();
			String sql = "";
			for(int i=0;i<id.length;i++){
				sql = "select pklcid from uf_fkzjb where id = '"+id[i]+"'";
				rs.executeSql(sql);
				if(rs.next()){
					list.add(rs.getString("pklcid"));
				}
			}
			HashSet<String> h = new HashSet<String>(list);
			list.clear();   
			list.addAll(h);
			if(list.size()>1){
				a=1;
			}
		}
		out.print(a);
	}else if(type.equals("Update")){//更新付款中间表
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String nowdate = sf.format(new Date());
		String ids = Util.null2String(request.getParameter("ids"));//
		String id[] = ids.split(",");
		String yh = Util.null2String(request.getParameter("yh"));//
		// String rq = Util.null2String(request.getParameter("rq"));////20181217
		String rid = "";
		String pkbh = "";
		String sql = "select u.pklcid,f.pkbh from  uf_fkzjb u join "+tablename_pk+" f on u.pklcid=f.requestid  where u.id = '"+id[0]+"'";
		rs.executeSql(sql);
		if(rs.next()){
			rid = rs.getString("pklcid");
			pkbh = rs.getString("pkbh");
		}
		
		
		sql = "select max(code) as  mcode from uf_bh where pplc = '"+rid+"'";
		String pc = "";
		rs.executeSql(sql);
		if(rs.next()){
			pc = rs.getString("mcode");
		}
		if(pc.length()<1){
			pc = "1";
		}else{
			pc = (Integer.valueOf(pc)+1)+"";
		}		
		sql = "insert into  uf_bh (code,pplc,crsj) values ('"+pc+"','"+rid+"',CONVERT(varchar,GETDATE(),120))";
		rs.executeSql(sql);
		for(int i=0;i<id.length;i++){
		//	sql = "update uf_fkzjb set flag=1 ,XZYH='"+yh+"',FKRQ='"+rq+"',PCNo='"+pc+"' where id = '"+id[i]+"'";
			sql = "update uf_fkzjb set flag=1 ,XZYH='"+yh+"',PCNo='"+pc+"',pzzt='0',kjqrqq='"+nowdate+"' where id = '"+id[i]+"'";//20181217
			rs.executeSql(sql);
		}
		
	}else if(type.equals("updateCN")){//出纳确认 
		String ids = Util.null2String(request.getParameter("ids"));//
		out.print(ids);
		String id[] = ids.split(",");
		for(int i=0;i<id.length;i++){
			String str []=id[i].split("aaa");
			String sql = "update uf_fkzjb set cnqr=1 where pklcid='"+str[0]+"' and pcno='"+str[1]+"' and cnqr=0 and flag = 1 ";
			
			rs.executeSql(sql);
		}
	}else if(type.equals("delete")){////20181217
		String ids = Util.null2String(request.getParameter("ids"));//
		String id[] = ids.split(",");
		for(int i=0;i<id.length;i++){
			String sql = "update uf_fkzjb set flag = 0 where id = '"+id[i]+"' and cnqr = 0 ";//20181217
			rs.executeSql(sql);
			
			
		}
		
		
	}
	
	
	
	



%>