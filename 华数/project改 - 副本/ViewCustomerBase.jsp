<%@page import="weaver.hrm.company.SubCompanyComInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,weaver.conn.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Timestamp" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSetShare" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<jsp:useBean id="CheckUserRight" class="weaver.systeminfo.systemright.CheckUserRight" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="RolesComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page"/>
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="DocComInfo" class="weaver.docs.docs.DocComInfo" scope="page" />
<jsp:useBean id="RequestComInfo" class="weaver.workflow.request.RequestComInfo" scope="page"/>
<%!
 	private boolean isPerUser(String type){
		return false;
	}
%>

<%
Date newdate = new Date() ;
long datetime = newdate.getTime() ;
Timestamp timestamp = new Timestamp(datetime) ;
String CurrentDate = (timestamp.toString()).substring(0,4) + "-" + (timestamp.toString()).substring(5,7) + "-" +(timestamp.toString()).substring(8,10);
String CurrentTime = (timestamp.toString()).substring(11,13) + ":" + (timestamp.toString()).substring(14,16) + ":" +(timestamp.toString()).substring(17,19);

String CustomerID = Util.null2String(request.getParameter("CustomerID"));
int curstatus = Util.getIntValue(request.getParameter("curstatus"),-1);
String statussql="";
if(curstatus>0){
	if(curstatus==1){ 
		statussql=" update wasu_projectbase set zjbdate='"+CurrentDate+"',spstatus=1 where id="+CustomerID;
	}else if(curstatus==2){ 
		statussql=" update wasu_projectbase set cwbdate='"+CurrentDate+"',spstatus=2 where id="+CustomerID;
	}else if(curstatus==3){ 
		statussql=" update wasu_projectbase set fzcdate='"+CurrentDate+"',spstatus=3 where id="+CustomerID;
	}else if(curstatus==4){ 
		statussql=" update wasu_projectbase set zcdate='"+CurrentDate+"',spstatus=4,xmstatus=7 where id="+CustomerID; 
	} 
	rs.executeSql(statussql);
}


%>

<%

char separator = Util.getSeparator() ;

String needalert = Util.null2String(request.getParameter("needalert"));
int custoridss = 1;
//TD5394
String mailAddress = "";
String mailAddressContacter = "";

String message = Util.null2String(request.getParameter("message"));

int userid = user.getUID();

boolean isEdit = false;
boolean isShow = false;
String sql_tmp = "select count(id) as cu_cc from HrmRoleMembers  where roleid in "
	+"(select roleid from SystemRightRoles where rightid=20140331) and resourceid="+userid;
if(userid == 1){
	isEdit = true;
}else{
	RecordSet.executeSql(sql_tmp);
	if(RecordSet.next()){
		int tmp_flag = RecordSet.getInt("cu_cc");
		if(tmp_flag > 0) isEdit = true;
	}
}

if(!isEdit){
	sql_tmp = "select count(id) as cu_cc from hrmrolemembers where roleid=9 and resourceid="+userid;
	RecordSet.executeSql(sql_tmp);
	if(RecordSet.next()){
		int tmp_flag = RecordSet.getInt("cu_cc");
		if(tmp_flag > 0) isShow = true;
	}
}

 if(!isEdit && !isShow) {
        response.sendRedirect("/notice/noright.jsp") ;
        return ;
 }


String logintype = ""+user.getLogintype();
int usertype = 0;
if(logintype.equals("2"))
	usertype= 1;
//get doc count

     RecordSet.executeSql(" select * from wasu_projectbase where id="+CustomerID);
        RecordSet.next();

String customerName=RecordSet.getString("name");
String type = RecordSet.getString("Type");
String xmcode= RecordSet.getString("xmcode");
String xmtzysje= RecordSet.getString("xmtzysje");
String xmrjje= RecordSet.getString("xmrjje");
String xmfyzyyjje= RecordSet.getString("xmfyzyyjje");
String xmyzyje= RecordSet.getString("xmyzyje"); 
String xmysyfy=RecordSet.getString("xmysyfy"); 
String firsttype= RecordSet.getString("firsttype"); 
String xmqtjf= RecordSet.getString("xmqtjf"); 
int xmstatus=RecordSet.getInt("xmstatus");
int spstatus=RecordSet.getInt("spstatus");
boolean isCustomerSelf=false;

String lcbalert="";
rs.executeSql(" select * from wasu_projstone where projid="+CustomerID);
while(rs.next()){
	if((rs.getString("stonedate")==null)||(rs.getString("stonedate").equals(""))){
		lcbalert="1";
	}
}

//获取项目相关的所有文档
String downloaddocs="";
String donwloadfileids="";
rs.executeSql("select * from wasu_projfiles where projid="+CustomerID);
while(rs.next()){
	downloaddocs+=rs.getString("fileid")+",";
}
String sjkzd="";
String wdflfjformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "wdflfj")); 
rs.executeSql(" select * from formtable_main_"+wdflfjformid+"_dt1 order by id asc ");  
String fieldnames="";
int filedcount=0;
while(rs.next()){
	sjkzd+=rs.getString("sjkzd")+",";
}
String sjkzds[]=sjkzd.split(",");

rs.executeSql("select "+sjkzd+"qtfj from wasu_projtask where projid="+CustomerID); 
while(rs.next()){
	int i=0;//20140509
	for(int d=0;d<sjkzds.length;d++){
	  String fj=sjkzds[d];
	  String docsfj=rs.getString(sjkzds[i++]);
	  if(docsfj!=null&&!docsfj.equals("")){ 
	  			downloaddocs+=docsfj+",";
	  } 
	}
} 


String lxlzwhformid=Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh")); 
Map xmlbMap = new HashMap();
rs.executeSql("select distinct lbzm,lbmc from formtable_main_"+lxlzwhformid+"_dt2 ");
while(rs.next()){
	xmlbMap.put(rs.getString("lbzm"),rs.getString("lbmc"));
}
//new weaver.general.BaseBean().writeLog("downloaddocs------------------->"+downloaddocs);
//String docids[]=downloaddocs.split(",");

%>
<%@page import="java.net.URLEncoder"%>
<HTML>
<HEAD>
<base target="" />
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</HEAD>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(136,user.getLanguage())+SystemEnv.getHtmlLabelName(647,user.getLanguage())+" - "+Util.toScreen(customerName,user.getLanguage());

String temStr="";

titlename += "  "+temStr;
String needfav ="1";
String needhelp ="";

boolean canedit=true;
%>
<BODY>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>


<%
String levelMenu = "";
String portalMenu = "";
String portalpwdMenu = ""; 
String topage= URLEncoder.encode("/CRM/data/ViewCustomer.jsp?CustomerID="+CustomerID);

if(isEdit){
	RCMenu += "{"+SystemEnv.getHtmlLabelName(93,user.getLanguage())+",javascript:doEdit(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;

	//RCMenu += "{新建任务,/docs/docs/DocList.jsp?crmid="+CustomerID+"&isExpDiscussion=y,_self} " ;
	//RCMenuHeight += RCMenuHeightStep ; 
	if(xmstatus<=0){ 
	RCMenu += "{项目确认申请,javascript:onConfirmApply(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{项目暂不立项,javascript:onNoApply(this),_self} " ; 
	RCMenuHeight += RCMenuHeightStep ;
	}
	if(xmstatus==8||xmstatus==7){  
	RCMenu += "{项目确认初验,javascript:onConfirmFOver(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	} 
	if(xmstatus==7){   
	RCMenu += "{项目确认上线,javascript:onConfirmOnLine(this),_self} " ; 
	RCMenuHeight += RCMenuHeightStep ;
	} 
	if(xmstatus==2){ 
	RCMenu += "{项目确认终验,javascript:onConfirmOver(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	}
	if(xmstatus==3){ 
	RCMenu += "{项目确认完成,javascript:onConfirmFinished(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

//RCMenu += "{项目异常终止,javascript:onConfirmNoFinished(this),_self} " ;
//RCMenuHeight += RCMenuHeightStep ; 
	} 
	if(xmstatus!=5){  
	RCMenu += "{项目异常终止,javascript:onConfirmNoFinished(this),_self} " ;
	RCMenuHeight += RCMenuHeightStep ; 
	}

	RCMenu += "{项目文档打包下载,javascript:downloadAllDocs("+CustomerID+"),_top} " ;  
	RCMenuHeight += RCMenuHeightStep ;

	RCMenu += "{"+SystemEnv.getHtmlLabelName(2029,user.getLanguage())+",javascript:doAddEmail(),_top} " ;
	RCMenuHeight += RCMenuHeightStep ;
}

%>
  
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<div id="divBase">
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
<TABLE width="100%">
<tr>
<td valign="top">

<TABLE class=ViewForm>
  <COLGROUP>
  <COL width="49%">
  <COL width=10>
  <COL width="49%">
  <TBODY>
  <TR>

	<TD vAlign=top>

	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="30%">
  		<COL width="70%">
        <TBODY>
        <TR class=Title>
            <TH colSpan=2>
            </TH>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=2></TD></TR>
        <TR>
          <TD>项目名称</TD>
          <TD class=Field><%=Util.toScreen(RecordSet.getString("name"),user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <!--add CRM CODE by lupeng 2004.03.30-->
        <TR>
          <TD>项目编码</TD>
          <TD class=Field><%=Util.toScreenToEdit(xmcode, user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>项目经理</TD>
          <TD class=Field><%=RecordSet.getString("xmjlname") %></TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>所属公司</TD>
          <TD class=Field><%=Util.toScreen(SubCompanyComInfo.getSubCompanyname(RecordSet.getString("xmgs")),user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
          <TD>所属部门</TD> 
          <TD class=Field><%=Util.toScreen(DepartmentComInfo.getDepartmentname(RecordSet.getString("xmbm")),user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>申请日期</TD>
          <TD class=Field><%=RecordSet.getString("sqrq")%> </TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>项目种类</TD> 
          <TD class=Field><% 
            				String xmzl=RecordSet.getString("xmzl");
        					String returnstr="";
					        if(xmzl.equals("0")){
								returnstr="客户化项目"; 
							}else if(xmzl.equals("1")){
								returnstr="一般投资项目"; 
							}else{
								returnstr="重大投资项目";  
							}
							out.println(returnstr); %>
							</TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
        <TD>项目一级分类</TD> 
        <TD class=Field><%=RecordSet.getString("firsttype")%></TD> 
      </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>项目类别</TD> 
          <TD class=Field><%=xmlbMap.get(RecordSet.getString("xmlb"))%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>联系电话</TD>
          <TD class=Field><%=Util.toScreen(RecordSet.getString("lxdh"),user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>项目经理邮箱</TD>
          <TD class=Field><%=Util.toScreen(RecordSet.getString("xmjlemail"),user.getLanguage())%></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>是否年度预算内项目</TD> 
          <TD class=Field><%=RecordSet.getString("sfndys").equals("0")?"是":"否"%></TD>
        </TR><tr><td class=Line colspan=2></td></tr> 
        <TR>
          <TD>立项论证形式</TD>
          <TD class=Field  >
          <%  int lxlzxs=RecordSet.getInt("lxlzxs");
       		  //String lxlzwhformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh"));
              rs.executeSql(" select * from formtable_main_"+lxlzwhformid+"_dt1  where px="+lxlzxs); 
              rs.next();
              out.println(rs.getString("lzmc")); 
          %>
          </TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>项目预算情况</TD>
          <TD class=Field  >
           投资预算金额: <%=xmtzysje %> 万 （其中软件金额：<%=xmrjje %>万 硬件金额:<%=xmfyzyyjje %>万 项目其他经费:<%=xmqtjf %>万 ）云资源金额：<%=xmyzyje %>万
          </TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
     <!--   <TD>项目其他经费</TD>
        <TD class=Field  >
           <%=xmqtjf %>  
        </TD> -->
      </TR><tr><td class=Line colspan=2></td></tr>
      <TR>
      <TD>项目已使用费用</TD>
      <TD class=Field  >
         <%=xmysyfy %>  
      </TD> 
    </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD>当前项目状态</TD>
          <TD class=Field  >
          <% 
        	String xmcstatus="";
          	if(xmstatus<=0){
          		xmcstatus="<font color=red>未立项</font>"; 
          	}else if(xmstatus==1){
          		xmcstatus="<font color=red>立项</font>";
          	}else if(xmstatus==2){
          		xmcstatus="<font color=red>项目初验</font>"; 
          	}else if(xmstatus==3){ 
          		xmcstatus="<font color=red>项目终验</font>"; 
          	}else if(xmstatus==4){
          		xmcstatus="<font color=red>完成</font>";
          	}else if(xmstatus==5){
          		xmcstatus="<font color=red>终止</font>";
          	}else if(xmstatus==9){  
          		xmcstatus="<font color=red>暂不立项</font>"; 
          	}else if(xmstatus==7){ 
          		xmcstatus="<font color=red>在建</font>"; 
          	}else if(xmstatus==8){ 
          		xmcstatus="<font color=red>上线</font>";  
          	}
       	 	%>
        	<%=xmcstatus %>
        	<% if(xmstatus==1){ %>  
        	 
        	<%} %>
          </TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD colspan=2> 
        	<% if(xmstatus==1){ %>  
        	<div>
        	<span id=zjbspan>
        	<% if(spstatus<=0){ %>
        	<BUTTON class=btnNew type=button onclick="ProjSpStatus('zjbspan','1')"  <%if(spstatus>=1){ %>disabled<%} %>>总经办审批</BUTTON>
        	<% }else{ out.print(RecordSet.getString("zjbdate"));} %>
        	</span>
        	<span id=cwbspan>
        	<% if(spstatus==1||RecordSet.getString("cwbdate").equals("")){ %>
        	<BUTTON class=btnNew type=button onclick="ProjSpStatus('cwbspan','2')"  <%if(spstatus>=2||spstatus<=0){ %>disabled<%} %>>财务部审批</BUTTON>
        	<% }else{ out.print(RecordSet.getString("cwbdate"));} %>
        	</span>
        	<span id=fzcspan>
        	<% if(spstatus==2||RecordSet.getString("fzcdate").equals("")){ %>
        	<BUTTON class=btnNew type=button onclick="ProjSpStatus('fzcspan','3')"  <%if(spstatus!=2){ %>disabled<%} %>>副总裁审批</BUTTON>
        	<% }else{ out.print(RecordSet.getString("fzcdate"));} %>
        	</span>
        	<% if(spstatus==3||RecordSet.getString("zcdate").equals("")){ %> 
        	<span id=zcspan><BUTTON class=btnNew type=button onclick="ProjSpStatus('zcspan','4')"  <%if(spstatus!=3){ %>disabled<%} %>>总裁审批</BUTTON>
        	<% }else{ out.print(RecordSet.getString("zcdate"));} %>
        	</span>
        	
        	</div>
        	<%} %>
          </TD> 
        </TR><tr><td class=Line colspan=2></td></tr>
        
        </TBODY>
	  </TABLE>
	  
	</TD>

    <TD></TD>

	<TD vAlign=top style="word-break: break-all;">

     <%int index=1; %>
<!--共享信息begin-->
 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="30%">
  		<COL width="60%">
  		<COL width="10%">
        <TBODY>
        <TR class=Title>
            <TH><%=SystemEnv.getHtmlLabelName(2112,user.getLanguage())%></TH>
			<TD align=right colspan=2>
			<%if(false){%>
			<a href="/CRM/data/AddShare.jsp?isfromtab=true&itemtype=2&CustomerID=<%=CustomerID%>&customername=<%=RecordSet.getString("name")%>&isfromCrmTab=true" target="_self"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></a>
			<%}%>
			</TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR>
 
 <%  rs.executeSql("select resourceid from HrmRoleMembers  where roleid in (select roleid from SystemRightRoles where rightid=20140331)"); 
     while(rs.next()){
    	 %>  	 
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></TD>
		  <TD class=Field>
			<a href="/hrm/resource/HrmResource.jsp?id=<%=rs.getString("resourceid") %>" target="_blank"><%=Util.toScreen(ResourceComInfo.getResourcename(rs.getString("resourceid")),user.getLanguage())%></a>/<%=SystemEnv.getHtmlLabelName(367,user.getLanguage())%>
			 <%=SystemEnv.getHtmlLabelName(93,user.getLanguage())%> 
		  </TD>
		  <TD class=Field  id="tdDel_<%=rs.getString("resourceid")%>"> 
		  </TD>
        </TR><tr><td class=Line colspan=3></td></tr>
<%   }
 %> 
        </TBODY>
	  </TABLE>
<!--共享信息end-->
 
 
        </TR>
          <tr>
<td   height=10 colspan="3"></td>
</tr>
        <tr>
<td   class=Line1  colspan="3"></td>
</tr>
     <tr>
     <td>
     	  <!--立项申请begin--> 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>立项申请表 </TH>
			<TD align=right > <%if(isEdit){%> <a href="#" onclick="addNewDoc(1)">添加</a> <%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <%int index1=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=1 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD id=toDel1_<%=index1 %>><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		   <%if(isEdit){%> <a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'toDel1_<%=index1++ %>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a> <%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--立项申请end--> 
     </td> 
     <td></td>
     
     <td>
       <!-- 讲解PPT begin--> 
	 <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>讲解PPT</TH>
			<TD align=right >  <%if(isEdit){%><a href="#" onclick="addNewDoc(2)">添加</a><%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <% 
          int index2=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=2 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD  id=toDel2_<%=index2 %>><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		  <%if(isEdit){%>  <a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'toDel2_<%=index2++ %>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a> <%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--讲解PPTend-->
     
     </td>  
     </tr> 
        
        
          <tr>
     <td>
     	  <!--立项报告begin--> 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>立项报告</TH>
			<TD align=right >  <%if(isEdit){%><a href="#" onclick="addNewDoc(3)">添加</a><%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <% 
          int index3=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=3 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD  id=toDel3_<%=index3 %>><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		   <%if(isEdit){%> <a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'toDel3_<%=index3++ %>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a> <%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--立项报告end-->
 
     </td>
     
     <td></td>
     
     
     <td>
       <!--预算卡begin--> 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>预算卡</TH>
			<TD align=right > <%if(isEdit){%> <a href="#" onclick="addNewDoc(4)">添加</a><%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <%
          int index4=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=4 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD id=toDel4_<%=index4 %>><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		  <%if(isEdit){%>  <a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'toDel4_<%=index4++ %>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a> <%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--预算卡end-->
     
     </td>  
     </tr> 
     
     
     
       <tr>
     <td>
     	  <!--重大项目申请begin--> 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>重大项目申请</TH>
			<TD align=right > <%if(isEdit){%> <a href="#" onclick="addNewDoc(5)">添加</a><%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <% 
          int index5=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=5 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD id=toDel5_<%=index5 %>><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		   <%if(isEdit){%> <a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'toDel5_<%=index5++ %>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a> <%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--重大项目申请end-->
 
     </td>
     
     <td></td>
     
     
     <td>
       <!--其他相关文件begin--> 
	  <TABLE class=ViewForm>
        <COLGROUP>
		<COL width="10%">
  		<COL width="60%">
  		<COL width="30%">
        <TBODY>
        <TR class=Title>
            <TH colspan=2>其他相关文件</TH>
			<TD align=right > <%if(isEdit){%> <a href="#" onclick="addNewDoc(6)">添加</a><%}%>
			 </TD>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=3></TD></TR> 
          <% int index6=0;
          rs.executeSql(" select t1.*,t2.imagefileid from wasu_projfiles t1,Docimagefile t2 where t1.fileid=t2.docid and typeid=6 and projid="+CustomerID);
             while(rs.next()){
          %>
        <TR>
          <TD><%=ResourceComInfo.getResourcename(rs.getString("creater")) %></TD> 
		  <TD><%=DocComInfo.getDocname(rs.getString("fileid")) %></TD>
		  <TD id="tdDel6_<%=index6%>"><a href="/weaver/weaver.file.FileDownload?fileid=<%=rs.getString("imagefileid")%>&download=1">下载</a>
		  &nbsp;&nbsp;&nbsp;
		   <%if(isEdit){%><a href="#" onClick="onDel('/project/DocUploadOperation.jsp?method=delete&fileid=<%=rs.getString("fileid")%>&projid=<%=CustomerID%>',this,'tdDel6_<%=index6++%>')" target="_self"><%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></a><%}%>
		  </TD> 
        </TR><tr><td class=Line colspan=3></td></tr> 
        <%} %>
        
        <tr><td height=10 colspan=3></td></tr> 
        </TBODY>
	  </TABLE>
<!--其他相关文件end-->
     
     </td>  
     </tr> 
     
     
        
        
	 </TABLE>
		</td>
		</tr>
		</TABLE>
</td>
</tr>




</TABLE>
</td>

</tr>



<tr>
<td height="10" colspan="3"></td>
</tr>
</table>
</FORM>
</div>


<script type="text/javascript" src="/js/extjs/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/extjs/ext-all.js"></script>  

<script language=javascript>

if("<%=lcbalert%>"=="1"&&"<%=needalert%>"=="1"){  
	alert("您项目里程碑上还有日期未维护，请及时维护！");
} 

function addNewDoc(typeid){  
	window.showModalDialog("/project/addNewdoc.jsp?typeid="+typeid+"&projid=<%=CustomerID%>",this,"height:320px,width:200px");
	window.location = "/project/ViewCustomerBase.jsp?CustomerID=<%=CustomerID%>"; 
}

function downloadAllDocs(projid){ 
	window.location="/weaver/weaver.file.FileDownload?fieldvalue=<%=downloaddocs%>&download=1&downloadBatch=1&requestid="; 
}

function ProjSpStatus(objspan,curstatus){
	 if(confirm("确认审批？")){
		 window.location="/project/ViewCustomerBase.jsp?CustomerID=<%=CustomerID%>&curstatus="+curstatus;
	 }
}

function onConfirmApply(obj){
	if(confirm("确认完成项目申请？")){
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=apply&projid=<%=CustomerID %>"; 
	}
}
function onNoApply(obj){
	if(confirm("确认项目暂不立项？")){ 
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=noapply&projid=<%=CustomerID %>"; 
	}
}
function onConfirmFOver(obj){
	if(confirm("确认完成项目初验？")){  
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=FOver&projid=<%=CustomerID %>"; 
	}
}
function onConfirmOnLine(obj){
	if(confirm("项目确认上线？")){     
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=Online&projid=<%=CustomerID %>"; 
	}
}
function onConfirmOver(obj){
	if(confirm("确认完成项目终验？")){
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=Over&projid=<%=CustomerID %>"; 
	}
}
function onConfirmFinished(obj){
	if(confirm("确认已经完成项目？")){
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=finished&projid=<%=CustomerID %>"; 
	}
}
function onConfirmNoFinished(obj){
	if(confirm("确认项目异常终止？")){
		obj.disabled= true;
	    location="/project/CustomerOperation.jsp?method=nofinished&projid=<%=CustomerID %>"; 
	}
}

 
function doAddEmail(){
	window.open("/email/MailAddByProj.jsp?to=<%=mailAddress%>")
}
function URLencode(sStr) 
{
    return escape(sStr).replace(/\+/g, '%2B').replace(/\"/g,'%22').replace(/\'/g, '%27').replace(/\//g,'%2F');
}
 
function onDel(url,obj,indexid){	
	 
	if(isdel()){		
		obj.parentNode.innerHTML="<img src='/images/loadingext.gif' align=absMiddle>";
		Ext.Ajax.request({
						url : url, 					
						method: 'POST',
						success: function ( result, request) {
							var trObj=document.getElementById(indexid).parentNode;
							var trObjNext=trObj.nextSibling; 
							trObj.parentNode.removeChild(trObjNext);
							trObj.parentNode.removeChild(trObj);
							//alert(trObj.tagName);	
							//this.obj.parentNode.parentNode.parentNode.removeChild(this.obj.parentNode.parentNode);
						},
						failure: function ( result, request) { 
							alert(result.responseText);
							//Ext.MessageBox.alert('Failed', 'Failed posted form: '+result); 
						} 
		});		
	}
}

function doEdit(){
	parent.location='/project/EditProject.jsp?isfromtab=true&projid=<%=CustomerID%>'; 
}

</script>
<script language=vbs>
sub onShowDoc(inputname,spanname)
	temp = document.all(inputname).value
	id1 = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?documentids="+temp)
	if (Not IsEmpty(id1)) then
			if id1(0)<> "" then
				tempdocids = id1(0)
				tempdocnames = id1(1)
				sHtml = ""
				tempdocids = Mid(tempdocids,1,len(tempdocids))
				document.all(inputname).value = tempdocids
				tempdocnames = Mid(tempdocnames,1,len(tempdocnames))
				while InStr(tempdocids,",") <> 0
					curid = Mid(tempdocids,1,InStr(tempdocids,",")-1)
					curname = Mid(tempdocnames,1,InStr(tempdocnames,",")-1)
					tempdocids = Mid(tempdocids,InStr(tempdocids,",")+1,Len(tempdocids))
					tempdocnames = Mid(tempdocnames,InStr(tempdocnames,",")+1,Len(tempdocnames))
					sHtml = sHtml&"<a href='/docs/docs/DocDsp.jsp?id="&curid&"'>"&curname&"</a>&nbsp"
				wend
				sHtml = sHtml&"<a href='/docs/docs/DocDsp.jsp?id="&tempdocids&"'>"&tempdocnames&"</a>&nbsp"
				document.all(spanname).innerHtml = sHtml
			else
				document.all(spanname).innerHtml =""
				document.all(inputname).value=""
			end if
	end if
end sub

sub onShowResource(inputname,spanname)
	temp = document.all(inputname).value
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="+temp)
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
		resourceids = id(0)
		resourcename = id(1)
		sHtml = ""
		resourceids = Mid(resourceids,2,len(resourceids))
		resourcename = Mid(resourcename,2,len(resourcename))
		inputname.value= resourceids
		while InStr(resourceids,",") <> 0
			curid = Mid(resourceids,1,InStr(resourceids,",")-1)
			curname = Mid(resourcename,1,InStr(resourcename,",")-1)
			resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
			resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
			sHtml = sHtml&curname&"&nbsp"
		wend
		sHtml = sHtml&resourcename&"&nbsp"
		spanname.innerHtml = sHtml		
    		document.frmmain.method.value="changeworker"
		document.frmmain.submit()
		
	else	
    	spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
    	inputname.value="0"
	end if
	end if
end sub

sub onShowProject(inputname,spanname)
	temp = document.all(inputname).value
	id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/proj/data/MultiTaskBrowser.jsp?resourceids="+temp)
	if (Not IsEmpty(id1)) then
			if id1(0)<> "" then
				tempprojectids = id1(0)
				projectName = id1(1)
				sHtml = ""
				tempprojectids = Mid(tempprojectids,2,len(tempprojectids))
				
				document.all(inputname).value = tempprojectids
				projectName = Mid(projectName,2,len(projectName))
				projectName = Mid(projectName,1,len(projectName))
				while InStr(tempprojectids,",") <> 0
					curid = Mid(tempprojectids,1,InStr(tempprojectids,",")-1)
					curname = Mid(projectName,1,InStr(projectName,",")-1)
					tempprojectids = Mid(tempprojectids,InStr(tempprojectids,",")+1,Len(tempprojectids))
					projectName = Mid(projectName,InStr(projectName,",")+1,Len(projectName))
					sHtml = sHtml&"<a href='/proj/process/ViewTask.jsp?taskrecordid="&curid&"'>"&curname&"</a>&nbsp"
				wend
				sHtml = sHtml&"<a href='/proj/process/ViewTask.jsp?taskrecordid="&tempprojectids&"'>"&projectName&"</a>&nbsp"
				document.all(spanname).innerHtml = sHtml
			else
				document.all(spanname).innerHtml =""
				document.all(inputname).value=""
			end if
	end if
end sub

sub onShowCRM(inputname,spanname)
	temp = document.all(inputname).value
	id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids="+temp)
	if (Not IsEmpty(id1)) then
		if id1(0)<> "" then
			resourceids = id1(0)
			resourcename = id1(1)
			sHtml = ""
			resourceids = Mid(resourceids,2,len(resourceids))
			document.all(inputname).value= resourceids
			resourcename = Mid(resourcename,2,len(resourcename))
		while InStr(resourceids,",") <> 0
			curid = Mid(resourceids,1,InStr(resourceids,",")-1)
			curname = Mid(resourcename,1,InStr(resourcename,",")-1)
			resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
			resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
			sHtml = sHtml&"<a href='/CRM/data/ViewCustomer.jsp?CustomerID="&curid&"'>"&curname&"</a>&nbsp"
		wend
		sHtml = sHtml&"<a href='/CRM/data/ViewCustomer.jsp?CustomerID="&resourceids&"'>"&resourcename&"</a>&nbsp"
		document.all(spanname).innerHtml = sHtml
					
		else
			document.all(spanname).innerHtml =""
			document.all(inputname).value=""
		end if
	end if
end sub

sub onShowRequest(inputname,spanname)
	temp = document.all(inputname).value
	id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/workflow/request/MultiRequestBrowser.jsp?resourceids="+temp)
	if (Not IsEmpty(id1)) then
		if id1(0)<> "" then
			resourceids = id1(0)
			resourcename = id1(1)
			sHtml = ""
			resourceids = Mid(resourceids,2,len(resourceids))
			document.all(inputname).value= resourceids
			resourcename = Mid(resourcename,2,len(resourcename))
		while InStr(resourceids,",") <> 0
			curid = Mid(resourceids,1,InStr(resourceids,",")-1)
			curname = Mid(resourcename,1,InStr(resourcename,",")-1)
			resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
			resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
			sHtml = sHtml&"<a href='/workflow/request/ViewRequest.jsp?requestid="&curid&"'>"&curname&"</a>&nbsp"
		wend
		sHtml = sHtml&"<a href='/workflow/request/ViewRequest.jsp?requestid="&resourceids&"'>"&resourcename&"</a>&nbsp"
		document.all(spanname).innerHtml = sHtml
					
		else
			document.all(spanname).innerHtml =""
			document.all(inputname).value=""
		end if
	end if
end sub
</script>
</BODY>
</HTML>



