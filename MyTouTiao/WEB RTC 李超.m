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

netstat -ntpl | grep 80 查看被占用的端口
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

传通的方式：
    局域网内：a主机通过掩码可算出判断目标b是否是同一局域网，如果是，直接把自己的ip,mac和b的ip,
		mac地址通过arp包发送给b，互相知道ip和mac地址后则可通讯
    外网：a主机通过掩码可算出判断目标b不是同一局域网，是不同网段，a把自己的ip,mac和b的ip，mac发给网关，
        网关通过路由发arp包一跳一跳的去广域网找目标主机b，给过多次路由找到b，最终发送数据，发送的数据是
        通过多个路由中转的
打洞方式：
    不同网段内两台主机直接映射出外网地址和端口号，这时通讯更明确，不需要路由经下一路由中转数据，而是直达数据
    

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
       onicecandidate:收到ice后选者，会触发这个事件
       
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


sdp协议规范，类似json,xml文件，只是不同于它存入的是媒体信息

会话层：会话层相当于全局的音视频信息设置
    会话的名称与目的
    会话存在的存活时间0为永远

媒体层：相当于局部的音视频信息设置，局部的可覆盖全局的设置
   多个媒体信息：
   媒体格式  音频视频
   传输协议  udp tcp
   传输ip和端口   如果用webrtc，这个影响不大，因为ip和端口是从ice服务器得到
   媒体负载类型    vp8 vp9 h.264

具体格式：
多个<type>=<value>组成
一个sdp包含一个会话层，一个会话层包含多个媒体信息

会话层具体描述：对与我们使用意义不大
   v=(具体版本)  必选
   o=(sessionid) 必选
   s=(session名称) 必选
   c=(连接ipv4,v6，网络连接session level 等连接信息)
   a=(全局设置0或更多的session属性)
   时间：
     t=(存活时间)
     r=(重复次数)
     
媒体层：
   m=(媒体名字和传输地址) 必选 m=<media audio><port><transport><fmtp/payload type list>//负载类型，可确定用什么解码器
   c=(传输相关信息)
   b=(带宽)
   a=(对m描述的一大堆属性，对m进行具体解释) a=framerate:<帧率>    a=rtpmap:修饰payload type 帧率，采样率



webrtc中的SDP规范  rtcp是控制网络反馈的，对网络质量都通过rtcp反馈 rcp协议包
会话元：和sdp规范一样的会话层
      v=(具体版本)  
      o=(sessionid session版本 in英特网  ip4 127.23.43.2) 
      s=-(session名乐)
      t=(起始时间 结束时间)
网络描述：单独对网络进行描述
      c=(连接ipv4,v6，网络连接session level 等连接信息)
      a=(对c属性进行具体描述) 
流描述：对流描述
      a=group:bundle 0 一组流进行绑定
      a=msid-sematic 一组媒体流id
      m=(video 9(端口号) udp/tls（加密）/rtp（上层）/savpf（加密） 96 99 98 （具体在a中作解释）)
      m以下都是媒体层，可用多个m
      c=in ip4 0.0.0.0
      a=(对m描述的一大堆属性，对m进行具体解释) a=fmtp a=rtpmap
      a=setup:actpass 媒体协商可自选为作服务端或客户端
      a=mid:0 这个0对应a=group:bundle 0 的0
      a=extmap:2 urn:ietf:param:rtp-hdrext:toffset  对媒体rtp头扩展
      a=sendrecv 发送和接收
      a=rtpmap:96 vp8/90000  rtc/90000 rtc表重传 ，如重传，它的type是98  red 允许发冗余包，包丢失可通过冗余包找到
      a=fmtp:99 apt=98 99和98关联
      a=ssrc: 每一种编码协议对应一种ssrc
安全描述：
      a=crypto 加密算法
      a=ice-options:trickle 先不收集链路，每收集一个链路再检测，增快效率
      a=ice-frag:ctqt a=ice-pwd 通过这两个对有效路径是否合法进行检测，是否非法用户
      a=fingerprint 指纹，对数据加密，验证证书是否有效

服务质量：
      整个网络的反馈 a=rtcp-fb  a=group 把多个音频流媒体流绑定在一起，可复用
      a=rtcpmux  rtp与rtcp端口复用同一个
      a=rtcp-rsize 控制rtcp包数据量
      a=rtcp-fb:96 goog-remb 接收端带宽评估
      a=rtcp-fb:98 transport-cc 支持transport-cc

      
      
      
      
webrtc中offer_answerSDP







12-1实战stun_turn服务器搭建  收集可用的链路和端口
rfc5766-turn-server google的
resturn是比较老的
coturn是升级，支持udp,tcp,ip4 ip6

coturn服务器搭建:

	下载coturn

	./configure --prefix=/usr/local/coturn 生成makefile

	编译安装： make && make install

具体：
打开github，下载coturn
./configure --prefix=/usr/local/coturn 指定编译后coturn安装地址
ls -atl Makefile 查看是否生成makefile
编译安装： make -j 8 
sudo make install

cd /usr/local/coturn 安装的文件都在下面
bin目录下有多个工具
etc下有配置文件
环境变量：
vi ~/bashrc   :为分隔符
$PATH:/usr/local/coturn/bin: 
启动：
turnserver -c ./etc/turn
turnserver -c ./etc/turnserver.conf
 
 
coturn的配置：
cd /usr/local/coturn/turnserver.conf
listening-port=3478
external-ip= 外网ip 
user=aaa:bbb 用户名和密码
realm=stun.xxx.cn  域名一定得写

ps -ef | grep turn查看是否启用


进入webrtc.github.io/samples
点：ice candidate gathering from sturn
添加自己的turn ip：turn:stun.al.learningrtc.cn:3478
在githup上添加自己的turn ip，点收集
relay表只收集中继服务器的


再论RTCPeerConnection

pc = new RTCPeerConnection([configuration])

RTCCofiguration:
    sequence<RTCIceServer> iceServer  //stun turn 多个服务，可获得反射地址和中继地址
    RTCIceTransportPolicy iceTransportPolicy="all"  //传输策略 all支持本机地址host relay中继地址
    RTCBundlePolicy  bundlePolicy="balanced"  //平衡策略
    RTCRtcpMuxPolicy  rtcpMuxPolicy ="require"  //复用策略
    DOMString   peerIdentity   //标识
    sequence<RTCCertificate>  certificates  //每一个可连通后选者都有一个证书，如果复用只会一个证书
    [EnforceRange]
    octet   iceCandidatePoolSize = 0 ;  //收集候选者池子的大小


bundlePolicy  
   balanced:所有音频轨使用一个通道，所有视频轨使用一个通道
   max-compat:每个轨都有自己的通道
   max-bundle:音视频都绑定到同一个传输通道
   
   
certificates  
    可能提供证书，可以不提供，则自己产生证书
   每一个可连通后选者都有一个证书，如果复用只会一个证书
   
iceCandidatePoolSize 
   16位整数指定候选者数量，如果值重新设置，则重收集候选者
   
iceTransportPolicy
   传输策略 all支持本机地址host relay中继地址
   
iceServer  
   stun turn 多个服务，可获得反射地址和中继地址
   credential  只有turn服务使用
   credentialtype 凭据类型可以是password或oauth
   urls   stun turn每一个都是一个url
   username
   
rtcpMuxPolicy  复用
   negotiate  收集rtcp与rtp复用的ice候选者，如果rtcp能复用就与rtp复用
              如果不能复用，它们就单独使用
   require    只能收集rtcp与rtp复用的ice候选者，如果rtcp不能复用，则失败
   
   
addIceCandidate
   aPromise = pc.addIceCandidate(candidate)
   
candidate
    candidate  候选者描述信息
    sdpMid     与候选者相关的媒体流的识别标签，代表每一路流，视频是0
    sdpMLineIndex  在sdp中m =的索引值  代表两路，引入视频是1 音频是2
    usernameFragment  包括了远端的唯一标识 ice-fragment就是这个标识
    


实战直播系统中加入信令服务器

   客户端信令消息：
       join  加入房间
       leave  离开房间
       message  发送端对端的消息，通过信令服务器转发
          offer 消息  获取到本机的媒体信息 是用sdp格式进行描述的
          answer 消息  收到offer后，也要发送answer,把本地媒体信息发给请求端
          candidate 消息  双方通信要知道彼此的通路ip端口，进行连通信检测，找出可用候选者
    
    服务端信令：
       joined消息  已经加入房间
       otherjoin   告诉别人另外一个人加入了
       full       告诉加入者房间已经满
       leaved     已离开房间
       bye        告诉其它客户端有一个已经离开
       
信令流程：              
	a b都与信令服务器建立连接 
	a 加入房间join  信令服务器回一个joined
	b 加入房间join  信令服务器回一个joined   
	信令服务器回一个 otherjoin给a告诉说b已经加入，这时候a和b就可以媒体协商了
	c 想加入房间，因为a,b一对一通话，所以信令服务器回一个full，告诉房间已满
	媒体协商：发送message消息offer  answer candidate
	b发送leave给信令服务器，信令服务器发送一个bye给a，告诉b离开了，信令服务器回一个leaved给b
   
   
实战，改造之前搭的socketio服务器，把多人聊天室改成1v1聊天室，打开server.js
var USERCOUNT = 3;

		if(users < USERCOUNT){
			socket.emit('joined', room, socket.id); //发给除自己之外的房间内的所有人
			if(users > 1){
				socket.to(room).emit('otherjoin', room, socket.id);//给其它人发
			}
		
		}else{
			socket.leave(room);	//房间以满提出房间
			socket.emit('full', room, socket.id);//告诉它房间已经满了
		}
  
	   
	socket.on('leave', (room)=>{
		var myRoom = io.sockets.adapter.rooms[room]; 
		var users = (myRoom)? Object.keys(myRoom.sockets).length : 0;
		logger.debug('the user number of room is: ' + (users-1));
		//socket.emit('leaved', room, socket.id);
		//socket.broadcast.emit('leaved', room, socket.id);
		socket.to(room).emit('bye', room, socket.id);//告诉其它人我离开了
		socket.emit('leaved', room, socket.id);//给自己发leaved
		//io.in(room).emit('leaved', room, socket.id);
	});
	
	
	socket.on('message', (room, data)=>{
		socket.to(room).emit('message',room, data);//给其它人转发消息
	});
	
	
	
	
再讨论CreateOffer
   aPromise=myPeerConnection.createOffer([options])

Options 可选
   iceRestart: 该选项会重启ice，重新进行candidate收集，比如wifi切成4g 或网络不好了，就重新选则路
   voiceActivityDetection: 是否开启静音检测，默认是开启的，当没有检测到人声的时候，可以不发送环境里的其它声音
   接收远端音频：
   接收远端视频：
   
   
实战testCreateOffer项目

index.html
   <html>
	<head>
		<title>
			test createOffer from different client
		</title>
	</head>

	<body>
		<button id="start">Start</button>
		<button id="restart">reStart ICE</button>
		<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
		<script src="js/main.js"></script>
	</body>
</html>
   

main.js

function getPc1Answer(desc){

	console.log('getPc1Answer', desc.sdp);
	pc2.setLocalDescription(desc);//pc2设置answer到自己本地
	pc1.setRemoteDescription(desc);//pc1接收到pc2的
}
function getPc1Offer(desc){

	console.log('getPc1Offer', desc.sdp);
	pc1.setLocalDescription(desc);
	pc2.setRemoteDescription(desc);//pc2设置到远端
	pc2.createAnswer().then(getPc1Answer).catch(handleError);//回一个answer

}

function getMediaStream(stream){

	stream.getTracks().forEach((track) => {
		pc1.addTrack(track, stream);	
	});
  
    
	var offerConstraints = {
		offerToReceiveAudio: 1,
		offerToRecieveVideo: 1,
		iceRestart:false   //不重启ice
	}

	pc1.createOffer(offerConstraints)
		.then(getPc1Offer)//拿到offer
		.catch(handleError);//创建offer

} 


执行代码：
可查看到offer以及answer中ice-ufrag的值发生了变化
ice-ufrag:80oi再点击后会发生变化，如果发生变化就说明icerestart重启了


客户端状态：
收到joined后会变成joined状态
收到otherjoin后会变成joined_conn
收到bye消息变成joined_unbind


客户端流程：
开始获取音视频
与信令服务器连接，并注册信令函数 
如果收到joined，创建并绑定媒体流
此时如果另一用房加入，是joined_unbind，即收到bye消息，则创建并绑定媒体流
如果不是joined_unbind，设置为joined_conn,开始媒体协商
如果收到full，设置状态为full,关闭pc,关闭本地媒体流
收到服务端leaved，关闭连接disconnect离开
发送leave到服务端，关闭pc，关闭流媒体
收到bye,变更为joined_unbind，关闭pc


sturn/turn 是服务器，电脑端可连接它得到可用的传输网络通道


实战客户端webrtc
连接信令服务器要在获得音视频媒体之后
当一端离开房间，另一端peerconnection也要关闭连接，保证干净
服务器都是异步处理的

打开12中peerconnection_onebyone
room.html: 
连接 离开按钮，远程本地video标签 信令服务器引用的脚本
       
				<button id="connserver">Connect Sig Server</button>

				<button id="leave" disabled>Leave</button>	
			<div >
					<h2>Local:</h2>
					<video id="localvideo" autoplay playsinline muted></video>
					<h2>Offer SDP:</h2>
					<textarea id="offer"></textarea>
				</div>
				<div>
					<h2>Remote:</h2>
					<video id="remotevideo" autoplay playsinline></video>
					<h2>Answer SDP:</h2>
					<textarea id="answer"></textarea>
				</div>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.3/socket.io.js"></script>

main.js
function connSignalServer(){
	
	//开启本地视频
	start();

	return true;
}
				

function getMediaStream(stream){

	conn();//连接信令服务器

}

function leave() {

	if(socket){
		socket.emit('leave', roomid); //notify server
	}

	hangup();
	closeLocalMedia();

	offer.value = '';
	answer.value = '';
	btnConn.disabled = false;
	btnLeave.disabled = true;
}
//获取到本地answer
function getAnswer(desc){
	pc.setLocalDescription(desc);//通知本地存放answer
	answer.value = desc.sdp;

	//send answer sdp
	sendMessage(roomid, desc);//发送给拔号端
}
function conn(){

	socket = io.connect();//与信令服务器建立连接
    //接收到回的joined响应
	socket.on('joined', (roomid, id) => {
		console.log('receive joined message!', roomid, id);
		state = 'joined'//改变状态

		//如果是多人的话，第一个人不该在这里创建peerConnection
		//都等到收到一个otherjoin时再创建
		//所以，在这个消息里应该带当前房间的用户数
		//
		//create conn and bind media track，我加入房间了，创建pc候选者连接，
		//并且监听如果收到远端对方流显示在屏幕上
		//并监听自己如果有候选者产生，发送给对方
		createPeerConnection();//媒体协商
		bindTracks();//创建完连接后一定要把本地采集的流中的轨添加到pc中

		btnConn.disabled = true;
		btnLeave.disabled = false;
		console.log('receive joined message, state=', state);
	});
    //接收到服务端返回的otherjoin
	socket.on('otherjoin', (roomid) => {
		console.log('receive joined message:', roomid, state);

		//如果是多人的话，每上来一个人都要创建一个新的 peerConnection
		//
		if(state === 'joined_unbind'){//如果我和其它另一个用户，另一个用户离开则是joined_unbind，那就是断开的，要重新连接
			createPeerConnection();//收到另一个用户离开，我自己需要重新连接，等待其它新用户加入
			bindTracks();
		}

		state = 'joined_conn';//otherjoin和joined_conn都表示第二个用户加入房间
		call();//当另一个用户加入，我创建offer，并发送offer给对方

		console.log('receive other_join message, state=', state);
	});
    //接收到服务端返回的full客间满员
	socket.on('full', (roomid, id) => {
		console.log('receive full message', roomid, id);
		hangup();//断掉没进入房间用户的连接 ，我想加入房间，房间满了，我会断掉自己的pc
		closeLocalMedia();//同时停止本地流中的轨
		state = 'leaved';//需要离开
		console.log('receive full message, state=', state);
		alert('the room is full!');
	});
    //接收到服务端返回自己离开消息
	socket.on('leaved', (roomid, id) => {
		console.log('receive leaved message', roomid, id);
		state='leaved'
		socket.disconnect();//我自己主动离开房间了，就把socket关闭掉
		console.log('receive leaved message, state=', state);

		btnConn.disabled = false;
		btnLeave.disabled = true;
	});
    //接收到服务端返回其它成员离开的消息
	socket.on('bye', (room, id) => {
		console.log('receive bye message', roomid, id);
		//state = 'created';
		//当是多人通话时，应该带上当前房间的用户数
		//如果当前房间用户不小于 2, 则不用修改状态
		//并且，关闭的应该是对应用户的peerconnection
		//在客户端应该维护一张peerconnection表，它是
		//一个key:value的格式，key=userid, value=peerconnection
		state = 'joined_unbind';//收到对方离开的状态
		hangup();//关闭pc连接
		offer.value = '';
		answer.value = '';
		console.log('receive bye message, state=', state);
	});

	socket.on('disconnect', (socket) => {
		console.log('receive disconnect message!', roomid);
		if(!(state === 'leaved')){//如果不是自己主动离开房间，都需要关掉pc，如果是自己主动离开，关掉socketio
			hangup();
			closeLocalMedia();

		}
		state = 'leaved';
	
	});
    //信令服务器发offer answer消息  当收到一端发过来offer，解发此函数
	socket.on('message', (roomid, data) => {
		console.log('receive message!', roomid, data);

		if(data === null || data === undefined){
			console.error('the message is invalid!');
			return;	
		}

		if(data.hasOwnProperty('type') && data.type === 'offer') {
			
			offer.value = data.sdp;
            //收到offer存到远端，创建answer
			pc.setRemoteDescription(new RTCSessionDescription(data));//把offer发到远端,RTCSessionDescriptionl(data)转换成对象

			//create answer成功，把answer保存到本地，再发送给我
			pc.createAnswer()
				.then(getAnswer)
				.catch(handleAnswerError);//创建answer

		}else if(data.hasOwnProperty('type') && data.type == 'answer'){//收到的是answer，发送到自己远端
			answer.value = data.sdp;
			pc.setRemoteDescription(new RTCSessionDescription(data));//设置到远端answer
		
		}else if (data.hasOwnProperty('type') && data.type === 'candidate'){//收到对方发来的candidate
			var candidate = new RTCIceCandidate({
				sdpMLineIndex: data.label,//媒体行号
				candidate: data.candidate
			});//生成candidate
			pc.addIceCandidate(candidate);//加入到本端	
		
		}else{
			console.log('the message is invalid!', data);
		
		}
	
	});


	roomid = getQueryVariable('room');
	socket.emit('join', roomid);//连接成功后发送一个自己加入房间的消息

	return true;
}
//turn sturn服务器的地址，很关键很关键
var pcConfig = {
  'iceServers': [{
    'urls': 'turn:stun.al.learningrtc.cn:3478',//turn stun地址
    'credential': "mypasswd",//密码
    'username': "garrylea"//用户名
  }]
};
//远端的视频数据
function getRemoteStream(e){
	remoteStream = e.streams[0];
	remoteVideo.srcObject = e.streams[0];//把获取到的视频参数给这标签
		//创建offer，会产生音频和视频的媒体流，包括一些媒体参数
	localStream.getTracks().forEach((track)=>{
		pc.addTrack(track, localStream);	
	});

}
//创建连接，临听候选者事件，通过信令，发到另一端，	
function createPeerConnection(){

	//如果是多人的话，在这里要创建一个新的连接.
	//新创建好的要放到一个map表中。
	//key=userid, value=peerconnection
	console.log('create RTCPeerConnection!');
	if(!pc){
		pc = new RTCPeerConnection(pcConfig);

		pc.onicecandidate = (e)=>{//监听到自己产生有候先者时

			if(e.candidate) {
				sendMessage(roomid, {//发消息给对端候选者
					type: 'candidate',
					label:event.candidate.sdpMLineIndex, 
					id:event.candidate.sdpMid, 
					candidate: event.candidate.candidate
				});
			}else{
				console.log('this is the end candidate');
			}
		}

		pc.ontrack = getRemoteStream;//收到ontrack即远端流后调用此函数
	}else {
		console.warning('the pc have be created!');
	}

	return;	
}

//绑定永远与 peerconnection在一起，
//所以没必要再单独做成一个函数
function bindTracks(){

	console.log('bind tracks into RTCPeerConnection!');

	if( pc === null || pc === undefined) {
		console.error('pc is null or undefined!');
		return;
	}

	if(localStream === null || localStream === undefined) {
		console.error('localstream is null or undefined!');
		return;
	}

	//add all track into peer connection 把本地的轨添加到pc中
	localStream.getTracks().forEach((track)=>{
		pc.addTrack(track, localStream);	
	});

}

function leave() {

	if(socket){
		socket.emit('leave', roomid); //notify server
	}

	hangup();
	closeLocalMedia();

	offer.value = '';
	answer.value = '';
	btnConn.disabled = false;
	btnLeave.disabled = true;
}

//关闭自己的媒体
function closeLocalMedia(){

	if(localStream && localStream.getTracks()){
		localStream.getTracks().forEach((track)=>{
			track.stop();
		});
	}
	localStream = null;
}

function sendMessage(roomid, data){

	console.log('send message to other end', roomid, data);
	if(!socket){
		console.log('socket is null');
	}
	socket.emit('message', roomid, data);//发送消息给房间
}
function getOffer(desc){
	pc.setLocalDescription(desc);//收及本端offer
	offer.value = desc.sdp;
	offerdesc = desc;

	//send offer sdp
	sendMessage(roomid, offerdesc);	//把offer发给房间中另一端,另一端临听通过socket.on('message')

}
//发起端才调用call
function call(){
	
	if(state === 'joined_conn'){//表示另外一个人也加入了房间，才能发起call

		var offerOptions = {//接收远端音视频
			offerToRecieveAudio: 1,
			offerToRecieveVideo: 1
		}
       //创建offer
		pc.createOffer(offerOptions)
			.then(getOffer)
			.catch(handleOfferError);
	}
}


举一反三，共享远程桌面  webrtc录屏,共享远程桌面
getDisplayMedia  无法采集音频的同时采集桌面，思考即能共享桌面声音和视频一起  同时是否要调整分辨率，以及共享区域

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
	
	

端与端的互通
rtp media

 RTCPeerConnection 底下一层rtp media涉及到数据传输的
 管理通路，流量，帧率等
 
 rtp media下面两个类
 receiver和sender（接收器和发送器）
 
getReceivers：  RTCPeerConnection 的getReceivers获取到一组RTCRtpReceiver对象，用于接收数据
  每一个媒体轨对应一个RTCRtpReceiver
getSender:用于发送数据，获取一组RTCRtpSender对象

RTCRtpSender和RTCRtpReceiver的属性：
MediaStreamTrack: 对应一个媒体轨，通过它知道是audio还是audio
RTCDtlsTransport: 通过Transport传输，如果是复用，则都用同一个Transport传输
RTCDtlsTransport: 描述rtcpTransport和rtcp传输相关的属性，收了多少，发了多少，抖动多少，根据这些降低流量控制

RTCRtpReceiver方法：
getParameters:获取编码器h.264 还是vp8,vp9，通道数等
getSynchronizationSources:共享了桌面，音频，视频，每一个都是共享源，不重复
getContributingSources:混音，三个人同时说话，混成一路，但有三个源
getStats:统计发了多少，流量多少
getCapabilities:	媒体支持哪些能力，支持哪些协商

RTCRtpSender方法：
getParameters:获取编码器h.264 还是vp8,vp9，通道数等
setParameters:设置编码器h.264 还是vp8,vp9，通道数等
getStats:统计发了多少，流量多少
replaceTrack:一个Track替换成另一个Track,摄像头替换
getCapabilities:	媒体支持哪些能力，及本机系统支持哪些


RTPMedia的结构体
第一层：
RTCRtpHeaderExtensionParameters:扩展头
  id  
  uri 
  encrypted(false)  加密
RTCRtcpParameters:第一个rtp都有一个rtcp与之对应
  cname 
  reduceSize  带宽不够保留基本消息
RTCRtpCodecParameter: 编解码相关
  playloadType  哪种编码
  mimeType  
  clockRate 
  channels  
  sdpFmtpLine
第二层：
RTCRtpParameters继承第一层:
  headerExtensions 
  codecs 
  rtcp
第三层：
RTCDegradationPreference:
  maintain-framerate  
  maintain-resolution 
  blanced
RTCRtpReceiveParameters继承RTCRtpParameters:
  encodings
RTCRtpSendParameters继承RTCRtpParameters和RTCDegradationPreference:（最关键的）
  transactionID   唯一标识
  encoding 
  degradationPreference   设置帧率和分bian率来降码流
  priority
第四层：
RTCRtpDecodingParameters继承RTCRtpReceiveParameters:
RTCRtpEncodingParameters继承RTCRtpSendParameters  编码器的设置
  codecPayloadType 
  dtx 
  active 
  ptime 
  maxBitrate 
  maxFramerate 
  scaleResolutionDownBY
第五层：
RTCRtpCodingParameters继承RTCRtpDecodingParameters
  rid
  
  
  
RTCRtpTransceiver:封装了一对RTCRtpSender和RTCRtpReceiver
属性：getTransceivers：获取一组RTCRtpTransceiver
方法：stop ：停止接收和发送


实战：传输速率控制

index.html

			<div>//选择速率的标签
				<label>Bandwidth:</label>
				<select id = "bandwidth" disabled>
					<option value="unlimited" selected>unlimited</option>
					<option value="2000">2000</option>
					<option value="1000">1000</option>
					<option value="500">500</option>
					<option value="250">250</option>
					<option value="125">125</option>
				</select>
				kbps
			</div>


main_bw.js
var bandwidth = document.querySelector('select#bandwidth');

bandwidth.onchange = change_bw;

function change_bw(){
    //参数设置不成功按钮先关闭
	bandwidth.disabled = true;
	var bw = bandwidth.options[bandwidth.selectedIndex].value;//用户选择的值

	var vsender = null;
	var senders = pc.getSenders();//获取到所有发送器

	senders.forEach(sender => {
		if(sender && sender.track.kind === 'video'){
			vsender = sender;//找到发送器
		}
	});

	var parameters = vsender.getParameters();//拿到它的参数
	
	if(!parameters.encodings){
		parameters.encodings=[{}];	//如果没有内容就不处理
	}

	if(bw === 'unlimited'){
		delete parameters.encodings[0].maxBitrate;
	}else{
		parameters.encodings[0].maxBitrate = bw * 1000;	//设取速率
	}

	vsender.setParameters(parameters)//添加回sender中
		.then(()=>{
			bandwidth.disabled = false;	//参数设置成功再打开
		})
		.catch(err => {
			console.error(err)
		});

	return;
}


//呼方收到answer需要打开设置速率
else if(data.hasOwnProperty('type') && data.type === 'answer'){
			pc.setRemoteDescription(new RTCSessionDescription(data));
			bandwidth.disabled = false;
		
		}
//接收方创建answer需要打开设置速率
function getAnswer(desc){
	pc.setLocalDescription(desc);
	bandwidth.disabled = false;

	//send answer sdp
	sendMessage(roomid, desc);
}



chrome浏览器调试：
chrome://webrtc-internals
查看：stats graphs for sscr..
可看到发送的流量是1m还是其它的，也就是码率



实战：webrtc统计信息流量也就是码率以及每秒发送的包数
index.html
            //显示流量及包数
			<div class="graph-container" id="bitrateGraph">
				<div>Bitrate</div>
				<canvas id="bitrateCanvas"></canvas>//画图用的
			</div>
			<div class="graph-container" id="packetGraph">
				<div>Packets sent per second</div>
				<canvas id="packetCanvas"></canvas>
			</div>
			//画图的js
		<script src="js/third_party/graph.js"></script>
		
		

main_bw.js
//每秒回调一次这个函数，像定时器
window.setInterval(() => {
  if (!pc) {
    return;
  }
  const sender = pc.getSenders()[0];//因为只有一个轨，视频，如果有其它轨需要判断
  if (!sender) {
    return;
  }
  sender.getStats().then(res => {//then 成功获取状态报道
    res.forEach(report => {
      let bytes;
      let packets;
      if (report.type === 'outbound-rtp') {//如果是输出的
        if (report.isRemote) {//如果是远端的，则不处理，只处理本地的
          return;
        }
        const now = report.timestamp;//报告生成的时间数
        bytes = report.bytesSent;//这次报告的字节
        packets = report.packetsSent;//发送的包数
        if (lastResult && lastResult.has(report.id)) {//如果和这次是同一个id，则处理
          // calculate bitrate
          const bitrate = 8 * (bytes - lastResult.get(report.id).bytesSent) /
            (now - lastResult.get(report.id).timestamp);//8位*（现在的-上一次的）／（现在-上一秒）

          // append to chart  流量相关的图
          bitrateSeries.addPoint(now, bitrate);//添加一个点
          bitrateGraph.setDataSeries([bitrateSeries]);//坐标
          bitrateGraph.updateEndDate();

          // calculate number of packets and append to chart
          packetSeries.addPoint(now, packets -
            lastResult.get(report.id).packetsSent);//包的点  这次减去上次的
          packetGraph.setDataSeries([packetSeries]);//坐标
          packetGraph.updateEndDate();
        }
      }
    });
    lastResult = res;//上一次的报告
  });
}, 1000);

//获取到流的时候要初使化状态图
function getMediaStream(stream){

	localStream = stream;	
	localVideo.srcObject = localStream;

	//这个函数的位置特别重要，
	//一定要放到getMediaStream之后再调用
	//否则就会出现绑定失败的情况
	
	//setup connection
	conn();

	bitrateSeries = new TimelineDataSeries();
	bitrateGraph = new TimelineGraphView('bitrateGraph', 'bitrateCanvas');
	bitrateGraph.updateEndDate();

	packetSeries = new TimelineDataSeries();
	packetGraph = new TimelineGraphView('packetGraph', 'packetCanvas');
	packetGraph.updateEndDate();
}


webrtc非音视频数据传输

 RTCPeerConnection下createDataChannel
 aPromise = pc.createDataChannel(label,[options]);//LABLE告诉是文本还是什么
 options:
   ordered:是否是按顺序到达，音视频是无序的
   maxPacketLifeTime/maxRetransmits :包的最大存活时间/包的最多重传次数
   negotiated:协商
       false:一端用createDataChannel创建通道，另一端监听onedatachannel事件
       true,两端都可以调用createDataChannel创建通道，通过id标识是否是同一通道
 id: 协疯时候通道id

例：
aPromise = pc.createDataChannel("chat",{ negotiated:true,id:0});


事件：
onmessage:对方有消息传来，回收到这事件
onopen:对方有消息传来或我们创建好createDataChannel调用此事件
onclose:DataChannel关闭
onerror:DataChannel数据出错的时候


非视频传输：
tcp/udp/sctp ：可靠/非可靠/可配置   sctp是在udp之上  tcp／sctp都是有序的/可配有序的

实实文本聊天：
index.html

<div>
					<h2>Chat:<h2>
					<textarea id="chat" disabled></textarea>
					<textarea id="sendtxt" disabled></textarea>
					<button id="send" disabled>Send</button>
				</div>

main_bw.js

var chat = document.querySelector('textarea#chat');
var send_txt = document.querySelector('textarea#sendtxt');
var btnSend = document.querySelector('button#send');

btnSend.onclick = sendText;
function sendText(){
	var data = send_txt.value;
	if(data != null){
		dc.send(data);
	}

	//更好的展示，发送完添空
	send_txt.value = "";
	chat.value += '<- ' + data + '\r\n';//显示的窗口累加
}

//在第二个人加入创建datachannel
	socket.on('otherjoin', (roomid) => {
		console.log('receive joined message:', roomid, state);

		//如果是多人的话，每上来一个人都要创建一个新的 peerConnection
		//
		if(state === 'joined_unbind'){
			createPeerConnection();
			bindTracks();
		}

		//create data channel for transporting non-audio/video data
		dc = pc.createDataChannel('chatchannel');
		dc.onmessage = receivemsg;
		dc.onopen = dataChannelStateChange;
		dc.onclose = dataChannelStateChange;

		state = 'joined_conn';
		call();

		console.log('receive other_join message, state=', state);
	});
var dc = null;	
function receivemsg(e){
	var msg = e.data;
	if(msg){//收到对方的消息
		console.log(msg);
		chat.value += "->" + msg + "\r\n";
	}else{
		console.error('received msg is null');
	}
}
function dataChannelStateChange() {
  var readyState = dc.readyState;//获取到状态，是打开还是断开
  console.log('Send channel state is: ' + readyState);
  if (readyState === 'open') {
    send_txt.disabled = false;
    send.disabled = false;
  } else {
    send_txt.disabled = true;
    send.disabled = true;
  }
}


另一方获取dc的方式：
		pc.ondatachannel = e=> {
			if(!dc){
				dc = e.channel;
				dc.onmessage = receivemsg; 
				dc.onopen = dataChannelStateChange;
				dc.onclose = dataChannelStateChange;
			}

		}
		

文件的实实传输：
通过js的FileReader从文件中读取数据
以数据块为单位发送数据，而不是一次发送整个文件
发送数据先要将文件的信息以信令的方式传给对方，告诉对方数据是什么，大小，类型，让对方知道文件大小，怎么存类型
还可上报服务器，传到哪里了

rtp-srtp协议头讲解
 web浏览器普通协议栈：
    xhr sse websocket
    http 1/2
    session(tls) 加密证书
    transport(tcp)
    ip协议
  支持webrtc协议的浏览器：
    rtcpeerconnection   datachannel
    srtp                 sctp(流传输)
         session(tls)（加密用的可选）
         ice ,stun, turn
         ip协议
         
webrtc传输协议
   rtp/srtp:
       rtp查看传输链路质量，传输视频数据,srtp是相对rtp的数据加密
   rtcp/srtcp
       发送rtp包的时候，延时，丢包，抖动的数量都能过rtcp进行上报的,srtcp把统计报告进行加密
   dtls
       rtp/rtcp加密之前对证书的加密
       
       
rtp：其实就是webrtc传输中一个头协议，头中包含版本，包顺序等，体中其实就是h.264,vp8,vp9的帧数据

   头解析：
   v： 2位版本号
   p： 1位，填充标识，最后一个字节是填充字节，含个数
   x： 1位，扩展标识，
   cc：4位，第一个c，和第二个c，分别控制头下面的数据
   m： 1位，用于区分帧之间的边界，因一帧拆成多个包，确保哪些包属于这一帧
   pt: 7位，playload type 描述体内数据是h.264 vp8 vp9
   seq number:  16位，标识包的顺序
   timestamp：   32位，如果是同一个时间，表示这几个包都是属于某一帧的，配合排序
   ssrc：        32位，一个视频源使用一个ssrc，一个音频源使用一个ssrc
   csrc：        32位，多路混音，多人聊天混成一路，这一路是一个csrc
   
rtcp包：
   rtcp包是在udp之上的，所以第一个是udp header
   rtcp包包括:rtcp header rtcp data
   
rtcp的端口为rtp端口+1
rtp,rtcp有时会复用端口，因为net穿越会产生多个端口比较麻烦
一个rtcp包中一般包含多个报告

rtcp payload type:
   100 sr   发送者的报告包
   201 rr   接收者的报告包
   202 sdes 源的一个描述，cname源的名字
   203 bye  不想共享源
   204 app  自定义自己的类型
   
rtcp中的header：
   p: 1位 填充标识，最后一个字节是填充字节，含个数
   rc: 5位 接收报告块的个数，可以是0
   pt: 8位，数据包类型
   length: 16位 ，包长度，包括头和包数据
   ssrc  32位，发送者的ssrc
   
rtcp playload type中 具体包结构：
   发送者的报告包：
      sender information block:发送者的报告信息包括如下：
            ntp 64位，网络时间，用于不同源之间同步
            rtp timestamp  32位，和rtp包时间一致，相对时间
            packet count   32位，总发包数，ssrc变化时会重置
            octet count    32位，总共发送的字节数
              
      receiver report block：同时作为接收者的报告信息
            ssrc_n  32位，接收到每个媒体源，多个用n表示
            faction lost 8位，上一次报告与本次报告的丢包比例
            packets lost  24位，自接收开始丢包总数，迟到的包不算
            hightest seq num  低16位表示收到的最大seq,高16位表示seq循环次数
            jitter  估计rtp包到达时间间隔的统计方差
            last sr  32位，上一次发送报告的ntp时间
            delay lsr 记录sr的时候与这次sr的时间差
    接收者的报告包 ：
         receiver report block：同时作为接收者的报告信息
            ssrc_n  32位，接收到每个媒体源，多个用n表示
            faction lost 8位，上一次报告与本次报告的丢包比例
            packets lost  24位，自接收开始丢包总数，迟到的包不算
            hightest seq num  低16位表示收到的最大seq,高16位表示seq循环次数
            jitter  估计rtp包到达时间间隔的统计方差
            last sr  32位，上一次发送报告的ntp时间
            delay lsr 记录sr的时候与这次sr的时间差
            
         

发送者与接收者发送时机：
    接收端只发接收者的报告包报文
    即是发送端又是接收端，在上一次报告有发送过数据时，则发sr发送者的报告包
    
    
协议规范，sdes
   rtcp payload type:
   202 sdes 源的一个描述，cname源的名字   

dtls 及证书交换
srtp 的结构

wireshark工具查看rtp，rtcp包



android与浏览器的互通
获取权限：
    摄像头权限
    录制音频
    访问互联网
      申请静态权限 <uses-permissionandroid:name="android">
      申请动态权限 void requestPermissions api申请动态权限
引入webrtc库 socket.io库
      implementation 'org.webrtc:google-webrtc:1.0+' 引入官方编译好的库
      implementation 'io.socket:socket.io-client1.0.0'
      easypermission   //更简单获取权限的库
          implementation 'pub.devrel:easypermissions:1.1.3'
信令处理
   客户端：
      join leave message(offer,answer,candidate)
   服务端返回：
       joined leaved other_joined bye full
webrtc处理流程


使用socket.io
    发消息：
    socket.emit("join",agrs);
    收消息：
    socket.on("joined",listener)


  
android中使用：
    PeerConnectionFactioyInterface 工厂
         可创建:
             PeerConnectionObserver  观察者：观察是join bye
             PeerConnectionInterface  连接
             LocalMediaStreamInterface  本地流
             LocalVideo/Audio TrackInterface   本地轨
webrtc处理流程
    video capture捕获数据  
    source  捕获到的视频数据源
    track   封装成track
    sink render 渲染显示到控件上
    
重要的类：
    PeerConnectionFactory
    PeerConnection
    MediaStream  流
    VideoCapture 捕获视频
    VideoSource/Video Track
    AudioSource/Audio Track
两个观察者
    PeerConnection.Observer
    SdpObserver sdp观察者
    

实战：
   权限，库引入，展示的界面
	   在Manifests文件中添加权限
	   在Module级的gradle中引入依赖库
	   编写界面
	   
	    
app/src/main/AndroidManifest.xml

    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
    <uses-feature
        android:glEsVersion="0x00020000"
        android:required="true" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
        
Gradle Scripts/build.gradle(Module:app)  
引入库
    dependencies {
    implementation 'io.socket:socket.io-client:1.0.0'
    implementation 'org.webrtc:google-webrtc:1.0.+'
    implementation 'pub.devrel:easypermissions:1.1.3'
}

增加编译选项防止某些机型报错：
    compileOptions {
        sourceCompatibility = '1.8'
        targetCompatibility = '1.8'
    }  
有些机型不适配：
    minSdkVersion 16    
    
MainActivity:
    信令服务器地址和房间号须填写
CallActivity

界面：
res/layout/activity_call.xml
res/layout/activity_call.xml


收发信令：
实现Activity的切换
编写signal类，连接信令socket.io发送加入房间等信令
在CallActivity中使用signal对象实现信令的触发

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final EditText serverEditText = findViewById(R.id.ServerEditText);
        final EditText roomEditText = findViewById(R.id.RoomEditText);
        findViewById(R.id.JoinRoomBtn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String addr = serverEditText.getText().toString();
                String roomName = roomEditText.getText().toString();
                if (!"".equals(roomName)) {
                    //跳转页面
                    Intent intent = new Intent(MainActivity.this, CallActivity.class);
                    intent.putExtra("ServerAddr", addr);//传参
                    intent.putExtra("RoomName", roomName);
                    startActivity(intent);
                }
            }
        });
        //动态申请权限
        String[] perms = {Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO};
        if (!EasyPermissions.hasPermissions(this, perms)) {
            EasyPermissions.requestPermissions(this, "Need permissions for camera & microphone", 0, perms);
        }
    }
    //权限申请的结果，用户同意了该作什么
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        EasyPermissions.onRequestPermissionsResult(requestCode, permissions, grantResults, this);
    }

    
    
信令部份：SignalClient.java
public class SignalClient {

    private static final String TAG = "SignalClient";

    private static SignalClient mInstance;//单例模式
    private OnSignalEventListener mOnSignalEventListener;

    private Socket mSocket;//socketio对象
    private String mRoomName;//房间号

    public interface OnSignalEventListener {
        void onConnected();
        void onConnecting();
        void onDisconnected();
        void onUserJoined(String roomName, String userID);
        void onUserLeaved(String roomName, String userID);
        void onRemoteUserJoined(String roomName);
        void onRemoteUserLeaved(String roomName, String userID);
        void onRoomFull(String roomName, String userID);
        void onMessage(JSONObject message);
    }
    //单例
    public static SignalClient getInstance() {
        synchronized (SignalClient.class) {
            if (mInstance == null) {
                mInstance = new SignalClient();
            }
        }
        return mInstance;
    }

    public void setSignalEventListener(final OnSignalEventListener listener) {
        mOnSignalEventListener = listener;
    }
    //加入房间
    public void joinRoom(String url, String roomName) {
        Log.i(TAG, "joinRoom: " + url + ", " + roomName);
        //连接
        try {
            mSocket = IO.socket(url);
            mSocket.connect();
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return;
        }
        //mUserId = userId;
        mRoomName = roomName;
        listenSignalEvents();//监听器

        mSocket.emit("join", mRoomName);
    }

    public void leaveRoom() {

        Log.i(TAG, "leaveRoom: " + mRoomName);
        if (mSocket == null) {
            return;
        }

        mSocket.emit("leave", mRoomName);
        mSocket.close();
        mSocket = null;
    }

    public void sendMessage(JSONObject message) {
        Log.i(TAG, "broadcast: " + message);
        if (mSocket == null) {
            return;
        }
        mSocket.emit("message", mRoomName, message);
    }

    //侦听从服务器收到的消息 注册监听器
    private void listenSignalEvents() {

        if (mSocket == null) {
            return;
        }

        mSocket.on(Socket.EVENT_CONNECT_ERROR, new Emitter.Listener() {
            @Override
            public void call(Object... args) {

                Log.e(TAG, "onConnectError: " + args);
            }
        });

        mSocket.on(Socket.EVENT_ERROR, new Emitter.Listener() {
            @Override
            public void call(Object... args) {

                Log.e(TAG, "onError: " + args);
            }
        });

        mSocket.on(Socket.EVENT_CONNECT, new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                String sessionId = mSocket.id();
                Log.i(TAG, "onConnected");
                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onConnected();
                }
            }
        });

        mSocket.on(Socket.EVENT_CONNECTING, new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                Log.i(TAG, "onConnecting");
                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onConnecting();
                }
            }
        });

        mSocket.on(Socket.EVENT_DISCONNECT, new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                Log.i(TAG, "onDisconnected");
                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onDisconnected();
                }
            }
        });

        mSocket.on("joined", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                String roomName = (String) args[0];
                String userId = (String) args[1];
                if (/*!mUserId.equals(userId) &&*/ mOnSignalEventListener != null) {
                    //mOnSignalEventListener.onRemoteUserJoined(userId);
                    mOnSignalEventListener.onUserJoined(roomName, userId);
                }
                //Log.i(TAG, "onRemoteUserJoined: " + userId);
                Log.i(TAG, "onUserJoined, room:" + roomName + "uid:" + userId);
            }
        });

        mSocket.on("leaved", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                String roomName = (String) args[0];
                String userId = (String) args[1];
                if (/*!mUserId.equals(userId) &&*/ mOnSignalEventListener != null) {
                    //mOnSignalEventListener.onRemoteUserLeft(userId);
                    mOnSignalEventListener.onUserLeaved(roomName, userId);
                }
                Log.i(TAG, "onUserLeaved, room:" + roomName + "uid:" + userId);
            }
        });

        mSocket.on("otherjoin", new Emitter.Listener() {

            @Override
            public void call(Object... args) {
                String roomName = (String) args[0];
                String userId = (String) args[1];
                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onRemoteUserJoined(roomName);
                }
                Log.i(TAG, "onRemoteUserJoined, room:" + roomName + "uid:" + userId);
            }
        });

        mSocket.on("bye", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                String roomName = (String) args[0];
                String userId = (String) args[1];
                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onRemoteUserLeaved(roomName, userId);
                }
                Log.i(TAG, "onRemoteUserLeaved, room:" + roomName + "uid:" + userId);

            }
        });

        mSocket.on("full", new Emitter.Listener() {
            @Override
            public void call(Object... args) {

                //释放资源
                mSocket.disconnect();
                mSocket.close();
                mSocket = null;

                String roomName = (String) args[0];
                String userId = (String) args[1];

                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onRoomFull(roomName, userId);
                }

                Log.i(TAG, "onRoomFull, room:" + roomName + "uid:" + userId);

            }
        });

        mSocket.on("message", new Emitter.Listener() {
            @Override
            public void call(Object... args) {
                String roomName = (String)args[0];
                JSONObject msg = (JSONObject) args[1];

                if (mOnSignalEventListener != null) {
                    mOnSignalEventListener.onMessage(msg);
                }

                Log.i(TAG, "onMessage, room:" + roomName + "data:" + msg);

            }
        });
    }
}


创建PeerConnection
	音视频数据采集
	创建PeerConnection
媒体协商
    媒体能力协商
    Candidate连通性检测（后选者）
    视频渲染
    
CallActivity.java

public class CallActivity extends AppCompatActivity {

    private static final int VIDEO_RESOLUTION_WIDTH = 1280;
    private static final int VIDEO_RESOLUTION_HEIGHT = 720;
    private static final int VIDEO_FPS = 30;

    private String mState = "init";

    private TextView mLogcatView;

    private static final String TAG = "CallActivity";

    public static final String VIDEO_TRACK_ID = "1";//"ARDAMSv0";
    public static final String AUDIO_TRACK_ID = "2";//"ARDAMSa0";

    //用于数据传输
    private PeerConnection mPeerConnection;
    private PeerConnectionFactory mPeerConnectionFactory;

    //OpenGL ES
    private EglBase mRootEglBase;
    //纹理渲染
    private SurfaceTextureHelper mSurfaceTextureHelper;

    //继承自 surface view
    private SurfaceViewRenderer mLocalSurfaceView;
    private SurfaceViewRenderer mRemoteSurfaceView;

    private VideoTrack mVideoTrack;
    private AudioTrack mAudioTrack;

    private VideoCapturer mVideoCapturer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_call);

        mLogcatView = findViewById(R.id.LogcatView);

        mRootEglBase = EglBase.create();

        mLocalSurfaceView = findViewById(R.id.LocalSurfaceView);
        mRemoteSurfaceView = findViewById(R.id.RemoteSurfaceView);

        mLocalSurfaceView.init(mRootEglBase.getEglBaseContext(), null);
        mLocalSurfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FILL);
        mLocalSurfaceView.setMirror(true);
        mLocalSurfaceView.setEnableHardwareScaler(false /* enabled */);

        mRemoteSurfaceView.init(mRootEglBase.getEglBaseContext(), null);
        mRemoteSurfaceView.setScalingType(RendererCommon.ScalingType.SCALE_ASPECT_FILL);
        mRemoteSurfaceView.setMirror(true);
        mRemoteSurfaceView.setEnableHardwareScaler(true /* enabled */);
        mRemoteSurfaceView.setZOrderMediaOverlay(true);

        //创建 factory， pc是从factory里获得的
        mPeerConnectionFactory = createPeerConnectionFactory(this);

        // NOTE: this _must_ happen while PeerConnectionFactory is alive!
        Logging.enableLogToDebugOutput(Logging.Severity.LS_VERBOSE);

        mVideoCapturer = createVideoCapturer();

        mSurfaceTextureHelper = SurfaceTextureHelper.create("CaptureThread", mRootEglBase.getEglBaseContext());
        VideoSource videoSource = mPeerConnectionFactory.createVideoSource(false);
        mVideoCapturer.initialize(mSurfaceTextureHelper, getApplicationContext(), videoSource.getCapturerObserver());

        mVideoTrack = mPeerConnectionFactory.createVideoTrack(VIDEO_TRACK_ID, videoSource);
        mVideoTrack.setEnabled(true);
        mVideoTrack.addSink(mLocalSurfaceView);

        AudioSource audioSource = mPeerConnectionFactory.createAudioSource(new MediaConstraints());
        mAudioTrack = mPeerConnectionFactory.createAudioTrack(AUDIO_TRACK_ID, audioSource);
        mAudioTrack.setEnabled(true);

        SignalClient.getInstance().setSignalEventListener(mOnSignalEventListener);

        String serverAddr = getIntent().getStringExtra("ServerAddr");
        String roomName = getIntent().getStringExtra("RoomName");
        SignalClient.getInstance().joinRoom(serverAddr, roomName);
    }

    @Override
    protected void onResume() {
        super.onResume();
        mVideoCapturer.startCapture(VIDEO_RESOLUTION_WIDTH, VIDEO_RESOLUTION_HEIGHT, VIDEO_FPS);
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            mVideoCapturer.stopCapture();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        doLeave();
        mLocalSurfaceView.release();
        mRemoteSurfaceView.release();
        mVideoCapturer.dispose();
        mSurfaceTextureHelper.dispose();
        PeerConnectionFactory.stopInternalTracingCapture();
        PeerConnectionFactory.shutdownInternalTracer();
        mPeerConnectionFactory.dispose();
    }

    public static class SimpleSdpObserver implements SdpObserver {
        @Override
        public void onCreateSuccess(SessionDescription sessionDescription) {
            Log.i(TAG, "SdpObserver: onCreateSuccess !");
        }

        @Override
        public void onSetSuccess() {
            Log.i(TAG, "SdpObserver: onSetSuccess");
        }

        @Override
        public void onCreateFailure(String msg) {
            Log.e(TAG, "SdpObserver onCreateFailure: " + msg);
        }

        @Override
        public void onSetFailure(String msg) {

            Log.e(TAG, "SdpObserver onSetFailure: " + msg);
        }
    }

    private void updateCallState(boolean idle) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (idle) {
                    mRemoteSurfaceView.setVisibility(View.GONE);
                } else {
                    mRemoteSurfaceView.setVisibility(View.VISIBLE);
                }
            }
        });
    }

    public void doStartCall() {
        logcatOnUI("Start Call, Wait ...");
        if (mPeerConnection == null) {
            mPeerConnection = createPeerConnection();
        }
        MediaConstraints mediaConstraints = new MediaConstraints();
        mediaConstraints.mandatory.add(new MediaConstraints.KeyValuePair("OfferToReceiveAudio", "true"));
        mediaConstraints.mandatory.add(new MediaConstraints.KeyValuePair("OfferToReceiveVideo", "true"));
        mediaConstraints.optional.add(new MediaConstraints.KeyValuePair("DtlsSrtpKeyAgreement", "true"));
        mPeerConnection.createOffer(new SimpleSdpObserver() {
            @Override
            public void onCreateSuccess(SessionDescription sessionDescription) {
                Log.i(TAG, "Create local offer success: \n" + sessionDescription.description);
                mPeerConnection.setLocalDescription(new SimpleSdpObserver(), sessionDescription);
                JSONObject message = new JSONObject();
                try {
                    message.put("type", "offer");
                    message.put("sdp", sessionDescription.description);
                    SignalClient.getInstance().sendMessage(message);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, mediaConstraints);
    }

    public void doLeave() {
        logcatOnUI("Leave room, Wait ...");
        hangup();

        SignalClient.getInstance().leaveRoom();

    }

    public void doAnswerCall() {
        logcatOnUI("Answer Call, Wait ...");

        if (mPeerConnection == null) {
            mPeerConnection = createPeerConnection();
        }

        MediaConstraints sdpMediaConstraints = new MediaConstraints();
        Log.i(TAG, "Create answer ...");
        mPeerConnection.createAnswer(new SimpleSdpObserver() {
            @Override
            public void onCreateSuccess(SessionDescription sessionDescription) {
                Log.i(TAG, "Create answer success !");
                mPeerConnection.setLocalDescription(new SimpleSdpObserver(),
                                                    sessionDescription);

                JSONObject message = new JSONObject();
                try {
                    message.put("type", "answer");
                    message.put("sdp", sessionDescription.description);
                    SignalClient.getInstance().sendMessage(message);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, sdpMediaConstraints);
        updateCallState(false);
    }

    private void hangup() {
        logcatOnUI("Hangup Call, Wait ...");
        if (mPeerConnection == null) {
            return;
        }
        mPeerConnection.close();
        mPeerConnection = null;
        logcatOnUI("Hangup Done.");
        updateCallState(true);
    }

    public PeerConnection createPeerConnection() {
        Log.i(TAG, "Create PeerConnection ...");

        LinkedList<PeerConnection.IceServer> iceServers = new LinkedList<PeerConnection.IceServer>();

        PeerConnection.IceServer ice_server =
                    PeerConnection.IceServer.builder("turn:xxxx:3478")
                                            .setPassword("xxx")
                                            .setUsername("xxx")
                                            .createIceServer();

        iceServers.add(ice_server);

        PeerConnection.RTCConfiguration rtcConfig = new PeerConnection.RTCConfiguration(iceServers);
        // TCP candidates are only useful when connecting to a server that supports
        // ICE-TCP.
        rtcConfig.tcpCandidatePolicy = PeerConnection.TcpCandidatePolicy.DISABLED;
        //rtcConfig.bundlePolicy = PeerConnection.BundlePolicy.MAXBUNDLE;
        //rtcConfig.rtcpMuxPolicy = PeerConnection.RtcpMuxPolicy.REQUIRE;
        rtcConfig.continualGatheringPolicy = PeerConnection.ContinualGatheringPolicy.GATHER_CONTINUALLY;
        // Use ECDSA encryption.
        //rtcConfig.keyType = PeerConnection.KeyType.ECDSA;
        // Enable DTLS for normal calls and disable for loopback calls.
        rtcConfig.enableDtlsSrtp = true;
        //rtcConfig.sdpSemantics = PeerConnection.SdpSemantics.UNIFIED_PLAN;
        PeerConnection connection =
                mPeerConnectionFactory.createPeerConnection(rtcConfig,
                                                            mPeerConnectionObserver);
        if (connection == null) {
            Log.e(TAG, "Failed to createPeerConnection !");
            return null;
        }

        List<String> mediaStreamLabels = Collections.singletonList("ARDAMS");
        connection.addTrack(mVideoTrack, mediaStreamLabels);
        connection.addTrack(mAudioTrack, mediaStreamLabels);

        return connection;
    }

    public PeerConnectionFactory createPeerConnectionFactory(Context context) {
        final VideoEncoderFactory encoderFactory;
        final VideoDecoderFactory decoderFactory;

        encoderFactory = new DefaultVideoEncoderFactory(
                                mRootEglBase.getEglBaseContext(),
                                false /* enableIntelVp8Encoder */,
                                true);
        decoderFactory = new DefaultVideoDecoderFactory(mRootEglBase.getEglBaseContext());

        PeerConnectionFactory.initialize(PeerConnectionFactory.InitializationOptions.builder(context)
                .setEnableInternalTracer(true)
                .createInitializationOptions());

        PeerConnectionFactory.Builder builder = PeerConnectionFactory.builder()
                .setVideoEncoderFactory(encoderFactory)
                .setVideoDecoderFactory(decoderFactory);
        builder.setOptions(null);

        return builder.createPeerConnectionFactory();
    }

    /*
     * Read more about Camera2 here
     * https://developer.android.com/reference/android/hardware/camera2/package-summary.html
     **/
    private VideoCapturer createVideoCapturer() {
        if (Camera2Enumerator.isSupported(this)) {
            return createCameraCapturer(new Camera2Enumerator(this));
        } else {
            return createCameraCapturer(new Camera1Enumerator(true));
        }
    }

    private VideoCapturer createCameraCapturer(CameraEnumerator enumerator) {
        final String[] deviceNames = enumerator.getDeviceNames();

        // First, try to find front facing camera
        Log.d(TAG, "Looking for front facing cameras.");
        for (String deviceName : deviceNames) {
            if (enumerator.isFrontFacing(deviceName)) {
                Logging.d(TAG, "Creating front facing camera capturer.");
                VideoCapturer videoCapturer = enumerator.createCapturer(deviceName, null);
                if (videoCapturer != null) {
                    return videoCapturer;
                }
            }
        }

        // Front facing camera not found, try something else
        Log.d(TAG, "Looking for other cameras.");
        for (String deviceName : deviceNames) {
            if (!enumerator.isFrontFacing(deviceName)) {
                Logging.d(TAG, "Creating other camera capturer.");
                VideoCapturer videoCapturer = enumerator.createCapturer(deviceName, null);
                if (videoCapturer != null) {
                    return videoCapturer;
                }
            }
        }
        return null;
    }

    private PeerConnection.Observer mPeerConnectionObserver = new PeerConnection.Observer() {
        @Override
        public void onSignalingChange(PeerConnection.SignalingState signalingState) {
            Log.i(TAG, "onSignalingChange: " + signalingState);
        }

        @Override
        public void onIceConnectionChange(PeerConnection.IceConnectionState iceConnectionState) {
            Log.i(TAG, "onIceConnectionChange: " + iceConnectionState);
        }

        @Override
        public void onIceConnectionReceivingChange(boolean b) {
            Log.i(TAG, "onIceConnectionChange: " + b);
        }

        @Override
        public void onIceGatheringChange(PeerConnection.IceGatheringState iceGatheringState) {
            Log.i(TAG, "onIceGatheringChange: " + iceGatheringState);
        }

        @Override
        public void onIceCandidate(IceCandidate iceCandidate) {
            Log.i(TAG, "onIceCandidate: " + iceCandidate);

            try {
                JSONObject message = new JSONObject();
                //message.put("userId", RTCSignalClient.getInstance().getUserId());
                message.put("type", "candidate");
                message.put("label", iceCandidate.sdpMLineIndex);
                message.put("id", iceCandidate.sdpMid);
                message.put("candidate", iceCandidate.sdp);
                SignalClient.getInstance().sendMessage(message);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onIceCandidatesRemoved(IceCandidate[] iceCandidates) {
            for (int i = 0; i < iceCandidates.length; i++) {
                Log.i(TAG, "onIceCandidatesRemoved: " + iceCandidates[i]);
            }
            mPeerConnection.removeIceCandidates(iceCandidates);
        }

        @Override
        public void onAddStream(MediaStream mediaStream) {
            Log.i(TAG, "onAddStream: " + mediaStream.videoTracks.size());
        }

        @Override
        public void onRemoveStream(MediaStream mediaStream) {
            Log.i(TAG, "onRemoveStream");
        }

        @Override
        public void onDataChannel(DataChannel dataChannel) {
            Log.i(TAG, "onDataChannel");
        }

        @Override
        public void onRenegotiationNeeded() {
            Log.i(TAG, "onRenegotiationNeeded");
        }

        @Override
        public void onAddTrack(RtpReceiver rtpReceiver, MediaStream[] mediaStreams) {
            MediaStreamTrack track = rtpReceiver.track();
            if (track instanceof VideoTrack) {
                Log.i(TAG, "onAddVideoTrack");
                VideoTrack remoteVideoTrack = (VideoTrack) track;
                remoteVideoTrack.setEnabled(true);
                remoteVideoTrack.addSink(mRemoteSurfaceView);
            }
        }
    };

    private SignalClient.OnSignalEventListener
            mOnSignalEventListener = new SignalClient.OnSignalEventListener() {

        @Override
        public void onConnected() {

            logcatOnUI("Signal Server Connected !");
        }

        @Override
        public void onConnecting() {

            logcatOnUI("Signal Server Connecting !");
        }

        @Override
        public void onDisconnected() {

            logcatOnUI("Signal Server Disconnected!");
        }

        @Override
        public void onUserJoined(String roomName, String userID){

            logcatOnUI("local user joined!");

            mState = "joined";

            //这里应该创建PeerConnection
            if (mPeerConnection == null) {
                mPeerConnection = createPeerConnection();
            }
        }

        @Override
        public void onUserLeaved(String roomName, String userID){
            logcatOnUI("local user leaved!");

            mState = "leaved";
        }

        @Override
        public void onRemoteUserJoined(String roomName) {
            logcatOnUI("Remote User Joined, room: " + roomName);

            if(mState.equals("joined_unbind")){
                if (mPeerConnection == null) {
                    mPeerConnection = createPeerConnection();
                }
            }

            mState = "joined_conn";
            //调用call， 进行媒体协商
            doStartCall();
        }

        @Override
        public void onRemoteUserLeaved(String roomName, String userID) {
            logcatOnUI("Remote User Leaved, room: " + roomName + "uid:"  + userID);
            mState = "joined_unbind";

            if(mPeerConnection !=null ){
                mPeerConnection.close();
                mPeerConnection = null;
            }
        }

        @Override
        public void onRoomFull(String roomName, String userID){
            logcatOnUI("The Room is Full, room: " + roomName + "uid:"  + userID);
            mState = "leaved";

            if(mLocalSurfaceView != null) {
                mLocalSurfaceView.release();
                mLocalSurfaceView = null;
            }

            if(mRemoteSurfaceView != null) {
                mRemoteSurfaceView.release();
                mRemoteSurfaceView = null;
            }

            if(mVideoCapturer != null) {
                mVideoCapturer.dispose();
                mVideoCapturer = null;
            }

            if(mSurfaceTextureHelper != null) {
                mSurfaceTextureHelper.dispose();
                mSurfaceTextureHelper = null;

            }

            PeerConnectionFactory.stopInternalTracingCapture();
            PeerConnectionFactory.shutdownInternalTracer();

            if(mPeerConnectionFactory !=null) {
                mPeerConnectionFactory.dispose();
                mPeerConnectionFactory = null;
            }

            finish();
        }

        @Override
        public void onMessage(JSONObject message) {

            Log.i(TAG, "onMessage: " + message);

            try {
                String type = message.getString("type");
                if (type.equals("offer")) {
                    onRemoteOfferReceived(message);
                }else if(type.equals("answer")) {
                    onRemoteAnswerReceived(message);
                }else if(type.equals("candidate")) {
                        onRemoteCandidateReceived(message);
                }else{
                    Log.w(TAG, "the type is invalid: " + type);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        private void onRemoteOfferReceived(JSONObject message) {
            logcatOnUI("Receive Remote Call ...");

            if (mPeerConnection == null) {
                mPeerConnection = createPeerConnection();
            }

            try {
                String description = message.getString("sdp");
                mPeerConnection.setRemoteDescription(
                                            new SimpleSdpObserver(),
                                            new SessionDescription(
                                                                SessionDescription.Type.OFFER,
                                                                description));
                doAnswerCall();
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        private void onRemoteAnswerReceived(JSONObject message) {
            logcatOnUI("Receive Remote Answer ...");
            try {
                String description = message.getString("sdp");
                mPeerConnection.setRemoteDescription(
                                    new SimpleSdpObserver(),
                                    new SessionDescription(
                                            SessionDescription.Type.ANSWER,
                                            description));
            } catch (JSONException e) {
                e.printStackTrace();
            }
            updateCallState(false);
        }

        private void onRemoteCandidateReceived(JSONObject message) {
            logcatOnUI("Receive Remote Candidate ...");
            try {
                IceCandidate remoteIceCandidate =
                        new IceCandidate(message.getString("id"),
                                            message.getInt("label"),
                                            message.getString("candidate"));

                mPeerConnection.addIceCandidate(remoteIceCandidate);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        private void onRemoteHangup() {
            logcatOnUI("Receive Remote Hangup Event ...");
            hangup();
        }
    };

    private void logcatOnUI(String msg) {
        Log.i(TAG, msg);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                String output = mLogcatView.getText() + "\n" + msg;
                mLogcatView.setText(output);
            }
        });
    }
}




IOS WEBRTC

本地视频采集与展示
创建RTCPeerConnection的rtp udp进行传输
媒体协商
远端视频的展示

打开权限
plist中privacy - camera usage
       privacy - microphone usage
  
  
    
ios引入webrtc库
通过pod方式引入
编译webrtc源码，手动引入，下载源码需要翻墙

编写podfile中
pod install


source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!//使用编译好的二进制的库，解决socket.io只有swift版本的问题
platform:ios,'11.0'
target 'WebRTC4iOS2' do //工程名
  pod 'GoogleWebRTC'
  pod 'Socket.IO-Client-Swift','~>13.3.0'
end

保证swift的socketio能在pod中正常安装
在bulid setting中搜索swift
查看到版本号SWIFT_VERSION 4.2
所以在bulid setting 加号 用户定义增加一行：SWIFT_VERSION 4.2



ios端 socketio的使用

通过socket.io连接服务端
发送消息
注册侦听的消息，哪些加入房间等

NSURL *URL = 
manager = [SocketManager alloc]initWithSocketURL:url
                                   config:@{
                                       @"log":@YES,
                                       @"forcePolling":@YES,
                                       @"forceWebsock":@YES
                                   }
socket = manager.defaultSocket;
if(socket.status==SocketIOStatusConnected){//如果建立成功
    [socket emit:@"join" with:@[room]];//房间名字
}

[socket on:@"connect" callback:^(NSArray* data,SocketAckEmitter *ack){
      NSLog(@"连接成功");
}]



具体代码：
bulid settings 搜索bitco ，关闭enable bitcode 因为webrtc不能使用bitcode
在ViewController.m中
@import SocketIO
@interface ViewController(){
    SocketManager *manager;
    SocketIOClient* socket;
}
-(void)viewDidLoad{
    [self connect];
}
-(void)connect{
    //socket.io服务器地址
	NSURL *url = [[NSUrl alloc] initWithString:@"https://learningrtc.cn"];
	manager = [SocketManager alloc]initWithSocketURL:url
									   config:@{
										   @"log":@YES,
										   @"forcePolling":@YES,
										   @"forceWebsock":@YES
									   }
	socket = manager.defaultSocket;
	[socket connect];
	if(socket.status==SocketIOStatusConnected){//如果建立成功
		[socket emit:@"join" with:@[@"111111"]];//房间名字ID
	}
    //监听消息
	[socket on:@"connect" callback:^(NSArray* data,SocketAckEmitter *ack){
		  NSLog(@"连接成功");
		  	if(socket.status==SocketIOStatusConnected){//如果建立成功
				[self->socket emit:@"join" with:@[@"111111"]];//房间名字ID
			}
	}]
	
	[socket on:@"joined" callback:^(NSArray* data,SocketAckEmitter *ack){
		  NSLog(@"joinde");
		  	NSString *room = [data objectAtIndex:0];
		  	NSString *userid = [data objectAtIndex:1];
	}]

}



ios界面的布局
ViewController.m
	UITextField* addr;
	UITextField* room;
	CallViewController *call;
	self.joinBtn
    -(void)btnClick:{
      [self addChildViewController:self.call];
      [self.call didMoveToParentViewController:self];
      //在内部建立了socketio的连接
      [self.view addSubview:self.call.view];
      //拿到连接成功的SignalClient单例
      sigclient = [SignalClient getInstance];
      //加入房间
      [sigclient joinRoom:@"111111"];
    }

CallViewController.m
	UITextField* myaddr;
	UITextField* myroom;
-(instancetype)initAddr:(NSString*)addr withRoom:(NSString*)room{
    myaddr = addr;
    myroom = room;
}


IOS本地视频的采集和展示
CallViewController.m

#import <WebRTC/WebRTC.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface CallViewController()<SignalEventNotify,RTCPeerConnectionDelegate,RTCVideoViewDelegate>
{
     NSString *myAddr;
     NSString *myRoom;
     NSString *myState;
     SignalClient *sigclient;
     RTCPeerConnectionFactory *factory;
     RTCCameraVideoCapturer *capture;
     //RTCMediaStream *localStream;
     RTCPeerConnection *peerConnection;
     
     RTCVideoTrack *videoTrack;
     RTCAudioTrack *audioTrack;
     
     RTCVideoTrack *remoteVideoTrack;
     CGSize remoteVideoSize;
     
     NSMutableArray *ICEServers;
}

@property (strong, nonatomic) RTCEAGLVideoView *remoteVideoView;//展示远端视频窗口，读Track数据
@property (strong, nonatomic) RTCCameraPreviewView *localVideoView;//展示本地，读本地source源数据
@property (strong, nonatomic) UIButton *leaveBtn;

@end

@implementation CallViewController
static CGFloat const kLocalVideoViewSize = 120;
static CGFloat const kLocalVideoViewPadding =8;
static NSString *const RTCSTUNServerURL = @"turn:stun.al.learningrtc.cn:3478";

-(instancetype)initAddr:(NSString*)addr withRoom:(NSString*)room{
    myAddr = addr;
    myRoom = room;
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = self.view.bounds;
    self.remoteVideoView = [[RTCEAGLVideoView alloc]initWithFrame:self.view.bounds];
    self.remoteVideoView.delegate = self;
    [self.view addSubview:self.remoteVideoView];
    
    self.localVideoView = [[RTCCameraPreviewView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.localVideoView];
    
    CGRect localVideoFrame = CGRectMake(0,0,kLocalVideoViewSize,kLocalVideoViewSize);
    localVideoFrame.origin.x = CGRectGetMaxX(bounds);
    
    localVideoFrame.origin.x = CGRectGetMaxX(bounds)-localVideoFrame.size.height-kLocalVideoViewPadding;
    localVideoFrame.origin.y = CGRectGetMaxY(bounds)-localVideoFrame.size.height-kLocalVideoViewPadding;
    [self.localVideoView setFrame:localVideoFrame];
    
    self.leaveBtn = [[UIButton alloc]init];
    [self.leaveBtn setTitleColor:[UIColor whitecolor] forState:UIControlStateNormal];
    [self.leaveBtn setFrame:CGRectMake(self.view.bounds.size.width/2-40,self.view.bounds.size.height-140,80,80)];
    [self.leaveBtn addTarget:self action:@selector(leaveRoom:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leaveBtn];
    //创建工厂，工厂可创建videosource connection
    [self createPeerConnectionFactory];
    //本地视频数据采集，渲染
    [self captureLocalMedia];
    //建立一个连接
    sigclient = [signalClient getInstance];
    sigclient.delegate = self;
    [sigclient createConnect:myAddr];

}

-(void)createPeerConnectionFactory{
   //设置ssl传输，工厂创建前必须调用
   [RTCPeerConnectionFactory initialize];
   if(!factory){
       //指定自己偏好的编码器解码器
       RTCDefaultVideoDecoderFactory *decoderFactory = [[RTCDefaultVideoDecoderFactory alloc]init];
       RTCDefaultVideoDecoderFactory *encoderFactory = [[RTCDefaultVideoDecoderFactory alloc]init];
       //获取出所支持的所有编码器
        NSArray *codecs = [encoderFactory supportedCodecs];
        //把自己偏好的编码器设置进去
       [encoderFactory setPreferredCodec:codecs[2]];
       factory = [[RTCPeerConnectionFactory alloc]initWithEncoderFactory:encoderFactory decoderFactory:decoderFactory];		
       //factory = [[RTCPeerConnectionFactory alloc]init];
   }
}

-(void)captureLocalMedia{
    NSDictionary *mandatoryConstraints = @{};
    [[RTCMediaConstraints alloc] initWithMandatoryConstraints:mandatoryConstraints optionalConstraints:nil]];
    RTCAudioSource *audioSource = [factory audioSourceWithConstraints:constraints];
    audioTrack = [factory audioTrackWithSource:audioSource trackId:@"ADRAMSa0"];
    //获取到所有移动端支持的设备video
    NSArray<AVCaptureDevice*>*catureDevices = [RTCCameraVideoCapturer captureDevices];
    //默认前置摄像头
    AVCaptureDevicePosition  position = AVCaptureDevicePositionFront;
    AVCaptureDevice* device = captureDevices[0];
    for(AVCaptureDevice*obj in catureDevices){
         if(obj.position ==position){
             device = obj;//找到前置摄像头
             break;
         }
    }
    //检查摄像头权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted ||authStatus==AVAuthorizationStatusDenied){
        NSLog(@"相机访问受限");
        return;
    }
    if(device){
        //设备采集的数据先输送给这个viceosource，view展示视频从viceosource的代理去拿
        RTCVideoSource *videoSource = [factory videoSource];
        //videoSource观察设备的采集
        capture = [[RTCCameraVideoCapturer alloc]initWithDelegate:videoSource];
        AVCaptureDeviceFormat *format = [[RTCCameraVideoCaturer supportedFormatsForDevice:device]lastObject];
        CGFloat fps = [[format videoSupportedFrameRateRanges] firstObject].macFrameRate;
        //videoSource与track建立联系，用于传输数据用的
        videoTrack =[factory videoTrackWithSource:videoSource trackId:@"ARDAMSv0"];
        //本地显示videoSource的视频
        self.localVideoView.captureSession = capture.captureSession;
        //启动的时候就会去展示数据
        [capture startCaptureWithDevice:device format:format fps:fps];
    }
    
}
-(void)leaved:(NSString*)room{
    NSLog(@"leave");
}
//SignalClient中加入房间后成功后的回调
-(void)joined:(NSString*)room{
    myState = @"joined";
    //这里创建PeerConnection
    if(!peerConnection){
        peerConnection = [self createPeerConnection];
    }
}
-(void)otherjoin:(NSString*)room User:(NSString*)uid
{
    //其它用户加入房间自己会收到joined_unbind
    if([myState isEqualToString:@"joined_unbind"]){
        if(!peerConnection){
          peerConnection = [self createPeerConnection];
        }
    }
    myState = @"joined_conn";
    //调用call 进行媒体协商
    [self doStartCall];
}
-(void)full:(NSString *)room {
   //房间满了的回调
   myState = @"leaved";
   if(peerConnection){
       [peerConnection close];
       peerConnection = nil;
   }
   if(self.localVideoView){
      //[self.localVideoView removeFromSuperview];
      //self.localVideoView = nil;
   }
}

-(void) doStartCall{
   if(!peerConnection){
       peerConnection = [self createPeerConnection];
   }
   //创建offer
   [peerConnection offerForConstraints:[self defaultPeerConnContraints] completionHandler:^(RTCSessionDescription *_Nullable sdp,NSError*_Nullable error){
         if(error){
           NSLog(@"创建offer失败");
         }else{
            __weak RTCPeerConnnection* weakPeerConntion =  self ->peerConnection;
            [self setLocalOffer:weakPeerConnction withSdp:sdp];//把offer存在本地
         }
   }];
}
//设置本地offer
-(void)setLocalOffer:(RTCPeerConnection*)pc withSdp:(RTCSessionDescription*)sdp{
    [pc setLocalDescription:sdp completionHandler:^(NSError *_Nullable error){
            if(!error){
               //成功设置offer到本地
            }else{
               //没有成功设置offer到本地
            }
    }];
    __weak NSString* weakMyRoom = myRoom;
    dispatch_async(dispatch_get_main_queue,^{
        NSDictionary* dict = [NSDictionary alloc]initWithObject:@[@"offer",sdp.sdp] forkeys:@[@"type",@"sdp"]];
        //发送offer
        [[SignalClient getInstance]sendMessage:weakMyRoom withMsg:dict];
    });
}
//接收到远端answer
-(void)answer:(NSString*)room message:(NSDictionary*)dict{
     //接收到一个answer的message
     NSString *remoteAnswerSdp =  dict[@"sdp"];
     //生成sdp对象
     RTCSessionDescription *remoteSdp = [[RTCSessionDescription alloc]initWithType:RTCSdpTypeAnswer sdp:remoteAnswerSdp];
     [peerConnection setRemoteDescription:remoteSdp completionHandler:^(NSError *_Nullable error){
          if(!error){
            //设置answer到远端成功
          }else{
            //设置answer到本地成功
          }
     }];
}
//作为远端设置本地answer
-(void)setLocalAnswer:(RTCPeerConnection*)pc withSdp:(RTCSessionDescription*)sdp{
     [pc  setLocalDescription:sdp completionHandler:^(NSError *_Nullable error){
           if(!error){
              //设置answer成功
           }else{
             //设置answer失败
           }
     
     }]

}

//远端接收到offer
-(void)offer:(NSString *)room message:(NSDictionary*)dict{
    NSString *remoteOfferSdp = dict[@"sdp"];
    RTCSessionDescription *remoteSdp = [[RTCSessionDescription alloc]initWithType:RTCSdpTypeOffer sdp:remoteOfferSdp];
    if(!peerConnection){
        peerConnection = [self createPeerConnection];
    }
    __weak RTCPeerConnection *weakPeerConnection = peerConnection;
    //设置到远端offer
    [weakPeerConnection setRemoteDescription:remoteSdp CompletionHandler:^(NSError *_Nullable error){
        if(!error){
            //设置成功拿到answer
           [self getAnswer:weakPeerConnection];
        }else{
            //设置到远端失败
        }
    
    }];
}

-(void)getAnswer:(RTCPeerConnection*)pc{
    //作为远端收到的offer设置到远端成功后创建answer
    [pc answerForConstraints:[self defaultPeerConnContraints]completionHandler:^(RTCSessionDescription * _Nullable sdp,NSError* _Nullable error){
        if(!error){
          __weak RTCPeerConnection *weakPeerConn = pc;
          //创建answer成功后设置本地answer
          [self setLocalAnswer:weakPeerConn withSdp:sdp];
        }else{
            //创建本地answer失败
        }
    }]
}

-(void)offer:(NSString*)room message:(NSDictionary*)dict{
     //接收到offer消息
     NSString *remoteOfferSdp = dict[@"sdp"];
     RTC
}


//主要用于端与端音视频数据的传输
-(RTCPeerConnection  *)createPeerConnection{
    //得到ICEServer，收集穿越后的ip地址，p2p打通，打不通要turn服务中转
    if(!ICEServers){
        ICEServers = [NSMutableArray array];
        [ICEServers addObject:[self defaultSTUNServer]];
    }
    //用工厂来创建连接
    RTCConfiguration *configuration = [[RTCConfiguration alloc]init];
    [configuration setIceServers:ICEServers];//设置iceserver
    //[self defaultPeerConnContraints]限制是否只传音频或视频，是否打开dtls方式加密，这里代理，就回收到候远者，数据的回调，添加流，或信令变化，协商时
    RTCPeerConnection *conn = [factory peerConnectionWithConfiguration:configuration constraints:[self defaultPeerConnContraints]delegate:self];
    NSArray<NSString*>* mediaStreamLabels = @[@"ARDAMS"];
    //协商前把要传的轨加进去
    [conn addTrack:videoTrack streamIds:mediaStreamLabels];
    [conn addTrack:audioTrack streamIds:mediaStreamLabels];
}

- (RTCMediaConstraints*) defaultPeerConnContraints {
    RTCMediaConstraints* mediaConstraints =
    [[RTCMediaConstraints alloc] initWithMandatoryConstraints:@{
                                                                kRTCMediaConstraintsOfferToReceiveAudio:kRTCMediaConstraintsValueTrue,
                                                                kRTCMediaConstraintsOfferToReceiveVideo:kRTCMediaConstraintsValueTrue
                                                                }
                                          optionalConstraints:@{ @"DtlsSrtpKeyAgreement" : @"true" }];
    return mediaConstraints;
}

//每收到候选者都发给另一端进行连通性检测
- (void)peerConnection:(RTCPeerConnection *)peerConnection
didGenerateIceCandidate:(RTCIceCandidate *)candidate{
    NSLog(@"%s",__func__);
    
    NSString* weakMyRoom = myRoom;
    dispatch_async(dispatch_get_main_queue(), ^{
    
        NSDictionary* dict = [[NSDictionary alloc] initWithObjects:@[@"candidate",
                                                                [NSString stringWithFormat:@"%d", candidate.sdpMLineIndex],
                                                                candidate.sdpMid,
                                                                candidate.sdp]
                                                           forKeys:@[@"type", @"label", @"id", @"candidate"]];
    
        [[SignalClient getInstance] sendMessage: weakMyRoom
                                    withMsg:dict];
    });
}
//渲染
- (void)peerConnection:(RTCPeerConnection *)peerConnection
        didAddReceiver:(RTCRtpReceiver *)rtpReceiver
               streams:(NSArray<RTCMediaStream *> *)mediaStreams{
    NSLog(@"%s",__func__);
    //拿到track
    RTCMediaStreamTrack* track = rtpReceiver.track;
    if([track.kind isEqualToString:kRTCMediaStreamTrackKindVideo]){
   
        if(!self.remoteVideoView){
            NSLog(@"error:remoteVideoView have not been created!");
            return;
        }
        
        remoteVideoTrack = (RTCVideoTrack*)track;
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            //内部自动渲染视频
            [remoteVideoTrack addRenderer: self.remoteVideoView];
        //});
        //[remoteVideoTrack setIsEnabled:true];
        
        //[self.view addSubview:self.remoteVideoView];
    }
    
}
@end

SignalClient.m
-(void)createConnect:(NSString*)addr{
    //socket.io服务器地址
	NSURL *url = [[NSUrl alloc] initWithString:@"https://learningrtc.cn"];
	manager = [SocketManager alloc]initWithSocketURL:url
									   config:@{
										   @"log":@YES,
										   @"forcePolling":@YES,
										   @"forceWebsock":@YES
									   }
	socket = manager.defaultSocket;
	[socket connect];
	if(socket.status==SocketIOStatusConnected){//如果建立成功
		[socket emit:@"join" with:@[@"111111"]];//房间名字ID
	}
    //监听消息
	[socket on:@"connect" callback:^(NSArray* data,SocketAckEmitter *ack){
		  NSLog(@"连接成功");
		  	if(socket.status==SocketIOStatusConnected){//如果建立成功
				[self->socket emit:@"join" with:@[@"111111"]];//房间名字ID
			}
	}]
	
	[socket on:@"joined" callback:^(NSArray* data,SocketAckEmitter *ack){
		  NSLog(@"joinde");
		  	NSString *room = [data objectAtIndex:0];
		  	NSString *userid = [data objectAtIndex:1];
		  	[self.delegate joined:room];
	}]

}

}

-(void)sendMessage:(NSString*)room withMsg:(NSDictionary*)msg{
      if(socket.status == SocketIOStatusConnected){
            if(msg){
                NSLog(@"json:%@",msg);
                [socket emit:@"message" with:@[room,msg]];
            }else{
                //msg是空
            }
      }else{
          //socket是断开
      }
}




IOS的远端渲染
RTCPeerConnection 委托

didGenerateIceCandidate:每收集到一个候选者都会收到这个事件
didAddReceiver:收到数据就会回调，相当于ontrack
didOpenDataChannel:非视频数据回调








