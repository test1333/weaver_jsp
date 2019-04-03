<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var wlglfw="#field51010";//物料管理范围
var wlglfw_dt1="#field51011_";//明细1 物料管理范围
var je_dt1 = "#field50589_";//明细1 金额
var kmkyje_dt1 = "#field53937_";//明细1 科目可用金额
var djje_dt1 = "#field53938_";//明细1 冻结金额
var fycdbm_dt1 = "#field50974_";//明细1 费用承担部门
var fyqj_dt1 = "#field50975_";//明细1 费用期间
var yskm_dt1 = "#field50972_";//明细1 预算科目
var yslx_dt1 = "#field51999_";//明细1 预算类型
var fycdfb="#field50572";
jQuery(document).ready(function(){
    jQuery(wlglfw).attr("readonly","readonly");
	jQuery("button[name=addbutton0]").live("click",function(){
		var index0 = jQuery('#indexnum0').val()-1;
		jQuery(kmkyje_dt1+index0).attr("readonly","readonly");
		jQuery(djje_dt1+index0).attr("readonly","readonly");
    });



	checkCustomize = function () {
		var fycdfb_val=jQuery(fycdfb).val();
		if(fycdfb_val !="25" && fycdfb_val !="101"){
			window.top.Dialog.alert("申请公司必须为维信诺昆山公司或显示中心，请检查");
			return false;
		}
		//jQuery(wlglfw).val("");
		var indexnum0 = jQuery('#indexnum0').val();
		//for(var index =0;index <indexnum0;index++){
		//	if(jQuery(wlglfw_dt1+index).length>0){	
		//		var wlglfw_dt1_val = jQuery(wlglfw_dt1+index).val();
		//		if(wlglfw_dt1_val == "集团"){
		//			jQuery(wlglfw).val(wlglfw_dt1_val);
		//			break;
		//		}
				
				
		//	}
			
		//}
		var countnum=0;
		for(var index =0;index <indexnum0;index++){
			if(jQuery(kmkyje_dt1+index).length>0){	
				countnum = countnum+1;
				var je_dt1_val = jQuery(je_dt1+index).val();
				var kmkyje_dt1_val = jQuery(kmkyje_dt1+index).val();
				var djje_dt1_val = jQuery(djje_dt1+index).val();
				var fycdbm_dt1_val=jQuery(fycdbm_dt1+index).val();
				var fyqj_dt1_val=jQuery(fyqj_dt1+index).val();
				var yskm_dt1_val=jQuery(yskm_dt1+index).val();
				
				if(je_dt1_val==""){
					je_dt1_val = "0";	
				}
				if(kmkyje_dt1_val==""){
					kmkyje_dt1_val = "0";	
				}
				if(djje_dt1_val==""){
					djje_dt1_val = "0";	
				}
				var yslx_dt1_val = jQuery(yslx_dt1+index).val();
				if(yslx_dt1_val != "1"){
					if(accSub(kmkyje_dt1_val,djje_dt1_val)<Number(je_dt1_val)){
					Dialog.alert("第"+countnum+"行明细存在申请金额大于科目可用金额-冻结金额，请检查");
					return false;
				}else{
					if(yskm_dt1_val !="" && fycdbm_dt1_val !="" && fyqj_dt1_val !=""){
						var allje_val=getAllJe(yskm_dt1_val,fycdbm_dt1_val,fyqj_dt1_val);
						if(accSub(kmkyje_dt1_val,djje_dt1_val)<Number(allje_val)){
							Dialog.alert("第"+countnum+"行明细存在申请金额大于科目可用金额-冻结金额，请检查");
							return false;
						}
						
					}
				}					
				}
				
			}
			
		}
		
		return true;
	}
	
	dodetail();
})

function getAllJe(yskm,fycdbm,fyqj){
	var allmonry = 0;
	var indexnum0 = jQuery('#indexnum0').val();
	for(var index =0;index <indexnum0;index++){
			if(jQuery(kmkyje_dt1+index).length>0){	
				var je_dt1_val = jQuery(je_dt1+index).val();
				var fycdbm_dt1_val=jQuery(fycdbm_dt1+index).val();
				var fyqj_dt1_val=jQuery(fyqj_dt1+index).val();
				var yskm_dt1_val=jQuery(yskm_dt1+index).val();
				if(je_dt1_val==""){
					je_dt1_val = "0";	
				}
				if(fycdbm_dt1_val == fycdbm && fyqj_dt1_val == fyqj && yskm_dt1_val==yskm){
					allmonry=accAdd(allmonry,je_dt1_val);
					
				}
					
			}
			
	}
	return allmonry;
}

function dodetail(){
	var indexnum0 = jQuery('#indexnum0').val();
	for(var index =0;index <indexnum0;index++){
		if(jQuery(kmkyje_dt1+index).length>0){		
			jQuery(kmkyje_dt1+index).attr("readonly","readonly");
			jQuery(djje_dt1+index).attr("readonly","readonly");		
		}
			
	}
}
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}

function accSub(arg1,arg2){
   var r1,r2,m,n;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
       m=Math.pow(10,Math.max(r1,r2));
       //动态控制精度长度
       n=(r1>=r2)?r1:r2;
       return ((arg1*m-arg2*m)/m).toFixed(n);
}

</script>
<script type="text/javascript">
// 资产编号
var zcbm_f = "field50656_";
var isITAss_str  = "#field50659";
setTimeout('yourFunction()',1000);

function yourFunction(){
	checkIsShow();
}

function checkIsShow(){
        var isITAss = jQuery(isITAss_str ).val();
         if(isITAss==0){
             hiddenRow_i();
         }else if(isITAss==1){
            hiddenRow_f();
        }
}

 jQuery(isITAss_str).bindPropertyChange(function (){
  	checkIsShow();
})

jQuery("button[name=addbutton0]").live("click",function(){
    checkIsShow();
})

function hiddenRow_i(){
    var tmp_ind = ".f_1" ;
	jQuery(tmp_ind).show(); 
	for(var index=0;index<200;index++){
		var sf = "#"+zcbm_f+index;
		if(jQuery(sf).length>0){
	  		addcheck(zcbm_f,"1");
	  	}
	}
}	
function hiddenRow_f(){
	var tmp_ind = ".f_1" ;
	jQuery(tmp_ind).hide(); 
	for(var index=0;index<200;index++){
		var sf = "#"+zcbm_f+index;
		if(jQuery(sf).length>0){
	  		removecheck(zcbm_f,"1");
	  	}
	}
}

function addcheck(field_id,flag){
	var btid_val = jQuery(field_id).val();
	if(btid_val ==  ''){
		if(flag == '0'){ 
			jQuery(field_id+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		}else{
			jQuery(field_id+"spanimg").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		} 	  
	}
	var needcheck = document.all("needcheck");
	if(needcheck.value.indexOf(","+field_id)<0){
		if(needcheck.value != '') needcheck.value +=",";
		needcheck.value += field_id;
	}
}

function removecheck(field_id,flag){
	if(flag=='0'){ 
		jQuery(field_id+"span").html("");
	}else{
		jQuery(field_id+"spanimg").html("");
	}
	var parastr = document.all('needcheck').value;
	parastr = parastr.replace(","+field_id,"");
	document.all('needcheck').value = parastr; 
}

</script>
<script type="text/javascript">
// 项目编号
var projectNo = "field8101_";
var no = 10;
var tem_nowRow;
var tem_str;
var new_no = 0;

// 物料描述
var wlms_str = "field6714_";

// 是否仓库收货
var sfsh_str = "field50581_";
// 是否列管资产
var sfzc_str = "field50606_";
// 科目分类码
var kmlm_str = "field50627_";


jQuery("button[name=addbutton0]").live("click",function(){
    getNo();
} );

jQuery(document).ready(function(){
	setTimeout('getNo()',500);
})

jQuery("#indexnum0").bindPropertyChange(function(){
	getNo();
	var index0 = jQuery('#indexnum0').val()-1;
	jQuery(kmkyje_dt1+index0).attr("readonly","readonly");
	jQuery(djje_dt1+index0).attr("readonly","readonly");
})

function getNo(){	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	checkNo(nowRow);
}

/*for(var i=0;i<200;i++){
    if(jQuery("#"+sfsh_str+i).length>0){
         checkNo(i);
    }else{
    	i = 200;
    }
}*/

function checkNo(nowRow){	
	var nowRow = parseInt($G("indexnum0").value) - 1;
	if(nowRow == 0){
		//alert(nowRow);
//		alert(no);
		jQuery("#"+projectNo+nowRow).val(no);
		jQuery("#"+projectNo+nowRow+"span").html(no);
		no = Number(no) + 10;
		new_no = no;
	}else{
//		alert(nowRow);
                tem_nowRow = Number(nowRow)-1;
		if(new_no == 0){
			tem_str = jQuery("#"+projectNo+tem_nowRow).val();
			new_no = Number(tem_str)+10;
		}
		jQuery("#"+projectNo+nowRow).val(new_no);
		jQuery("#"+projectNo+nowRow+"span").html(new_no);
		new_no = Number(new_no) + 10;
	}
		jQuery("input[id='"+wlms_str+nowRow+"']").bind("change",function(){
			// 获取必填信息
			var wlbh_val = jQuery("#"+wlms_str+nowRow).val();
			//alert("1")
			if(wlbh_val.length > 40 ){
				window.top.Dialog.alert("物料描述强制要求不超过40位,目前填写"+wlbh_val.length+"位！会清空记录！！");
				document.getElementById(wlms_str+nowRow).value="";
				document.all(wlms_str+nowRow+"span").innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
			}
		});


	jQuery("#"+sfsh_str+nowRow).bindPropertyChange(function () {
                              //  alert("2")
		var sfsh_val = jQuery("#"+sfsh_str+nowRow).val();
		var sfzc_val = jQuery("#"+sfzc_str+nowRow).val();
		if(sfsh_val.length>0&&sfzc_val.length>0){
			if(sfsh_val=='0'&&sfzc_val=='0'){
				document.getElementById(kmlm_str+nowRow).value = "Y";
			}else if(sfsh_val=='0'&&sfzc_val=='1'){
				document.getElementById(kmlm_str+nowRow).value = "K";
			}else{
				document.getElementById(kmlm_str+nowRow).value = "Z";
			}
			document.getElementById(kmlm_str+nowRow).readOnly = true;
		}
	});

	jQuery("#"+sfzc_str+nowRow).bindPropertyChange(function () {
                               // alert("3")
		var sfsh_val = jQuery("#"+sfsh_str+nowRow).val();
		var sfzc_val = jQuery("#"+sfzc_str+nowRow).val();
		if(sfsh_val.length>0&&sfzc_val.length>0){
			if(sfsh_val=='0'&&sfzc_val=='0'){
				document.getElementById(kmlm_str+nowRow).value = "Y";
			}else if(sfsh_val=='0'&&sfzc_val=='1'){
				document.getElementById(kmlm_str+nowRow).value = "K";
			}else{
				document.getElementById(kmlm_str+nowRow).value = "Z";
			}
			document.getElementById(kmlm_str+nowRow).readOnly = true;
		}
	});

}
</script>











