<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var sqdh = "#field21583";//申请单号
var cjz = "#field25993";//创建者
var xmzys="#field21630";//项目总预算
var gs="#field21621";//公司
var fkjhzje = "#field26322";//付款计划总金额
var sqdh_dt1 ="#field21585_";//申请单号明细1
var xmgsdm_dt1 = "#field21616_";//项目公司代码
var yh_dt1 = "#field25444_";//用户明细1
var jhfkrq_dt2 = "#field26324_";//计划付款日期明细2
var xzbs_dt2 = "#field26122_";//新增标识明细2
var yh_dt2 = "#field26123_";//用户明细2
jQuery(document).ready(function(){
	 jQuery('button[name=addbutton0]').live('click', function () {
        var indexnum0 = jQuery('#indexnum0').val()-1;
		var sqdh_val = jQuery(sqdh).val();
		jQuery(sqdh_dt1+indexnum0).val(sqdh_val);
		jQuery(sqdh_dt1+indexnum0+"span").text(sqdh_val);
		var cjz_val = jQuery(cjz).val();
		jQuery(yh_dt1+indexnum0).val(cjz_val);
		jQuery(yh_dt1+indexnum0+"span").text(cjz_val);
		var gs_val = jQuery(gs).val();
		jQuery(xmgsdm_dt1+indexnum0).val(gs_val);
		jQuery(xmgsdm_dt1+indexnum0+"span").html("");
    });
	 jQuery('button[name=addbutton1]').live('click', function () {
        var indexnum1 = jQuery('#indexnum1').val()-1;
		var cjz_val = jQuery(cjz).val();
		jQuery(yh_dt2+indexnum1).val(cjz_val);
		jQuery(yh_dt2+indexnum1+"span").text(cjz_val);
		jQuery(xzbs_dt2+indexnum1).val("X");
		jQuery(xzbs_dt2+indexnum1+"span").text("X");
		jQuery(jhfkrq_dt2+indexnum1).val("");
		jQuery(jhfkrq_dt2+indexnum1+"span").text("");
		jQuery(jhfkrq_dt2+indexnum1+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");
		
    });
	 checkCustomize = function () {
		 var fkjhzje_val = jQuery(fkjhzje).val();
		 var xmzys_val = jQuery(xmzys).val();
		 if(fkjhzje_val != xmzys_val){
			window.top.Dialog.alert("项目总预算不等于付款计划总金额,请检查");
			return false;
		 }
		 var indexnum1 = jQuery('#indexnum1').val();
		for(var index =0;index <indexnum1;index++){
        if(jQuery(jhfkrq_dt2+index).length>0){
			var jhfkrq_dt2_val = jQuery(jhfkrq_dt2+index).val();
			if(jhfkrq_dt2_val == ""){
				continue;
			}else{
				if(!checkdate(jhfkrq_dt2_val,index+1)){
					window.top.Dialog.alert("明细中存在计划付款日期相等,请检查");
					return false;	
				}
			}
		}
	 }
		 return true;
	 }
});	

function checkdate(date1,index){
	var indexnum1 = jQuery('#indexnum1').val();
	 for(var index1 =index;index1 <indexnum1;index1++){
        if(jQuery(jhfkrq_dt2+index1).length>0){
			var jhfkrq_dt2_val = jQuery(jhfkrq_dt2+index1).val();
			if(jhfkrq_dt2_val == ""){
				continue;
			}else{
				if(jhfkrq_dt2_val == date1){
						return false;
				}
			}
		}
	 }
	return true;
}
</script>
