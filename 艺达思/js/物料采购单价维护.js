<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var lh_dt1="field6367_";//�Ϻ�-��ϸ1
	var gys_dt1="field6585_";//��Ӧ��-��ϸ1
	var bb_dt1="field6374_";//�ұ�_��ϸ1
	var dw_dt1="field6372_";//��λ_��ϸ1
	var kssj_dt1="field6375_";//��ʼʱ��_��ϸ1
	var jssj_dt1="field6376_";//����ʱ��_��ϸ1
     jQuery(document).ready(function () {
     	 dodetail();
       jQuery("button[name=addbutton0]").live("click", function () {
	  	   		dodetail();
	 });
     });
     function dodetail(){
      	var indexnum0=  jQuery("#indexnum0").val();
             for(var index = 0;index<indexnum0;index++){
                if(jQuery("#"+lh_dt1+index).length>0){
             	 	 bindchange(index);	 
             	 	 	 
                }
             	 
             }
     }
     
     function bindchange(index){
       jQuery("#"+lh_dt1+index).bindPropertyChange(function () {
        checkdata(index);
       });
        jQuery("#"+gys_dt1+index).bindPropertyChange(function () {
        checkdata(index);	 
        
       });
       jQuery("#"+kssj_dt1+index).bindPropertyChange(function () {
       checkdata(index);	 
        
       });
       jQuery("#"+jssj_dt1+index).bindPropertyChange(function () {	 
        checkdata(index);
       
       });
        jQuery("#"+bb_dt1+index).bind("change",function () {
        checkdata(index);	 
       
       });
       jQuery("#"+dw_dt1+index).bind("change",function () {
       checkdata(index);	 
       
       });

    }
    function checkdata(index){
      var lh_dt1_val=jQuery("#"+lh_dt1+index).val();
    	var gys_dt1_val=jQuery("#"+gys_dt1+index).val();
    	var dw_dt1_val=jQuery("#"+dw_dt1+index).val();
    	var bb_dt1_val=jQuery("#"+bb_dt1+index).val();
    	var kssj_dt1_val=jQuery("#"+kssj_dt1+index).val();
    	var jssj_dt1_val=jQuery("#"+jssj_dt1+index).val();
    //	alert("lh:"+lh_dt1_val+"  gys:"+gys_dt1_val+"  dw:"+dw_dt1_val+"  bb:"+bb_dt1_val+"  kssj:"+kssj_dt1_val+"  jssj"+jssj_dt1_val);
    	if(lh_dt1_val !="" && gys_dt1_val !="" && dw_dt1_val !="" && bb_dt1_val !="" && kssj_dt1_val !="" && jssj_dt1_val !=""){
        var result=getcheckresult(lh_dt1_val,gys_dt1_val,dw_dt1_val,bb_dt1_val,kssj_dt1_val,jssj_dt1_val);		
        if(result=="1"){
         alert("���ϲɹ������Ѵ���");
         
         jQuery("#"+kssj_dt1+index).val("");
         jQuery("#"+kssj_dt1+index+"span").text("");
        jQuery("#"+jssj_dt1+index).val("");	     
      jQuery("#"+jssj_dt1+index+"span").text("");
        }
      }
    }
    
 function getcheckresult(lh_dt1_val,gys_dt1_val,dw_dt1_val,bb_dt1_val,kssj_dt1_val,jssj_dt1_val){
 	// alert("kssj_dt1_val"+kssj_dt1_val+" jssj_dt1_val"+jssj_dt1_val);
        	var xhr = null;
   var text='';
   if (window.ActiveXObject) {//IE�����
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
   } else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
   }
   if (null != xhr) {	   
	xhr.open("GET","/yds/pr/checkcgdj.jsp?lh="+lh_dt1_val+"&gys="+gys_dt1_val+"&dw="+dw_dt1_val+"&bb="+bb_dt1_val+"&kssj="+kssj_dt1_val+"&jssj="+jssj_dt1_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		 text= xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
	   }
      }
     }
	 xhr.send(null);
   }
   return text;
   }
</script>
