<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();

    //拿取盘点id
	String checkid = Util.null2String(request.getParameter("Checkid"));
    String approve ="";
    String workprocess = "";
	String wfdifferencehandle = "";
	String sql2 = "select  * from  uf_checkrecord where id = "+checkid+"";
	rs.executeSql(sql2);
	if(rs.next()){
	approve =  Util.null2String(rs.getString("approve"));
	workprocess =  Util.null2String(rs.getString("workprocess"));
	wfdifferencehandle =  Util.null2String(rs.getString("wfdifferencehandle"));

}

    //读取当前操作人
    int count_cc = 0;
    int count_vv = 0;
    int count_ss = 0;
    int userid = user.getUID();
   // if(userid == 1){
    //  count_cc = 1;
   // }else{
    String sql_person_approve= "select count(monitor) as count_cc from uf_checkrecord where id= "+checkid+" and monitor= "+userid+"";
    rs.executeSql(sql_person_approve);
    if(rs.next()){
    	count_cc = rs.getInt("count_cc");
   }

    String sql_person_write= "select count(id) as count_vv from uf_checkrecord where id= "+checkid+" and admin= "+userid+"";
    rs.executeSql(sql_person_write);
    if(rs.next()){
    	count_vv = rs.getInt("count_vv");
   }

    String sql_person_checkperson= "select count(id) as count_ss from uf_checkrecord where id= "+checkid+" and checkperson= "+userid+"";
    rs.executeSql(sql_person_checkperson);
    if(rs.next()){
    	count_ss = rs.getInt("count_ss");
   }
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		if(count_ss!=0&&wfdifferencehandle.equals("")){
		RCMenu += "{新增,javascript:assetsAdd("+checkid+"),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		RCMenu += "{删除,javascript:dele(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
	}

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		<input type="hidden" name="differid_detail" value="">
		<input type="hidden" name="checkid" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				</td>
				<td class="rightSearchSpan" 
					style="text-align: right; width: 400px !important">
					<%if(count_ss!=0&&wfdifferencehandle.equals("")){%>
					<input type="button" 
						value="新增"
						class="e8_btn_top middle" onclick="assetsAdd(<%=checkid%>)" />
					<input type="button"
						value="删除"
						class="e8_btn_top middle" onclick="dele()" />
						<%}%>
					<span
						title="<%=SystemEnv.getHtmlLabelName(23036, user.getLanguage())%>"  class="cornerMenu middle"></span>
				</td>
			</tr>
		</table>

		<%
		String backfields = " a.id,a.handleassetsinfo,a.handlenum,a.handleremark,a.commenton,'入库' as handleltype,b.goodsname";
		String fromSql  = " from uf_differhandle a join uf_goodsinfo b on a.handleassetsinfo = b.id ";
		String sqlWhere = " where notinstock = 1 ";
		String orderby = "" ;
		String tableString = "";
         
		//右侧鼠标 放上可以点击
		String  operateString= "";
		if(count_cc!=0&&workprocess.equals("2")){
			    operateString =  "<operates width=\"20%\">"+
	                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
	                    "     <operate isalwaysshow=\"true\" href=\"javascript:comment();\" linkkey=\"id\" linkvaluecolumn=\"id\" text=\"批注\" index=\"0\"/> "+
	                    "</operates>";
	                }
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+="  <col width=\"20%\" labelid=\"资产名称\" text=\"资产名称\" column=\"goodsname\" orderkey=\"goodsname\" linkvaluecolumn=\"handleassetsinfo\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=77&amp;formId=-123\" target=\"_fullwindow\"/>"+
			"               <col width=\"20%\" labelid=\"处理数量\" text=\"拟处理数量\" column=\"handlenum\" orderkey=\"handlenum\"/>"+
			"				<col width=\"20%\" labelid=\"处理方式\" text=\"处理方式\" column=\"handleltype\" orderkey=\"handleltype\"/>"+
			"				<col width=\"20%\" labelid=\"差异说明\" text=\"差异说明\" column=\"handleremark\" orderkey=\"handleremark\"/>"+
						"	<col width=\"20%\" labelid=\"批注\" text=\"批注\" column=\"commenton\" orderkey=\"commenton\"/>"+
		"			</head>"+
	" </table>";
	%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"/>
	<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include>  
</BODY>
</HTML>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
	<script type="text/javascript">
	var diag_vote;

	function closeDialog(){
	diag_vote.close();
}

    function closeDlgARfsh(){
	_table.reLoad();
	diag_vote.close();
}

  		function assetsAdd(checkid){
		var title = "";
		var url = "";
		title = "盘盈资产";
		url="/seahonor/jsp/NewCheckAssets.jsp?checkid="+checkid+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	      } else {
		    diag_vote = new Dialog();
	    };

		diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.Modal = true;
		diag_vote.checkDataChange = false;
		diag_vote.Title = title;
		diag_vote.maxiumnable = true;
		diag_vote.URL = url;
		diag_vote.show();

  		}
        
        function dele(){
        var ids = _xtable_CheckedCheckboxId();
        var checkid = <%=checkid%>;
        //document.report.differid_detail.value = ids ;
        //document.report.checkid.value = checkid ;
		//document.report.action = "/seahonor/jsp/NewCheckAssetsDelete.jsp";
       // $('#report').submit();
       	$.post("/seahonor/jsp/NewCheckAssetsDelete.jsp",{ids:ids,checkid:checkid},function(datas){
		_table.reLoad();
	   });	
        }

        //批注
	    function comment(id){
	    var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/AssetsCheckComment2.jsp?id="+id+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 600;
		diag_vote.Height = 400;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");


	    }

	</script>