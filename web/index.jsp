<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Java后端WebSocket的Tomcat实现</title>
	<style>
		.video{
			z-index: -100;
		}

		.divAn {
			opacity: 0;
			position: absolute;
			animation: myfirst 2s linear 0s 1 normal; /* Safari 和 Chrome: */
			-moz-animation: myfirst 2s linear 0s 1 normal; /* Firefox: */
			-webkit-animation: myfirst 2s linear 0s 1 normal; /* Safari 和 Chrome: */
			-o-animation: myfirst 2s linear 0s 1 normal; /* Opera: */
		}

		@keyframes myfirst {
			0% {
				opacity: 0;
				left: 80%;
			}
			50% {
				opacity: 1;
				left: 40%;
			}
			100% {
				opacity: 0;
				left: 0px;
				visibility: hidden;
			}
		}
	</style>
</head>

<body>
<div id="in" style="height: 300px">
	<p align="center">
		<video width="640" height="480"
			   controls="controls" autoplay="autoplay" src="yourname.mp4">
		</video>
	</p>

</div>
<br>
<br><br><br><br><br><br><br><br>
<div style="text-align: center">
	<input type="text" id="textT" value="我是弹幕">
	<input type="button" onclick="javascript:sendmess()" value="send" style="top: 100px;">
</div>
<p id="message"></p>
</body>

<script type="text/javascript">
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        //websocket = new WebSocket("ws://localhost:8080/t/websocket");
        websocket = new WebSocket("ws://cxyzf.cn:8080/t/websocket");
    }
    else {
        alert('当前浏览器 Not support websocket')
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        setMessageInnerHTML("WebSocket连接发生错误");
    };

    //连接成功建立的回调方法
    websocket.onopen = function () {
        setMessageInnerHTML("WebSocket连接成功");
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
        setMessageInnerHTML(event.data);
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
        setMessageInnerHTML("WebSocket连接关闭");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        var s = randomBy(5, 200);
        var idNumber = Date.parse(new Date());
        //alert(innerHTML);
        var alertString = '<div class="divAn" style="top:' + s + 'px;" id="' + idNumber + '">' + innerHTML + '</div>';
        $("#in").append(alertString);
        window.setTimeout(function () {
            $("#" + idNumber).remove();
        }, 80000);

        document.getElementById('message').innerHTML += innerHTML + '<br/>';
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function sendmess() {
        var str=$("#textT").val();
		//alert(str)
        websocket.send(str);
    }
</script>

<script src="http://cdn.bootcss.com/jquery/3.0.0-alpha1/jquery.min.js"></script>

<script type="application/javascript">
    function send(str)
	{
	    /*
        var s = randomBy(5, 200);
        var idNumber = Date.parse(new Date());
        var alertString = '<div class="divAn" style="top:' + s + 'px;" id="' + idNumber + '">' + $("#textT").val() + '</div>';
        alert($("#textT").val());
        $("#in").append(alertString);
        window.setTimeout(function () {
            $("#" + idNumber).remove();
        }, 2000);
        sendmess($("#textT").val())
        */
        var alertString = '<div class="divAn" style="top:' + s + 'px;" id="' + idNumber + '">' + str + '</div>';
        alert(str);
        $("#in").append(alertString);
        window.setTimeout(function () {
            $("#" + idNumber).remove();
        }, 80000);
    }

    function randomBy(under, over) {
        switch (arguments.length) {
            case 1:
                return parseInt(Math.random() * under + 1);
            case 2:
                return parseInt(Math.random() * (over - under + 1) + under);
            default:
                return 0;
        }
    }
</script>
</html>