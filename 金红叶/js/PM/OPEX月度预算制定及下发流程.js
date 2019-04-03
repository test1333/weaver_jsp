<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var xhxx = '#field30175';// 相关信息
var dqczr = '#field30174';// 当前操作人
var opexid = '#field30050';// 
jQuery(document).ready(function () {
	setTimeout('doUrl()',1000);
	
});
function doUrl(){
	var dqczr_val=jQuery(dqczr).val();
	var opexid_val=jQuery(opexid).val();
	var url = "<a href='javascript:void(window.open(&quot;http://172.18.95.95/appdevjsp/HQ/PM/getFileUrl.jsp?IV_PERNR="+dqczr_val+"&IV_ZOPID="+opexid_val+"&quot;,&quot;_blank&quot;,&quot;toolbar=no,scrollbar=no,location=no,top=50,left=50,width=1200,height=550&quot;));'>相关信息</a>";
	jQuery(xhxx).val(url);
	jQuery(xhxx+'span').html(url);
}
</script>
