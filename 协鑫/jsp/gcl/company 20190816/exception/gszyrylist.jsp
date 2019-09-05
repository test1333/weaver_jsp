<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="gcl.company.CompanyChangeUtil" %>
<%@ page import="java.util.Date" %>
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
    <link rel="stylesheet" type="text/css" href="/css/crmcss/lanlv.css" /></p>
    <script type="text/css">

    </script>
</head>
<%
    int emp_id = user.getUID();
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "公司主要人员信息";
    String needfav = "1";
    String needhelp = "";
    String gsid = Util.null2String(request.getParameter("gsid"));
    SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	String nowyear = sf.format(new Date());  
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    String tablenameqcc = du.getBillTableName("GSQCCZYRY");
    CompanyChangeUtil ccu = new CompanyChangeUtil();
    String sql = "";
    
   
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
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
                         
    <table class=Viewform id="searchTable" >
    <colgroup><col width="45%"></col><col width="10%"></col><col width="45%"></col></colgroup>
        <tbody>
        <tr>
            <td valign="top"><br />
            <div align="center"><font class="reqname">EC信息</font></div>
             <table class=Viewform >
                    <tbody>
                    <COLGROUP>
                        <COL width="15%"/>
                        <COL width="35%"/>
                        <COL width="35%"/>
                        <COL width="15%"/>
                    </COLGROUP>
                    <!-- <TR class=Title>
                            <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
                        </TR>-->
                        <tr>
                            <td ></td>
                            <td class="fname">职务</td>
                            <td class="fname">姓名</td>
                            <td></td>
                        </tr>
                        <%
                           String dsz = "";
                           String zjl = "";
                           String cwfzr = "";
                           String fddbr = "";
                           String fdsz = "";
                           sql = "select dsz,zjl,cwfzr,fddbr,fdsz from "+tablename+" where id="+gsid;
                           rs.execute(sql);
                           if(rs.next()){
                               dsz = ccu.getDJGXM(Util.null2String(rs.getString("dsz")));
                               zjl = ccu.getDJGXM(Util.null2String(rs.getString("zjl")));
                               cwfzr = ccu.getDJGXM(Util.null2String(rs.getString("cwfzr")));
                               fddbr = ccu.getDJGXM(Util.null2String(rs.getString("fddbr")));
                               fdsz = Util.null2String(rs.getString("fdsz"));
                           }

                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=dsz%></SPAN></td>
                                <td ></td>                           
                             </tr>
                             <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">副董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=fdsz%></SPAN></td>
                                <td ></td>                           
                             </tr>
                             <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">总经理</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=zjl%></SPAN></td>
                                <td ></td>                           
                             </tr>
                             <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">法定代表人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=fddbr%></SPAN></td>
                                <td ></td>                           
                             </tr>
                             <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">财务负责人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=cwfzr%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            sql = "select * from "+tablename+"_dt2 where mainid="+gsid;
                            rs.execute(sql);
                            while(rs.next()){
                                String ds = ccu.getDJGXM(Util.null2String(rs.getString("ds")));
                        %>
                                <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">董事</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=ds%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            sql = "select * from "+tablename+"_dt3 where mainid="+gsid;
                            rs.execute(sql);
                            while(rs.next()){
                                String js = ccu.getDJGXM(Util.null2String(rs.getString("js")));
                        %>
                                <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">监事</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=js%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                        %>
                    
                        
                        
                        </table>
            </td>
            <td>&nbsp;</td>
            <td valign="top"><br />
            <div align="center"><font class="reqname">企查查信息</font></div>
             <table class=Viewform >
                    <tbody>
                    <COLGROUP>
                        <COL width="15%"/>
                        <COL width="35%"/>
                        <COL width="35%"/>
                        <COL width="15%"/>
                    </COLGROUP>
                    <!-- <TR class=Title>
                            <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
                        </TR>-->
                        <tr>
                            <td ></td>
                            <td class="fname">职务</td>
                            <td class="fname">姓名</td>
                            <td></td>
                        </tr>
                        <%
                            String country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='0'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));
                                country = "1";

                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            if("0".equals(country)){
                          %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%       
                            }
                            country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='1'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));
                                country = "1";
                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">副董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            if("0".equals(country)){
                          %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">副董事长</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%       
                            }
                            country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='3'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));
                                country = "1";
                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">总经理</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            if("0".equals(country)){
                          %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">总经理</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%       
                            }
                            country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='2'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));
                                country = "1";
                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">法定代表人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                             if("0".equals(country)){
                          %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">法定代表人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%       
                            }
                            country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='4'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));
                                country = "1";
                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">财务负责人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            if("0".equals(country)){
                          %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">财务负责人</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%       
                            }
                            country = "0";
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='5'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));

                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">董事</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                            sql = "select xm from "+tablenameqcc+" where gsid='"+gsid+"' and lx='6'";
                            rs.execute(sql);
                            while(rs.next()){
                                String xm = Util.null2String(rs.getString("xm"));

                        %>
                            <tr>
                                <td ></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0">监事</SPAN></td>
                                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xm%></SPAN></td>
                                <td ></td>                           
                             </tr>
                        <%
                            }
                        %>
                    
                        
                        
                        </table>
            </td>
        </tr>
       

       </tbody>   
    </table>
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
    function refresh() {
        window.location.reload();
    }
    
    function donj(njid){
       var opts = {
            _dwidth: '550px',
            _dheight: '300px',
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
       var result= window.showModalDialog("/gcl/company/exception/update-gsnj-info.jsp?njid="+njid,
           "", "addressbar=no;status=0;scroll=" + opts._scroll + ";dialogHeight=" + opts._dheight + ";dialogWidth=" + opts._dwidth + ";dialogLeft=" + opts.left + ";dialogTop=" + opts.top + ";resizable=0;center=1;");
        if(result){
            if(result == "1"){               
                window.location.reload();
            }
        }
    }

   

   
</script>
</BODY>
</HTML>