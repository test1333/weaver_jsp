
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.conn.RecordSet"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ include file="/systeminfo/leftMenuCommon.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.*"%>
<%
int userid=user.getUID();
String loca=Util.null2String(request.getParameter("loca"),"1");
String coworkid=Util.null2String(request.getParameter("coworkid"),"-1");


String sql = "select name from nickname where userid = ?";
RecordSet rs = new RecordSet();
rs.executeQuery(sql,userid+"");
boolean hasnickname = false;
if(rs.getCounts()>0){
	hasnickname = true;
}

//增加说明页内容-从表单建模查询第一条配置内容
String ygtitel = ""; //标题
String setsetting = ""; //定时标题
String tpwidth = ""; //图片宽度
String tpheight = ""; //图片高度
int settime = 120; //定时默认时间/s
String setfile = ""; //说明图片附件
String sql_yg = "select * from uf_co_regiser_mg where rownum=1 order by id asc ";
RecordSet rs_yg = new RecordSet();
rs_yg.executeSql(sql_yg);
if(rs_yg.next()){
	ygtitel = Util.null2String(rs_yg.getString("ygtitel"));
	setsetting = Util.null2String(rs_yg.getString("setcontent"));
	tpwidth = Util.null2String(rs_yg.getString("tpwidth"));
	tpheight = Util.null2String(rs_yg.getString("tpheight"));
	settime = Util.getIntValue(Util.null2String(rs_yg.getString("settime")),120);
	setfile = Util.null2String(rs_yg.getString("setfile")); //图片附件
}

String setfiles[] = setfile.split(",");  //切割多个附件
String imagehtml = ""; //图片html总代码
String imagefilehtml = ""; //单个图片html

RecordSet rs_imagefile = new RecordSet();
String rs_imageSql = "select imagefileid from DocImageFile where docid = ";

for (int i=0; i<setfiles.length; i++ ){
	rs_imagefile.executeSql(rs_imageSql+setfiles[i]); 
	if(rs_imagefile.next()){
		imagefilehtml = "/weaver/weaver.file.FileDownload?fileid="+Util.null2String(rs_imagefile.getString("imagefileid"));
		if (!"".equals(Util.null2String(rs_imagefile.getString("imagefileid")))) {
			imagehtml += "<img src='"+imagefilehtml+"' id='imgcontent"+i+"' style='";
			if(!"".equals(tpwidth)){
				imagehtml += "width:" + tpwidth+";";
			}
			if(!"".equals(tpheight)){
				imagehtml += "height:" + tpheight+";";
			}
			imagehtml += "' class='img-rounded'>";
		}
	}

}


// hasnickname = false;
//new BaseBean().writeLog(hasnickname);
%>

<link rel="stylesheet" href="/css/ecology8/request/leftNumMenu_wev8.css" type="text/css" />
<script type="text/javascript" src="/js/ecology8/request/leftNumMenu_wev8.js"></script>
<script src="/js/tabs/jquery.tabs.extend_wev8.js"></script>
<script type="text/javascript" src="/js/ecology8/cowork/coworkview_wev8.js"></script>

<style>
.custom_btn_top{
    color: #fff;
    background-color: #D8D8D8;
    padding-left: 10px !important;
    padding-right: 10px !important;
    height: 23px;
    line-height: 22px;
    vertical-align: middle;
    border: 1px solid #D8D8D8;
    cursor: pointer;
}
</style>

</head>
<!--<body  style="background-image:url('/cowork/images/cowork_bg6.jpg');"> -->
<body>
<div class="container-fluid">
	<div class="row-fluid" style="height: 30px;width: 100%;position: relative;">
		<div class="span1" style="position: absolute;left: 0px;padding: 10px 25px 10px;font-size: 18px;">
    		<strong id="ydtitle"><!-- 左侧标题 --></strong>
		</div>
		<div class="span2" style="position: absolute;right: 0px;padding: 10px 35px 10px 0px;font-size: 16px;">
			<span class="setsetting"><!-- 右侧定时标题 --></span>
			<strong style="color: #2384bf;font-size: 16px;">
				<span class="settime"><!-- 定时时间 --></span>
			</strong>
			<input type=button class="RegiterButton custom_btn_top" onclick="doRegiter(this);" style="margin: 0px 0px 0px 20px;" value="注册">
		</div>
		
	</div>
	<div class="row-fluid" style="width: 100%;text-align: center;">
		<div id="ydimg" style="margin: 15px 0px 0px;"><!-- 图片 -->
		</div>
	</div>
	<div class="row-fluid" style="width: 100%;height:20px;margin:-20px 0px 30px 0px;">
		<div class="span2" style="position: absolute;right: 0px;padding: 10px 35px 10px 0px;font-size: 16px;">
			<span class="setsetting"><!-- 右侧定时标题 --></span>
			<strong style="color: #2384bf;font-size: 16px;">
				<span class="settime"><!-- 定时时间 --></span>
			</strong>
			<input type=button class="RegiterButton custom_btn_top" onclick="doRegiter(this);" style="margin: 0px 0px 0px 20px;" value="注册">
		</div>
	</div>	
</div>
</body>
<script>
 
	var ygtitel = "<%=ygtitel%>"; //页面左上角标题
	var setsetting = "<%=setsetting%>"; //页面右上角定时标题
	var tpwidth = "<%=tpwidth%>"; //图片宽度
	var tpheight = "<%=tpheight%>"; //图片高度
	var settime = "<%=settime%>"; //定时时间/s
	var imagehtml = "<%=imagehtml%>"; //图片总拼接html

	jQuery("#ydtitle").text(ygtitel);
	jQuery(".setsetting").text(setsetting);
	jQuery(".settime").text(settime+"秒");
	jQuery(".RegiterButton").attr("disabled",true);
	jQuery("#ydimg").append(imagehtml);
	var midtime = 1;
	var endtime = settime;
	var interval = setInterval(function () {
	    endtime = settime - midtime;
	    midtime ++;
	    jQuery(".settime").text(endtime+'秒');
	    if(endtime==0){
	    	showSubmitButton();
	    	clearInterval(interval);
	    	return;
	    }
	}, 1000);
	function showSubmitButton(){
		$(".RegiterButton").addClass("e8_btn_top_first");
		$(".RegiterButton").removeClass("custom_btn_top");
		jQuery(".RegiterButton").attr("disabled",false);	
	}
	
  var demoLeftMenus = "";
  var hasnickname = "<%=hasnickname%>";
  var loca = "<%=loca%>";
  var coworkid = "<%=coworkid%>";
  
	function doRegiter(obj){
		 // alert(hasnickname=="false");
		 
		 if(hasnickname=="false"){
		       var  inhtml = '		<div class="deletedialog none-select">';
				inhtml+= '	<table height="100%" border="0" align="center" cellpadding="10" cellspacing="20" style="padding-top:20px">';
				inhtml+= '		<tbody>';
				inhtml+= '			<tr>';
				inhtml+= '				<td align="left">';
				inhtml+= '					温馨提示：';
				inhtml+= '				</td>';
				inhtml+= '			</tr>';
				inhtml+= '			<tr>';
				inhtml+= '				<td align="left" colspan="2" style="font-size:9pt" id="Message_undefined">';
				inhtml+= '					1、浏览或参与发帖评论等，请注册账户。';
				inhtml+= '				</td> ';
				inhtml+= '			</tr>';
				inhtml+= '			<tr>';
				inhtml+= '				<td align="left" colspan="2" style="font-size:9pt" id="Message_undefined">';
				inhtml+= '					2、如有任何需求或疑问，可联系维信诺学院田安琪。';
				inhtml+= '				</td>';
				inhtml+= '			</tr>';
				inhtml+= '		</tbody>';
				inhtml+= '	</table>';
				inhtml+= '	<div class="isDelAll" style="padding-top:20px;margin-left: 75%;"> <div href="#" style="text-decoration: none;color: dodgerblue;cursor: pointer;" onclick="goregiste();">立即注册</div></div>';
				inhtml+= '</div>';
		     
		    //var parentWin = parent.getParentWindow(window);
		    //parentWin.closeDialog();
			// var diag = new window.top.Dialog();
		    var diag = new window.Dialog();
		    diag.Title = 'V来心声论坛注册提醒';
		    diag.Width = 280;
		    diag.Height = 230;
		    diag.normalDialog= false;
		    diag.ShowCloseButton = false;
		    diag.InnerHtml = inhtml;        
		    diag.show();    
		    $(window.top.document).find(".deletedialog").jNice();
		}
	}
 //  hasnickname = "false";
  $(document).ready(function(){

  });
   
 
	/*
		  document.onkeydown = killesc; 
function killesc(){
alert(1); 
alert(window.event.keyCode);  
if(window.event.keyCode==27)   
{   
window.event.keyCode=0;   
window.event.returnValue=false;   
return true;
}   
} */
	 
        

    
 function goregiste(){
 	var diag = new window.Dialog();
 	diag.Title = 'V来心声账号注册';
	//diag=getCoworkDialog("V来心声账号注册",100,100);
	diag.Width = 380;
    diag.Height = 185;
    diag.normalDialog= false;
    diag.URL = "/cowork/nickname/CoworkNicknameAdd.jsp?loca="+loca+"&coworkid="+coworkid;
    diag.show();
    document.body.click();
 }
 
function gg(){
alert(1);}
 
</script>
</html>

