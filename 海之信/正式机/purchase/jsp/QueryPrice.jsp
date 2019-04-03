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
		<link rel="stylesheet" href="/css/init_wev8.css" type="text/css" />
		<style>
		.checkbox {
			display: none
		}
		TABLE.ViewForm1 {
			WIDTH: 100%;
			border:0;margin:0;
			border-collapse:collapse;
		
	   }
		TABLE.ViewForm1 TD {
			padding:0 0 0 5px;
		}
		TABLE.ViewForm1 TR {
			height: 35px;
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
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:firm(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>

		<form id=frmmain name=frmmain method=post action="InsertQueryPrice.jsp">
		 
		<%
		String sql_1 = "";
		String sql_2 = "";
		String sql_3 = "";
		String sql_4 = "";
		String supplierID = "";//供应商ID
		String name = "";//供应商名称	
		String requestid = "";//流程requestid
		String mainID = "";
		String Name = "";//商品名称ID
		String goodsname = "";//商品名称
		String tmp_goodsname = "";//供应商商品名称
		String Stock = "";//当前库存
		String AvgPrice = "";//平均单价
		int index = 0 ;
		String sum1 = "";//总和
		String count2 = "";//数量
		String price2 = "";//单价
		String total2 = "";//总价
		String remark2 = "";//备注

		supplierID = request.getParameter("supplierID");

		requestid = request.getParameter("requestid");
		
		log.writeLog("requestid供应商ID="+requestid); 

		sql_1 = "select cast(GOODSNAME as varchar(8000)) as gname,name from uf_supplier where id="+supplierID+"";
		//log.writeLog("sql_1="+sql_1); 
		rs.executeSql(sql_1);
		while(rs.next()){
				 name = Util.null2String(rs.getString("name"));
				 tmp_goodsname = Util.null2String(rs.getString("gname"));//供应商商品名称
				 //log.writeLog("name="+name); 
		}
		%>
		<table width=100% class="ViewForm1  outertable" id="count_table">
			<colgroup>
			<col width="13%"></col>
			<col width="13%"></col>
			<col width="13%"></col>
			<col width="13%"></col>
			<col width="13%"></col>
			<col width="13%"></col>
			<col width="20%"></col></colgroup>
			<tr>
				<td>供应商</td>
				 <INPUT type="hidden" name="sname" value="<%=name%>">
				<td><%=name%></td>
			</tr>
			<tr>
				<td>商品名称</td>
				<td>当前库存</td>
				<td>平均单价</td>
				<td>复核数量</td>
				<td>供应商单价</td>
				<td>金额</td>
				<td>备注</td>
			</tr>		
			<!--通过这种方式把值传到另外一个jsp中，另外一个jsp通过name获得其中的值。-->
			<INPUT type="hidden" name="supplierID" value="<%=supplierID%>">
			<INPUT type="hidden" name="requestid" value="<%=requestid%>">
			
		<%
		sql_2 = "select * from formtable_main_73 where requestid="+requestid;	
		rs.executeSql(sql_2);
			while(rs.next()){
					mainID = Util.null2String(rs.getString("id"));//获取主表中的id，作为明细表中的mainid
			}	 
		//查询明细表
		//sql_3 = "select * from formtable_main_45_dt1 where mainid="+mainID;
		sql_3 = "select f2.Name,f2.Stock,f2.AvgPrice,(select goodsname from uf_goodsinfo where id = f2.Name) as goodsname from"+
		" formtable_main_73_dt1 f2 left join  formtable_main_73 f1 on f1.id = f2.mainid where f2.mainid = "+mainID+" and charindex(f2.name,'"+tmp_goodsname+"') >0 ";	
		rs.executeSql(sql_3);
		log.writeLog("sql_3="+sql_3); 
			while(rs.next()){
				 goodsname = Util.null2String(rs.getString("goodsname"));//获取明细表中商品名称ID
				 log.writeLog("goodsname="+goodsname); 
				 Stock = Util.null2String(rs.getString("Stock"));//获取明细表中当前库存
				 //log.writeLog("Stock="+Stock); 
				 AvgPrice = Util.null2String(rs.getString("AvgPrice"));//获取明细表中平均单价
				 String sql = " select * from formtable_main_136 where requestId = "+requestid+"and supplier ="+supplierID+" and IndexNum = "+index+" ";
				 rs1.executeSql(sql);
				 if(rs1.next()){
				 	count2 = Util.null2String(rs1.getString("count"));//复核数量
					price2 = Util.null2String(rs1.getString("SupplierPrice"));//供应商单价
					total2 = Util.null2String(rs1.getString("Total"));//金额
					remark2 = Util.null2String(rs1.getString("Remark"));//备注
				 }
			%>

				<tr>
				<td><%=goodsname%></td>
				 <INPUT type="hidden" name="goodsname" value="<%=goodsname%>">
				 <INPUT type="hidden" name="index" value="<%=index%>">
				<td><%=Stock%></td>
				<INPUT type="hidden" name="Stock" value="<%=Stock%>">
				<td><%=AvgPrice%></td>
				<INPUT type="hidden" name="AvgPrice" value="<%=AvgPrice%>">
				<td><input id='count<%=index%>' type='text' class=inputstyle name="count" onblur='fun(<%=index%>)' value="<%=count2%>"></td>
				<td><input id='price<%=index%>' type='text' class=inputstyle name="SupplierPrice" onblur='fun(<%=index%>)' value="<%=price2%>"></td>
				<td><input id='total<%=index%>' class=inputstyle type='text' name="Total" value="<%=total2%>"></td>
				<td><input id='remark<%=index%>' name="Remark" type='remark' value="<%=remark2%>"></td>
			
				</tr>
				
		<%	
				index++;	
				//out.print("index="+index);	
			}
			//out.print("sum1="+sum1);	
		%>
		<!-- <tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td><input id="sum" value='<%=sum1%>' onblur='fun(<%=index%>)'></td>
				<td></td>
			
		</tr> -->
		</table>
		</form>
	<script type="text/javascript">

	function fun(index)
		{	
			//alert("index="+index);
			var count = document.getElementById("count"+index).value;//document 中value方法是获取值。
			var price = document.getElementById('price'+index).value;
			//alert("price="+price);
			document.getElementById('total'+index).value = count*price;
			//document.getElementById('sum').value = Number(document.getElementById('sum').value) + Number(count*price);
		}

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