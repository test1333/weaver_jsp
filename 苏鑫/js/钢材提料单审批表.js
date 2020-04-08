
<script type="text/javascript">
var mxxh = "field11798";//明细序号
var clbh = "field8626";//订单编号
var clxxbmmx_dt1 = "field11796_";//材料信息编码_dt1
jQuery(document).ready(function () {
	//获取明细最大行下标
	var indexnum0 = jQuery("#indexnum0").val();
	for(var index=0;index<indexnum0;index++){
		//设置只读
		WfForm.changeFieldAttr(clxxbmmx_dt1+index, 1);
					
	}
	 //复制功能
	 jQuery("[name=copybutton0]").live("click", function () {
		 //明细序号取值
			 var mxxh_val = WfForm.getFieldValue(mxxh);
             var indexcount = jQuery("#indexnum0").val();
             for(var index=mxxh_val;index<indexcount;index++){
					setbhvalue(index);
					
			 }
			
        });
		//新增按钮
		 jQuery("[name=addbutton0]").live("click", function () {
			 //获取新增行号
             var indexcount = jQuery("#indexnum0").val()-1;
             setbhvalue(indexcount);
			
        });
		
		

	
});
//设置明细编号字段的值，并设置只读
function setbhvalue(index){
	//获取当前明细序号的值
var mxxh_val = WfForm.getFieldValue(mxxh);
	if(mxxh_val == ""){
		mxxh_val = "1";
	}else{
		mxxh_val = Number(mxxh_val)+1;
	}
	//获取流程编号的值
	var clbh_val = WfForm.getFieldValue(clbh);
	//设置明细行编号的值
	WfForm.changeFieldValue(clxxbmmx_dt1+index, {value:clbh_val+'-'+mxxh_val})
	//更改只读
	WfForm.changeFieldAttr(clxxbmmx_dt1+index, 1);
	//更改主表明细序号的值
	WfForm.changeFieldValue(mxxh, {value:mxxh_val});
	
}



</script>
