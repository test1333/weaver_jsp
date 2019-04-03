<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

<%
String workflowid1="41";
String requestname1="请假申请流程";
Integer lg=(Integer)user.getLanguage();
int user_id = user.getUID();
String tmc_pageId = "wok001";
weaver.general.AccountType.langId.set(lg);
String beginDate = Util.null2String(request.getParameter("beginDate"));
	String endDate = Util.null2String(request.getParameter("endDate"));
	String Sender = Util.null2String(request.getParameter("Sender"));
String sql="";
int nodecount=0;
sql="select count(b.id) as count from workflow_flownode a,workflow_nodebase b where a.nodeid=b.id and a.workflowid="+workflowid1+" and isend <>1";
rs.executeSql(sql);
if(rs.next()){
nodecount = rs.getInt("count");
}
int nodecount_with=nodecount*7;
int with1=250+nodecount_with*120;
int with2=290+nodecount_with*120;
String nodeid="";
String xh="";
String fz="";
StringBuffer sb= new StringBuffer();
		sb.append("requestid,rownum,requestname");
		sql="select b.id,c.xh,c.fz  from workflow_flownode a left join workflow_nodebase b on a.nodeid=b.id left join uf_outtime_cong_dt1 c on b.id=c.jdid where a.workflowid="+workflowid1+" and isend <>1 order by nodename asc ";
		int num=0;
		rs.executeSql(sql);
		while(rs.next()){
			num++;
			nodeid = Util.null2String(rs.getString("id"));
			xh = Util.null2String(rs.getString("xh"));
			fz = Util.null2String(rs.getString("fz"));
			String bzgs="";
			if(!"".equals(xh)){
				bzgs += xh+"小时";
				
			}
			if(!"".equals(fz)){
				bzgs += fz+"分钟";
				
			}
			sb.append(",getnodeoperate("+nodeid+",requestid) as a"+num+",getnodelogtype("+nodeid+",requestid) as b"+num+",getnodeoreceive("+nodeid+",requestid) as c"+num+",getnodeyjwcsje("+nodeid+",requestid) as d"+num+",getnodesjclsj("+nodeid+",requestid)  as e"+num+", "+
			" '"+bzgs+"'  as f"+num+",getnodessjhs("+nodeid+",requestid) as g"+num+",getischaoshi("+nodeid+",requestid) as h"+num+"");
		}
		String backfields=sb.toString();
		String fromSql=" from workflow_requestbase a";
		String sqlWhere=" where workflowid="+workflowid1+"";
		String orderby = " a.requestid ";

  if(!"".equals(beginDate)){
				sqlWhere +=  " and createdate >='"+beginDate+"'";
			   }else{
				   sqlWhere += " and 1=2 ";
				 	//sqlWhere +=  " and to_date(createdate,'yyyy-mm-dd')>=trunc(sysdate,'MM')";  
			   }
			  if(!"".equals(endDate)){
				sqlWhere +=  " and createdate <='"+endDate+"'";
			  }else{
				  sqlWhere += " and 1=2 ";
				  //sqlWhere +=  " and to_date(createdate,'yyyy-mm-dd')<= LAST_DAY(sysdate)";
			  }

			  if(!"".equals(Sender)){
				  sqlWhere += " and exists(select 1 from workflow_currentoperator b where b.requestid=a.requestid and b.userid="+Sender+")";
			  }
			  	String sqlquery="select "+backfields+fromSql+sqlWhere+" order by requestid asc";
//out.print(sqlquery);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: <%=with1%>px;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
		}
		.table-head{padding-right:17px}
         .table-body{width:100%;overflow-y:auto;overflow-x: hidden}
		</style>
		
	</head>
	<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
    <link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
  <link type="text/css" rel="stylesheet" href="/css/crmcss/lanlv_wev8.css" />
  <link type="text/css" rel="stylesheet" href="/wui/theme/ecology8/skins/default/wui_wev8.css" />
	<BODY >
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
			RCMenu += "{刷新,javascript:refersh(),_self} " ;
		RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/htkj/report/workflowReport.jsp" method=post>
			<input type="hidden" name="requestid" value="">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
					<span id="advancedSearch" class="advancedSearch"><%=SystemEnv.getHtmlLabelName(21995,user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
					</td>
				</tr>
			</table>
			
			<% // 查询条件 %>
			<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">
				<wea:layout type="4col">
				<wea:group context="查询条件">
				 <wea:item>查询日期</wea:item>
		<wea:item>
			<button type="button" class=Calendar id="selectBeginDate" onclick="onshowPlanDate('beginDate','selectBeginDateSpan')"></BUTTON> 
              	<SPAN id=selectBeginDateSpan ><%=beginDate%></SPAN> 
              	<INPUT type="hidden" name="beginDate" id="beginDate" value="<%=beginDate%>">  
            &nbsp;-&nbsp;
            <button type="button" class=Calendar id="selectEndDate" onclick="onshowPlanDate('endDate','endDateSpan')"></BUTTON> 
            	<SPAN id=endDateSpan><%=endDate%></SPAN> 
            	<INPUT type="hidden" name="endDate"  id="endDate"  value="<%=endDate%>">  
		</wea:item>
<wea:item>相关人员</wea:item>
				<wea:item>
				<brow:browser viewType="0"  name="Sender" browserValue="<%=Sender %>" 
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="165px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(Sender),user.getLanguage())%>">
				</brow:browser>
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
	
	<div style="width:<%=with2%>px; ">	
	<div class="table-head" style="width:<%=with1%>px; ">
			<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
            <table class="ViewForm1  maintable" scrolling="auto" id='table11'>
                <colgroup> 
				 <col width="50px">
				 <col width="200px">
				<%
				  for(int i=0;i<nodecount;i++){
				  %>
				  <col width="100px"></col>
				   <col width="100px"></col>
				    <col width="140px"></col>
					 <col width="140px"></col>
					  <col width="140px"></col>
					   <col width="100px"></col>
					    <col width="120px"></col>
				<%  	  
				  }
				%>
				 
				 </colgroup>
                <tbody>
					 <tr>
						 <td class="fname" rowspan="2" align="center"></td>
					    <td class="fname" rowspan="2" align="center"><%=requestname1%></td>
						<%
						    String nodename="";
							sql="select nodename  from workflow_flownode a,workflow_nodebase b where a.nodeid=b.id and a.workflowid="+workflowid1+" and isend <>1 order by nodename asc";
							rs.executeSql(sql);
							while(rs.next()){
								nodename = Util.null2String(rs.getString("nodename"));
						%>
							<td class="fname" colspan="7" align="center"><%=nodename%></td>
						<%	
							}
						%>
	                  
                 </tr>
				 <tr>
					 <%
				  for(int i=0;i<nodecount;i++){
				  %>
				  	  <td class="fname">&nbsp;&nbsp;操作人</td>
					  <td class="fname">&nbsp;&nbsp;操作状态</td>
					  <td class="fname">&nbsp;&nbsp;接收时间</td>
					  <td class="fname">&nbsp;&nbsp;设定完成时间</td>
					  <td class="fname">&nbsp;&nbsp;实际处理时间</td>
					  <td class="fname">&nbsp;&nbsp;标准工时</td>
					  <td class="fname">&nbsp;&nbsp;实际耗时</td>
				<%  	  
				  }
				%>
					 
				</tr>
				</tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
	</div>
	<div class="table-body" id="div22" style="width:<%=with2%>px; ">
	<table class="ViewForm1  outertable" scrolling="auto">
    <tbody>		
        <tr>			
            <td>
			<a id="btn0"></a>
<input id="pageSize" type="text" size="1" maxlength="2" value="getDefaultValue()"/><a> 条 </a> <a href="#" id="pageSizeSet">设置</a> 
<a id="sjzl"></a> 
<a  href="#" id="btn1">首页</a>
<a  href="#" id="btn2">上一页</a>
<a  href="#" id="btn3">下一页</a>
<a  href="#" id="btn4">尾页</a> 
<a>转到 </a>
<input id="changePage" type="text" size="1" maxlength="4"/>
<a>页 </a>
<a  href="#" id="btn5">跳转</a>
            <table class="ViewForm1  maintable" id="table1111" scrolling="auto">
                <colgroup>  
				 <col width="50px">
				  <col width="200px">
				<%
				  for(int i=0;i<nodecount;i++){
				  %>
				  <col width="100px"></col>
				   <col width="100px"></col>
				    <col width="140px"></col>
					 <col width="140px"></col>
					  <col width="140px"></col>
					   <col width="100px"></col>
					    <col width="120px"></col>
				<%  	  
				  }
				%>
				 </colgroup>
                <tbody>
					 <%
					 	rs1.executeSql(sqlquery);
						 while(rs1.next()){
					 %>
					 <tr>
						  <td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("rownum")%></td>
						 <td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("requestname")%></td>
						<%
							sql="select nodename  from workflow_flownode a,workflow_nodebase b where a.nodeid=b.id and a.workflowid="+workflowid1+" and isend <>1 order by nodename asc";
							rs.executeSql(sql);
							num=0;
							while(rs.next()){
								num++;
						%>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("a"+num)%></td>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("b"+num)%></td>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("c"+num)%></td>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("d"+num)%></td>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("e"+num)%></td>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("f"+num)%></td>
						 <%
						 if("1".equals(rs1.getString("h"+num))){
						 %>
						 	<td class="fvalue" bgcolor="red">&nbsp;&nbsp;<%=rs1.getString("g"+num)%></td>
						 <%	 
						 }else{
						 %>
								<td class="fvalue">&nbsp;&nbsp;<%=rs1.getString("g"+num)%></td>
						<%	
						}
							}
						%>
					 </tr>

					 <%
						 }
					 %>
					
                </tbody>
            </table>
			 </td>
        </tr>
    </tbody>
</table>
           
</div>
</div>	
<div style="display:none">
	<%
	String tableString="";
	String  operateString= "";
tableString =" <table tabletype=\"none\" pagesize=\""+ PageIdConst.getPageSize(tmc_pageId,user.getUID(),PageIdConst.HRM)+"\" >"+	
		"	   <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.requestid\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
    operateString+
    "			<head>";
		tableString+="<col width=\"50px\"  text=\"序号\" column=\"rownum\" orderkey=\"rownum\" hide=\"true\"/>"+
		"<col width=\"200px\"  text=\"流程名称\" column=\"requestname\" orderkey=\"requestname\" hide=\"true\"/>";
       sql="select nodename  from workflow_flownode a,workflow_nodebase b where a.nodeid=b.id and a.workflowid="+workflowid1+" and isend <>1 order by nodename asc";
		rs.executeSql(sql);
		num=0;
		while(rs.next()){
			nodename = Util.null2String(rs.getString("nodename"));
			num++;
			tableString+="<col width=\"100px\"  text=\""+nodename+"操作人\" column=\"a"+num+"\" orderkey=\"a"+num+"\" hide=\"true\"/>"+	
			"<col width=\"100px\"  text=\""+nodename+"操作状态\" column=\"b"+num+"\" orderkey=\"b"+num+"\" hide=\"true\"/>"+
			"<col width=\"100px\"  text=\""+nodename+"接收时间\" column=\"c"+num+"\" orderkey=\"c"+num+"\" hide=\"true\"/>"+	
			"<col width=\"140px\"  text=\""+nodename+"设定完成时间\" column=\"d"+num+"\" orderkey=\"d"+num+"\" hide=\"true\"/>"+										
			"<col width=\"140px\"  text=\""+nodename+"实际处理时间\" column=\"e"+num+"\" orderkey=\"e"+num+"\" hide=\"true\"/>"+	
			"<col width=\"140px\"  text=\""+nodename+"标准工时\" column=\"f"+num+"\" orderkey=\"f"+num+"\" hide=\"true\"/>"+	
			"<col width=\"100px\"  text=\""+nodename+"实际耗时\" column=\"g"+num+"\" orderkey=\"g"+num+"\" hide=\"true\"/>"+
			"<col width=\"100px\"  text=\""+nodename+"是否超时\" column=\"h"+num+"\" orderkey=\"h"+num+"\" hide=\"true\"/>";		
		
			
							
		}

	tableString +="			</head>"+
    " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" showExpExcel="true"/>
</div>
	<script type="text/javascript">
	window.onload=function(){
		var clienthei= document.body.clientHeight;
		var height1=Number(clienthei)-100;
		height1=height1+'px';
		document.getElementById('div22').style.height=height1;
	}
	  
		var parentWin;
		try{
		parentWin = parent.getParentWindow(window);
		}catch(e){}
		function onBtnSearchClick() {
				var endDate=jQuery("#endDate").val();
			var beginDate=jQuery("#beginDate").val();
			if(endDate == '' && beginDate !=''){
				alert("请选择结束时间");
				return;
			}
			if(beginDate == '' && endDate !=''){
				alert("请选择开始时间");
				return;
			}
			if(endDate == '' && beginDate ==''){
				alert("请选择查询时间");
				return;
			}
			report.submit();
		}
        	var parentWin="";
		function refersh() {
  			window.location.reload();
  		}
		  function onBtnSaveClick() {	
			$('#report1').submit();	
			window.close();
		}
	   

	</script>
	<script type="text/javascript">
            var pageSize = 15;    //每页显示的记录条数
             var curPage=0;        //当前页
             var lastPage;        //最后页
             var direct=0;        //方向
            var len;            //总行数
            var page;            //总页数
            var begin;
            var end;

                
            $(document).ready(function display(){   
                len =$("#table1111 tr").length;    // 求这个表的总行数，剔除第一行介绍
                page=len % pageSize==0 ? len/pageSize : Math.floor(len/pageSize)+1;//根据记录条数，计算页数
                // alert("page==="+page);
                curPage=1;    // 设置当前为第一页
                displayPage(1);//显示第一页

                document.getElementById("btn0").innerHTML="当前 " + curPage + "/" + page + " 页    每页 ";    // 显示当前多少页
                document.getElementById("sjzl").innerHTML="数据总量 " + len + "";        // 显示数据量
                document.getElementById("pageSize").value = pageSize;

                

                $("#btn1").click(function firstPage(){    // 首页
                    curPage=1;
                    direct = 0;
                    displayPage();
                });
                $("#btn2").click(function frontPage(){    // 上一页
                    direct=-1;
                    displayPage();
                });
                $("#btn3").click(function nextPage(){    // 下一页
                    direct=1;
                    displayPage();
                });
                $("#btn4").click(function lastPage(){    // 尾页
                    curPage=page;
                    direct = 0;
                    displayPage();
                });
                $("#btn5").click(function changePage(){    // 转页
                    curPage=document.getElementById("changePage").value * 1;
                    if (!/^[1-9]\d*$/.test(curPage)) {
                        alert("请输入正整数");
                        return ;
                    }
                    if (curPage > page) {
                        alert("超出数据页面");
                        return ;
                    }
                    direct = 0;
                    displayPage();
                });

                
                $("#pageSizeSet").click(function setPageSize(){    // 设置每页显示多少条记录
                    pageSize = document.getElementById("pageSize").value;    //每页显示的记录条数
                    if (!/^[1-9]\d*$/.test(pageSize)) {
                        alert("请输入正整数");
                        return ;
                    }
                    len =$("#table1111 tr").length - 1;
                    page=len % pageSize==0 ? len/pageSize : Math.floor(len/pageSize)+1;//根据记录条数，计算页数
                    curPage=1;        //当前页
                     direct=0;        //方向
                     firstPage();
                });
            });

            function displayPage(){
                if(curPage <=1 && direct==-1){
                    direct=0;
                    alert("已经是第一页了");
                    return;
                } else if (curPage >= page && direct==1) {
                    direct=0;
                    alert("已经是最后一页了");
                    return ;
                }

                lastPage = curPage;

                // 修复当len=1时，curPage计算得0的bug
                if (len > pageSize) {
                    curPage = ((curPage + direct + len) % len);
                } else {
                    curPage = 1;
                }

                
                document.getElementById("btn0").innerHTML="当前 " + curPage + "/" + page + " 页    每页 ";        // 显示当前多少页

                begin=(curPage-1)*pageSize + 1;// 起始记录号
                end = begin + 1*pageSize - 1;    // 末尾记录号

                
                if(end > len ) end=len;
                $("#table1111 tr").hide();    // 首先，设置这行为隐藏
                $("#table1111 tr").each(function(i){    // 然后，通过条件判断决定本行是否恢复显示
                    if((i>=begin && i<=end) || i==0 )//显示begin<=x<=end的记录
                        $(this).show();
                });

             }
    </script>

<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
</BODY>
</HTML>