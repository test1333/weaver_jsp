<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
    var tzlx ="#field5923";//��������
    var cyhjs="#field10205";//��������
    var yzw ="#field5961_";//ԭְλ
    var xzzw ="#field5964_";//����ְλ
    var zwbm = "#field5962_";//ְ�����
    var tzq = "#field5918_";//����ǰ
    var jz = "#field5921_";//��ְ
    var lwg = "#field5922_";//����
    var max_len =100;
/*
	����һ��
1�������������ֶΡ�����ϼ�����������ϼ���=��ϸ���еĲ����ۼơ�
2���������Ͳ�ͨ�����ӱ��е�ԭ���߼�ȡ�������鱸�ݱ��棩������µ�����
��ϸ���е�ÿһ�������С�ԭ��ְλ���͡�����ְλ���������ֶ�ֻ����һ����ֵ��ѡ��ԭ��ְλ����ʱ����ա�����ְλ���͡�ְλ���롱������ԭ��ְλ�Ͷ�Ӧԭ��ְλ��Ӧ��ְλ���룩��ѡ������ְλ����ʱ����ա�ԭ��ְλ���͡�ְλ���롱����������ְλ�Ͷ�Ӧ����ְλ��Ӧ��ְλ���룩��
�����ύ��ʱ���ж����£�
����ϼ���>0ʱ�򣬵�������Ϊֻ��ѡ���������ƣ�����ϼ���=0��ʱ���������Ϊֻ��Ϊ�������ơ�����ϼ���<0�������ύ

	*/
  jQuery(document).ready(function() {
    checkCustomize = function() {
        for(var index =0;index <100;index ++){
           if(jQuery(zwbm+index).length>0){
              var xzzw_val = jQuery(xzzw+index).val();
              var yzw_val = jQuery(yzw +index).val();
              if(xzzw_val != "" && yzw_val != ""){
                alert("����ְλ��ԭ��ְλ����ֻ����дһ������������д");
                  jQuery(xzzw+index).val("");
                  jQuery(xzzw+index+"span").text("");
                   jQuery(zwbm+index).val("")
                  jQuery(yzw+index).val("");
                  jQuery(yzw+index+"span").text("");
                 return false;
              }
           }else{
             index = 101;
           }
        }
        var cyhjs_val =  jQuery(cyhjs).val();
       var tzlx_val =jQuery(tzlx).val();
        if(Number(cyhjs_val )>Number('0') && tzlx_val != '0'){
          alert("������������");
          return false;
        }
         if(Number(cyhjs_val ) == Number('0') && tzlx_val != '1'){
          alert("������������");
          return false;
        }
         if(Number(cyhjs_val ) < Number('0') ){
          alert("����ϼ�������С��0");
          return false;
        }
      return true;
    }

 });
  

</script>





