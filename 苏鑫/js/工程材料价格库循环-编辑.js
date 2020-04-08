
<script type="text/javascript">
var mxxh = "field11795";//明细序号
var clbh = "field6776";//材料编码
var clxxbmmx_dt1 = "field6786_";//材料信息编码_dt1
jQuery(document).ready(function () {
	//页面加载后将明细编码字段设置只读
	var indexcount = ModeForm.getDetailRowCount("detail_1");
	for(var index=0;index<indexcount;index++){
		ModeForm.changeFieldAttr(clxxbmmx_dt1+index, 1);
	}
	//点击复制按钮触发
	jQuery("[name=copybutton1]").live("click", function () {
			 var mxxh_val = ModeForm.getFieldValue(mxxh);
             var indexcount1 = ModeForm.getDetailRowCount("detail_1");
             for(var index=mxxh_val;index<indexcount1;index++){
					setbhvalue(index);
					
			 }
			
        });
});
//明细1增加后触发
function _customAddFun1(addIndexStr){
	setbhvalue(addIndexStr);

}
//明细1删除成功后触发事件 
function _customDelFun1(){     
	//获取行数
    var indexcount = ModeForm.getDetailRowCount("detail_1");
	//删除后重置编码
	ModeForm.changeFieldValue(mxxh, {value: '0',showhtml: '0'}); 
	for(var index=0;index<indexcount;index++){
		if(jQuery("#"+clxxbmmx_dt1+index).length>0){
				setbhvalue(index);
		}
					
	}
}
//根据行号更改编号字段的值和设置只读
function setbhvalue(index){
var mxxh_val = ModeForm.getFieldValue(mxxh);
	if(mxxh_val == ""){
		mxxh_val = "1";
	}else{
		mxxh_val = Number(mxxh_val)+1;
	}
	var clbh_val = ModeForm.getFieldValue(clbh);
	ModeForm.changeFieldValue(clxxbmmx_dt1+index, {value: clbh_val+'-'+mxxh_val,showhtml: clbh_val+'-'+mxxh_val}); 
	ModeForm.changeFieldAttr(clxxbmmx_dt1+index, 1);

	ModeForm.changeFieldValue(mxxh, {value: mxxh_val,showhtml: mxxh_val}); 	
	
}



</script>

<style type="text/css">
/*
* 请在下方编辑CSS
*/

</style>