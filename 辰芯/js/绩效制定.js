<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var khqz = '#field7750';
	var ljkhqz = '#field7751';
	jQuery(document).ready(function () {
		jQuery(ljkhqz).attr("readonly","readonly");
		checkCustomize = function () {
			var khqz_val = jQuery(khqz).val();
			var ljkhqz_val = jQuery(ljkhqz).val();
			if(khqz_val == ""){
				khqz_val = "0";
			}
			if(ljkhqz_val == ""){
				ljkhqz_val = "0";
			}
			var sumzq = accAdd(khqz_val,ljkhqz_val);
			if(Number(sumzq)>Number("100")){
				window.top.Dialog.alert("当前周期总权重大于100无法提交，请检查");
				return false;
			}
			return true;			
		}		
	})
	
function accAdd(arg1,arg2){
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
    m=Math.pow(10,Math.max(r1,r2))
    return (arg1*m+arg2*m)/m
}



</script>
