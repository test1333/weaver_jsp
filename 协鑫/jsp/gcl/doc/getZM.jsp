 <%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<%
	String groupid = Util.null2String(request.getParameter("groupid"));
	String rid = Util.null2String(request.getParameter("rid"));
	String depid = Util.null2String(request.getParameter("depid"));
	String zjbz = Util.null2String(request.getParameter("zjbz"));
	String fbz = Util.null2String(request.getParameter("fbz"));
	
	String type = Util.null2String(request.getParameter("type"));//0 第一次设置href  1 循环设置href 2 部门组 3 循环部门组 4 自动组 5 循环自动组
	
	String groupids [] = groupid.split(",");
	String depids [] = depid.split(",");
	String zjbzs [] = zjbz.split(",");
	String fbzs [] = fbz.split(",");
	if(type.equals("0")){
		String sql = "select groupid, zm from xx_getGroups where groupid in ("+groupid+")";
		rs.executeSql(sql);
		StringBuffer sb = new StringBuffer();
		while(rs.next()){
			String gpid = rs.getString("groupid");
			String zm = rs.getString("zm");
			sb.append(gpid);
			sb.append(",");
			sb.append(zm);
			sb.append("@@@@@@");	
		}
		out.print(sb.toString());
	}else if(type.equals("1")){
		StringBuffer sb = new StringBuffer();
		for(int i= 0;i<groupids.length;i++){
			String sql = "select  uf.groupid ,hm.name || ' ( ' || to_char(count(uf.id)) || ' )' as zm from  uf_hrmgroup uf join hrmgroup hm on hm.id = uf.groupid where uf.bs ='1' and hm.id = '"+groupids[i]+"' and uf.rid = '"+rid +"' group by groupid,hm.name " ;
			int con = 0;//判断是否存在
			rs.executeSql(sql);
			if(rs.next()){
				String zm = rs.getString("zm");
				String gpid = rs.getString("groupid");
				sb.append(gpid);
				sb.append(",");
				sb.append(zm);
				sb.append("@@@@@@");
				++con;				
			}
			if(con<1){
				sql = "select groupid, zm from xx_getGroups where groupid = '"+groupids[i]+"'";
				rs.executeSql(sql);
				if(rs.next()){
					String zm = rs.getString("zm");
					String gpid = rs.getString("groupid");
					sb.append(gpid);
					sb.append(",");
					sb.append(zm);
					sb.append("@@@@@@");			
				}
			}
			
		}
		out.print(sb.toString());
	}else if(type.equals("2")){//部门 绑定事件
		StringBuffer sb = new StringBuffer();
		String sql = "select departmentid,dname from xx_hrdept where departmentid in ("+depid+")";
		rs.executeSql(sql);
		while(rs.next()){
			String departmentid = rs.getString("departmentid");
			String dname = rs.getString("dname");
			sb.append(departmentid);
			sb.append(",");
			sb.append(dname);
			sb.append("@@@@@@");	
		}
		out.print(sb.toString());	
	}else if(type.equals("3")){//部门延迟加载
		StringBuffer sb = new StringBuffer();
		for(int i= 0;i<depids.length;i++){
			String sql = "select uf.departmentid ,hd.departmentname || ' ( ' || to_char(count(uf.id)) || ' )' as dname from uf_hrdept uf join hrmdepartment hd on uf.departmentid = hd.id where uf.bs = '1' and hd.id ='"+depids[i]+"' and uf.rid = '"+rid+"'  group by departmentid,hd.departmentname" ;
			int con = 0;//判断是否存在
			rs.executeSql(sql);
			if(rs.next()){
				String departmentid = rs.getString("departmentid");
				String dname = rs.getString("dname");
				sb.append(departmentid);
				sb.append(",");
				sb.append(dname);
				sb.append("@@@@@@");
				++con;				
			}
			if(con<1){
				sql = "select departmentid,dname from xx_hrdept where departmentid = '"+depids[i]+"'";
				rs.executeSql(sql);
				if(rs.next()){
					String departmentid = rs.getString("departmentid");
					String dname = rs.getString("dname");
					sb.append(departmentid);
					sb.append(",");
					sb.append(dname);
					sb.append("@@@@@@");			
				}
			}
		}
		out.print(sb.toString());
	}else if(type.equals("4")){//自动组
		StringBuffer sb = new StringBuffer();
		for(int i= 0;i<zjbzs.length;i++){
			String sql = "select zjbz,namecn from xx_gethrzdz where zjbz in ('"+zjbzs[i]+"')";
			rs.executeSql(sql);
			if(rs.next()){
				String zjbzz = rs.getString("zjbz");
				String namecn = rs.getString("namecn");
				sb.append(zjbzz);
				sb.append(",");
				sb.append(namecn);
				sb.append("@@@@@@");
			}	
		}
		out.print(sb.toString());	
	}else if(type.equals("5")){//自动组延迟加载
		StringBuffer sb = new StringBuffer();
		for(int i= 0;i<zjbzs.length;i++){
			String fb = "";
			String zjbh = "";
			if(zjbzs[i].length()>5){
				fb = zjbzs[i].substring(5);//分部
				zjbh = zjbzs[i].substring(0,5);//主键编号  OA001  所有   OA002  高管    OA003  中层高管   OA004  中层   OA005  基层  
			}
			String strsql = "";
			if(zjbh.equals("OA001")){
				strsql  = "本层级所有人";
			}else if(zjbh.equals("OA002")){
				strsql  = "本层级高层人员组";
			}else if(zjbh.equals("OA003")){
				strsql  = "本层级中层管理人员组";
			}else if(zjbh.equals("OA004")){
				strsql  = "本层级中层人员组";
			}else if(zjbh.equals("OA005")){
				strsql  = "本层级基层人员组";
			}			
			String sql = "select uf.zjbz ,'"+strsql+"' || ' ( ' || to_char(count(uf.id)) || ' )' as namecn from uf_hrzdyz uf where uf.bs = '1' and uf.zjbz ='"+zjbzs[i]+"' and uf.rid = '"+rid+"'  group by uf.zjbz " ;
			int con = 0;//判断是否存在
			rs.executeSql(sql);
			if(rs.next()){
				String zjbzz = rs.getString("zjbz");
				String namecn = rs.getString("namecn");
				sb.append(zjbzz);
				sb.append(",");
				sb.append(namecn);
				sb.append("@@@@@@");
				++con;				
			}
			if(con<1){
				sql = "select zjbz,namecn from xx_gethrzdz where zjbz in ('"+zjbzs[i]+"')";
				rs.executeSql(sql);
				while(rs.next()){
					String zjbzz = rs.getString("zjbz");
					String namecn = rs.getString("namecn");
					sb.append(zjbzz);
					sb.append(",");
					sb.append(namecn);
					sb.append("@@@@@@");	
				}
			}
		}
		out.print(sb.toString());
	}else if(type.equals("6")){//自定义
		for(int i=0;i<groupids.length;i++){
			String str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupids[i]+") and rid = '"+rid+"'";
			rs1.executeSql(str);
			int a = 0;
			int b = 0;//有效人数
			int d = 0;//删除后存在人数
			if(rs1.next()){
				a = rs1.getInt("con");//建模组内人数
			}
			str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupids[i]+") and rid = '"+rid+"' and bs = '1'";
			rs1.executeSql(str);
			if(rs1.next()){
				b = rs1.getInt("con");
			}
			if(a>0){
				str = "select count(userid) as con  from hrmgroupmembers where groupid = '"+ groupids[i] +"'  ";
				rs1.executeSql(str);
				int c = 0;//组内人数
				if(rs1.next()){
					c = rs1.getInt("con");
				}
				str =  "select id from uf_hrmgroup where groupid in ("+groupids[i]+") and rid = '"+rid+"')  and hid  not in ( select userid from hrmgroupmembers where groupid = '"+ groupids[i] +"'  )";
				rs1.executeSql(str);
				while(rs1.next()){
					String undoid = rs1.getString("id");
					String delsql = "delete uf_hrmgroup where id = '"+undoid+"'";
					rs.executeSql(delsql);
				}
				
				str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupids[i]+") and rid = '"+rid+"'";
				rs1.executeSql(str);
				if(rs1.next()){
					d = rs1.getInt("con");
				}
				if(c>d){
					str = " select userid from hrmgroupmembers where groupid = '"+ groupids[i] +"'  and userid not in (select hid from uf_hrmgroup where groupid in ("+groupids[i]+") and rid = '"+rid+"') ";
					rs1.executeSql(str);
					while(rs1.next()){
						String  hrmid = rs1.getString("userid");
						String ssq = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id = '"+hrmid+"' ";
						rs.executeSql(ssq);
						if(rs.next()){
							String id = rs.getString("id");
							String lastnames = rs.getString("lastname");
							String workcodes = rs.getString("workcode");
							String jobtitle = rs.getString("jobtitle");
							String departmentid = rs.getString("departmentid");
							String subcompanyid1 = rs.getString("subcompanyid1");
							ssq = "insert into uf_hrmgroup (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,groupid) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+groupid+"')";
							rs.executeSql(ssq);
						}
					}
					
				}
				
				
			}
			if(a>0 && b<1){
				str = " update uf_hrmgroup set bs = '1' where groupid in ("+groupids[i]+") and rid = '"+rid+"' and bs = '0' ";
				rs1.executeSql(str);
			}
			
			
			if(a<1){
				str = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id in ( select userid from hrmgroupmembers where groupid = '"+ groupids[i] +"' ) ";
				rs1.executeSql(str);//bs 0 无效   1有效
				while(rs1.next()){
					String id = rs1.getString("id");
					String lastnames = rs1.getString("lastname");
					String workcodes = rs1.getString("workcode");
					String jobtitle = rs1.getString("jobtitle");
					String departmentid = rs1.getString("departmentid");
					String subcompanyid1 = rs1.getString("subcompanyid1");
					String sss = "insert into uf_hrmgroup (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,groupid) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+groupid+"')";
					rs.executeSql(sss);
				}
			}
		}		
		
	}else if(type.equals("7")){//部门
		
		for(int i=0;i<depids.length;i++){
			String str = "select count(id) as con from uf_hrdept where departmentid in ("+depids[i]+") and rid = '"+rid+"'";
			rs1.executeSql(str);
			int a = 0;
			int b = 0;//有效人数
			int d = 0;//删除后存在人数
			if(rs1.next()){
				a = rs1.getInt("con");//建模内人数
			}
			str = "select count(id) as con from uf_hrdept where departmentid in ("+depids[i]+") and rid = '"+rid+"' and bs = '1'";
			rs1.executeSql(str);
			if(rs1.next()){
				b = rs1.getInt("con");
			}
			if(a>0){
				str = "select count(id) as con  from hrmresource where departmentid = '"+ depids[i] +"' and status <4  ";
				rs1.executeSql(str);
				int c = 0;//bumen 人数
				if(rs1.next()){
					c = rs1.getInt("con");
				}
				str =  "select id from uf_hrdept where departmentid in ("+depids[i]+") and rid = '"+rid+"'  and hid  not in ( select id from hrmresource where departmentid = '"+ depids[i] +"' and status<4  )";
				rs1.executeSql(str);
				while(rs1.next()){
					String undoid = rs1.getString("id");
					String delsql = "delete uf_hrdept where id = '"+undoid+"'";
					rs.executeSql(delsql);
				}
				
				str = "select count(id) as con from uf_hrdept where departmentid in ("+depids[i]+") and rid = '"+rid+"'";
				rs1.executeSql(str);
				if(rs1.next()){
					d = rs1.getInt("con");
				}
				if(c>d){
					str = " select id from hrmresource where departmentid = '"+ depids[i] +"' and status<4 and id  not in (select hid from uf_hrdept where departmentid in ("+depids[i]+") and rid = '"+rid+"') ";
					rs1.executeSql(str);
					while(rs1.next()){
						String  hrmid = rs1.getString("id");
						String ssq = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id = '"+hrmid+"' ";
						rs.executeSql(ssq);
						if(rs.next()){
							String id = rs.getString("id");
							String lastnames = rs.getString("lastname");
							String workcodes = rs.getString("workcode");
							String jobtitle = rs.getString("jobtitle");
							String departmentid = rs.getString("departmentid");
							String subcompanyid1 = rs.getString("subcompanyid1");
							ssq = "insert into uf_hrdept (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1')";
							rs.executeSql(ssq);
						}
					}
					
				}
				
				
			}
			if(a>0 && b<1){
				str = " update uf_hrdept set bs = '1' where departmentid in ("+depids[i]+") and rid = '"+rid+"' and bs = '0' ";
				rs1.executeSql(str);
			}
			
			
			if(a<1){
				str = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id in ( select id from hrmresource where departmentid = '"+ depids[i] +"' and status<4 ) ";
				rs1.executeSql(str);//bs 0 无效   1有效
				while(rs1.next()){
					String id = rs1.getString("id");
					String lastnames = rs1.getString("lastname");
					String workcodes = rs1.getString("workcode");
					String jobtitle = rs1.getString("jobtitle");
					String departmentid = rs1.getString("departmentid");
					String subcompanyid1 = rs1.getString("subcompanyid1");
					String sss = "insert into uf_hrdept (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1')";
					rs.executeSql(sss);
				}
			}
		}
		
	}else if(type.equals("8")){//自动	
		
		for(int i=0;i<zjbzs.length;i++){
			String fb = "";
			String zjbh = "";
			if(zjbzs[i].length()>5){
				fb = zjbzs[i].substring(5);//分部
				zjbh = zjbzs[i].substring(0,5);//主键编号  OA001  所有   OA002  高管    OA003  中层高管   OA004  中层   OA005  基层  
			}
			String str = "select count(id) as con from uf_hrzdyz where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"'";
			rs1.executeSql(str);
			int a = 0;
			int b = 0;//有效人数
			int d = 0;//删除后存在人数
			if(rs1.next()){
				a = rs1.getInt("con");//建模内人数
			}
			str = "select count(id) as con from uf_hrzdyz where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"' and bs = '1'";
			rs1.executeSql(str);
			if(rs1.next()){
				b = rs1.getInt("con");
			}
			if(a>0){
				
				String strsql = "";
				str = " select count(hr.id) as con  from  ec_psninfo_test@ehr ec join hrmresource hr on hr.workcode=ec.psncode where hr.status<4 ";
				if(zjbh.equals("OA001")){
					strsql  = " and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA002")){
					strsql  = " and ec.persk = '10' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA003")){
					strsql  = " and ec.persk = '20' and substr(ec.stell,4,1) = '1' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA004")){
					strsql  = " and ec.persk = '20' and substr(ec.stell,4,1) <> '1' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA005")){
					strsql  = " and ec.persk = '30' and hr.subcompanyid1='"+fb+"' ";
				}
				str = str + strsql;
				rs1.executeSql(str);
				int c = 0;//bumen 人数
				if(rs1.next()){
					c = rs1.getInt("con");
				}
				str =  "select id from uf_hrzdyz where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"'  and hid  not in (select hr.id from  ec_psninfo_test@ehr ec join hrmresource hr on hr.workcode=ec.psncode where hr.status<4 "+ strsql + " )";
				rs1.executeSql(str);
				while(rs1.next()){
					String undoid = rs1.getString("id");
					String delsql = "delete uf_hrzdyz where id = '"+undoid+"'";
					rs.executeSql(delsql);
				}
				str = "select count(id) as con from uf_hrzdyz where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"'";
				rs1.executeSql(str);
				if(rs1.next()){
					d = rs1.getInt("con");
				}
				if(c>d){
					str = " select id from hrmresource where subcompanyid1 = '"+ fb +"' and status<4 and id  not in (select hid from uf_hrzdyz where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"') ";
					rs1.executeSql(str);
					while(rs1.next()){
						String  hrmid = rs1.getString("userid");
						String ssq = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id = '"+hrmid+"' ";
						rs.executeSql(ssq);
						if(rs.next()){
							String id = rs.getString("id");
							String lastnames = rs.getString("lastname");
							String workcodes = rs.getString("workcode");
							String jobtitle = rs.getString("jobtitle");
							String departmentid = rs.getString("departmentid");
							String subcompanyid1 = rs.getString("subcompanyid1");
							ssq = "insert into uf_hrzdyz (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,zjbz) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+zjbzs[i]+"')";
							rs.executeSql(ssq);
						}
					}
				}
			}
			if(a>0 && b<1){
				str = " update uf_hrzdyz set bs = '1' where zjbz in ('"+zjbzs[i]+"') and rid = '"+rid+"' and bs = '0' ";
				rs1.executeSql(str);
			}			
			if(a<1){
				//主键编号  OA001  所有   OA002  高管    OA003  中层高管   OA004  中层   OA005  基层  fb
				str = " select hr.departmentid,hr.jobtitle,hr.subcompanyid1,hr.workcode,hr.lastname,hr.id  from  ec_psninfo_test@ehr ec join hrmresource hr on hr.workcode=ec.psncode where hr.status<4 ";
				if(zjbh.equals("OA001")){
					str = str +" and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA002")){
					str = str +" and ec.persk = '10' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA003")){
					str = str +" and ec.persk = '20' and substr(ec.stell,4,1) = '1' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA004")){
					str = str +" and ec.persk = '20' and substr(ec.stell,4,1) <> '1' and hr.subcompanyid1='"+fb+"' ";
				}else if(zjbh.equals("OA005")){
					str = str +" and ec.persk = '30' and hr.subcompanyid1='"+fb+"' ";
				}
				rs1.executeSql(str);//bs 0 无效   1有效
				while(rs1.next()){
					String id = rs1.getString("id");
					String lastnames = rs1.getString("lastname");
					String workcodes = rs1.getString("workcode");
					String jobtitle = rs1.getString("jobtitle");
					String departmentid = rs1.getString("departmentid");
					String subcompanyid1 = rs1.getString("subcompanyid1");
					String sss = "insert into uf_hrzdyz (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,zjbz) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+zjbzs[i]+"')";
					rs.executeSql(sss);
				}
			}
		}
		
	}else if(type.equals("9")){//分部
		String str = "select id, fbname from xx_fbhr_view where id in ("+fbz+")";
		rs.executeSql(str);
		StringBuffer sb = new StringBuffer();
		while(rs.next()){
			String id = rs.getString("id");
			String fbname = rs.getString("fbname");
			sb.append(id);
			sb.append(",");
			sb.append(fbname);
			sb.append("@@@@@@");	
		}
		out.print(sb.toString());		
	}else if(type.equals("10")){//分部
		StringBuffer sb = new StringBuffer();
		for(int i = 0;i<fbzs.length;i++){
			int con = 0;
			String str = "select h.subcompanyname || '('||to_char(count(u.id)) || ')' as fbname,h.id from uf_hrfbz u join  hrmsubcompany h on h.id = u.SUBCOMPANYID1 where u.SUBCOMPANYID1 = '"+fbzs[i]+"' and bs='1' and rid = '"+rid+"' group by h.id ,h.subcompanyname ";
			rs.executeSql(str);
			if(rs.next()){
				String id = rs.getString("id");
				String fbname = rs.getString("fbname");
				sb.append(id);
				sb.append(",");
				sb.append(fbname);
				sb.append("@@@@@@");	
				con++;
			}
			if(con<1){
				str = "select id, fbname from xx_fbhr_view where id in ('"+fbzs[i]+"')";
				rs.executeSql(str);
				while(rs.next()){
					String id = rs.getString("id");
					String fbname = rs.getString("fbname");
					sb.append(id);
					sb.append(",");
					sb.append(fbname);
					sb.append("@@@@@@");	
				}
			}
		}
		out.print(sb.toString());
	}
	
%>
