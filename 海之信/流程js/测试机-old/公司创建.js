<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var nameCheck = "field13691_";  // �ͻ�������֤
		var gsname = "field12854_";  // �ͻ�����
    var kh="field12876_";
    var gys="field12877_";
    var hzhb="field12878_";
 	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+kh+index).length>0){
		                  var tmp_kh = jQuery("#"+kh+index).attr("checked");
                               var tmp_gys = jQuery("#"+gys+index).attr("checked")
                               var tmp_hzhb = jQuery("#"+hzhb+index).attr("checked")
                                if(tmp_kh == false && tmp_gys == false && tmp_hzhb == false){
                				alert("��ѡ���뱾��˾�Ĺ�ϵ��")
               					return false;
                                 }
                                 var name_val = jQuery("#"+nameCheck+index).val();
                                 var gsname_val = jQuery("#"+gsname+index).val();
		
					if(name_val=="�ظ�"){
					alert(gsname_val+"�Ѵ��ڣ����ѯȷ�ϣ�");
					return false;
					}
		              }
		          }
	      
	      	return true;
             }
</script>






