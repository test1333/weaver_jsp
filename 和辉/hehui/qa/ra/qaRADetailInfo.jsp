<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<HTML><HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<%
	String mainid = Util.null2String(request.getParameter("mainid"));
	String dtid = Util.null2String(request.getParameter("dtid"));
	String uf = Util.null2String(request.getParameter("uf"));
	
	String sqlxx = "";
	if("del".equals(uf)){
		if(dtid.length() > 1) {
			String deSQL = "delete from uf_ycjm_dt1 where mainid = " + mainid + " and id = " + dtid;
			RecordSet.executeSql(deSQL);
		}
	}else if("add".equals(uf)){
		String nz1 = Util.null2String(request.getParameter("nz1"));
		String nz2 = Util.null2String(request.getParameter("nz2"));
		String ztd = Util.null2String(request.getParameter("ztd"));
//		String maxNo = Util.null2String(request.getParameter("maxNo"));
		if(nz2.length() == 0 || nz2.trim().equals("PANELID")){
			out.print("1");
			return;
		}
		if(nz1.trim().equals("DEMONO"))  nz1 = "";
		if(ztd.length() == 0) ztd = "0";
		
//		if(maxNo.length() == 0 || nz1.length() == 0 ){
		if(nz1.length() == 0 ){
			RecordSet.executeSql("select (bh+1) as nbh from uf_ycjm_dt1 where id in (select MAX(id) from uf_ycjm_dt1 where mainid=" + mainid + ")");
			if(RecordSet.next()){
				nz1 =  Util.null2String(RecordSet.getString("nbh"));
			}
		}
		//else if(maxNo.length() >0){
		//	try { 
	//			long fN = Long.parseLong(maxNo, 10) + 1;
	//			nz1 = String.valueOf(fN);
	//		}catch (NumberFormatException e) {  
	//		    	nz1 = maxNo + 1;
	//	}  
//	}
		if(nz1.trim().length() == 0) nz1 = "1";
		RecordSet.executeSql("insert into uf_ycjm_dt1(mainid,PANEL,bh,zt) values("+mainid+",'"+nz2+"','"+nz1+"',"+ztd+")");
	}else if("update".equals(uf)){
		String ztd = Util.null2String(request.getParameter("ztd"));
		if(ztd.length() == 0) ztd = "0";
		sqlxx = "update uf_ycjm_dt1 set zt = " + ztd + " where  id = "+dtid+" and  mainid=" + mainid;
		RecordSet.executeSql("update uf_ycjm_dt1 set zt = " + ztd + " where  id = "+dtid+" and  mainid=" + mainid );
		
	}
%>	

<SCRIPT>
	function changeColorx(bttID){
		var bttSptID = "#btt" + bttID;
		var ztdID = "#ztd_x" ;
		var bttSpt = jQuery(bttSptID);
//		alert("1 = " + bttSpt.attr("class"));
//		alert("2 = " + bttSpt.text());
		if(jQuery(bttSptID).attr("class") == 'btnNormal'){
			jQuery(bttSptID).removeClass("btnNormal");
			jQuery(bttSptID).addClass("btnException");
			jQuery(bttSptID).text("异 常");
			jQuery(ztdID).val("1");
		}else if(jQuery(bttSptID).attr("class") == 'btnException'){
			jQuery(bttSptID).removeClass("btnException");
			jQuery(bttSptID).addClass("btnNormal");
			jQuery(bttSptID).text("正 常");
			jQuery(ztdID).val("0");
		}
		
	}
	
	// 重新计算 fail  总片数
	function calFailAll(){
		var allNum = 0;
		var failNum = 0;
	//	alert(" allNum : " + allNum + " ; failNum : " + failNum); 
		var baseFd = "#ztd_";
		for(var index = 0; index < 500;index++){
			var tmpFd = baseFd + index;
	//		alert(" tmpFd = " + tmpFd);
			if(jQuery(tmpFd).length > 0){
		//		alert("存在");
				allNum = allNum + 1;
				var tmpVal = jQuery(tmpFd).val();
				// 异常状态
				if(tmpVal == "1"){
					failNum = failNum + 1;
				//	alert("tmpFd = " + tmpFd + " ; failNum = " + failNum) ;
				}
			}else{
			//	alert("不存在");
				index = 500;
			}
		}
//		alert(" allNum : " + allNum + " ; failNum "); 
		// 结束后 赋值
		jQuery("#FAILps").val(failNum);
		jQuery("#FAILbl").val(failNum);
		jQuery("#FAILbl1").val(allNum);
	}
	
	function changeColor(bttID){
		var bttSptID = "#btt" + bttID;
		var ztdID = "#ztd_" + bttID;
		var bttSpt = jQuery(bttSptID);
//		alert("1 = " + bttSpt.attr("class"));
//		alert("2 = " + bttSpt.text());
		var zt_val = "";
		if(jQuery(bttSptID).attr("class") == 'btnNormal'){
			jQuery(bttSptID).removeClass("btnNormal");
			jQuery(bttSptID).addClass("btnException");
			jQuery(bttSptID).text("异 常");
			jQuery(ztdID).val("1");
			zt_val = "1";
		}else if(jQuery(bttSptID).attr("class") == 'btnException'){
			jQuery(bttSptID).removeClass("btnException");
			jQuery(bttSptID).addClass("btnNormal");
			jQuery(bttSptID).text("正 常");
			jQuery(ztdID).val("0");
			zt_val = "0";
		}
		
		var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=update&ztd="+zt_val +"&dtid=" + bttID +"&mainid=<%=mainid%>";
	//	alert("urlx = " + urlx);
		$.get(urlx,function(data,status){
		//	alert("Data: " + data + "\nStatus: " + status);
			if(data != "1"){
				 jQuery("#tableChlddiv").html(data);
				 calFailAll();
			}
		});
		
	}
	var diag_vote;
	function edtitem(bttID){
		var title = "";
		var url = "/hehui/qa/ra/lqOperLoad.jsp?id="+bttID;
		
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 370;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.show();
	}
	
	function closeDialog(){
		diag_vote.close();
	}
	
	function addPan(){
		var nz1 = jQuery("#nz1").val();
		var nz2 = jQuery("#nz2").val();
		var ztd = jQuery("#ztd_x").val();
		if(nz2 == ''){
			 jQuery("#nz2").val(' PANELID');
		}else{
			 jQuery("#nz1").val(" DEMONO");
			var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=add&ztd="+ztd+"&nz1="+nz1 + "&nz2=" + nz2+"&mainid=<%=mainid%>";
		//	alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
		//		alert("Data: " + data + "\nStatus: " + status);
				if(data != "1"){
					 jQuery("#tableChlddiv").html(data);
					 calFailAll();
				}
			});
		}
	}
	
	function delitem(bttID){
	//	alert("delitem = " + bttID);
		if(window.confirm('你是确认删除？')){
			var urlx = "/hehui/qa/ra/qaRADetailInfo.jsp?uf=del&dtid="+bttID+"&mainid=<%=mainid%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
			//	alert("Data: " + data + "\nStatus: " + status);
				 jQuery("#tableChlddiv").html(data);
				 calFailAll();
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
		
		.det_cont{
			border: 1px solid #10A0EA;
			height:30px;
			width:85%;
			line-height: 25px;
	/*		color:rgb(255,255,255);*/
		/*	background-color:#10A0EA; */
		}
		
		.det1_cont{
			border: none;
			width:170px;
			height:29px;
			line-height: 26px;
			color:#ADADAD;
		}
		.btnSummbit{  
			background-color:#10A0EA;  
			border:none;  
			height:60px;  
			color:white;  
			font-size:24px;  
			width:100px  
		}  
		
		.div_input{
			width:97%;
		/*	 background-color:#10A0EA; */
		 	 position:relative;
    		}
		
		.warp{
			width:97%;
		}
		.title{
			margin:2% auto;
			text-align: center;
		}
		
		.btnNormal{  
			background-color:#009100;  
			border:none;  
			height:30px;  
			color:white;  
			font-size:12px;  
			width:55px  
		}  
		.btnException{  
			background-color:#EA0000;  
			border:none;  
			height:30px;  
			color:white;  
			font-size:12px;  
			width:55px  
		} 
		
	</style>
</head>
		<body>
		
	<table align="center" width = "95%">
	
		<colgroup><col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/>
					<col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/>
					<col width="4%"/><col width="10%"/><col width="13%"/><col width="6%"/></colgroup>
		<tbody>
			<tr><td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
			<td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
			<td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> <td> &nbsp;</td> 
			<!--  系统开始记录表里信息    一个内容占据四行,   一行即一个TR占用 3个值内容   -->
			 <%
				RecordSet.executeSql("select * from uf_ycjm_dt1 where mainid = " + mainid + " order by id");	
				int lineFlag = 0;
				while(RecordSet.next()){
					if(lineFlag %3 == 0){
						out.println("</tr><tr height=\"38px\">");
					}
					String t_id = Util.null2String(RecordSet.getString("id")); //唯一标示
					// 状态标示
					String t_status = Util.null2String(RecordSet.getString("zt")); //状态
					// 增加隐藏字段	
					out.println("	<td>");
					if("1".equals(t_status)){
						out.println("<button  id = \"btt" + t_id + "\"  type = \"button\" onclick=\"changeColor(" + t_id + ")\" class = \"btnException\">异 常</button>");
					}else{
						out.println("<button  id = \"btt" + t_id + "\"  type = \"button\" onclick=\"changeColor(" + t_id + ")\" class = \"btnNormal\">正 常</button>");
						t_status = "0";
					}
					out.println("<input type=\"hidden\" id =\"ztd_" + lineFlag + "\"  name=\"ztd_" + t_id + "\" value=\"" + t_status + "\" > ");
					out.println("	</td>");
					//  PANEL bh
					String t_panel = Util.null2String(RecordSet.getString("PANEL")); //PANEL ID
					String t_code = Util.null2String(RecordSet.getString("bh")); //RA 编号
					out.println("	<td align=\"center\" > <div class=\"div_input\"><input type = \"text\" class=\"det_cont\"  value = \"" + t_panel + "\" name = \"PANEL _" + t_id +"\"/> </td></div>");
					out.println("	<td align=\"center\" > <div class=\"div_input\"><input type = \"text\" class=\"det_cont\"  value = \"" + t_code + "\" name = \"bh _" + t_id +"\"/> </td></div>");
					
					
					//    编辑 ：/images/edit_wev8.gif     删除/images/delete_wev8.gif
					out.println("  <td><img src=\"/images/edit_wev8.gif\" height=\"20px\" onclick=\"edtitem(" + t_id + ")\"> &nbsp");
					out.println("  	<img src=\"/images/delete_wev8.gif\" height=\"20px\" onclick=\"delitem(" + t_id + ")\"></td>");
					lineFlag++;
				}
			%>
			</tr>
		</tbody>
	</table>
					</body>
				</html>