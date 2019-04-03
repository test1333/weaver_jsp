<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.DesUtil"%>
<%@ page import="org.json.JSONObject" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<jsp:useBean id="CptFieldComInfo" class="weaver.cpt.util.CptFieldComInfo" scope="page" />
<jsp:useBean id="CptCardGroupComInfo" class="weaver.cpt.util.CptCardGroupComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%

if(!HrmUserVarify.checkUserRight("Cpt:LabelPrint", user)){
    		response.sendRedirect("/notice/noright.jsp");
    		return;
}
String isclose = Util.null2String(request.getParameter("isclose"));
String isDialog = Util.null2String(request.getParameter("isdialog"));
int colnum = Util.getIntValue(request.getParameter("colnum"), 1);
int forcenewpage = Util.getIntValue(request.getParameter("forcenewpage"), 0);
%>
<html><head>

<script language="javascript" src="/js/weaver_wev8.js"></script>
<SCRIPT language="javascript" src="/cpt/js/common_wev8.js"></script>

<script language=javascript src="/js/weaver_wev8.js"></script>
<jsp:useBean id="RecordSetaaa" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="PrintUtil" class="weaver.cpt.util.PrintUtil" scope="page" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.printsmall{
         -webkit-transform-origin: 0 0 0;
-webkit-transform: scale(0.5,0.3);
}
	html, body {
    	-webkit-text-size-adjust: none;
	}
	
    *{float:none;}
    #container{float: none;}
    .tab-request{position: relative;float: none;padding-bottom: 20px;padding-top: 20px;}
    .tab-request-first{position: relative;float: none;padding-bottom: 20px;}
	.tab-line{padding-left:10px;padding-right: 10px;}
    .tab-line hr {height:1px;}
    .page-break {page-break-after: always;}
    .pholder {
        display:none;
    }
    
	table {
		table-layout: fixed;
	}


	td {
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}

    table,table tr th, table tr td { border:1px solid; }
        table { border-collapse: collapse;}  
    
.small-font01{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.1);display:block;}
.small-font02{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.2);display:block;}
.small-font03{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.3);display:block;}
.small-font04{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.4);display:block;}
.small-font05{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.5);display:block;}
.small-font06{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.6);display:block;}
.small-font07{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.7);display:block;}
.small-font08{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.8);display:block;}
.small-font09{font-size:12px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.9);display:block;}

.small-font011{font-size:1px;  display: inline;}
.small-font021{font-size:2px;  display: inline;}
.small-font031{font-size:4px;  display: inline;}
.small-font041{font-size:4px; display: inline;}
.small-font051{font-size:8px;  -webkit-transform-origin-x: 0; -webkit-transform: scale(0.6);display:block;white-space:nowrap;}
.small-font061{font-size:6px; display: inline;}
.small-font071{font-size:7px; }
.small-font081{font-size:8px; }
.small-font091{font-size:9px;  }
</style>

<%--打印的时候，一些元素不打印 --%>
<style type="text/css" media="print">
    .tab-line{display: none;}
    .tab-request{padding-bottom: 0px;padding-top: 0px;}
    .tab-request-first{padding-bottom: 0px;}
.small-font01{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.1);}
.small-font02{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.2);}
.small-font03{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.3);}
.small-font04{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.4);}
.small-font05{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.5);}
.small-font06{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.6);}
.small-font07{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.7);}
.small-font08{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.8);}
.small-font09{font-size:12px; -webkit-transform-origin-x: 0; -webkit-transform: scale(0.9);}
</style>

<script type="text/javascript">
var dialog = parent.parent.getDialog(parent);
var parentWin = parent.parent.getParentWindow(parent);
if("<%=isclose%>"=="1"){
	parentWin._table.reLoad();
	parentWin.closeDialog();	
}
</script>
</head>
<%

String imagefilename = "/images/hdMaintenance_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(16450,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<body id="flowbody" style="overflow:auto">
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(257,user.getLanguage())+",javascript:doPrint(),_top}" ;
    RCMenuHeight += RCMenuHeightStep ;
    /*for (int i = 1; i <= 8; i++) {
        RCMenu += "{"+i+SystemEnv.getHtmlLabelNames("18621,19407", user.getLanguage())+",javascript:toggleCol("+i+"),_self}" ;
        RCMenuHeight += RCMenuHeightStep ;
    }*/

    RCMenu += "{"+SystemEnv.getHtmlLabelName(20756,user.getLanguage())+",javascript:printSet(),_top}" ;
    RCMenuHeight += RCMenuHeightStep ;



%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table id="topTitle" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		</td>
		<td class="rightSearchSpan" style="text-align:right;">
			<input type=button class="e8_btn_top" onclick="doPrint();" value="<%=SystemEnv.getHtmlLabelName(257, user.getLanguage())%>" />
			<input type=button class="e8_btn_top" onclick="printSet();" value="<%=SystemEnv.getHtmlLabelName(20756, user.getLanguage())%>" />
			<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
		</td>
	</tr>
</table>
    <div class="printsmall">
        <%
            String multirequestid = Util.null2String(request.getParameter("customerids"));
            String contents="";
            int mouldid=-1;
            RecordSetaaa.executeSql("select mouldtext from CPT_PRINT_Mould where id="+mouldid);
            if (RecordSetaaa.next()) {
                contents=RecordSetaaa.getString("mouldtext");
            }

            out.println(PrintUtil.parse(contents,user,multirequestid,request));
		//	System.out.println(PrintUtil.parse(contents,user,multirequestid,request));

        %>
    </div>
<form id="weaver" name="weaver" action="printview.jsp">
    <input type="hidden" name="isdialog" id="isdialog" value="<%=isDialog %>" />
    <input type="hidden" name="customerids" id="customerids" value="<%=multirequestid %>" />
    <input type="hidden" name="colnum" id="colnum" value="<%=colnum %>" />
    <input type="hidden" name="forcenewpage" id="forcenewpage" value="<%=forcenewpage %>" />

</form>
<script language="javascript">



function doPrint(){
    hideRightClickMenu();  //隐藏右键菜单
    window.print();
}
function printSet() {
    var url="/cpt/print/printset.jsp?isdialog=1";
    var title="<%=SystemEnv.getHtmlLabelNames("20756",user.getLanguage())%>";
    openDialog(url,title,600,400,true,false);
}

function toggleCol(colnum){
    jQuery("#colnum").val(colnum);
    weaver.submit();
}



</script>
<%if(false && "1".equals(isDialog)){ %>
<div class="tab-line" style="height: 50px;"></div>
<div id="zDialog_div_bottom" class="zDialog_div_bottom" >
	<wea:layout needImportDefaultJsAndCss="false">
			<wea:group context=""  attributes="{\"groupDisplay\":\"none\"}">
				<wea:item type="toolbar">
					<input type="button" value="<%=SystemEnv.getHtmlLabelName(309,user.getLanguage())%>" id="zd_btn_cancle"  class="zd_btn_cancle" onclick="parentWin.closeDialog();">
				</wea:item>
			</wea:group>
		</wea:layout>
</div>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			resizeDialog(document);
		});
	</script>
<%} %>
</body>