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

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "一级部门维护";
String needfav ="1";
String needhelp ="";

    //以下得搜索时的变量值
    //层级
    String level = Util.null2String(request.getParameter("level"));
    String name = Util.null2String(request.getParameter("name"));

    //构建where语句
    String andSql="";
    if (!"".equals(level)) andSql+=" and deplevel="+level;
    if(!"".equals(name)) andSql+=" and name like '%"+name+"%'";


%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
if(HrmUserVarify.checkUserRight("FnaLedgerAdd:Add", user)){

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/finance/firstDepAdd.jsp?level="+level+",_parent} " ;
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
<input type="hidden" name="operation">
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
			<wea:item>部门名称</wea:item>
			<wea:item>
				<Input type="text" class="inputstyle" name="name" value="<%=name%>"/>
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




                             <!--列表部分-->
                          <%
                                //得到pageNum 与 perpage
                                int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;;
                                int perpage = UserDefaultManager.getNumperpage();
                                if(perpage <2) perpage=15;

                                //设置好搜索条件
                                String backFields =" id,name,code,description,deplevel ";
                                String fromSql = " firstDepLeft ";
                                String sqlWhere = " where 1=1 "+andSql;
                                String orderBy=" id ";

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"id\" sqlsortway=\"Asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                             "<col width=\"25%\"  text=\"名称\" column=\"name\" orderkey=\"name\" href=\"firstDepAdd.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" target=\"contentframe\"/>"+
                                             "<col width=\"15%\"  text=\"金蝶部门编码\" column=\"code\" orderkey=\"code\"/>"+
                                             "<col width=\"15%\"  text=\"层级\" column=\"deplevel\" orderkey=\"deplevel\" transmethod=\"tool.tools.getFirstDepName\" />"+
                                             "<col width=\"45%\"  text=\""+SystemEnv.getHtmlLabelName(433,user.getLanguage())+"\" column=\"description\" orderkey=\"description\" />"+
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
        document.searchfrm.action="firstDepList.jsp";
		document.searchfrm.submit();
}
</script>
</html>