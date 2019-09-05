<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page"/>
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page"/>
<html>
<head>
    <script type="text/javascript" src="/js/weaver.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/Weaver.css">
</head>
<%
    int emp_id = user.getUID();
    String sub_com = ResourceComInfo.getSubCompanyID("" + emp_id);
    int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	String groupid = request.getParameter("groupid");
	String rid = request.getParameter("rid");
	String groupids = request.getParameter("groupid");
	String lastname = Util.null2String(request.getParameter("lastname"));
	String workcode = Util.null2String(request.getParameter("workcode"));
	if(groupids.length()>0){
		String groupidss[] = groupids.split(",");
		for(int i=0;i<groupidss.length;i++){
			String str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupidss[i]+") and rid = '"+rid+"'";
			rs1.executeSql(str);
			int a = 0;
			int b = 0;//有效人数
			int d = 0;//删除后存在人数
			if(rs1.next()){
				a = rs1.getInt("con");//建模组内人数
			}
			str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupidss[i]+") and rid = '"+rid+"' and bs = '1'";
			rs1.executeSql(str);
			if(rs1.next()){
				b = rs1.getInt("con");
			}
			if(a>0){
				str = "select count(userid) as con  from hrmgroupmembers where groupid = '"+ groupidss[i] +"'  ";
				rs1.executeSql(str);
				int c = 0;//组内人数
				if(rs1.next()){
					c = rs1.getInt("con");
				}
				str =  "select id from uf_hrmgroup where groupid in ("+groupidss[i]+") and rid = '"+rid+"'  and hid  not in ( select userid from hrmgroupmembers where groupid = '"+ groupidss[i] +"'  )";
				rs1.executeSql(str);
				while(rs1.next()){
					String undoid = rs1.getString("id");
					String delsql = "delete uf_hrmgroup where id = '"+undoid+"'";
					rs.executeSql(delsql);
				}
				
				str = "select count(id) as con from uf_hrmgroup where groupid in ("+groupidss[i]+") and rid = '"+rid+"'";
				rs1.executeSql(str);
				if(rs1.next()){
					d = rs1.getInt("con");
				}
				if(c>d){
					str = " select userid from hrmgroupmembers where groupid = '"+ groupidss[i] +"'  and userid not in (select hid from uf_hrmgroup where groupid in ("+groupidss[i]+") and rid = '"+rid+"') ";
					rs1.executeSql(str);
					while(rs1.next()){
						String  hrmid = rs1.getString("userid");
						String ssq = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id = '"+hrmid+"' ";
						rs.executeSql(ssq);
						if(rs.next()){
							String id = rs.getString("id");
							String lastnames = rs.getString("lastname");
							String workcodes = rs.getString("workcode");
							String jobtitle = rs.getString("jobtitle");
							String departmentid = rs.getString("departmentid");
							String subcompanyid1 = rs.getString("subcompanyid1");
							ssq = "insert into uf_hrmgroup (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,groupid) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+groupid+"')";
							rs.executeSql(ssq);
						}
					}
					
				}
				
				
			}
			if(a>0 && b<1){
				str = " update uf_hrmgroup set bs = '1' where groupid in ("+groupidss[i]+") and rid = '"+rid+"' and bs = '0' ";
				rs1.executeSql(str);
			}
			
			
			if(a<1){
				str = "select id,lastname,workcode ,jobtitle,departmentid,subcompanyid1 from hrmresource where id in ( select userid from hrmgroupmembers where groupid = '"+ groupidss[i] +"' ) ";
				rs1.executeSql(str);//bs 0 无效   1有效
				while(rs1.next()){
					String id = rs1.getString("id");
					String lastnames = rs1.getString("lastname");
					String workcodes = rs1.getString("workcode");
					String jobtitle = rs1.getString("jobtitle");
					String departmentid = rs1.getString("departmentid");
					String subcompanyid1 = rs1.getString("subcompanyid1");
					String sss = "insert into uf_hrmgroup (hid,rid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,groupid) values('"+id+"','"+rid+"','"+lastnames+"','"+workcodes+"','"+jobtitle+"','"+departmentid+"','"+subcompanyid1+"','1','"+groupid+"')";
					rs.executeSql(sss);
				}
			}
		}
	}

    int perpage = 10;
    String cjkc_name = Util.null2String(request.getParameter("cjkc_name"));
    String imagefilename = "/images/hdDOC.gif";
    String titlename = "组内人员";
    String needfav = "1";
    String needhelp = "";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:document.weaver.submit(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
    RCMenu += "{刷新,javascript:refresh(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
	RCMenu += "{确认,javascript:tosave(),_top} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr>
            <td height="10" colspan="2"></td>
        </tr>
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                            <FORM id=weaver name=weaver STYLE="margin-bottom:0" action="" method="post">
                                <input type="hidden" name="multiRequestIds" value="">
                                <input type="hidden" name="operation" value="">
                                <table width=100% class=ViewForm>
    <colgroup>
        <col width="25%"></col>
        <col width="25%"></col>
		<col width="25%"></col>
        <col width="25%"></col>
        <col></col>
    </colgroup>
    <tr>
		<TD align="center" valign="middle">人员工号</TD>
        <td><input class=inputstyle id='workcode' name=workcode size="20" value="<%=workcode%>"></td>
        <TD align="center" valign="middle">人员姓名</TD>
        <td><input class=inputstyle id='lastname' name=lastname size="20" value="<%=lastname%>"></td>

    </tr>
    <tr style="height:1px;">
        <td class=Line colspan=3></td>
    </tr>
</table>
<TABLE width="100%">
    <tr>
        <td valign="top">
            <%
				
			
				String str = "select id from uf_hrmgroup where  groupid = '"+ groupid +"' and rid = '"+rid+"'  and bs ='1'";
				String strs = "";
				rs1.executeSql(str);
				int st = 0;
				while(rs1.next()){
					String bsid = rs1.getString("id");
					if(st<1){
						strs = strs+bsid;
					}else{
						strs = strs+","+bsid;
					}
					st++;
					
				}
				String 	backfields = "  id,hid,lastname,workcode ,jobtitle,departmentid,subcompanyid1,bs,groupid   ";				
                String fromSql = " from uf_hrmgroup ";
                String sqlWhere = "  where groupid = '"+ groupid +"' and rid = '"+rid+"' ";
				
              // out.println("select " + backfields + fromSql + " where " + sqlWhere+"----------"+strs);
                //out.println(sqlWhere);
				
				if (!"".equals(workcode)) {
                    sqlWhere += "  and  workcode like '%" + workcode + "%' ";
                }
				
				 if (!"".equals(lastname)) {
                    sqlWhere += "  and lastname like '%" + lastname + "%' ";
                }				
                String orderby = " id ";
                String tableString = "";
                tableString = " <table  tabletype=\"checkbox\" pagesize=\"" + perpage + "\" >" +
                        "	   <sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\"" + Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby + "\" sqlprimarykey=\"id\" sqlsortway=\"asc\" />" +
                        "			<head>" +
					" 	<col width=\"20%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />" +
                        " 	<col width=\"20%\" text=\"姓名\" column=\"hid\" orderkey=\"hid\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"  />" +
            " 	<col width=\"20%\" text=\"所属分部\" column=\"subcompanyid1\" orderkey=\"subcompanyid1\" transmethod=\"weaver.hrm.company.SubCompanyComInfo.getSubCompanyname\"  />" +
            " 	<col width=\"20%\" text=\"部门\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"  />" +
            " 	<col width=\"20%\" text=\"岗位\" column=\"jobtitle\" orderkey=\"jobtitle\" transmethod=\"weaver.hrm.job.JobTitlesComInfo.getJobTitlesname\"  />" +
                        "			</head>" +
                        "</table>";
            %>

            <wea:SplitPageTag tableString="<%=tableString%>" mode="run" showExpExcel="false"  selectedstrs ="<%=strs%>" />
        </td>
    </tr>
</TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
</table>
<script type="text/javascript">
    function refresh() {
        window.location.reload();
    }

	
	function tosave(){
		var ids = _xtable_CheckedCheckboxId();
		if(ids == null || ids == ""){
			alert("请选择人员数据");
			return ;
		}
		var res = false;
		if(ids!=null && ids!=""){
			var idds = ids.substring(0,ids.length-1);
			//alert(idds)
			$.ajax({
				type: "POST",
				url: "/gcl/doc/changeinfo.jsp",
				data: {'idds': idds,'groupid':<%=groupids%>,'rid':<%=rid%>},
				dataType: "text",
				async: false,//同步   true异步
				success: function (data) {
					res = true;
				}
			});
		}
		if(res){
			// window.location.reload();
			window.open('','_self');
			window.close();
		}
		
	}
    function cy(id) {
        //alert("id")
        var creater = "<%=emp_id%>";
        var rqid = "";
        var result = "";
        $.ajax({
            type: "POST",
            url: "/gcl/doc/docaction.jsp",
            data: {'billid': id, 'creater': creater, 'type': 'check'},
            dataType: "text",
            async: false,//同步   true异步
            success: function (data) {
                data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                result = data;
            }
        });
        //alert(result);
        if (result == "1") {
            alert("有未提交的传阅子流程");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/gcl/doc/docaction.jsp",
            data: {'billid': id, 'creater': creater, 'type': 'cw'},
            dataType: "text",
            async: false,//同步   true异步
            success: function (data) {
                data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
                rqid = data;
            }
        });
        //alert(rqid);
        if (rqid == "-1") {
            alert("创建传阅流程失败");
            return;
        }

        openFullWindowForXtable('/workflow/request/ViewRequest.jsp?requestid=' + rqid);
    }

    function ycy(id) {
        var obj = new Object();
        obj.keyid = id;
        var iTop = (window.screen.availHeight - 30 - parseInt(300)) / 2 + "px"; //获得窗口的垂直位罿
        var iLeft = (window.screen.availWidth - 10 - parseInt(500)) / 2 + "px"; //获得窗口的水平位罿
        var k = window.showModalDialog("/gcl/doc/editRemark.jsp",
            obj, "addressbar=no;status=0;scroll=no;dialogHeight=300px;dialogWidth=500px;dialogLeft=" + iLeft + ";dialogTop=" + iTop + ";resizable=0;center=1;");
        if (k == 1) {//判断是否刷新
            window.location.reload();
        }
    }

    function downloadxml() {
    }

 
    function onShowResource() {
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?selectedids=" + jQuery("#lastname").val());
        if (data != null) {
            if (data.id != "") {
                ids = data.id.split(",");
                names = data.name.split(",");
                sHtml = "";
                for (var i = 0; i < ids.length; i++) {
                    if (ids[i] != "") {
                        sHtml = sHtml + names[i] + "&nbsp;&nbsp;";
                    }
                }
                jQuery("#lastnamespan").html(sHtml);
                jQuery("input[name=lastname]").val(data.id.substr(1));
            } else {
                jQuery("#lastnamespan").html("");
                jQuery("input[name=lastname]").val("");
            }
        }
    }
   
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
<script language="javascript" src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
</BODY>
</HTML>