<%@page import="tool.tools"%>
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
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="tools" class="tool.tools" scope="page" />

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<script language="javascript"  type='text/javascript' src="/js/jquery/jquery-1.4.2.min.js"></script>
</head>
<% 

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "�ҵ�����Ŀ";
String needfav ="1";
String needhelp ="";



    //���µ�����ʱ�ı���ֵ
    String procode = Util.null2String(request.getParameter("procode"));
    
    String userID = String.valueOf(user.getUID());
    String productProjectID = Util.null2String(request.getParameter("productProjectID"));
    String execution = Util.null2String(request.getParameter("execution"));
    String projectManager = Util.null2String(request.getParameter("projectManager"));
    String timeLine  = Util.null2String(request.getParameter("timeLine"));
    String totimeLine  = Util.null2String(request.getParameter("totimeLine"));
    String formTime  = Util.null2String(request.getParameter("formTime"));
    String toTime  = Util.null2String(request.getParameter("toTime"));

    //����where���
    String andSql="";
    if(!"".equals(procode)) andSql+=" and t1.name like '%"+procode+"%'";
    if(!"".equals(projectManager)) andSql+=" and t1.projectManager = '"+projectManager+"'";
    if(!"".equals(productProjectID) && !"0".equals(productProjectID)) andSql+=" and t1.productProjectID = '"+productProjectID+"'";
    if(!"".equals(timeLine)) andSql+=" and t1.timeline >= '"+timeLine+"'";
    if(!"".equals(totimeLine)) andSql+=" and t1.timeline <= '"+totimeLine+"'";
    if(!"".equals(formTime)) andSql+=" and t1.overtime >= '"+formTime+"'";
    if(!"".equals(toTime)) andSql+=" and t1.overtime <= '"+toTime+"'";
    
    

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

// RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/proj/ProductAdd.jsp,_self} " ;
// RCMenuHeight += RCMenuHeightStep ;
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

                         <!--��������-->
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="15%">
                                <col width="35%">
                                <col width="15%">
                                <col width="35%">
                                <TR>
                                    <TD>����Ŀ���</TD>
                                    <TD class="field">
                                        <Input type="text" class="inputstyle" name=procode value="<%=procode%>"/>
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
                                 <TR>
                                    <TD>��Ʒ������Ŀ</TD>
                                    <TD class="field">
                                        <BUTTON class=Browser id=ServiceLineBrowser onClick="onProductProjectBrowser()"></BUTTON> <span 
							            id=productProjectIDspan><%=tools.getProductPorjectName(productProjectID) %></span> 
							              <INPUT class=inputstyle type=hidden name="productProjectID" id="productProjectID" value="<%=productProjectID%>">
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
                                    <TD>��Ŀ����</TD>
                                    <TD class="field">
                                        <BUTTON class=Browser id=SelectManagerID onClick="onShowResource1()"></BUTTON> 
								      	<span id=projectManagerspan><%=ResourceComInfo.getLastname(projectManager)%></span> 
								              <INPUT class=inputstyle type=hidden name="projectManager" value="<%=projectManager %>">
                                    </TD>
                                    <TD>���ʱ��</TD>
                                    <TD class="field">
                                       <button type=button class=calendar id=SelectDate onClick="getDate(fromTimespan,formTime)"></button>
										<span id=fromTimespan ><%=formTime %> </span><span>-</span>
										<input type="hidden" name="formTime" value="<%=formTime %>">
										<button type=button class=calendar id=SelectDate onClick="getDate(toTimespan,toTime)"></button>
										<span id=toTimespan ><%=toTime %></span>
										<input type="hidden" name="toTime" value="<%=toTime %>">
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
                                String backFields =" t1.id,t1.procode,t1.productprojectID,t1.productversionID,t1.timeLine, case t1.execution when '0' then '����' when '1' then '����' when '2' then '�ݻ�' when '3' then '���' end as execution ,t1.businessleader,t1.producemanager,t1.projectmanager,t1.technicalmanager,t1.overtime ";
                                String fromSql = " Prj_ProjectInfo t1";
                                String sqlWhere = " where t1.id in (select t1.id  from Prj_ProjectInfo t1 "+
												  " where t1.businessleader = '"+userID+"' or t1.producemanager = '"+userID+"' or t1.projectmanager = '"+userID+"' or technicalmanager = '"+userID+"')"+andSql;
                                String orderBy=" t1.id ";
//                                 out.print(backFields+fromSql+sqlWhere);

                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                       "<col width=\"10%\"  text=\"����Ŀ���\" column=\"procode\" orderkey=\"procode\" href=\"/proj/data/ViewProject.jsp\" linkkey=\"ProjID\" linkvaluecolumn=\"id\" target=\"_self\"/>"+
                                             "<col width=\"10%\"  text=\"��Ʒ������Ŀ\" column=\"productprojectID\" orderkey=\"productprojectID\" transmethod=\"tool.tools.getProductPorjectName\"/>"+
                                             "<col width=\"10%\"  text=\"��Ʒ��+�汾\" column=\"productversionID\" orderkey=\"productversionID\" transmethod=\"tool.tools.getProjectInfoName\"/>"+
                                             "<col width=\"10%\"  text=\"����ʱ��\" column=\"timeLine\" orderkey=\"timeLine\" />"+
                                             "<col width=\"10%\"  text=\"������\" column=\"execution\" orderkey=\"execution\" />"+
                                             "<col width=\"10%\"  text=\"���ʱ��\" column=\"overtime\" orderkey=\"overtime\" />"+
                                             "<col width=\"10%\"  text=\"ҵ����\" column=\"businessleader\" orderkey=\"businessleader\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"��Ʒ����\" column=\"producemanager\" orderkey=\"producemanager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"��Ŀ����\" column=\"projectmanager\" orderkey=\"projectmanager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"��������\" column=\"technicalmanager\" orderkey=\"technicalmanager\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
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
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript">
function onSearch(){
        document.frmmain.action="ProjectSearchList.jsp";
		document.frmmain.submit();
}
function onProductProjectBrowser() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/proj/ProductProjectBrowser.jsp");
	                     if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#productProjectID").val(ids);
					jQuery("#productProjectIDspan").html(names);
				} else {
					jQuery("#productProjectID").val("");
					jQuery("#productProjectIDspan").html("");
				}
			}
	}
</script>
<script language=vbs>
sub onShowResource1()
id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
if NOT isempty(id) then
        if id(0)<> "" then
	projectManagerspan.innerHtml = id(1)
	frmmain.projectManager.value=id(0)
	else
	projectManagerspan.innerHtml = ""
	frmmain.projectManager.value=""
	end if
end if

end sub
</script>
</html>