<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
	var lx = "#field11727";
	var jt = "#field11726";
	    var yjdzt="field11745";
    var xjdzt="field11746";
    	var nameCheck = "field13747";  // ����������֤
		var jtname = "field11728";  // ��������
	
    jQuery(document).ready(function () {
	jQuery(lx).bindPropertyChange(function (){ 
                jQuery(jt).val("");
		jQuery(jt+"span").text("");
	})
	checkCustomize = function () {
		 var yjdzt_val=jQuery("#"+yjdzt).val();
		  var xjdzt_val=jQuery("#"+xjdzt).val();
		  if(yjdzt_val == '0' && xjdzt_val=='0'){
		      alert("���޸���У��״̬�����ύ��");
		       return false;
		     }
		       var name_val = jQuery("#"+nameCheck).val();
                     var jtname_val = jQuery("#"+jtname).val();
                     	if(name_val=="�ظ�"){
					alert(jtname_val+"�Ѵ��ڣ����ѯȷ�ϣ�");
					return false;
					}
	      	return true;
             }
    });	
</script>





