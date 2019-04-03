<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<%
	    int userid = user.getUID();
	    String checkid = request.getParameter("checkid");//idֵ
		String main_handleid = "";
		String goodscate = "";
		String unit = "";
		String assets = request.getParameter("goodsname");
		String applicant = request.getParameter("applicant");
		String num = Util.null2String(request.getParameter("num"));
		String origin = Util.null2String(request.getParameter("origin"));
		String customer = Util.null2String(request.getParameter("customer"));
		String currency = Util.null2String(request.getParameter("currency"));
		String remark = Util.null2String(request.getParameter("desc"));

		String sql_goodscate = "select * from uf_goodsinfo where id = "+assets+"";
		rs.executeSql(sql_goodscate);
		if(rs.next()){
			goodscate =  Util.null2String(rs.getString("goodscatex"));
			unit =  Util.null2String(rs.getString("unit"));
		}

		String sql_insert_main = " insert into uf_differhandle (handleassetsinfo,handletype,creater,applicant,handlenum,handleremark,CheckID,notinstock)" +
								" values("+assets+",0,"+userid+","+applicant+","+num+",'"+remark+"',"+checkid+",1)";
		rs.executeSql(sql_insert_main);

		String sql_id = "select max(id) as idx from uf_differhandle ";
		rs.executeSql(sql_id);
		if(rs.next()){
			main_handleid =  Util.null2String(rs.getString("idx"));
		}

		String sql_insert_In = "insert into uf_InHandleRd (CheckId,Assetsname,Currency,InNum,Original,Customer,Remark,Mainid,AssetsCate,Unit,Account) "+
					" values("+checkid+","+assets+",'"+currency+"',"+num+",'"+origin+"','"+customer+"','"+remark+"',"+main_handleid+",'"+goodscate+"',"+unit+","+currency+"*"+num+")";
		rs.executeSql(sql_insert_In);

%>
<script type="text/javascript">
	var parentWin;
	try{
		parentWin = parent.getParentWindow(window);
		parentWin.closeDlgARfsh();
	}catch(e){
		window.close();
	}
</script>
