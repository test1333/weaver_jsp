<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var clzsfzbz_dt1 = "#field10219_";//明细1 差旅住宿费费用总标准
var clzsffqe_dt1 = "#field10221_";//明细1 差旅住宿费费用申请饿
var cbzsy_dt1 = "#field10225_";//明细1 超标准事由

var clbzzbz_dt3 = "#field10238_";//明细3 差旅补助总标准
var clbzsqje_dt3 = "#field10240_";//明细3 差旅补助申请金额原币
var cbzsy_dt3 = "#field10244_";//明细3 超标准事由
jQuery(document).ready(function(){
	checkCustomize = function () {
		var indexnum0 = jQuery("#indexnum0").val();
    	var countnum=0;
		for(var index=0; index<indexnum0;index++){
			if(jQuery(clzsfzbz_dt1+index).length>0){
				countnum = countnum +1;
				var clzsfzbz_dt1_val = jQuery(clzsfzbz_dt1+index).val();
				var clzsffqe_dt1_val = jQuery(clzsffqe_dt1+index).val();
				var cbzsy_dt1_val = jQuery(cbzsy_dt1+index).val();
				if(cbzsy_dt1_val == ""){
					if(clzsfzbz_dt1_val == ""){
						clzsfzbz_dt1_val = "0";
					}
					if(clzsffqe_dt1_val == ""){
						clzsffqe_dt1_val = "0";
					}
					if(Number(clzsffqe_dt1_val)>Number(clzsfzbz_dt1_val)){
						alert("明细1 第"+countnum+"行明细的差旅住宿费超标准，请填写超标准事由");
						return false;
					}
				}
			}
		}
		var indexnum2 = jQuery("#indexnum2").val();
    	countnum=0;
		for(var index=0; index<indexnum2;index++){
			if(jQuery(clbzzbz_dt3+index).length>0){
				countnum = countnum +1;
				var clbzzbz_dt3_val = jQuery(clbzzbz_dt3+index).val();
				var clbzsqje_dt3_val = jQuery(clbzsqje_dt3+index).val();
				var cbzsy_dt3_val = jQuery(cbzsy_dt3+index).val();
				if(cbzsy_dt3_val == ""){
					if(clbzzbz_dt3_val == ""){
						clbzzbz_dt3_val = "0";
					}
					if(clbzsqje_dt3_val == ""){
						clbzsqje_dt3_val = "0";
					}
					if(Number(clbzsqje_dt3_val)>Number(clbzzbz_dt3_val)){
						alert("明细3 第"+countnum+"行明细的差旅补助超标准，请填写超标准事由");
						return false;
					}
				}
			}
		}
		return true;
	}
	
})
</script>
