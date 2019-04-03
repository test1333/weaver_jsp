<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.*"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="weaver.hrm.User"%>
<%@ page import="weaver.hrm.HrmUserVarify"%>
<%@ page import="weaver.hrm.report.schedulediff.HrmScheduleDiffUtil"%>
<%@ page import="weaver.workflow.webservices.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<%
	String opt = Util.null2String(request.getParameter("opt"));  
	String xmbh = Util.null2String(request.getParameter("xmbh"));  
	
	if("getHDM".equals(opt)){
		rs.executeSql(" select * from uf_hq_cri_casedp where xmbh = '"+xmbh+"' ");
		if(rs.next()){
			String dyjbr = rs.getString("dyjbr");
			String jbrxm = "";
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dyjbr+"') and hmd = '0' ");
			while(rs1.next()){
				jbrxm = rs1.getString("xm");
			}
			String jbdxxm = "";
			String dybjbdx = rs.getString("dybjbdx");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dybjbdx+"') and hmd = '0' ");
			while(rs1.next()){
				jbdxxm = rs1.getString("xm");
			}
			
			String dyzrxm = "";
			String dyzr = rs.getString("dyzr");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dyzr+"') and hmd = '0' ");
			while(rs1.next()){
				dyzrxm = rs1.getString("xm");
			}
			
			String xydxxm = "";
			String xydx = rs.getString("xydx");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+xydx+"') and hmd = '0' ");
			while(rs1.next()){
				xydxxm = rs1.getString("xm");
			}
			
			String zrxm = "";
			String zr = rs.getString("zr");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+zr+"') and hmd = '0' ");
			while(rs1.next()){
				zrxm = rs1.getString("xm");
			}
			
			out.print("{\"dyjbr\":\""+dyjbr+"\",\"jbrxm\":\""+jbrxm+"\",\"dybjbdx\":\""+dybjbdx+"\",\"jbdxxm\":\""+jbdxxm+"\",\"dyzr\":\""+dyzr+"\",\"dyzrxm\":\""+dyzrxm+"\",\"zr\":\""+zr+"\",\"zrxm\":\""+zrxm+"\",\"xydx\":\""+xydx+"\",\"xydxxm\":\""+xydxxm+"\"}");
			
		}
	}
	
	if("getJKMD".equals(opt)){
		rs.executeSql(" select * from uf_hq_cri_casedp where xmbh = '"+xmbh+"' ");
		if(rs.next()){
			String dyjbr = rs.getString("dyjbr");
			String jbrxm = "";
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dyjbr+"') and jkmd = '0' ");
			while(rs1.next()){
				jbrxm = rs1.getString("xm");
			}
			String jbdxxm = "";
			String dybjbdx = rs.getString("dybjbdx");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dybjbdx+"') and jkmd = '0' ");
			while(rs1.next()){
				jbdxxm = rs1.getString("xm");
			}
			
			String dyzrxm = "";
			String dyzr = rs.getString("dyzr");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+dyzr+"') and jkmd = '0' ");
			while(rs1.next()){
				dyzrxm = rs1.getString("xm");
			}
			
			String xydxxm = "";
			String xydx = rs.getString("xydx");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+xydx+"') and jkmd = '0' ");
			while(rs1.next()){
				xydxxm = rs1.getString("xm");
			}
			
			String zrxm = "";
			String zr = rs.getString("zr");
			rs1.executeSql(" select xm from uf_hq_cri_involpers where id in ('"+zr+"') and jkmd = '0' ");
			while(rs1.next()){
				zrxm = rs1.getString("xm");
			}
			
			out.print("{\"dyjbr\":\""+dyjbr+"\",\"jbrxm\":\""+jbrxm+"\",\"dybjbdx\":\""+dybjbdx+"\",\"jbdxxm\":\""+jbdxxm+"\",\"dyzr\":\""+dyzr+"\",\"dyzrxm\":\""+dyzrxm+"\",\"zr\":\""+zr+"\",\"zrxm\":\""+zrxm+"\",\"xydx\":\""+xydx+"\",\"xydxxm\":\""+xydxxm+"\"}");
			
		}
	}
	
	if("getGSHMD".equals(opt)){
		rs.executeSql(" select * from uf_hq_cri_casedp where xmbh = '"+xmbh+"' ");
		if(rs.next()){
			String sadw = rs.getString("sadw");
			String sadwmc = "";
			rs1.executeSql(" select gsmc from uf_hq_cri_involcomp where id in ('"+sadw+"') and gshmd = '0' ");
			while(rs1.next()){
				sadwmc = rs1.getString("gsmc");
			}
			out.print("{\"sadw\":\""+sadw+"\",\"sadwmc\":\""+sadwmc+"\"}");
		}
	}
	
%>



