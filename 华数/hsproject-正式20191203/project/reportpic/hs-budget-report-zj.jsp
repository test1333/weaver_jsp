<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
	
<script src="jquery-1.5.1.min.js"></script>
<script src="jquery.jqChart.min.js"></script>
<style>
	html, body { 
		width : 100%;
		height : 100%; 
		margin : 0; 
		padding : 0; 
	}
	.wrapper { 
		width : 500px;
		height:350px; 
		padding:20px; 
		margin:0px auto font-size : 0; 
	}
	.icon { 
		position : relative; 
		display : inline-block; 
		width : 100px; 
		height : 100px; 
		margin : 20px; 
		border-radius : 18px; 
		-webkit-box-sizing : border-box; 
		-moz-box-sizing : border-box; 
		box-sizing : border-box; 
	}
</style>
	
<%
	Calendar today = Calendar.getInstance();
	String currentyear = Util.add0(today.get(Calendar.YEAR), 4);
	String titleFName = "紫荆-部门预算使用情况（单位：万元）";

	List<String> deptIDs = new ArrayList<String>();
	

	String maxbudget = "";
	int minnum = 100;
	int maxnum = 2000;
	String sql = "select max(budget) as maxbudget from (select sum(nvl(budget,0)) as budget from uf_prj_depbudget where year='"+currentyear+"' and company=623 group by department)";
	rs.executeSql(sql);
	if(rs.next()){
		maxbudget = Util.null2String(rs.getString("maxbudget"));
	}
	sql = "select ceil("+maxbudget+"/100/20)*100 as minnum,ceil("+maxbudget+"/100/20)*2000 as maxnum from dual";
	rs.executeSql(sql);
	if(rs.next()){
		minnum = rs.getInt("minnum");
		maxnum = rs.getInt("maxnum");
	}
	sql = " select department,(select departmentname from hrmdepartment where id=department) as departmentname,sum(nvl(budget,0)) as budget,sum(nvl(amount,0)) as amount from uf_prj_depbudget where year='"+currentyear+"' and company=623 group by department";
	//out.println("sql:"+sql);
	rs.executeSql(sql);
	Map<String,String> twoMap = new HashMap<String,String>();
	Map<String,String> oneMap = new HashMap<String,String>();
	while(rs.next()){
		String tmpDeptID = Util.null2String(rs.getString("department"));
		String budget = Util.null2String(rs.getString("budget"));
		String amount = Util.null2String(rs.getString("amount"));
		oneMap.put(tmpDeptID,budget);
		twoMap.put(tmpDeptID,amount);
		if(!deptIDs.contains(tmpDeptID)){
			deptIDs.add(tmpDeptID);
		}
	}
	
	
	
	// 封装数据对象
	StringBuffer buff = new StringBuffer();
	
	buff.append("{");
	buff.append("type: 'column',");
	buff.append("title:'预算总额',");
	buff.append("data:[");
	String flagx = "";
	for(int index = 0;index < deptIDs.size();index++){
		String tmpDeptID = deptIDs.get(index);
		String tmpDeptName = DepartmentComInfo.getDepartmentname(tmpDeptID);
		buff.append(flagx);
		buff.append("[");
		buff.append("'");buff.append(tmpDeptName);buff.append("'");buff.append(",");
		if(oneMap.containsKey(tmpDeptID)){
			buff.append(oneMap.get(tmpDeptID));
		}else{
			buff.append("0");
		}
		buff.append("]");
		flagx = ",";
	}
	buff.append("]");
	buff.append("}");
	
	flagx = "";
	buff.append(",{");
	buff.append("type: 'column',");
	buff.append("title:'发生额',");
	buff.append("data:[");
	for(int index = 0;index < deptIDs.size();index++){
		String tmpDeptID = deptIDs.get(index);
		String tmpDeptName = DepartmentComInfo.getDepartmentname(tmpDeptID);
		buff.append(flagx);
		buff.append("[");
		buff.append("'");buff.append(tmpDeptName);buff.append("'");buff.append(",");
		if(twoMap.containsKey(tmpDeptID)){
			buff.append(twoMap.get(tmpDeptID));
		}else{
			buff.append("0");
		}
		buff.append("]");
		flagx = ",";
	}
	buff.append("]");
	buff.append("}");
	//out.println("buff:"+buff.toString());
%>
	
	
<script>
	$(document).ready(function () {
		$('#jqChart').jqChart({
			title: { text: '<%=titleFName%>' },
			axes: [{
				location: 'left',//y轴位置，取值：left,right
				minimum: 0,//y轴刻度最小值
				maximum: <%=maxnum%>,//y轴刻度最大值
				interval: <%=minnum%>//刻度间距
				}
			],
			series: [
				<%=buff.toString()%>
			]
		});
	});
</script>

<div class="wrapper">
<!-- 代码 开始 -->
    <div>
        <div id="jqChart" style="width: 500px; height: 350px;"></div>
    </div>
<!-- 代码 结束 -->
</div>


