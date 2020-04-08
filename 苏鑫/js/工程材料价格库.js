
<script type="text/javascript">
var mxxh = "field11795";//明细序号
var clbh = "field6776";//材料编码
var clxxbmmx_dt1 = "field6786_";//材料信息编码_dt1
var mxhs = 0;
jQuery(document).ready(function () {
	
	 jQuery("[name=copybutton1]").live("click", function () {
			 var mxxh_val = ModeForm.getFieldValue(mxxh);
             var indexcount = ModeForm.getDetailRowCount("detail_1");
			 var num=0;
             for(var index=mxhs+1;index<=indexcount;index++){
					setbhvalue(Number(mxxh_val)+num);
					num++;
					
			 }
			
        });

	
});
function _customAddFun1(addIndexStr){
   
setbhvalue(addIndexStr);
 var indexcount = ModeForm.getDetailRowCount("detail_1");
 mxhs = indexcount;
	

}
//明细1删除成功后触发事件 
function _customDelFun1(){     
	//获取行数
    var indexcount = ModeForm.getDetailRowCount("detail_1");
	mxhs = indexcount;
	
}

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