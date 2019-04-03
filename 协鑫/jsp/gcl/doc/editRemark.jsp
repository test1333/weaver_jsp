<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="gcl.doc.workflow.DocUtil" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<html>
	<head>
		<script type="text/javascript" src="/js/weaver.js"></script>
		<link rel="stylesheet" type="text/css" href="/css/Weaver.css">
		<link rel="stylesheet" type="text/css" href="/css/crmcss/lanlv.css">
	</head>
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
		<script>   
			var  obj  =  window.dialogArguments   
			var keyid=obj.keyid;
       </script>  
	<BODY>
		<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
		<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.weaver.submit(),_top} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu.jsp" %>
		<FORM id=report name=report action="" method=post>
			<input type="hidden" name="requestid" value="">
			<table  cellpadding="0" cellspacing="0">
				<tr>
					
				</tr>
			</table>
				
		</FORM>
		<table class="ViewForm1" >
   		 <tbody>
        <tr>			
            <td><br />
			
			<div align="right"> 

				<input type="button" value="保存" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis; max-width: 100px;" onclick="winClose(1);"/>
			
				<span >&nbsp;&nbsp;&nbsp;&nbsp;</span>				 
			</div>
            <title></title>
			<FORM id=report1 name=report1 action="" method=post>
            <table class="ViewForm1  maintable">
                <colgroup>  <col width="50px"></col><col width="100px"></col> <col width="250px"></col><col width="50px"></col> </colgroup>
                <tbody>
                   
				 <tr>
					 <td>&nbsp;</td>
	                    <td class="fname">&nbsp;&nbsp;原因</td>
                        <td class="fvalue">&nbsp;&nbsp;<input  id="yy" type="text" value="" name="yy" /></td>                                               
	                    
						<td>&nbsp;</td>		
                 </tr>
				
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
</FORM>
		<script type="text/javascript">
		function winClose(isRefrash){
			if(confirm("是否确认更改已传阅状态")){
				var yy_val = jQuery("#yy").val();
				if(yy_val == ""){
					alert("请先填写原因，再保存");
					return false;
				}else{
					//alert(keyid);
					$.ajax({
						type: "POST",
						url: "/gcl/doc/docaction.jsp",
						data: {'billid':keyid, 'creater':'','type':'upstatus','reason':yy_val},
						dataType: "text",
						async:false,//同步   true异步
						success: function(data){
									data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
									//alert(data);
								}
						});
					window.returnValue = isRefrash;
					window.close();
				}
            }else{
                 return false;
            }

			
		}
		
		</script>
		<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
	</BODY>
</HTML>