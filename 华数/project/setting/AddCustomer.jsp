<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,weaver.conn.*" %>
<jsp:useBean id="CustomerTypeComInfo" class="weaver.crm.Maint.CustomerTypeComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
<jsp:useBean id="CountryComInfo" class="weaver.hrm.country.CountryComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="CustomerInfoComInfo" class="weaver.crm.Maint.CustomerInfoComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />

<%!
/**
 * @Date June 21,2004
 * @Author Charoes Huang
 * @Description 检测是否是个人用户的添加
 */
	private boolean isPerUser(String type){
		RecordSet rs = new RecordSet();
		String sqlStr ="Select * From CRM_CustomerType WHERE ID = "+type+" and candelete='n' and canedit='n' and fullname='个人用户'";
		rs.executeSql(sqlStr);
		if(rs.next()){
			return true;
		}
		return false;
	}
%>
 
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET> 
<SCRIPT language="javascript" src="/js/jquery/jquery.js"></script> 
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script language=javascript >
function checkSubmit(obj){
	window.onbeforeunload=null;
	if(check_form(weaver,"Name")){ 
		obj.disabled = true; // added by 徐蔚绛 for td:1553 on 2005-03-22
		weaver.submit();
	}
}
function protectCus(){
	if(!checkDataChange())//added by cyril on 2008-06-12 for TD:8828
		event.returnValue="<%=SystemEnv.getHtmlLabelName(18675,user.getLanguage())%>";
}
function mailValid() {
	var emailStr = document.all("CEmail").value;
	emailStr = emailStr.replace(" ","");
	if (!checkEmail(emailStr)) {
		alert("<%=SystemEnv.getHtmlLabelName(18779,user.getLanguage())%>");
		document.all("CEmail").focus();
		return;
	}
}
</script>

</HEAD>
<%
String type = Util.null2String(request.getParameter("type1"));
String name = Util.null2String(request.getParameter("name1"));
// check the "type" null value added by lupeng 2004-8-9. :)
/*Added by Charoes Huang On June 21,2004*/
if(!type.equals("") && isPerUser(type)){
	response.sendRedirect("AddPerCustomer.jsp?type1="+type+"&name1=" + new String(name.getBytes("GBK") , "ISO8859_1"));
	
	return;
}

String lxlzwhformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "lxlzwh")); 

String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+":项目"; 
String needfav ="1";
String needhelp ="";
String beginDate=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<BODY onbeforeunload="protectCus()">
<%@ include file="/systeminfo/TopTitle.jsp" %>

<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:checkSubmit(this),_top} " ;
RCMenuHeight += RCMenuHeightStep ; 
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

<FORM id=weaver name= weaver action="/project/CustomerOperation.jsp" method=post onsubmit='return check_form(this,"Name,Abbrev,Address1,Language,Type,Description,Size,Source,Sector,Manager,Department,Title,FirstName,JobTitle,Email,seclevel,CreditAmount,CreditTime")' enctype="multipart/form-data">
<input type="hidden" name="method" value="add">

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
            <TH colSpan=2>项目基本信息</TH>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=2></TD></TR>
          
        <TR>
          <TD>项目<%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=50 name="Name" onchange='checkinput("Name","Nameimage")' STYLE="width:95%" value='<%=Util.toScreen(name,user.getLanguage(),"0")%>'><SPAN id=Nameimage><%if(name=="") {%><IMG src="/images/BacoError.gif" align=absMiddle><%}%></SPAN></TD>
        </TR><tr><td class=Line colspan=2></td></tr> 
        <TR>
          <TD>项目编码</TD>
          <TD class=Field><INPUT type=hidden class=InputStyle maxLength=50 name="xmcode" STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
         <TR>
          <TD>项目经理</TD>
          <TD class=Field>
          <!--  <BUTTON class=Browser id=xmjlid onClick="onShowResourceID()"></BUTTON> 
           <span  id=xmjlidspan><%=user.getUsername()%></span> -->
              <INPUT class=InputStyle type=text name=xmjlname >
        </TD>
        </TR><tr><td class=Line colspan=2></td></tr> 
         <TR> 
          <TD>所属公司</TD>
          <TD class=Field>  
              <select name=xmgs  onchange="changeyijifl(this)">
                   <option value=-1 >    </option>
                <%   
                   String gsformid= Util.null2o(weaver.file.Prop.getPropValue("projconfig", "gsbm"));
                    rs.executeSql(" select gs from formtable_main_"+gsformid+"_dt2 ");  
                    while(rs.next()){ 
                %> 
                   <option value=<%=rs.getString("gs") %>><%=SubCompanyComInfo.getSubCompanyname(rs.getString("gs")) %></option>
                <%}  %> 
              </select>
              
        </TD>
        </TR><tr><td class=Line colspan=2></td></tr> 
         <TR>
          <TD>所属部门</TD> 
          <TD class=Field>  
              <select name=xmbm>
               <%  rs.executeSql(" select bm from formtable_main_"+gsformid+"_dt1 ");
                    while(rs.next()){  
                %> 
                   <option value=<%=rs.getString("bm") %>><%=DepartmentComInfo.getDepartmentname(rs.getString("bm")) %></option>
                <%}  %> 
              </select>
        </TD>
        </TR><tr><td class=Line colspan=2></td></tr>     
         <TR>
          <TD>申请日期</TD> 
          <TD class=Field>  
               <BUTTON class="Calendar" id="selectBeginDate" onclick="onshowPlanDate(sqrq, selectBeginDateSpan)"></BUTTON> 
				<SPAN id="selectBeginDateSpan">
				 <%=beginDate %>
				</SPAN> 
				<INPUT type="hidden" name="sqrq" value="<%=beginDate%>">   
        </TD>
        </TR><tr><td class=Line colspan=2></td></tr>     
        <TR>
          <TD>项目经理邮箱	</TD>
          <TD class=Field><INPUT class=InputStyle maxLength=120 name="xmjlemail"   STYLE="width:95%">
          <!--<SPAN id=Address1image><IMG src="/images/BacoError.gif" align=absMiddle></SPAN>  -->
          </TD>
        </TR><tr><td class=Line colspan=2></td></tr>        
        <TR>
          <TD>项目种类</TD>
          <TD class=Field>
          	<select name=xmzl  onchange="changeLxlzxs(this)">
				<option value=0>客户化项目</option>
				<option value=1>一般投资项目</option>
				<option value=2>重大投资项目</option>
			</select>
          </TD>
        </TR><tr><td class=Line colspan=2></td></tr>     
        <TR>
        <TD>一级类别</TD>
        <TD class=Field>
         <%  rs.executeSql(" select gs from formtable_main_"+gsformid+"_dt2 ");  
         		while(rs.next()){ 
         			String gsid=rs.getString("gs");
         		
          %>
        	<select name=firsttype id="firstype_<%=gsid %>" onchange="getdynlboptions(this,<%=gsid %>)" disabled=true style="display:none" > 
             <option value=-1 > </option> 
             	<% 
        	    rs2.executeSql(" select distinct firsttype from formtable_main_"+lxlzwhformid+"_dt2 where ssgs="+gsid+" order by firsttype asc ");	
        	 	while(rs2.next()){  
        	    %>
				<option value=<%=rs2.getString("firsttype") %> ><%=rs2.getString("firsttype") %></option>
			   <%} %> 
			 </select>
			 <% }  %> 
			
        </TD>
      </TR><tr><td class=Line colspan=2></td></tr> 
        <TR>
          <TD>项目类别</TD>
        <!--
          <TD class=Field>
           <%  rs.executeSql(" select gs from formtable_main_"+gsformid+"_dt2 ");  
           		while(rs.next()){ 
           			String gsid=rs.getString("gs");
           		
            %>
          	<select name=xmlb id="xmlb_<%=gsid %>" disabled=true style="display:none" > 
               <option value=-1 > </option> 
               	<% 
          	    rs2.executeSql(" select * from formtable_main_"+lxlzwhformid+"_dt2 where ssgs="+gsid+" order by sx asc ");	
          	 	while(rs2.next()){  
          	    %>
				<option value=<%=rs2.getString("lbzm") %>  ><%=rs2.getString("lbmc") %></option>
			   <%} %> 
			 </select>
			 <% }  %> 
          </TD>
          -->
          <TD class=Field>
		      	<select name=xmlb id="xmlb" > 
		        <option value=-1 > </option> 
				 </select>
		 </td>
        </TR><tr><td class=Line colspan=2></td></tr>     
        <TR>
          <TD>联系电话</TD>
          <TD class=Field><INPUT class=InputStyle maxLength=50 name="lxdh" STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>        
        <TR>
          <TD>是否年度预算内项目</TD>
          <TD class=Field>
          	<select name=sfndys>
				<option value=0>是</option>
				<option value=1>否</option>
			</select>
          </TD>
        </TR><tr><td class=Line colspan=2></td></tr>     
        <TR>
          <TD>立项论证形式</TD>
          <TD class=Field>
          	<select name=lxlzxs id=lxlzxs> 
          	<% 
          	   rs.executeSql(" select * from formtable_main_"+lxlzwhformid+"_dt1 order by px asc ");	
          	 while(rs.next()){  
          	%>
				<option value=<%=rs.getString("px") %> <%if(rs.getString("lzmc").equals("直接")){ %>selected<%} %> ><%=rs.getString("lzmc") %></option>
			   <%}  %> 
			</select>  
          </TD>
        </TR><tr><td class=Line colspan=2></td></tr>     
         <TR>
          <TD>项目投资情况</TD>
          <TD class=Field>
          	 投资预算金额:<INPUT class=InputStyle size=6 name="xmtzysje" >万 （其中软件金额：<INPUT class=InputStyle  size=6 name="xmrjje" >万 硬件金额:<INPUT class=InputStyle  size=6 name="xmfyzyyjje" >万 ）云资源金额：<INPUT class=InputStyle size=6 name="xmyzyje"  value=0.0 >万
          	项目其他经费：<INPUT class=InputStyle size=6 name="xmqtjf" >万
          </TD> 
        </TR><tr><td class=Line colspan=2></td></tr>  
        <!-- <TR>
        <TD>项目其他经费</TD>
        <TD class=Field>
        	<INPUT class=InputStyle size=6 name="xmqtjf" >  
        </TD> 
      </TR><tr><td class=Line colspan=2></td></tr>  -->     
              
        </TBODY>
	  </TABLE>

	  <TABLE class=ViewForm style="display:none">
        <COLGROUP>
		<COL width="30%">
  		<COL width="70%">
        <TBODY>
        <TR class=Title>
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(572,user.getLanguage())%></TH>
          </TR>
        <TR class=Spacing>
          <TD class=Line1 colSpan=2></TD></TR>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(462,user.getLanguage())%></TD>
          
           <td class=Field id=txtLocation><BUTTON class=Browser onclick="onShowTitleID()"></BUTTON> 
              <SPAN id=Titlespan><IMG src='/images/BacoError.gif' align=absMiddle></SPAN> 
              <INPUT type=hidden name=Title>        </TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(413,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=50 name="FirstName" onchange='checkinput("FirstName","FirstNameimage")' STYLE="width:95%"><SPAN id=FirstNameimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(640,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=100 name="JobTitle" onchange='checkinput("JobTitle","JobTitleimage")' STYLE="width:95%"><SPAN id=JobTitleimage><IMG src="/images/BacoError.gif" align=absMiddle></SPAN></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(477,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=150 name="CEmail" onblur='mailValid()' STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(420,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=20 name="PhoneOffice" STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(619,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(421,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=20 name="PhoneHome" STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
          <TD><%=SystemEnv.getHtmlLabelName(620,user.getLanguage())%></TD>
          <TD class=Field><INPUT class=InputStyle maxLength=20 name="Mobile" STYLE="width:95%"></TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        <TR>
           <TD><%=SystemEnv.getHtmlLabelName(15707,user.getLanguage())%></TD>
            <TD class=Field>
              <input class=inputstyle maxLength=20 type="file" STYLE="width:95%" name="photoid">
            </TD>
        </TR><tr><td class=Line colspan=2></td></tr>
        </TBODY>
	  </TABLE>

	</TD>

    <TD></TD>
    
	<TD vAlign=top>
       
	</TD>
  </TR>
  </TBODY>
</TABLE>
</FORM>
<script language=vbs>
sub onShowCountryID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/country/CountryBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	countryidspan.innerHtml = id(1)
	weaver.Country.value=id(0)
	else 
	countryidspan.innerHtml = ""
	weaver.Country.value=""
	end if
	end if
end sub

sub onShowProvinceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/province/ProvinceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	provinceidspan.innerHtml = id(1)
	weaver.Province.value=id(0)
	else 
	provinceidspan.innerHtml = ""
	weaver.Province.value=""
	end if
	end if
end sub

sub onShowCityID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/city/CityBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	cityidspan.innerHtml = id(1)
	weaver.City.value=id(0)
	else 
	cityidspan.innerHtml = ""
	weaver.City.value=""
	end if
	end if
end sub

sub onShowLanguageID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/systeminfo/language/LanguageBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	languageidspan.innerHtml = id(1)
	weaver.Language.value=id(0)
	else 
	languageidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Language.value=""
	end if
	end if
end sub

sub onShowTitleID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/ContacterTitleBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Titlespan.innerHtml = id(1)
	weaver.Title.value=id(0)
	else 
	Titlespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Title.value=""
	end if
	end if
end sub

sub onShowTypeID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerTypeBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Typespan.innerHtml = id(1)
	weaver.Type.value=id(0)
	else 
	Typespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Type.value=""
	end if
	end if
end sub

sub onShowDescriptionID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerDescBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Descriptionspan.innerHtml = id(1)
	weaver.Description.value=id(0)
	else 
	Descriptionspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Description.value=""
	end if
	end if
end sub


sub onShowSizeID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerSizeBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Sizespan.innerHtml = id(1)
	weaver.Size.value=id(0)
	else 
	Sizespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Size.value=""
	end if
	end if
end sub

sub onShowSourceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/ContactWayBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Sourcespan.innerHtml = id(1)
	weaver.Source.value=id(0)
	else 
	Sourcespan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Source.value=""
	end if
	end if
end sub

sub onShowSectorID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/SectorInfoBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Sectorspan.innerHtml = id(1)
	weaver.Sector.value=id(0)
	else 
	Sectorspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Sector.value=""
	end if
	end if
end sub

sub onShowManagerID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	manageridspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaver.Manager.value=id(0)
	else 
	manageridspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Manager.value=""
	end if
	end if
end sub

sub onShowResourceID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	xmjlidspan.innerHtml = "<A href='/hrm/resource/HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	weaver.xmjl.value=id(0)
	else 
	xmjlidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.xmjl.value=""
	end if
	end if
end sub

sub onShowDepartment()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&weaver.Department.value)
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	departmentspan.innerHtml = id(1)
	weaver.Department.value=id(0)
	else
	departmentspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	weaver.Department.value=""
	end if
	end if
end sub

sub onShowAgent()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp?sqlwhere=where t1.type in (3,4)")
	
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	Agentspan.innerHtml = "<A href='/CRM/data/ViewCustomer.jsp?CustomerID="&id(0)&"'>"&id(1)&"</A>"
	weaver.Agent.value=id(0)
	else 
	Agentspan.innerHtml = ""
	weaver.Agent.value=""
	end if
	end if
end sub

sub onShowParent()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/CustomerBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	Parentspan.innerHtml = "<A href='/CRM/data/ViewCustomer.jsp?CustomerID="&id(0)&"'>"&id(1)&"</A>"
	weaver.Parent.value=id(0)
	else 
	Parentspan.innerHtml = ""
	weaver.Parent.value=""
	end if
	end if
end sub

sub showDoc()
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		weaver.Document.value=id(0)&""
		Documentname.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub

sub showRemarkDoc()
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		weaver.RemarkDoc.value=id(0)&""
		RemarkDocname.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub

sub showRemarkdocName()
	id = window.showModalDialog("/docs/DocBrowserMain.jsp?url=/docs/docs/DocBrowser.jsp")
	if Not isempty(id) then
		weaver.introductionDocid.value=id(0)&""
		introductionDocname.innerHtml = "<a href='/docs/docs/DocDsp.jsp?id="&id(0)&"'>"&id(1)&"</a>"	
	end if	
end sub
sub onShowStatusID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/Maint/CustomerStatusBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	Statusspan.innerHtml = id(1)
	weaver.CustomerStatus.value=id(0)
	else
	Statusspan.innerHtml = ""
	cms.CustomerStatus.value=""
	end if
	end if
end sub
</script>

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
</BODY>
<script language=javascript>
 function changeLxlzxs(obj){
	 if(obj.value==0){
		 document.getElementById("lxlzxs").selectedIndex=1;
	 }else{
		 if(document.getElementById("lxlzxs").selectedIndex==1){ 
			 document.getElementById("lxlzxs").selectedIndex=0;
		 }
	 }
 }
 
 function changefl(obj){ 
	 //alert(document.getElementById("xmlb_"+obj.value).style.display);
	 //alert(jQuery("[id^=xmlb_]").size());//.disabled=false;
	 //alert(jQuery("[id^=xmlb_]")); 
	 jQuery("[id^=xmlb_]").attr("disabled","true");  
	 jQuery("[id^=xmlb_]").css("display","none"); //.style.display="none";  
	 
	 document.getElementById("xmlb_"+obj.value).disabled=false;
	 document.getElementById("xmlb_"+obj.value).style.display="block";
 }
 
 //first type
 function changeyijifl(obj){  
	 jQuery("[id^=firstype_]").attr("disabled","true");  
	 jQuery("[id^=firstype_]").css("display","none"); //.style.display="none";  
	 
	 document.getElementById("firstype_"+obj.value).disabled=false; 
	 document.getElementById("firstype_"+obj.value).style.display="block";
 }
 
 //add dynamic options
function getdynlboptions(obj,gsid){ 
	//alert(obj.value);
	//alert(gsid);
	jQuery.ajax({
		type:"post",
		url: "/project/getOptionByFirstType.jsp",
		async:false,
		data:{"method":"getOptionsByFirstType","firsttype":obj.value,"gs":gsid}, 
		success:function(data){ 
			eval("var returno="+data);
	        var ro=returno.doptions;
	        //alert(ro);
	        jQuery("#xmlb").empty();
	        jQuery("#xmlb").append(ro);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			 //alert(XMLHttpRequest.status);
             //alert(XMLHttpRequest.readyState);
             alert(textStatus);
		}
	}); 
}
</script>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
<!-- added by cyril on 2008-06-12 for td8828-->
<script language=javascript src="/js/checkData.js"></script>
<!-- end by cyril on 2008-06-12 for td8828-->
</HTML>
