<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.hrm.HrmUserVarify" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="gcl.company.CompanyAuthorityUtil" %>
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
    String titlename = "公司年检信息";
    String needfav = "1";
    String needhelp = "";
    DocUtil du = new DocUtil();
    String tablename = du.getBillTableName("GSNJJLB");
    String gsid = Util.null2String(request.getParameter("gsid"));
    SimpleDateFormat sf = new SimpleDateFormat("yyyy");
	String nowyear = sf.format(new Date());
    YearCheckUtil ycu = new YearCheckUtil();
    String njids = ycu.getNjJLIds(gsid);
    String sql = "";
    CompanyAuthorityUtil cau = new CompanyAuthorityUtil();
    String ryid = emp_id+"";
    String bjyjlbids = "";
    if(!"1".equals(ryid)){
        bjyjlbids = cau.getEditDataLbId(ryid);
    }
    String tablenameGs = du.getBillTableName("GSGLXXK");
    String yjlb = "";
    sql = "select yjlb from "+tablenameGs+" where id="+gsid;
    rs.execute(sql);
    if(rs.next()){
        yjlb = Util.null2String(rs.getString("yjlb"));
    }
    String canupdate = "0";
    if("1".equals(ryid) || bjyjlbids.indexOf(yjlb)>=0){
        canupdate = "1";
    }
   
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    //RCMenu += "{"+"变更"+",javascript:dochange(),_self} " ;
    //RCMenuHeight += RCMenuHeightStep ;
    //RCMenu += "{"+"导出Excel"+",javascript:_xtable_getAllExcel(),_self} " ;
    //RCMenuHeight += RCMenuHeightStep ;
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
        <tbody>
        <COLGROUP>
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">
            <COL width="12.5%">

           <!-- <TR class=Title>
                <TH colSpan=4><%=SystemEnv.getHtmlLabelName(15774,user.getLanguage())%></TH>
            </TR>-->
            <tr>
                <td></td>
                <td class="fname">年检类型</td>
                <td class="fname">本次年检截止时间</td>
                <td class="fname">本次年检完成时间</td>
                <td class="fname">经办人</td>
                <td class="fname">下次次年检截止时间</td>
                <td class="fname"></td>
                <td></td>
            </tr>
            <%
                String njlx = "";
                String bcnjjzsj = "";
                String bcnjwcsh = "";
                String jbr = "";
                String xcnjjzsj = "";
                String njid = "";
                sql = "select id,(select selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='"+tablename+"' and a.fieldname='njlx' and selectvalue=t.njlx) as njlx,bcnjjzsj,bcnjwcsh,case when jbr=1 then '系统管理员' else(select lastname from hrmresource where id=t.jbr)end as jbr,xcnjjzsj from "+tablename+" t where gsid='" + gsid + "' and substr(bcnjjzsj,0,4)='" + nowyear+ "'";
                rs.execute(sql);
                while(rs.next()){
                    njid = Util.null2String(rs.getString("id"));
                    njlx = Util.null2String(rs.getString("njlx"));
                    bcnjjzsj = Util.null2String(rs.getString("bcnjjzsj"));
                    bcnjwcsh = Util.null2String(rs.getString("bcnjwcsh"));
                    jbr = Util.null2String(rs.getString("jbr"));
                    xcnjjzsj = Util.null2String(rs.getString("xcnjjzsj"));

            %>
                <tr>
                <td></td>
                <td class=fvalue><SPAN  style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=njlx%></SPAN></td>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=bcnjjzsj%></SPAN></td>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=bcnjwcsh%></SPAN></td>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=jbr%></SPAN></td>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><%=xcnjjzsj%></SPAN></td>
                <%
                    if(!"".equals(bcnjwcsh)|| "0".equals(canupdate)){
                %>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"></SPAN></td>

                <%       
                    }else{
                %>
                <td class=fvalue><SPAN style="WORD-WRAP: break-word; WORD-BREAK: break-all" isedit="0"><A onclick="donj('<%=njid%>')">确认年检</A></SPAN></td>

                <%  
                    }
                %>
                <td></td>
            </tr>
            <%
                }
            %>
           
            
            
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