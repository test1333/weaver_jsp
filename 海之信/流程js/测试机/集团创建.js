<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var nameCheck = "field13746_";  // ����������֤
		var jtname = "field11638_";  // ��������
 	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+jtname+index).length>0){
		                  
                                 var name_val = jQuery("#"+nameCheck+index).val();
                                 var jtname_val = jQuery("#"+jtname+index).val();
		
					if(name_val=="�ظ�"){
					alert(jtname_val+"�Ѵ��ڣ����ѯȷ�ϣ�");
					return false;
					}
		              }
		          }
	      
	      	return true;
             }
</script>








