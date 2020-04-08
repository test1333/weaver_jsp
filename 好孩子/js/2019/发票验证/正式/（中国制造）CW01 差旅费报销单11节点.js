<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var wbje="#field6924";
var sjje="#field_lable6927";
var kdkje_dt1 = "#field17882_";//明细1可抵扣金额
var sl_dt1 = "#field17881_";//明细1税率
var jtgjlx_dt1 = "#field11744_";//明细1交通工具类型
var pmje_dt1 = "#field17884_";//明细1票面金额
var ryfjf_dt1 = "#field17879_";//明细1燃油附件费
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");
	var indexnum0 = jQuery("#indexnum0").val()
		for(var index = 0;index < indexnum0;index++){
            if(jQuery(kdkje_dt1+index).length>0){
				 jQuery(kdkje_dt1+index).attr('readonly', 'readonly')
				 bindjtgj(index);
                
            }
        }
});
function bindjtgj(index){
	
	jQuery(sl_dt1+index).bind("change",function(){
		getkdkje(index);
		
	})
	
}
function getkdkje(index){
	var jtgjlx_dt1_val = jQuery(jtgjlx_dt1+index).val();
		var pmje_dt1_val = jQuery(pmje_dt1+index).val();
		var sl_dt1_val = jQuery(sl_dt1+index).val();
		if(sl_dt1_val == ""){
			sl_dt1_val = "0.00";
		}
		if(pmje_dt1_val == ""){
			pmje_dt1_val = "0.00";
		}
		var ryfjf_dt1_val = jQuery(ryfjf_dt1+index).val();
		if(ryfjf_dt1_val == ""){
			ryfjf_dt1_val = "0.00";
		}
		if(jtgjlx_dt1_val=="0"||jtgjlx_dt1_val=="2"||jtgjlx_dt1_val=="3"){
			var kdkje_val = "";
			
			  $.ajax({
				 type: "POST",
				 url: "/goodbaby/gb2019/getkdkje.jsp",
				 data: {'type':jtgjlx_dt1_val, 'pmje':pmje_dt1_val,'ryfjf':ryfjf_dt1_val,'sl':sl_dt1_val},
				 dataType: "text",
				 async:false,//同步   true异步
				 success: function(data){
							data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							kdkje_val=data;
				 }
			 });
			 jQuery(kdkje_dt1+index).val(kdkje_val);

		}else{
			jQuery(kdkje_dt1+index).val("0.00");
		}
}
jQuery(document).ready(function () {
    // 检查差旅交通明细
    checkIsOver(t1.sfcbz)

    // 检查差旅住宿明细
    checkIsOver(t2.sfcbz)

    // 检查差旅餐费明细
    checkIsOver(t3.sfcbz)

    /**
     * 检查是否需要添加黄色背景
     *
     * @param {string} fieldid 被检查的字段id，明细字段
     */
    function checkIsOver (fieldid) {
        // 检查差旅餐费明细
        _C.stEach(fieldid, function (r) {
            if (_C.v(fieldid + r) === '0') {
                trBackground(fieldid + r, '0')
            }
        })
    }

    /**
     * 修改明细行背景色
     *
     * @param {string} fieldid 字段id
     * @param {string} flag 标识，0添加背景，1取消背景
     * @return void
     */
    function trBackground (fieldid, flag) {
        var td = jQuery('#' + fieldid).parent()
        if (flag === '0') {
            // 该行添加黄色背景色
            td.parent().attr('style', 'background-color:yellow')
        } else {
            // 该行删除背景色
            td.parent().removeAttr('style')
        }
    }
})

var t1 = {
    sfcbz: 'field6939' /** 是否超标准-int**/
}
var t2 = {
    sfcbz: 'field7378' /** 是否超标准-int**/
}
var t3 = {
    sfcbz: 'field7386' /** 是否超标准-int**/
}
</script>	













