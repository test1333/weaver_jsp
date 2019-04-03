<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
jQuery(document).ready(function () {
    var applyType = 'field8762' // 未打卡类型
    var afterWorkTime = 'field8761' // 下班时间
    // 启动_C.run2函数，目标字段:明细表1的[未打卡类型]
    _C.run2(applyType, function (p) {
        var applyTypeVal = _C.v(applyType + p.r)
        var obj = document.getElementById(afterWorkTime + p.r)
        var field = '#' + afterWorkTime + p.r
        // alert('初始化值：' + p.v.o + '|已有值：' + p.v.n)
        // 页面初始化加载：有值
        if (p.v.o === undefined && p.v.n !== '') {
            if (p.v.n === '0') {
                jQuery(field + ' option[value=\'1\']').remove() // 删除Select中Value='1'的Option
                jQuery(field + ' option[value=\'2\']').remove() // 删除Select中Value='2'的Option
            } else {
                jQuery(field + ' option[value=\'0\']').remove() // 删除Select中Value='0'的Option
            }
        } else {
            if (applyTypeVal === '1' || applyTypeVal === '2') {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='1'>16:30</option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='2'>17:30</option>") // 为Select追加一个Option(下拉项)
                // 去掉必填红色感叹号
                // _C.rs(afterWorkTime + p.r, false)
            } else if (applyTypeVal === '0') {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
                jQuery(field).append("<option value='0'>空</option>") // 为Select追加一个Option(下拉项)
                // _C.rs(afterWorkTime + p.r, false)
            } else {
                jQuery(field).empty()
                jQuery(field).append("<option value=''></option>") // 为Select追加一个Option(下拉项)
            }
        }
    })
})
</script>












