<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<%
	String id = Util.null2String(request.getParameter("id"));
	String uf = Util.null2String(request.getParameter("uf"));
	if("del".equals(uf)){
		String dtid = Util.null2String(request.getParameter("dtid"));
		if(dtid.length() > 1) {
			String deSQL = "delete from uf_ycjm where  id = " + dtid;
			RecordSet.executeSql(deSQL);
		}
	}else if("add".equals(uf)){
		String syxm = Util.null2String(request.getParameter("syxm"));
		// 获取唯一lcmx   手动添加的 按负数自增加
		String sql = "select min(lcmxid) as nw from uf_zy_dt9 where lcmxid < 0 ";
		RecordSet.executeSql(sql);
		int sf = 0;
		if(RecordSet.next()){
			sf = RecordSet.getInt("nw") - 1 ;
		}
		if(sf >= 0) sf = -1;
		
		// 查询入明细 dt9
		sql = "insert into uf_zy_dt9(mainid,lcmxid,syxm) values(" + id + "," +  sf  + "," + syxm + ")";
		RecordSet.executeSql(sql);
		
		sql = "insert into uf_ycjm(lcmxid,syxm) values(" + sf + "," +  syxm + ")";
		RecordSet.executeSql(sql);
	}
%>	
<SCRIPT>
	var diag_vote;
	function Foo(bttID){
		
		var title = "";
		var url = "/hehui/qa/ra/qaRAListOtherDetail1.jsp?mainid="+bttID;
//		alert(url);
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1700;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){
			diag_vote.close();
			window.location.reload();
		};
		diag_vote.show();
	}
	
	function closeDialog(){
		diag_vote.close();
	}
	
	function delitem(bttID){
		if(window.confirm('你是确认删除？')){
			var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=del&dtid="+bttID+"&id=<%=id%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
				 jQuery("#tableChlddivx").html(data);
			});
		}
	}
	
	function submitData(){
		var sData = jQuery("#syxm_dt").val();
		if(window.confirm('你是确认增加？')){
			var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=add&syxm="+sData+"&id=<%=id%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
				 jQuery("#tableChlddivx").html(data);
			});
		}
	}
</SCRIPT>
	<style type="text/css">
		.td_warp {
			width:95%;
			display: inline-block;
			text-align: center;
			height:33px;
			line-height: 33px;
			background-color: rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		.warp_cont{
			height:30px;
			width:90%;
			line-height: 25px;
		}
		.warp{
			width:97%;
		}
		.title{
			margin:2% auto;
			text-align: center;
		}
		.btnSummbit{  
			background-color:#10A0EA;  
			border:none;  
			height:40px;  
			color:white;  
			font-size:18px;  
			width:150px  
		} 
		
	    	.bg{
			width: 80px;
			height: 40px;
			background-color: #33CCFF;
			float:left;
		}
		.bg:hover{
			background-color: #FFCC66;
		}
		
		.bg1{
			width: 80px;
			height: 40px;
			background-color: #FF6633;
			float:left;
		}
		.bg1:hover{
			background-color: #FFCC66;
		}
		
		.div_warp div{
			float:left;
			width:10%;
			margin-left:3%;
		}
	</style>
</head>
		<body>
		<table align="center" width = "95%">
			<colgroup><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
						<col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
			</colgroup>
			<tbody>
			<tr><td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
				<td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
			<!--  系统开始记录表里信息    一个内容占据四行,   一行即一个TR占用 3个值内容   -->
			 <%
				String sql  = "select id,(select syxm  from uf_syxm u where u.id=f.syxm) as syxm1 "
					+" ,(select COUNT(1) from uf_ycjm_dt1 where mainid=f.id and zt=1) as fnum "
					+" from uf_ycjm f where lcmxid in(select lcmxid from uf_zy_dt9 where mainid=" + id + ") order by id ";
				RecordSet.executeSql(sql);
				int lineFlag = 0;
				while(RecordSet.next()){
					String t_id = Util.null2String(RecordSet.getString("id"));  		// 唯一标示
					String t_syxm = Util.null2String(RecordSet.getString("syxm1"));  // 实验目的
						
					int fnum = RecordSet.getInt("fnum");  // 是否有异常
											
					if(lineFlag%14 == 0){
						out.println("</tr><tr height=\"58px\">");
					}
					
					if(fnum > 0){
						out.println("	<td> <div class= \"bg1\"  onclick=\"Foo("+t_id+");\">");
					}else{
						out.println("	<td> <div class= \"bg\"  onclick=\"Foo("+t_id+");\">");
					}
					// 增加显示名和连接
					out.println(t_syxm + " : " + t_id);
					// 增加删除按钮
					out.println("  </div>&nbsp;<img src=\"/images/delete_wev8.gif\" height=\"20px\" onmouseover=\"this.style.border='1px solid #009933'\" onmouseout=\"this.style.border='none'\"    onclick=\"delitem(" + t_id + ")\">  ");
					// 增加隐藏字段	
					out.println("<input type=\"hidden\" name=\"uq_" + t_id + "\" value=\"" + t_id + "\" > ");
					out.println("	</td>");

					lineFlag++;
				}
			%>
		</tr>
	</tbody></table>
	</body>
</html>