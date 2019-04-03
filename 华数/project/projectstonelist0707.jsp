<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%><!--added by xwj for td2023 on 2005-05-20-->
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.GCONST" %>
<%@ page import="weaver.general.IsGovProj" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="SearchClause" class="weaver.search.SearchClause" scope="session" />
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="SubcompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type="text/css" rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>

</head>
<%
int isgoveproj = Util.getIntValue(IsGovProj.getPath(),0);//0:非政务系统，1：政务系统
String imagefilename = "/images/hdDOC.gif";
String titlename = "搜索：项目相关信息查询";  
String needfav ="1";
String needhelp ="";


String workflowids=""; 

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %> 

<FORM id=weaver name=frmmain method=post action="projectstonelist.jsp">

<% 
 
String xmname=Util.null2String(request.getParameter("xmname"));
String xmcode=Util.null2String(request.getParameter("xmcode"));
String xmjl=Util.null2String(request.getParameter("xmjl")); 
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


String CurrentUser = Util.null2String((String)session.getAttribute("RequestViewResource")) ;

String userID = String.valueOf(user.getUID());
  
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
  
int perpage=100;
 

RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:OnSearch(),_self}" ;
RCMenuHeight += RCMenuHeightStep ; 

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

<table class="viewform">
  <colgroup>
  <col width="10%">
  <col width="20%">
  <col width="5">
  <col width="10%">
  <col width="20%">
  <col width="5%">
  <col width="10%">
  <col width="20%">
  <tbody>
    <tr>
    <td>项目名称</td>
    <td class=field> 
	      <input name=xmname type=text class=inputStyle   value="<%=xmname%>" >
    </td> 
    <td>&nbsp;</td>
    <td>项目编号</td> 
    <td class=field >
        <input name=xmcode type=text class=inputStyle   value="<%=xmcode%>" >
    </td> 
    <td>&nbsp;</td>
    <td>项目经理</td> 
    <td class=field >
          <button class=browser onClick="onShowMutiResource('xmjl','resourcesspan')"></button>
			<span id=resourcesspan><%=ResourceComInfo.getMulResourcename(xmjl) %></span>
		   <input name=xmjl type=hidden  value="<%=xmjl %>"> 
    </td> 
  </tr>
  <TR><TD class=Line colSpan=8></TD></TR> 
  <tr>
   <td>项目状态</td>
   <td class=field>
       <select name="xmstatus">
       <option	value=-1></option>
       		<option  <%if(xmstatus==0){ %>selected<%} %>>立项</option>
       		<option  <%if(xmstatus==1){ %>selected<%} %>>在建</option>
       		<option  <%if(xmstatus==2){ %>selected<%} %>>验收</option>
       		<option  <%if(xmstatus==3){ %>selected<%} %>>完成</option>
       		<option  <%if(xmstatus==4){ %>selected<%} %>>终止</option> 
       </select>
  </td>
  <td>&nbsp;</td>
 <td >申请公司</td>
	<td class=field>
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
    </td>
  <td>&nbsp;</td>
 
  <td >申请部门</td>
	<td class=field>
		  <select name=xmbm>
		  <option	value=-1></option> 
               <%  rs.executeSql(" select bm from formtable_main_"+gsformid+"_dt1 "); 
                    while(rs.next()){  
                %> 
                   <option value=<%=rs.getString("bm") %>   <%if(xmbm.equals(rs.getString("bm"))){ %>selected<%} %> ><%=DepartmentComInfo.getDepartmentname(rs.getString("bm")) %></option>
                <%}  %> 
              </select>
    </td> 
  
  </tr>
  <TR><TD class=Line colSpan=8></TD></TR> 
  <tr>
   <td>相关会议纪要</td>
   <td class=field>
          <button class=browser onClick="onShowSubcompany('subcompanyspan','subcompanyid')"></button>
			<span id=subcompanyspan></span>
			<input name=subcompanyid type=hidden name=xghyjy  value="" /> 
   </td>
  <td>&nbsp;</td>
 <td >是否年度预算内项目</td>
	<td class=field>
		  <select name="sfndys">
       		<option	value=-1></option>
       		<option value=0 <%if(sfndys==0){ %>selected<%} %>>是</option>
       		<option value=1 <%if(sfndys==1){ %>selected<%} %>>否</option> 
       </select>
    </td> 
    <td>&nbsp;</td>
  <td >论证情况</td>
	<td class=field>
		 <select name=lxlzxs>
		 <option	value=-1></option> 
				<option value=0 <%if(lxlzxs==0){ %>selected<%} %>>直接</option>
				<option value=1 <%if(lxlzxs==1){ %>selected<%} %>>邮件 </option>
				<option value=2 <%if(lxlzxs==2){ %>selected<%} %>>会议 </option>
				<option value=3 <%if(lxlzxs==3){ %>selected<%} %>>战略</option> 
			</select>
    </td>  
  </tr>
   <TR><TD class=Line colSpan=8></TD></TR> 
    <tr>
   <td>项目种类</td>
   <td class=field>
           <select name=xmzl>
           <option	value=-1></option> 
				<option value=0 <%if(xmzl==0){ %>selected<%} %> >客户化项目</option>
				<option value=1 <%if(xmzl==1){ %>selected<%} %> >一般投资项目</option>
			</select>
   </td>
  <td>&nbsp;</td>
 <td >项目申请日期</td>
	<td class=field>
		   <BUTTON class="Calendar" id="selectBeginDate" onclick="onshowPlanDate(sqrq1, selectBeginDateSpan)"></BUTTON> 
				<SPAN id="selectBeginDateSpan"><%=sqrq1%></SPAN> 
				<INPUT type="hidden" name="sqrq1" value="<%=sqrq1%>">  
				- 
			<BUTTON class="Calendar" id="selectendDate" onclick="onshowPlanDate(sqrq2, selectendDateSpan)"></BUTTON> 
				<SPAN id="selectendDateSpan"><%=sqrq2%></SPAN> 
				<INPUT type="hidden" name="sqrq2" value="<%=sqrq2%>">
    </td> 
    <td>&nbsp;</td>
  <td > </td>
	<td class=field>
		 
    </td>  
  </tr>
   <TR><TD class=Line colSpan=8></TD></TR> 
   
   
  <TR><TD class=Line colSpan=8></TD></TR> 
  </tbody>
</table>

<input name=start type=hidden value="<%=start%>">
</form>
 
 <TABLE width="100%">
  
                    <tr>
                      <td valign="top">                                                                                    
                          <%
                           String tableString = "";
                          
                            if(perpage <2) perpage=10;                                  
                        
                            String backfields =" t1.* "; 
                            String fromSql  = " from wasu_projectbase t1 "; 
                            String sqlWhere = " where 1=1   "+sqlwhere;  
                         // new weaver.general.BaseBean().writeLog("------->select "+backfields+fromSql+sqlWhere); 
                         System.out.println("select "+backfields+fromSql+sqlWhere);
                         tableString =" <table instanceid=\"workflowRequestListTable\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
                                                 " <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"t1.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
                                                 " <head>";  
                                    tableString+=" <col width=\"12%\"  text=\"项目名称\" column=\"name\"  otherpara=\"column:id\" orderkey=\"t1.name\"  transmethod=\"weaver.general.ProjectTransMethod.getProjectName\"  />";                      
                                    tableString+=" <col width=\"6%\"  text=\"项目编号\" column=\"xmcode\"   orderkey=\"t1.xmcode\"   />"; 
                                    tableString+=" <col width=\"6%\"  text=\"里程碑数\" column=\"id\"    transmethod=\"weaver.general.ProjectTransMethod.getStoneAcount\"  />";                       
                                    tableString+=" <col width=\"6%\"  text=\"关注数\" column=\"id\"      transmethod=\"weaver.general.ProjectTransMethod.getAttentionAcount\"/>";                      
                                    tableString+=" <col width=\"5%\"  text=\"1月\" column=\"id\"     otherpara=\"1\"   transmethod=\"weaver.general.ProjectTransMethod.getStonePic\" />"; 
                                    tableString+=" <col width=\"5%\"  text=\"2月\" column=\"id\"     otherpara=\"2\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\" />"; 
                                    tableString+=" <col width=\"5%\"  text=\"3月\" column=\"id\"     otherpara=\"3\" transmethod=\"weaver.general.ProjectTransMethod.getStonePic\" />";  
                                    tableString+=" <col width=\"5%\"  text=\"4月\" column=\"id\"     otherpara=\"4\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"5月\" column=\"id\"     otherpara=\"5\" transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"6月\" column=\"id\"     otherpara=\"6\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"7月\" column=\"id\"     otherpara=\"7\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"8月\" column=\"id\"     otherpara=\"8\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"9月\" column=\"id\"     otherpara=\"9\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"10月\" column=\"id\"    otherpara=\"10\"   transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"11月\" column=\"id\"    otherpara=\"11\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+=" <col width=\"5%\"  text=\"12月\" column=\"id\"    otherpara=\"12\"  transmethod=\"weaver.general.ProjectTransMethod.getStonePic\"/>";  
                                    tableString+="	</head>"+      	 		
                                                 "</table>";    
                          %>
                          <wea:SplitPageTag  tableString="<%=tableString%>"  mode="run"  showExpExcel="true"  />
                      </td>
                    </tr>
                  </TABLE>

<!--   added by xwj for td2023 on 2005-05-20  end  -->
     
<table align=right>
   <tr>
   <td>&nbsp;</td>
   <td>
   <%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(18363,user.getLanguage())+",javascript:_table.firstPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1258,user.getLanguage())+",javascript:_table.prePage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1259,user.getLanguage())+",javascript:_table.nextPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(18362,user.getLanguage())+",javascript:_table.lastPage(),_self}" ;
    RCMenuHeight += RCMenuHeightStep ;
   %>
 <td>&nbsp;</td>
   </tr>
	  </TABLE>
	  
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



<%@ include file="/systeminfo/RightClickMenu.jsp" %>
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

function goPayment(){ 
	document.location="personbaoxiaolist.jsp";
}
 

function OnMultiSubmit(){ 

    document.frmmain.multiSubIds.value = _xtable_CheckedCheckboxId();
    //alert (document.frmmain1.multiSubIds.value);
    document.frmmain.submit();
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
 
<SCRIPT language="javascript" defer="defer" src='/js/datetime.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript" src="/js/project/WdatePicker.js"></script> 
<SCRIPT language="javascript"  src='/js/selectDateTime.js?rnd="+Math.random()+"'></script>
</html>
 