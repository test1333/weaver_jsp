<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="xssUtil" class="weaver.filter.XssUtil" scope="page" />
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<html>
<% if(!HrmUserVarify.checkUserRight("HrmResourceAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }
%>
<head>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
</head>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);
String resourceid=Util.null2String(request.getParameter("resourceid"));
if(resourceid.equals("undefined"))resourceid="";
boolean hasFF = true;
rs.executeProc("Base_FreeField_Select","hr");
if(rs.getCounts()<=0)
	hasFF = false;
else
	rs.first();
	
String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename = SystemEnv.getHtmlLabelName(6091,user.getLanguage())+": "+ SystemEnv.getHtmlLabelName(179,user.getLanguage());
String needfav ="1";
String needhelp ="";

int detachable=Util.getIntValue(String.valueOf(session.getAttribute("detachable")),0);
%>
<body>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(615,user.getLanguage())+",javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
  <FORM name=resource id=resource action="HrmResourceStatusOperation.jsp" method=post>
  <table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type=button class="e8_btn_top" onclick="doSave(this);" value="<%=SystemEnv.getHtmlLabelName(615, user.getLanguage())%>"></input>
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
    <input type=hidden name=operation value="dismiss">
    <%if(software.equals("ALL") || software.equals("HRM")){}else{ %>       
              <INPUT type=hidden name=changecontractid value='0'>                           
		<%}%>
    <wea:layout>
    	<wea:group context='<%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%>'>
    		<wea:item><%=SystemEnv.getHtmlLabelName(897,user.getLanguage())%></wea:item>
            <wea:item> 
					  <%
					  String lastname = "";
					  if(resourceid.length()>0) lastname = ResourceComInfo.getLastnameAllStatus(resourceid);
					  String subcomstr = "";
				    	if(detachable==1){  
				        //如果开启分权，管理员
						  subcomstr=SubCompanyComInfo.getRightSubCompany(user.getUID(),"HrmResourceAdd:Add",0);
				        }
					  String sqlwhere = " (status<4 or status>6) and status!=7 " ;
					  String browserUrl = "/systeminfo/BrowserMain.jsp?url=/hrm/resource/MultiResourceBrowserByRight.jsp?rightStr=HrmResourceAdd:Add&fromHrmStatusChange=HrmResourceDismiss&sqlwhere="+xssUtil.put(sqlwhere)+"&selectedids=";
						String completeUrl = "/data.jsp?whereClause="+xssUtil.put(" (status<4 or status>6) and status!=7 ");
						if(!"".equals(subcomstr)){
						completeUrl = "/data.jsp?whereClause="+xssUtil.put(" (status<4 or status>6) and status!=7 and ("+Util.getSubINClause(subcomstr, "t1.subcompanyid1", "in") +") ");
						}
						
					  %>
		        <brow:browser viewType="0" name="resourceid" browserValue='<%=resourceid %>' 
		             browserUrl='<%=browserUrl %>' 
		             hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='2'
		             completeUrl='<%=completeUrl %>' linkUrl="javascript:openhrm($id$)"
		             browserSpanValue='<%=lastname %>'>     
		        </brow:browser>
            <!-- 
                        <BUTTON class=Browser  type="button" onclick="onShowResource(resourceid,assistantidspan)"></BUTTON> 
              <SPAN id=assistantidspan><IMG src='/images/BacoError_wev8.gif' align=absMiddle></SPAN> 
              <INPUT type=hidden name=resourceid onChange='checkinput("resourceid","assistantidspan")'>
             -->
            </wea:item>
            <wea:item><%=SystemEnv.getHtmlLabelName(15961,user.getLanguage())%></wea:item>
            <wea:item><BUTTON class=Calendar type="button" id=selectcontractdate onclick="getchangedate()"></BUTTON> 
              <SPAN id=changedatespan ><IMG src='/images/BacoError_wev8.gif' align=absMiddle></SPAN> 
              <input type="hidden" name="changedate" onChange='checkinput("changedate","changedatespan")'>
            </wea:item>
				<wea:item>支付工资</wea:item>
            <wea:item>
			<select id="issalary" name="issalary"> 
			   <option value="1">是</option> 
			   <option value="0">否</option>
			</select>
			</wea:item>
			<wea:item>离职类型</wea:item>
            <wea:item>
			<select id="dismissreason" name="dismissreason"> 
			   <option value="1001">主动离职</option>
			   <option value="1002">被动离职</option>
               <option value="1003">自离</option>
			</select>
			</wea:item>
			<wea:item>离职原因</wea:item>
            <wea:item>
			<select id="dismisstype" name="dismisstype"> 
			   <option value="1002">(主)个人及家庭</option>
               <option value="1003">(主)职业发展与选择</option>
               <option value="1004">(主)工作内容、环境与机制</option>
			   <option value="1005">(主)部门管理</option>
			   <option value="1006">(主)公司理念与文化</option>
			   <option value="1007">(主)薪资福利</option>
			   <option value="1008">(主)工作压力</option>
			   <option value="1010">(被)未通过试用期</option>
			   <option value="1011">(主)其他原因</option>
			   <option value="1012">(被)辞退</option>
			   <option value="1013">(被)劝退</option>
			   <option value="1014">(被)合同到期不续约</option>
			   <option value="1015">(自)自离</option>
			   <option value="1016">(自)报到当天自离</option>
			</select>
			</wea:item>
            <wea:item>离职备注<!--<%=SystemEnv.getHtmlLabelName(1978,user.getLanguage())%>--></wea:item>
            <wea:item>
              <textarea class=inputstyle rows=5 cols=40 name="changereason"></textarea>
            </wea:item>
<%if(software.equals("ALL") || software.equals("HRM")){%>          
            <wea:item><%=SystemEnv.getHtmlLabelName(6120,user.getLanguage())%></wea:item>
            <wea:item>
             <brow:browser viewType="0" name="changecontractid" browserValue="" 
                browserUrl="/systeminfo/BrowserMain.jsp?mouldID=hrm&url=/hrm/contract/contract/HrmContractBrowser.jsp?status=1"
                hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
                completeUrl="/data.jsp?type=HrmContract&whereClause=status=1" width="240px"
                browserSpanValue="">
               </brow:browser>                     
            </wea:item>
<%}%>
            <wea:item><%=SystemEnv.getHtmlLabelName(16077,user.getLanguage())%></wea:item>
            <wea:item>
	          <span> 
	            <brow:browser viewType="0" name="infoman" browserValue="" 
	              browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp"
	              hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
	              completeUrl="/data.jsp" linkUrl="javascript:openhrm($id$)" width="240px"
	              browserSpanValue=""></brow:browser>
	         	</span>
            <!-- 
              <BUTTON class=Browser type="button" onClick="onShowResource(infoman,infomanspan)">
	      </BUTTON>
	      <span id=infomanspan>
	      </span>
	      <INPUT class=inputstyle id=organizer type=hidden name=infoman >            
             -->
            </wea:item>
    	</wea:group>
    </wea:layout>
</FORM>
  
<SCRIPT language="javascript">
  function  getchangedate(){
	var returndate = window.showModalDialog("/systeminfo/Calendar.jsp",null,"dialogHeight:320px;dialogwidth:275px");

	if (returndate!=null&&returndate!=""){
	    changedatespan.innerHTML= returndate;
        resource.changedate.value=returndate;
	}else{    
           if (returndate==""){           
	       changedatespan.innerHTML= "<IMG src='/images/BacoError_wev8.gif' align=absMiddle>";
           resource.changedate.value=returndate;         
           }
         } 
}

function disModalDialogRtnM(url, inputname, spanname) {
	var id = window.showModalDialog(url);
	if (id != null) {
		if (wuiUtil.getJsonValueByIndex(id, 0) != "") {
			var ids = wuiUtil.getJsonValueByIndex(id, 0).substr(1);
			var names = wuiUtil.getJsonValueByIndex(id, 1).substr(1);

			jQuery(inputname).val(ids);
			var sHtml = "";
			var ridArray = ids.split(",");
			var rNameArray = names.split(",");

			linkurl = ""

			for ( var i = 0; i < ridArray.length; i++) {

				var curid = ridArray[i];
				var curname = rNameArray[i];

				sHtml += "<a tatrget='_blank' href=/hrm/resource/HrmResource.jsp?id=" + curid + ">" + curname + "</a>&nbsp;";
			}

			jQuery(spanname).html(sHtml);
		} else {
			jQuery(inputname).val("")
			jQuery(spanname).html("");
		}
	}
}

function onShowResource(tdname,inputename){
	var results = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp");
	if(results){
	  if(wuiUtil.getJsonValueByIndex(results,0)!=""){
	  	 jQuery($GetEle(tdname)).html("<a href='javascript:openhrm("+wuiUtil.getJsonValueByIndex(results,0)+")'>"+wuiUtil.getJsonValueByIndex(results,1)+"</a>");
	     jQuery("input[name='"+inputename+"']")[0].value=wuiUtil.getJsonValueByIndex(results,0);
	  }else{
	     jQuery($GetEle(tdname)).html("");
	     jQuery("input[name='"+inputename+"']").val("");
	  }
	}
}

function onShowResource1(inputname,spanname){
	disModalDialogRtnM("/systeminfo/BrowserMain.jsp?url=/hrm/resource/browser/dismiss/MutiResourceBrowser.jsp",inputname,spanname);
}

function onShowContract(){
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/contract/contract/HrmContractBrowser.jsp?status=1 ");
	if (data!=null){
		if (data.id!= ""){
			jQuery("#contractspan").html("<A href=javascript:openFullWindowForXtable('/hrm/contract/contract/HrmContractEdit.jsp?id="+data.id+"')>"+data.name+"</A>");
			jQuery("#changecontractid").val(data.id);
		}else{
			jQuery("#contractspan").html("");
			jQuery("#changecontractid").val("");
		}
	}
}
</SCRIPT>

<script language=javascript>
function doSave(obj) {
   if(check_form(document.resource,"resourceid,changedate"))
	{
	   obj.disabled=true;
	   document.resource.submit();
	}

}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</html>

