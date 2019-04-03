<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetV" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetC" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetM" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="RecordSetFF" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetLog" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetShare" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetEX" class="weaver.conn.RecordSet" scope="page" />

<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />

<jsp:useBean id="CustomerDescComInfo" class="weaver.crm.Maint.CustomerDescComInfo" scope="page" />
<jsp:useBean id="CustomerSizeComInfo" class="weaver.crm.Maint.CustomerSizeComInfo" scope="page" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="ContactWayComInfo" class="weaver.crm.Maint.ContactWayComInfo" scope="page" />

<jsp:useBean id="TradeInfoComInfo" class="weaver.crm.Maint.TradeInfoComInfo" scope="page" />
<jsp:useBean id="CreditInfoComInfo" class="weaver.crm.Maint.CreditInfoComInfo" scope="page" />
<jsp:useBean id="DeliveryTypeComInfo" class="weaver.crm.Maint.DeliveryTypeComInfo" scope="page" />
<jsp:useBean id="PaymentTermComInfo" class="weaver.crm.Maint.PaymentTermComInfo" scope="page" />

<jsp:useBean id="SectorInfoComInfo" class="weaver.crm.Maint.SectorInfoComInfo" scope="page" />
<jsp:useBean id="CustomerRatingComInfo" class="weaver.crm.Maint.CustomerRatingComInfo" scope="page" />
<jsp:useBean id="CustomerStatusComInfo" class="weaver.crm.Maint.CustomerStatusComInfo" scope="page" />
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page"/>

<jsp:useBean id="ProvinceComInfo" class="weaver.hrm.province.ProvinceComInfo" scope="page"/>
<jsp:useBean id="CityComInfo" class="weaver.hrm.city.CityComInfo" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="ContacterTitleComInfo" class="weaver.crm.Maint.ContacterTitleComInfo" scope="page" />

<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="CurrencyComInfo" class="weaver.fna.maintenance.CurrencyComInfo" scope="page"/>
<jsp:useBean id="RelatedRequestCount" class="weaver.workflow.request.RelatedRequestCount" scope="page"/>
<jsp:useBean id="RequestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/>

<jsp:useBean id="CoworkDAO" class="weaver.cowork.CoworkDAO" scope="page"/>

<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="DocSearchComInfo" class="weaver.docs.search.DocSearchComInfo" scope="page" />
<jsp:useBean id="SearchComInfo1" class="weaver.proj.search.SearchComInfo" scope="session" />

<jsp:useBean id="EvaluationLevelComInfo" class="weaver.crm.Maint.EvaluationLevelComInfo" scope="page" />

<jsp:useBean id="CustomerModifyLog" class="weaver.crm.data.CustomerModifyLog" scope="page"/>
<jsp:useBean id="WFUrgerManager" class="weaver.workflow.request.WFUrgerManager" scope="page" />
<jsp:useBean id="ProjectTaskApprovalDetail" class="weaver.proj.Maint.ProjectTaskApprovalDetail" scope="page"/>
	
<jsp:useBean id="CrmShareBase" class="weaver.crm.CrmShareBase" scope="page"/>
	<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page"/>
<%!
/**
 * @Date June 21,2004
 * @Author Charoes Huang
 * @Description ����Ƿ��Ǹ����û�
 */
	private boolean isPerUser(String type){
		RecordSet rs = new RecordSet();
		String sqlStr ="Select * From CRM_CustomerType WHERE ID = "+type+" and candelete='n' and canedit='n' and fullname='�����û�'";
		rs.executeSql(sqlStr);
		if(rs.next()){
			return true;
		}
		return false;
	}
%>

<%

String requestPara = request.getQueryString(); 

Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

char separator = Util.getSeparator() ;

String CustomerID = Util.null2String(request.getParameter("CustomerID"));
 //log.writeLog("ceshi11 CustomerID"+CustomerID);
String message = Util.null2String(request.getParameter("message"));

int userid = user.getUID();
String logintype = ""+user.getLogintype();
int usertype = 0;
if(logintype.equals("2"))
	usertype= 1;
//get doc count
 

String useridcheck=""+user.getUID();

boolean canview=false;
boolean canedit=false;
boolean canviewlog=false;
boolean canmailmerge=false;
boolean canapprove=false;
boolean onlyview=false;
boolean isCustomerSelf=false;
boolean isCreater=false;
boolean canApply=false; //�Ƿ�������뼶��״̬�ı仯
boolean canApplyPortal=false; //�Ƿ���������Ż�״̬�ı仯
boolean canApplyPwd=false; //�Ƿ���������Ż�����仯
boolean canApproveLevel=false; //�Ƿ������׼����仯
boolean canApprovePortal=false; //�Ƿ������׼�Ż�״̬�仯
boolean canApprovePwd=false; //�Ƿ������׼�Ż�����仯

String levelMsg = ""; //���������е���ʾ��Ϣ
String portalMsg = ""; //�Ż������е���ʾ��Ϣ
String portalPwdMsg = ""; //�Ż����������е���ʾ��Ϣ
 
int sharelevel =4;
if(sharelevel>0){
     canview=true;
     canviewlog=true;
     canmailmerge=true;
     if(sharelevel==2) canedit=true;
     if(sharelevel==3||sharelevel==4){
         canedit=true;
         canapprove=true;
     }
}
	 canview=true;
	 canedit=true;
	 canviewlog=true;
	 canmailmerge=true;
	canapprove=true;


        canApply=true; //ֻ�пͻ��ľ���ſ������������������Լ�����ͽⶳ����
        canApplyPortal = true; //ֻ�пͻ��ľ���ſ������뿪���Ż����Լ�����ͽⶳ����
        canApplyPwd = true; //ֻ�пͻ��ľ���ſ�������������������
        RecordSet.executeSql(" select * from wasu_projectbase where id="+CustomerID);
        RecordSet.next();

String customerName=RecordSet.getString("name");
   //log.writeLog("ceshi11 customerName"+customerName);       
 
%>


<HTML>
<HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>
<%@ include file="/project/DocCommExt.jsp"%>
<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename ="��Ŀ��Ƭ - "+Util.toScreen(customerName,user.getLanguage());
String newtitlename = titlename;
String temStr="";

titlename += "  "+temStr;
String needfav ="1";
String needhelp ="";

%>
<BODY>
<%@ include file="/project/TopTitleExt.jsp"%>
<%
	session.setAttribute("fav_pagename" , newtitlename ) ;	
%> 
<%

String arrOtherTab="[";
arrOtherTab+="{	title:'"+SystemEnv.getHtmlLabelName(1361,user.getLanguage())+" ',url:'ViewCustomerBase.jsp?requestid="+11+"&isrequest="+0+"&CustomerID="+CustomerID+"'}";
//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(352,user.getLanguage())+SystemEnv.getHtmlLabelName(351,user.getLanguage())+"',url:'ViewCustomerTotal.jsp?isrequest="+isrequest+"&CustomerID="+CustomerID+"'}";
String topage= URLEncoder.encode("/project/ViewCustomer.jsp?CustomerID="+CustomerID);
if(!onlyview){

if(canviewlog){%>
<%


%><%}%>
<%if(!isCustomerSelf){
arrOtherTab+=",{id:'crmContract',title:'��Ŀ��̱�����',url:'/project/Milestonelist.jsp?log=n&projid="+CustomerID+"'}";
}
//arrOtherTab+=",{id:'crmExchange',title:'"+SystemEnv.getHtmlLabelName(15153,user.getLanguage())+"',url:'/discuss/ViewExchange.jsp?types=CC&sortid="+CustomerID+"'}";
%>

<%
//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(110,user.getLanguage())+"',url:'/CRM/data/ViewAddress.jsp?CustomerID="+CustomerID+"&canedit="+canedit+"'}";
%>


<!-- BUTTON class=btn  accessKey=S onclick='location.href="/sms/SmsMessageEdit.jsp?crmid=<%=RecordSetC.getString(1)%>"'><U>S</U>-���Ͷ���</BUTTON -->
<%if(!isCustomerSelf){%> 
<%

arrOtherTab+=",{title:'��Ŀ��ע�����',url:'/project/ProjAttentionlist.jsp?projid="+CustomerID+"'}";
arrOtherTab+=",{title:'��Ŀ�����ĵ�����',url:'/project/Projtasklist.jsp?projid="+CustomerID+"'}";
arrOtherTab+=",{title:'��ػ����Ҫ',url:'/project/Projmeetinglist.jsp?projid="+CustomerID+"'}";  
arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(618,user.getLanguage())+"',url:'/project/ViewLog.jsp?log=n&projid="+CustomerID+"'}";

%>
<%}%>
<%if(!user.getLogintype().equals("2")){%>
<%

//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(614,user.getLanguage())+"',url:'/CRM/data/ContractList.jsp?CustomerID="+CustomerID+"'}";
%>
<%}%>
<%if (canedit) {%>
<%
//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(6070,user.getLanguage())+"',url:'/CRM/data/GetEvaluation.jsp?CustomerID="+CustomerID+"'}";
//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(6061,user.getLanguage())+"',url:'/CRM/data/AddContacterLogRemind.jsp?CustomerID="+CustomerID+"'}";
%>
<%}%>
<%if (isCreater) {%>
<%
//arrOtherTab+=",{title:'"+SystemEnv.getHtmlLabelName(136,user.getLanguage())+SystemEnv.getHtmlLabelName(216,user.getLanguage())+"',url:'/CRM/data/UniteCustomer.jsp?CustomerID="+CustomerID+"'}";
%>
<%}%>
<%
}

arrOtherTab+="]";
%>

</BODY>
</HTML>
<script language=javascript>
var arrOtherTab=eval(<%=arrOtherTab%>);

function setTabPanelActive(panelId){
	
	Ext.getCmp('crmtabpanel').activate(panelId);
	
}
</script>
<script type="text/javascript" src="/js/crm/ViewCustomer.js"></script>



