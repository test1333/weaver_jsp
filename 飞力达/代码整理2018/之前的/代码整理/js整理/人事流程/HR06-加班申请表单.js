<script type="text/javascript" src="/js/feiliks/date.format.js"></script>
<script type="text/javascript">
    /*
    ����1��
    ҳ������ʱ���ֶε�ǰ���ϵ�ж�.
    ��ʼ����: ֻ��ͬһ�������ڻ���һ�������ڡ�һ������������26��25��
    ��������: �������ڿ�ʼ����Ҳ�����Գ���һ��

    ����2��
    ���㷽ʽ����Ա�������ȼ�OA�Զ���ʾ��1������2���Ӱ�ѣ�5��������:ֻ�ܴ������ݣ�5�����µ�Ĭ�ϼӰ�ѣ�

    ����3��
    1. �۲�ʱ��:Ĭ��Ϊ1; �Ӱ�ʱ�����ڵ���5Сʱ���۲�ʱ�������Ҳ���Ϊ0�������������ݡ�ְ�񣨱����򱣰��೤�����жϣ�����Ը�۲���(��������0)
    2. �Ʋʹ�:�۲�ʱ��0.5Сʱ��1�Σ���1.5Сʱ��2�Σ���1Сʱ���ж�ʱ�俪ʼʱ��8��00��12��:00֮����1��֮����2��
    3. ����Ӱ�ʱ���Զ����㣺���ݽ�������(����ʱ��)-��ʼ����(��ʼʱ��)- �۲�ʱ��

    NEW:
    1��ְ��Ϊ����Ա�ͱ����೤���۲�ʱ���ͼƲʹ�Ĭ��Ϊ0���ҿ���ѡ��
    2�������ȼ�1-4����Ĭ�Ͻ��㷽ʽΪ�Ӱ�ѣ�����ѡ���ݣ�5�������ϣ����㷽ʽΪ���ݣ��Ҳ�����ѡ��
    
    3���Ӱ�����Ϊ��ͨ�Ӱࣨ1�����۲�ʱ����ѡΪ0.5���Ʋʹ�1���۲�ʱ����ѡΪ0���Ʋʹ�0��   --  ��������ѡ
    4���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59������Ӱ���ʱ��С��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
    5���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59������Ӱ���ʱ�����ڵ���5HС��11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
    6���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59������Ӱ���ʱ�����ڵ���11.5,�۲�ʱΪ1.5���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
    7���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59������Ӱ���ʱС��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
    8���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59������Ӱ���ʱ���ڵ���5HС��11.5H,�۲�ʱΪ0.5���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
    9���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59������Ӱ���ʱ���ڵ���11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
    10���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��22:00-07:59���۲�ʱ���ͼƲʹ�Ĭ��Ϊ0���ҿ���ѡ��


    20160912
    1.���ƼӰ����뵥��ϸ����ֻ������ͬһ���͵ļӰࡣ�Ӱ����ͱ�����:1�Ǽ��ռӰ�;2,3Ϊ���ռӰ�
    1��һ��;2,3����һ��

    2.����������Ϻ󽫼Ӱ����͸��µ���ͷ�����ֶ��� .(1.����Ϊ�Ǽ��ռӰ�;2,3����Ϊ���ռӰ�)

    20160916
    1.Ա�������Ǳ�����������óɸ��������Զ���ʾ��
    2.�����ȼ�5�����ϣ����㷽ʽ���Խ���ѡ����Ҫ�������ƣ�ĬȻΪ����
    3.�����ȼ�5�����½��ռӰ����ѡ����ݣ���ҪĬ�ϼӰ�ѣ�
    4.��𲻻��Զ���ʾ����Ҫ�Զ���ʾ��
    5.����Ӱ�ʱ�������Զ���ʾ���ύ�Ժ�Ż���ʾ����Ҫ�Զ���ʾ



    */
    var bufferDays = 4;
    var id_sqrq = "#field6538"; //��������

    var arr_xzdj = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "C", "B", "A"];

    var checkDate = function () {
        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25"));
        var isSuccess = true;
        var flag_jblx = ""; //�Ӱ����ͱ�ʶ
        $("td[name='td_ksrq']").each(function () {

            /*
            ҳ������ʱ���ֶε�ǰ���ϵ�ж�.
            ��ʼ����: ֻ��ͬһ�������ڻ���һ�������ڡ�һ������������26��25��
            ��������: �������ڿ�ʼ����Ҳ�����Գ���һ��
            */
            var td_bDate = $(this);
            var tr = td_bDate.closest("tr");

            if (handleDTChange(tr) == false) {
                isSuccess = false;
                return false;
            }

            var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']");
            var ct = parseInt(i_sqjbss.val());

            /*
            �۲�ʱ��:Ĭ��Ϊ1; 
            �Ӱ�ʱ�����ڵ���5Сʱ���۲�ʱ�������Ҳ���Ϊ0��
            �����������ݡ�ְ�񣨱����򱣰��೤�����жϣ�����Ը�۲���(��������0)
            */
            var i_kcss = tr.find("td[name='td_kcss'] select option:selected");
            var span_zhiwu = tr.find("td[name='td_zhiwu'] span");
            var v_kcss = i_kcss.text();
            var v_zhiwu = span_zhiwu.text();
            v_kcss = isNaN(v_kcss) ? 0 : parseFloat(v_kcss);
            //            if (ct >= 5 && v_kcss =="0" && v_zhiwu.indexOf("����") < 0) {
            //                window.top.Dialog.alert("�Ӱ�ʱ�����ڵ���5Сʱ���۲�ʱ�������Ҳ���Ϊ0(�������򱣰��೤��");

            //                isSuccess = false;
            //                return false;
            //            }

            /*
            �Զ�����ǲʹ�
            */
            if (setJcc(tr) == false) {
                isSuccess = false;
                return false;
            }


            //���㷽ʽ����Ա�������ȼ�OA�Զ���ʾ��
            //1������2���Ӱ�ѣ�5��������:ֻ�ܴ������ݣ�5�����µ�Ĭ�ϼӰ�ѣ�
            var i_xzdj = tr.find("td[name='td_xzdj'] input");
            var v_xzdj = isNaN(i_xzdj.val()) ? 0 : parseInt(i_xzdj.val());

            var i_jsfs = tr.find("td[name='td_jsfs'] select");
            var v_jsfs = i_jsfs.find("option:selected").text();

            if (v_xzdj >= 5 && v_jsfs == "�Ӱ��") {
                window.top.Dialog.alert("5��������ֻ��ѡ�����");
                isSuccess = false;
                return false;
            }


            //�Ӱ�����
            var i_jblx = tr.find("td[name='td_jblx'] input");
            if (i_jblx.val() == "") {
                window.top.Dialog.alert("��ѡ��Ӱ����ͣ�");
                isSuccess = false;
                return false;
            }
            var v_jblx = i_jblx.val() == "1" ? "1" : "2";

            if (flag_jblx == v_jblx) { } else {
                if (flag_jblx == "") {
                    flag_jblx = v_jblx;
                } else {
                    window.top.Dialog.alert("�Ӱ����Ͳ�һ�£�");
                    isSuccess = false;
                    return false;

                }
            }

        });

        $("#field9574").val(flag_jblx);
        if (isSuccess) {
            return true;
        }
        return (false);
    }


    //���üǲʹ�
    /*
    �Ʋʹ�:�۲�ʱ��0.5Сʱ��1�Σ���1.5Сʱ��2�Σ���1Сʱ���ж�ʱ�俪ʼʱ��8��00��12��:00֮����1��֮����2��

    3���Ӱ�����Ϊ��ͨ�Ӱࣨ1�����۲�ʱ����ѡΪ0.5���Ʋʹ�1���۲�ʱ����ѡΪ0���Ʋʹ�0��

    4���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59��
    ����Ӱ���ʱ��С��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
    5���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59��
    ����Ӱ���ʱ�����ڵ���5HС��11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
    6���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��8��00-11��59��
    ����Ӱ���ʱ�����ڵ���11.5,�۲�ʱΪ1.5���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
    7���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59��
    ����Ӱ���ʱС��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
    8���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59��
    ����Ӱ���ʱ���ڵ���5HС��11.5H,�۲�ʱΪ0.5���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
    9���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��12:00-21:59��
    ����Ӱ���ʱ���ڵ���11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
    10���Ӱ�����Ϊ���ݼӰࣨ2���ͽ��ռӰࣨ3�����Ӱ࿪ʼʱ��22:00-07:59���۲�ʱ���ͼƲʹ�Ĭ��Ϊ0���ҿ���ѡ��

    */
    var setJcc = function (tr) {
        var i_kcss = $(tr).find("td[name='td_kcss'] select");
        var i_jcc = $(tr).find("td[name='td_jcc'] input");
        var v_kcss = i_kcss.find("option:selected").text();


        var i_jblx = tr.find("td[name='td_jblx'] input[type='hidden']"); //�Ӱ�����
        var v_jblx = i_jblx.val(); //�Ӱ�����
        var v = 1;

        var span_zhiwu = tr.find("td[name='td_zhiwei'] span");
        var v_zhiwu = span_zhiwu.text();
        if (v_zhiwu.indexOf("����") >= 0) {
            return true;
        }

        //alert(v_jblx);
        if (v_jblx == "1") {//��ͨ�Ӱࣨ1�����۲�ʱ����ѡΪ0.5���Ʋʹ�1,��Ӧ�ģ��۲�ʱ����ѡΪ0���Ʋʹ�0


            if (v_kcss == "0.5") {
                v = 1;
            } else if (v_kcss == "0") {
                v = 0;
            } else {
                v = 1;
                v_kcss = "0.5";
                i_kcss.find("option").each(function () {
                    if (v_kcss == $(this).text()) {
                        $(this).attr("selected", "selected");
                    } else {
                        $(this).attr("selected", null);
                    }
                });

                //window.top.Dialog.alert("��ͨ�Ӱ�,�۲�ʱ��ֻ����ѡ�� 0.5 �� 0 ��");
                //return false;
            }
            i_jcc.val(v);
        } else {
            //���ݼӰࣨ2���ͽ��ռӰࣨ3��
            var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //��ʼʱ��
            var v_kssj = i_kssj.val();
            var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']"); //����Ӱ�ʱ��
            var v_sqjbss = parseFloat(i_sqjbss.val());
            //if (isNaN(v_sqjbss)) { v_sqjbss = 0; }
            if ("08:00" <= v_kssj && v_kssj <= "11:59") {
                /*
                4���Ӱ࿪ʼʱ��8��00-11��59��
                ����Ӱ���ʱ��С��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
                ����Ӱ���ʱ�����ڵ���5HС��11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
                ����Ӱ���ʱ�����ڵ���11.5,�۲�ʱΪ1.5���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
                */
                if (v_sqjbss < 5) {
                    if (v_kcss != "0") {
                        //window.top.Dialog.alert("����Ӱ���ʱ��С��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 0;
                        v_kcss = "0";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 0;
                    }
                } else if (5 <= v_sqjbss && v_sqjbss < 11.5) {
                    if (v_kcss != "1") {
                        //window.top.Dialog.alert("����Ӱ���ʱ�����ڵ���5HС��11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 1;
                        v_kcss = "1";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 1;
                    }
                } else {
                    if (v_kcss != "1.5") {
                        //window.top.Dialog.alert("����Ӱ���ʱ�����ڵ���11.5,�۲�ʱΪ1.5���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 2;
                        v_kcss = "1.5";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 2;
                    }
                }
                i_jcc.val(v);

            } else if ("12:00" <= v_kssj && v_kssj <= "21:59") {
                /*
                7���Ӱ࿪ʼʱ��12:00-21:59��
                ����Ӱ���ʱС��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��
                ����Ӱ���ʱ���ڵ���5HС��11.5H,�۲�ʱΪ0.5���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��
                ����Ӱ���ʱ���ڵ���11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��
                */
                if (v_sqjbss < 5) {
                    if (v_kcss != "0") {
                        //window.top.Dialog.alert("����Ӱ���ʱС��5H,�۲�ʱΪ0���Ʋʹ�Ϊ0���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 0;
                        v_kcss = "0";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 0;
                    }
                } else if (5 <= v_sqjbss && v_sqjbss < 11.5) {
                    if (v_kcss != "0.5") {
                        //window.top.Dialog.alert("����Ӱ���ʱ���ڵ���5HС��11.5H,�۲�ʱΪ0.5���Ʋʹ�Ϊ1���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 1;
                        v_kcss = "0.5";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 1;
                    }
                } else {
                    if (v_kcss != "1") {
                        //window.top.Dialog.alert("����Ӱ���ʱ���ڵ���11.5H,�۲�ʱΪ1���Ʋʹ�Ϊ2���۲�ʱ���ͼƲʹξ�������ѡ��");
                        //return false;
                        v = 2;
                        v_kcss = "1";
                        i_kcss.find("option").each(function () {
                            if (v_kcss == $(this).text()) {
                                $(this).attr("selected", "selected");
                            } else {
                                $(this).attr("selected", null);
                            }
                        });
                    } else {
                        v = 2;
                    }
                }
                i_jcc.val(v);
            } else {
                /*10���Ӱ࿪ʼʱ��22:00-07:59���۲�ʱ���ͼƲʹ�Ĭ��Ϊ0���ҿ���ѡ��*/

            }


        }
        //i_jcc.val(v);

        //        var v = 1;
        //        if (v_kcss == "0.5") {
        //            v = 1;
        //        } else if (v_kcss == "1.5") {
        //            v = 2;
        //        } else if (v_kcss == "1") {
        //            var i_bTime = $(tr).find("td[name='td_beginTime'] input");
        //            var v_bTime = i_bTime.val();
        //            if ("08:00" <= v_bTime && v_bTime <= "12:00") {
        //                v = 1;
        //            } else {
        //                v = 2;
        //            }
        //        } else {
        //            v = 0;
        //        }
        //        i_jcc.val(v);

        return true;
    }

    var handleXZDJChange = function (_tr) {
        var tr = $(_tr);
        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //�����ȼ�
        var i_jsfs = tr.find("td[name='td_jsfs'] input[id^='field8599_'][type='hidden']"); //���㷽ʽ
        var s_jsfs = $("#" + i_jsfs.attr("id") + "span"); //���㷽ʽ

        var i_jsfsms = tr.find("td[name='td_jsfsms'] input"); //���㷽ʽ����
        var s_jsfsms = tr.find("td[name='td_jsfsms'] span"); //���㷽ʽ����

        var v_xzdj = -1;
        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == i_xzdj.val()) {
                v_xzdj = i;
            }
        }

        //1������2���Ӱ�ѣ�5��������:ֻ�ܴ������ݣ�5�����µ�Ĭ�ϼӰ�ѣ�
        if (v_xzdj >= 4) {
            i_jsfs.val("3");
            i_jsfsms.val("����");
            s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '3<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
            s_jsfsms.text("����");

        } else {
            i_jsfs.val("1");
            i_jsfsms.val("�Ӱ��");
            s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '1<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
            s_jsfsms.text("�Ӱ��");

        }
    }


    var handleJSFSCheck = function (_tr) {
        var tr = $(_tr);
        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //�����ȼ�
        var i_jsfs = tr.find("td[name='td_jsfs'] input[id^='field8599_'][type='hidden']"); //���㷽ʽ
        var s_jsfs = $("#" + i_jsfs.attr("id") + "span"); //���㷽ʽ

        var i_jsfsms = tr.find("td[name='td_jsfsms'] input"); //���㷽ʽ����
        var s_jsfsms = tr.find("td[name='td_jsfsms'] span"); //���㷽ʽ����

        var v_xzdj = -1;
        for (i = 0; i < arr_xzdj.length; i++) {
            if (arr_xzdj[i] == i_xzdj.val()) {
                v_xzdj = i;
            }
        }

        //1������2���Ӱ�ѣ�5��������:ֻ�ܴ������ݣ�5�����µ�Ĭ�ϼӰ�ѣ�
        if (v_xzdj >= 4) {
            if ("3" != i_jsfs.val()) {
                i_jsfs.val("3");
                i_jsfsms.val("����");
                s_jsfs.empty().append($('<span class="e8_showNameClass">'
                                + '3<span class="e8_delClass" id="1" onclick="del(event,this,1,false,{});" style="opacity: 0;'
                                    + 'visibility: hidden;">&nbsp;x&nbsp;</span></span>'));
                s_jsfsms.text("����");
                window.top.Dialog.alert("5��������ֻ��ѡ�����");

                return false;
            }
        }
    }


    var handleZWChange = function (_tr) {
        var tr = $(_tr);
        var i_zhiwu = tr.find("td[name='td_zhiwu'] span"); //ְ��
        var i_kcss = $(tr).find("td[name='td_kcss'] select");
        var i_jcc = $(tr).find("td[name='td_jcc'] input");
        if (i_zhiwu.text().indexOf("����") >= 0) {
            i_kcss.val("1");
            i_jcc.val(0);
        }
    }


    var handleDTChange = function (_tr) {
        var tr = $(_tr);
        var i_ksrq = tr.find("td[name='td_ksrq'] input[type='hidden']"); //��ʼ����
        var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //��ʼʱ��
        var i_jsrq = tr.find("td[name='td_jsrq'] input[type='hidden']"); //��������
        var i_jssj = tr.find("td[name='td_jssj'] input[type='hidden']"); //����ʱ��

        var i_sqjbss = tr.find("td[name='td_sqjbss'] input[type='hidden']"); //����Ӱ�ʱ��


        if (i_ksrq.val() == "" || i_kssj.val() == "" || i_jsrq.val() == "" || i_jssj.val() == "") {
            //��Ϣδ���꣬����
            return;
        }

        var date1 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26 00:00"));
        var date2 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25 23:59"));

        var date3 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 0 : -1).Format("yyyy/MM/26 00:00"));
        var date4 = new Date(new Date().addMonths(new Date().getDate() > 25 ? 1 : 0).Format("yyyy/MM/25 23:59"));
        date3.addMonths(1);
        date4.addMonths(1);

        var datetime1 = new Date((i_ksrq.val() + " " + i_kssj.val()).replace(/-/g, "/"));
        var datetime2 = new Date((i_jsrq.val() + " " + i_jssj.val()).replace(/-/g, "/"));
        var ct = datetime1.dateDiff("n", datetime2) / (60);

        ct = Math.round(ct * 100);
        ct = (ct * 0.01);
        //        if (!isNaN(ct)) {
        //            i_sqjbss.val(ct);
        //            $("#" + i_sqjbss.attr("id") + "span").text(ct);
        //        }
        /*
        if ((date1 <= datetime1 && datetime1 <= date2) || (date3 <= datetime1 && datetime1 <= date4)) { } else {
            window.top.Dialog.alert("����" + datetime1.Format("yyyy-MM-dd") + "���ڵ�ǰ���ڣ�" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "������һ���ڣ�" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "���ڣ�");
            return false;
        }
        if ((date1 <= datetime2 && datetime2 <= date2) || (date3 <= datetime2 && datetime2 <= date4)) { } else {
            window.top.Dialog.alert("����" + datetime2.Format("yyyy-MM-dd") + "���ڵ�ǰ���ڣ�" + date1.Format("yyyy-MM-dd") + " - " + date2.Format("yyyy-MM-dd") + "������һ���ڣ�" + date3.Format("yyyy-MM-dd") + " - " + date4.Format("yyyy-MM-dd") + "���ڣ�");
            return false;
        }
        */

        if ((0 <= ct && ct <= 48)) { } else {
            window.top.Dialog.alert("��������+����ʱ��������ڿ�ʼ����+��ʼʱ�䣬����48Сʱ�ڣ�");
            return false;
        }

    }

    var initDetail = function () {
        var td_kcss = $("#oTable0 td[name='td_kcss'] select:last");
        var tr = td_kcss.closest("tr");

        td_kcss.change(function () {
            setJcc($(this).closest("tr"));
        });
        var i_jblx = tr.find("td[name='td_jblx'] input[type='hidden']"); //�Ӱ�����
        jQuery("#" + i_jblx.attr("id")).bindPropertyChange(function () { setJcc(tr); });



        var i_xzdj = tr.find("td[name='td_xzdj'] input"); //�����ȼ�
        jQuery("#" + i_xzdj.attr("id")).bindPropertyChange(function () { handleXZDJChange(tr); });

        var i_jsfs = tr.find("td[name='td_jsfs'] input[type='hidden']"); //���㷽ʽ
        jQuery("#" + i_jsfs.attr("id")).bindPropertyChange(function () { handleJSFSCheck(tr); });

        var i_ksrq = tr.find("td[name='td_ksrq'] input[type='hidden']"); //��ʼ����
        jQuery("#" + i_ksrq.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_kssj = tr.find("td[name='td_kssj'] input[type='hidden']"); //��ʼʱ��
        jQuery("#" + i_kssj.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_jsrq = tr.find("td[name='td_jsrq'] input[type='hidden']"); //��������
        jQuery("#" + i_jsrq.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });
        var i_jssj = tr.find("td[name='td_jssj'] input[type='hidden']"); //����ʱ��
        jQuery("#" + i_jssj.attr("id")).bindPropertyChange(function () { handleDTChange(tr); });


        var i_zhiwu = tr.find("td[name='td_zhiwu'] input[type='hidden']"); //ְ��
        jQuery("#" + i_zhiwu.attr("id")).bindPropertyChange(function () { handleZWChange(tr); });

    }



    checkCustomize = function () {
        var isSuccess = true;

        var i_sqrq = $(id_sqrq);

        $("td[name='td_ksrq'] input[type='hidden']").each(function () {

            var d1 = new Date($(this).val().replace(/-/g, "/")); //��ʼ����
            var d2 = new Date(i_sqrq.val().replace(/-/g, "/")); //��������
            if (d1.addDays(bufferDays) < d2) {
                window.top.Dialog.alert("���������������ڷ�Χ���������ύ" + bufferDays + "���ڵ����룡");
                isSuccess = false;
                return false;
            }


        });

        if (isSuccess) {
            isSuccess = checkDate();
        }

        return isSuccess;
    }

    jQuery(document).ready(function () {
        $("#div0button .addbtn_p").click(function () { initDetail() });
        window.setTimeout("initDetail()", 1000);
    });



</script>



