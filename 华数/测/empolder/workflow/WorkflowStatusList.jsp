<%@page import="weaver.hrm.resource.ResourceComInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.PageManagerUtil " %>
<%@ page import="java.util.*" %>
<jsp:useBean id="recordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet2" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="recordSet3" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="UserDefaultManager" class="weaver.docs.tools.UserDefaultManager" scope="session" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="tools" class="tool.tools" scope="page"/>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<script type="text/javascript" language="javascript" src="/js/jquery/jquery.js"></script>
<% 
boolean canedit = HrmUserVarify.checkUserRight("FnaBudgetfeeTypeEdit:Edit", user) ;

String fromdate = Util.null2String(request.getParameter("fromdate"));
String todate = Util.null2String(request.getParameter("todate"));
String OANO = Util.null2String(request.getParameter("OANO"));
String resID = Util.null2String(request.getParameter("resID"));
String endFale = Util.null2String(request.getParameter("endFalg"));
String inFalg = Util.null2String(request.getParameter("inFalg"));
String money = Util.null2String(request.getParameter("money"));

String rzfromdate = Util.null2String(request.getParameter("rzfromdate"));
String rztodate = Util.null2String(request.getParameter("rztodate"));
// out.print(endFale+"-----");

String imagefilename = "/images/hdMaintenance.gif";
String titlename = "����ƾ֤�б�";
String needfav ="1";
String needhelp ="";
  
    String sql = "";
    String tablename = "";
    String detailtablename = "";
//     sql = "Select tablename From Workflow_bill Where id=(";
// 	sql += "Select formid From workflow_base Where id='37')";
//	sql = "select tablename,detailtablename From workflow_bill where id = '158'";
//	recordSet.executeSql(sql);
//	if(recordSet.next()){
//		tablename = recordSet.getString("tablename");
//		detailtablename = recordSet.getString("detailtablename");
//	}
	
	tablename = "formtable_main_1844";
	detailtablename = " formtable_main_1844_dt1";


			//������sqr
			String f_sqr = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqr"));
			//���벿��
			String f_sqbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqbm"));
			//�걨���
			String f_sbje = Util.null2String(Prop.getPropValue("FinancialDocuments", "sbje"));
			//ʵ�����
			String f_bxje = Util.null2String(Prop.getPropValue("FinancialDocuments", "bxje"));
			//�걨����
			String f_sbrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "sqrq"));
			//OA���
			String f_oabh = Util.null2String(Prop.getPropValue("FinancialDocuments", "oabh"));
			//�����־
			String f_drbz = Util.null2String(Prop.getPropValue("FinancialDocuments", "drbz"));
			//�Ƿ�����ƾ֤
			String f_sfscpz = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfxydr"));
			//����һ������
			String f_ssyjbm = Util.null2String(Prop.getPropValue("FinancialDocuments", "ssyjbm"));
			//ƾ֤��
			String f_pzh = Util.null2String(Prop.getPropValue("FinancialDocuments", "pzh"));
			//�Ƿ񵼳�excel
			String f_sfdc = Util.null2String(Prop.getPropValue("FinancialDocuments", "sfdc"));
			//��������
			String f_rzrq = Util.null2String(Prop.getPropValue("FinancialDocuments", "rzrq"));
			
			
			//��ص�workflowid
			String workflowid = Util.null2String(Prop.getPropValue("workflowStatusList", "workflowid"));
			//�ڵ�ID
			String nodeid = Util.null2String(Prop.getPropValue("workflowStatusList", "nodeid"));
    
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
// if(HrmUserVarify.checkUserRight("FnaLedgerAdd:Add", user)){
	RCMenu += "{Excel,javascript:doExport(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSearch(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;

// RCMenu += "{"+SystemEnv.getHtmlLabelName(365,user.getLanguage())+",/empolder/finance/relevanceAdd.jsp?parentID="+parentID+",_parent} " ;
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

<FORM id=weaver name=frmmain action=WorkflowStatusList.jsp method=post >
<input class=inputstyle type=hidden name=operation value="add">
<%-- <input class=inputstyle type=hidden name=parent value="<%=parentID%>"> --%>

                         <!--��������-->
                            <TABLE  class ="ViewForm">
                                <TBODY>
                                <colgroup>
                                <col width="15%">
                                <col width="30%">
                                <col width="10%">
                                <col width="15%">
                                <col width="30%">
                                <TR>
<td width=15%>��������</td>
    <td class=field width=35%><BUTTON class=calendar id=SelectDate name="SelectDate"  onclick="gettheDate(fromdate,fromdatespan)"></BUTTON>
      <SPAN id=fromdatespan ><%=fromdate%></SPAN>
      -&nbsp;&nbsp;<BUTTON class=calendar id=SelectDate1 name="SelectDate1" onClick="gettheDate(todate,todatespan)"></BUTTON>
      <SPAN id=todatespan ><%=todate%></SPAN>
	  <input type="hidden" name="fromdate" value="<%=fromdate%>">
	  <input type="hidden" name="todate" value="<%=todate%>">
    </td>
    <td width=15%>OA���̱��</td>
    <Td class="field" width=35%>
    	<input type="text"  class=InputStyle  name="OANO" value="<%=OANO%>">
    </Td>
                                </TR>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                 <tr>
                                 <tr>
                                 	<td width=15%>��������</td>
                                 	<td class=field width=35%><BUTTON class=calendar id=SelectDate name="SelectDate"  onclick="gettheDate(rzfromdate,rzfromdatespan)"></BUTTON>
								      <SPAN id=rzfromdatespan ><%=rzfromdate%></SPAN>
								      -&nbsp;&nbsp;<BUTTON class=calendar id=SelectDate1 name="SelectDate1" onClick="gettheDate(rztodate,rztodatespan)"></BUTTON>
								      <SPAN id=rztodatespan ><%=rztodate%></SPAN>
									  <input type="hidden" name="rzfromdate" value="<%=rzfromdate%>">
									  <input type="hidden" name="rztodate" value="<%=rztodate%>">
								    </td>
								    <td width=15%>ʵ�����</td>
                                 	<td width=30% class="field">
                                 	<input type="text"  class=InputStyle  name="money" value="<%=money%>">
                                 	</td>
                                 </tr>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                 	<td width=15%>�鵵��־</td>
                                 	<td width=30% class="field">
                                 		<select name="endFalg" class=inputstyle>
                                 		    <option></option>
                                 			<option value="0" <%if("0".equals(endFale)){ %> selected="selected" <%} %>>δ�鵵</option>
                                 			<option value="3" <%if("3".equals(endFale)){ %> selected="selected" <%} %>>�ѹ鵵</option>
                                 		</select>
                                 	</td>
                                 	<td width=15%>�����־</td>
                                 	<td width=30% class="field">
                                 		<select name="inFalg" class=inputstyle>
                                 		    <option></option>
                                 			<option value="0" <%if("0".equals(inFalg)){ %> selected="selected" <%} %>>δ����</option>
                                 			<option value="1" <%if("1".equals(inFalg)){ %> selected="selected" <%} %>>�ѵ���</option>
                                 		</select>
                                 	</td>
                                 </tr>
                                 <TR><TD class=Line colSpan=5></TD></TR>
                                 <td width=15%>������</td>
                                 	<td width=35% class="field">
                                 		<button class=Browser onClick="onShowCreater('resIDSpan','resID')"></button>
                                 		<span id=resIDSpan>
									      <%=ResourceComInfo.getResourcename(resID)%>
									      </span>
									      <input type="hidden" name="resID" value="<%=resID%>">
                                 	</td>
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
//                                 String backFields =" t1.id,t1."+f_sqr+",t1."+f_sqbm+",t1."+f_sbje+",t1."+f_bxje+",t1."+f_sbrq+",t1."+f_oabh+",t1."+f_drbz+",t1."+f_sfscpz+",t2.currentnodetype,t3.nodename ";
                                String backFields =" t1.id,t1."+f_sqr+",t1."+f_sqbm+",t1."+f_sbje+",t1."+f_bxje+",t1."+f_sbrq+",t1."+f_oabh+", case t1."+f_drbz+" when 0 then 'δ����' when 1 then '�ѵ���' else '' end as ffdrbz,t1."+f_sfscpz+",t1."+f_ssyjbm+",t1."+f_rzrq+",t1."+f_pzh+",case t1."+f_sfdc+" when 1 then '�ѵ���' else 'δ����' end as ff_sfdc,t1.requestid,t2.currentnodetype,t3.nodename,t4.sumamount,'��ϸ' as xx ";
                                String fromSql = tablename + " t1 "+
                                        " left join (select t1.requestid,t2.sumamount from "+tablename+" t1 left join (select t1.id,sum(t1."+f_sbje+") as sumamount from "+detailtablename+" t1 group by t1.id) t2 on t1.id = t2.id) t4 on t1.requestid = t4.requestid"+
                                        " left join workflow_requestbase t2 on t1.requestid = t2.requestid "+
                                        " left join (select t1.id,t1.nodename,t2.requestid from workflow_nodebase t1 left join workflow_requestbase t2 on t2.currentnodeid = t1.id) t3 on t3.requestid = t1.requestid"; 
//                                 String sqlWhere = " where t1.requestid in (select requestid from workflow_requestbase where workflowid in ("+workflowid+")) and t3.id in ("+nodeid+") and t1."+f_sbrq+" is not null";
                          //      String sqlWhere = " where t1.requestid in (select requestid from workflow_requestbase where workflowid in ("+workflowid+")) and t1."+f_sbrq+" is not null";
                                
                                String sqlWhere = " where t1."+f_sbrq+" is not null";
                                
                                String orderBy=" t1.id ";
                                if(!"".equals(fromdate)){
                                	sqlWhere += " and t1."+f_sbrq+" >= '"+fromdate+"'";
                                }
                                if(!"".equals(todate)){
                                	sqlWhere += " and t1."+f_sbrq+" <= '"+todate+"'";
                                }
                                if(!"".equals(OANO)){
                                	sqlWhere += " and t1."+f_oabh+" like '%"+OANO+"%'";
                                }
                                if(!"".equals(resID)){
                                	sqlWhere += " and t1."+f_sqr+" = '"+resID+"'";
                                }
                                if(!"".equals(endFale) && "3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype = '"+endFale+"'";
                                }else if(!"".equals(endFale) && !"3".equals(endFale)){
                                	sqlWhere += " and t2.currentnodetype <> '3'";
                                }
                                if(!"".equals(inFalg)){
                                	sqlWhere += " and t1."+f_drbz+" = '"+inFalg+"'";
                                }
                                if(!"".equals(money)){
                                	sqlWhere += " and t1."+f_bxje+" = '"+money+"'";
                                }
                                if(!"".equals(rzfromdate)){
                                	sqlWhere += " and t1."+f_rzrq+" >= '"+rzfromdate+"'";
                                }
                                if(!"".equals(rztodate)){
                                	sqlWhere += " and t1."+f_rzrq+" <= '"+rztodate+"'";
                                }
                                // new BaseBean().writeLog(backFields + fromSql);
                        //        out.println("select " + backFields + " from " + fromSql + sqlWhere);
                                String tableString=""+
                                       "<table pagesize=\""+perpage+"\" tabletype=\"none\">"+
                                       "<sql backfields=\""+backFields+"\" sqlform=\""+Util.toHtmlForSplitPage(fromSql)+"\" sqlorderby=\""+orderBy+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"Asc\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" />"+
                                       "<head>"+
                                             "<col width=\"8%\"  text=\"��������\" column=\""+f_sbrq+"\" orderkey=\""+f_sbrq+"\"/>"+
                                             "<col width=\"8%\"  text=\"OA���̱��\" column=\""+f_oabh+"\" orderkey=\""+f_oabh+"\"  href=\"/workflow/request/ViewRequest.jsp\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"/>"+
                                             "<col width=\"5%\"  text=\"������\" column=\""+f_sqr+"\" orderkey=\""+f_sqr+"\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getResourcename\"/>"+
                                             "<col width=\"10%\"  text=\"����һ������\" column=\""+f_ssyjbm+"\" orderkey=\""+f_ssyjbm+"\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
                                             "<col width=\"10%\"  text=\"��������\" column=\""+f_sqbm+"\" orderkey=\""+f_sqbm+"\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"/>"+
                                             "<col width=\"8%\"  text=\"�걨���\" column=\""+f_sbje+"\" orderkey=\""+f_sbje+"\" />"+
                                             "<col width=\"8%\"  text=\"ʵ�����\" column=\""+f_bxje+"\" orderkey=\""+f_bxje+"\" />"+
                                             "<col width=\"10%\"  text=\"�ڵ�����\" column=\"nodename\" orderkey=\"nodename\" />"+
                                             "<col width=\"6%\"  text=\"�鵵��־\" column=\"currentnodetype\" orderkey=\"currentnodetype\" transmethod=\"tool.tools.getIsEnd\"/>"+
                                             "<col width=\"6%\"  text=\"�����־\" column=\"ffdrbz\" orderkey=\"ffdrbz\" />"+
                                             "<col width=\"8%\"  text=\"�Ƿ�����ƾ֤\" column=\""+f_sfscpz+"\" orderkey=\""+f_sfscpz+"\" transmethod=\"tool.tools.getPZ\"/>"+
                                             "<col width=\"6%\"  text=\"ƾ֤��\" column=\""+f_pzh+"\" orderkey=\""+f_pzh+"\"  />"+
//                                              "<col width=\"4%\"  text=\"��ϸ\" column=\"xx\" orderkey=\"xx\" href=\"/workflow/request/ViewRequest.jsp\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"/>"+
//                                              "<col width=\"4%\"  text=\"excel������־\" column=\"ff_sfdc\" orderkey=\"ff_sfdc\" />"+
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
<iframe id="searchexport" style="display:none"></iframe>
</body>
<SCRIPT language="javascript">
//����EXCEL
function doExport(obj) {
	window.onbeforeunload = function (){};
	obj.disabled=true;
	jQuery('#searchexport').attr('src','WorkflowStatusReportExport.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&OANO=<%=OANO%>&resID=<%=resID%>&endFale=<%=endFale%>&inFalg=<%=inFalg%>&money=<%=money%>&rzfromdate=<%=rzfromdate%>&rztodate=<%=rztodate%>');
}
function onSearch(){
        document.frmmain.action="WorkflowStatusList.jsp";
		document.frmmain.submit();
}
function onShowSubject() {
	var id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/empolder/finance/subjectBrowser.jsp");	
	   if (id1) {
				var ids = id1.id;
				var names = id1.name;
				if (ids.length > 0) {
					jQuery("#subjectid").val(ids);
					jQuery("#subjectidimage").html(names);
				} else {
					jQuery("#subjectid").val("");
					jQuery("#subjectidimage").html("");
				}
			}
	}
</script>
<script language=vbs>
sub onShowDept(tdName,inputName)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&document.all(inputName).value)
	if NOT isempty(id) then
	        if id(0)<> 0 then
		document.all(tdName).innerHtml = id(1)
		document.all(inputName).value=id(0)
		else
		document.all(tdName).innerHtml = empty
		document.all(inputName).value=""
		end if
	end if
end sub



sub onShowCreater(tdname,inputename)
	    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	    if id(0)<> "" then
	        document.all(tdname).innerHtml = id(1)
	        document.all(inputename).value=id(0)
	    else
	        document.all(tdname).innerHtml = empty
	        document.all(inputename).value=""
	    end if
	end if
end sub



</script>
</html>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>