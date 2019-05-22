<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>供应商门户</title>
    <style>
        * { margin: 0; padding: 0; }
        html { height: 100%; }
        body { height: 100%; background: #fff url(images/backgroud.png) 50% 50% no-repeat; background-size: cover;}
        .dowebok { position: absolute; left: 50%; top: 50%; width: 430px; height: 550px; margin: -300px 0 0 -215px; border: 1px solid #fff; border-radius: 20px; overflow: hidden;}
        .logo { width: 104px; height: 104px; margin: 50px auto 80px; background: url(images/login.png) 0 0 no-repeat; }
        .form-item { position: relative; width: 360px; margin: 0 auto; padding-bottom: 30px;}
        .form-item input { width: 288px; height: 48px; padding-left: 70px; border: 1px solid #fff; border-radius: 25px; font-size: 18px; color: #fff; background-color: transparent; outline: none;}
        .form-item button { width: 360px; height: 50px; border: 0; border-radius: 25px; font-size: 18px; color: #1f6f4a; outline: none; cursor: pointer; background-color: #fff; }
        #username { background: url(images/emil.png) 20px 14px no-repeat; }
        #password { background: url(images/password.png) 23px 11px no-repeat; }
        #email { background: url(images/emil.png) 23px 11px no-repeat; }
        #supplier { background: url(images/mould_wev8.png) 23px 11px no-repeat; }
        #company { background: url(images/mould_wev8.png) 23px 11px no-repeat; }
        .tip { display: none; position: absolute; left: 20px; top: 52px; font-size: 14px; color: #f50; }
        .reg-bar { width: 360px; margin: 20px auto 0; font-size: 14px; overflow: hidden;}
        .reg-bar a { color: #fff; text-decoration: none; }
        .reg-bar a:hover { text-decoration: underline; }
        .reg-bar .reg { float: left; }
        .reg-bar .forget { float: right; }
        .dowebok ::-webkit-input-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok :-moz-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok ::-moz-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok :-ms-input-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}

        @media screen and (max-width: 500px) {
            * { box-sizing: border-box; }
            .dowebok { position: static; width: auto; height: auto; margin: 0 30px; border: 0; border-radius: 0; }
            .logo { margin: 50px auto; }
            .form-item { width: auto; }
            .form-item input, .form-item button, .reg-bar { width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" action="" method="post">
        <div id="register" class="dowebok">
        
            <div class="logo"></div>
            <div class="form-item">
                <input id="email" name="email" type="text" autocomplete="off" placeholder="注册邮箱">
            </div>
            <div class="form-item">
                <input id="supplier" name="supplier" type="text" autocomplete="off" placeholder="法人">
            </div>
            <div class="form-item">
                <input id="company" name="company" type="text" autocomplete="off" placeholder="公司名称">
            </div>
            <div class="form-item"><button id="submit" onclick="register()">注册</button></div>
        </div>
    </form>
</body>
</html>
<script src="images/jquery.min.js"></script>
<script src="sweetalert.min.js"></script>
<link rel="stylesheet" href="sweetalert.css">
<script>

    //注册验证
    function register(){
        var email = jQuery("#email").val();
        var supplier = jQuery("#supplier").val();
        var company = jQuery("#company").val();
        // alert("email + supplier + company--------" + email + supplier + company);
        // alert("$('#form1').serialize()="+$('#form1').serialize())
        if(email==""){
//            swal("", "注册邮箱必须输入!", "error");
            alert("注册邮箱必须输入!");
            return false;
        }

        if(!isEmail(email)){
//            swal("", "邮箱格式错误,请重新输入!", "error");
            alert("邮箱格式错误,请重新输入!");
            return false;
        }

        if(supplier==""){
//            swal("", "公司法人必须输入!", "error");
            alert("公司法人必须输入!");
            return false;
        }

        if(company==""){
            alert("公司名称必须输入!");
            return false;
        }

        $.ajax({
        //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "json",//预期服务器返回的数据类型
            url: "/supplier/operation.jsp" ,//url
            data: $('#form1').serialize(),
            success: function (data) {
                console.log(data);//打印服务端返回的数据(调试用)
                alert("data="+data);
                if(data==0){
                    alert("注册成功！");
                    return true;
                }else{
                    alert("该供应商已经存在，请重新填写！");
                    return false;
                }
            },
            error : function() {
                alert("异常！");
            }
        });
    }

  
    function isEmail(mail) {  
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;  

        return filter.test(mail);

    }
    $(function () {
        $('input').val('')
        $('#submit').on('click', function () {
            $('.tip').show()
        })
    })
</script>