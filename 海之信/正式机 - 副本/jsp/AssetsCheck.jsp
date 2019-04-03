<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%!
// JSP中的方法
public static String CreateTmpOnlineUserId(	RecordSet rs ,ArrayList<String> onlineuserids)throws Exception
{
String userids = "";
rs.execute("delete from TmpOnlineUserId");

for(int i=0;onlineuserids!=null&&i<onlineuserids.size();i++){
rs.execute("INSERT INTO TmpOnlineUserId VALUES ("+onlineuserids.get(i)+")");
}
return userids;
}
%>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	String assets_pageId = "assets_check";
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String checkid = Util.null2String(request.getParameter("Checkid"));

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

    String sql_person_write= "select count(id) as count_vv from uf_checkrecord where admin= "+userid+" and id= "+checkid+"";
    rs.executeSql(sql_person_write);
    if(rs.next()){
    	count_vv = rs.getInt("count_vv");
   }
       String sql_person_checkperson= "select count(id) as count_ss from uf_checkrecord where checkperson= "+userid+" and id= "+checkid+"";
    rs.executeSql(sql_person_checkperson);
    if(rs.next()){
    	count_ss = rs.getInt("count_ss");
   }

//}

	//资产类别
	String goodscate_name ="";
	String goodscate_x = Util.null2String(request.getParameter("goodscate")) ;
	String sql = "select catename from uf_goodscate where id = replace('"+goodscate_x+"','57_','')";
	rs.executeSql(sql);
	if(rs.next()){
	       goodscate_name = Util.null2String(rs.getString("catename"));
	   }
    //资产名称
	String goods_name ="";
	String goodsname_x =Util.null2String(request.getParameter("goodsname"));
	String sql2 = "select goodsname from uf_goodsinfo where id = '"+goodsname_x+"'";
	rs.executeSql(sql2);
	if(rs.next()){
	       goods_name = Util.null2String(rs.getString("goodsname"));
	   }
    
    //拿取主表id
	String isEnd = "";
	String approve = "";
	String workprocess = "";
	String status = "";
	String sql3 = "select checkwriteend,approve,workprocess,status from uf_checkrecord where id = "+checkid+"";
	rs.executeSql(sql3);
		if(rs.next()){
	       isEnd = Util.null2String(rs.getString("checkwriteend"));
	       approve = Util.null2String(rs.getString("approve"));
	       workprocess = Util.null2String(rs.getString("workprocess"));
	       status = Util.null2String(rs.getString("status"));
	   }


	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<input type="hidden" name="pageId" id="pageId" value="<%=assets_pageId %>"/>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
	if(approve.equals("")){
		if(count_ss!=0&&isEnd.equals("")){
		RCMenu += "{提交,javascript:checkWriteEnd(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		RCMenu += "{Excel导入,javascript:ExcelExport(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

	}else if(count_vv!=0&&!"1".equals(status)&&!workprocess.equals("0")){
		RCMenu += "{提交,javascript:approvalflow(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{结束,javascript:approval(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
  }
}
	if(count_cc!=0&&!isEnd.equals("")&&workprocess.equals("0")){
		RCMenu += "{提交,javascript:monitor(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		RCMenu += "{退回,javascript:approvalReturn(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
	}
    //if(count_cc!=0&&!approve.equals("")&&workprocess.equals("2")){
    //	RCMenu += "{提交,javascript:approvalflow(),_self} " ;
	//	RCMenuHeight += RCMenuHeightStep ;

	//	RCMenu += "{退回,javascript:approvalReturn(),_self} " ;
	//	RCMenuHeight += RCMenuHeightStep ;
 	//}

		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="checkid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
				<%if(count_ss!=0&&approve.equals("")&&isEnd.equals("")){%>	
					<input type="button" 
						value="提交"
						class="e8_btn_top middle" onclick="checkWriteEnd()" />	
				<%}%>
				<%if(count_vv!=0&&approve.equals("")&&!workprocess.equals("0")&&!"1".equals(status)){%>	
					<input type="button" 
						value="提交"
						class="e8_btn_top middle" onclick="approvalflow()" />
					<input type="button" 
						value="结束"
						class="e8_btn_top middle" onclick="approval()" />		
				<%}%>
				<%if(count_cc!=0&&!isEnd.equals("")&&workprocess.equals("0")){%>
					<input type="button" 
						value="提交"
						class="e8_btn_top middle" onclick="monitor()" />
					<input type="button" 
						value="退回"
						class="e8_btn_top middle" onclick="approvalReturn()" />	
				<%}%> 	

				<!--<%if(count_cc!=0&&!approve.equals("")&&workprocess.equals("2")){%>	
					<input type="button" 
						value="提交"
						class="e8_btn_top middle" onclick="approvalflow()" />
					<input type="button" 
						value="退回"
						class="e8_btn_top middle" onclick="approvalReturn()" />		
				<%}%> 
				<%	if(isEnd.equals("")&&count_vv!=0){%>
						<input type="button" 
						value="新资产添加"
						class="e8_btn_top middle" onclick="assetsAdd(<%=checkid%>)" />		
				<%}%>	-->
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">

				<wea:item>所属类别</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="goodscate" browserValue="<%=goodscate_x %>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/formmode/tree/treebrowser/CustomTreeBrowser.jsp?type=45_256"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="120px"
			    linkUrl=""
			    browserSpanValue="<%=goodscate_name %>">
				</brow:browser>
				</wea:item>

				<wea:item>资产名称</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="goodsname" browserValue="<%=goodsname_x %>"
				browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.goodsinfo"
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp?type=4" width="120px"
				linkUrl=""
				browserSpanValue="<%=goods_name %>">
				</brow:browser>
				</wea:item>

				</wea:group>
				<wea:group context="">
				<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
				</wea:item>
				</wea:group>
				</wea:layout>
			</div>
		    </FORM>
		<%

		/*int cuss = 0;
		String sqlx_tmp = "  select count(*) as diffnum from (select a.id as cate,b.id as idkey,a.catename "+
    	"    , c.goodsname,b.goodscate,b.goodsname as goodsnamex,"+
		"    b.goodsno,b.originalx, b.original,b.actual,b.stock,b.difference,b.remark,b.explanation,b.assets, "+
		"    b.actual-b.original as differencex,b.actual-b.stock as difference_x,b.difference_temp from uf_goodscate a "+
		"    join (select * from uf_checkrecord_dt1 where mainid = "+checkid+" and mark is null) b "+
		"    on cast(a.id as varchar(max)) =replace(cast(b.goodscate as varchar(max)),'57_','') "+
		"    join uf_goodsinforecord c on b.assets = c.id where b.actual-b.stock != 0 ) s ";
		rs.executeSql(sqlx_tmp);
		if(rs.next()){
			cuss = rs.getInt("diffnum");
		} */

		String backfields = " a.id as cate,b.id as idkey,a.catename, c.goodsname,b.goodscate,b.goodsname as goodsnamex,b.monitornum, "+
		                   "  b.goodsno,b.originalx, b.original,b.actual,b.stock,b.difference,b.remark,b.explanation,b.assets, "+
		                   "  b.actual-b.original as differencex,b.actual-b.stock as difference_x,b.difference_temp,b.commenton";
		String fromSql  = " from uf_goodscate a "+ 
                          " join (select * from uf_checkrecord_dt1 where mainid = "+checkid+" and mark is null) b "+ 
                          " on cast(a.id as varchar(max)) =replace(cast(b.goodscate as varchar(max)),'57_','') "+ 
                          " join uf_goodsinforecord c on b.assets = c.id ";
		String sqlWhere = " where 1= 1 ";
		String orderby = "  b.id" ;
		String tableString = "";
         
        //查询条件显示结果
        if(!goodscate_x.equals(""))sqlWhere+=" and b.goodscate = '"+goodscate_x + "'";
	    if(!goodsname_x.equals(""))sqlWhere+=" and b.goodsname = "+ goodsname_x + "";

		//右侧鼠标 放上可以点击
		String  operateString= "";
		if(count_ss!=0&&isEnd.equals("")){
			operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:addFieldTrigger();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"盘点填报\" index=\"0\"/>"+
		                    "</operates>";
		}else if(count_cc!=0&&workprocess.equals("0")){
		    operateString =  "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:comment();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"批注\" index=\"1\"/> "+
		                    "</operates>";
		}else if(count_vv!=0&&workprocess.equals("1")||count_vv!=0&&workprocess.equals("2")){
		    operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsIn();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"入库\" index=\"0\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsBorrow();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"借用\" index=\"1\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsReturn();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"归还\" index=\"2\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsCustomerReturn();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"归还客户\" index=\"8\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsReceive();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"领用\" index=\"3\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsReturnback();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"退还\" index=\"4\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsLoss();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"报损\" index=\"5\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsScrap();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"报废\" index=\"6\"/> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:AssetsRepair();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"维修\" index=\"7\"/> "+
		                    "</operates>";
		}else if(workprocess.equals("0")&&count_ss==0){
			operateString = "";

	    }else{
			operateString = "<operates width=\"20%\">"+
		                    " <popedom transmethod=\"weaver.hrm.common.SplitPageTagOperate.getBasicOperate\" otherpara=\""+String.valueOf(user.isAdmin())+":true:true:true:true\"></popedom> "+
		                    "     <operate isalwaysshow=\"true\" href=\"javascript:differenceHandle();\" linkkey=\"idkey\" linkvaluecolumn=\"idkey\" text=\"差异处理记录\" index=\"1\"/> "+
		                    "</operates>";
	    }
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(assets_pageId,user.getUID(),PageIdConst.HRM)+            "\" pageId=\""+assets_pageId+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
		if(workprocess.equals("0")){
			tableString+="<col width=\"10%\" labelid=\"ID\" text=\"ID\" column=\"idkey\" orderkey=\"idkey\"/>"+
			"               <col width=\"15%\" labelid=\"资产类别\" text=\"资产类别\" column=\"catename\" orderkey=\"catename\" linkvaluecolumn=\"cate\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=89&amp;formId=-117\" target=\"_fullwindow\" />"+
			"				<col width=\"15%\" labelid=\"资产名称\" text=\"资产名称\" column=\"goodsname\" orderkey=\"goodsname\" linkvaluecolumn=\"assets\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=82&amp;formId=-122\" target=\"_fullwindow\" />"+
			"				<col width=\"15%\" labelid=\"资产编号\" text=\"资产编号\" column=\"goodsno\" orderkey=\"goodsno\"/>"+
			"				<col width=\"15%\" labelid=\"实盘数\" text=\"实盘数\" column=\"actual\" orderkey=\"actual\"/>"+
			"				<col width=\"15%\" labelid=\"监盘数\" text=\"监盘数\" column=\"monitornum\" orderkey=\"monitornum\"/>"+
			"				<col width=\"15%\" labelid=\"备注说明\" text=\"备注说明\" column=\"remark\" orderkey=\"remark\"/>"+
			"				<col width=\"10%\" labelid=\"批注\" text=\"批注\" column=\"commenton\" orderkey=\"commenton\"/>"+
		"			</head>"+
	" </table>";
	}else{
				tableString+="<col width=\"10%\" labelid=\"资产类别\" text=\"所属类别\" column=\"catename\" orderkey=\"catename\" linkvaluecolumn=\"cate\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=89&amp;formId=-117\" target=\"_fullwindow\" />"+
				"				<col width=\"10%\" labelid=\"资产名称\" text=\"资产名称\" column=\"goodsname\" orderkey=\"goodsname\" linkvaluecolumn=\"assets\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=82&amp;formId=-122\" target=\"_fullwindow\" />"+
				"				<col width=\"10%\" labelid=\"资产编号\" text=\"资产编号\" column=\"goodsno\" orderkey=\"goodsno\"/>"+
				"				<col width=\"10%\" labelid=\"库存数\" text=\"库存数\" column=\"original\" orderkey=\"original\"/>"+
				"				<col width=\"10%\" labelid=\"实盘数\" text=\"实盘数\" column=\"actual\" orderkey=\"actual\"/>"+
				"				<col width=\"10%\" labelid=\"监盘数\" text=\"监盘数\" column=\"monitornum\" orderkey=\"monitornum\"/>"+
				"				<col width=\"10%\" labelid=\"盘点差异\" text=\"盘点差异\" column=\"differencex\" orderkey=\"differencex\"/>"+
				"				<col width=\"10%\" labelid=\"处理后差异\" text=\"处理后差异\" column=\"difference_x\" orderkey=\"difference_x\"/>"+
				"				<col width=\"10%\" labelid=\"备注\" text=\"备注\" column=\"remark\" orderkey=\"remark\"/>"+
			"			</head>"+
		" </table>";
	}

	%>
	<%
	if(isEnd.equals("")&&count_ss!=0){%>	
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true" />
    <%}else{%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<%}%>
	<script type="text/javascript">
	   var workprocess = <%=workprocess%>;
	   var checkperson = <%=count_ss%>;
	   if(checkperson!=0&&workprocess==0){
	       alert("友情提醒：未填写数据就直接盘点结束，默认资产实盘数为零");
        }
	   var diag_vote;

	      function closeDialog(){
	    diag_vote.close();
      }

          function closeDlgARfsh(){
	   _table.reLoad();
	   diag_vote.close();
       }

		  function onBtnSearchClick() {
			report.submit();
		}

				function AssetsIn(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=0&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsBorrow(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=1&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsReturn(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=2&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}

		function AssetsCustomerReturn(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=8&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsReceive(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=3&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsReturnback(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=4&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsLoss(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=5&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsScrap(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=6&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}
		function AssetsRepair(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?type=7&amp;idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}

		//填报
		function addFieldTrigger(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/ActualAssetsEdit.jsp?idkey="+idkey+"";
		
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 600;
		diag_vote.Height = 400;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show();
	}
        //差异处理
		function differenceHandle(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleForBonus.jsp?idkey="+idkey+"";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	}

	    //批注
	    function comment(idkey){
	    var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/AssetsCheckComment.jsp?idkey="+idkey+"";
		
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

		function checkWriteEnd() {
            
			document.report.checkid.value = <%=checkid%> ;
			document.report.action = "/seahonor/jsp/IsEndRefersh.jsp?type=0";
            document.report.submit();
            //closeWindows();

  		}
  		function monitor(){
  			document.report.checkid.value = <%=checkid%> ;
			document.report.action = "/seahonor/jsp/IsEndRefersh.jsp?type=1";
            document.report.submit();
  		} 

  		function approval() {
  			var checkid_temp = <%=checkid%>
  			$.ajax({ 
                async: true, 
                type : "POST", 
                data : {"checkid_temp":checkid_temp},
                url : "/seahonor/jsp/DiffNumJudge.jsp", 
                dataType : "json", 
                success : function(data){
                	if(data == '1'){
	                    document.report.checkid.value = <%=checkid%> ;
						document.report.action = "/seahonor/jsp/AssetsCheckApprove.jsp";
						alert("提交成功");
	            		document.report.submit();
	          		    }else{
	          				alert("警告:差异未处理完或处理流程未走完！");  
          		    }
          		}
            }); 
  		}

  		function refersh() {
  			window.location.reload();
  		}


  		function approvalReturn() {
  			document.report.checkid.value = <%=checkid%> ;
		    document.report.action = "/seahonor/jsp/ApprovalReturn.jsp";
            document.report.submit();

  		}

  		function approvalflow() {
  			document.report.checkid.value = <%=checkid%> ;
		    document.report.action = "/seahonor/jsp/ApprovalFlow.jsp";
            document.report.submit();
            alert("提交成功");
  		}

  		function ExcelExport(){
	    var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/ExcelIn.jsp";
		
		if(window.top.Dialog){
		diag_vote = new window.top.Dialog();
	    } else {
		    diag_vote = new Dialog();
	    };
	    diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 320;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show("");
	    }

	    function add(idkey){
		var title = "";
		var url = "";
		title = "资产盘点";
		url="/seahonor/jsp/DifferenceHandleAdd.jsp?idkey="+idkey+"";
		
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 600;
		diag_vote.Height = 400;
		diag_vote.maxiumnable = true;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.show();
        }

        function closeWindows() {

        }

	</script>
</BODY>
</HTML>