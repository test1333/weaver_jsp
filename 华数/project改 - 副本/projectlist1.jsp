
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
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


<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<style>
.checkbox {
	display: none
}
</style>
</head>
<%
	int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
	String imagefilename = "/images/hdDOC.gif";
	String titlename = "";  
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
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= PageIdConst.HRM_ONLINEUSER %>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
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
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

<FORM id=weaver name=frmmain method=post action="projectlist1.jsp">
	<input type=hidden name=multiSubIds value=""/>
	 <input name=creatertype type=hidden value="0">  
	<input type=hidden name=isovertime value="<%=isovertime%>">
	<input name=start type=hidden value="<%=start%>">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<!--<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>-->
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>

 <div class="tab_box" style="visibility: visible;">

	<wea:layout type="table" attributes="{'cols':'6','cws':'13%,20%,13%,20%,13%,21%,'}">
		<wea:group context="查询条件" >
			<wea:item  type="thead"/><wea:item  type="thead"/><wea:item  type="thead"/><wea:item  type="thead"/><wea:item  type="thead"/><wea:item  type="thead"/>
			<wea:item>项目名称</wea:item>
			<wea:item>
				<input name=xmname type=text class=inputStyle   value="<%=xmname%>" />
			</wea:item>
		
			<wea:item>项目编号</wea:item>
			<wea:item>
				<input name=xmcode type=text class=inputStyle   value="<%=xmcode%>" />
			</wea:item>
				
			<wea:item>项目经理</wea:item>
			<wea:item>
				<input name=xmjlname type=text  value="<%=xmjlname %>"/> 
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
				<input type="hidden" name="sqrq1" value="<%=sqrq1 %>"/>
				&nbsp;&nbsp;&nbsp;&nbsp;——&nbsp;&nbsp;&nbsp;&nbsp;
				<button type=button class=calendar id=SelectDate onClick="getDate(toTimespan,toTime)"></button>
					<span id=toTimespan ><%=sqrq2 %></span>
				<input type="hidden" name="sqrq2" value="<%=sqrq2 %>"/>
			</wea:item>
								
			<wea:item>一级分类</wea:item>
			<wea:item>
				<input name=firsttype type=text  value="<%=firsttype %>"/> 
			</wea:item>
		</wea:group>
		<!--<wea:group context="">
			<wea:item type="toolbar">
				<input class="e8_btn_submit" type="submit" name="submit_1" onClick="onSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
				<span class="e8_sep_line">|</span>
				<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
				<span class="e8_sep_line">|</span>
				<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
					
			</wea:item>
		</wea:group>-->
	</wea:layout>
</div>	

	</FORM>

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

</html>
 
 <SCRIPT language="javascript">
function OnSearch(){
		document.frmmain.submit();
}
</script>
 
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>