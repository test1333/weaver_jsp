<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var cgsqdh="#field51632";
var xghcgsl_dt="#field51639_";//�޸ĺ�ɹ�����
var yzccgddsl_dt="#field51640_";//��ת�ɲɹ���������
var ycgsl_dt="#field51638_";//ԭ�ɹ�����
var xghygdj_dt="#field51643_";//�޸ĺ�Ԥ������
var yygdj_dt="#field51642_";//Ԥ������
var ywlms_dt="#field51637_";//ԭ��������
var xghwlms_dt="#field51672_";//�޸ĺ���������
var wlbh_dt="#field51636_";//���ϱ��
var xghcgje_dt="#field51664_";//�޸ĺ�ɹ����
 jQuery(document).ready(function(){
 	 
 	 //jQuery("button[name=addbutton0]").css('display','none');
 	 var nodesnum0 = jQuery("#nodesnum0").val();
 	  if(Number(nodesnum0)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	}
 	 jQuery("#nodesnum0").bindPropertyChange(function () {
 	 	 var nodesnum00= jQuery("#nodesnum0").val();
 	 	  if(Number(nodesnum00)>0){
 	    	  jQuery(cgsqdh+"_browserbtn").attr('disabled',true);
 	    	 setTimeout('checkoutnum()',1000);
 	    	}else{
 	        jQuery(cgsqdh+"_browserbtn").attr('disabled',false);		
 	     }
 	 })	 
 	 	 checkCustomize = function () {
 	 	var indexnum0 = jQuery("#indexnum0").val();
 	 	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(xghcgsl_dt + index).length > 0) {
                var xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
				if(yzccgddsl_dt_val == ""){
					yzccgddsl_dt_val="0";
				}
                  var ycgsl_dt_val=jQuery(ycgsl_dt + index).val();
				  if(ycgsl_dt_val == ""){
					  ycgsl_dt_val="0";
				    }
                  if(xghcgsl_dt_val == ''){
                  	  jQuery(xghcgsl_dt + index).val(ycgsl_dt_val);
                  }
                   var xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                    var yygdj_dt_val=jQuery(yygdj_dt + index).val();
					if(yygdj_dt_val == ""){
					  yygdj_dt_val="0";
				    }
                    if(xghygdj_dt_val == ''){
                  	  jQuery(xghygdj_dt + index).val(yygdj_dt_val);
                    }
                  
                  var ywlms_dt_val=jQuery(ywlms_dt + index).val();
                    var xghwlms_dt_val=jQuery(xghwlms_dt+ index).val();
                     if(xghwlms_dt_val == ''){
                  	  jQuery(xghwlms_dt + index).val(ywlms_dt_val);
                  }
				xghcgsl_dt_val=jQuery(xghcgsl_dt + index).val();
				xghygdj_dt_val=jQuery(xghygdj_dt + index).val();
                if(Number(xghcgsl_dt_val)<Number(yzccgddsl_dt_val)){
                	  window.top.Dialog.alert("�����޸ĺ�����С����ת�ɲɹ��������������顣");
                     return false;
                }
                 if(Number(ycgsl_dt_val)<Number(xghcgsl_dt_val)){
                	  window.top.Dialog.alert("�����޸ĺ���������ԭ�ɹ����������顣");
                     return false;
                }
				 if(Number(yygdj_dt_val)<Number(xghygdj_dt_val)){
                	  window.top.Dialog.alert("�����޸ĺ󵥼۴���ԭ�ɹ����ۣ����顣");
                     return false;
                }
				var xghcgje_dt_val = jQuery(xghcgje_dt+index).val();
				if(xghcgje_dt_val == ""){
					xghcgje_dt_val = "0";
				}
				
				if(Number(xghcgje_dt_val) == Number("0")){
					xghcgje_dt_val = accMul(xghcgsl_dt_val,xghygdj_dt_val);
					jQuery(xghcgje_dt+index).val(xghcgje_dt_val);
					jQuery(xghcgje_dt+index+"span").text(xghcgje_dt_val);
				}
					
            }	 
         }
		 calSum(0);
         return true;
       }	 
	   
 setTimeout('checkoutnum()',1000);
 });
  function checkoutnum(){
 	var indexnum0 = jQuery("#indexnum0").val();
 	 for(var index=0;index<indexnum0;index++){
 	   if (jQuery(yzccgddsl_dt+index).length > 0) {
                var yzccgddsl_dt_val=jQuery(yzccgddsl_dt + index).val();
                if(Number(yzccgddsl_dt_val)>Number(0)){
                     jQuery(xghygdj_dt+index).attr("readonly", "readonly");
                }
                var wlbh_dt_val=jQuery(wlbh_dt+index).val();
                if(wlbh_dt_val != ''){
                	jQuery(xghwlms_dt+index).attr("readonly", "readonly");
                }
            }	 
       }
 } 
function accMul(arg1,arg2)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
}

</script>

