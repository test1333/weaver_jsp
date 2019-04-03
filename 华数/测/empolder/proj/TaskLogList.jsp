<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<% 

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "日志列表";
String needfav ="1";
String needhelp ="";

    //以下得搜索时的变量值
    String taskid = Util.null2String(request.getParameter("taskid"));

    //构建where语句
    String andSql="";
    if(!"".equals(taskid)) andSql+=" and t1.taskid = '"+taskid+"'";


//     String sql = "select * from hrmManager where id = '6'";
//     recordSet.executeSql(sql);
//     if(recordSet.next()){
//     	out.print(recordSet.getString("memo"));
//     }
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
// if(HrmUserVarify.checkUserRight("FnaLedgerAdd:Add", user)){

// RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
// RCMenuHeight += RCMenuHeightStep ;

// RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/proj/ProductLineAdd.jsp,_self} " ;
// RCMenuHeight += RCMenuHeightStep ;
// }
RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/proj/process/ViewTask.jsp?taskrecordid="+taskid+",_self} " ;
RCMenuHeight += RCMenuHeightStep;
%>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>

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

<FORM id=weaver name=frmmain  method=post >
<input class=inputstyle type=hidden name=operation value="add">

                         <!--搜索部分-->
<!--                             <TABLE  class ="ViewForm"> -->
<!--                                 <TBODY> -->
<!--                                 <colgroup> -->
<!--                                 <col width="15%"> -->
<!--                                 <col width="30%"> -->
<!--                                 <col width="10%"> -->
<!--                                 <col width="15%"> -->
<!--                                 <col width="30%"> -->
<!--                                 <TR> -->
<!--                                     <TD>名称</TD> -->
<!--                                     <TD class="field"> -->
<%--                                         <Input type="text" class="inputstyle" name="name" value="<%=name%>"/> --%>
<!--                                     </TD> -->
<!--                                 </TR> -->
<!--                                  <TR><TD class=Line colSpan=5></TD></TR> -->
<!--                                 </TBODY> -->
<!--                             </TABLE> -->



                             <!--列表部分-->
                          <%
                                //得到pageNum 与 perpage
                                int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;;
                                int perpage = UserDefaultManager.getNumperpage();
                                if(perpage <2) perpage=15;

                                //设置好搜索条件
                                String backFields =" t1.taskID,t1.modifydate,t1.modifytime,t1.modifyPeople,t1.old_content,t1.new_content ";
                                String fromSql = " Prj_TaskProcess_log t1";
                                String sqlWhere = " where 1 = 1 "+andSql;
                                String orderBy=" t1.id ";

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                             "<col width=\"20%\"  text=\"任务名称\" column=\"taskID\" orderkey=\"taskID\" transmethod=\"weaver.proj.Maint.ProjectTaskApprovalDetail.getProjectNameByTaskId\"/>"+
                                             "<col width=\"10%\"  text=\"修改日期\" column=\"modifyDate\" orderkey=\"modifyDate\" />"+
                                             "<col width=\"10%\"  text=\"修改时间\" column=\"modifyTime\" orderkey=\"modifyTime\" />"+
                                             "<col width=\"10%\"  text=\"修改人\" column=\"modifyPeople\" orderkey=\"modifyPeople\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"25%\"  text=\"原内容\" column=\"old_content\" orderkey=\"old_content\" />"+
                                             "<col width=\"25%\"  text=\"修改后内容\" column=\"new_content\" orderkey=\"new_content\" />"+
                                       "</head>"+
                                       "</table>";
                              %>
                                <TABLE width="100%" height="100%">
                                    <TR>
                                        <TD valign="top">
                                            <wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>"  mode="run"/>
                                        </TD>
                                    </TR>
                                </TABLE>
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
        document.frmmain.action="ServiceLineList.jsp";
		document.frmmain.submit();
}
</script>
</html>