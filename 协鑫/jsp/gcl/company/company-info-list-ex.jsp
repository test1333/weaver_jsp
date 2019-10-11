<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="gcl.company.CompanyChangeUtil" %>
<%@ page import="gcl.company.CompanyAuthorityUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
    <link rel="stylesheet" type="text/css" href="/gcl/company/style/company.css"> 
    <script type="text/css">

    </script>
</head>
<%
    int emp_id = user.getUID();
   
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
    int perpage = 10;
    String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "公司预警信息查询";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    String tablenameDJG = du.getBillTableName("DJG");
    String formid = "";
    String modeid = "";
    String sql = "select id from workflow_bill where tablename='" + tablename + "'";
    rs.executeSql(sql);
    if (rs.next()) {
        formid = Util.null2String(rs.getString("id"));
    }
    sql = "select id from modeinfo where  formid=" + formid;
    rs.executeSql(sql);
    if (rs.next()) {
        modeid = Util.null2String(rs.getString("id"));
    }
    String ishide="";
    String tyshxydm = Util.null2String(request.getParameter("tyshxydm"));
    String gsmc = Util.null2String(request.getParameter("gsmc"));
    String gslx = Util.null2String(request.getParameter("gslx"));
    String bgdz = Util.null2String(request.getParameter("bgdz"));
    String fddbr = Util.null2String(request.getParameter("fddbr"));
    String zczbwy = Util.null2String(request.getParameter("zczbwy"));
    String gszt = Util.null2String(request.getParameter("gszt"));
    String ds = Util.null2String(request.getParameter("ds"));
    String js = Util.null2String(request.getParameter("js"));
    String zjl = Util.null2String(request.getParameter("zjl"));
    String frbk = Util.null2String(request.getParameter("frbk"));
    String frbkname = "";
    String glbkname = "";
    String glbk = Util.null2String(request.getParameter("glbk"));
    String jyfw = Util.null2String(request.getParameter("jyfw"));
    String city = Util.null2String(request.getParameter("city"));
    String cityname = "";
    String yjlb = Util.null2String(request.getParameter("yjlb"));
    String yjlbname = "";
    CompanyChangeUtil ccu = new CompanyChangeUtil();
    cityname = ccu.getCityName(city);
    frbkname = ccu.getFrbk(frbk);
    glbkname = ccu.getGlbk(glbk);
    yjlbname = ccu.getYjlb(yjlb);
    CompanyAuthorityUtil cau = new CompanyAuthorityUtil();
    String ryid = emp_id+"";
    String bjyjlbids = "";
    String ckyjlbids = "";
    if(!"1".equals(ryid)){
        bjyjlbids = cau.getEditDataLbId(ryid);
        ckyjlbids = cau.getViewDataLbId(ryid);
    }
    //out.print("bjyjlbids:"+bjyjlbids);
   // out.print("ckyjlbids:"+ckyjlbids);
   String yjlbids = ckyjlbids;
   if(!"".equals(bjyjlbids)){
       if(!"".equals(yjlbids)){
           yjlbids = yjlbids+","+bjyjlbids;
       }else{
           yjlbids = bjyjlbids;
       }
   }
   if (!HrmUserVarify.checkUserRight("CompanyInfo:Query", user)&&"".equals(yjlbids)){
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:document.weaver.submit(),_top} ";

    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{"+"新建"+",javascript:addinfo(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+"导出Excel"+",javascript:_xtable_getAllExcel(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{刷新,javascript:refresh(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
        <col width="10">
        <col width="">
        <col width="10">
</colgroup>
        <tr>
            <td height="10" colspan="3"></td>
        </tr>
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                         
<FORM id=weaver name=weaver action="company-info-list-ex.jsp" method=post >
    <input type="hidden" name="ishide" id="ishide" value="<%=ishide %>" />
    <table class=Viewform id="searchTable" style="display:<%="1".equals(ishide)?"none":"" %>">
        <tbody>
        <COLGROUP>
            <COL width="15%">
            <COL width="35%">
            <COL width="15%">
            <COL width="35%">

           <!-- <TR class=Title>
                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
            </TR>-->
            <TR class=Spacing style="height:1px;"> <TD class=Line1 colSpan=4 ></TD> </TR>
            <tr>
                  <TD >统一社会信用代码</TD>
                    <td class=Field><input class=inputstyle id='tyshxydm' name=tyshxydm size="20" value="<%=tyshxydm%>"></td>
                    <TD >名称</TD>
                    <td class=Field><input class=inputstyle id='gsmc' name=gsmc size="20" value="<%=gsmc%>">
                    </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                 <TD >公司类型</TD>
                <td class=Field>
                    <select class="InputStyle styled" name="gslx" id="gslx">
							<option value="" <%if("".equals(gslx)){%> selected<%} %>>
								<%=""%></option>
							<%
								sql = "select tc.selectname,tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='"+tablename+"' and ta.fieldname='gslx' and tc.cancel='0' order by listorder asc";
								rs.executeSql(sql);
								while(rs.next()){
									String selectname = Util.null2String(rs.getString("selectname"));
									String selectvalue = Util.null2String(rs.getString("selectvalue"));
							%>
								<option value="<%=selectvalue%>" <%if(selectvalue.equals(gslx)){%> selected<%} %>>
								<%=selectname%></option>
							<%
								}
							%>
					</select>
                </td>
                <TD>住所</TD>
                <td class=Field><input class=inputstyle id='bgdz' name=bgdz size="20" value="<%=bgdz%>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
               <TD>法定代表人</TD>
                <td class=Field><input class=inputstyle id='fddbr' name=fddbr size="20" value="<%=fddbr%>"></td>
                <TD>注册资本</TD>
                <td class=Field><input class=inputstyle id='zczbwy' name=zczbwy size="20" value="<%=zczbwy%>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <TD>公司状态</TD>
                <td class=Field>
               <select class="InputStyle styled" name="gszt" id="gszt">
							<option value="" <%if("".equals(gszt)){%> selected<%} %>>
								<%=""%></option>
							<%
								sql = "select tc.selectname,tc.selectvalue from workflow_billfield ta, workflow_bill tb,workflow_selectitem tc where ta.billid=tb.id and tc.fieldid=ta.id  and tb.tablename='"+tablename+"' and ta.fieldname='gszt' and tc.cancel='0' order by listorder asc";
								rs.executeSql(sql);
								while(rs.next()){
									String selectname = Util.null2String(rs.getString("selectname"));
									String selectvalue = Util.null2String(rs.getString("selectvalue"));
							%>
								<option value="<%=selectvalue%>" <%if(selectvalue.equals(gszt)){%> selected<%} %>>
								<%=selectname%></option>
							<%
								}
							%>
					</select>
                </td>
                <TD>董事</TD>
                <td class=Field><input class=inputstyle id='ds' name=ds size="20" value="<%=ds%>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
               <TD>监事</TD>
                <td class=Field><input class=inputstyle id='js' name=js size="20" value="<%=js%>"></td>
                <TD>总经理</TD>
                <td class=Field><input class=inputstyle id='zjl' name=zjl size="20" value="<%=zjl%>">
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
               <TD>法人板块</TD>
                <td class=Field>
                 <BUTTON class=Browser type="button" onClick="onShowBrowserFrbk()">
                  </BUTTON>
                 <SPAN id=frbkspan><%=frbkname%></SPAN>
                 <INPUT id=frbk type=hidden name=frbk temptitle="法人板块" viewtype="0"
                                                         value="<%=frbk%>"> 
                </td>
                <TD>管理板块</TD>
                <td class=Field>
                 <BUTTON class=Browser type="button" onClick="onShowBrowserGlbk()">
                  </BUTTON>
                 <SPAN id=glbkspan><%=glbkname%></SPAN>
                 <INPUT id=glbk type=hidden name=glbk temptitle="管理板块" viewtype="0"
                                                         value="<%=glbk%>"> 
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>

            <tr>
                <TD>经营范围</TD>
                <td class=Field><input class=inputstyle id='jyfw' name=jyfw size="20" value="<%=jyfw%>"></td>
                <TD>城市</TD>
                <td class=Field>
                 <BUTTON class=Browser type="button" onClick="onShowBrowserCity()">
                  </BUTTON>
                 <SPAN id=cityspan><%=cityname%></SPAN>
                 <INPUT id=city type=hidden name=city temptitle="城市" viewtype="0"
                                                         value="<%=city%>"> 
                </td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>
               <TD>板块</TD>
                <td class=Field>
                 <BUTTON class=Browser type="button" onClick="onShowBrowserYjlb()">
                  </BUTTON>
                 <SPAN id=yjlbspan><%=yjlbname%></SPAN>
                 <INPUT id=yjlb type=hidden name=yjlb temptitle="一级类别" viewtype="0"
                                                         value="<%=yjlb%>"> 
                </td>
                <td></td>
                <td></td>
            </tr>
            <TR style="height:1px;"> <TD class=Line colSpan=4></TD> </TR>
    </table>
</FORM>
<div >
    <button onclick="toggle(this)" id="ishideBtn"><%="1".equals(ishide)?"显示条件":"隐藏条件" %></button>
</div>

                <%
                    String backfields = " id,yjlb,tyshxydm,gsmc as mc,(select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='gslx' and c.selectvalue=a.gslx ) as gslx,bgdz,(select xm from "+tablenameDJG+" where id=a.fddbr) as fddbr,zczbwy,zcrq,djgexp as djg,gsmcexp as gsmc,dzycexp as dzyc,id as lxr,njexp as nj,dwtzexp as dwtj,flwsexp as flws,id as cz,zcdz";
                        String fromSql = " from "+tablename+" a ";
                    String sqlWhere = " 1=1 and nvl(zt,0)='1'";
                    if(!"1".equals(ryid)){
                        if(!"".equals(yjlbids)){
                            sqlWhere = sqlWhere + " and yjlb in ("+yjlbids+")";
                        }else{
                            sqlWhere = sqlWhere + " 1=2 ";
                        }
                    }
                    if(!"".equals(tyshxydm)){
                        sqlWhere = sqlWhere + " and upper(tyshxydm) like upper('%"+tyshxydm+"%')";
                    }
                    if(!"".equals(gsmc)){
                        sqlWhere = sqlWhere + " and upper(gsmc) like upper('%"+gsmc+"%')";
                    }
                    if(!"".equals(gslx)){
                        sqlWhere = sqlWhere + " and gslx='"+gslx+"'";
                    }
                    if(!"".equals(bgdz)){
                        sqlWhere = sqlWhere + " and upper(bgdz) like upper('%"+bgdz+"%')";
                    }
              
                     if(!"".equals(fddbr)){
                        sqlWhere = sqlWhere + " and fddbr=(select id from "+tablenameDJG+" where xm='"+fddbr+"') ";
                    }
                     if(!"".equals(zczbwy)){
                        sqlWhere = sqlWhere + " and zczbwy='"+zczbwy+"'";
                    }
                     if(!"".equals(gszt)){
                        sqlWhere = sqlWhere + " and gszt='"+gszt+"'";
                    }
                     if(!"".equals(ds)){
                        sqlWhere = sqlWhere + " and exists(select 1 from "+tablename+"_dt2 where mainid=a.id and ds=(select id from "+tablenameDJG+" where xm='"+ds+"')) ";
                    }
                    if(!"".equals(js)){
                        sqlWhere = sqlWhere + " and exists(select 1 from "+tablename+"_dt3 where mainid=a.id and js=(select id from "+tablenameDJG+" where xm='"+js+"')) ";
                    }
                     if(!"".equals(zjl)){
                        sqlWhere = sqlWhere + " and zjl=(select id from "+tablenameDJG+" where xm='"+zjl+"') ";
                    }
                     if(!"".equals(frbk)){
                        sqlWhere = sqlWhere + " and frbk='"+frbk+"' ";
                    }
                    if(!"".equals(glbk)){
                        sqlWhere = sqlWhere + " and glbk='"+glbk+"'";
                    }
                    if(!"".equals(jyfw)){
                        sqlWhere = sqlWhere + " and upper(jyfw) like upper('%"+jyfw+"%')";
                    }
                     if(!"".equals(city)){
                        sqlWhere = sqlWhere + " and city='"+city+"'";
                    }
                    if(!"".equals(yjlb)){
                        sqlWhere = sqlWhere + " and yjlb='"+yjlb+"'";
                    }
                    //out.println("select "+ backfields + fromSql + " where " + sqlWhere);
                    if("".equals(bjyjlbids)){
                        bjyjlbids ="-101";
                    }
                    String otherpara1 = "column:id+column:yjlb+"+ryid+"+"+bjyjlbids;
                   // out.print("otherpara1:"+otherpara1);
                    String orderby = " id  ";
                    String tableString = "";

                    tableString = " <table  tabletype=\"none\" pagesize=\"" + perpage + "\" >" +
                            "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"id\" sqlsortway=\"desc\" />" +
                            "			<head>" +
                            " 	<col width=\"8%\" text=\"统一社会信用代码\" column=\"tyshxydm\" orderkey=\"tyshxydm\" />" +
                            " 	<col width=\"14%\" text=\"名称\" column=\"mc\" orderkey=\"mc\" linkvaluecolumn=\"id\" linkkey=\"billid\" href=\"/formmode/view/AddFormMode.jsp?type=0&amp;modeId=" + modeid + "&amp;formId=" + formid + "&amp;opentype=0\" target=\"_fullwindow\"/>" +
                            " 	<col width=\"6%\" text=\"公司类型\" column=\"gslx\" orderkey=\"gslx\" />" +
                            " 	<col width=\"10%\" text=\"住所\" column=\"zcdz\" orderkey=\"zcdz\"  />" +
                            " 	<col width=\"8%\" text=\"法定代表人\" column=\"fddbr\" orderkey=\"fddbr\"  />" +
                            " 	<col width=\"8%\" text=\"注册资本（万元）\" column=\"zczbwy\" orderkey=\"zczbwy\"  />" +
                            " 	<col width=\"6%\" text=\"成立日期\" column=\"zcrq\" orderkey=\"zcrq\" />" +
                            " 	<col width=\"5%\" text=\"董监高\" column=\"djg\" orderkey=\"djg\" otherpara=\"column:id\" transmethod=\"gcl.company.CompanyTransMethod.getDjg\"/>" +
                            " 	<col width=\"5%\" text=\"公司名称\" column=\"gsmc\" orderkey=\"gsmc\" otherpara=\"column:id\" transmethod=\"gcl.company.CompanyTransMethod.getGSMC\"/>" +
                            " 	<col width=\"5%\" text=\"地址异常\" column=\"dzyc\" orderkey=\"dzyc\" otherpara=\"column:id\" transmethod=\"gcl.company.CompanyTransMethod.getDzyc\"/>" +
                            //" 	<col width=\"5%\" text=\"联系人\" column=\"lxr\" orderkey=\"lxr\" transmethod=\"gcl.company.CompanyTransMethod.getNj\"/>" +
                            " 	<col width=\"5%\" text=\"年检\" column=\"nj\" orderkey=\"nj\" otherpara=\"column:id\" transmethod=\"gcl.company.CompanyTransMethod.getNj\"/>" +
                            " 	<col width=\"5%\" text=\"对外投资\" column=\"dwtj\" orderkey=\"dwtj\" otherpara=\"column:id\" transmethod=\"gcl.company.CompanyTransMethod.getDwtz\"/>" +
                            " 	<col width=\"5%\" text=\"法律文书\" column=\"flws\" orderkey=\"flws\" />" +
                            " 	<col width=\"5%\" text=\"操作\" column=\"cz\" orderkey=\"cz\" otherpara=\""+otherpara1+"\" transmethod=\"gcl.company.CompanyTransMethod.getCzTrans\" />" +
 

                            "			</head>" +
                            "</table>";
                    //showExpExcel="true"
                %>
            <div>
                <wea:SplitPageTag tableString="<%=tableString%>" mode="run"   isShowBottomInfo="true"/>
            </div>
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
<script type="text/javascript">
function changedate(dataid){
   window.open("/gcl/company/change/wui/main.jsp?dataid="+dataid,"_blank");

    //this.openFullWindowForXtable('/gcl/company/change/wui/main.jsp?dataid='+dataid);
}
function showexp(type,dataid){
      if(type == "0"){
          this.openFullWindowForXtable('/gcl/company/exception/gszyrylist.jsp?gsid='+dataid);
          return;
      }else if(type == "1"){
          this.openFullWindowForXtable('/gcl/company/exception/gsmc-ex.jsp?gsid='+dataid);
          return;
      }else if(type == "2"){
          this.openFullWindowForXtable('/gcl/company/exception/address-ex.jsp?gsid='+dataid);
          return;
      }else if(type == "4"){
          this.openFullWindowForXtable('/gcl/company/exception/gsnj-info.jsp?gsid='+dataid);
          return;
      }else if(type == "5"){
          this.openFullWindowForXtable('/gcl/company/exception/gsdwtzlist.jsp?gsid='+dataid);
          return;
      }
}
function showflinfo(dataid){
     alert(dataid);
}

function addinfo(){
    window.open("/formmode/view/AddFormMode.jsp?modeId=<%=modeid%>&formId=<%=formid%>&type=1","_blank")
}
function toggle(obj){
    if(jQuery("#ishide").val()=="1"){
        jQuery("#ishide").val("");
        jQuery("#ishideBtn").html("隐藏条件");
        jQuery("#searchTable").show();

    }else{
        jQuery("#ishide").val("1");
        jQuery("#ishideBtn").html("显示条件");
        jQuery("#searchTable").hide();
    }
}
    function refresh() {
        window.location.reload();
    }

   

    function downloadxml() {
    }

    function onShowResourceID(inputname, spanname) {
        var opts = {
            _dwidth: '550px',
            _dheight: '550px',
            _url: 'about:blank',
            _scroll: "no",
            _dialogArguments: "",
            _displayTemplate: "#b{name}",
            _displaySelector: "",
            _required: "no",
            _displayText: "",
            value: ""
        };
        var iTop = (window.screen.availHeight - 30 - parseInt(opts._dheight)) / 2 + "px"; //获得窗口的垂直位置;
        var iLeft = (window.screen.availWidth - 10 - parseInt(opts._dwidth)) / 2 + "px"; //获得窗口的水平位置;
        opts.top = iTop;
        opts.left = iLeft;
        datas = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp",
            "", "addressbar=no;status=0;scroll=" + opts._scroll + ";dialogHeight=" + opts._dheight + ";dialogWidth=" + opts._dwidth + ";dialogLeft=" + opts.left + ";dialogTop=" + opts.top + ";resizable=0;center=1;");
        if (datas) {
            if (datas.id != "") {
                $("#" + spanname).html("<A href='javascript:openhrm(" + datas.id + ");' onclick='pointerXY(event);'>" + datas.name + "</A>");
                $("input[name=" + inputname + "]").val(datas.id);
            } else {
                $("#" + spanname).html("");
                $("input[name=" + inputname + "]").val("");
            }
        }
    }
    function onShowBrowserCity() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.city&selectedids=" + jQuery("#city").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "" && data.id !="0") {
                jQuery("#cityspan").html(data.name);
                jQuery("input[name=city]").val(data.id);
            } else {
                jQuery("#cityspan").html("");
                jQuery("input[name=city]").val("");
            }
        }
    }
    function onShowBrowserCity() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.city&selectedids=" + jQuery("#city").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "" && data.id !="0") {
                jQuery("#cityspan").html(data.name);
                jQuery("input[name=city]").val(data.id);
            } else {
                jQuery("#cityspan").html("");
                jQuery("input[name=city]").val("");
            }
        }
    }
    function onShowBrowserGlbk() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.glbk&selectedids=" + jQuery("#glbk").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "" && data.id !="0") {
                jQuery("#glbkspan").html(data.name);
                jQuery("input[name=glbk]").val(data.id);
            } else {
                jQuery("#glbkspan").html("");
                jQuery("input[name=glbk]").val("");
            }
        }
    }
     function onShowBrowserFrbk() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.frbk&selectedids=" + jQuery("#frbk").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "" && data.id !="0") {
                jQuery("#frbkspan").html(data.name);
                jQuery("input[name=frbk]").val(data.id);
            } else {
                jQuery("#frbkspan").html("");
                jQuery("input[name=frbk]").val("");
            }
        }
    }
    function onShowBrowserYjlb() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.yjlb&selectedids=" + jQuery("#yjlb").val());
        if (data != null) {
            // alert(data.id);
            // alert(data.name);
            if (data.id != "" && data.id !="0") {
                jQuery("#yjlbspan").html(data.name);
                jQuery("input[name=yjlb]").val(data.id);
            } else {
                jQuery("#yjlbspan").html("");
                jQuery("input[name=yjlb]").val("");
            }
        }
    }
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
</BODY>
</HTML>