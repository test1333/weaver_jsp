<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
	
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
	
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelFile" class="weaver.file.ExcelFile" scope="session"/>
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubcompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="ProjectTransMethod" class="weaver.general.ProjectTransMethod" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver_wev8.js"></script>

</head>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdDOC.gif";
String titlename = "搜索：项目相关信息查询";  
String needfav ="1";
String needhelp ="";

String userID = String.valueOf(user.getUID());

boolean isEdit = false;
boolean isShow = false;
String sql_tmp = "select count(id) as cu_cc from HrmRoleMembers  where roleid in "
	+"(select roleid from SystemRightRoles where rightid=20140331) and resourceid="+userID;
if("1".equals(userID)){
	isEdit = true;
}else{
	RecordSet.executeSql(sql_tmp);
	if(RecordSet.next()){
		int tmp_flag = RecordSet.getInt("cu_cc");
		if(tmp_flag > 0) isEdit = true;
	}
}

if(!isEdit){
	sql_tmp = "select count(id) as cu_cc from hrmrolemembers where roleid=9 and resourceid="+userID;
	RecordSet.executeSql(sql_tmp);
	if(RecordSet.next()){
		int tmp_flag = RecordSet.getInt("cu_cc");
		if(tmp_flag > 0) isShow = true;
	}
}

 //if(!isEdit && !isShow) {
 //       response.sendRedirect("/notice/noright.jsp") ;
 //       return ;
 //}


String workflowids=""; 

String multiSubIds=Util.null2String(request.getParameter("multiSubIds"));
if(!multiSubIds.equals("")){
   if(multiSubIds.startsWith(",")){
	   multiSubIds=multiSubIds.substring(1);
   }
   if(multiSubIds.endsWith(",")){
	   multiSubIds=multiSubIds.substring(0,multiSubIds.length()-1);
   } 
   boolean ok = rs.executeSql("delete from wasu_projectbase where id in ("+multiSubIds+")");
   if(ok){
	   out.print("<script>alert('删除成功');</script>");
   }
}

%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %> 

<FORM id=weaver name=frmmain method=post action="projectlist.jsp">
<input type=hidden name=multiSubIds value=""/>
<% 


String xmname=Util.null2String(request.getParameter("xmname"));
String xmcode=Util.null2String(request.getParameter("xmcode"));
String xmjl=Util.null2String(request.getParameter("xmjl")); 
String firsttype=Util.null2String(request.getParameter("firsttype")); 
String xmjlname=Util.null2String(request.getParameter("xmjlname")); 
int xmstatus=Util.getIntValue(request.getParameter("xmstatus"),-1);
String xmgs=Util.null2String(request.getParameter("xmgs"));
String xmbm=Util.null2String(request.getParameter("xmbm"));
String sqrq1=Util.null2String(request.getParameter("sqrq1"));
String sqrq2=Util.null2String(request.getParameter("sqrq2")); 
int sfndys=Util.getIntValue(request.getParameter("sfndys"),-1);
int lxlzxs=Util.getIntValue(request.getParameter("lxlzxs"),-1);
int xmzl=Util.getIntValue(request.getParameter("xmzl"),-1);  

int iswaitdo= Util.getIntValue(request.getParameter("iswaitdo"),0) ;
int isovertime= Util.getIntValue(request.getParameter("isovertime"),0) ;
 
String newsql=" ";
Calendar thedate = Calendar.getInstance();


if(!sqrq1.equals("")){ 
	newsql += "  and sqrq>='"+sqrq1+"' ";   
}
if(!sqrq2.equals("")){ 
	newsql += "  and sqrq<='"+sqrq2+"' ";   
}
if(!xmname.equals("")){ 
	newsql += "  and name like '%"+xmname+"%' ";    
} 
if(!firsttype.equals("")){ 
	newsql += "  and firsttype like '%"+firsttype+"%' ";    
} 
if(!xmcode.equals("")){ 
	newsql += "  and xmcode like '%"+xmcode+"%' ";    
}  
if(xmstatus>-1){ 
	newsql += "  and xmstatus="+xmstatus+" ";    
} 
if(!xmgs.equals("")&&!xmgs.equals("-1")){ 
	newsql += "  and xmgs="+xmgs+" ";    
} 
if(!xmbm.equals("")&&!xmbm.equals("-1")){ 
	newsql += "  and xmbm="+xmbm+" ";    
} 
if(sfndys>-1){  
	newsql += "  and sfndys="+sfndys+" ";    
} 
if(lxlzxs>-1){ 
	newsql += "  and lxlzxs="+lxlzxs+" ";    
} 
if(xmzl>-1){ 
	newsql += "  and xmzl="+xmzl+" ";     
} 

if(!xmjl.equals("") ){
	if(xmjl.startsWith(",")){
		xmjl = xmjl.substring(1,xmjl.length());
	}  
	newsql += " and t1.xmjl  in("+xmjl+")";
}
if(!xmjlname.equals("") ){ 
	newsql += " and t1.xmjlname like '%"+xmjlname+"%' ";
}


String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;


  
String sqlwhere="";
  
String orderby = "";  
sqlwhere +=" "+newsql ;
orderby=" t1.id ";   
 
int start=Util.getIntValue(Util.null2String(request.getParameter("start")),1);
String sql="";
int totalcounts = Util.getIntValue(Util.null2String(request.getParameter("totalcounts")),0);

//add by xhheng @ 20050302 for TD 1545
String strworkflowid="";
int startIndex = 0;
  
int perpage=25;

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ;  
RCMenu += "{导出Excel,/weaver/weaver.file.ExcelOut,_self}" ;
RCMenuHeight += RCMenuHeightStep ; 
if(isEdit){
	RCMenu += "{删除,javascript:OnMultiSubmit(),_self}" ;
	RCMenuHeight += RCMenuHeightStep ; 
}

%>

<div id='divshowreceivied' style='background:#FFFFFF;padding:3px;width:100%' valign='top'>
</div>  
 <input name=creatertype type=hidden value="0">  
<input type=hidden name=isovertime value="<%=isovertime%>">
<table width=100% height=94% border="0" cellspacing="0" cellpadding="0">
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
	<wea:layout type="table" attributes="{'cols':'8','cws':'10%,15%,10%,15%,10%,15%,10%,15%'}">
		<wea:group context="查询条件">
			<wea:item>项目名称</wea:item>
			<wea:item>
				<input name=xmname type=text class=inputStyle   value="<%=xmname%>" 
			</wea:item>
		
			<wea:item>项目编号</wea:item>
			<wea:item>
				<input name=xmcode type=text class=inputStyle   value="<%=xmcode%>" >
			</wea:item>
				
			<wea:item>项目经理</wea:item>
			<wea:item>
				<input name=xmjlname type=text  value="<%=xmjlname %>"> 
			</wea:item>
			
			<wea:item>项目状态</wea:item>
			<wea:item>
				      <select name="xmstatus">
			       		<option	value=-1></option>   
			       		<option value=1  <%if(xmstatus==1){ %>selected<%} %>>立项</option>
			       		<option value=9  <%if(xmstatus==9){ %>selected<%} %>>暂不立项</option>
			       		<option value=7 <%if(xmstatus==7){ %>selected<%} %>>在建</option>
			       		<option value=2 <%if(xmstatus==2){ %>selected<%} %>>初验</option>
			       		<option value=4 <%if(xmstatus==4){ %>selected<%} %>>完成</option>
			       		<option value=5 <%if(xmstatus==5){ %>selected<%} %>>终止</option> 
			       </select>
			</wea:item>
				
				
			<wea:item>申请公司</wea:item>
			<wea:item>
				    <select name=xmgs>
				  <option	value=-1></option>
		                <%  
		                String gsformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "gsbm"));
		                    rs.executeSql(" select gs from formtable_main_"+gsformid+"_dt2 "); 
		                    while(rs.next()){ 
		                %> 
		                   <option value=<%=rs.getString("gs") %> <%if(xmgs.equals(rs.getString("gs"))){ %>selected<%} %> ><%=SubcompanyComInfo.getSubCompanyname(rs.getString("gs")) %></option>
		                <%}  %> 
		              </select>
			</wea:item>
							
			<wea:item>申请部门</wea:item>
			<wea:item>
				    <select name=xmbm>
		  <option	value=-1></option> 
		  		
               <%  
               	  String gsformid1 = Util.null2o(weaver.file.Prop.getPropValue("projconfig", "gsbm"));
               rs.executeSql(" select bm from formtable_main_"+gsformid1+"_dt1 "); 
                    while(rs.next()){  
                %> 
                   <option value=<%=rs.getString("bm") %>   <%if(xmbm.equals(rs.getString("bm"))){ %>selected<%} %> ><%=DepartmentComInfo.getDepartmentname(rs.getString("bm")) %></option>
                <%}  %> 
              </select>
			</wea:item>
					
			<wea:item>项目种类</wea:item>
			<wea:item>
				    <select name=xmzl>
			           <option	value=-1></option> 
							<option value=0 <%if(xmzl==0){ %>selected<%} %> >客户化项目</option>
							<option value=1 <%if(xmzl==1){ %>selected<%} %> >一般投资项目</option>
						</select>
			</wea:item>
				
			<wea:item>是否年度预算内项目</wea:item>
			<wea:item>
				    <select name="sfndys">
		       		<option	value=-1></option>
		       		<option value=0 <%if(sfndys==0){ %>selected<%} %>>是</option>
		       		<option value=1 <%if(sfndys==1){ %>selected<%} %>>否</option> 
		       </select>
			</wea:item>
				
			<wea:item>论证情况</wea:item>
			<wea:item>
				    <select name=lxlzxs>
					 <option	value=-1></option> 
							<% 
							String lxlzwhformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh")); 
			          	   	rs.executeSql(" select * from formtable_main_"+lxlzwhformid+"_dt1 order by px asc ");  	
			          	 	while(rs.next()){  
			          		%>
							<option value=<%=rs.getString("px") %> <%if(rs.getString("px").equals(lxlzxs+"")){ %>selected<%} %> ><%=rs.getString("lzmc") %></option>
						   <%}  %> 
						</select>
			</wea:item>
								
			<wea:item>项目立项</wea:item>
			<wea:item>
				<button type=button class=calendar id=SelectDate onClick="getDate(fromTimespan,formTime)"></button>
					<span id=fromTimespan ><%=sqrq1 %> </span>
				<input type="hidden" name="sqrq1" value="<%=sqrq1 %>">
				&nbsp;&nbsp;&nbsp;&nbsp;——&nbsp;&nbsp;&nbsp;&nbsp;
				<button type=button class=calendar id=SelectDate onClick="getDate(toTimespan,toTime)"></button>
					<span id=toTimespan ><%=sqrq2 %></span>
				<input type="hidden" name="sqrq2" value="<%=sqrq2 %>">
			</wea:item>
								
			<wea:item>一级分类</wea:item>
			<wea:item>
				<input name=firsttype type=text  value="<%=firsttype %>"> 
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


<input name=start type=hidden value="<%=start%>">
 
                                                                               
                          <%
                           String tableString = "";
                          
                            if(perpage <2) perpage=10;                                  
                        
                            String backfields =" t1.* "; 
                            String fromSql  = " from wasu_projectbase t1 "; 
                            String sqlWhere = " where 1=1   "+sqlwhere;   
                         // new weaver.general.BaseBean().writeLog("------->select "+backfields+fromSql+sqlWhere); 
                         //System.out.println("select "+backfields+fromSql+sqlWhere);
                         tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"checkbox\" pagesize=\""+perpage+"\" >"+
                                                 " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
                                                 " <head>";  
                                        //         if(HrmUserVarify.checkUserRight("ProjectStone:Look", user)){
       tableString+=" <col width=\"8%\"  text=\"项目名称\" column=\"name\"  otherpara=\"column:id\" orderkey=\"t1.name\"  transmethod=\"weaver.general.ProjectTransMethod.getProjectName\"  />";                      
                                         //        }else{
                                          //      	 tableString+=" <col width=\"8%\"  text=\"项目名称\" column=\"name\"  orderkey=\"t1.name\"  />";                      
                                          //       }
       tableString+=" <col width=\"6%\"  text=\"项目编号\" column=\"xmcode\"   orderkey=\"t1.xmcode\"   />"; 
     tableString+=" <col width=\"5%\"  text=\"项目经理\" column=\"xmjlname\"   orderkey=\"t1.xmjlname\"     />"; 
      tableString+=" <col width=\"5%\"  text=\"项目状态\" column=\"xmstatus\"    transmethod=\"weaver.general.ProjectTransMethod.getProjectStatus\"/>";  
      tableString+=" <col width=\"5%\"  text=\"立项时间\" column=\"sqrq\" orderkey=\"t1.sqrq\"  />";  
        tableString+=" <col width=\"6%\"  text=\"申请公司\" column=\"xmgs\"      transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\"/>";                      
        tableString+=" <col width=\"6%\"  text=\"申请部门\" column=\"xmbm\"    transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"  />";                       
        tableString+=" <col width=\"5%\"  text=\"投资预算总额\" column=\"xmtzysje\"   orderkey=\"t1.xmtzysje\"  />";                       
        tableString+=" <col width=\"5%\"  text=\"软件金额\" column=\"xmrjje\"  orderkey=\"t1.xmrjje\"  />";                       
        tableString+=" <col width=\"5%\"  text=\"硬件金额\" column=\"xmfyzyyjje\"   orderkey=\"t1.xmfyzyyjje\"    />";                       
     tableString+=" <col width=\"5%\"  text=\"其他金额\" column=\"xmqtjf\"    />";  
        tableString+=" <col width=\"5%\"  text=\"云资源金额\" column=\"xmyzyje\"  orderkey=\"t1.xmyzyje\"    />";                        
       tableString+=" <col width=\"4%\"  text=\"是否年度预算内\" column=\"sfndys\"     transmethod=\"weaver.general.ProjectTransMethod.getProjectNDYS\" />"; 
       tableString+=" <col width=\"5%\"  text=\"论证形式\" column=\"lxlzxs\"     transmethod=\"weaver.general.ProjectTransMethod.getProjectLxlzxs\"/>";  
          tableString+=" <col width=\"5%\"  text=\"是否重大项目\" column=\"lxlzxs\"   transmethod=\"weaver.general.ProjectTransMethod.getProjectZDXM\" />"; 
       tableString+=" <col width=\"5%\"  text=\"项目类别\" column=\"xmlb\"  />";  
       tableString+=" <col width=\"5%\"  text=\"一级分类\" column=\"firsttype\"  />";  
     tableString+=" <col width=\"5%\"  text=\"项目种类\" column=\"xmzl\"     transmethod=\"weaver.general.ProjectTransMethod.getProjectZL\" />"; 
	 if(isEdit){
		tableString+=" <col width=\"5%\"  text=\"已使用经费\" column=\"xmysyfy\"   orderkey=\"t1.xmysyfy\"  />";  
	 }
                                    tableString+="	</head>"+      	 		
                                                 "</table>";    
                          %>
                          <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run"  showExpExcel="fasle"  />
                      </td>
                    </tr>
                  </TABLE>

<!--   added by xwj for td2023 on 2005-05-20  end  -->
     

	  

	</td>
	<td></td>
</tr>
<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>
<% sql = "SELECT " + backfields + " " + fromSql + " " + sqlWhere + " ORDER BY " + " t1.id desc ";
RecordSet.executeSql(sql); 
ExcelFile.init();
ExcelSheet es = new ExcelSheet();
ExcelStyle excelStyle = ExcelFile.newExcelStyle("Border");
excelStyle.setCellBorder(ExcelStyle.WeaverBorderThin);
ExcelStyle excelStyle1 = ExcelFile.newExcelStyle("Header");
excelStyle1.setGroundcolor(ExcelStyle.WeaverHeaderGroundcolor);
excelStyle1.setFontcolor(ExcelStyle.WeaverHeaderFontcolor);
excelStyle1.setFontbold(ExcelStyle.WeaverHeaderFontbold);
excelStyle1.setAlign(ExcelStyle.WeaverHeaderAlign);
excelStyle1.setCellBorder(ExcelStyle.WeaverBorderThin);
ExcelRow er = es.newExcelRow();

er.addStringValue("项目名称", "Header"); 
er.addStringValue("项目编号", "Header"); 
er.addStringValue("项目状态", "Header"); 
er.addStringValue("立项时间", "Header"); 
er.addStringValue("申请公司", "Header"); 
er.addStringValue("申请部门", "Header"); 
er.addStringValue("投资预算总额", "Header"); 
er.addStringValue("软件金额", "Header"); 
er.addStringValue("硬件金额", "Header"); 
er.addStringValue("其他金额", "Header"); 
er.addStringValue("云资源金额", "Header"); 
er.addStringValue("是否年度预算内", "Header"); 
er.addStringValue("论证形式", "Header"); 
er.addStringValue("是否重大项目", "Header"); 
er.addStringValue("项目类别", "Header"); 
er.addStringValue("一级分类", "Header"); 
er.addStringValue("项目种类", "Header"); 

if(isEdit){
	er.addStringValue("已使用经费", "Header");
}
 
while(RecordSet.next()){
	er = es.newExcelRow();
	 
	er.addStringValue(Util.null2String(RecordSet.getString("name")), "Border");
	er.addStringValue(Util.null2String(RecordSet.getString("xmcode")), "Border");
	er.addStringValue(ProjectTransMethod.getProjectStatus(Util.null2String(RecordSet.getString("xmstatus"))), "Border");
	er.addStringValue(Util.null2String(RecordSet.getString("sqrq")), "Border");  
	er.addStringValue(SubCompanyComInfo.getSubCompanyname(Util.null2String(RecordSet.getString("xmgs"))), "Border");
	er.addStringValue(DepartmentComInfo.getDepartmentname(Util.null2String(RecordSet.getString("xmbm"))), "Border");  
	er.addValue(Util.null2String(RecordSet.getString("xmtzysje")), "Border");  
	er.addValue(Util.null2String(RecordSet.getString("xmrjje")), "Border");  
	er.addValue(Util.null2String(RecordSet.getString("xmfyzyyjje")), "Border");  
	er.addValue(Util.null2String(RecordSet.getString("xmqtjf")), "Border");  
	er.addValue(Util.null2String(RecordSet.getString("xmyzyje")), "Border");  
	er.addStringValue(ProjectTransMethod.getProjectNDYS(Util.null2String(RecordSet.getString("sfndys"))), "Border");
	er.addStringValue(ProjectTransMethod.getProjectLxlzxs(Util.null2String(RecordSet.getString("lxlzxs"))), "Border");
	er.addStringValue(ProjectTransMethod.getProjectZDXM(Util.null2String(RecordSet.getString("lxlzxs"))), "Border");
	er.addStringValue(Util.null2String(RecordSet.getString("xmlb")), "Border");   
	er.addStringValue(Util.null2String(RecordSet.getString("firsttype")), "Border");   
	er.addStringValue(ProjectTransMethod.getProjectZL(Util.null2String(RecordSet.getString("xmzl"))), "Border");
	if(isEdit){
		er.addValue(Util.null2String(RecordSet.getString("xmysyfy")), "Border");
	}
	 
}
ExcelFile.setFilename("项目列表导出");  
ExcelFile.addSheet("项目列表", es);
%>

</form>

<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
</body>
<script language=vbs>
sub onShowResource()
	tmpval = document.all("creatertype").value
	if tmpval = "0" then
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	else
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	end if
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		resourcespan.innerHtml = id(1)
		frmmain.createrid.value=id(0)
		else
		resourcespan.innerHtml = ""
		frmmain.createrid.value=""
		end if
	end if
end sub

sub onShowMutiResource(inputename,spanname)  
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="&document.all(inputename).value)
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		document.all(spanname).innerHtml = id(1)
		document.all(inputename).value=id(0)
		else
		document.all(spanname).innerHtml = ""
		document.all(inputename).value=""
		end if
	end if

end sub

sub onShowDepartment(tdname,inputename)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="&document.all(inputename).value)
	if NOT isempty(id) then
	        if id(0)<> "" and id(0)<> "0" then
		document.all(tdname).innerHtml = mid(id(1),2,len(id(1)))
		document.all(inputename).value=mid(id(0),2,len(id(0)))
		else
		document.all(tdname).innerHtml = ""
		document.all(inputename).value=""
		end if
	end if
end sub

sub onShowSubcompany(tdname,inputename)
    linkurl="/hrm/company/HrmSubCompanyDsp.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SingleSubcompanyBrowser.jsp?selectedids="&document.all(inputename).value)
    if NOT isempty(id) then
        if id(0)<> "" then        
        	resourceids = id(0)
       		resourcename = id(1)
        	sHtml = ""
        	 
       		document.all(inputename).value = resourceids
        	while InStr(resourceids,",") <> 0
            	curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            	curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            	resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            	resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            	sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
       		wend
        	sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
       		document.all(tdname).innerHtml = sHtml
        else
					document.all(tdname).innerHtml = ""
        	document.all(inputename).value=""
        end if
    end if
end sub
</script>

<SCRIPT language="javascript">

function OnChangePage(start){
        document.frmmain.start.value = start;
		document.frmmain.submit();
}

function OnSearch(){
		document.frmmain.submit();
}

function OnExportExcel(){  
	document.getElementById("excels").src = "projectlistExcel.jsp?export=true&sql=<%=sql%>"; 
}

function goPayment(){ 
	document.location="personbaoxiaolist.jsp";
}
 

function OnMultiSubmit(){ 

    document.frmmain.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert(document.frmmain.multiSubIds.value);
    if(document.frmmain.multiSubIds.value==''){
	   alert("未选择任何项目！");
	   return;
    }else{
    	document.frmmain.submit();
    }
}

function OnMultiSubmitNew(obj){

    document.frmmain1.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.frmmain1.submit();
	obj.disabled=true;
}
function CheckAll(haschecked) {

    len = document.weaver1.elements.length;
    var i=0;
    for( i=0; i<len; i++) {
        if (document.weaver1.elements[i].name.substring(0,13)=='multi_submit_') {
            document.weaver1.elements[i].checked=(haschecked==true?true:false);
        }
    }


}


var showTableDiv  = document.getElementById('divshowreceivied');
var oIframe = document.createElement('iframe');
function showreceiviedPopup(content){
    showTableDiv.style.display='';
    var message_Div = document.createElement("<div>");
     message_Div.id="message_Div";
     message_Div.className="xTable_message";
     showTableDiv.appendChild(message_Div);
     var message_Div1  = document.getElementById("message_Div");
     message_Div1.style.display="inline";
     message_Div1.innerHTML=content;
     var pTop= document.body.offsetHeight/2+document.body.scrollTop-50;
     var pLeft= document.body.offsetWidth/2-50;
     message_Div1.style.position="absolute"
     message_Div1.style.posTop=pTop;
     message_Div1.style.posLeft=pLeft;

     message_Div1.style.zIndex=1002;

     oIframe.id = 'HelpFrame';
     showTableDiv.appendChild(oIframe);
     oIframe.frameborder = 0;
     oIframe.style.position = 'absolute';
     oIframe.style.top = pTop;
     oIframe.style.left = pLeft;
     oIframe.style.zIndex = message_Div1.style.zIndex - 1;
     oIframe.style.width = parseInt(message_Div1.offsetWidth);
     oIframe.style.height = parseInt(message_Div1.offsetHeight);
     oIframe.style.display = 'block';
}
function displaydiv_1()
{
	if(WorkFlowDiv.style.display == ""){
		WorkFlowDiv.style.display = "none";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(332,user.getLanguage())%></span>";
	}
	else{
		WorkFlowDiv.style.display = "";
		//WorkFlowspan.innerHTML = "<a href='javascript:void(0);' onClick=displaydiv_1() target=_self><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></a>";
		WorkFlowspan.innerHTML = "<span style='cursor:hand;color: blue; text-decoration: underline' onClick='displaydiv_1()' ><%=SystemEnv.getHtmlLabelName(15154,user.getLanguage())%></span>";

	}
}

function ajaxinit(){
    var ajax=false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
    ajax = new XMLHttpRequest();
    }
    return ajax;
}
function showallreceived(requestid,returntdid){
    showreceiviedPopup("<%=SystemEnv.getHtmlLabelName(19205,user.getLanguage())%>");
    var ajax=ajaxinit();
	
    ajax.open("POST", "WorkflowUnoperatorPersons.jsp", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("requestid="+requestid+"&returntdid="+returntdid);
    //获取执行状态
    //alert(ajax.readyState);
	//alert(ajax.status);
    ajax.onreadystatechange = function() {
        //如果执行状态成功，那么就把返回信息写到指定的层里
        if (ajax.readyState==4&&ajax.status == 200) {
            try{
            document.all(returntdid).innerHTML = ajax.responseText;
            }catch(e){}
            showTableDiv.style.display='none';
            oIframe.style.display='none';
        } 
    } 
}
//?rnd="+Math.random()+" 
</script>
 
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</html>
 