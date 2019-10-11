<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="CompanyComInfo" class="weaver.hrm.company.CompanyComInfo" scope="page" />
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<%

    int userid = user.getUID();

    String WLBM = Util.null2String(request.getParameter("WLBM")) ;//物料编码
	String WLMC = Util.null2String(request.getParameter("WLMC")) ;//物料名称
	String CWNY = Util.null2String(request.getParameter("CWNY")) ;//财务年月
	String CKID = Util.null2String(request.getParameter("CKID")) ;//财务年月
	//out.print("CWNY="+CWNY);
	
    String leave_pageId = "Goodbaby_Stock";
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
    String imagefilename = "/images/hdMaintenance_wev8.gif";
    String titlename = SystemEnv.getHtmlLabelName(21039,user.getLanguage())
            + SystemEnv.getHtmlLabelName(480, user.getLanguage())
            + SystemEnv.getHtmlLabelName(18599, user.getLanguage())
            + SystemEnv.getHtmlLabelName(352, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
%>
<BODY>
<div id="tabDiv">
            <span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>">
            <%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
    <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%=leave_pageId%>"/>
<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(527, user.getLanguage())+ ",javascript:onBtnSearchClick(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
<FORM id=weaver name=weaver method=post action="" >
    <table id="topTitle" cellpadding="0" cellspacing="0">
        <tr>
            <td></td>
            <td class="rightSearchSpan" style="text-align:right;">
                        <span id="advancedSearch" class="advancedSearch">
                        <%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%>
                        </span>
                <span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu">
                        </span>
            </td>
        </tr>
    </table>
    <div>
        <table width="100%" class="ListStyle" style="font-size: 8pt">
            <colgroup>
                <col width="10%"></col>
                <col width="5%"></col>
                <col width="10%"></col>
                <col width="5%"></col>
                <col width="60%"></col>
            </colgroup>
        </table>
    </div>
    <div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
        <wea:layout type="4col">
            <wea:group context="查询条件">
			
                <wea:item>物料名称</wea:item>
                <wea:item>
                    <input type="text" name="WLMC" style='width:80%' value="">
                </wea:item>
            </wea:group>

            <wea:group context="">
                <wea:item type="toolbar">
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(30947,user.getLanguage())%>" class="e8_btn_submit" onclick="onBtnSearchClick();"/>
                    <input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
                </wea:item>
            </wea:group>
        </wea:layout>
    </div>

</FORM>
<%
	
    String backfields = " d.id,d.wlmc,CASE d.rkly WHEN '0' THEN '入库' WHEN '1' THEN '出库' END as rkly,d.lch,"+
	"a.WLname,a.WLBM,c.requestmark,d.rkrq,d.rksj,d.rkjg,d.rksl,d.ylysl,(select b.ckmc from "+
	"uf_stocks b where b.id=d.CKID) as ckmc";
    String fromSql  = " from uf_stock d,uf_materialDatas a,workflow_requestbase c";
    String sqlWhere = " a.id = d.wlmc and c.requestid=d.lch and convert(varchar(7),d.rkrq) = '"+CWNY+"'";
    String orderby = " d.id asc" ;
    String tableString = "";
    String operateString= "";
	
    //物料编码
    if(!"".equals(WLBM)){
        sqlWhere += " and d.wlmc in( select id from uf_materialDatas where WLBM = '"+WLBM+"' )";
    }
    //物料名称
    if(!"".equals(WLMC)){
        sqlWhere += " and WLname = "+WLMC;
    }
	if(!"".equals(CKID)){
        sqlWhere += " and d.CKID = "+CKID;
    }
	//out.print("select " + backfields + fromSql + " where " + sqlWhere);

    tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(leave_pageId,user.getUID(),PageIdConst.HRM)+"\" pageId=\""+leave_pageId+"\">"+
            "      <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"d.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\" />"+
            operateString +
            "           <head>";
    tableString+= " <col width=\"10%\"  text=\"单据编号\" column=\"requestmark\" orderkey=\"requestmark\" />"+
            "       <col width=\"10%\"  text=\"物料名称\" column=\"WLname\" orderkey=\"WLname\"  />"+
            "       <col width=\"10%\"  text=\"物料代码\" column=\"WLBM\" orderkey=\"WLBM\" />"+
			"       <col width=\"12%\" text=\"仓库\" column=\"ckmc\" orderkey=\"ckmc\" />"+
            "       <col width=\"10%\" text=\"出/入库日期\" column=\"rkrq\" orderkey=\"rkrq\" />"+
            "       <col width=\"8%\" text=\"出/入库时间\" column=\"rksj\" orderkey=\"rksj\" />"+
            "       <col width=\"10%\"  text=\"出/入库数量\" column=\"rksl\" orderkey=\"rksl\" />"+
            "       <col width=\"10%\"  text=\"出/入库\" column=\"rkly\" orderkey=\"rkly\" />"+
            "       <col width=\"10%\"  text=\"入库价格\" column=\"rkjg\" orderkey=\"rkjg\" />"+
            "           </head>"+
            " </table>";
%>
<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run"  />
<script type="text/javascript">
    function onShowSubcompanyid1(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
        if (data!=null){
            if (data.id!= ""){
                jQuery("#subcompanyid1span").html(data.name);
                jQuery("#subcompanyid1").val(data.id);
                makechecked();
            }else{
                jQuery("#subcompanyid1span").html("");
                jQuery("#subcompanyid1").val("");
            }
        }
    }

    function onShowDepartmentid(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
        if (data!=null){
            if (data.id!= ""){
                jQuery("#departmentidspan").html(data.name);
                jQuery("#departmentid").val(data.id);
                makechecked();
            }else{
                jQuery("#departmentidspan").html("");
                jQuery("#departmentid").val("");
            }
        }
    }
   

   
    function onBtnSearchClick() {
        weaver.submit();
    }

    
</script>

<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>