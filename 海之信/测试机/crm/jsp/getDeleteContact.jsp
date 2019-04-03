<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<%!
   public String getIsGL(String gsid){
	   RecordSet rs1= new RecordSet();
	    RecordSet rs_dt1= new RecordSet();
	   String flag = "0";
	 	String tablename="";//表名
		String zdm="";//字段名
		String keyzd="";//关键字段
		String kmm="";//科目名
		String url = "";//连接URL
		String glbm = "";//关联表名
		String glzd = "";//关联字段
		String glbmkey = "";//关联表key
		String urlzd = "";//Url字段
		String sfmxb = "";//是否明细表
		String jmxsbm = "";
		String jmxszdm = "";
		String jmxskey = "";
		String jmxsglzd = "";		
		String kmm_dt="";
		String name_dt="";
		String url_dt="";
		String sql="select * from uf_delcontact_table";
		StringBuffer sb= new StringBuffer();
		String sql_dt="";
		rs1.executeSql(sql);
		while(rs1.next()){
			String query="";
			tablename = Util.null2String(rs1.getString("tablename"));
			zdm = Util.null2String(rs1.getString("zdm"));
			keyzd = Util.null2String(rs1.getString("keyzd"));
			kmm = Util.null2String(rs1.getString("kmm"));
			url = Util.null2String(rs1.getString("url"));
			glbm = Util.null2String(rs1.getString("glbm"));
			glzd = Util.null2String(rs1.getString("glzd"));
			glbmkey = Util.null2String(rs1.getString("glbmkey"));
			urlzd = Util.null2String(rs1.getString("urlzd"));
			sfmxb = Util.null2String(rs1.getString("sfmxb"));
			jmxsbm = Util.null2String(rs1.getString("jmxsbm"));
			jmxszdm = Util.null2String(rs1.getString("jmxszdm"));
			jmxskey = Util.null2String(rs1.getString("jmxskey"));
			jmxsglzd = Util.null2String(rs1.getString("jmxsglzd"));
		
			if("1".equals(sfmxb)){
				query="select '"+kmm+"' as kmm from "+glbm+" a,"+tablename+" b " +
								"where a."+glbmkey+"=b."+glzd+" and   ','+CAST(b."+zdm+" as varchar(8000))+','   like '%,"+gsid+",%'";
			
			}else{
				query="select '"+kmm+"' as kmm  from "+tablename+"  a where  ','+CAST(a."+zdm+" as varchar(8000))+','   like '%,"+gsid+",%'";
			
			}
			sql_dt="select count(1) as count from ( "+query+") a";
			
			rs_dt1.executeSql(sql_dt);
			int count=0;
			if(rs_dt1.next()){
				count = rs_dt1.getInt("count");
			}
			if(count > 0){
				flag= "1";
				break;
			}
		}
		return flag;

   }
%>
<%
    String gjz = request.getParameter("gjz");
	 StringBuffer sb = new StringBuffer();
	 
	 String gs="";
	 String name = "";
	 String dealStatus = "";
	 String dealStatusspan="";
	 String wwm = "";
	 String lxrcm = "";
	 String lxrcmspan="";
	 String GroupName = "";
	 String GroupNamespan="";
	 String customName = "";
	 String customNamespan="";
	 String dept = "";
	 String Position = "";
	 String mobile = "";
	 String tel = "";
	 String Fax = "";
	 String bgdz = "";
	 String Postcode = "";
	 String Email = "";
	 String grwxh = "";
	 String jtdz = "";
	 String zzdh = "";
	 String lxrsr = "";
	 String qz = "";
	 String qzspan="";
	 String status = "";
	 String statusspan="";
	 String lzsj = "";
	 String sql_dt="";
	 String sql="select top 50 id,name,dealStatus,wwm,lxrcm,GroupName,customName,dept,Position,mobile,tel,Fax,bgdz,Postcode,Email,grwxh,jtdz,zzdh,lxrsr,qz,status,lzsj from uf_contacts where superid is null and upper(name) like UPPER('%"+gjz+"%') ";
	
		 sql +=" and dealstatus in(0,1,2) ";
	 
	 sql +=" order by name asc";
    rs.executeSql(sql);
	while(rs.next()){
         gs = Util.null2String(rs.getString("id"));
		 name = Util.null2String(rs.getString("name"));
		 dealStatus = Util.null2String(rs.getString("dealStatus"));
		  if(!"".equals(dealStatus)){
			sql_dt=" select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_contacts' and a.fieldname='dealStatus' and c.selectvalue='"+dealStatus+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				dealStatusspan = Util.null2String(rs_dt.getString("selectname"));
			}
		 }else{
			 dealStatusspan="";
		 }
		 wwm = Util.null2String(rs.getString("wwm"));
		 lxrcm = Util.null2String(rs.getString("lxrcm"));
		  if(!"".equals(lxrcm)){
			sql_dt=" select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_contacts' and a.fieldname='lxrcm' and c.selectvalue='"+lxrcm+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				lxrcmspan = Util.null2String(rs_dt.getString("selectname"));
			}
		 }else{
			 lxrcmspan="";
		 }
		 GroupName = Util.null2String(rs.getString("GroupName"));
		 if(!"".equals(GroupName)){
			sql_dt=" select GroupName from uf_custom_group where id="+GroupName;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				GroupNamespan = Util.null2String(rs_dt.getString("GroupName"));
			}
		 }else{
			 GroupNamespan="";
		 }
		 customName = Util.null2String(rs.getString("customName"));
		 if(!"".equals(customName)){
			sql_dt="select customName from uf_custom where id="+customName;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				customNamespan = Util.null2String(rs_dt.getString("customName"));
			}
		 }else{
			 customNamespan="";
		 }
		 dept = Util.null2String(rs.getString("dept"));
		 Position = Util.null2String(rs.getString("Position"));
		 mobile = Util.null2String(rs.getString("mobile"));
		 tel = Util.null2String(rs.getString("tel"));
		 Fax = Util.null2String(rs.getString("Fax"));
		 bgdz = Util.null2String(rs.getString("bgdz"));
		 Postcode = Util.null2String(rs.getString("Postcode"));
		 Email = Util.null2String(rs.getString("Email"));
		 grwxh = Util.null2String(rs.getString("grwxh"));
		 jtdz = Util.null2String(rs.getString("jtdz"));
		 zzdh = Util.null2String(rs.getString("zzdh"));
		 lxrsr = Util.null2String(rs.getString("lxrsr"));
		 qz = Util.null2String(rs.getString("qz"));
		  if(!"".equals(qz)){
			sql_dt="select flmc from uf_group where id="+qz;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				qzspan = Util.null2String(rs_dt.getString("flmc"));
			}
		 }else{
			 qzspan="";
		 }
		 status = Util.null2String(rs.getString("status"));
		  if(!"".equals(status)){
			sql_dt=" select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_contacts' and a.fieldname='status' and c.selectvalue='"+status+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				statusspan = Util.null2String(rs_dt.getString("selectname"));
			}
		 }else{
			 statusspan="";
		 }
		 lzsj = Util.null2String(rs.getString("lzsj"));
		sb.append(gs);
		sb.append("###");
		sb.append(name);	
		sb.append("###");
		sb.append(getIsGL(gs));
		sb.append("###");
		sb.append(dealStatus);
		sb.append("###");
		sb.append(dealStatusspan);
		sb.append("###");
		sb.append(wwm);
		sb.append("###");
		sb.append(lxrcm);
		sb.append("###");
		sb.append(lxrcmspan);
		sb.append("###");
		sb.append(GroupName);
		sb.append("###");
		sb.append(GroupNamespan);
		sb.append("###");
		sb.append(customName);
		sb.append("###");
		sb.append(customNamespan);
		sb.append("###");
		sb.append(dept);
		sb.append("###");
		sb.append(Position);
		sb.append("###");
		sb.append(mobile);
		sb.append("###");
		sb.append(tel);
		sb.append("###");
		sb.append(Fax);
		sb.append("###");
		sb.append(bgdz);
		sb.append("###");
		sb.append(Postcode);
		sb.append("###");
		sb.append(Email);
		sb.append("###");
		sb.append(grwxh);
		sb.append("###");
		sb.append(jtdz);
		sb.append("###");
		sb.append(zzdh);
		sb.append("###");
		sb.append(lxrsr);
		sb.append("###");
		sb.append(qz);
		sb.append("###");
		sb.append(qzspan);
		sb.append("###");
		sb.append(status);
		sb.append("###");
		sb.append(statusspan);
		sb.append("###");
		sb.append(lzsj);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>