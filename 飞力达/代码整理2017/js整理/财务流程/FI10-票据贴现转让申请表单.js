<!-- script���룬�����Ҫ����js�ļ�����ʹ����HTML����ͬ�ķ�ʽ�� -->
<script type="text/javascript">
var clfs="#field11293"; //Ʊ�ݴ���ʽ
var txrq="field9166"; //����/ת������
var jzll="field9168"; //��׼����
var txlx="field9171"; //������Ϣ
var txll="field9170"; //��������
var bsr="field11294"; //������
var bbsr="field11295"; //��������
	/*
	���ѡ��Ʊ�����֣�ͬ�����л�׼���ʣ��껯�����������ʡ�������Ϣ�����λ��Ϊ��ѡ�ͬʱ�����ˡ��������˲�������
	��ѡ��Ʊ��Ϊ����ת��ʱ��ͬ���������л�׼���ʣ��껯����������Ϣ���������ʡ������������ĸ��ֶβ�����������������Ϊ�գ������˼��������˱���
	*/
       jQuery(clfs).bindPropertyChange(function () {
            var clfs_val=jQuery(clfs).val();
            if(clfs_val==0){
              jQuery("#"+bsr).val("");
              jQuery("#"+bsr+"span").text("");
               jQuery("#"+bsr).hide();

              jQuery("#"+bbsr).val("");
              jQuery("#"+bbsr+"span").text("");
               jQuery("#"+bbsr).hide();

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
               jQuery("#"+jzll).show();

              jQuery("#"+txlx).val("");
              jQuery("#"+txlx+"span").text("");
               jQuery("#"+txlx).show();

              jQuery("#"+txll).val("");
              jQuery("#"+txll+"span").text("");
               jQuery("#"+txll).show();

              jQuery("#"+txrq).val("");
              jQuery("#"+txrq+"span").text("");
               jQuery("#"+txrq+"browser").show();

               var parastr = document.all('needcheck').value;
               parastr = parastr.replace(","+bsr,"");
               parastr = parastr.replace(","+bbsr,"");
               document.all('needcheck').value=parastr;

            }else{
              jQuery("#"+bsr).val("");
              jQuery("#"+bsr+"span").text("");
               jQuery("#"+bsr).show();
               jQuery("#"+bsr+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+bbsr).val("");
              jQuery("#"+bbsr+"span").text("");
               jQuery("#"+bbsr).show();
               jQuery("#"+bbsr+"span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");

              jQuery("#"+jzll).val("");
              jQuery("#"+jzll+"span").text("");
               jQuery("#"+jzll).hide();

              jQuery("#"+txlx).val("");
              jQuery("#"+txlx+"span").text("");
               jQuery("#"+txlx).hide();

              jQuery("#"+txll).val("");
              jQuery("#"+txll+"span").text("");
               jQuery("#"+txll).hide();

              jQuery("#"+txrq).val("");
              jQuery("#"+txrq+"span").text("");
               jQuery("#"+txrq+"browser").hide();

               var needcheck = document.all("needcheck");
              if(needcheck.value.indexOf(","+bsr)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=bsr;
              }
              if(needcheck.value.indexOf(","+bbsr)<0){
                  if(needcheck.value!='') needcheck.value+=",";
                  needcheck.value+=bbsr;
              }
            }
       })
</script>























































