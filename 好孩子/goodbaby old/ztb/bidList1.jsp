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
	boolean canedit = true;
	%>
	<%
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();


    //拿取盘点资产列表id
	String idkey = Util.null2String(request.getParameter("idkey"));

	String url = "";
	String oper = "";
	//获取对应显示数据值
    String goodscate = "";
    String assets = "";
    String goodsname = "";
    String goodsno = "";
    String original = "";
    String goodscate_name = "";
    String goods_name = "";
    int actual = 0;
    int stock = 0;

    String operate = Util.null2String(request.getParameter("operate"));
	//拿取盘点主表状态值
	String checkid = "";
	String sql = "select * from  uf_checkrecord_dt1 where id = "+idkey+"";
	rs.executeSql(sql);
	if(rs.next()){
		checkid =  Util.null2String(rs.getString("mainid"));
		goodscate = Util.null2String(rs.getString("goodscate"));
		assets = Util.null2String(rs.getString("assets"));
    	goodsname = Util.null2String(rs.getString("goodsname"));
   		goodsno = Util.null2String(rs.getString("goodsno"));
    	original = Util.null2String(rs.getString("original"));
    	actual = rs.getInt("actual");
    	stock = rs.getInt("stock");
    }

    String sql_1 = "select catename from uf_goodscate where id = replace('"+goodscate+"','57_','')";
	rs.executeSql(sql_1);
	if(rs.next()){
	       goodscate_name = Util.null2String(rs.getString("catename"));
	   }
	String sql_2 = "select goodsname from uf_goodsinfo where id = "+goodsname+"";
	rs.executeSql(sql_2);
	if(rs.next()){
	       goods_name = Util.null2String(rs.getString("goodsname"));
	   }

    String lastname = "";
    String num = Util.null2String(request.getParameter("num"));
    String remark = Util.null2String(request.getParameter("remark"));

	String approve = "";
	String workprocess = "";
	String wfdifferencehandle = "";
	String workflowshow = "";
	String sql2 = "select approve,workprocess,wfdifferencehandle, workflowshow from  uf_checkrecord where id = "+checkid+"";
	rs.executeSql(sql2);
	if(rs.next()){
	approve =  Util.null2String(rs.getString("approve"));
	workprocess =  Util.null2String(rs.getString("workprocess"));
	wfdifferencehandle =  Util.null2String(rs.getString("wfdifferencehandle"));
	workflowshow =  Util.null2String(rs.getString("workflowshow"));
}

    //读取当前操作人
    int count_vv = 0;
    int userid = user.getUID();
    String sql_person_write= "select count(id) as count_vv from uf_checkrecord where id= "+checkid+" and admin= "+userid+"";
    rs.executeSql(sql_person_write);
    if(rs.next()){
    	count_vv = rs.getInt("count_vv");
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
		if(count_vv!=0){
		if(wfdifferencehandle.equals("")){

		RCMenu += "{删除,javascript:deletex(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{保存,javascript:save(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
	}
}

		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="" method=post>
		<input type="hidden" name="idkey" value="">
		<input type="hidden" name="handleRecord_main" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				</td>
				<td class="rightSearchSpan" 
					style="text-align: right; width: 400px !important">
					<%if(count_vv!=0){%>
					<%if(wfdifferencehandle.equals("")){%>
					<input type="button"
						value="删除"
						class="e8_btn_top middle" onclick="deletex()" />
					<input type="button"
						value="保存"
						class="e8_btn_top middle" onclick="save()" />
					<%}%>
				<%}%>
					<span
						title="<%=SystemEnv.getHtmlLabelName(23036, user.getLanguage())%>"  class="cornerMenu middle"></span>
				</td>
			</tr>
		</table>
        <%if(count_vv!=0&&wfdifferencehandle.equals("")){%>
		<div class="zDialog_div_content" id="differencehandle" name="differencehandle">
				<wea:layout type="2col">
				<wea:group context="差异处理" >

				<wea:item>资产名称</wea:item>
				<wea:item><%=goods_name%></wea:item>

				<wea:item>资产编号</wea:item>
				<wea:item><%=goodsno%></wea:item>

				<wea:item>报损数量</wea:item>
				<wea:item>
				<wea:required id="nameimage" required="true" value="">
				<% if(canedit) {%>
					<INPUT  maxLength=50 size=45 name="num" style="width: 90px;" id = "name"
						value="<%=num%>"
						onchange='checkinput("num","nameimage")'
						temptitle="<%=SystemEnv.getHtmlLabelName(-433,user.getLanguage())%>"
						onkeypress="ItemCount_KeyPress()">
					<%} else {%><%=Util.toScreen(RecordSet.getString(2),user.getLanguage())%><%}%>
				</wea:required>
				</wea:item>

         		<wea:item>备注说明</wea:item>
				<wea:item>
				<TEXTAREA class=InputStyle ROWS="4" STYLE="width:65%" name="desc" value="<%=remark%>"></TEXTAREA>
				</wea:item>

				</wea:group>
				</wea:layout>
		</div>
       	<div class="zDialog_div_content" id="differencerecord" name="differencerecord">
				<wea:layout type="2col">
					<wea:group context="处理记录" >
					</wea:group>
				</wea:layout>

		</div>
		<%}%>
		<%
		String backfields = " a.id,a.handleassets,a.handleno,case a.handletype when '0' then '入库' when '1' then '借用' when '2' then '归还' "+
							" when '3' then '领用' when '4' then '退还' when '5' then '报损' when '6' then '报废' when '7' then '维修' else '归还客户' end as type, "+
							"a.creater,a.applicant,a.handlenum,a.handleremark,b.goodsname,b.goodsnum ";
		String fromSql  = " from uf_differhandle a join uf_goodsinforecord b on a.handleassets = b.id ";
		String sqlWhere = " where IdKey = "+idkey+" and notinstock is null and IsReject is null";
		String orderby = "" ;
		String tableString = "";
         
		//右侧鼠标 放上可以点击
		String  operateString= "";
	    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(PageIdConst.HRM_ONLINEUSER,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+PageIdConst.HRM_ONLINEUSER+"\">"+
		           "	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"Asc\" sqlisdistinct=\"false\"/>"+
		operateString+
		"			<head>";
			tableString+=""+
			"				<col width=\"14%\" labelid=\"处理资产\" text=\"处理资产\" column=\"goodsname\" orderkey=\"goodsname\" linkvaluecolumn=\"handleassets\" linkkey=\"billid\" href=\"/formmode/view/ViewMode.jsp?type=0&amp;modeId=82&amp;formId=-122\" target=\"_fullwindow\"/>"+
			"				<col width=\"14%\" labelid=\"处理资产编号\" text=\"处理资产编号\" column=\"goodsnum\" orderkey=\"goodsnum\"/>"+
			"				<col width=\"14%\" labelid=\"处理方式\" text=\"处理方式\" column=\"type\" orderkey=\"type\"/>"+
			"               <col width=\"14%\" labelid=\"处理创建人\" text=\"处理创建人\" column=\"creater\" orderkey=\"creater\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  linkvaluecolumn=\"creater\"  linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
			"               <col width=\"14%\" labelid=\"处理申请人\" text=\"处理申请人\" column=\"applicant\" orderkey=\"applicant\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"  linkvaluecolumn=\"applicant\"  linkkey=\"id\" href=\"/hrm/HrmTab.jsp?_fromURL=HrmResource\" target=\"_fullwindow\"/>"+
			"				<col width=\"10%\" labelid=\"处理数量\" text=\"处理数量\" column=\"handlenum\" orderkey=\"handlenum\"/>"+
			"				<col width=\"20%\" labelid=\"处理说明\" text=\"处理说明\" column=\"handleremark\" orderkey=\"handleremark\"/>"+
		"			</head>"+
	" </table>";
	%>

	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />
	<jsp:include page="/systeminfo/commonTabFoot.jsp"></jsp:include> 
</FORM> 
</BODY>
</HTML>
    <LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript">

	jQuery(differencerecord).html("<td class='interval'><span class='groupbg'></span><span class='e8_grouptitle'>处理记录</span></td><td class='interval' colspan='2' style='text-align:right;'><span class='toolbar'></span></td>");
        
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

        function save(){
        	if(check_form(report,'applicant,num')){
        	var idkeyx = <%=idkey%>;
        	document.report.idkey.value = idkeyx ;
       		document.report.action = "DifferHandleRecord.jsp?type=5";
        	document.report.submit();
        }
        }

        function deletex(){
        	var handleRecord_main = _xtable_CheckedCheckboxId();
        	var idkeyx = <%=idkey%>;
        	document.report.idkey.value = idkeyx ;
        	document.report.handleRecord_main.value = handleRecord_main;
       		document.report.action = "DifferHandleDelete.jsp?type=5";
       		document.report.submit();
        }

  		function refersh() {
  			window.location.reload();
  		}

	</script>