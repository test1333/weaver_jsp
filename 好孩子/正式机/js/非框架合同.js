<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var sfys_dt1 = "#field14694_";
jQuery(document).ready(function () {
	var htze = "#field13304";
	var mxbj = "#field13311_";
	var htlx = "#field13294";
	checkCustomize = function (){
		var rs =true;
		var indexnum = jQuery("#indexnum0").val();
		var nosenum = jQuery("#nodesnum0").val();
		var ze = 0;
		var htze_val = jQuery(htze).val();
		var count =0;
		for(var i=0;i<indexnum;i++){
			if(jQuery(mxbj+i).length>0){
				var mxbj_val = jQuery(mxbj+i).val();
				if(mxbj_val ==''){
					mxbj_val = "0.0";
				}
				ze = ze+parseFloat(mxbj_val);
				var sfys_dt1_val = jQuery(sfys_dt1+i).val();
				if(sfys_dt1_val == "1"){
					count = count + 1;
				}
			}
			
		}
		if(count == 0|| count>1){
			Dialog.alert("��ϸ���������ֻ����һ�����Ƿ����ա�Ϊ�ǵ��У�����");
			return false;
		}
		if(parseFloat(nosenum)>0){
			//alert("ze--"+parseFloat(ze)+"--parseFloat(htze_val)-"+parseFloat(htze_val));
			if(parseFloat(htze_val)!= parseFloat(ze)){
				Dialog.alert("��ϸ�����ۺϲ����������ۣ��������")
				return false;
			}
		}
		return rs;
		
		
	}
	
	
})
</script>
























