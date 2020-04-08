<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var oanw = 'field5868';//oa内网
var fsdw = 'field6045';//发送单位
    jQuery(document).ready(function () {
		alert("123");
		if(WfForm.getFieldValue(oanw) != "1"){
			WfForm.changeFieldAttr(fsdw, 4);
		}
		WfForm.bindFieldChangeEvent(oanw, function(obj,id,value){  
			if(value == '1'){
				WfForm.changeFieldAttr(fsdw, 3);
			}else{
				WfForm.changeFieldAttr(fsdw, 4);
			}
		});
		
	})
</script>
