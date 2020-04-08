<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var wbje="#field12810";
var sjje="#field_lable6927";
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");
});

jQuery(document).ready(function () {
    // 检查差旅交通明细
    checkIsOver(t1.sfcbz)

    // 检查差旅住宿明细
    checkIsOver(t2.sfcbz)

    // 检查差旅餐费明细
    checkIsOver(t3.sfcbz)

    /**
     * 检查是否需要添加黄色背景
     *
     * @param {string} fieldid 被检查的字段id，明细字段
     */
    function checkIsOver (fieldid) {
        // 检查差旅餐费明细
        _C.stEach(fieldid, function (r) {
            if (_C.v(fieldid + r) === '0') {
                trBackground(fieldid + r, '0')
            }
        })
    }

    /**
     * 修改明细行背景色
     *
     * @param {string} fieldid 字段id
     * @param {string} flag 标识，0添加背景，1取消背景
     * @return void
     */
    function trBackground (fieldid, flag) {
        var td = jQuery('#' + fieldid).parent()
        if (flag === '0') {
            // 该行添加黄色背景色
            td.parent().attr('style', 'background-color:yellow')
        } else {
            // 该行删除背景色
            td.parent().removeAttr('style')
        }
    }
})

var t1 = {
    sfcbz: 'field16627' /** 是否超标准-int**/
}
var t2 = {
    sfcbz: 'field16652' /** 是否超标准-int**/
}
var t3 = {
    sfcbz: 'field16660' /** 是否超标准-int**/
}

</script>













































































