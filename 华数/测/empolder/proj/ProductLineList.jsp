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
boolean isDuty = false;//产品线负责人可以查看所有负责的产品线（业务线条件过滤掉）
String sql_s = "select * from  ProductDictionary  where dutyNameID = '"+user.getUID()+"'";
recordSet3.executeSql(sql_s);
if(recordSet3.next()){
	isDuty = true;
}

boolean isAll =false;

if(HrmUserVarify.checkUserRight("proj:AllProject",user)) {
	isAll = true;
}
if(isAll){
}else{
	if(!HrmUserVarify.checkUserRight("product:edit",user)) {
			if(isDuty){
				
			}else{
				sql_s = "select * from ProductDictionary  where  isShow = '0' and forserverline in (select id from serviceLine where personnel_1 like '%,"+user.getUID()+",%' or personnel_1 like '%,"+user.getUID()+"' or personnel_1 like '%"+user.getUID()+",%' or personnel_1 = '"+user.getUID()+"')";
				recordSet3.executeSql(sql_s);
				if(recordSet3.next()){
					
				}else{
					response.sendRedirect("/notice/noright.jsp") ;
					return ;
				}
			}
		
		}
}


String imagefilename = "/images/hdMaintenance.gif";
String titlename = "产品线列表";
String needfav ="1";
String needhelp ="";

    //以下得搜索时的变量值
    String name = Util.null2String(request.getParameter("name"));

    //构建where语句
    String andSql="";
    if(!"".equals(name)) andSql+=" and t1.name like '%"+name+"%'";


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
	//对于新建或是查询，只有属于产品线维护角色
if(HrmUserVarify.checkUserRight("product:edit",user) || isDuty){
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/proj/ProductLineAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
// }
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
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="15%">
                                <col width="30%">
                                <col width="10%">
                                <col width="15%">
                                <col width="30%">
                                <TR>
                                    <TD>名称</TD>
                                    <TD class="field">
                                        <Input type="text" class="inputstyle" name="name" value="<%=name%>"/>
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                </TBODY>
                            </TABLE>



                             <!--列表部分-->
                          <%
                                //得到pageNum 与 perpage
                                int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;;
                                int perpage = UserDefaultManager.getNumperpage();
                                if(perpage <2) perpage=15;

                                //设置好搜索条件
                                String backFields =" t1.id,t1.o_order,t1.name,t1.description,t1.forserverline,t1.dutynameid,t2.name as cname";
                                String fromSql = " ProductDictionary t1";
                                       fromSql += " left join serviceline t2 on t1.forserverline = t2.id";
                                String sqlWhere = "";
                                if(isAll){
                                	sqlWhere = "where t1.isShow = '0'";
                                }if(isDuty){
                                	sqlWhere= " where t1.isShow = '0' and (t1.dutyNameID = '"+user.getUID()+"'or Createperson= '"+user.getUID()+"' or t1.forserverline in (select id from serviceLine  where isshow = '0' and (personnel_1 like '%,"+user.getUID()+",%' or personnel_1 like '%,"+user.getUID()+"' or personnel_1 like '%"+user.getUID()+",%' or personnel_1 = '"+user.getUID()+"')))"+andSql;
                                }
                                else{
	                                sqlWhere= " where t1.isShow = '0' and t1.forserverline in (select id from serviceLine where isshow = '0' and (personnel_1 like '%,"+user.getUID()+",%' or personnel_1 like '%,"+user.getUID()+"' or personnel_1 like '%"+user.getUID()+",%' or personnel_1 = '"+user.getUID()+"'))"+andSql;
                                }
                                String orderBy=" t1.forserverline,t1.o_order,t1.id ";

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                             "<col width=\"10%\"  text=\"位置\" column=\"o_order\" orderkey=\"o_order\" />";
                                             if(isAll){
                                            	tableString += "<col width=\"15%\"  text=\"名称\" column=\"name\" orderkey=\"name\"/>";
                                             }else{
                                            	tableString += "<col width=\"15%\"  text=\"名称\" column=\"name\" orderkey=\"name\" href=\"ProductLineAdd.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" target=\"_self\"/>";
                                             }
                                             tableString += "<col width=\"15%\"  text=\"所属业务线\" column=\"cname\" orderkey=\"cname\" />"+
                                             "<col width=\"10%\"  text=\"负责人\" column=\"dutynameid\" orderkey=\"dutynameid\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"60%\"  text=\"描述\" column=\"description\" orderkey=\"description\" />"+
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
        document.frmmain.action="ProductLineList.jsp";
		document.frmmain.submit();
}
</script>
</html>