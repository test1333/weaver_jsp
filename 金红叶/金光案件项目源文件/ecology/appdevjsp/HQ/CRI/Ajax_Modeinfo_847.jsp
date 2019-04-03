<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil"%>
<%@ page import="weaver.workflow.webservices.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<%
String opt = Util.null2String(request.getParameter("opt"));  
String xm = Util.null2String(request.getParameter("xm"));
String sfzh = Util.null2String(request.getParameter("sfzh"));
String gh = Util.null2String(request.getParameter("gh"));
String lx = Util.null2String(request.getParameter("lx"));
String nr = Util.null2String(request.getParameter("nr"));
String sql = "";
if("getCheckXM".equals(opt)){
	sql = " select * from uf_hq_cri_involpers where xm = '"+xm+"' ";
	rs.executeSql(sql);
	if(rs.next()){
		out.print("{\"result\":\"500\"}");
	}else{
		out.print("{\"result\":\"200\"}");
	}
}else if("getCheckSFZH".equals(opt)){
	String sfzhstr=getSFZH(sfzh.trim());
	if("".equals(sfzhstr)){
		sql = " select * from uf_hq_cri_involpers where sfzh = '"+sfzh.trim()+"' ";
		rs.executeSql(sql);
		if(rs.next()){
			out.print("{\"result\":\"500\"}");
		}else{
			out.print("{\"result\":\"200\"}");
		}
	}else{
		String array[]=sfzhstr.split(",");
		String result="200";
		for(int i=0;i<array.length;i++){
			String temp=array[i];
			sql = " select * from uf_hq_cri_involpers where sfzh like '%"+temp+"%' ";
			rs.executeSql(sql);
			if(rs.next()){
				i=array.length;
				result=temp;
			}
		}
		out.print("{\"result\":\""+result+"\"}");
	}
}else if("getCheckGH".equals(opt)){
	sql = " select * from uf_hq_cri_involpers where gh = '"+gh+"' ";
	rs.executeSql(sql);
	if(rs.next()){
		out.print("{\"result\":\"500\"}");
	}else{
		out.print("{\"result\":\"200\"}");
	}
}else if("getCheckLXFS".equals(opt)){
	if(!"".equals(nr)){
		if("0".equals(lx)){
			String sjh=getTelnum(nr.trim());
			if("".equals(sjh)){
				sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr.trim()+"' ";
				rs.executeSql(sql);
				if(rs.next()){
					out.print("{\"resulta\":\"500\"}");
				}else{
					out.print("{\"resulta\":\"200\"}");
				}
			}else{
				String array[]=sjh.split(",");
				String result="200";
				for(int i=0;i<array.length;i++){
					String temp=array[i];
					sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr like '%"+temp+"%' ";
					rs.executeSql(sql);
					if(rs.next()){
						i=array.length;
						result=temp;
					}
				}
				out.print("{\"resulta\":\""+result+"\"}");
			}			
		}else if("1".equals(lx)){
			sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				out.print("{\"resultb\":\"500\"}");
			}else{
				out.print("{\"resultb\":\"200\"}");
			}
		}else if("2".equals(lx)){
			sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				out.print("{\"resultc\":\"500\"}");
			}else{
				out.print("{\"resultc\":\"200\"}");
			}
		}else if("3".equals(lx)){
			sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				out.print("{\"resultd\":\"500\"}");
			}else{
				out.print("{\"resultd\":\"200\"}");
			}
		}else if("4".equals(lx)){
			sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				out.print("{\"resulte\":\"500\"}");
			}else{
				out.print("{\"resulte\":\"200\"}");
			}
		}else if("5".equals(lx)){
			sql = " select * from uf_hq_cri_involpers_dt1 where lx = '"+lx+"' and nr = '"+nr+"' ";
			rs.executeSql(sql);
			if(rs.next()){
				out.print("{\"resultf\":\"500\"}");
			}else{
				out.print("{\"resultf\":\"200\"}");
			}
		}
	}	
}
%>
<%!
public  String getTelnum(String sParam){
	if(sParam.length()<=0){
		return "";
	}
	Pattern pattern = Pattern.compile("(1|861)(3|5|8)\\d{9}$*");
	Matcher matcher = pattern.matcher(sParam);
	StringBuffer bf = new StringBuffer();
	while(matcher.find()){
		bf.append(matcher.group()).append(",");
	}
	Pattern patterndh = Pattern.compile("(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)");
	Matcher matcherdh = patterndh.matcher(sParam);
	while(matcherdh.find()){
		bf.append(matcherdh.group()).append(",");
	}	
	int len = bf.length();
	if(len > 0){
		bf.deleteCharAt(len - 1);
	}
	return bf.toString();
}

public  String getSFZH(String sParam){
	if(sParam.length()<=0){
		return "";
	}
	Pattern pattern = Pattern.compile("^\\d{15}|^\\d{17}([0-9]|X|x)$");
	Matcher matcher = pattern.matcher(sParam);
	StringBuffer bf = new StringBuffer();
	while(matcher.find()){
		bf.append(matcher.group()).append(",");
	}
	int len = bf.length();
	if(len > 0){
		bf.deleteCharAt(len - 1);
	}
	return bf.toString();
}
%>
