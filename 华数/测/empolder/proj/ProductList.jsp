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
<jsp:useBean id="tools" class="tool.tools" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript" type="text/javascript" src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<% 

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "�ҵĲ�ƷĿ���б�";
String needfav ="1";
String needhelp ="";

    //���µ�����ʱ�ı���ֵ
    String name = Util.null2String(request.getParameter("name"));
    
    String userID = String.valueOf(user.getUID());
    String num = Util.null2String(request.getParameter("num"));
    String version = Util.null2String(request.getParameter("version"));
    String execution = Util.null2String(request.getParameter("execution"));
    String productManager = Util.null2String(request.getParameter("productManager"));
    String priority  = Util.null2String(request.getParameter("priority"));
    String formTime  = Util.null2String(request.getParameter("formTime"));
    String toTime  = Util.null2String(request.getParameter("toTime"));
    String timeLine  = Util.null2String(request.getParameter("timeLine"));
    String totimeLine  = Util.null2String(request.getParameter("totimeLine"));

    //����where���
    String andSql="";
    if(!"".equals(name) && !"0".equals(name)) andSql+=" and t1.name = '"+name+"'";
    if(!"".equals(num)) andSql+=" and t1.num like '%"+num+"%'";
    if(!"".equals(version)) andSql+=" and t1.version like '%"+version+"%'";
    if(!"".equals(execution)) andSql+=" and t1.execution = '"+execution+"'";
    if(!"".equals(productManager) && !"0".equals(productManager)) andSql+=" and t1.productManager = '"+productManager+"'";
    if(!"".equals(priority)) andSql+=" and t1.priority = '"+priority+"'";
    if(!"".equals(formTime)) andSql+=" and t1.overtime >= '"+formTime+"'";
    if(!"".equals(toTime)) andSql+=" and t1.overtime <= '"+toTime+"'";
    if(!"".equals(timeLine)) andSql+=" and t1.timeline >= '"+timeLine+"'";
    if(!"".equals(totimeLine)) andSql+=" and t1.timeline <= '"+totimeLine+"'";

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

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

if(!HrmUserVarify.checkUserRight("product:Edit",user)) {
RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/proj/ProductAdd.jsp,_self} " ;
RCMenuHeight += RCMenuHeightStep ;
}
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

                         <!--��������-->
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                                <TR>
                                    <TD>��Ʒ������</TD>
                                    <TD class="field">
                                    <BUTTON class=Browser id=ServiceLineBrowser onClick="onProductLineBrowser()"></BUTTON> 
                                    <span id=namespan><%=tools.getProductLineName(name)%></span>
                                        <Input type="hidden" class="inputstyle" name="name" id = "name" value="<%=name%>"/>
                                    </TD>
                                    <TD>���ȼ�</TD>
                                    <TD class="field">
                                        <select name="priority">
											<option></option>
											<option value="0" <%if("0".equals(priority)){ %> selected="selected" <%} %>>��</option>
											<option value="1" <%if("1".equals(priority)){ %> selected="selected" <%} %>>��</option>
											<option value="2" <%if("2".equals(priority)){ %> selected="selected" <%} %>>��</option>
										</select>
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                 <TR>
                                    <TD>��Ʒ�汾</TD>
                                    <TD class="field">
                                        <Input type="text" class="inputstyle" name="version" value="<%=version%>"/>
                                    </TD>
                                    <TD>������</TD>
                                    <TD class="field">
                                        <select name="execution">
											<option></option>
											<option value="0" <%if("0".equals(execution)){ %> selected="selected" <%} %>>����</option>
											<option value="1" <%if("1".equals(execution)){ %> selected="selected" <%} %>>����</option>
											<option value="2" <%if("2".equals(execution)){ %> selected="selected" <%} %>>�ݻ�</option>
											<option value="3" <%if("3".equals(execution)){ %> selected="selected" <%} %>>���</option>
										</select>
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                 <TR>
                                    <TD>���ʱ��</TD>
                                    <TD class="field">
                                       <button type=button class=calendar id=SelectDate onClick="getDate(fromTimespan,formTime)"></button>
										<span id=fromTimespan ><%=formTime %> </span><span>-</span>
										<input type="hidden" name="formTime" value="<%=formTime %>">
										<button type=button class=calendar id=SelectDate onClick="getDate(toTimespan,toTime)"></button>
										<span id=toTimespan ><%=toTime %></span>
										<input type="hidden" name="toTime" value="<%=toTime %>">
                                    </TD>
                                    <TD>����ʱ��</TD>
                                    <TD class="field">
                                       <button type=button class=calendar id=SelectDate onClick="getDate(timeLinespan,timeLine)"></button>
										<span id=timeLinespan ><%=timeLine %> </span><span>-</span>
										<input type="hidden" name="timeLine" value="<%=timeLine %>">
										<button type=button class=calendar id=SelectDate onClick="getDate(totimeLinespan,totimeLine)"></button>
										<span id=totimeLinespan ><%=totimeLine %></span>
										<input type="hidden" name="totimeLine" value="<%=totimeLine %>">
                                    </TD>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                </TBODY>
                            </TABLE>



                             <!--�б���-->
                          <%
                                //�õ�pageNum �� perpage
                                int pagenum = Util.getIntValue(request.getParameter("pagenum") , 1) ;;
                                int perpage = UserDefaultManager.getNumperpage();
                                if(perpage <2) perpage=15;

                                //���ú���������
                                String backFields =" t1.id,t1.num,t1.name,t1.version, case t1.priority when '0' then '��' when '1' then '��' when '2' then '��' end as priority,t1.timeLine, case t1.execution when '0' then '����' when '1' then '����' when '2' then '�ݻ�' when '3' then '���' end as execution ,t1.productManager,t1.projectManager,t1.overtime ";
                                String fromSql = " projectInfo t1";
                              //  String sqlWhere = " where t1.isShow = '0' and (t1.productManager = '"+userID+"' or t1.projectManager = '"+userID+"') and t1.forline in (select id from serviceLine where personnel_1 like '%,"+user.getUID()+",%' or personnel_1 like '%,"+user.getUID()+"' or personnel_1 like '%"+user.getUID()+",%' or personnel_1 = '"+user.getUID()+"') "+andSql;
                                String sqlWhere = " where t1.isShow = '0' and ((t1.productManager = '"+userID+"' or t1.projectManager = '"+userID+"') or t1.forline in (select id from serviceLine where ','||personnel_1||',' like '%,"+user.getUID()+",%')) "+andSql;
                                String orderBy=" t1.timeLine,t1.id ";

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
//                                              "<col width=\"10%\"  text=\"���\" column=\"num\" orderkey=\"num\" />"+
                                             "<col width=\"10%\"  text=\"��Ʒ������\" column=\"name\" orderkey=\"name\" href=\"ProductAdd.jsp\" linkkey=\"id\" linkvaluecolumn=\"id\" target=\"_self\" transmethod=\"tool.tools.getProductLineName\"/>"+
                                             "<col width=\"10%\"  text=\"��Ʒ�汾\" column=\"version\" orderkey=\"version\" />"+
                                             "<col width=\"10%\"  text=\"���ȼ�\" column=\"priority\" orderkey=\"priority\" />"+
                                             "<col width=\"10%\"  text=\"����ʱ��\" column=\"timeLine\" orderkey=\"timeLine\" />"+
                                             "<col width=\"10%\"  text=\"������\" column=\"execution\" orderkey=\"execution\" />"+
                                             "<col width=\"10%\"  text=\"���ʱ��\" column=\"overtime\" orderkey=\"overtime\" />"+
                                             "<col width=\"10%\"  text=\"��Ʒ����\" column=\"productManager\" orderkey=\"productManager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"��Ŀ����\" column=\"projectManager\" orderkey=\"projectManager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
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
        document.frmmain.action="ProductList.jsp";
		document.frmmain.submit();
}
function onProductLineBrowser() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/proj/ProductLineBrowser.jsp");
	                     if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#name").val(ids);
					jQuery("#namespan").html(names);
				} else {
					jQuery("#name").val("");
					jQuery("#namespan").html("");
				}
			}
	}
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</html>