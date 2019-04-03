<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var ywlx="#field33780";//业务类型
var wllx="#field33781";//物料类型
var wllxid="field33781";
var butt1="#butt1";//明细1button K-基本视图数据
var butt2="#butt2";//明细2button E-采购视图
var butt3="#butt3";//明细3button D-MRP视图
var butt4="#butt4";//明细4button L-工厂存储视图
var butt5="#butt5";//明细5button Q-质量管理视图
var butt6="#butt6";//明细6button B-G财务会计视图
var butt7="#butt7";//明细7button V-销售视图
var butt8="#butt8";//明细8button A-工作计划视图
var butt9="#butt9";//明细9button X-删除标识
var wlbm_dt1="field34733_";//SAP物料编码
var wlms_dt1="field33097_";//物料描述明细1
var jbjldw_dt1="field33093_";//基本计量单位明细1
var wlz_dt1="field33098_";//物料组明细1	
var zldw_dt1="field33094_";//重量单位明细1
var mz_dt1="field33038_";//毛重明细1
var jz_dt1="field33039_";//净重明细1
var kgcwlzt_dt1="field33095_";//跨工厂物料状态明细1
var spbzsm_dt1="field33040_";//审批备注说明明细1
//var zhjsm_dt4="field33560_";//总货架寿命
//var zxsyhjsm_dt4="field33559_";//最小剩余货架寿命
//var jgkz_dt6="field33588_";//价格控制
//var bzjg_dt6="field33591_";//标准价格
//var jgqd_dt6="field33592_";//价格确定
//var mrplx_dt3="field33242_";//MRP类型
//var mrpkzz_dt3="field33243_";//MRP控制者
//var zdhd_dt3="field33244_";//再订货点
//var pldxcl_dt3="field33245_";//批量大小策略
//var gdpldx_dt3="field33246_";//固定批量大小
//var jhclz_dt3="field33269_";//计划策略组
//var zhmrp_dt3="field33274_";//综合MRP
var ywlx_old="";
var wllx_old="";
//E-采购=视图
var wlbm_dt2="field33107_";//sap物料编号
var wlms_dt2="field33548_";//物料描述
var jbjldw_dt2="field33109_";//基本计量单位
var gc_dt2="field33110_";//工厂
var cgz_dt2="field33111_";//采购组
var dddw_dt2="field33112_";//订单单位
var dwfz_dt2="field33113_";//单位分子
var dwfm_dt2="field33114_";//单位分母
var shclsj_dt2="field33115_";//收货处理时间
var hyqd_dt2="field33124_";//货源清单
var peap_dt2="field33846_";//配额安排

//L-工厂存储视图
var wlbm_dt4="field33145_";//sap物料编号
var wlms_dt4="field33551_";//物料描述
var jbjldw_dt4="field33147_";//基本计量单位
var gc_dt4="field33148_";//工厂
var pcgl_dt4="field33558_";//批次管理
var zxsyhjsm_dt4="field33559_";//最小剩余货架寿命
var zhjsm_dt4="field33560_";//总货架寿命
	
//Q-质量管理视图
var wlbm_dt5="field33149_";//sap物料编号
var wlms_dt5="field33552_";//物料描述
var jbjldw_dt5="field33151_";//基本计量单位
var gc_dt5="field33152_";//工厂
var jcjg_dt5="field33564_";//检查间隔
var jylx1_dt5="field33565_";//检验类型1
var hdd1_dt5="field33566_";//活动的1
var jylx2_dt5="field33567_";//检验类型2
var hdd2_dt5="field33568_";//活动的2
var jylx3_dt5="field33569_";//检验类型3
var hdd3_dt5="field33570_";//活动的3
var jylx4_dt5="field33571_";//检验类型4
var hdd4_dt5="field33572_";//活动的4

//B-G财务会计视图
var wlbm_dt6="field33153_";//sap物料编号
var wlms_dt6="field33553_";//物料描述
var jbjldw_dt6="field33155_";//基本计量单位
var gc_dt6="field33156_";//工厂
var pgl_dt6="field33587_";//评估类
var jgkz_dt6="field33588_";//价格控制
var jgdw_dt6="field33589_";//价格单位
var ydpjj_dt6="field33590_";//移动平均价
var bzjg_dt6="field33591_";//标准价格
var jgqd_dt6="field33592_";//价格确认
var ysz_dt6="field33610_";//原始组
var cym_dt6="field33612_";//差异码
var lrzx_dt6="field33614_";//利润中心
	
//V-销售视图
var wlbm_dt7="field33157_";//sap物料编号
var wlms_dt7="field33554_";//物料描述
var jbjldw_dt7="field33159_";//基本计量单位
var gc_dt7="field33160_";//工厂
var xszz_dt7="field33690_";//销售组织
var fxqd_dt7="field33691_";//分销渠道
var cpz_dt7="field33692_";//产品组
var jhgc_dt7="field33693_";//交货工厂
var sfss_dt7="field33694_";//是否收税
var wlz_dt7="field33695_";//物料组
var zzz_dt7="field33696_";//装载组
var lrzx_dt7="field33697_";//利润中心	
	
//A-工作计划视图
var wlbm_dt8="field33161_";//sap物料编号
var wlms_dt8="field33555_";//物料描述
var jbjldw_dt8="field33163_";//基本计量单位
var gc_dt8="field33164_";//工厂
var scgly_dt8="field33748_";//生产管理员
var cnscsj_dt8="field33749_";//厂内生产时间
	
//A-工作计划视图
var wlbm_dt3="field33130_";//sap物料编号
var wlms_dt3="field33550_";//物料描述
var jbjldw_dt3="field33132_";//基本计量单位
var gc_dt3="field33133_";//工厂
var mrpz_dt3="field33240_";//mrp组
var abcbs_dt3="field33241_";//abc标识
var mrplx_dt3="field33242_";//mrp类型
var mrpkzz_dt3="field33243_";//mrp控制者
var zdhd_dt3="field33244_";//再订货点
var pldxcl_dt3="field33245_";//批量大小策略
var gdpldx_dt3="field33246_";//固定批量大小
var srz_dt3="field33247_";//舍入值
var cglx_dt3="field33248_";//采购类型
var tshqlx_dt3="field33249_";//特殊获取类型
var jhjhsj_dt3="field33250_";//计划交货时间
var shclsj_dt3="field33251_";//收货处理时间
var jhbjm_dt3="field33252_";//计划边际码
var scccdd_dt3="field33266_";//生产仓储地点
var wbcgczdd_dt3="field33267_";//外部采购仓储地点
var aqkc_dt3="field33268_";//安全库存
var jhclz_dt3="field33269_";//计划策略组
var xhms_dt3="field33271_";//消耗模式
var xqxhqj_dt3="field33272_";//向前消耗期间
var xhxhqj_dt3="field33273_";//向后消耗期间
var zhmrp_dt3="field33274_";//综合mrp
var kyxjc_dt3="field33275_";//可用性检查
var dljzbs_dt3="field33276_";//独立集中标识	
jQuery(document).ready(function(){
	  var ywlx_val = jQuery(ywlx).val();
	   if(ywlx_val !=''){
	   	   ywlx_old = ywlx_val;
	          jQuery(ywlx+"_browserbtn").attr('disabled',true);
	    }	
	     var wllx_val = jQuery(wllx).val();
	   if(wllx_val !=''){
	          jQuery(wllx+"_browserbtn").attr('disabled',true);
	    }
	    if(ywlx_val=='A01'){
	   removeaddcheckmain(ywlx_val);
	}
	jQuery("#fz2").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(2)' >");
	jQuery("#fz4").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(4)' >");
	jQuery("#fz5").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(5)' >");
	jQuery("#fz6").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(6)' >");
	jQuery("#fz7").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(7)' >");
	jQuery("#fz8").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(8)' >");
	jQuery("#fz3").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='加载' onclick='getdata(3)' >");

        showhideButton(ywlx_val,wllx_val);
        changedt4();
        changedt1();
        changedt6();
        changedt3();
	  jQuery(ywlx).bindPropertyChange(function () {
	  	  jQuery(ywlx+"_browserbtn").attr('disabled',true);
		  var ywlx_val = jQuery(ywlx).val();
		  var wllx_val = jQuery(wllx).val();
                if(ywlx_old==''){
                	ywlx_old = ywlx_val; 
              }else{
               jQuery(ywlx).val(ywlx_old);
                jQuery(ywlx+"span").text(ywlx_old);	  
            }
		  if(ywlx_val !="A01"){
		       jQuery(wllx+"_browserbtn").attr('disabled',true);
		       jQuery(wllx).val("");
		       jQuery(wllx+"span").text("");
		  }else{
		    removeaddcheckmain(ywlx_val);
		 }
		  showhideButton(ywlx_val,wllx_val);
	 })
	jQuery(wllx).bindPropertyChange(function () {
	  	  jQuery(wllx+"_browserbtn").attr('disabled',true);
		  var wllx_val = jQuery(wllx).val();
		  var ywlx_val = jQuery(ywlx).val();
		  showhideButton(ywlx_val,wllx_val);
		  changedt1();
		     if(wllx_old==''){
                	wllx_old = wllx_val; 
              }else{
               jQuery(wllx).val(wllx_old);
                jQuery(wllx+"span").text(wllx_old);	  
            }
	 })
	jQuery("#indexnum0").bindPropertyChange(function () {
		
		setTimeout('changedt1()',1000);
	});
	jQuery("#indexnum3").bindPropertyChange(function () {
		
	setTimeout('changedt4()',1000);
	});
	jQuery("#indexnum5").bindPropertyChange(function () {
		
		setTimeout('changedt6()',1000);
	});
	jQuery("#indexnum2").bindPropertyChange(function () {
		
setTimeout('changedt3()',1000);
	});
	
});	
function getdata(type){
	var wlbhall= getallwlbh();
	var i_view="";
	if(type == 2){
		i_view="E";
		getdata2E(wlbhall,i_view);
	}else if(type == 3){
		i_view="D";
		getdata3D(wlbhall,i_view);
	}else if(type == 4){
		i_view="L";
		getdata4L(wlbhall,i_view);
	}else if(type == 5){
		i_view="Q";
		getdata5Q(wlbhall,i_view);
	}else if(type == 6){
		i_view="B";
		getdata6B(wlbhall,i_view);
	}else if(type == 7){
		i_view="V";
		getdata7V(wlbhall,i_view);
	}else if(type == 8){
		i_view="A";
		getdata8A(wlbhall,i_view);
	}	

}
function getdata2E(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum1=  jQuery("#indexnum1").val();
     var xhr2 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr2 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr2 = new XMLHttpRequest();
  	  }
  	   if (null != xhr2) {
  	   	   	xhr2.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr2.onreadystatechange = function () {
	if (xhr2.readyState == 4) {
	  if (xhr2.status == 200) {
		var text = xhr2.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow1(1);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  jQuery("#"+wlbm_dt2+i).val(tmp_arr[0]);
		  jQuery("#"+wlbm_dt2+i+"span").text(tmp_arr[0]);
		  jQuery("#"+wlms_dt2+i).val(tmp_arr[1]);
		  jQuery("#"+wlms_dt2+i+"span").text(tmp_arr[1]);
		  jQuery("#"+jbjldw_dt2+i).val(tmp_arr[2]);
		  jQuery("#"+jbjldw_dt2+i+"span").text(tmp_arr[2]);
		  jQuery("#"+cgz_dt2+i).val(tmp_arr[4]);
		  jQuery("#"+cgz_dt2+i+"span").text(tmp_arr[4]);
		  jQuery("#"+dddw_dt2+i).val(tmp_arr[5]);
		  jQuery("#"+dddw_dt2+i+"span").text(tmp_arr[5]);
		  jQuery("#"+dwfz_dt2+i).val(tmp_arr[6]);
		  jQuery("#"+dwfm_dt2+i).val(tmp_arr[7]);
		  jQuery("#"+shclsj_dt2+i).val(tmp_arr[8]);
		  jQuery("#"+hyqd_dt2+i).val(tmp_arr[9]);
		  jQuery("#"+hyqd_dt2+i+"span").text(tmp_arr[9]);
		  jQuery("#"+peap_dt2+i).val(tmp_arr[10]);
		  jQuery("#"+peap_dt2+i+"span").text(tmp_arr[10]);
		  
	     }
          }
	  }
	 }
       xhr2.send(null);
     }
}


function getdata4L(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum3=  jQuery("#indexnum3").val();
     var xhr4 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr4 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr4 = new XMLHttpRequest();
  	  }
  	   if (null != xhr4) {
  	   	   	xhr4.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr4.onreadystatechange = function () {
	if (xhr4.readyState == 4) {
	  if (xhr4.status == 200) {
		var text = xhr4.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum3);
		for(var i=indexnum3;i<length1;i++){
		  addRow3(3);
		  var tmp_arr = text_arr[i-indexnum3].split("###");
		  jQuery("#"+wlbm_dt4+i).val(tmp_arr[0]);
		  jQuery("#"+wlbm_dt4+i+"span").text(tmp_arr[0]);
		  jQuery("#"+wlms_dt4+i).val(tmp_arr[1]);
		  jQuery("#"+wlms_dt4+i+"span").text(tmp_arr[1]);
		  jQuery("#"+jbjldw_dt4+i).val(tmp_arr[2]);
		  jQuery("#"+jbjldw_dt4+i+"span").text(tmp_arr[2]);
		  jQuery("#"+pcgl_dt4+i).val(tmp_arr[6]);
		  jQuery("#"+pcgl_dt4+i+"span").text(tmp_arr[6]);
		  jQuery("#"+zxsyhjsm_dt4+i).val(tmp_arr[4]);
		  jQuery("#"+zhjsm_dt4+i).val(tmp_arr[5]);
		  
	     }
          }
	  }
	 }
       xhr4.send(null);
     }
     changedt4();
}

	
function getdata5Q(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum4=  jQuery("#indexnum4").val();
     var xhr5 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr5 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr5 = new XMLHttpRequest();
  	  }
  	   if (null != xhr5) {
  	   	   	xhr5.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr5.onreadystatechange = function () {
	if (xhr5.readyState == 4) {
	  if (xhr5.status == 200) {
		var text = xhr5.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum4);
		for(var i=indexnum4;i<length1;i++){
		  addRow4(4);
		  var tmp_arr = text_arr[i-indexnum4].split("###");
		  jQuery("#"+wlbm_dt5+i).val(tmp_arr[12]);
		  jQuery("#"+wlbm_dt5+i+"span").text(tmp_arr[12]);
		  jQuery("#"+wlms_dt5+i).val(tmp_arr[2]);
		  jQuery("#"+wlms_dt5+i+"span").text(tmp_arr[2]);
		  jQuery("#"+jbjldw_dt5+i).val(tmp_arr[3]);
		  jQuery("#"+jbjldw_dt5+i+"span").text(tmp_arr[3]);
		  jQuery("#"+jcjg_dt5+i).val(tmp_arr[10]);
		  jQuery("#"+jylx1_dt5+i).val(tmp_arr[1]);
		  jQuery("#"+jylx1_dt5+i+"span").text(tmp_arr[1]);
		  jQuery("#"+hdd1_dt5+i).val(tmp_arr[5]);
		  jQuery("#"+hdd1_dt5+i+"span").text(tmp_arr[5]);
		  jQuery("#"+jylx2_dt5+i).val(tmp_arr[6]);
		  jQuery("#"+jylx2_dt5+i+"span").text(tmp_arr[6]);
		  jQuery("#"+hdd2_dt5+i).val(tmp_arr[0]);
		  jQuery("#"+hdd2_dt5+i+"span").text(tmp_arr[0]);
		  jQuery("#"+jylx3_dt5+i).val(tmp_arr[7]);
		  jQuery("#"+jylx3_dt5+i+"span").text(tmp_arr[7]);
		  jQuery("#"+hdd3_dt5+i).val(tmp_arr[8]);
		  jQuery("#"+hdd3_dt5+i+"span").text(tmp_arr[8]);
		  jQuery("#"+jylx4_dt5+i).val(tmp_arr[9]);
		  jQuery("#"+jylx4_dt5+i+"span").text(tmp_arr[9]);
		  jQuery("#"+hdd4_dt5+i).val(tmp_arr[11]);
		  jQuery("#"+hdd4_dt5+i+"span").text(tmp_arr[11]);
		  
	     }
          }
	  }
	 }
       xhr5.send(null);
     }
}

	
function getdata6B(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum5=  jQuery("#indexnum5").val();
     var xhr6 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr6 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr6 = new XMLHttpRequest();
  	  }
  	   if (null != xhr6) {
  	   	   	xhr6.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr6.onreadystatechange = function () {
	if (xhr6.readyState == 4) {
	  if (xhr6.status == 200) {
		var text = xhr6.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum5);
		for(var i=indexnum5;i<length1;i++){
		  addRow5(5);
		  var tmp_arr = text_arr[i-indexnum5].split("###");
		  jQuery("#"+wlbm_dt6+i).val(tmp_arr[12]);
		  jQuery("#"+wlbm_dt6+i+"span").text(tmp_arr[12]);
		  jQuery("#"+wlms_dt6+i).val(tmp_arr[5]);
		  jQuery("#"+wlms_dt6+i+"span").text(tmp_arr[5]);
		  jQuery("#"+jbjldw_dt6+i).val(tmp_arr[6]);
		  jQuery("#"+jbjldw_dt6+i+"span").text(tmp_arr[6]);
		  jQuery("#"+pgl_dt6+i).val(tmp_arr[13]);
		  jQuery("#"+pgl_dt6+i+"span").text(tmp_arr[13]);
		  jQuery("#"+jgkz_dt6+i).val(tmp_arr[2]);
		  jQuery("#"+jgkz_dt6+i+"span").text(tmp_arr[2]);
		  jQuery("#"+jgdw_dt6+i).val(tmp_arr[7]);
		  jQuery("#"+ydpjj_dt6+i).val(tmp_arr[3]);
		  jQuery("#"+bzjg_dt6+i).val(tmp_arr[0]);
		  jQuery("#"+jgqd_dt6+i).val(tmp_arr[8]);
		  jQuery("#"+jgqd_dt6+i+"span").text(tmp_arr[8]);
		  jQuery("#"+ysz_dt6+i).val(tmp_arr[9]);
		  jQuery("#"+ysz_dt6+i+"span").text(tmp_arr[9]);
		  jQuery("#"+cym_dt6+i).val(tmp_arr[11]);
		  jQuery("#"+cym_dt6+i+"span").text(tmp_arr[11]);
		  jQuery("#"+lrzx_dt6+i).val(tmp_arr[1]);
		  jQuery("#"+lrzx_dt6+i+"span").text(tmp_arr[1]);
		  
	     }
          }
	  }
	 }
       xhr6.send(null);
     }
     changedt6();
}

function getdata7V(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum6=  jQuery("#indexnum6").val();
     var xhr7 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr7 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr7 = new XMLHttpRequest();
  	  }
  	   if (null != xhr7) {
  	   	   	xhr7.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr7.onreadystatechange = function () {
	if (xhr7.readyState == 4) {
	  if (xhr7.status == 200) {
		var text = xhr7.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum6);
		for(var i=indexnum6;i<length1;i++){
		  addRow6(6);
		  var tmp_arr = text_arr[i-indexnum6].split("###");
		  jQuery("#"+wlbm_dt7+i).val(tmp_arr[3]);
		  jQuery("#"+wlbm_dt7+i+"span").text(tmp_arr[3]);
		  jQuery("#"+wlms_dt7+i).val(tmp_arr[4]);
		  jQuery("#"+wlms_dt7+i+"span").text(tmp_arr[4]);
		  jQuery("#"+jbjldw_dt7+i).val(tmp_arr[10]);
		  jQuery("#"+jbjldw_dt7+i+"span").text(tmp_arr[10]);
		  jQuery("#"+xszz_dt7+i).val(tmp_arr[5]);
		  jQuery("#"+xszz_dt7+i+"span").text(tmp_arr[5]);
		  jQuery("#"+fxqd_dt7+i).val(tmp_arr[6]);
		  jQuery("#"+fxqd_dt7+i+"span").text(tmp_arr[6]);
		  jQuery("#"+cpz_dt7+i).val(tmp_arr[11]);
		  jQuery("#"+cpz_dt7+i+"span").text(tmp_arr[11]);
		  jQuery("#"+jhgc_dt7+i).val(tmp_arr[7]);
		  jQuery("#"+jhgc_dt7+i+"span").text(tmp_arr[7]);
		  jQuery("#"+sfss_dt7+i).val(tmp_arr[8]);
		  jQuery("#"+sfss_dt7+i+"span").text(tmp_arr[8]);
		  jQuery("#"+wlz_dt7+i).val(tmp_arr[0]);
		  jQuery("#"+wlz_dt7+i+"span").text(tmp_arr[0]);
		  jQuery("#"+zzz_dt7+i).val(tmp_arr[9]);
		  jQuery("#"+zzz_dt7+i+"span").text(tmp_arr[9]);
		  jQuery("#"+lrzx_dt7+i).val(tmp_arr[1]);
		  jQuery("#"+lrzx_dt7+i+"span").text(tmp_arr[1]);
		  
	     }
          }
	  }
	 }
       xhr7.send(null);
     }
}

function getdata8A(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum7=  jQuery("#indexnum7").val();
     var xhr8 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr8 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr8 = new XMLHttpRequest();
  	  }
  	   if (null != xhr8) {
  	   	   	xhr8.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr8.onreadystatechange = function () {
	if (xhr8.readyState == 4) {
	  if (xhr8.status == 200) {
		var text = xhr8.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum7);
		for(var i=indexnum7;i<length1;i++){
		  addRow7(7);
		  var tmp_arr = text_arr[i-indexnum7].split("###");
		  jQuery("#"+wlbm_dt8+i).val(tmp_arr[5]);
		  jQuery("#"+wlbm_dt8+i+"span").text(tmp_arr[5]);
		  jQuery("#"+wlms_dt8+i).val(tmp_arr[0]);
		  jQuery("#"+wlms_dt8+i+"span").text(tmp_arr[0]);
		  jQuery("#"+jbjldw_dt8+i).val(tmp_arr[1]);
		  jQuery("#"+jbjldw_dt8+i+"span").text(tmp_arr[1]);
		  jQuery("#"+scgly_dt8+i).val(tmp_arr[3]);
		  jQuery("#"+scgly_dt8+i+"span").text(tmp_arr[3]);
		  jQuery("#"+cnscsj_dt8+i).val(tmp_arr[4]);
		  
	     }
          }
	  }
	 }
       xhr8.send(null);
     }
}

	
function getdata3D(I_MATNR,I_VIEW){
  if(I_MATNR == ""||I_VIEW==""){
    return;
  }	
   var indexnum2=  jQuery("#indexnum2").val();
     var xhr3 = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr3 = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr3 = new XMLHttpRequest();
  	  }
  	   if (null != xhr3) {
  	   	   	xhr3.open("GET","/gvo/sap/GetSapViewData.jsp?I_MATNR="+I_MATNR+"&I_VIEW="+I_VIEW, false);
	xhr3.onreadystatechange = function () {
	if (xhr3.readyState == 4) {
	  if (xhr3.status == 200) {
		var text = xhr3.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		//alert(text);
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum2);
		for(var i=indexnum2;i<length1;i++){
		  addRow2(2);
		  var tmp_arr = text_arr[i-indexnum2].split("###");
		  jQuery("#"+wlbm_dt3+i).val(tmp_arr[7]);
		  jQuery("#"+wlbm_dt3+i+"span").text(tmp_arr[7]);
		  jQuery("#"+wlms_dt3+i).val(tmp_arr[20]);
		  jQuery("#"+wlms_dt3+i+"span").text(tmp_arr[20]);
		  jQuery("#"+jbjldw_dt3+i).val(tmp_arr[3]);
		  jQuery("#"+jbjldw_dt3+i+"span").text(tmp_arr[3]);
		  jQuery("#"+mrpz_dt3+i).val(tmp_arr[23]);
		  jQuery("#"+mrpz_dt3+i+"span").text(tmp_arr[23]);
		  jQuery("#"+abcbs_dt3+i).val(tmp_arr[24]);
		  jQuery("#"+abcbs_dt3+i+"span").text(tmp_arr[24]);
		  jQuery("#"+mrplx_dt3+i).val(tmp_arr[9]);
		  jQuery("#"+mrplx_dt3+i+"span").text(tmp_arr[9]);
		  jQuery("#"+mrpkzz_dt3+i).val(tmp_arr[10]);
		  jQuery("#"+mrpkzz_dt3+i+"span").text(tmp_arr[10]);
		  jQuery("#"+zdhd_dt3+i).val(tmp_arr[0]);
		  jQuery("#"+pldxcl_dt3+i).val(tmp_arr[11]);
		  jQuery("#"+pldxcl_dt3+i+"span").text(tmp_arr[11]);
		  jQuery("#"+gdpldx_dt3+i).val(tmp_arr[21]);
		  jQuery("#"+srz_dt3+i).val(tmp_arr[12]);
		  jQuery("#"+cglx_dt3+i).val(tmp_arr[1]);
		  jQuery("#"+cglx_dt3+i+"span").text(tmp_arr[1]);
		  jQuery("#"+tshqlx_dt3+i).val(tmp_arr[13]);
		  jQuery("#"+tshqlx_dt3+i+"span").text(tmp_arr[13]);
		  jQuery("#"+jhjhsj_dt3+i).val(tmp_arr[22]);
		  jQuery("#"+shclsj_dt3+i).val(tmp_arr[25]);
		  jQuery("#"+jhbjm_dt3+i).val(tmp_arr[14]);
		  jQuery("#"+jhbjm_dt3+i+"span").text(tmp_arr[14]);
		  jQuery("#"+scccdd_dt3+i).val(tmp_arr[15]);
		  jQuery("#"+scccdd_dt3+i+"span").text(tmp_arr[15]);
		  jQuery("#"+wbcgczdd_dt3+i).val(tmp_arr[2]);
		  jQuery("#"+wbcgczdd_dt3+i+"span").text(tmp_arr[2]);
		  jQuery("#"+aqkc_dt3+i).val(tmp_arr[16]);
		  jQuery("#"+jhclz_dt3+i).val(tmp_arr[4]);
		  jQuery("#"+jhclz_dt3+i+"span").text(tmp_arr[4]);
		  jQuery("#"+xhms_dt3+i).val(tmp_arr[17]);
		  jQuery("#"+xhms_dt3+i+"span").text(tmp_arr[17]);
		  jQuery("#"+xqxhqj_dt3+i).val(tmp_arr[18]);
		  jQuery("#"+xhxhqj_dt3+i).val(tmp_arr[5]);
		  jQuery("#"+zhmrp_dt3+i).val(tmp_arr[26]);
		  jQuery("#"+zhmrp_dt3+i+"span").text(tmp_arr[26]);
		  jQuery("#"+kyxjc_dt3+i).val(tmp_arr[6]);
		  jQuery("#"+kyxjc_dt3+i+"span").text(tmp_arr[6]);
		  jQuery("#"+dljzbs_dt3+i).val(tmp_arr[19]);
		  jQuery("#"+dljzbs_dt3+i+"span").text(tmp_arr[19]);
		  
	     }
          }
	  }
	 }
       xhr3.send(null);
     }
     changedt3();
}
function getallwlbh(){
	var indexnum0 =jQuery("#indexnum0").val();
	var wlbhall="";
	var flag="";
	for( var index=0;index<indexnum0;index++){
	  if( jQuery("#"+wlbm_dt1+index).length>0){
	  	   	  var  wlbm_dt1_val=jQuery("#"+wlbm_dt1+index).val();
	  	   	  if(wlbm_dt1_val != ""){
	  	   	    wlbhall = wlbhall+flag+wlbm_dt1_val;
	  	   	    flag=",";	  
	  	      }
	  }
	}
	return wlbhall;
}

    function removeaddcheckmain(ywlx_val){

	  var wllx_val = jQuery(wllx).val();
	if(ywlx_val =='A01'){
		 if(wllx_val==''){
     	 	 	   jQuery("#"+wllxid+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+wllxid)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=wllxid;
                }
     }else{
     	  jQuery("#"+wllxid+"spanimg").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+wllxid,"");
                document.all('needcheck').value=parastr;
     }
}

function changedt3(){
	var indexnum3= jQuery("#indexnum2").val();
	 for(var index=0;index <indexnum3;index++){
	      if(jQuery("#"+mrplx_dt3+index).length>0){
	          bindchangedt3(index);
	           var mrplx_dt3_val= jQuery("#"+mrplx_dt3+index).val();
	         removeaddcheckdt(mrplx_dt3_val,"PD",mrpkzz_dt3,'1',index);
	         removeaddcheckdt(mrplx_dt3_val,"VB",zdhd_dt3,'0',index); 
	           var pldxcl_dt3_val= jQuery("#"+pldxcl_dt3+index).val();
	             removeaddcheckdt(pldxcl_dt3_val,"FX",gdpldx_dt3,'0',index); 
	            var jhclz_dt3_val= jQuery("#"+jhclz_dt3+index).val();
         removeaddcheckdt3(jhclz_dt3_val,index); 
            }
	}
}
function bindchangedt3(index){
      jQuery("#"+mrplx_dt3+index).bindPropertyChange(function () {
         var mrplx_dt3_val= jQuery("#"+mrplx_dt3+index).val();
         removeaddcheckdt(mrplx_dt3_val,"PD",mrpkzz_dt3,'1',index); 
          removeaddcheckdt(mrplx_dt3_val,"VB",zdhd_dt3,'0',index); 
       })
        jQuery("#"+pldxcl_dt3+index).bindPropertyChange(function () {
         var pldxcl_dt3_val= jQuery("#"+pldxcl_dt3+index).val();
         removeaddcheckdt(pldxcl_dt3_val,"FX",gdpldx_dt3,'0',index); 
       })
       jQuery("#"+jhclz_dt3+index).bindPropertyChange(function () {
    
         var jhclz_dt3_val= jQuery("#"+jhclz_dt3+index).val();
         removeaddcheckdt3(jhclz_dt3_val,index); 
       })
  }
    function removeaddcheckdt3(jhclz_dt3_val,index){

	var zhmrp_dt3_val = jQuery("#"+zhmrp_dt3+index).val();
	var zhmrp=zhmrp_dt3+index;
	if(jhclz_dt3_val =='11' || jhclz_dt3_val =='70'){
		 if(zhmrp_dt3_val==''){
     	 	 	   jQuery("#"+zhmrp_dt3+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+zhmrp)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=zhmrp;
                }
     }else{
     	  jQuery("#"+zhmrp_dt3+index+"spanimg").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+zhmrp,"");
                document.all('needcheck').value=parastr;
     }
}
function changedt6(){
	var indexnum5= jQuery("#indexnum5").val();
	 for(var index=0;index <indexnum5;index++){
	      if(jQuery("#"+jgkz_dt6+index).length>0){
	          bindchangedt6(index);
	           var jgkz_dt6_val= jQuery("#"+jgkz_dt6+index).val();
	         //removeaddcheckdt6(jgkz_dt6_val,index);
	         removeaddcheckdt(jgkz_dt6_val,"S",bzjg_dt6,'0',index);
            }
	}
}
function bindchangedt6(index){
      jQuery("#"+jgkz_dt6+index).bindPropertyChange(function () {
         var jgkz_dt6_val= jQuery("#"+jgkz_dt6+index).val();
           //removeaddcheckdt6(jgkz_dt6_val,index);
           removeaddcheckdt(jgkz_dt6_val,"S",bzjg_dt6,'0',index);
           if(jgkz_dt6_val=="S"){
           	    jQuery("#"+jgqd_dt6+index).val("3");
           	     jQuery("#"+jgqd_dt6+index+"span").text("3")
           	   	 jQuery("#"+jgqd_dt6+index+"spanimg").html("");
           }
           if(jgkz_dt6_val=="V"){
           	    jQuery("#"+jgqd_dt6+index).val("2");
           	     jQuery("#"+jgqd_dt6+index+"span").text("2")
           	   	 jQuery("#"+jgqd_dt6+index+"spanimg").html("");
           }
       })
  }
  
  function removeaddcheckdt(yz,bjz,btid,flag,index){
	var btid_val = jQuery("#"+btid+index).val();
	var btid_check=btid+index;
	if(yz ==bjz){
		 if(btid_val==''){
		 	         if(flag=='0'){ 
     	 	 	   jQuery("#"+btid+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  }else{
     	 	 	 jQuery("#"+btid+index+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	 	 	  } 	  
     	 	 	 
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+btid_check)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=btid_check;
                }
     }else{
     	    if(flag=='0'){ 
     	  jQuery("#"+btid+index+"span").html("");
     	}else{
     	 jQuery("#"+btid+index+"spanimg").html("");
             }
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+btid_check,"");
                document.all('needcheck').value=parastr;
     }
}

  function removeaddcheckdt6(jgkz_dt6_val,index){
	var bzjg_dt6_val = jQuery("#"+bzjg_dt6+index).val();
	var bzjg=bzjg_dt6+index;
	if(jgkz_dt6_val =='S'){
		 if(bzjg_dt6_val==''){
     	 	 	   jQuery("#"+bzjg_dt6+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+bzjg)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=bzjg;
                }
     }else{
     	  jQuery("#"+bzjg_dt6+index+"span").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+bzjg,"");
                document.all('needcheck').value=parastr;
     }
}
function changedt4(){
	var indexnum3 = jQuery("#indexnum3").val();
	 for(var index=0;index <indexnum3;index++){
	      if(jQuery("#"+zhjsm_dt4+index).length>0){
	          bindchangedt4(index);
	           var zhjsm_dt4_val= jQuery("#"+zhjsm_dt4+index).val();
	          removeaddcheckdt4(zhjsm_dt4_val,index);
            }
	}
}


function removeaddcheckdt4(zhjsm_val,index){
	var zxsyhjsm_dt4_val = jQuery("#"+zxsyhjsm_dt4+index).val();
	var zxsyhjsm=zxsyhjsm_dt4+index;
	if(zhjsm_val !=''){
		 if(zxsyhjsm_dt4_val==''){
     	 	 	   jQuery("#"+zxsyhjsm_dt4+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	   }
     	 
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+zxsyhjsm)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=zxsyhjsm;
                }
     }else{
     	  jQuery("#"+zxsyhjsm_dt4+index+"span").html("");
     	     var parastr = document.all('needcheck').value;
                parastr = parastr.replace(","+zxsyhjsm,"");
                document.all('needcheck').value=parastr;
     }
}
function bindchangedt4(index){
      jQuery("#"+zhjsm_dt4+index).bind("change",function () {
         var zhjsm_dt4_val= jQuery("#"+zhjsm_dt4+index).val();
            removeaddcheckdt4(zhjsm_dt4_val,index);
       })
  }
function changedt1(){
    var 	indexnum0 = jQuery("#indexnum0").val();
    	var wllx_val = jQuery(wllx).val();
	var ywlx_val = jQuery(ywlx).val();
    for(var index=0;index <indexnum0;index++){
      if(jQuery("#"+wlbm_dt1+index).length>0){
     	 if(ywlx_val == "A01" && (wllx_val=="Z007"||wllx_val=="HALB"||wllx_val=="ZFT1"||wllx_val=="FERT")){
     	 	 if(jQuery("#"+wlbm_dt1+index).val()==''){
     	 	 	   jQuery("#"+wlbm_dt1+index+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
     	        }
     	 	 var wlbm=wlbm_dt1+index;
     	    var needcheck = document.all("needcheck");
                if(needcheck.value.indexOf(","+wlbm)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                   needcheck.value+=wlbm;
                }
                 jQuery("#"+wlbm_dt1+index).removeAttr("readonly");
        }else if(ywlx_val == "A02"){
	    jQuery("#"+wlbm_dt1+index).attr("readonly", "readonly");
	        jQuery("#"+wlms_dt1+index).attr("readonly", "readonly");
	    jQuery("#"+jbjldw_dt1+index+"_browserbtn").attr('disabled',true);
	     jQuery("#"+wlz_dt1+index+"_browserbtn").attr('disabled',true);
	       jQuery("#"+zldw_dt1+index+"_browserbtn").attr('disabled',true);
	    jQuery("#"+mz_dt1+index).attr("readonly", "readonly");
	      jQuery("#"+jz_dt1+index).attr("readonly", "readonly");
	         jQuery("#"+kgcwlzt_dt1+index+"_browserbtn").attr('disabled',true);
	        jQuery("#"+spbzsm_dt1+index).attr("readonly", "readonly");
     	}else{
     	     jQuery("#"+wlbm_dt1+index).attr("readonly", "readonly");	
    		}
     }
   
   }
    
}
 function showhideButton(ywlx_val,wllx_val){
 	 if(ywlx_val==''){
 	 	jQuery(butt1).hide();
 	      jQuery(butt2).hide();
 	      jQuery(butt3).hide();
 	      jQuery(butt4).hide();
 	      jQuery(butt5).hide();
 	      jQuery(butt6).hide();
 	      jQuery(butt7).hide();
 	      jQuery(butt8).hide();
 	      jQuery(butt9).hide();
 	       
 	      jQuery("#fz2").hide();
 	      jQuery("#fz3").hide();
 	      jQuery("#fz4").hide();
 	      jQuery("#fz5").hide();
 	      jQuery("#fz6").hide();
 	      jQuery("#fz7").hide();
 	      jQuery("#fz8").hide();
       }
       if(ywlx_val=="A01" || ywlx_val=="A03" ){
 	 	jQuery(butt1).show();
 	 	jQuery(butt2).show();
 	 	jQuery(butt3).show();
 	 	jQuery(butt4).show();
 	 	jQuery(butt5).show();
 	 	jQuery(butt6).show();
 	 	jQuery(butt7).show();
 	 	jQuery(butt8).show();
 	 	jQuery("#fz2").show();
 	      jQuery("#fz3").show();
 	      jQuery("#fz4").show();
 	      jQuery("#fz5").show();
 	      jQuery("#fz6").show();
 	      jQuery("#fz7").show();
 	      jQuery("#fz8").show();
 	 	if(ywlx_val=="A03"){
 	 		    jQuery("button[name=addbutton0]").css('display','none');
 	     }
 	      jQuery("button[name=addbutton1]").css('display','none');
 	  	jQuery("button[name=addbutton2]").css('display','none');
 	      jQuery("button[name=addbutton3]").css('display','none');
 	     jQuery("button[name=addbutton4]").css('display','none');
 	 jQuery("button[name=addbutton5]").css('display','none');
 	 jQuery("button[name=addbutton6]").css('display','none');
 	 jQuery("button[name=addbutton7]").css('display','none');
 	 	   jQuery(butt9).hide();
       }
          if(ywlx_val=="A02"  ){
          	  jQuery(butt1).show();
 	 	jQuery(butt2).show();
 	 	jQuery(butt3).show();
 	 	jQuery(butt4).show();
 	 	jQuery(butt5).show();
 	 	jQuery(butt6).show();
 	 	jQuery(butt7).show();
 	 	jQuery(butt8).show();
 	 	   jQuery(butt9).hide();
 	 	   	jQuery("#fz2").show();
 	      jQuery("#fz3").show();
 	      jQuery("#fz4").show();
 	      jQuery("#fz5").show();
 	      jQuery("#fz6").show();
 	      jQuery("#fz7").show();
 	      jQuery("#fz8").show();
 	jQuery("button[name=addbutton0]").css('display','none');
 	jQuery("button[name=addbutton1]").css('display','none');
 	 jQuery("button[name=addbutton2]").css('display','none');
 	 jQuery("button[name=addbutton3]").css('display','none');
 	 jQuery("button[name=addbutton4]").css('display','none');
 	 jQuery("button[name=addbutton5]").css('display','none');
 	 jQuery("button[name=addbutton6]").css('display','none');
 	 jQuery("button[name=addbutton7]").css('display','none');
       }
       
       if(ywlx_val=="A05"){
       	jQuery(butt1).hide();
 	      jQuery(butt2).hide();
 	      jQuery(butt3).hide();
 	      jQuery(butt4).hide();
 	      jQuery(butt5).hide();
 	      jQuery(butt6).hide();
 	      jQuery(butt7).hide();
 	      jQuery(butt8).hide();
 	 	jQuery(butt9).show();
 	 	 	jQuery("#fz2").hide();
 	      jQuery("#fz3").hide();
 	      jQuery("#fz4").hide();
 	      jQuery("#fz5").hide();
 	      jQuery("#fz6").hide();
 	      jQuery("#fz7").hide();
 	      jQuery("#fz8").hide();
 	 	jQuery("button[name=addbutton8]").css('display','none');
       }
}
</script>	

