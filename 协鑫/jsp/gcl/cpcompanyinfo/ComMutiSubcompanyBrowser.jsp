<%@ page language="java" contentType="text/html; charset=gbk" %>
<%@ page import="weaver.general.Util,java.sql.Timestamp,java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<HTML>
<HEAD>
<base/>
<link href="/cpcompanyinfo/style/Operations.css" rel="stylesheet"type="text/css" />
<link href="/cpcompanyinfo/style/Public.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/cpcompanyinfo/style/dhtmlxtree.css" type="text/css">
<script type="text/javascript" src="/cpcompanyinfo/js/dhtmlxcommon.js"></script>
<script type="text/javascript" src="/cpcompanyinfo/js/dhtmlxtree.js"></script>
</HEAD>
<BODY>
	
	<%
		String selevalue=Util.null2String(request.getParameter("selevalue"));
	 %>
   <div class="OContRightScroll" style="width:100%;height:440px;border: 1px solid #ccc;margin-top:10px">
		  <form name="userform">
		      <table width="100%" border="0" cellpadding="0" cellspacing="0"  align="center">
			        <tr>
			          <td valign="top" >
			                <div id="treeboxbox_tree1" style="width:100%;height:auto;"></div>
			          </td>
			        </tr>
			       
		       </table>
			            
		</form>
	</div>
	<ul class="OContRightMsg2" style="font-size:12px;margin-left: 230px">
		<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="check(1)" class="hover"><div><div><%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></div></div></a></li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="cleanall()" class="hover"><div><div><%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></div></div></a></li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="check(2)" class="hover"><div><div><%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></div></div></a></li>
	</ul>
		<script>
 			tree=new dhtmlXTreeObject("treeboxbox_tree1","100%","","-1");
			tree.setSkin('dhx_skyblue');
			tree.setImagePath("/cpcompanyinfo/images/");
			tree.enableCheckBoxes(1);
			tree.enableThreeStateCheckboxes(true);//设置选中根目录，选中下面的所有复选框
			tree.setXMLAutoLoading("/cpcompanyinfo/Comajaxmanage.jsp?selevalue=<%=selevalue%>");	
		    tree.loadXML("/cpcompanyinfo/Comajaxmanage.jsp?selevalue=<%=selevalue%>");
			function check(type_) {
				if(type_=="1"){
					 var tempstr="";
			         var idlisttree = tree.getAllChecked();
			         var temp=idlisttree.split(",");
			         //alert(tree.getItemText("31"));//获得指定节点的文本
			         for(var i=0;i<temp.length;i++)
			         {
			         	tempstr+="<a href='javascript:void(0)' style='text-decoration: inherit;'>"+tree.getItemText(temp[i])+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";
			         }
			          window.returnValue=new Array(tempstr,idlisttree);
			          window.close();		  
				}else{
					  window.returnValue=new Array("0","0");
					  window.close();		         
				}
		     }				
			function cleanall() {
				 window.returnValue=new Array("","");;
		         window.close();	
			}
			
		</script>

 </BODY>
 
 
</HTML>
