共90节课
webrtc 只定义了客户端规范，服务端没有定义规范
应用音视频通话，人脸识别

webrtc：
网络传输
回音消除降噪
即时通讯
各个模块都可以拆分出来直接用
https://appr.tc  客户端和服务端输入同一个房间号，就可以通讯了


webrtc整体架构：
网上可以找到一幅图：
由上到下：
web api  浏览器调用的api
webrtc c(c++) api ios/android等可调用这里实现
session managment/abstract signaling 上下文，包括音视频，网络传输一些配置信息
核心层：
voice engine 声频引擎
   iSAC/iLBC Codec 编解码库
   NetEQ for voice  解决传输中音频包抖动
   Echo Canceler/.. 回声消除，降噪
video engine 视频引擎
   vp8 codec   编解码库
   video jitter buffer 解决传输中视频包抖动
   image enhancem ents  图像滤镜
Transport 传输引擎
    srtp 建立在udp之上的rtp协议，srtp是安全的
    mutiplexing 缓冲
    p2p 传输  stun+turn+ice
最底层：可自定义，渲染是用户自己实现
Audio catureRender  音频采集
Video Capture    视频采集
Network I/O   网络io
    

webrtc目录结构
api 提供我们调用的接口，以及修改接口
call 对视频流，音频流管理，一个call 代表同一个端口的管理
video 视频编解码逻辑
audio 音频编解码逻辑
common_audio 音频算法相关
common+video 视频算法相关
media 与多媒体相关的逻辑处理
logging 日志相关
module 最重要，里面包括很多子模块
pc  peer connection连接相关逻辑层，拿到流，以及流信息，流里面又包括音频视频轨 ，轨是永远平行的
p2p  端到端传输首先检测p2p能否打通，以及p2p相应协议stun,turn 以及检测是否打通
rtc_base  统一线程，锁调用
rtc_tool 音视频的分析工具，i,p帧，头
tool_webrtc 测试工具，音视频网络测试,webrtc测试
system_wrappers  与操作系统相关，如cpu 原子操作
stas 存放各种统计数据 丢包率 抖动时长
sdk  存放android ios层代码 音视频采集，渲染


module 下的子模块：
  audio_coding  音频编解码器
  audio_device  以前所有设备的音频采集，播放代码都放在这里
  audio_mixer   混音相关的，两三个人同时说话，把音频混一起
  audio_processing 音频回音消除，降噪，前后处理的相关代码，这里面又分了很多子目录
  bitrate_controller  音视频码流的控制
  congestion_controller 网络比较高就进行流量控制
  desk cature 桌面录制采集
  pacing 码率是怎样的，然后作平滑处理
  remote_bitrate_estimator  远端码率评保，检测我能发多少，对方能收多少
  rtp_rtcp  rtp/rtcp相关的代码
  video_capture  视频采集相关
  video_coding   视频编码相关 h264 vp8 vp9
  video_processing  视频前后处理相关代码，视频帧检测增强
  
  
  webrtc运行机制
  
  track轨：视频是一个轨 双声道是两路轨， 永远不相交
  mediastream流:媒体流里面包含很多轨，音频轨，视频轨，字幕轨
  
  
  webrtc类：
   mediastream流:媒体流里面包含很多轨，音频轨，视频轨，字幕轨
   RTCPeerConnection: 对开发者简单，只需建立连接，把流放到这连接中，其它就不用管，底层包括p2p传输，是否能打通，不能打通需要中转
   RTCDataChannel:非音视频数据通过它传输，它是通过 RTCPeerConnection拿到的，把数据给它就传输了
   
RTCPeerConnection的调用过程，api方法调用过程有两幅图，2-3可深入去看



web 服务器：
nodejs javacript开发的服务器，一份代码是控制服务器的，一份代码是浏览器运行的

nojejs工作原理：
javascript代码通过V8 javascript编码成二进制，调用node.js api
node.js api把代码的命令放入libuv库
libuv库创建一个事件队列，事件循环去从队列取命令，放到线程中执行
执行结果再回调，通过os operation回调给客户端
nodejs分服务端和客户端两个v8引擎


nodejs的安装
二进制安装
源码安装：生成makefile，编译，安装

无盘tu二进制安装：
apt/brew/yum install nodejs
apt/brew/yum install npm //这是nodejs 依赖的一个库


源码安装：
官网找到源码地址：nodejs.cn/download/

weget -c 下载地址
tar -zvxf 包名
./configure 生成makefile文件
./configure --prefix=/usr/local/nodejs 安装makefile指定路径
python tools/gyp_node.py --no-parall -f make-linux  如果没有python安装python
此时makefile文件生成
make -j 4 && sudo make install  //编译完再安装

安装完成：/nodejs/可看到node npm npx已经安装上了
环境变量：
vi ~/.bashrc
export PATH=/usr/local/nodejs/bin:$PATH:
source ~/.bashrc使环境变量生效
env | grep PATH 查看环境变量

使用：node
node --version





最简单的http服务：
require 引入http模块
创建http服务方法
指定监听端口

创建server.js：

'use strict'//使用最严格的语法

var http = require('http');//引入http模块

var app = http.createServer(function(req, res){//创建http模块
	res.writeHead(200, {'Content-Type':'text/plain'});//写一个返回的头，即内容
	res.end('Hello World\n');//响应结束返回字符串
}).listen(8080, '0.0.0.0');//监听端口 任意网卡


启动服务：
node server.js

测试：
netstat -ntpl查看到已经启动

www.learningrtc.cn:8080 可显示

启动服务并在后台运行：
nohub node server.js & //日志会有问题

每三方工具启动后台运行：
forever start server.js  //内部也是调用的nohub

安装forever:
npm install forever -g //在机器上任何位置可调forever -g

停止nodejs：
forever stop server.js 



nodejs搭建https服务：

生成htts证书 分公有和私有，这里是公有证书
引入https模块
指定证书位置，并创建https服务
创建目录
mkdir https_server
拷贝证书到当前目录下
1636_www.learningrtc.cn.key 1636_www.learningrtc.cn.pem
把上面证书key 和证书移动到cert目录下
mkdir cert
mv 1636_www.learningrtc.cn.key 1636_www.learningrtc.cn.pem ./cert/

server.js

'use strict'//使用最严格的语法

var https = require('https');//引入http模块
var fs = require('fs');//读证书的

var options = {
  key  : fs.readFileSync('./cert/1557605_www.learningrtc.cn.key'),
  cert : fs.readFileSync('./cert/1557605_www.learningrtc.cn.pem')
}

var app = https.createServer(options, function(req, res){//创建http模块
	res.writeHead(200, {'Content-Type': 'text/plain'});//写一个返回的头，即内容
	res.end('HTTPS:Hello World!\n');//响应结束返回字符串


}).listen(443, '0.0.0.0');//监听端口 任意网卡 https都是443端口


运行：node server.js
netstat - ntpl | grep 443
forever start server.js

浏览器：https://learningrtc.cn



真正的web服务器
引用express模块，里面有很多模块，这里专门处理web服务
引入serve-index模块，可能把web目录共享出来
指定发布目录

实现一个webserver即支持http又支持https服务
并设定一个发布目录

'use strict'

var http = require('http');
var https = require('https');
var fs = require('fs');

var serveIndex = require('serve-index');

var express = require('express');//引入模块
var app = express();

//顺序不能换
app.use(serveIndex('./public'));//浏览路径
app.use(express.static('./public'));//使用静态目录

var options = {
	key  : fs.readFileSync('./cert/1557605_www.learningrtc.cn.key'),
	cert : fs.readFileSync('./cert/1557605_www.learningrtc.cn.pem') 
}

var https_server = https.createServer(options, app);//传入express模块
https_server.listen(443, '0.0.0.0');

var http_server = http.createServer(app);//传入express模块
http_server.listen(80, '0.0.0.0');


安装模块：
npm install express 
npm install serve-index

node server.js

nestat -ntpl | grep 80 查看被占用的端口
kill -9 杀不死
进入到server.js 所在目录forever stop server.js  停止占用的80端口

这时候访问浏览器，会访问到发布的publish目录，里面会显示public目录下的两个文件



javascript基础知识的使用

js调试工具的使用
google浏览器上的一个调试javascript工具



js 学习
console.log('case');



webrtc设备管理
webrtc获取音视频
enumerateDevices 获取音视频设力求
var ePromise= navigator.mediaDevices.enumerateDevices();//获取设备列表
ePromise中MediaDevicesInfo:
	deviceID  设备id
	label     设备的名字
	kind      设备种类，是输入还是输出
	groupID   如果两个设备groupid相同，则是同一个物理设备，如音频输入输出
	
javascript中的promise
promise为javascript提供了异步执行功能
创建一个Promise对象，把handle(resolve,reject)方法交给Promise对象，这个方法会处理一些逻辑
如果成功处理，Promise对象会回调then的on_resolve方法，如果失败回调cache的on_reject方法
Promise的状态分为开始，处理中，处理成功，处理失败
var ePromise= navigator.mediaDevices.enumerateDevices();//其实在这里就为Promise注册了handle(resolve,reject)方法

这两个创建的都放到public中去
代码：vi index.html


<html>
	<head>
		<title> WebRTC get audio and video devices</title>
	</head>
	<body>
		<div>
			<label>audio input device:</label>
			<select id="audioSource"></select>//音频输入选择列表
		</div>
		<div>
			<label>audio output device:</label>
			<select id="audioOutput"></select>//音频输出设备列表
		</div>
		<div>
			<label>video input device:</label>
			<select id="videoSource"></select>//视频设备列表
		</div>

		<script src="./js/client.js"></script>//引入脚本，浏览器会调用底层v8去解析js
	</body>
</html>



vi client.js

'use strict'
var audioSource  = document.querySelector("select#audioSource");//获取到元素
var audioOutput  = document.querySelector("select#audioOutput");
var videoSource  = document.querySelector("select#videoSource");

if(!navigator.mediaDevices ||
	!navigator.mediaDevices.enumerateDevices){//浏览器是否支持这里的方法
	console.log('enumerateDevices is not supported!');
}else {
	navigator.mediaDevices.enumerateDevices()
		.then(gotDevices)//成功
		.catch(handleError);//失败
}

function gotDevices(deviceInfos){
	deviceInfos.forEach( function(deviceInfo){//遍列数组
		console.log(deviceInfo.kind + ": label = " 
				+ deviceInfo.label + ": id = "
				+ deviceInfo.deviceId + ": groupId = "
				+ deviceInfo.groupId);//打印出设备的信息	
		var option = document.createElement('option');//创建一个选项
		option.text = deviceInfo.label;
		option.value = deviceInfo.deviceId;
		if(deviceInfo.kind === 'audioinput'){//音频输出，则加入一个标签
			audioSource.appendChild(option);
		}else if(deviceInfo.kind === 'audiooutput'){
			audioOutput.appendChild(option);
		}else if(deviceInfo.kind === 'videoinput'){
			videoSource.appendChild(option);
		}
	});

}

function handleError(err){
	console.log(err.name + " : " + err.message);
}



访问必须使用https，safari浏览器不能获取

webrtc音视频数据采集
音视频采集api


MediaStreamConstraints：
dictionary MediaStreamConstraints{
    (boolean or MediaTrackConstraints)video = false;//通过设置bool值来表示是否采集音频或视频，也可以设置MediaTrackConstraints采集自定义参数的视频
    (boolean or MediaTrackConstraints)audio = false;
}

var promise = navigator.mediaDevices.getUserMedia(MediaStreamConstraints Constraints)采集音视频

代码案例：
在public目录下mkdir  mediastream
vi index.html

<html>
	<head>
		<title>WebRTC capture video and audio</title>

		<link rel="stylesheet" href="css/main.css"/>
	</head>

	<body>
		<video autoplay playsinline id="player"></video>//自动播放 在页面中播放
		<script src="./js/client.js"></script>//调用浏览器api，通过api去调用webrtc核心层捕获音视频数据输出播放出来
	</body>
</html>



vi client.js

'use strict'

var videoplay = document.querySelector('video#player');//获取到html中播放器的标签

//获取到这个流，这个流中包含音频轨和视频轨
function gotMediaStream(stream){
	videoplay.srcObject = stream;//把流给这个音频标签
}

function handleError(err){
	console.log('getUserMedia error:', err);
}

if(!navigator.mediaDevices ||
	!navigator.mediaDevices.getUserMedia){
	console.log('getUserMedia is not supported!');
	return;
}else{
		var constraints = {
		video : true, 
		audio : true 
	}
	navigator.mediaDevices.getUserMedia(constraints)
		.then(gotMediaStream)//成功调用些方法
		.catch(handleError);//失败调用此方法
}






WEBRTC_API浏览器的适配

getUserMedia适配
各个浏览器厂商内部实现的getUserMedia名字不同
getUserMedia
webkitGetUserMedia  google
mozGetUserMedia     fixfox

//是否有这个方法，有就赋值，这种兼容比较麻烦
var getUserMedia = navigator.getUserMedia 
       || navigator.webkitGetUserMedia

使用google开源库 adapter.js去适配
https://webrtc.github.io/adapter/adapter-latest.js
       || navigator.mozGetUserMedia

vi index.html

<html>
	<head>
		<title>WebRTC capture video and audio</title>

		<link rel="stylesheet" href="css/main.css"/>
	</head>

	<body>
		<video autoplay playsinline id="player"></video>//自动播放 在页面中播放
		<script src="./js/client.js"></script>//调用浏览器api，通过api去调用webrtc核心层捕获音视频数据输出播放出来
		<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>//适配不同的浏览器
	</body>
</html> 


这样不同浏览器都可以看到效果





获取音视频设备的访问权限
在苹果下是看不到设备的名字的，因为苹果下对设备的访问权限更严格，所以看不到设备信息
可以弹出一个窗口，提示是否允许访问设备


vi index.html

<html>
	<head>
		<title>WebRTC capture video and audio</title>

		<link rel="stylesheet" href="css/main.css"/>
	</head>

	<body>
	    //设备显示信息
	    <div>
			<label>audio Source:</label>
			<select id="audioSource"></select>
		</div>

		<div>
			<label>audio Output:</label>
			<select id="audioOutput"></select>
		</div>

		<div>
			<label>video Source:</label>
			<select id="videoSource"></select>
		</div>
	
	
	    //流播放
		<video autoplay playsinline id="player"></video>//自动播放 在页面中播放
		<script src="./js/client.js"></script>//调用浏览器api，通过api去调用webrtc核心层捕获音视频数据输出播放出来
		<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>//适配不同的浏览器
	</body>
</html> 




vi client.js

'use strict'
//devices
var audioSource = document.querySelector('select#audioSource');
var audioOutput = document.querySelector('select#audioOutput');
var videoSource = document.querySelector('select#videoSource');

var videoplay = document.querySelector('video#player');//获取到html中播放器的标签

//获取设备信息
function gotDevices(deviceInfos){

	deviceInfos.forEach(function(deviceinfo){//拿到设备信息

		var option = document.createElement('option');
		option.text = deviceinfo.label;
		option.value = deviceinfo.deviceId;
	
		if(deviceinfo.kind === 'audioinput'){
			audioSource.appendChild(option);
		}else if(deviceinfo.kind === 'audiooutput'){
			audioOutput.appendChild(option);
		}else if(deviceinfo.kind === 'videoinput'){
			videoSource.appendChild(option);
		}
	})
}


//获取到这个流，这个流中包含音频轨和视频轨
function gotMediaStream(stream){
	videoplay.srcObject = stream;//把流给这个音频标签
	return navigator.mediaDevices.enumerateDevices();//返回这些设备的信息 兼容的重点
}

function handleError(err){
	console.log('getUserMedia error:', err);
}

if(!navigator.mediaDevices ||
	!navigator.mediaDevices.getUserMedia){
	console.log('getUserMedia is not supported!');
	return;
}else{
		var constraints = {
		video : true, 
		audio : true 
	}
	navigator.mediaDevices.getUserMedia(constraints)
		.then(gotMediaStream)//成功调用些方法
		.then(gotDevices)//获取流成功后串联操作，继续获取设备信息 兼容的重点
		.catch(handleError);//失败调用此方法
}





webrtc采集音视频参数的调整
视频参数调整：
width
heigh
4:3  320*240  640*480
16:9 1280*720
aspectRatio 宽高比例一般不用设
frameRate 帧率  帧率高码流会大，因为一秒钟采集的数据多了
facingMode 控制摄像头的
	user:前置摄像头对着自己拍
	environment：后置摄像头
	left：前置左摄像头
	right：前置右摄像头
resizeMode:采集的是否要裁剪


vi client.js

'use strict'
//devices
var audioSource = document.querySelector('select#audioSource');
var audioOutput = document.querySelector('select#audioOutput');
var videoSource = document.querySelector('select#videoSource');

var videoplay = document.querySelector('video#player');//获取到html中播放器的标签

//获取设备信息
function gotDevices(deviceInfos){

	deviceInfos.forEach(function(deviceinfo){//拿到设备信息

		var option = document.createElement('option');
		option.text = deviceinfo.label;
		option.value = deviceinfo.deviceId;
	
		if(deviceinfo.kind === 'audioinput'){
			audioSource.appendChild(option);
		}else if(deviceinfo.kind === 'audiooutput'){
			audioOutput.appendChild(option);
		}else if(deviceinfo.kind === 'videoinput'){
			videoSource.appendChild(option);
		}
	})
}


//获取到这个流，这个流中包含音频轨和视频轨
function gotMediaStream(stream){
	videoplay.srcObject = stream;//把流给这个音频标签
	return navigator.mediaDevices.enumerateDevices();//返回这些设备的信息 兼容的重点
}

function handleError(err){
	console.log('getUserMedia error:', err);
}

if(!navigator.mediaDevices ||
	!navigator.mediaDevices.getUserMedia){
	console.log('getUserMedia is not supported!');
	return;
}else{
		var constraints = {  //参数设置重点
			video : {
				width: 640,	
				height: 480,
				frameRate:15,
				facingMode: 'enviroment',
				deviceId : deviceId ? {exact:deviceId} : undefined 
			}, 
			audio : false 
		}
	navigator.mediaDevices.getUserMedia(constraints)
		.then(gotMediaStream)//成功调用些方法
		.then(gotDevices)//获取流成功后串联操作，继续获取设备信息 兼容的重点
		.catch(handleError);//失败调用此方法
}





音频参数调整：
volume 音量
sampleRate 采样率   48000 32000  16000 8000
sampleSize 采样大小，每一个的采样用多少位表示，一般是16两个字节
echoCancellation 是否要开启回音消除
autoGainControl 是否要增量，为录音增加音效
noiseSuppression 是否要降噪功能
latency 延时，网络通信时候的廷时，延时小，网络不好就会卡 ，设得大声音画面平滑，但是会廷时
channel 音声道 双声道  音乐用双
deviceID 设备的切换如前置切到后置
groupID 音频的输入输出 同一设备
function start() {//改造成一个函数
        var deviceId = videoSource.value; 
		var constraints = {
			video : {
				width: 640,	
				height: 480,
				frameRate:15,
				facingMode: 'enviroment',
				deviceId : deviceId ? {exact:deviceId} : undefined //设备id存在，就设置一下
			}, 
			audio : {
				noiseSuppression: true,	
				echoCancellation: true,
			} ,
			
		}
		//换了设备id后再重新采集数据
		navigator.mediaDevices.getUserMedia(constraints)
		.then(gotMediaStream)//成功调用些方法
		.then(gotDevices)//获取流成功后串联操作，继续获取设备信息 兼容的重点
		.catch(handleError);//失败调用此方法
}

start();
videoSource.onchange = start;//选设备的时候重新调一下start函数，在里面换设备




视频特效：
web中使用特效用的是：
css filter
-webkit-filter firefox 苹果 google
filter ie浏览器

如何将video和filter关联在一起

opengl/metal/..  底层最终用是这个


特效：
grayscale   灰度
spepia      褐色
saturate    饱和度
hue-rotate  色相旋转
invert      反色
opacity     透明度
brightness  亮度
contrast    对比度
blur        模糊
drop-shadow  阴影

vi index.html
	<head>
		<title>WebRTC capture video and audio</title>

		<link rel="stylesheet" href="css/main.css"/>

		<style>
			.none {
				-webkit-filter: none;	
			}

			.blur {
				-webkit-filter: blur(3px);	
			}

			.grayscale {
				-webkit-filter: grayscale(1); 	
			}

			.invert {
				-webkit-filter: invert(1);	
			}

			.sepia {
				-webkit-filter: sepia(1);
			}

		</style>
	</head>
	
		<div>
			<label>Filter:</label>
			<select id="filter">
				<option value="none">None</option>
				<option value="blur">blur</option>
				<option value="grayscale">Grayscale</option>
				<option value="invert">Invert</option>
				<option value="sepia">sepia</option>
			</select>
		</div>




vi client.js

//filter
var filtersSelect = document.querySelector('select#filter');

filtersSelect.onchange = function(){
	videoplay.className = filtersSelect.value;
}




从视频中获取图像

vi index.html

		<div>
			<button id="snapshot">Take snapshot</button>
		</div>
		<div>
			<canvas id="picture"></canvas>
		</div>

		
vi client.js

//picture
var snapshot = document.querySelector('button#snapshot');
var picture = document.querySelector('canvas#picture');
picture.width = 640;
picture.height = 480;

snapshot.onclick = function() {
    //对这张图片设置滤镜
	picture.className = filtersSelect.value;
	//二维的图像上下文，drawImage方法画图片
	picture.getContext('2d').drawImage(videoplay, 0, 0, picture.width, picture.height);
}



webrtc 采集音频数据

audio标签中采集音频数据 而不用video标签

vi index.html
<audio autoplay controls id='audioplayer'></audio> //controls将播放按钮显示出来

vi client.js
var audioplay = document.querySelector('audio#audioplayer');

		var constraints = {
			video : false, 
			audio : true 
		}

function gotMediaStream(stream){
	audioplay.srcObject = stream;
	return navigator.mediaDevices.enumerateDevices();
}





MediaStreamAPI获取视频约束

MediaStream.addTrack()   //添加轨到流
MediaStream.removeTrack() //移除轨
MediaStream.getVideoTrack() //得到视频轨
MediaStream.getAudioTrack()  //得到音频轨

触发的事件：
MediaStream.oneaddTrack() //添加轨到流时触发
MediaStream.onremoveTrack()//移除轨触发
MediaStream.onended()//流结束的时候


获取视频的约束来使用上面api

vi index.html
		<table>
			<tr>
				<td><video autoplay playsinline id="player"></video></td>
				<td><div id='constraints' class='output'></div></td>
			</tr>
		</table>
		
vi client.js

//div
var divConstraints = document.querySelector('div#constraints');
function gotMediaStream(stream){

	var videoTrack = stream.getVideoTracks()[0];//获取到视频的tracks 只有一个视频track
	var videoConstraints = videoTrack.getSettings();//得到video的所有约束
	
	divConstraints.textContent = JSON.stringify(videoConstraints, null, 2);//videoConstraints转成json格式


	//audioplay.srcObject = stream;
	return navigator.mediaDevices.enumerateDevices();
}




基础概念   webrtc录制基本知识

gotMediaStream(stream) 获取了时时音视频流数据
如何通过webrtc保存时时数据，即录制这些数据
 
获取 MediaRecoder
var mediaRecorder = new MediaRecorder(stream,[options])
stream:包括 video audio canvas
options:限制选项
	mimeType :录制什么流以及录制的格式
		 video/webm
		 audio/mp4
		 video/webm;codecs=vp8//编码格式
		 video/webm;codecs=h264//编码格式
		 audio/webm;codecs=opus//编码格式 只有音频的webm支持opus
	audioBitsPerSecond 音频码率
	videoBitsPerSecond 视频码率
	bitsPerSecond     整体码率


 MediaRecoder api
  MediaRecoder.start(timeslice)
  开始录制媒体，timeslice是可选的，如果没选，则所有录制放一个buff中，如果选了，则会不同的时间段把数据放不同buff中
  MediaRecoder.stop
  停止录制的时候，会触发dataavailable事件，存储最终blob数据
  MediaRecode.pause //暂停录制
  MediaRecoder.resume()  //开始录制
  MediaRecoder.isTypeSupported()  //是否支持的录制格式
  
数据传过来会有这个事件，这事件中的data是录制到的数据  
MediaRecoder.ondataavailable
如果没设时间片，则会把整个数据完成时调用该方法，设了时间片则定期触发该方法

MediaRecoder.onerror 错误时会调用


javascript几种数据存储方式
字符串
blob 是一个特殊的存储区域，可把不同对象存储到这里最后写到文件中
底层是无类型的一个缓冲区
ArrayBuffer  blob是依赖于它的封装
ArrayBufferView 各种类型的buffer


vi index.html

		<table>
			<tr>
				<td><video autoplay playsinline id="player"></video></td>
				<td><video playsinline id="recplayer"></video></td>
				<td><div id='constraints' class='output'></div></td>
			</tr>
			<tr>
				<td><button id="record">Start Record</button></td>
				<td><button id="recplay" disabled>Play</button></td>
				<td><button id="download" disabled>Download</button></td>
			</tr>
		</table>
		
	
vi client.js

//record
var recvideo = document.querySelector('video#recplayer');
var btnRecord = document.querySelector('button#record');
var btnPlay = document.querySelector('button#recplay');
var btnDownload = document.querySelector('button#download');

var buffer;
var mediaRecorder;

function gotMediaStream(stream){
	window.stream = stream;//window是全局对象，保存这个stream
}
function startRecord(){
	
	buffer = [];//创建存储数据的buffer
    //录制时的设置
	var options = {
		mimeType: 'video/webm;codecs=vp8'
	}
    //如果不是支持的录制类型return
	if(!MediaRecorder.isTypeSupported(options.mimeType)){
		console.error(`${options.mimeType} is not supported!`);
		return;	
	}

	try{
		mediaRecorder = new MediaRecorder(window.stream, options);
	}catch(e){
		console.error('Failed to create MediaRecorder:', e);
		return;	
	}

	mediaRecorder.ondataavailable = handleDataAvailable;//存储数据的回调
	mediaRecorder.start(10);//每隔时秒存一次

}
function handleDataAvailable(e){
	if(e && e.data && e.data.size > 0){
	 	buffer.push(e.data);//把数据存到buffer中			
	}
}

function stopRecord(){
	mediaRecorder.stop();
}
//录制按钮
btnRecord.onclick = ()=>{

	if(btnRecord.textContent === 'Start Record'){
		startRecord();	
		btnRecord.textContent = 'Stop Record';
		btnPlay.disabled = true;
		btnDownload.disabled = true;
	}else{
	
		stopRecord();
		btnRecord.textContent = 'Start Record';
		btnPlay.disabled = false;
		btnDownload.disabled = false;

	}
}
//播放录制的视频
btnPlay.onclick = ()=> {
	var blob = new Blob(buffer, {type: 'video/webm'});//存储的数据类型
	recvideo.src = window.URL.createObjectURL(blob);//播放的地址
	recvideo.srcObject = null;
	recvideo.controls = true;//显示播放的按钮
	recvideo.play();//播放
}
//下载录制的视频
btnDownload.onclick = ()=> {
	var blob = new Blob(buffer, {type: 'video/webm'});
	var url = window.URL.createObjectURL(blob);
	var a = document.createElement('a');//创建a标签

	a.href = url;//下载地址
	a.style.display = 'none';
	a.download = 'aaa.webm';//下载的文件名
	a.click();
}




webrtc录屏
getDisplayMedia

var promise = navigator.mediaDevices.getDisplayMedia(constraints);
constraints可选
constraints中约束与getUserMedia函数中一致

这个功能只有在最新的chrome中才有
输入：chrome://flags/#enable-experimental-web-platform-features
找到Experimental Web Platform features  将它打开
重新启动


//把所有的getUserMedia换成getDisplayMedia
vi client.js
if(!navigator.mediaDevices ||
		!navigator.mediaDevices.getDisplayMedia){

		console.log('getUserMedia is not supported!');
		return;

	}else{

		var deviceId = videoSource.value; 
		var constraints = {
			video : {
				width: 640,	
				height: 480,
				frameRate:15,
				facingMode: 'enviroment',
				deviceId : deviceId ? {exact:deviceId} : undefined 
			}, 
			audio : false 
		}

		navigator.mediaDevices.getDisplayMedia(constraints)
			.then(gotMediaStream)
			.then(gotDevices)
			.catch(handleError);
	}






webrtc信令服务器原理

两个客户端通信，一般是以p2p方式，就是客户端与客户端直接连接
如果两客户端不在一个网络类，需要打洞后连接p2p，对称的是打通不了的
非对称的可尝试打通，如果打通不了只能通过服务进行中转

两个客户端连接前，需要交换信息，交换信息分两方面：
1：客户端所处的网络类的相关信息，通过信令服务器传给另一端，以判断是否支持p2p
2:解码器支持哪种，视频支持哪种格式，都需要信令服务器
3：具体业务，进入房间，离开房间等

为什么要使用socket.io

传输音视频分tcp,udp，udp主要用于流媒体的传输，文本，文字聊天，问题在于不可靠传输
信令传输一般用tcp，需要安全可靠
socket.io是websocket超集，底层是tcp，所以socket.io作为信令服务器是挺好的

socket.io有房间的概念，必须在一个房间里

官方： 房间服务器 信令服务器  流传输中转

socket.io跨平台，跨语言


实现：
在node.js 服务器上增加socket.io，它是一个库

客户端： socket.io clien lib 库来连接服务端 ，连接好以后创建房间，加入房间就可以通信了

多个服务器的socket.io可以互相通信


使用socket.io发消息
给本次连接发消息,问连接是否连上，连接回答连上了
socket.emit()

给整个加入socket.io中的某个房间类所有人发消息
io.in(room).emit()  io表示整个socket.io节点

除本人外，给房间内的所有人发消息，如全体禁音
socket.to(room).emit()

除本人外，给所有人发消息，所有房间的人
socket.broadcast.emit()


socket.io客户端处理消息
服务端：socket.emit('action');
客户端：socket.on('action',function(){})

服务端: socket.emit('action',data);
客户端：socket.on('action',function(data){})

服务端：socket.emit('action',arg1,arg2);
客户端：socket.on('action',function(arg1,arg2){})


服务端: socket.emit('action',data,function(arg1,arg2){});
客户端：socket.on('action',function(data,fn){fn('a','b')})



webrtc信令服务器的实现

安装socket.io
npm install socket.io log4js
代码引入socket.io
处理connection消息

vi server.js
//socket.io 引入
var socketIo = require('socket.io');




//bind socket.io with https_server，此时443端口又可响应web服务，也可响应socketio服务
var io = socketIo.listen(https_server);//socket.io节点

//临听连接，socket代表每一个客户端
io.sockets.on('connection', (socket)=>{

	socket.on('message', (room, data)=>{
		socket.to(room).emit('message', room, data)//房间内所有人,除自己外
	});

	//该函数应该加锁，收到要加入房间的时候
	socket.on('join', (room)=> {

		socket.join(room);//加入房间，没有房间则创建房间

		var myRoom = io.sockets.adapter.rooms[room];//获取到自己的房间
		var users = Object.keys(myRoom.sockets).length;//myRoom.sockets所有房间用户   users用户人数

		logger.log('the number of user in room is: ' + users);

		//在这里可以控制进入房间的人数,现在一个房间最多 2个人
		//为了便于客户端控制，如果是多人的话，应该将目前房间里
		//人的个数当做数据下发下去。
		if(users < 3) {
			socket.emit('joined', room, socket.id);	//加入成功，并返回用户id
			if (users > 1) {
				socket.to(room).emit('otherjoin', room);//除自己之外其它人回
			}
		}else {
			socket.leave(room);
			socket.emit('full', room, socket.id);	
		}
	 	//socket.to(room).emit('joined', room, socket.id);//除自己之外
		//io.in(room).emit('joined', room, socket.id)//房间内所有人
	 	//socket.broadcast.emit('joined', room, socket.id);//除自己，全部站点	
	});
	socket.on('leave', (room)=> {
		var myRoom = io.sockets.adapter.rooms[room];
		var users = Object.keys(myRoom.sockets).length;
		//users - 1;

		logger.log('the number of user in room is: ' + (users-1));

		socket.leave(room);
		socket.to(room).emit('bye', room, socket.id)//房间内所有人,除自己外
	 	socket.emit('leaved', room, socket.id);	
	 	//socket.to(room).emit('joined', room, socket.id);//除自己之外
		//io.in(room).emit('joined', room, socket.id)//房间内所有人
	 	//socket.broadcast.emit('joined', room, socket.id);//除自己，全部站点	
	});

});


//引入打印日志包
var log4js = require('log4js');
//定义日志对象
var logger = log4js.getLogger();
//日志的配置

log4js.configure({
    appenders: {
        file: {
            type: 'file',
            filename: 'app.log',
            layout: {
                type: 'pattern',
                pattern: '%r %p - %m',
            }
        }
    },
    categories: {
       default: {
          appenders: ['file'],
          level: 'debug'
       }
    }
});



配置好以后 ：forever stop server.js

node server.js
forver start server.js





客户端利用socket.io实现简单聊天室
//vi 08 client.js
'use strict'

//
var userName = document.querySelector('input#username');
var inputRoom = document.querySelector('input#room');
var btnConnect = document.querySelector('button#connect');
var btnLeave = document.querySelector('button#leave');
var outputArea = document.querySelector('textarea#output');
var inputArea = document.querySelector('textarea#input');
var btnSend = document.querySelector('button#send');

var socket;
var room;

btnConnect.onclick = ()=>{

	//connect成功
	socket = io.connect(); 
	
	//recieve message  加入房间
	socket.on('joined', (room, id) => {
		btnConnect.disabled = true;
		btnLeave.disabled = false;
		inputArea.disabled = false;
		btnSend.disabled = false;
	});	
	//离开房间
	socket.on('leaved', (room, id) => {
		btnConnect.disabled = false;
		btnLeave.disabled = true;
		inputArea.disabled = true;
		btnSend.disabled = true;

		socket.disconnect();
	});	
    //收到消息
	socket.on('message', (room, id, data) => {
		outputArea.scrollTop = outputArea.scrollHeight;//窗口总是显示最后的内容
		outputArea.value = outputArea.value + data + '\r';//内容放到outputArea
	});	

	socket.on('disconnect', (socket)=>{
		btnConnect.disabled = false;
		btnLeave.disabled = true;
		inputArea.disabled = true;
		btnSend.disabled = true;
	});

	//send message 已经加入房间
	room = inputRoom.value;
	socket.emit('join', room);
}

btnSend.onclick = ()=>{
	var data = inputArea.value;//拿到输入的值
	data = userName.value + ':' + data;//用户的名字和用户的内容连一起
	socket.emit('message', room, data);//发送消息
	inputArea.value = '';//发送完把窗口内容清空
}

btnLeave.onclick = ()=>{
	room = inputRoom.value;
	socket.emit('leave', room);
}

inputArea.onkeypress = (event)=> {
    //event = event || window.event;
    if (event.keyCode == 13) { //回车发送消息
	var data = inputArea.value;
	data = userName.value + ':' + data;
	socket.emit('message', room, data);
	inputArea.value = '';
	event.preventDefault();//阻止默认行为
    }
}



vi index.html
<html>
	<head>
		<title>Chat Room</title>
		<link rel="stylesheet" href="./css/main.css"></link>
	</head>
	<body>
		<table align="center">
			<tr>
				<td>
					<label>UserName: </label>
					<input type=text id="username"></input>
				</td>
			</tr>
			<tr>
				<td>
					<label>room: </label>
					<input type=text id="room"></input>
					<button id="connect">Conect</button>
					<button id="leave" disabled>Leave</button>
				</td>
			</tr>
			<tr>
				<td>
					<label>Content: </label><br>
					<textarea disabled style="line-height: 1.5;" id="output" rows="10" cols="100"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<label>Input: </label><br>
					<textarea disabled id="input" rows="3" cols="100"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<button id="send">Send</button>
				</td>
			</tr>
		</table>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.3/socket.io.js"></script>//引入库
		<script src="./js/client.js"></script>//引入socket.io客户端代码
	</body>

</html>




webrtc网络传输基本知识

nat ：网络地址转换 把内网地址转成公网地址

网络上一台主机访问我的电脑，首先我的电脑是内网地址，通过路由器网关的nat映射，把我的主机映射成一个外网地址加端口，这样就能和我的电脑直接访问了


stun：p2p穿越，将两台传输的地址进行交换，这样交换后才能互相传输

turn：当stun的p2p穿越不成功，在云端架设流媒体服务器，让数据通过这个服务器转发

ice；把stun,turn打包作成组合，选一条更好的传输方式，turn不通就换节点。

nat:  将同一局域网类主机ip映射成同一公网ip，每一个端口代表一台局域网主机
      产生是因为ipv4资源不够，出于安全网络原因，因为要攻击内网主机，必须经过nat转换，防火墙，然后还要网关过滤
      
      
nat类型：
完全锥型：映身成外网ip加端口号，全网都可访问它
地址限制型： 局域内主机向一台外网ip发信息并记录了ip，所以只有我发过ip信息的那些机器才能访问我
端口限制型： 局域内主机向一台外网ip和端口发信息并记录了ip和端口，，所以只有我发过ip信息的那些机器的记录的端口才能访问我
对称型nat：局域网内的主机每向不同的外网ip发信息，都net映射成不同的ip和不同的端口，由于有多个ip，所以外部要访问这台主机更困难


nat打洞穿越原理：
完全锥型：局域网向外网某一主机发信息，打洞成一个公网ip加端口号，如果其它公网主机知道它的ip和端口都能对它访问
地址限制型： 局域内主机向一台外网ip发信息，net服务器或防火墙并记录了ip映身表，所以只有我发过ip信息的那些机器才能访问我
端口限制型： 局域内主机向一台外网ip和端口发信息，net服务器或防火墙并记录了记录了ip和端口，，所以只有我发过ip信息的那些机器的记录的端口才能访问我
对称型nat：局域网内的主机每向不同的外网ip发信息，都net映射成不同的ip和不同的端口，由于有多个ip，所以外部要访问这台主机更困难


c1与c2发送消息前，要向stun服务发送消息，互相交换网络信息公网ip和端口
交换后判断是否能打通

对称型nat如果要打通需要端口猜测


哪些不能打通，主要看防火墙：
端口受限型 和 对称型
对称型 和 对称型


net类型检测：客户端多次向另一端发信息，
需要搭建stun服务器，这个服务器有两个ip地址和两个端口
客户端发送：req 请示  服务端收到消息请求后：通过客户端给的ip和端口回一条消息
客户端接收消息：如果发的消息未回，则不通，不用再打洞 是对称的
             如果收到消息回复，判断公网返回的服务器ip地址是否是和我发送的ip地址相同，如相同，则说明一个公网ip地址可和我通讯
             不一致比如ip一致，端口号不一致，再发一个消息，如果对方用ip一致端口号不一致回复的消息我们收到了，那说明没作端口限制
             再发送一个消息，服务端更换另一个ip地址回复消息，如果客户端收到，说明客户端映射的ip地址能支持多个公网ip主机通讯
             
             
stun协议：
  stun协议就是net穿越
  典型客户端服务器模型
规范有两种：
rfc3489/stun 简单的通过udp进行穿越，失败率高，现有的路由器好多限制udp穿越
rfc5389/stun 一系列穿越net的工具，如udp tcp

stun消息头20字节
   2个字节16位 消息类型 
	   前2位是00，区分复用同一个端口是不是stun协议
	   2位用于分类，即c0和c1 c0:请求和指示  c1:成功应答和错误应答
	   12位用于不同请求的定义，如1代表绑定  2代表私有数据 
		   c1c2举例：0b意思是二进制
		      0b00:表示一个请求 
		      0b01:表示一个指示
		      0b10:表示请求成功响应
		      0b11:表示请求失败响应
		      
	      12位的请求定义与2位c1c2结合：
	          0x0001:00表示请求  01表示绑定   含义：绑定请求
	          0x0002:00表示请求  02表示私密   含义：私密请求
	          rfc5389已经把私密给去掉了，通过body属性去控制
	          
	      大端模式： 数据的高字节保存在低地址中，如123，高字节是100，存放在最低端的地址
	      小端模式： 数据的高字节保存在高地址中
	      网络字节续：网络传输采用大端排序方式，先传100 再传20 再传3  网络字节续都先发送高字节
	        
   2个字节是消息体长度，为包括消息头长度
   
   transaction id:16字节的事物id，请求与响应事物的id相同
          前4字节，固定值0x2112a442,是这个值就说明是rac5389,不是这个值那就是rac3489,如果是5389就可以识别一些新的规范
          12字节，标识同一个事件的请求和响应
   
   
   
stun消息体：包括多个属性
   每个属性使用的tlv动态编码:type(16位) length(16位) value
   0x0001  MAPPED-ADDRESS 标识了客户端反向传输地址（映射后的地址），这个属性只用于服务器向后兼容RFC3489的客户端。服务端发送的
   0x0002  RESPONSE-ADDRESS  对指明对于RESPONSE-ADDRESS 响应由哪里发出
   0x0003  CHANGE-REQUEST    请求服务端使用不同ip地址和端口号发送请求
   0x0004  SOURCE-ADDRESS    指定服务器ip地址和端口号 服务端必须发送
   0x0005  CHANGED-ADDRESS   它是CHANGE-REQUEST请求的响应   服务端必须发送
   0x0006  USERNAME			 用于安全验证
   0x0007  PASSWORD          用于安全验证
   0x0008  MESSAGE-INTEGRITY  消息完整性验证
   0x0009  ERROR-CODE         错误码
   0x000a  UNKNOWN-ATTRIBUTES  未知属性
   0x000b  REFLECTED-FROM     拒约




turn 协议：
解决对称nat无法穿越的问题
搭设一个turn协议的服务器实现转发网络信息，协议是建立在stun上的，很相似
turn 客户端需要服务端分配一个公网ip和端口号用于接收和发送数据

发送过程：c代表客户端 s代表服务端
c（10.1.1.2:49721） nat后（192.0.3.1:7000） 发（allocate）消息给  s(192.0.2.15:3487)
s(192.0.2.15:3487)开壁另一个端口，3487是用于和c连接的，50000是用于消息中传的 开壁后变为s(192.0.2.15:50000)
s(192.0.2.15:50000)中转消息发给peerb(客户端192.0.2.210:49191)
peerb(客户端192.0.2.210:49191)通过中转发消息给s(192.0.2.15:50000)，s(192.0.2.15:50000)再转成s(192.0.2.15:3487)发
消息给c（10.1.1.2:49721）


c与s互通后,turn协议打通，c就可以与peer发数据了，但发送前还需要信令服务器知道对方，这样就可以发数据了
s会有一个refresh request相当于心跳，确认客户端是否还在

server到peer都是使用的udp协议
c到server可用udp也可用tcp

turn send and  data
send 客户端发送
data 服务端发送
缺点：每次都会带30字节trun 头

turn channel 
规定一个channelid，在这个管道里不用每次发送头
1：c发送一个绑定请求给s
2：s创建一个channel管道成功
3：c和s就可以互发数据了，这时可以用send ,channel,data混发数据

turn 使用
1：c首先要绑定打通，拿到服务器的端口和ip地址
2：c调用allocation,让server开辟一个服务接收数据的中转ip地址和端口
3: c通过信令，发送媒体信息和网络信息给被调用者
4：s调用allocation,要c开辟接收对方的数据，s发送应答成功的信息
5：交换ip地址端口
6：检查p2p的连接
7：连接不成功，就开通中转发送数据


ice框架
ice是合理选择两台机器传输通路，如果p2p通则直接选stun通路传输，如果不通选turn
1。ice把两台机器所有可能的通路都进行收集
2。收集的通路发给两台机器
3。两台机器跟据这些通路11尝试
4。都不通最后就通过turn进行中转发送


ice candidate
每个 candidate包含一个地址和端口，是非中转的通路

拿到通路通过信令服务器sdt进行交换流媒体信息和网络通路
candidate（后选者 ，通路）:
   udp  192.168.1.2  port  是本机地址还是nat后地址（都会包括协议 端口 ip 地址 和它类型本机还是映射ip）

candidate类型：
主机候选者类型  局域网内通讯
反射候选者类型  外网net映射通讯和turn
中继候选者类型  云turn中转通讯


ice具体的事情：
收集candidate后选者
排序candidate
连通性测试：对每个candidate的检测，发送一个请求，如果回复就连接成功


sdp 是一种信息格式的描述标准，本身不属于传输协议，
但可以被其它传输协议用来交换必要的信息，是一种信令服务

v 版本
0 归谁所有
c 代表连接
m 媒体信息  使用的协议
a=candidate  检测到的通路


双方收到candidate通过信令传给对方



tcpdump 与wireshark 网络协议分析工具
tcpdump在linux上工作，对用户要求高，因为是二进制结果
wireshark 有界面的系统都可安装，对用户要求低
tcpdump命令：
tcpdump -i eth0 src port 80 -xx -Xs 0 -w test.cap



端对端1v1传输基本流程

RTCPeerConnection：内部作了媒体协商 轨道处理 接收与发送 

pc = new RTCPeerConnection([configuration])

RTCPeerConnection方法分类：
媒体协商：拿到双方媒体信息，交换信息，协商编码音视频格式 有四个方法
    a创建一个offer，形成一个sdp(包含媒体信息，编解码传输信息) 
    调用setLocalDescription收集传输的后选者
    通过信令传给b
    b通过setRemoteDescription把sdp数据放到远端存储
    b创建一个answer方法，answer方法是获取自己的offer包含媒体信息，编解码传输信息)，发给a
    b调用setLocalDescription收集传输的后选者
    a收到answer后通过setRemoteDescription把sdp数据放到远端存储
    
    通过协商主要是交换了sdp以及后选择，然后选择最好的一种方式
    
    协商状态： offer(编解码媒体信息)  answer(对方的编解码媒体信息)  stable状态表示所有都准备好了
       a创建了offer，通过setlocal(offer)后变为have-local-offer(有本地的offer)
       a收到offer,通过setRemote(offer)后变为have-remote-offer(有远程的offer )
       a收到answer,通过setRemote(answer)后变成stable状态
       a设置通过setlocal(answer)也变成stable状态
       其它情况：
           pranswer：提前应答，指被调用者还没有数据的时候可以创建一个临时的answer，它没有音视频流
           作用就是提前建立链路连接，这时就产生了have-remote-answer状态，指链路已经提前链接但还没有数据
           
    媒体协商的方法：
    createOffer:A端创建offer
        aPromise=myPeerConnection.createOffer([options])
    createAnswer:b端收到offer后创建answer
        aPromise=myPeerConnection.createAnswer([options])
    setLocalDescription:A端把本地的sdp描述信息设置完成后去触发收集后选者（两个动作）
        aPromise=myPC.setLocalDescription([options])
    setRemoteDescription:收到sdp信息后设置到远程存储
        aPromise=myPC.setRemoteDescription([options])
    
    
    
流/track轨：
    addTrack:
       rtpSender = myPc.addTrack(track,stream...);
    removeTrack:
       myPC.removeTrack(rtpSender)
       
    重要事件：
       onnegotiationneeded：媒体协商触发，需要协商
       onicecandidate:收到ice后选者，会解发这个事件
       
传输相关协议rtp：查看传输链路质量
统计相关方法：编解码器 传输链路信息获取


10--3端到端连接的基本流程：有一幅图，多看几遍了解流程

本机内的1：1音视频互通
实战webrtc音视频传输
  
sdp类似json格式之类的，可以被其它传输协议传输，它里面是包含了
媒体信息



index.html

<html>
	<head>
		<title>WebRTC PeerConnection</title>
		<link href="./css/main.css" rel="stylesheet" />
	</head>

	<body>
		<div>


			<div>
				<button id="start">Start</button>	//开始采集视频按钮
				<button id="call" disabled>Call</button>//	连接另一端显示视频
				<button id="hangup" disabled>HangUp</button>//关闭连接	
			</div>

			<div id="preview">
				<div >
					<h2>Local:</h2>
					<video id="localvideo" autoplay playsinline></video>//本地显示的视频进行播放
					<h2>Local SDP:</h2>
					<textarea id="offer"></textarea>//显示sdp内容：本地采集的视频的sdp，支持的媒体格式
				</div>
				<div>
					<h2>Remote:</h2>
					<video id="remotevideo" autoplay playsinline></video>//远端显示的视频进行播放
					<h2>Remote SDP:</h2>
					<textarea id="answer"></textarea>//显示sdp内容：远端的sdp支持的格式
				</div>
			</div>
		</div>

		<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>//浏览器兼容
		<script src="js/main.js"></script>//连接webrtc的js
	</body>
</html>





main.js


'use strict'  //最严格的js语法

//获取各个控件
var localVideo = document.querySelector('video#localvideo');
var remoteVideo = document.querySelector('video#remotevideo');

var btnStart = document.querySelector('button#start');
var btnCall = document.querySelector('button#call');
var btnHangup = document.querySelector('button#hangup');

var offerSdpTextarea = document.querySelector('textarea#offer');
var answerSdpTextarea = document.querySelector('textarea#answer');
//本地流
var localStream;
//连接端1，21
var pc1;
var pc2;
//得到本地采集的流
function getMediaStream(stream){
	localVideo.srcObject = stream;//把流交给本机端的vedio标签
	localStream = stream;
}

function handleError(err){
	console.error('Failed to get Media Stream!', err);
}
//开始采集
function start(){
    //判断是否兼容
	if(!navigator.mediaDevices ||
		!navigator.mediaDevices.getUserMedia){
		console.error('the getUserMedia is not supported!');
		return;
	}else {
	    //只采集视频
		var constraints = {
			video: true,
			audio: false
		}
		navigator.mediaDevices.getUserMedia(constraints)
					.then(getMediaStream)//采集到流时执行的方法
					.catch(handleError);

		btnStart.disabled = true;
		btnCall.disabled = false;
		btnHangup.disabled = true;
	}
}
//远端的video控件播放流
function getRemoteStream(e){
	remoteVideo.srcObject = e.streams[0];
}

function handleOfferError(err){
	console.error('Failed to create offer:', err);
}

function handleAnswerError(err){
	console.error('Failed to create answer:', err);
}
//pc2得到answer的回调
function getAnswer(desc){
	pc2.setLocalDescription(desc);//设置answer到本地，这里answer 包含的是媒体信息
	answerSdpTextarea.value = desc.sdp//显示pc2的sdp信息

	//send desc to signal
	//receive desc from signal
	
	pc1.setRemoteDescription(desc);//pc1设置answer到自己的远端
}

//获取到本地采集的offer
function getOffer(desc){
	pc1.setLocalDescription(desc);//把offer设置到本地
	offerSdpTextarea.value = desc.sdp//显示sdp内容到本地sdp控件上
     //由于没有信令服务器，这里省略两步代码
	//send desc to signal  发送offer到信令服务器
	//receive desc from signal  从offer接收信令服务器信息
	
	pc2.setRemoteDescription(desc);//pc2得到offer，并存入远端

	pc2.createAnswer()//pc2创建answer
		.then(getAnswer)
		.catch(handleAnswerError);

}
//连接远端
function call(){
	//创建两个端的连接
	pc1 = new RTCPeerConnection();
	pc2 = new RTCPeerConnection();
    //连接前的状态，捕扣到候选者，a的后选者被b添加
	pc1.onicecandidate = (e)=>{
		pc2.addIceCandidate(e.candidate);	
	}
    //同上
	pc2.onicecandidate = (e)=>{
		pc1.addIceCandidate(e.candidate);	
	}
    //被连接者的ontrack动作，会接收到传来的流进行播放
	pc2.ontrack = getRemoteStream;
    //遍列本地流中的各个轨，并把各个轨添加到流中
	localStream.getTracks().forEach((track)=>{
		pc1.addTrack(track, localStream);	
	});
    //offer只响应视频流
	var offerOptions = {
		offerToRecieveAudio: 0,
		offerToRecieveVideo: 1
	}
    //创建offer，offer中能拿到sdp
	pc1.createOffer(offerOptions)
		.then(getOffer)
		.catch(handleOfferError);

	btnCall.disabled = true;
	btnHangup.disabled = false;
}

function hangup(){
	pc1.close();
	pc2.close();
	pc1 = null;
	pc2 = null;

	btnCall.disabled = false;
	btnHangup.disabled = true;
}

btnStart.onclick = start;
btnCall.onclick = call;
btnHangup.onclick = hangup;
