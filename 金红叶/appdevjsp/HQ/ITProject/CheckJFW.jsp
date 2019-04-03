<%@ page import="weaver.general.Util" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", -10);
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />
<%
	String sql = "";
	String requestId = "";//id
	String  result = "";

	// sql="select machine from uf_machine";
	//String type="21";
	//rs.executeSql(sql);
	//String machine="DEV";
	//if(rs.next()){
	//	machine = Util.null2String(rs.getString("machine"));
	//}
	//if("DEV".equals(machine)){
	//	type="21";
	//}else{
	//	type="21";
	//}
	String taskid = Util.null2String(request.getParameter("taskid"));
    String parentids ="";
	String parentid = "";
	sql = "select parentids,parentid from prj_taskprocess where id="+taskid;
    rs.executeSql(sql);  
	if(rs.next()){
         parentids = Util.null2String(rs.getString("parentids"));
		 parentid = Util.null2String(rs.getString("parentid"));
	}    
	 String subid =   parentids.split(",")[0];
	 String prefinish = "";
	 String prjtype = "";
	 String prjid = "";
	 String finish="";
	 String prjstatus="";
	 int jfwsl=0;
	 int accessorylength=0;
	 String accessory="";
	 if("0".equals(parentid)){
		 result ="0";
	 }else{
		sql="select a.prefinish,a.prjid,b.prjtype,b.status from prj_taskprocess  a,prj_projectinfo b where a.prjid=b.id and a.id="+subid;
		rs.executeSql(sql); 
		if(rs.next()){
			prefinish = Util.null2String(rs.getString("prefinish"));
			prjtype = Util.null2String(rs.getString("prjtype"));
			prjid = Util.null2String(rs.getString("prjid"));
			prjstatus = Util.null2String(rs.getString("status"));
		}
		if("0".equals(prefinish)||"0".equals(prjstatus)){
			result = "0";
		}else{
			sql="select finish,jfwsl,accessory from prj_taskprocess where prjid="+prjid+" and taskindex="+prefinish+" and parentid=0";
			rs.executeSql(sql);
			if(rs.next()){
				finish = Util.null2String(rs.getString("finish"));
				jfwsl = rs.getInt("jfwsl");
				accessory = Util.null2String(rs.getString("accessory"));
			}
            if(jfwsl>0){
			if(!"".equals(accessory)){
			        if(accessory.startsWith(",")){
						accessory= accessory.substring(1,accessory.length());
					}
					if(accessory.endsWith(",")){
						accessory= accessory.substring(0,accessory.length()-1);
					}
					sql="select count(1) as count from docdetail where id in ("+accessory+")";
					rs.executeSql(sql);
					if(rs.next()){
						accessorylength = rs.getInt("count");
					}
			}
			if(!"100".equals(finish)){
				result = "1";
			}else{
			if("".equals(accessory)||jfwsl >accessorylength){
					result = "1";
				}else{
					result = "0";
				}
			}
		}else{
			result = "0";
		}
		}
	 }
	out.print(result);

%>