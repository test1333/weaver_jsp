<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var sfsjzscqht_dt1="#field30961_";//明细1 是否涉及知识产权合同
var sfzhtsfjjwc_dt1="#field30962_";//明细1 所负责合同是否交接完成
var sfwckhjj_dt1="#field30963_";//明细1 是否完成客户交接
var zgpy_dt1="#field30964_";//明细1 主管评语
var wjqkje_dt1="#field30965_";//明细1 未结欠款金额
var wjfyje_dt1="#field30966_";//明细1 未结费用金额
var qksqzt_dt1="#field30967_";//明细1 欠款收取状态
var fyjqzt_dt1="#field30968_";//明细1 费用结清状态
var sfwc_dt1="#field30969_";//明细1 是否完成
var clry_dt1="#field30970_";//明细1 处理人员
jQuery(document).ready(function(){
	var dqczr = wf__info.f_bel_userid;
	dodetail(dqczr);
	checkCustomize = function () {
		var indexnum0 = jQuery('#indexnum0').val();
		for(var index =0;index <indexnum0;index++){
			if(jQuery(sfwc_dt1+index).length>0){
				var clry_dt1_val = ","+jQuery(clry_dt1+index).val()+",";
				if(clry_dt1_val.indexOf(","+dqczr+",")>=0){
					var sfwc_dt1_val =jQuery(sfwc_dt1+index).val()
					if(sfwc_dt1_val !="1"){
						window.top.Dialog.alert("请完成所有处理事项后提交");
						return false;
					}
				}
			}
		}
		return true;
	}
		
})
function dodetail(dqczr){
	var indexnum0 = jQuery('#indexnum0').val();
	for(var index =0;index <indexnum0;index++){
		if(jQuery(sfwc_dt1+index).length>0){
			var clry_dt1_val = ","+jQuery(clry_dt1+index).val()+",";
			if(clry_dt1_val.indexOf(","+dqczr+",")<0){
				setReadonly(index);
			}
		}
	}
}
function setReadonly(index){
	jQuery(sfsjzscqht_dt1+index).attr("disabled", "disabled");
	jQuery(sfzhtsfjjwc_dt1+index).attr("disabled", "disabled");
	jQuery(sfwckhjj_dt1+index).attr("disabled", "disabled");
	jQuery(zgpy_dt1+index).attr("readonly", "readonly");
	jQuery(wjqkje_dt1+index).attr("readonly", "readonly");
	jQuery(wjfyje_dt1+index).attr("readonly", "readonly");
	jQuery(qksqzt_dt1+index).attr("readonly", "readonly");
	jQuery(fyjqzt_dt1+index).attr("readonly", "readonly");
	jQuery(sfwc_dt1+index).attr("disabled", "disabled");
}
</script>
