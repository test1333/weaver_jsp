<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
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
		height:300px; 
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
	String titleFName = "柱形图示例";
	// 计算每个部门 男 女 数
	// 遍历所有的部门ID
	List<String> deptIDs = new ArrayList<String>();
	
	// 男生
	String  sql = " select departmentid,count(1) as ct from hrmresource where sex = 0 group by departmentid  ";
	rs.executeSql(sql);
	Map<String,String> oneMap = new HashMap<String,String>();
	while(rs.next()){
		String tmpDeptID = Util.null2String(rs.getString("departmentid"));
		String tmpNum = Util.null2String(rs.getString("ct"));
		oneMap.put(tmpDeptID,tmpNum);
		if(!deptIDs.contains(tmpDeptID)){
			deptIDs.add(tmpDeptID);
		}
	}
	
	// 女生
	sql = " select departmentid,count(1) as ct from hrmresource where sex = 1 group by departmentid  ";
	rs.executeSql(sql);
	Map<String,String> twoMap = new HashMap<String,String>();
	while(rs.next()){
		String tmpDeptID = Util.null2String(rs.getString("departmentid"));
		String tmpNum = Util.null2String(rs.getString("ct"));
		twoMap.put(tmpDeptID,tmpNum);
		if(!deptIDs.contains(tmpDeptID)){
			deptIDs.add(tmpDeptID);
		}
	}
	
	
	// 封装数据对象
	StringBuffer buff = new StringBuffer();
	
	buff.append("{");
	buff.append("type: 'column',");
	buff.append("title:'男',");
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
	buff.append("title:'女',");
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
%>
	
	
<script>
	$(document).ready(function () {
		$('#jqChart').jqChart({
			title: { text: '<%=titleFName%>' },
			axes: [{
				location: 'left',//y轴位置，取值：left,right
				minimum: 1,//y轴刻度最小值
				maximum: 30,//y轴刻度最大值
				interval: 1//刻度间距
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
        <div id="jqChart" style="width: 500px; height: 300px;"></div>
    </div>
<!-- 代码 结束 -->
</div>


