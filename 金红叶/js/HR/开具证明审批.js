<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
jQuery(document).ready(function() {
       var oldvalue = jQuery("#field32955").val();
       //alert(oldvalue);
       $.ajax({
        async:"false",
        type: "POST",
        url: "/appdevjsp/HQ/EXP/get-decode.jsp?oldvalue="+oldvalue,
        dataType: "Text",
        success: function(data){
            data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            //alert(data);
            if(jQuery("#field32955").attr("type")=="hidden"){
                 jQuery("#field32955_span").html(data);
            }else{
                 jQuery("#field32955").val(data);
            }
        }
    });
});
</script>








