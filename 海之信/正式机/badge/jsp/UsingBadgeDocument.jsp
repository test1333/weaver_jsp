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

		<table width=100% class=ViewForm id="count_table">
			<colgroup>
			<col width="20%"></col>
			<col width="80%"></col>
			</colgroup>
			<tr>
				<td>序号</td>
				<td>文档名称</td>
			</tr>		

		<%
			String UsingDocument ="";//用印文档
			String docsubject = "";//文档名称
			String sql = "";
			int val = 0;
			 //拿取用印证章的id
			String idkey = Util.null2String(request.getParameter("idkey"));
			 sql = "select UsingDocument from formtable_main_82 where id="+idkey+"";
			rs.executeSql(sql);
			if(rs.next()){
				UsingDocument =  Util.null2String(rs.getString("UsingDocument"));
			}
			String idArr[] = UsingDocument.split(",");
			for(int index=0;index<idArr.length;index++){
			 sql = "select docsubject from DocDetail where id ="+idArr[index];
			rs.executeSql(sql);
				while(rs.next()){
						 docsubject = Util.null2String(rs.getString("docsubject"));
						 val++;
					%>
			 
						 <tr>
						 	<td><%=val%></td>
							<td><a href="/docs/docs/DocDsp.jsp?id=<%=idArr[index]%>" target="_blank"><%=docsubject%></a></td>
						</tr>
					<%		
				}
			
			}
			%>

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