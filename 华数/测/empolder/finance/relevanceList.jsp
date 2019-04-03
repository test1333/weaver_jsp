<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@ page import="java.util.*" %>
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />

<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
</head>
<% 

boolean canedit = HrmUserVarify.checkUserRight("FnaBudgetfeeTypeEdit:Edit", user) ;

//所属父级
String parentID = Util.null2String(request.getParameter("parent"));
//搜索条件
String subjectid = Util.fromScreen(request.getParameter("subjectid"),user.getLanguage());

String tem_name = "";

recordSet.executeSql("select * from firstDepLeft where id = '"+parentID+"'");
if(recordSet.next()){
	tem_name = recordSet.getString("name");
}

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "科目关系列表:"+tem_name;
String needfav ="1";
String needhelp ="";

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if(HrmUserVarify.checkUserRight("FnaLedgerAdd:Add", user)){

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/finance/relevanceAdd.jsp?parentID="+parentID+",_parent} " ;
RCMenuHeight += RCMenuHeightStep ;
}
%>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top">

<FORM id=weaver name=searchfrm action=FnaBudgetfeeTypeOperation.jsp method=post >
<input class=inputstyle type=hidden name=operation value="add">
<input class=inputstyle type=hidden name=parent value="<%=parentID%>">
<div class="e8_boxhead">
	<div class="div_e8_xtree" id="div_e8_xtree"></div>
    <div class="e8_tablogo" id="e8_tablogo" style="background-image: url('/js/tabs/images/nav/mnav3_wev8.png'); margin-left: 6px;"></div>
	<div class="e8_ultab">
		<div class="e8_navtab" id="e8_navtab">
			<%=titlename%>
		</div>
	</div>
</div>
 <div class="tab_box" style="height: 110px; visibility: visible;">
	<wea:layout type="fourCol">
		<wea:group context="查询条件">
			<wea:item><%=SystemEnv.getHtmlLabelName(15409,user.getLanguage())%></wea:item>
			<wea:item>
				<brow:browser viewType="0"  name="subjectid" browserValue="<%=subjectid%>"
                browserUrl="/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.subjectDeatil"
              	hasInput="true"  hasBrowser = "true" isMustInput='1' isSingle="false"
                 width="120px"
                linkUrl=""
                browserSpanValue="<%=tem_name %>">
                </brow:browser>

			</wea:item>
		</wea:group>
		<wea:group context="">
			<wea:item type="toolbar">
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%>" class="e8_btn_submit" onclick="onSearch()"/>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
			</wea:item>
		</wea:group>
	</wea:layout>
</div>	

                          <%
                                //得到pageNum 与 perpage
                                int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;;
                                int perpage = UserDefaultManager.getNumperpage();
                                if(perpage <2) perpage=15;

                                //设置好搜索条件
                                String backFields =" t1.id,t1.subjectID,t1.subjcetCode,t1.description,t1.parentDepID,t1.isFalg,"
										+"  (select name from subjectDeatil where id=t1.subjectID) as name2,(case isFalg when '0' then '有' else '无'  end ) as isFalg1  ";
                                String fromSql = " relevance t1 ";
                                String sqlWhere = " where 1=1 and t1.parentDepID = '"+parentID+"'";
                                if(!"".equals(subjectid) && !"0".equals(subjectid)){
                                	sqlWhere += " and t1.subjectID = '"+subjectid+"'";
                                }
                                String orderBy=" t1.id ";

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                             "<col width=\"30%\"  text=\"科目名称\" column=\"name2\" orderkey=\"name2\" href=\"relevanceAdd.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" target=\"contentframe\"/>"+
                                             "<col width=\"15%\"  text=\"科目编码\" column=\"subjcetCode\" orderkey=\"subjcetCode\"/>"+
                                             "<col width=\"30%\"  text=\"描述\" column=\"subjcetCode\" orderkey=\"subjcetCode\"  />"+
                                             "<col width=\"25%\"  text=\"是否有归属地\" column=\"isFalg1\" orderkey=\"isFalg1\" />"+
                                       "</head>"+
                                       "</table>";
                              %>

                                            <wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>"  mode="run"/>

                  </form>



</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
</body>
<SCRIPT language="javascript">
function onSearch(){
        document.searchfrm.action="relevanceList.jsp";
		document.searchfrm.submit();
}
</script>
</html>