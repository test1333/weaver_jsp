<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ���������:
   1.   ��ΪSAP�Խӽӿ�����,�°�ֻ�ϴ��롣
      ���Ա���ˢ������ѡ���ϰࡱ��ʱ��������ϰ����ʹ���ΪP10.
       ����ˢ������ѡ���°ࡱ��ʱ��������ϰ����ʹ���ΪP20.
         
    */
    var id_sklx = "#field10197";//ˢ������ 
    var id_sxbsklx = "#field10734"; //���°�ˢ������
    
    var setNX = function () {
        var i_sklx = $(id_sklx + " option:selected"); //ˢ������ 

        if (i_sklx.text() == "�ϰ�") {
            $(id_sxbsklx).val("P10").attr("value","P10");
        } else if (i_sklx.text() == "�°�") {
            $(id_sxbsklx).val("P20").attr("value","P20");
        } else {
            $(id_sxbsklx).val("").attr("value","");
        }
       // alert($(id_sxbsklx).val() )
    } 

    checkCustomize = function () {
        var isSuccess = true;
        setNX();
        return isSuccess;
    }


    jQuery(document).ready(function () {
        $(id_sklx).change(setNX);
        jQuery(id_sklx).bindPropertyChange(function () { setNX(); });
        setNX();
    }); 
</script>


