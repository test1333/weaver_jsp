<script type="text/javascript" src="/goodbaby/adore/js/cw.js"></script>
<script type="text/javascript">
var wbje="#field16932";
var sjje="#field_lable7006";
jQuery(document).ready(function(){
	jQuery(wbje).attr("readonly", "readonly");
	jQuery(sjje).attr("readonly", "readonly");
});

jQuery(document).ready(function () {
    checkCustomize = function () {


        // 遍历明细表1
        var arr = []
        _C.stEach(t1.rq, function (r) {

            if (_C.v(t1.rq + r) !== '' && _C.v(t1.cflx + r) !== '') {
                arr.push(_C.v(t1.rq + r) + _C.v(t1.cflx + r))
            }
        })
        if (isRepeat(arr)) {
            Dialog.alert('同一天相同餐费类型只能出现一次')
            return false
        }
        return true
    }

    _C.run2(t1.ccje, function (p) {
        // console.log('p1=' + p.k)
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    _C.run2(t2.ccje, function (p) {
        // console.log('p1=' + p.k)
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    _C.run2(t3.ccje, function (p) {
        // console.log('p1=' + p.k)
        jQuery('#' + p.k + p.r).attr('readonly', 'readonly')
    })

    // 职级变化
    _C.run2(t0.appLevel, function () {
        // 检查餐费
        _C.stEach(t1.rq, function (r) {
            isMealOver(r)
        })

        // 检查住宿费
        _C.stEach(t2.rq, function (r) {
            isHotelOver(r)
        })
    })

    // 明细1区域类别
    _C.run2(t1.qylb, function (p) {
        // console.log('p.r=' + p.r)
        isMealOver(p.r)
    })

    // 明细1参加人数
    _C.run2(t1.cjrs, function (p) {
        isMealOver(p.r)
    })

    // 明细1陪同人数
    _C.run2(t1.ptrs, function (p) {
        isMealOver(p.r)
    })

    // 明细1报销金额
    _C.run2(t1.rmbje, function (p) {
        isMealOver(p.r)
    })

    // 明细2参加人数
    _C.run2(t2.cjrs, function (p) {
        isHotelOver(p.r)
    })

    // 明细2报销金额
    _C.run2(t2.rmbje, function (p) {
        isHotelOver(p.r)
    })

   // 明细2住宿时长
    _C.run2(t2.zcsc, function (p) {
        isHotelOver(p.r)
    })

    // 明细3参加人数
    _C.run2(t3.cjrs, function (p) {
        isGiftOver(p.r)
    })

    // 明细3报销金额
    _C.run2(t3.rmbje, function (p) {
        isGiftOver(p.r)
    })
})

/**
 * 检查数组是否有重复元素
 *
 * @param {*} arr 数组
 * @return boolean
 */
function isRepeat (arr) {
    var hash = {}
    for (var i in arr) {
        if (hash[arr[i]]) {
            return true
        }
        hash[arr[i]] = true
    }
    return false
}

/**
 * 检查餐费是否超标准
 *
 * @param {string} r 明细表下标
 */
function isMealOver (r) {
    var result = true
    var total = _C.v(t1.rmbje + r)
    var level = _C.v(t0.appLevel)
    var area = _C.v(t1.qylb + r)
    var join = _C.v(t1.cjrs + r)
    var accompany = _C.v(t1.ptrs + r)
    var most = getMealLevel(area, level)
    var momeyAll = Number(most) * (Number(join) +Number(accompany) + 1)
    if (Number(total) > Number(momeyAll)) {
        var over = Number(total) - Number(momeyAll)
        _C.v(t1.ccje + r, over)
        disableSelected(t1.sfcbbz + r, '0')
        trBackground(t1.sfcbbz + r, '0')
    } else {
        _C.v(t1.ccje + r, '0.00')
        disableSelected(t1.sfcbbz + r, '1')
        trBackground(t1.sfcbbz + r, '1')
    }

    return result
}

/**
 * 检查礼品费是否超标准
 *
 * @param {string} r 明细表下标
 */
function isGiftOver (r) {
    var total = _C.v(t3.rmbje + r)
    var join = _C.v(t3.cjrs + r)
    var momeyAll = Number(join) * 300
    if (Number(total) > Number(momeyAll)) {
        var over = Number(total) - Number(momeyAll)
        _C.v(t3.ccje + r, over)
        disableSelected(t3.sfcbbz + r, '0')
        trBackground(t3.sfcbbz + r, '0')
    } else {
        _C.v(t3.ccje + r, '0.00')
        disableSelected(t3.sfcbbz + r, '1')
        trBackground(t3.sfcbbz + r, '1')
    }
}

/**
 * 检查住宿费是否超标准
 *
 * @param {string} r 明细表下标
 */
function isHotelOver (r) {
    var total = _C.v(t2.rmbje + r)
    var level = _C.v(t0.appLevel)
    var area = _C.v(t2.qylb + r)
    var join = _C.v(t2.cjrs + r)
    var zcscT = _C.v(t2.zcsc + r)
    var most = getHotelLevel(area, level)
    var momeyAll = Number(most) * Number(join) * Number(zcscT) 
    if (Number(total) > Number(momeyAll)) {
        var over = Number(total) - Number(momeyAll)
        _C.v(t2.ccje + r, over)
        disableSelected(t2.sfcbbz + r, '0')
        trBackground(t2.sfcbbz + r, '0')
    } else {
        _C.v(t2.ccje + r, '0.00')
        disableSelected(t2.sfcbbz + r, '1')
        trBackground(t2.sfcbbz + r, '1')
    }
}

/**
 * 选择框只读
 *
 *
 * @param {string} fieldid  表单字段
 * @param {string} flag 标识
 */
function disableSelected (fieldid, flag) {
    jQuery('#' + fieldid).empty()
    // 保存到数据库的值
    // jQuery('#' + fieldid).val(flag)
    // 选中之后页面展示的值
    // _C.v('dis' + fieldid, flag)
    if (flag === '0') {
        jQuery('#' + fieldid).append("<option value='0' selected>是</option>") // 为Select追加一个Option(下拉项)
    } else {
        jQuery('#' + fieldid).append("<option value='1' selected>否</option>") // 为Select追加一个Option(下拉项)
    }
}

/**
 * 餐费报销标准
 *
 * @param {string} cityType 地区类别
 * @param {string} level 申请人职级
 * @return {Number}  result 报销标准
 */
function getMealLevel (cityType, level) {
    var result = 0
    if (cityType === '0') {
        if (Number(level) >= 17) {
            result = 400
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 300
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 200
        } else if (Number(level) <= 12) {
            result = 150
        }
    } else if (cityType === '1') {
        if (Number(level) >= 17) {
            result = 300
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 200
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 150
        } else if (Number(level) <= 12) {
            result = 100
        }
    } else if (cityType === '2' || cityType === '3') {
        if (Number(level) >= 17) {
            result = 200
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 150
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 100
        } else if (Number(level) <= 12) {
            result = 80
        }
    } else {
        result = 0
    }
    return result
}

/**
 * 住宿费报销标准
 *
 * @param {string} cityType 地区类别
 * @param {string} level 申请人职级
 * @return {Number}  result 报销标准
 */
function getHotelLevel (cityType, level) {
    var result = 0
    if (cityType === '0') {
        if (Number(level) >= 17) {
            result = 600
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 400
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 350
        } else if (Number(level) <= 12) {
            result = 300
        }
    } else if (cityType === '1') {
        if (Number(level) >= 17) {
            result = 500
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 370
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 300
        } else if (Number(level) <= 12) {
            result = 220
        }
    } else if (cityType === '2' || cityType === '3') {
        if (Number(level) >= 17) {
            result = 400
        } else if (Number(level) >= 15 && Number(level) <= 16) {
            result = 340
        } else if (Number(level) >= 13 && Number(level) <= 14) {
            result = 280
        } else if (Number(level) <= 12) {
            result = 200
        }
    } else {
        result = 0
    }
    return result
}

function checkMainOver (flag) {
        // 保存到数据库的值
        // jQuery('#' + t0.sfcbz).val(flag)
        // 选中之后页面展示的值
        // _C.v('dis' + t0.sfcbz, flag)

        // edit 2018-08-13 11:56:21 选择框只读
        disableSelected(t0.sfcbz, flag)
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

var t0 = {
    _index: 0,
    appLevel: 'field17015' /** 申请人职级-varchar(500)**/

}
var t1 = {
    _index: 1,
    rq: 'field16937' /** 费用发生日期-char(10)**/,
    ycmd: 'field16938' /** 应酬目的-varchar(300)**/,
    kelx: 'field16939' /** 客户类型-varchar(300)**/,
    khgsmc: 'field16940' /** 客户公司名称-varchar(300)**/,
    kemz: 'field16941' /** 客户名字-varchar(300)**/,
    bz: 'field16942' /** 备注-varchar(300)**/,
    sfcbbz: 'field16943' /** 是否超标准-int**/,
    bxje: 'field16949' /** 报销金额-decimal(15,2)**/,
    bz1: 'field16950' /** 币种-browser.huin**/,
    hl: 'field16951' /** 汇率-decimal(15,4)**/,
    rmbje: 'field16952' /** 人民币金额-decimal(15,2)**/,
    cflx: 'field16969' /** 餐费类型-int**/,
    dq: 'field16970' /** 地区-int**/,
    cs: 'field16971' /** 城市-browser.cs**/,
    qylb: 'field16972' /** 区域类别-int**/,
    sl: 'field16973' /** 税率-decimal(15,2)**/,
    sj: 'field16974' /** 税金-decimal(15,2)**/,
    ccje: 'field16975' /** 超出金额-decimal(15,2)**/,
    cjrs: 'field16997' /** 参加人数-int**/,
    ptrs: 'field16998' /** 陪同人数-int**/
}
var t2 = {
    _index: 2,
    rq: 'field16976' /** 费用发生日期-char(10)**/,
    ycmd: 'field16977' /** 应酬目的-varchar(300)**/,
    kelx: 'field16978' /** 客户类型-varchar(300)**/,
    khgsmc: 'field16979' /** 客户公司名称-varchar(300)**/,
    kemz: 'field16980' /** 客户名字-varchar(300)**/,
    cjrs: 'field16981' /** 参加人数-int**/,
    jdmc: 'field16982' /** 酒店名称-varchar(300)**/,
    qzrq: 'field16983' /** 起住日期-char(10)**/,
    jsrq: 'field16984' /** 结束日期-char(10)**/,
    dq: 'field16985' /** 地区-int**/,
    cs: 'field16986' /** 城市-browser.cs**/,
    qylb: 'field16987' /** 区域类别-int**/,
    bxje: 'field16988' /** 报销金额-decimal(15,2)**/,
    sl: 'field16989' /** 税率-decimal(15,2)**/,
    sj: 'field16990' /** 税金-decimal(15,2)**/,
    bz1: 'field16991' /** 币种-browser.huin**/,
    hl: 'field16992' /** 汇率-decimal(15,4)**/,
    rmbje: 'field16993' /** 人民币金额-decimal(15,2)**/,
    bz: 'field16994' /** 备注-varchar(300)**/,
    sfcbbz: 'field16995' /** 是否超标准-int**/,
    ccje: 'field16996' /** 超出金额-decimal(15,2)**/,
    zcsc: 'field17016' /** 住宿时长-decimal(15,2)**/
}
var t3 = {
    _index: 3,
    rq: 'field16999' /** 费用发生日期-char(10)**/,
    ycmd: 'field17000' /** 应酬目的-varchar(300)**/,
    kelx: 'field17001' /** 客户类型-varchar(300)**/,
    khgsmc: 'field17002' /** 客户公司名称-varchar(300)**/,
    kemz: 'field17003' /** 客户名字-varchar(300)**/,
    cjrs: 'field17004' /** 参加人数-int**/,
    bxje: 'field17005' /** 报销金额-decimal(15,2)**/,
    sl: 'field17006' /** 税率-decimal(15,2)**/,
    sj: 'field17007' /** 税金-decimal(15,2)**/,
    bz1: 'field17008' /** 币种-browser.huin**/,
    hl: 'field17009' /** 汇率-decimal(15,4)**/,
    rmbje: 'field17010' /** 人民币金额-decimal(15,2)**/,
    bz: 'field17011' /** 备注-varchar(300)**/,
    sfcbbz: 'field17012' /** 是否超标准-int**/,
    ccje: 'field17013' /** 超出金额-decimal(15,2)**/
}

</script>	

























