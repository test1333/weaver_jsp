<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="log" class="weaver.general.BaseBean" scope="page" />


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
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

		<form id=frmmain name=frmmain method=post action="">
		 
		<%
		String billid=Util.null2String(request.getParameter("billid"));
		String Month=Util.null2String(request.getParameter("Month"));
		String Year=Util.null2String(request.getParameter("Year"));
		String rowid = "";//获取序号
		String Name = "";//获取商品名称
		String Numbers = "";//获取数量
		String ApplicationDepartment = "";//获取部门
		String Application = "";//申请人
		String ApplicationDate = "";//申请日期
		String requestname = "";//获取申请流程
		String requestId = "";
		int index = 1 ;
		String Department_temp = "";
		String ApplicationDepartment_temp = "";

		String sql_1 = "select (select goodsname from uf_goodsinfo where id = Name) Name,Numbers,a.requestId,"+
					"wr.requestname,row_number() over (order by a.requestId desc) as rowid,(select departmentname "+
					"from HrmDepartment where id =a.ApplicationDepartment) ApplicationDepartment,"+
					"a.Application from (select Name,Numbers,f.requestId,f.Application,f.Month,f.ApplicationDepartment"+
					",f.Year from formtable_main_72_dt1 dt1 left join formtable_main_72 f on dt1.mainid=f.id) a left"+
					" join workflow_requestbase wr on a.requestId=wr.requestId where a.Month="+Month+" and a.Year="+Year;
			rs1.executeSql(sql_1);
			log.writeLog("sql_1="+sql_1); 
			while(rs1.next()){
				ApplicationDepartment = Util.null2String(rs1.getString("ApplicationDepartment"));//获取部门

				if(!ApplicationDepartment_temp.equals(ApplicationDepartment)){   //这是把部门给区分开来，部门不同时才执行下面操作
				
		%>
		<table align="center" width="80%" rules="all" style="background:white;margin-left: 10%;margin-top: 5px;margin-right: 10%;font-size: 9pt;border-collapse:collapse;" border="1px" bordercolor="#D3D3D3" cellspacing="1px">
			<colgroup>
			<col width="10%"></col>
			<col width="20%"></col>
			<col width="20%"></col>
			<col width="20%"></col>
			<col width="20%"></col>
			<col width="20%"></col>
			</colgroup>
			<tr class="ListStyle" align="center" style="color:#000;height: 60px;background-color: #EBF5FF;">
				<td colspan="3">部门名称</td>
				<td colspan="3"><%=ApplicationDepartment%></td>
			</tr>
			<tr class="ListStyle" align="center" style="color:#000;height: 60px;background-color: #EBF5FF;">
				<td>序号</td>
				<td>商品名称</td>
				<td>数量</td>
				<td>申请流程</td>
				<td>申请人</td>
				<td>申请时间</td>
			</tr>
			<%
			String sql = "select (select goodsname from uf_goodsinfo where id = Name) Name,Numbers,a.requestId,"+
					"wr.requestname,row_number() over (order by a.requestId desc) as rowid,(select departmentname "+
					"from HrmDepartment where id =a.ApplicationDepartment) ApplicationDepartment,"+
					"(select lastname from HrmResource where id=a.Application) Application,a.ApplicationDate "+
					"from (select Name,Numbers,f.requestId,f.Application,f.Month,f.ApplicationDate,f.ApplicationDepartment"+
					",f.Year from formtable_main_72_dt1 dt1 left join formtable_main_72 f on dt1.mainid=f.id) a left"+
					" join workflow_requestbase wr on a.requestId=wr.requestId where a.Month="+Month+" and a.Year="+Year;
			rs.executeSql(sql);
			log.writeLog("sql="+sql); 
			while(rs.next()){
				Department_temp = Util.null2String(rs.getString("ApplicationDepartment"));//获取部门
				rowid = Util.null2String(rs.getString("rowid"));//获取序号,这个序号现在不用这个方法，用index这个方法
				Name = Util.null2String(rs.getString("Name"));//获取商品名称
				Numbers = Util.null2String(rs.getString("Numbers"));//获取数量
				requestname = Util.null2String(rs.getString("requestname"));//获取申请流程
				requestId = Util.null2String(rs.getString("requestId"));//获取requestId
				Application = Util.null2String(rs.getString("Application"));//获取申请人
				ApplicationDate = Util.null2String(rs.getString("ApplicationDate"));//获取申请日期

				if(Department_temp.equals(ApplicationDepartment)){    //这个是每个部门申请的商品区分开来


		%>
			
					
			<!--通过这种方式把值传到另外一个jsp中，另外一个jsp通过name获得其中的值。-->	
				<tr align="center" style="height: 40px;">
				<td><%=index%></td>
				<td><%=Name%></td>
				<td><%=Numbers%></td>
				<td><a href="/workflow/request/ViewRequest.jsp?requestid=<%=requestId%>" target="_blank"><%=requestname%></td>
				<td><%=Application%></td>
				<td><%=ApplicationDate%></td>
				</tr>
				
		<%	
				index++;//这个是临时变量，给序号赋值	
				//out.print("index="+index);
				}

			}
			index = 1;	
		%>
		</table>
		<%
					}	
					ApplicationDepartment_temp = ApplicationDepartment;//把部门赋予临时变量，方便之前的比较
			}
			
			//out.println("ApplicationDepartment_temp="+ApplicationDepartment_temp);
		%>
		</form>
	<script type="text/javascript">

	function firm(){

                if(confirm("是否保存？")){
                	frmmain.submit();
                }   
            }
	
		function onBtnSearchClick() {
			
			frmmain.submit();
		}

		
	</script>
	<script type="text/javascript">  
    $().ready(function() {  
    setAllCount();  
    });  
        function setAllCount(){  
            var tr_id=0;//要统计的行数  
            var total1 = 0.00;  
            var itemtable = document.getElementById("count_table");//需要统计的table的id  
            var length = itemtable.childNodes[0].childNodes.length;  
            tr_id=length;//计算要统计的行数  
              
            for(var i=1;i<=tr_id;i++){  
               if(""!=($("#no"+i).val())&&null!=($("#no"+i).val())){  
                 total1 = total1+parseFloat($("#no"+i).val());  
               }else{  
                 total1 = total1+parseFloat(0.00);  
               }  
            }   
                  
             $("#count_result").html(total1.toFixed(0));  
            return true;  
    }  
    </script>  
	<!-- 日期的js引用 -->
	<SCRIPT language="javascript" src="../../js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="../../js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="../../js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>