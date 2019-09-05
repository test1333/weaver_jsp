<script type="text/javascript">
var kh = '#field12082';// 客户
var xh_dt1 = '#field11993_';// 序号
var bj_dt1 = '#field11996_';// 编辑
var yz_dt1 = '#field11994_';// 原值
var xz_dt1 = '#field11995_';// 新值
var bgzd_dt1 = '#field11992_';// 变更字段
jQuery(document).ready(function () {
	 var indexnum0 = jQuery('#indexnum0').val();
	 for(var index=0;index<indexnum0;index++){
		if(jQuery(bgzd_dt1+index).length>0){
			var url = "<a href=\"javascript:editInfo('" + index + "')\">编辑</a>";
			jQuery(bj_dt1 + index).val(url);
			jQuery(bj_dt1 + index + 'span').html(url);
			
		}
	 }
});
function dourl (index) {
    var seqno = '';
    jQuery.ajax({
        type: 'POST',
        url: '/cx/contract/get-change-seqno.jsp',
        data: {},
        dataType: 'text',
        async: false, // 同步   true异步
        success: function (data) {
            data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            seqno = data;
        }
    });
    jQuery(xh_dt1 + index).val(seqno);
    var url = "<a href=\"javascript:editInfo('" + index + "')\">编辑</a>";
    jQuery(bj_dt1 + index).val(url);
    jQuery(bj_dt1 + index + 'span').html(url);
    jQuery(yz_dt1 + index).attr('readonly', 'readonly');
    jQuery(xz_dt1 + index).attr('readonly', 'readonly');
}
function editInfo (index) {
    var seqno = jQuery(xh_dt1 + index).val();
    var customid = jQuery(kh).val();
    var fieldid = jQuery(bgzd_dt1 + index).val();
    var sfxj_val = "1";//新建 1 查看
    var newvalue = '';
    var oldvalue = '';
    if (fieldid == '') {
        alert('请先选择变更字段');
        return;
    }
    var title = '';
    var url = '/cx/contract/cx-cs-field-change.jsp?customid=' + customid +  '&fieldid=' + fieldid + '&seqno=' + seqno + '&sfxj=' + sfxj_val;
    var diag_vote = new window.top.Dialog();
    diag_vote.currentWindow = window;
    diag_vote.Width = 600;
    diag_vote.Height = 450;
    diag_vote.Modal = true;
    diag_vote.Title = title;
    diag_vote.URL = url;
    diag_vote.isIframe = false;
    diag_vote.CancelEvent = function () {
        diag_vote.close();
        
    };
    diag_vote.show();
}
</script>