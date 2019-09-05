<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="gcl.company.exception.YearCheckUtil" %>
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
    String titlename = "公司对外投资";
    String needfav = "1";
    String needhelp = "";
    String gsid = Util.null2String(request.getParameter("gsid"));
    SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	String nowyear = sf.format(new Date());  
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSGLXXK");
    String tablenameqcc = du.getBillTableName("GSQCCDWTZ");
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
                        <COL width="25%"/>
                        <COL width="25%"/>
                        <COL width="25%"/>
                        <COL width="25%"/>
                    </COLGROUP>
                    <!-- <TR class=Title>
                            <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
                        </TR>-->
                        <tr>
                            <td class="fname">公司名称</td>
                            <td class="fname">统一社会信用代码</td>
                            <td class="fname">投资比例</td>
                            <td class="fname">公司状态</td>
                        </tr>
                        <%
                            String gsmc = "";
                            String tyshxydm = "";
                            String tzbl = "";
                            String gszt = "";
                            sql = "select b.id,a.id as tzfid,a.gsmc,a.tyshxydm,a.zczbwy,to_char(b.tzbl)||'%' as tzbl,a.zcrq,(select c.selectname from workflow_billfield t, workflow_bill b,workflow_selectitem c where t.billid=b.id and c.fieldid=t.id  and b.tablename='"+tablename+"' and t.fieldname='gszt' and c.selectvalue=a.gszt) as gszt  from "+tablename+" a,"+tablename+"_dt1 b  where a.id=b.mainid  and b.tzf ='"+gsid+"' order by a.gsmc asc";
                            rs.execute(sql);
                            while(rs.next()){
                                gsmc = Util.null2String(rs.getString("gsmc"));
                                tyshxydm = Util.null2String(rs.getString("tyshxydm"));
                                tzbl = Util.null2String(rs.getString("tzbl"));
                                gszt = Util.null2String(rs.getString("gszt"));

                        %>
                            <tr>
                            <td class=fvalue><SPAN  style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=gsmc%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=tyshxydm%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=tzbl%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=gszt%></SPAN></td>
                           
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
                        <COL width="25%"/>
                        <COL width="25%"/>
                        <COL width="25%"/>
                        <COL width="25%"/>
                    </COLGROUP>
                    <!-- <TR class=Title>
                            <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
                        </TR>-->
                        <tr>
                            <td class="fname">公司名称</td>
                            <td class="fname">统一社会信用代码</td>
                            <td class="fname">投资比例</td>
                            <td class="fname">公司状态</td>
                        </tr>
                        <%
                            String gsmc1 = "";
                            String tyshxydm1 = "";
                            String tzbl1 = "";
                            String gszt1 = "";
                            sql = "select name,creditcode,fundedratio,status from "+tablenameqcc+" where gsid='"+gsid+"' and status<>'注销' order by name asc";
                            rs.execute(sql);
                            while(rs.next()){
                                gsmc1 = Util.null2String(rs.getString("name"));
                                tyshxydm1 = Util.null2String(rs.getString("creditcode"));
                                tzbl1 = Util.null2String(rs.getString("fundedratio"));
                                gszt1 = Util.null2String(rs.getString("status"));

                        %>
                            <tr>
                            <td class=fvalue><SPAN  style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=gsmc1%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=tyshxydm1%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=tzbl1%></SPAN></td>
                            <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=gszt1%></SPAN></td>
                           
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