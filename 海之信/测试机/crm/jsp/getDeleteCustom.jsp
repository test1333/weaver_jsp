<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
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
		String sql="select * from uf_delcustom_table";
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
	BaseBean log = new BaseBean();
    String gjz = request.getParameter("gjz");
	 StringBuffer sb = new StringBuffer();
	 String gs="";
	 String customName = "";
	 String CutomStatus="";
	 String CutomStatusspan="";
	 String gswwm="";
	 String gsjczw="";
	 String CustomGroup="";
	 String CustomGroupspan="";
	 String Address="";
	 String Telphone="";
	 String Fax="";
	 String Postcode="";
	 String zcdz="";
	 String gszt="";
	 String gsztspan="";
	 String Website="";
	 String zczb="";
	 String sszb="";
	 String khyh="";
	 String yhzh="";
	 String sh="";
	 String gswxh="";
	 String sql_dt="";
	 String sql="select top 50 id,customName,CutomStatus,gswwm,gsjczw,CustomGroup,Address,Telphone,Fax ,Postcode,zcdz,gszt,Website,zczb,sszb,khyh,yhzh,sh ,gswxh from uf_custom where superid is null and upper(customName) like UPPER('%"+gjz+"%') ";	
	 sql +=" and CutomStatus in(0,1,2) ";
	 sql +=" order by customName asc";
	log.writeLog("deletecustom:sql"+sql);
    rs.executeSql(sql);
	while(rs.next()){
         gs = Util.null2String(rs.getString("id"));
		 customName = Util.null2String(rs.getString("customName"));
		 CutomStatus = Util.null2String(rs.getString("CutomStatus"));
		 if(!"".equals(CutomStatus)){
			sql_dt=" select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_custom' and a.fieldname='CutomStatus' and c.selectvalue='"+CutomStatus+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				CutomStatusspan = Util.null2String(rs_dt.getString("selectname"));
			}
		 }else{
			 CutomStatusspan="";
		 }
		gswwm =  Util.null2String(rs.getString("gswwm"));
		gsjczw =  Util.null2String(rs.getString("gsjczw"));
		CustomGroup =  Util.null2String(rs.getString("CustomGroup"));
		 if(!"".equals(CustomGroup)){
			sql_dt=" select GroupName from uf_custom_group where id="+CustomGroup;
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				CustomGroupspan = Util.null2String(rs_dt.getString("GroupName"));
			}
		 }else{
			 CustomGroupspan="";
		 }
		 Address =  Util.null2String(rs.getString("Address"));
		 Telphone =  Util.null2String(rs.getString("Telphone"));
		 Fax =  Util.null2String(rs.getString("Fax"));
		 Postcode =  Util.null2String(rs.getString("Postcode"));
		 zcdz =  Util.null2String(rs.getString("zcdz"));
		 gszt =  Util.null2String(rs.getString("gszt"));
		 if(!"".equals(gszt)){
			sql_dt=" select c.selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_custom' and a.fieldname='gszt' and c.selectvalue='"+gszt+"'";
			rs_dt.executeSql(sql_dt);
			if(rs_dt.next()){
				gsztspan = Util.null2String(rs_dt.getString("selectname"));
			}
		 }else{
			 gsztspan="";
		 }
		 Website =  Util.null2String(rs.getString("Website"));
		 zczb =  Util.null2String(rs.getString("zczb"));
		 sszb =  Util.null2String(rs.getString("sszb"));
		 khyh =  Util.null2String(rs.getString("khyh"));
		 yhzh =  Util.null2String(rs.getString("yhzh"));
		 sh =  Util.null2String(rs.getString("sh"));
		 gswxh =  Util.null2String(rs.getString("gswxh"));
		sb.append(gs);
		sb.append("###");
		sb.append(customName);
		sb.append("###");
		sb.append(getIsGL(gs));
		sb.append("###");
		sb.append(CutomStatus);
		sb.append("###");
		sb.append(CutomStatusspan);
		sb.append("###");
		sb.append(gswwm);
		sb.append("###");
		sb.append(gsjczw);
		sb.append("###");
		sb.append(CustomGroup);
		sb.append("###");
		sb.append(CustomGroupspan);
		sb.append("###");
		sb.append(Address);
		sb.append("###");
		sb.append(Telphone);
		sb.append("###");
		sb.append(Fax);
		sb.append("###");
		sb.append(Postcode);
		sb.append("###");
		sb.append(zcdz);
		sb.append("###");
		sb.append(gszt);
		sb.append("###");
		sb.append(gsztspan);
		sb.append("###");
		sb.append(Website);
		sb.append("###");
		sb.append(zczb);
		sb.append("###");
		sb.append(sszb);
		sb.append("###");
		sb.append(khyh);
		sb.append("###");
		sb.append(yhzh);
		sb.append("###");
		sb.append(sh);
		sb.append("###");
		sb.append(gswxh);
		sb.append("@@@");
	}

	out.print(sb.toString()); 
%>