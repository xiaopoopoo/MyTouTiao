第二章 组件化 Magic

1. VIP组件化第一课

工具git 9条命令记住就ok了
1.初始化一个代码仓库
	·	git init

2.如果使用GIT，必须给GIT配置用户名和邮箱
给当前的git仓库配置用户名和邮箱
	·	git config user.name “Magic”
	·	git config uer.email “Magic@163.com”
给git配置全局的用户名和邮箱
	·	git config —global user.name “Magic”
	·	git config —global uer.email “Magic@163.com”

3.初始化项目
	·	touch main.m:创建了main.m
	·	git add main.m:将main.m添加到暂缓区
	·	git commit -m “初始化项目”:将在暂缓区的所有内容提交到本地版本库，清空暂缓区
	·	git add .:将工作区所有不在暂缓区的内容添加到暂缓区
注意:添加的文件或者是修改的文件都要通过add命令将该文件添加到暂缓区。

4.查看文件状态
	·	git status
红色：该文件被添加或者被修改，但是没有添加到git得暂缓区
绿色：该文件在暂缓区，但是没有提交到本地版本库

5.给命令行起别名
	·	git config alias.st “status”
	·	git config alias.ci “conmmit -m”
	·	git config —global alias.st “status”

6.删除文件
	·	git rm Perosn.m: 将Person.m删除

7.查看版本信息
	·	git log -> 版本号是由sha1算法生成的40位哈希值
	·	gut reflog:可以查看所有版本回退的操作

8.版本回退
	·	git reset — hard HEAD: 回到当前的版本
	·	git reset — hard HEAD^: 回到上一个版本
	·	git reset — hard HEAD^: 回到上上一个版本

9.给git log起别名
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

工具二 cocoa pod 本地私有库 远程私有库 组件化都需要这个工具


一.git的基本使用
例子：
我需要在本地创建一个代码仓库，然后我们还需要一个远程的代码仓库，然后把两者链接起来，给你的代码打上一个tag，然后删掉

1.我们在远程代码仓库直接克隆到本地然后再打tag
2.本地初始化一个代码仓库，远程代码仓库和它进行链接，最后打tag

1。首先在githup上创建一个远程公有代码仓库，建好以后有三个文件，.gitigonore(忽略文件) license（协议文件） readme.md
2。在本地终端git glone 地址 克隆到本地，实现本地仓库与远程仓库的连接
3。在本地仓库创建一个class文件，touch Person.h Person.m 创建两个类文件
4. clear清楚一下终端命令 git add .  (添加类文件到暂缓区) git commit -m “添加类文件”（将暂缓区内容提交到本地仓库） git push(上传到远程代码仓库)
5。打本地tag   git tag '0.0.1'  查看本地tag  git tag   git push --tags (把本地所有tag推送到远程仓库，在githup上release下就可以看到刚推送的tag，就可以根据tag值点击下载不同tag对应的代码)
6。为了看出tag的好处，再打一个tag，首先修改一下Person类的内容，git add.  git commit -m "修改类文件"  git push  git tag '0.0.2'  git push --tags  一定是把本地仓库代码传到远程仓库以后再打tag
7。不同的tag对应不同的代码版本
8.每次git commit -m “添加类文件”   会产生一个40位的hash值版本号，并提交到master分支， git log 可以查看每次git commit提交后的版本号
9.git tag'0.0.2' 会对应git commit的版本号，所以不同的版本可以通过tag去下载
10。删掉tag '0.0.2'  git tag -d 0.0.2 (删掉本地仓库的tag)  git push origin:0.0.2 (push删除命令，删除掉远程master分支上的tag 0.0.2)

第二种方式关联本地仓库和远程仓库
1。在本地创建一个test1234文件夹，并在选程githup上创建一个代码仓库名叫test1234，在终端中进入test1234文件夹，git init 初始化让test1234成为一个本地代码仓库
2。链接本地仓库与远程仓库 git remote add origin 地址（连接本地和远程仓库）git remote(查看连接好的仓库) origin翻译为起源 这个时候如果git add添加文件会有问题，因为本地仓库没有
.gitigonore(忽略文件) license（协议文件） readme.md 这三个文件，需要git pull origin master 把这三个文件从远程仓库拉下来
3。在本地仓库新建一个classes文件夹，touch cat.h cat.m  git add .   git commit -m “添加类文件”   git push origin master (必须有origin master 如果是第二种方式)
4。git tag '0.0.1'  git push -tags   
5.修改一下类文件然后  git add .(添加所有文件到本地暂缓区)  git commit --m '修改文件'（提交所有文件到本地暂缓区）  git push origin mast （暂缓区文件提交到远程仓库）
  git tag '0.0.2'（打一个本地tag）  git push --tags （把本地tag传到远程仓库）
6。git tag -d 0.0.2(删掉本地tag) git push origin:0.0.2 (push删除命令，删除掉远程master分支上的tag 0.0.2)

.git文件的结构 ，这个文件夹下的内容称为仓库

branches(文件夹)
COMMIT_EDITMSG
config
description
HEAD
hooks（文件夹）
index
info(文件夹)
logs（文件夹）
objects（文件夹）
packed-refs
refs（文件夹）

和.git文件同级别的目录是我们的工作区，这里放我们的代码，git -status 可以看到这些文件是红色。因为没在暂缓区，但作过修改的 ，
绿是表示该文件在暂缓区，也就是add了的文件，但没有commit到本地仓库 

.git文件夹下一级目录是暂缓区，commit的代码都提交到了这里，最后push是提交到远程master分支

cocoapod 使用
任务：Cocoapods基本使用
	
例子：我们新建一个工程，在我们工程当中使用cocoapod安装一个AFN框架

	1.如何安装cocoaPods  http://www.jianshu.com/p/9e4e36ba8574
	2.pod install 和 pod upadate区别
	3.Cocoapods的图解机制

例子：我们创建了一个第三方框架，我们要把它提交到远程索引库，使用pod install的方式安装到我们的工程当中

1。进入工程下的目录 cd /工程文件 pod init 自动会在该目录下生成一个podfile文件
2。打开podfile文件，编写成如下
platform :ios, '9.0'
target 'Test' DO
#pod for Test
end
3. pod search AFN(拷贝出现的代码)
pod 'AFNetworking' , '~3.1.0'
4. pod install
5.pod search AFN  pod install 发生了什么事情
官方的远程索引库：
里面放了框架描述文件，是.spec文件
.spec文件内容：框架命称，版本号，真实的源代码地址，对应的是框架源码

本地也有一个索引库，pod setup ，第一次安装的时候使用这个命令生成的
远程索引库克隆了一份到本地索引库的
pod search AFN 首先在本地索引库搜索afn的检索索引文件中去找afn框架，搜索到的库不会是最新的，因为是之前克隆的索引库
pod install 把远程框架源码集成到项目中
6.查看远程索引库的结构
在githup上搜索cocoapods，找到cocoapods/specs
有一个specs文件夹，打开后会0,1,2,3到f 个文件夹，每个文件夹都有一个时间
7。在本机根目录下，有一个.cocoapods文件夹，打开repos文件夹，是一个master文件夹，master这个打开是会0,1,2,3到f 个文件夹，
其实就是官方的克隆到本地了
8。查看一个检索资源库，在个人／caches/cocoapods/search_index.json 有13mb大小，如果这个文件删掉，当用pod search命令时
会再次自动生成这个文件，个人／caches/cocoapods/pods文件夹下，会发现全是框架源码，是pod install缓存到本地的源码
9。怎么写一个第三方框架，上传到官方cocoapod上
打开githup网站，创建一个远程仓库
在本地创建一个文件夹，名字和远程仓库的一样
把本地和远程仓库连接起来
进入到这个文件夹，git init  初始成为一个本地代码仓库
创建一个classes文件夹，touch car.h car.m
git remote add origin 地址 链接远程仓库
git add.
git commit --m '创建了car类'
git push origin master 本地仓库提交到远程仓库
10。所有框架描述都存在远程索引库中，自己作一个库到cocoapod中
a.完成框架源码的开发
b.需要一个描述文件.spec
c。需要把这个描述文件上传到远程索引库里
11。进到源码同一级目录，pod spec create magic（创建一个spec索引文件，与远程仓库同名），打开spec文件
s.name
s.version
s.summary 简短说明
s.description 具体描述，summary内容不能太长
s.homepage 代码仓库的首页地址，拷贝浏览器上的这个地址复制到这里
s.license 协议把（example）去掉
s.author 自己设置用户名和邮箱
s.source git=>后面是源码地址 tag =>"#{}"(必须有一个tag，对应版本号)
#s.exclude_files ="classes/exclude" 注释掉，先用不上
s.source_files ="classes","classes/**/*.{h,m}" 告诉你要安装哪些代码，这里指点，classes文件夹下所有.h,.m文件，你要别人安装的代码都放到classes文件夹下
12。spec文件准备好了，上传spec文件会有一个校验，一种是远程校验，一种是本地校验，先本地校验会快些，pod lib lint 本地校验命令
13。校验报错了，是因为代码没有提交
git add .
git commit --m "创建了.spec文件"
git push origin master
pod lib lint 校验
14。pod spec lint 用远程校验，会发现一个坑，说没有一个分支
原因是.spec文件没有一个tag
所以必须有一个tag
在本地的.spec文件找开，s.source 下的tag 必须与s.version版本号一致
本地校验不会校验s.source 是否有版本号，源码地址是否正确
15。解决远程校验问题
在终端进入源码，git tag '0.0.1' git push --tags
pod spec lint 重新校验就通过了，这里发现在本地.spec文件打开不用更改s.source_files中的tag
16.校验通过，使用远程索引库得用trunk命令，trunk是cocoapod自动化管理工具
pod trunk register 2501234@QQ.com 'zwhcode' --verbose (需要真实邮箱)你
这里完成会要你去邮箱验证一下真实性，打开邮箱，点击链接，会收到验证成功，现在可以直接上传你的框架索引信息了
pod trunk push magic.podspec 把框架索引信息上传到cocoapod远程索引库
以前使用cocoapods用的淘宝的镜像，现在不能用了，就用另一个镜像
17. pod install pod update 区别
工程会有podfile podfile.lock两个文件，如果podfile.lock文件存在，pod install 就会去
在这个podfile.lock文件中读取信息去安装，如果没有podfile.lock这个文件，就会在podfile文件去找这个库安装，pod install后会有
podfile.lock生成 pod update 不管有无podfile.lock这个文件，都会去podfile中下载框架，然后再更新podfile.lock文件
一般都使用pod install ，版本一致，不会造成一个团队项目混乱
18。每三方框架发布成功了
pod search 框架名，没有找到我们上传的框架，为什么？
因为本地索引库没有更新，同步远和索引库
在githhup上specs可以看到刚上传的文件
更新cocoapod本地索引库
查看一个检索资源库，在个人／caches/cocoapods/search_index.json 有13mb大小，把这个文件删除掉，这个是克隆的老的cocoapod检索文件
pod setup 这时重新安装检索资源库
再pod search 框架命，可以找到我们上传的框架














                          第2章  潭州EV版流   流媒体
                          
                            
一 课程介绍与OpenCV初体验


1  内容一： 课程介绍
    
    第一点： 四个部分组成
       第一部分：shell脚本语言 3节课
       
       第二部分：音视频技术ffmpeg  8节课
       
       第三部分： c++语言面象对象 opencv库是用c++实现的 （3-4节课）
       
       第四部分： opencv开发  MAP矩阵是c++语言  12节课
       
       共26 节课
       
内容二：  OpenCV初体验




2   OpenCV-内容介绍
      
      跨平台处理技术
      
      第一步： 了解什么是OpenCV
      
      1 OpenCV 是跨平台开源框架
      2 c/c++ java python oc  swift(直接可调用c/c++，所以支持) ruby
      3 windows平台 mac平台 ios平台  android平台
      4 开源稳定的图片框架 1999年发布更新到2017年
      5 支持的模块多 机器学习 无人架驶 人脸识别 人脸检测 物体追踪  图象分隔 图象拼接 视频处理
      
      案例：以ios android 举例  码赛克
      
      下载开发包，后面教大家怎么编译这个库导入到项目中，暂时用开发包
      学习shell脚本，才能上手对此库写一些编译脚本，以及改脚本
      
      在官网https://opencv.org/opencv-4-0-0.html 打开news ，找到一个版本，在最下端
      ios pack 为编译好的代码 文件名：OpenCV-4.00-ios-framwork.zip
      sources  为源码 文件名：OpenCV-4.00.zip
      

3   OpenCV-马赛克-原理分析

      马赛克原理：图像由很多像素点组成，这些点组成一个大矩型，马赛克是3*3像素点组成的矩型，这个矩型把图片象素分隔成多个矩型区，并取出每个
      矩型区的左上角起始象素点的颜色，把马赛克矩型区内的象素全替换成这一个颜色。
      

      打开OpenCV源码库大致开一些模块：
          modules - imgcodecs 文件夹包含：
          include文件夹
          src文件夹下：
             ios_conversions.mm  包含ios很多处理转换
             
          modules - core  -src  文件夹包含：
             matrix.cpp  这里面是很多mat矩阵
             
        第二步： 配置环境
           把下载好的opencv.framework导入xcode项目中
           
           创建一个工具类 ImageUtils
           
           ImageUtils.h：  倒入OpenCV框架  核心头文件  对iOS支持  C++命名空间 导入矩阵帮助类（如opencv的rect ）
           
           #import <UIKit/UIKit.h>
			//倒入OpenCV框架
			//核心头文件
			#import <opencv2/opencv.hpp>
			//对iOS支持
			#import <opencv2/imgcodecs/ios.h>
			//导入矩阵帮助类 高级gui绘制类
			#import <opencv2/highgui.hpp>
			#import <opencv2/core/types.hpp>

			//导入C++命名空间
			using namespace cv;

			@interface ImageUtils : NSObject

			//定义方法:处理图片
			+(UIImage*)opencvImage:(UIImage*)image level:(int)level;


			@end
			
			
			
			
			
			ImageUtils.m： 把ios图片转成opencv图片，拿到它的宽高
			#import "ImageUtils.h"   

			@implementation ImageUtils

				+(UIImage*)opencvImage:(UIImage*)image level:(int)level{
					//实现功能
					//第一步：将iOS图片转成OpenCV图片(Mat矩阵就是处理这个)
					Mat mat_image_src;
					UIImageToMat(image, mat_image_src);
		
					//第二步：确定宽高
					int width = mat_image_src.cols;
					int height = mat_image_src.rows;
		
		
		            //码赛克处理
					//图片类型->进行转换
					//在OpenCV里面
					//坑隐藏
					//OPENCV只支持RGB处理 需将ARGB转换成RGB
					//图片ARGB  a代表透明度
					//将ARGB->RGB
					Mat mat_image_dst;//定义了rgb图片
					cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB, 3);//ARGB->RGB 是3个通道 无透明度
		
					//研究OpenCV时候，如何发现巨坑？
					//观察规律
					//看到了OpenCV官方网站->每次进行图像处理时候，规律->每一次都会调用cvtColor保持一致(RGB)
					//所以：每一次你在进行转换的时候，一定要记得转换类型
		
					//为了不影响原始图片，把转换后的opencv克隆一张图片
					Mat mat_image_clone = mat_image_dst.clone();
		
					//第三步：马赛克处理
					//分析马赛克算法原理 一块区域 一块区域处理的
					//level = 3 表示马赛克矩阵为 3 * 3象素点组成的矩形
					//动态的处理 level可以改
					int x = width - level;//x坐标等于图片宽度减去马赛克级别
					int y = height - level;
		
					for (int i = 0; i < y; i += level) { //y坐标以level=3 去移动
						for (int j = 0; j < x; j += level) { //x坐标以level=3 的像素去移动
							//创建一个矩形区域
							Rect2i mosaicRect = Rect2i(j, i, level, level);
				
							//给填Rect2i区域->填充数据->原始数据  给上面的矩形区域填充数据
							Mat roi = mat_image_dst(mosaicRect);//roi为获取到的这块区域
				
				        
							//让整个矩形区域颜色值保持一致 把左上角像素的颜色值填到这个区域
							//mat_image_clone.at<Vec3b>(i, j) 会得到mat_image_clone这张图片中每一个矩型开始的像素点 <Vec3b>是存颜色值的集合
							//像素点由多个颜色值组成如由ARGB颜色值组成，ARGB是存储到数组中的，
							//所以mat_image_clone.at<Vec3b>(i, j)返回的是颜条值数组
							//mat_image_clone.at<Vec3b>(i, j)->像素点（颜色值组成->多个）->ARGB->数组
							//mat_image_clone.at<Vec3b>(i, j)[0]->R值
							//mat_image_clone.at<Vec3b>(i, j)[1]->G值
							//mat_image_clone.at<Vec3b>(i, j)[2]->B值
							
							//存放了颜色
							Scalar scalar = Scalar(
								   mat_image_clone.at<Vec3b>(i, j)[0],
								   mat_image_clone.at<Vec3b>(i, j)[1],
								   mat_image_clone.at<Vec3b>(i, j)[2]);
				
							//把矩形区域（被马赛克分隔的图片区域）上第一个像素点的颜色值数组，数组中里面包含所有颜色值，拷贝到这个马赛克矩型区域上
							//CV_8UC3：代表它是32位相素 是无符号类型0-255颜色值 有rgb 3个通道
							//CV_8UC3解释一下->后面也会讲到
							//CV_:表示框架命名空间
							//8表示：32位色->ARGB->A 8位 R 8位 G 8位 B 8位 = 1字节 -> 4个字节
							//U分析
							//两种类型：有符号类型(Sign->有正负数->简写"S")、无符号类型(Unsign->正数->"U")
							//无符号类型：颜色值 0-255(通常情况)
							//有符号类型：颜色值 -128-127
							//C分析：char类型
							//3表示：3个通道->RGB
							
							//mosaicRect.size() 矩型区域的大小  CV_8UC3上面注解中有讲到
							Mat roiCopy = Mat(mosaicRect.size(), CV_8UC3, scalar);//获取到马塞克的分隔矩型区，这个区域已经存放了颜色
							roiCopy.copyTo(roi);//把这块马赛克拷贝到分隔的roi原始图片上
						}
					}
		
					//第四步：将OpenCV图片->iOS图片
					return MatToUIImage(mat_image_dst);
				}
	
			@end
			
			
			
			
			ViewController.mm ： //c++混合编程需修改为.mm
			#import "ViewController.h"
			#import "ImageUtils.h"

			@interface ViewController ()
			@property (weak, nonatomic) IBOutlet UIImageView *imageView;

			@end

			@implementation ViewController

			- (void)viewDidLoad {
				[super viewDidLoad];
			}

			//正常图片
			- (IBAction)clickNormal:(id)sender {
				_imageView.image = [UIImage imageNamed:@"Test.jpeg"];
			}

			//马赛克图片
			- (IBAction)clickMosaic:(id)sender {
				_imageView.image = [ImageUtils opencvImage:_imageView.image level:20];
			}

			- (void)didReceiveMemoryWarning {
				[super didReceiveMemoryWarning];
			}


			@end
      
       
                            
            

4  OpenCV-马赛克-Android平台实现

   android底层开发 ndk技术（底层代码搞明白 上层java代码不需要关心）
   android studio开发 ndk技术
   
  第一步:  android studio 新建一个项目
   选中 include c++ support 支持c++
   下一步 下一步 最后完成的时候 customiz c++ support界面 勾上 exception support(异常捕获) | runtime type infomation support
   在maniactivity中提示改版本号 ，把minsdkversion 改为14版本
   
  第二步： 配置opencv的开发环境
    1。导入.so动态库，类似ios的库
      在src / main / 创建jniLibs目录，放入armeabi库
      
      
      
      
      
5  Shell脚本语言-第1讲 http://c.biancheng.net/view/810.html

shell介绍：访问linux系统操作内核的时候，shell语言是一个中间件。
开发者操作shell，shell再去操作系统内核的服务。
shell语言作的事情：
android动态库编译 .so文件
ios里面静态库编译  .a文件
学习的目的：掌握基本shell使用-》修改和应用shell

什么是shell？
它是一种脚本语言，用的最多的是编译库

shell的环境？
mac支持shell开发的。
shell的种类？
种类非常多，种类：bash、c Shell、K Shell等等...最广泛的种类是bash，是所有操作系统默认的脚本语言，免费易用
所以不需要再安装

02-Shell脚本语言-第一个HelloWorld程序

查看修改删子人禾立linux的文件，需要权限，首先按使用者分：
User  文件拥有者：
        linux是多用户操作系统，允许多人操作一台电脑，如果我的文件不希望被其它人查看，可以设置为我是文件的拥有者
Group  群组概念：  
         组1有a,b,c三个成员，组2有d,e,f三个成员，a的某些资料各以让b,c查看，某些不能，因为在一个组的。
         更形象的例子：李家有三兄弟，客厅是共用的，三个房间则是三兄弟私有的，每个兄弟就是文件拥有者，李家是一个群组，客厅共用
Others 其他人的概念：
        李家有三兄弟，张家有两兄弟，张家兄弟要去李家，必须张家兄弟认识李家兄弟，张家兄弟则为其它人
        其他人就是组外的有可能通过某些关系能访问该文件的人
root：   
        像天神一样，无论是组，还是个人的文件隐私都能访问
        
不同的使用者帐号保存在哪里的？
不要随意删除下面几个文件：
Others User root 相关信息保存在/etc/passwd文件内
User个人的密码则是记录在/etc/shadow这个文件下
群组名称都纪录在/etc/group内

查看文件权限：
以snrifk身份登陆，查看需使用su - （切换成root用户）
ls -al 表示列出所有的文件详细的权限与属性 （包含隐藏
文件，就是文件名第一个字符为“ . ”的文件）

表示的符号：
[ r ]代表可读（read）、[ w ]代表可写
（write）、[ x ]代表可执行（execute）。 要注意的是，这三个权限的位置不会改变，如果没有权限，就会出现减号[ - ]而
已。

分析ls -al的输出：
-rw-r--r--  5    root   root    4096    May 29 16:08
(第一栏)  （二栏） (三栏) （四栏）  （五栏）   (六栏)

第一栏第一个字符：代表这个文件是“目录、文件或链接文件等等”
当为[ d ]则是目录，例如上表文件名为“.config”的那一行；
当为[ - ]则是文件，例如上表文件名为“initial-setup-ks.cfg”那一行；
若是[ l ]则表示为链接文件（link file）；
若是[ b ]则表示为设备文件里面的可供储存的周边设备（可随机存取设备）；
若是[ c ]则表示为设备文件里面的序列埠设备，例如键盘、鼠标（一次性读取设备）。

第一栏后面的字符：文件拥有者可具备的权限

第二栏：示有多少文件名链接到此节点（i-node）

第三栏：加入此群组之帐号的权限”

第四栏：“非本人且没有加入本群组之其他帐号的权限

第五栏：文件的大小

第六栏： 这个文件的创建日期或者是最近的修改日期：
        如果这个文件被修改的时间距离现在太久了，那么时间部分会仅显示年份
        “ls -l --full-time”就能够显示出完整的时间格式了




1、第一个Shell程序？
			1.1 创建Shell文件
				命令：touch hello.sh
			1.2 编写Shell程序
				定义文件声明
				#!/bin/bash
				echo "Hello world!"	

				#!：表示约定标记，他会告诉系统这个脚本需要什么样子的解释器来执行，既是一种脚本体现。
				echo：表示命令用于输出文本信息	
				
			1.3.2 查看每一个部分权限
					查看文件权限		
					命令：ls -l hello.sh
						-rw-r--r--
			1.3.3 修改文件权限（为文件添加user,group,others的执行权限）
					命令： chmod +x ./hello.sh
						-rwxr-xr-x

			1.4 执行Shell脚本文件
				命令：./hello.sh


03-Shell脚本语言-语法-注释

”#“ 表示注释
	例如：
				脚本代码
					#!/bin/bash
					# 输出了Hello world!
					echo "Hello world!"
			注意：在Shell脚本中，没有多行注视，只有单行注释


04-Shell脚本语言-语法-变量-注意事项
变量分为多种类型
变量定义： 
注意一：定义变量时候，变量名称不需要加"$"符号 
   $name 表示取变量的值  name="123" 变量的定义
注意二：变量名和等号不能够有空格
注意三：变量名首字母必需是字母加下划线（a到z、A到Z）
   _name="123" 可以 __name="123" 可以  name="123"可以
注意四：变量名中间不允许有空格	
注意五：不允许使用标点符号



05-Shell脚本语言-语法-变量-只读变量
3.2 只读变量  类似于常量
				关键字：readonly（只读，不能够修改）
				脚本代码
					name="HelloApp"
					readonly name
					#./hello.sh: line 35: name: readonly variable
					name="smile2017"
					echo "执行了"



06-Shell脚本语言-语法-变量-删除变量
	3.3 删除变量？
				语法：unset（干掉了）
				案例：unset 变量名
				
				name="HelloApp"
				echo $name
				unset name
				echo $name
				
				
07-Shell脚本语言-语法-变量-变量类型


	
变量名外面的花括号{ }：
	花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面这种情况：
	skill="Java"
	echo "I am good at ${skill}Script"
	
将命令的结果赋值给变量：
	第一种方式把命令用反引号包围起来，反引号和单引号非常相似，容易产生混淆，所以不推荐使用：
	variable=`command`
	第二种方式把命令用$()包围起来，区分更加明显，所以推荐使用这种方式。
	variable=$(command)
	例如：cat 命令将 log.txt 的内容读取出来，并赋值给一个变量，然后使用 echo 命令输出。
	[mozhiyan@localhost code]$ log=$(cat log.txt)
	[mozhiyan@localhost code]$ echo $log
	[2017-09-10 06:53:22] 严长生正在编写Shell教程
	[mozhiyan@localhost code]$ log=`cat log.txt`
	[mozhiyan@localhost code]$ echo $log
	[2017-09-10 06:53:22] 严长生正在编写Shell教程

3.4 变量类型
				3.4.1 类型一：本地变量（全局变量)作用域是运行脚本的shell进程的生命周期
					语法：name="Dream"
					function ace()[
					    a="hello"//全局变量，没用local定义
					 ]
				3.4.2 类型二：局部变量 作用域是函数的生命周期；在函数结束时被自动销毁
					作用域：当前代码段（修饰符：local）
					local name="Andy"
					 function ace()[
					   local a="hello"//局部变量，用local定义
					 ]
					 echo a//外部不能访问
					 
				3.4.3 类型三：环境变量
					作用域：所有的程序如qq程序启动，包括shell启动的程序，都能访问环境变量
					      ，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
					语法：export name="Dream"
					环境变量分三种：
					   1：对所有用户生效的永久性变量（系统级）：
					      这类变量对系统内的所有用户都生效，所有用户都可以使用这类变量。作用范围是整个系统
					      设置方式：
					        1.vim打开/etc/profile文件，profile只能在root环境打开
					        2.文件中写入export name="Dream"
					        3.保存文件，使配置文件生效：source /etc/profile
					        4.使用 echo name
					   2: 对单一用户生效的永久性变量（用户级）
					      用户A设置了此类环境变量，这个环境变量只有A可以使用。而对于其他的B,C,D,E….用户这个变量是不存在的
					      设置方式：在用户主目录”~”下的隐藏文件 “.bashrc”中添加自己想要的环境变量
					        1：首先切目录：cd ~    然后查看：echo .* 
					        2：系统中可能存在两个文件，.bashrc和.bash_profile（有些系统中只有其中一个），这两个文件任意一个里面添加都是可以的。
					        3：bash_profile文件只会在用户登录的时候读取一次  .bashrc在每次打开终端进行一次新的会话时都会读取
					        4：利用vim打开.bashrc文件中写入export name="Dream"
					        5：保存文件，使配置文件生效：source /etc/profile
					        6：使用 echo name
					   3：临时有效的环境变量（只对当前shell有效）
					       当我们退出登录或者关闭终端再重新打开时，这个环境变量就会消失。是临时的
					       在shell命令窗口中：
					       	[mozhiyan@localhost code]$ export name="Dream"
	                        [mozhiyan@localhost code]$ echo $name
	                        
	                设置环境变量常用的几个指令：
	                   1：echo 变量使用时要加上符号“$”例：echo $PATH
	                   2：export 设置新的环境变量 export 新环境变量名=内容 
                          例:export MYNAME=”LLZZ”
                       3：修改环境变量 例：MYNAME=”ZZLL”
                       4：env   查看所有环境变量
                       5：set 查看本地定义的所有shell变量
                       6：删除一个环境变量  例 unset MYNAME
                       7：readonly 设置只读环境变量。 
                          例：readonly MYNAME  
                    
                    常用的几个环境变量：
                       1：PATH 让我们运行程序或指令更加方便
                       例：
                         通过gcc编译生成的可执行文件a.out
                         访问：./a.out 或 /home/lzk/test/a.out 
                         如何更简单访问如：a.out 
                         设置：export PATH=$PATH:路径 （（PATH中路径是通过冒号“:”进行分隔的）
                              PATH="$PATH":/home/lzk/test/a.out:/home/lzk/test/b.out
                       2：HOME 指定用户的主工作目录，即为用户登录到Linux系统中时的默认目录，即“~”
                       3: HISTSIZE 指保存历史命令记录的条数。我们输入的指令都会被系统保存下来，这个环境变量记录的就是保持指令的条数。一般为1000
                           历史指令都被保存在用户工作主目录“~”下的隐藏文件.bash_profile中 我们可以通过指令history来查看。
                       4: LOGNAME 指当前用户的登录名
                       5: HOSTNAME  指主机的名称
                       6: SHELL 指当前用户用的是哪种shell
                       7: LANG/LANGUGE 和语言相关的环境变量，使用多种语言的用户可以修改此环境变量
                       8: MAIL 指当前用户的邮件存放目录
                       9:  PS1 第一级Shell命令提示符，root用户是#，普通用户是$
                       10: PS2 第二级命令提示符，默认是“>”
                       11: PS3 第三级命令提示符。主要用于select循环控制结构的菜单选择提示符 ：【等待一个链接】
                       12: 用户和系统交互过程的超时值。
                           系统提示让用户进行输入，但用户迟迟没有输入，时间超过TMOUT设定的值后，shell将会因超时而终止执行。
	                
					   
				3.4.4 类型四：位置变量  给脚本文件传参 区分变量${name} ${age}
					脚本代码
						#!/bin/bash
						#文件名称
						filename=${0}
						#参数一
						name=${1}
						#参数二
						age=${2}
						#参数三
						sex=${3}
						echo "文件名称：${filename}"
						echo "姓名：${name}   年龄：${age}  性别：${sex} "
					执行脚本
						./hello.sh Jeff 150 男
					执行结果	
					    文件名称：./hello.sh
					    姓名：Jeff   年龄： 150  性别：男	
						${0}表示脚本文件名称
						参数从1开始
				3.4.5 特殊变量
				        ${0}:文件名称
				        ${?}:表示命令执行状态返回值
				             0：表示执行成功
						     1：程序执行结果
						     2：表示程序状态返回码（0-255）
							    系统预留错误（1、2、127）
						$#:参数个数
						$*:参数列表
						   #!/bin/bash
							echo ${*}
                           执行：./hello.sh Andy 200 男
                           结果："Andy 200 男" 参数组成一个字符串

					    $@:参数列表
					       #!/bin/bash
							echo ${@}
                           执行：./hello.sh Andy 200 男
                           结果："Andy" 200 "男"  每个参数都是分开的

					    $$:后去当前shell进行ID

					    $!:执行上一个指令PID
					    
08-Shell脚本语言-语法-字符串-上
    
		4.2 .单引号和双引号的区别：
			#!/bin/bash
			url="http://c.biancheng.net"
			website1='C语言中文网：${url}'
			website2="C语言中文网：${url}"
			echo $website1
			echo $website2

			运行结果：
			C语言中文网：${url}
			C语言中文网：http://c.biancheng.net

			以单引号' '包围变量的值时，单引号里面是什么就输出什么
			以双引号" "包围变量的值时，输出时会先解析里面的变量和命令，
			而不是把双引号中的变量名和命令原样输出
		4.3 字符串->拼接
					方式一：
						脚本代码
							#!/bin/bash
							name="Andy"
							age=100
							sex="男"
							info="${name} ${age} ${sex}"
							echo ${info}
							
				
						脚本结果："Andy 100 男"
					方式二
						脚本代码
							#!/bin/bash
							name="Andy"
							age=100
							sex="男"
							info=" 姓名："${name}"   年龄："${age}"  性别："${sex}"  "
							echo ${info}
			4.4 字符串->获取字符串长度
				语法结构：${#变量名}  区别：${name}获取name值 ${#name}获取长度，里面多了一个#
				脚本代码
					#!/bin/bash
					name="Andy"
					echo ${#name}
				脚本结果：4
				
			4.5 字符串->截取
				1：语法：${变量名:开始位置:截取长度}  区别：${name}获取name值  ${name:2:3}多了两个冒号
				脚本代码
						#!/bin/bash
						name="I have a Dream"
				案例一：从字符串第3个开始截取，截取3个
					name="I have a Dream"
					result=${name:2:3}
					echo ${result}
				案例二：从字符串第5个开始截取，到最后一个结束
					方式一
						name="I have a Dream"
						length=${#name}
						result=${name:5:length-1}
						echo ${result}
					方式二
						name="I have a Dream"
						result=${name:5}
						echo ${result}
			   2： # 号截取，删除左边字符，保留右边字符
				   var=http://www.aaa.com/123.htm
				   echo ${var#*//}
				   结果是 ：www.aaa.com/123.htm
				   其中 var 是变量名，# 号是运算符，*// 表示从左边开始删除第一个 // 号及左边的所有字符

               3： ## 号截取，删除左边字符，保留右边字符
                   var=http://www.aaa.com/123.htm
                   echo ${var##*/}
                   结果是 123.htm
                   ##*/ 表示从右边/开始包括/ 从右到左删除 保留右边
               4： %号截取，删除右边字符，保留左边字符
                   var=http://www.aaa.com/123.htm
                   echo ${var%/*}
                   结果是：http://www.aaa.com
                   %/* 表示删除掉最右边/ 包括/ 后面的所有内容
               5： 从左边第几个字符开始，一直到结束
                   var=http://www.aaa.com/123.htm
                   echo ${var:7}
                   结果是 ：www.aaa.com/123.htm
                   其中的 7 表示左边第8个字符开始，一直到结束
               6：  从右边第几个字符开始，及字符的个数
                    var=http://www.aaa.com/123.htm
                    echo ${var:0-7:3}
                    结果是：123
                    0-7 表示从右到左0开始数到7，不包括第7个的字符
                    3 表示向后截取3个
                    注：（左边的第一个字符是用 0 表示，右边的第一个字符用 0-1 表示）
               8：  从右边第几个字符开始，一直到结束
                    var=http://www.aaa.com/123.htm
                    echo ${var:0-7}
                    结果是：123.htm
                    0-7 表示从右到左0开始数到7，不包括第7个的字符，向后截取所有字符
                    注：（左边的第一个字符是用 0 表示，右边的第一个字符用 0-1 表示）
               9：  ${变量名%%删除字符串 正则表达式}
					案例一：从左到右查找第一个字符，并且删除它后面所有的字符（包含自己）
						name="I have a Dream"
						result=${name%%a*}
						echo ${result}
                    结果是：I h
               10:  指定删除范围 从右到左，查找第一个字符a，包含a，到D,删除前面所有内容
						name="I have a Dream"
						result=${name%a*D}
						echo ${result}
                    结果是：I have a Dream
                11: 只匹配字符串结尾，成功则删除匹配的字符串
					案例一：查找第一个字符（匹配第一个）
						代码一：
							name="I have a Dream"
							result=${name%a}
							echo ${result}
							结果是：I have a Dream
						代码二：
							name="I have a Dream"
							result=${name%m}
							echo ${result}
							结果是：I have a Drea


              总结：
					从左边删除到右边
						#->表示查询方向从左到右
						##->表示查询方向从右到左
					从右边删除到左边
						%->表示查询方向从右到左
						%%->表示查询方向从左到右




6 20171027-第3次课-Shell脚本语言-第2讲

01-Shell语言-echo命令
    1.显示普通字符的两种方式：
        echo "It is a test"
        引号完全可以省略：echo It is a test
    2.显示转义字符
    echo "\"It is a test\""
    echo  \"It is a test\"
    结果："It is a test"
    3.显示变量
    read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
    #!/bin/sh
	read name 
	echo "$name It is a test"
	使用：
	以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:
	[root@www ~]# sh test.sh
	OK                     #标准输入
	OK It is a test        #输出
	4.显示换行
	echo -e "OK! \n" # -e 开启\n等字符转义
	echo "It is a test"
	输出结果：
	OK!
	It is a test
	5.显示不换行
	#!/bin/sh
	echo -e "OK! \c" # -e 开启转义 \c 不换行
	echo "It is a test"
	输出结果：OK! It is a test
	6.显示结果定向至文件
	echo "It is a test" > myfile
	7.原样输出字符串，不进行转义或取变量(用单引号)
	echo '$name\"'
	输出结果：name\"
	8.显示命令执行结果 注意： 这里使用的是反引号 `, 而不是单引号 '。
	echo `date`
	结果将显示当前日期：Thu Jul 24 10:08:46 CST 2014
	
   shell的退出命令：
   exit 是一个 Shell 内置命令，用来退出当前 Shell 进程，并返回一个退出状态；
   使用$?可以接收这个退出状态
   exit 命令可以跟一个退出的整形参数
   exit 退出状态只能是一个介于 0~255 之间的整数，其中只有 0 表示成功，其它值都表示失败
   
   例：命名为 test.sh：
	#!/bin/bash
	echo "befor exit"
	exit 8
	echo "after exit"
	执行：
	[mozhiyan@localhost demo]$ chmod +x ./test.sh
	[mozhiyan@localhost demo]$ ./test.sh
	befor exit
	分析："after exit"并没有输出，这说明遇到 exit 命令后，test.sh 执行就结束了。
	
   使用$?来获取 test.sh 的退出状态:
   [mozhiyan@localhost demo]$ echo $?
    8
    
    
    02-Shell语言-数组  http://c.biancheng.net/view/810.html
    
    数组：Shell 也支持数组。数组（Array）是若干数据的集合，其中的每一份数据都称为元素（Element）。
    Shell 并且没有限制数组的大小
    数组元素的下标也是从 0 开始
    获取数组中的元素要使用下标[ ]，下标可以是一个整数，也可以是一个结果为整数的表达式；当然，下标必须大于等于 0
    常用的 Bash Shell 只支持一维数组，不支持多维数组。
    
    Shell 数组的定义：
    在 Shell 中，用括号( )来表示数组，数组元素之间用空格来分隔
    nums=(29 100 13 8 91 44) 赋值号=两边不能有空格
    
    Shell 是弱类型的，并不要求所有数组元素的类型必须相同
    arr=(20 56 "http://c.biancheng.net/shell/")
    
    Shell 数组的长度不是固定的，可以增加元素，从而扩展长度
    nums[6]=88
    
    无需逐个元素地给数组赋值
    ages=([3]=24 [5]=19 [10]=12)
    只给第 3、5、10 个元素赋值，所以数组长度是 3。
    
    获取数组元素：
    ${array_name[index]}
    array_name 是数组名，index 是下标。例如：
    n=${nums[2]}  echo ${nums[3]}
    
    使用@或*可以获取数组中的所有元素
    ${nums[*]}
	${nums[@]}
	
	例：
	#!/bin/bash

	nums=(29 100 13 8 91 44)
	echo ${nums[@]}  #输出所有数组元素
	nums[10]=66  #给第10个元素赋值（此时会增加数组长度）
	echo ${nums[*]}  #输出所有数组元素
	echo ${nums[4]}  #输出第4个元素
	
	运行结果：
	29 100 13 8 91 44
	29 100 13 8 91 44 66
	91
	
	Shell获取数组长度两种方式：
	${#array_name[@]}
	${#array_name[*]}
	原理，${array_name[@]}是数据所有元素，再多个#号就能显示数组个数
	
	获取某个字符串元素的长度，如下所示：
	${#arr[2]}
	
	回忆字符串长度的获取
	回想一下 Shell 是如何获取字符串长度的呢？其实和获取数组长度如出一辙，它的格式如下：
	${#string_name} 
	string_name 是字符串名。
	
	删除数组元素
	unset nums[1]
	
	实例演示

	下面我们通过实际代码来演示一下如何获取数组长度。
	#!/bin/bash

	nums=(29 100 13)
	echo ${#nums[*]}

	#向数组中添加元素
	nums[10]="http://c.biancheng.net/shell/"
	echo ${#nums[@]}
	echo ${#nums[10]}

	#删除数组元素
	unset nums[1]
	echo ${#nums[*]}
	运行结果：
	3
	4
	29
	3
	
	
	Shell数组拼接或Shell数组合并：
		所谓 Shell 数组拼接（数组合并），就是将两个数组连接成一个数组。
		思路：拼接数组的思路是：先利用@或*，将数组扩展成列表，然后再合并到一起
		两种方式：
		array_new=(${array1[@]}  ${array2[@]})
		array_new=(${array1[*]}  ${array2[*]})
		下面是完整的演示代码：
		#!/bin/bash

		array1=(23 56)
		array2=(99 "http://c.biancheng.net/shell/")
		array_new=(${array1[@]} ${array2[*]})

		echo ${array_new[@]}  #也可以写作 ${array_new[*]}
		运行结果：
		23 56 99 http://c.biancheng.net/shell/
	
	Shell删除数组元素（也可以删除整个数组）：
		unset 关键字来删除数组元素：unset array_name[index]
		删除整个数组不写下标：unset array_name
	
		下面我们通过具体的代码来演示：
		格式化复制
		#!/bin/bash

		arr=(23 56 99 "http://c.biancheng.net/shell/")
		unset arr[1]
		echo ${arr[@]}

		unset arr
		echo ${arr[*]}
		运行结果：
		23 99 http://c.biancheng.net/shell/
		
		
	Shell关联数组，下标可以使用字符串，更容易理解
		现在最新的 Bash Shell 已经支持关联数组了。关联数组使用字符串作为下标，而不是整数
		“键值对（key-value）”数组，键（key）也即字符串形式的数组下标，值（value）也即元素值。
		例如，我们可以创建一个叫做 color 的关联数组，并用颜色名字作为下标。
			方式1：
			declare -A color   //-A是数组，把color看作一个数组
			color["red"]="#ff0000"
			color["green"]="#00ff00"
			color["blue"]="#0000ff"
			方式2:
			declare -A color=(["red"]="#ff0000", ["green"]="#00ff00", ["blue"]="#0000ff")
			关联数组必须使用带有-A选项的 declare 命令创建
			
	访问关联数组元素:
	array_name["index"]
	例：color["white"]="#ffffff"
	
	获取数组元素的值：
	加上$()即可：echo $(color["white"])
	
	
	获取所有元素的值
	${array_name[@]}
	${array_name[*]}
	
	获取关联数组的所有下标值：
	${!array_name[@]}
	${!array_name[*]}
	
	获取关联数组长度
	${#array_name[*]}
	${#array_name[@]}
	
	
	关联数组实例演示：
		#!/bin/bash

		declare -A color
		color["red"]="#ff0000"
		color["green"]="#00ff00"
		color["blue"]="#0000ff"
		color["white"]="#ffffff"
		color["black"]="#000000"

		#获取所有元素值
		for value in ${color[*]}
		do
			echo $value
		done
		echo "****************"

		#获取所有元素下标（键）
		for key in ${!color[*]}
		do
			echo $key
		done
		echo "****************"

		#列出所有键值对
		for key in ${!color[@]}
		do
			echo "${key} -> ${color[$key]}"
		done
		运行结果：
		#ff0000
		#0000ff
		#ffffff
		#000000
		#00ff00
		****************
		red
		blue
		white
		black
		green
		****************
		red -> #ff0000
		blue -> #0000ff
		white -> #ffffff
		black -> #000000
		green -> #00ff00
	
	
03-Shell语言-参数传递
      1、语法定义？
		./文件名称.sh 参数1 参数2 参数3...
		2、案例
			脚本内容如下：
				#${0}->表示文件名称
				#${1}->表示参数1
				#${2}->表示参数2
			代码内容：echo ${0} ${1}  ${2}
			
			执行脚本代码：
				./hello.sh "逗你玩" "饿到爆"
	  2、 参数个数 $#
	      	脚本内容如下：
				echo ${#}	
			执行脚本代码：
				./hello.sh "逗你玩" "饿到爆"
			执行脚本结果：2
      3、 显示输入的所有参数
            脚本内容如下：
				echo ${*}	
			执行脚本代码：
				./hello.sh "逗你玩" "饿到爆"
			执行脚本结果："逗你玩" "饿到爆"

04-Shell语言-基本运算符-算术运算符
     Shell 不能直接进行算数运算，必须使用数学计算命令：
     命令：
		 (( ))	用于整数运算，效率很高，推荐使用。
		let	    用于整数运算，和 (()) 类似。
		$[]  	用于整数运算，不如 (()) 灵活。
		expr	可用于整数运算，也可以处理字符串。比较麻烦，需要注意各种细节，不推荐使用。
		bc	    Linux下的一个计算器程序，可以处理整数和小数。Shell 本身只支持整数运算，
		        想计算小数就得使用 bc 这个外部的计算器。
		declare -i	将变量定义为整数，然后再进行数学运算时就不会被当做字符串了。功能有限，
		            仅支持最基本的数学运算（加减乘除和取余），不支持逻辑运算、自增自减等，所以在实际开发中很少使用。
	 1、算数运算符
	   "+"运算
			#注意："expr"规定命令
			a=8388
			b=9688
			c= `expr $a + $b`   //expr 和反引号结合
			echo "c的值：$c"
			
		
	    "*"运算
		#注意："expr"规定命令
		a=8388
		b=9688
		c=`expr $a \* $b`  //expr 和反引号结合 和转义字符\
		echo "c的值：$c"
		
		
		 "/"运算
		#注意："expr"规定命令
		a=8388
		b=9688
		c=`expr $a / $b`
		echo "c的值：$c"

		"%"运算
			#注意："expr"规定命令
			a=8388
			b=9688
			c=`expr $a % $b`
			echo "c的值：$c"
			
		"="运算
		#注意："expr"规定命令
		a=8388
		b=$a
		echo "b的值：$b"
		
		
	    "=="运算
		#注意："expr"规定命令
		a=8388
		b=9688
		if [ $a == $b ]
		then
			echo "a等于b"
		else
			echo "a不等于b"
		
		fi //结束if
		
		
		2、关系运算符  等于 不等于 大于 小于 大于等于 小于等于
		2.1 "-eq"：检测两个数是否相等，当等返回true
			a=100
			b=200
			if [ $a -eq $b ]
			then
				echo "a等于b"
			else
				echo "a不等于b"
			fi

		2.2 "-ne"：检测两个数是否相等，不相等返回true
			a=100
			b=200
			if [ $a -ne $b ]
			then
				echo "a不等于b"
			else
				echo "a等于b"
			fi

		2.3 "-gt"：检测左边数是否大于右边数，如果是，返回true
			a=100
			b=200
			if [ $a -gt $b ]
			then
				echo "a大于b"
			else
				echo "a小于b"
			fi

		2.4 "-lt"：检测左边数是否小于右边数，如果是，返回true
			a=100
			b=200
			if [ $a -lt $b ]
			then
				echo "a小于b"
			else
				echo "a大于b"
			fi

		2.5 "-ge"：检测左边数是否(大于+等于)右边数，如果是，返回true
			a=100
			b=200
			if [ $a -ge $b ]
			then
				echo "a大于等于b"
			else
				echo "a小于b"
			fi

		2.6 "-le"：检测左边数是否(小于+等于)右边数，如果是，返回true
			a=100
			b=200
			if [ $a -le $b ]
			then
				echo "a小于等于b"
			else
				echo "a大于b"
			fi

		
		05-Shell语言-基本运算符-布尔运算符
		
		3、布尔值运算符 与 或 非
		3.1 "!"：非运算，表达式为true，返回true，否则返回false
			a=100
			b=200
			if [ $a != $b ]
			then
				echo "a不等于b"
			fi

		3.2 "-o"：或运算，有一个表达式为true，则返回true
			a=100
			b=200
			if [ $a -lt 200 -o $b -gt 200 ]
			then
				echo "成立"
			fi

		3.3 "-a"：与运算，两个表达式为true，则返回true
			a=100
			b=200
			if [ $a -lt 200 -a $b -gt 200 ]
			then
				echo "成立"
			else
				echo "不成立"
			fi

		06-Shell语言-基本运算符-逻辑运算符
		
			4.1 "&&"：逻辑且->and
			a=100
			b=200
			if [ $a -lt 200 ] && [ $b -gt 200 ]
			then
				echo "成立"
			else
				echo "不成立"
			fi	

			4.2 "||"：逻辑 OR
				a=100
				b=200
				if [ $a -lt 200 ] || [ $b -gt 200 ]
				then
					echo "成立"
				else
					echo "不成立"
				fi


		07-Shell语言-基本运算符-字符串运算符
        
        5、字符串运算 检测字符串是否相同 不同 是否为空 长度是否为0
			5.1 "="：检测两个字符串是否相等，如果相等返回true
				a="JAR"
				b="逗你玩"
				if [ $a = $b ]
				then
					echo "字符串a等于字符串b"
				else
					echo "字符串a不等于字符串b"
				fi

			5.2 "!="：检测两个字符串是否相等，如果不相等返回true
				a="JAR"
				b="逗你玩"
				if [ $a != $b ]
				then
					echo "字符串a不等于字符串b"
				else
					echo "字符串a等于字符串b"
				fi
	
			5.3 "-z"：检测字符串长度是否为0，如果是返回true
				a="JAR"
				if [ -z $a ]
				then
					echo "a不为空，存在"
				else
					echo "a不存在值"
				fi

			5.4 "-n"：检测字符串长度是否为0，如果不是0，返回true
				a="JAR"
				if [ -n "$a" ]
				then
					echo "a存在"
				else
					echo "a不存在值"
				fi

			5.5 "字符串"：检测字符串是否为空，不为空返回true
				a="JAR"
				if [ $a ]
				then
					echo "a不为空"
				else
					echo "a为空"
				fi
				
				
		08-Shell语言-基本运算符-文件测试运算符  检测文件是否在该目录下 是否可读 可写 可执行 是否只是普通文件，不是目录 是否为空 是否存在
		    file="/Users/yangshaohong/Desktop/test.sh"

			6.1 "-d file"：检测文件是不是一个目录，如果是，那么返回true
				if [ -d $file ]
				then 
					echo "是一个目录"
				else
					echo "不是一个目录"
				fi

			6.2 "-r file"：检测文件是否可读，如果是，那么返回true
				if [ -r $file ]
				then 
					echo "可读"
				else
					echo "不可读"
				fi

			6.3 "-w file"：检测文件是否可写，如果是，那么返回true
				if [ -w $file ]
				then 
					echo "可写"
				else
					echo "不可写"
				fi

			6.4 "-x file"：检测文件是否是可执行文件，如果是，那么返回true
				if [ -x $file ]
				then 
					echo "可执行"
				else
					echo "不可执行"
				fi

			6.5 "-f file"：检测文件是否是一个普通文件（既不是目录，也不是设备文件），如果是，那么返回true
				if [ -f $file ]
				then 
					echo "文件为普通文件"
				else
					echo "文件为特殊文件"
				fi

			6.6 "-s file"：检测文件是否为空（文件有内容），如果是，那么返回true
				if [ -s $file ]
				then 
					echo "文件有内容"
				else
					echo "文件没有内容"
				fi

			6.7 "-e file"：检测文件是否存在（包含了：目录和文件），如果是，那么返回true
				if [ -e $file ]
				then 
					echo "存在"
				else
					echo "不存在"
				fi
		
		
		09-Shell语言-流程控制-上
		
		    1、"if"语句
		语法结构
			if [条件]
			then
				代码
			fi
		代码结构
			a="JAR"
			b="逗你玩"
			if [ $a = $b ]
			then
				echo "字符串a等于字符串b"
			fi

	2、"if else"语句
		语法结构
			if [条件]
			then
				代码
			else
				代码
			fi
		代码结构
			a="JAR"
			b="逗你玩"
			if [ $a = $b ]
			then
				echo "字符串a等于字符串b"
			else
				echo "字符串a不等于字符串b"
			fi

	3、"if-else-if-else"
		语法结构
			if [条件]
			then
				代码
			elif [条件]
			then
				代码
			else
				代码
			fi
		
		代码结构
			a="JAR"
			b="逗你玩"
			if [ $a = $b ]
			then
				echo "字符串a等于字符串b"
			elif [ $a ]
			then
				echo "字符串a不为空"
			else
				echo "字符串a不等于字符串b"
			fi
	
	4、"for"循环语句
		语法结构
			for 变量名 in item1 item2 item3 …
			do
				代码
			done
		代码案例一
			for name in "JAR" "小白菜" "Andy" "雪夜"
			do
   				echo ${name}
			done
		
	5、"while"循环
		语法结构
			while(条件)
			do
				代码
			done
		代码案例一
			a=1
			while(($a<10))
			do
   				echo ${a}
				a=`expr $a + 1`
			done

	6、"case"语句
		语法结构
			case 值 in
			模式1)
				代码
				;;
			模式2)
				代码
				;;
			模式3)
				代码
				;;
			esac
		代码案例一
			number=1
			case $number in
			1) echo "等于1"
				;;
			2) echo "等于2"
				;;
			3) echo "等于3"
				;;
			esac


7  20171101-第4次课-Shell脚本语言-第3讲

   01-Shell脚本语言-循环-until使用
		unti 循环和 while 循环恰好相反，当判断条件不成立时才进行循环，一旦判断条件成立，就终止循环

		Shell until 循环的用法如下：
		   until condition
		do
			statements
		done
		
		condition表示判断条件，statements表示要执行的语句（可以只有一条，也可以有多条），do和done都是 Shell 中的关键字。
		
		
		until 循环的执行流程为：
			先对 condition 进行判断，如果该条件不成立，就进入循环，执行 until 循环体中的语句（do 和 done 之间的语句），这样就完成了一次循环。
			每一次执行到 done 的时候都会重新判断 condition 是否成立，如果不成立，就进入下一次循环，继续执行循环体中的语句，
			如果成立，就结束整个 until 循环，执行 done 后面的其它 Shell 代码。
			如果一开始 condition 就成立，那么程序就不会进入循环体，do 和 done 之间的语句就没有执行的机会。
			
			
		例：
			#!/bin/bash

			i=1
			sum=0

			until ((i > 100))
			do
				((sum += i))
				((i++))
			done
			echo "The sum is: $sum"
			运行结果：
			The sum is: 5050

    02-Shell脚本语言-循环-break使用 03-Shell脚本语言-循环-continue使用
    使用 while、until、for、select 循环时，如果想提前结束循环（在不满足结束条件的情况下结束循环），可以使用 break 或者 continue 关键字。
    大部分编程语言中，break 和 continue 只能跳出当前层次的循环，内层循环中的 break 和 continue 对外层循环不起作用；
    但是 Shell 中的 break 和 continue 却能够跳出多层循环，也就是说，内层循环中的 break 和 continue 能够跳出外层循环。


   break 关键字
	Shell break 关键字的用法为：
	break n
    n 表示跳出循环的层数，如果省略 n，则表示跳出当前的整个循环。break 关键字通常和 if 语句一起使用，即满足条件时便跳出循环。
    
    【实例1】不断从终端读取用户输入的正数，求它们相加的和：
		格式化复制
		#!/bin/bash

		sum=0

		while read n; do
			if((n>0)); then
				((sum+=n))
			else
				break
			fi
		done

		echo "sum=$sum"
		运行结果：
		10↙
		20↙
		30↙
		0↙
		sum=60
		
		分析：
		while 循环通过 read 命令的退出状态来判断循环条件是否成立，只有当按下 Ctrl+D 组合键（表示输入结束）时，read n才会判断失败，
		此时 while 循环终止。
        除了按下 Ctrl+D 组合键，你还可以输入一个小于等于零的整数，这样会执行 break 语句来终止循环（跳出循环）。
        
        
        实例2 使用 break 跳出双层循环。

        #!/bin/bash

		i=0
		while ((++i)); do  #外层循环
			if((i>4)); then
				break  #跳出外层循环
			fi

			j=0;
			while ((++j)); do  #内层循环
				if((j>4)); then
					break  #跳出内层循环
				fi
				printf "%-4d" $((i*j))
			done

			printf "\n"
		done
		运行结果：
		1   2   3   4  
		2   4   6   8  
		3   6   9   12 
		4   8   12  16 
		分析：
		当 j>4 成立时，执行第二个 break，跳出内层循环；外层循环依然执行，直到 i>4 成立，跳出外层循环。内层循环共执行了 4 次，外层循环共执行了 1 次。
		
	   实例3 break 后面跟一个数字，让它一次性地跳出两层循环，请看下面的代码：
	   
	   #!/bin/bash

		i=0
		while ((++i)); do  #外层循环
			j=0;
			while ((++j)); do  #内层循环
				if((i>4)); then
					break 2  #跳出内外两层循环
				fi
				if((j>4)); then
					break  #跳出内层循环
				fi
				printf "%-4d" $((i*j))
			done

			printf "\n"
		done
		修改后的代码将所有 break 都移到了内层循环里面。需要重点关注break 2这条语句，它使得程序可以一次性跳出两层循环，
		也就是先跳出内层循环，再跳出外层循环。
		
		
		continue 关键字
			continue n
			n 表示循环的层数：
			如果省略 n，则表示 continue 只对当前层次的循环语句有效，遇到 continue 会跳过本次循环，忽略本次循环的剩余代码，直接进入下一次循环。
			如果带上 n，比如 n 的值为 2，那么 continue 对内层和外层循环语句都有效，不但内层会跳过本次循环，外层也会跳过本次循环，
			其效果相当于内层循环和外层循环同时执行了不带 n 的 continue
	    
	    【实例1】不断从终端读取用户输入的 100 以内的正数，求它们的和：
				#!/bin/bash

				sum=0

				while read n; do
					if((n<1 || n>100)); then
						continue
					fi
					((sum+=n))
				done

				echo "sum=$sum"
				运行结果：
				10↙
				20↙
				-1000↙
				5↙
				9999↙
				25↙
				sum=60

				变量 sum 最终的值为 60，-1000 和 9999 并没有计算在内，这是因为 -1000 和 9999 不在 1~100 的范围内，if 判断条件成立，
				所以执行了 continue 语句，跳过了当次循环，也就是跳过了((sum+=n))这条语句。

				注意，只有按下 Ctrl+D 组合键输入才会结束，read n才会判断失败，while 循环才会终止。

		【实例2】使用 continue 跳出多层循环，请看下面的代码：
				#!/bin/bash

				for((i=1; i<=5; i++)); do
					for((j=1; j<=5; j++)); do
						if((i*j==12)); then
							continue 2
						fi
						printf "%d*%d=%-4d" $i $j $((i*j))
					done
					printf "\n"
				done
				运行结果：
				1*1=1   1*2=2   1*3=3   1*4=4   1*5=5  
				2*1=2   2*2=4   2*3=6   2*4=8   2*5=10 
				3*1=3   3*2=6   3*3=9   4*1=4   4*2=8   5*1=5   5*2=10  5*3=15  5*4=20  5*5=25
				从运行结果可以看出，遇到continue 2时，不但跳过了内层 for 循环，也跳过了外层 for 循环。
				break 和 continue 的区别

				break 用来结束所有循环，循环语句不再有执行的机会；continue 用来结束本次循环，直接跳到下一次循环，如果循环条件成立，还会继续循环。
				
				
05-Shell脚本语言-文件包含

			语法一：./filename
					文件A->fileA.sh
						脚本内容
							#!/bin/bash
							echo "我是文件A"
					文件B->fileB.sh
						脚本内容
							#!/bin/bash
							#文件B包含文件A
							./fileA.sh
							echo "我是文件B"
            执行脚本命令
			./fileB.sh

			语法二：source filename.sh
				注意：source是一个关键字
				文件A->fileA.sh
					脚本内容
						#!/bin/bash
						echo "我是文件A"
				文件B->fileB.sh
					脚本内容
						#!/bin/bash
						#文件B包含文件A
						source ./fileA.sh
						echo "我是文件B"
				执行脚本命令
					./fileB.sh
					

06-Shell脚本语言-cat命令


				cat：查看文件的内容、连接文件、创建一个或多个文件和重定向输出到终端或文件  用法：cat [选项] [文件]

				1. $ cat hello.txt

				显示hello.txt文本文件中的内容

 

				2. $ cat -n file

				-n选项，可以显示文件的内容和行号

 

				3. $ cat -b file

				-b选项，与-n类似，但只标识非空白行的行号（空白行仍显示）

 

				4. $ cat -e file

				-e选项，将在每一行的末尾显示“$”字符，在需要将多行内容转换成一行时非常有用。

 

				5. $ cat

				只输入cat命令的话，它只是接收标准输入的内容并在标准输出中显示，所以在输入一行并按回车后会在接下来的一行显示相同的内容。

				如：$ cat

				hello world!

				hello world!


				6.  cat f1 f2 （同时显示文件ml和m2的内容）

				7.  cat f1 f2 > f3 （将文件ml和m2合并后放入文件file中）

				8.  重定向输入内容放入hello：

				$ cat >hello

				hello world!

				(ctrl+D组合键退出，输入的内容 hello world! 会写入到文件hello中)

				9.  $ cat >>hello

				hello world!

				重定向操作符有两个： >和>>，前者是内容覆盖，后者是在文件的最后追加。
				
				
				案例一：查看文件内容
					cat fileA.sh
				案例二：cat -n fileA.sh
					-n选项：可以显示文件内容和行号
				案例三：cat -b fileA.sh
					-b选项：和"-n"类似功能，但是只标记非空白行行号
				案例四：cat -e fileA.sh
					-e选项：在每一行内容最后加入了一个"$"符号，在需要将多行内容转换为一行内容的时候，非常有用（后面脚本学习，不是很多 
					
					

07-Shell脚本语言-获取用户输入-read命令

			read 是 Shell 内置命令，用来从标准输入中读取数据并赋值给变量。如果没有进行重定向，
			默认就是从键盘读取用户输入的数据；如果进行了重定向，那么可以从文件中读取数据。

			read 命令的用法为：
			read [-options] [variables]
			options表示选项，如下表所示；variables表示用来存储数据的变量，可以有一个，也可以有多个。

			options和variables都是可选的，如果没有提供变量名，那么读取的数据将存放到环境变量 REPLY 中。

			参数：

			-a array	把读取的数据赋值给数组 array，从下标 0 开始。
			-d delimiter	用字符串 delimiter 指定读取结束的位置，而不是一个换行符（读取到的数据不包括 delimiter）。
			-e	在获取用户输入的时候，对功能键进行编码转换，不会直接显式功能键对应的字符。
			-n num	读取 num 个字符，而不是整行字符。
			-p prompt	显示提示信息，提示内容为 prompt。
			-r	原样读取（Raw mode），不把反斜杠字符解释为转义字符。
			-s	静默模式（Silent mode），不会在屏幕上显示输入的字符。当输入密码和其它确认信息的时候，这是很有必要的。
			-t seconds	设置超时时间，单位为秒。如果用户没有在指定时间内输入完成，那么 read 将会返回一个非 0 的退出状态，表示读取失败。
			-u fd	使用文件描述符 fd 作为输入源，而不是标准输入，类似于重定向。

			【实例1】使用 read 命令给多个变量赋值。
			纯文本复制
			#!/bin/bash
			read -p "Enter some information > " name url age   //输入时会提示"Enter some information > "
			echo "网站名字：$name"
			echo "网址：$url"
			echo "年龄：$age"
			运行结果：
			Enter some information > C语言中文网 http://c.biancheng.net 7↙
			网站名字：C语言中文网
			网址：http://c.biancheng.net
			年龄：7

			注意，必须在一行内输入所有的值，不能换行，否则只能给第一个变量赋值，后续变量都会赋值失败。

			本例还使用了-p选项，该选项会用一段文本来提示用户输入。



			【示例2】只读取一个字符。
			纯文本复制
			#!/bin/bash
			read -n 1 -p "Enter a char > " char
			printf "\n"  #换行
			echo $char
			运行结果：
			Enter a char > 1
			1

			-n 1表示只读取一个字符。运行脚本后，只要用户输入一个字符，立即读取结束，不用等待用户按下回车键。

			printf "\n"语句用来达到换行的效果，否则 echo 的输出结果会和用户输入的内容位于同一行，不容易区分。


			【实例3】在指定时间内输入密码。 s类似于输入密码
			#!/bin/bash
			if
				read -t 20 -sp "Enter password in 20 seconds(once) > " pass1 && printf "\n" &&  #第一次输入密码
				read -t 20 -sp "Enter password in 20 seconds(again)> " pass2 && printf "\n" &&  #第二次输入密码
				[ $pass1 == $pass2 ]  #判断两次输入的密码是否相等
			then
				echo "Valid password"
			else
				echo "Invalid password"
			fi
			这段代码中，我们使用&&组合了多个命令，这些命令会依次执行，并且从整体上作为 if 语句的判断条件，只要其中一个命令执行失败（退出状态为非 0 值）
			，整个判断条件就失败了，后续的命令也就没有必要执行了。

			如果两次输入密码相同，运行结果为：
			Enter password in 20 seconds(once) >
			Enter password in 20 seconds(again)>
			Valid password

			如果两次输入密码不同，运行结果为：
			Enter password in 20 seconds(once) >
			Enter password in 20 seconds(again)>
			Invalid password

			4、从文件里面读取内容
					cat fileB.sh | while read line
					do
						echo "内容：${line}"
					done
					下一节课：管道
					接收输入一行：read name
					接收输入多行：while read name


			如果第一次输入超时，运行结果为：
			Enter password in 20 seconds(once) > Invalid password

			如果第二次输入超时，运行结果为：
			Enter password in 20 seconds(once) >
			Enter password in 20 seconds(again)> Invalid password
			
			
			
08-Shell脚本语言-printf命令
		使用printf可以输出更规则更格式化的结果。
		使用printf可以指定字符串的宽度、实现左对齐（使用减符号-）、右对齐（默认的）、格式化小数输出等。
		使用printf最需要注意的两点是：
		(1)printf默认不在结尾加换行符，它不像echo一样，所以要手动加“\n”换号；
		(2)printf只是格式化输出，不会改变任何结果，所以在格式化浮点数的输出时，浮点数结果是不变的，仅仅只是改变了显示的结果。

			例：
			[root@xuexi tmp]# cat >abc.sh<<eof  # 将下面的内容覆盖到abc.sh脚本中
			> #!/bin/bash
			> #文件名：abc.sh
			> printf "%-5s %-10s %-4s\n" No Name Mark     # 三个%分别对应后面的三个参数
			> printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.34 # 减号“-”表示左对齐
			> printf "%-5s %-10s %-4.2f\n" 2 James 90.998 # 5s表示第一个参数占用5个字符
			> printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564
			> eof
			[root@xuexi tmp]# sh abc.sh  # 执行结果：左对齐，取小数点后两位
			No    Name       Mark
			1     Sarath     80.34
			2     James      91.00
			3     Jeff       77.56
			[root@xuexi tmp]# sed -i s#'-'##g abc.sh  # 将减号“-”去掉，将右对齐

			[root@xuexi tmp]# sh abc.sh 
			   No       Name Mark
				1     Sarath 80.34
				2      James 91.00
				3       Jeff 77.56
	
	
		printf中还可以加入分行符、制表符等符号。
			例：
			[root@xuexi tmp]# vim abc.sh   #修改abc.sh将其改为如下格式
			#!/bin/bash
			#文件名：abc.sh

			printf "%-s\t %-s\t %s\n" No Name Mark
			printf "%-s\t %-s\t %4.2f\n" 1 Sarath 80.34
			printf "%-s\t %-s\t %4.2f\n" 2 James 90.998
			printf "%-s\t %-s\t %4.2f\n" 3 Jeff 77.564
			[root@xuexi tmp]# sh abc.sh  # 出现制表符
			No       Name    Mark
			1        Sarath  80.34
			2        James   91.00
			3        Jeff    77.56
		printf还有一个常见的i格式，表示对整型格式化占用几个整数，前面示例中的s表示对字符格式化。
		

09-Shell脚本语言-函数
    Shell 函数的本质是一段可以重复使用的脚本代码，这段代码被提前编写好了，放在了指定的位置，使用时直接调取即可
    Shell 函数定义的语法格式如下：
	function name() {
		statements
		[return value]
	}
	对各个部分的说明：
	function是 Shell 中的关键字，专门用来定义函数；
	name是函数名；
	statements是函数要执行的代码，也就是一组语句；
	return value表示函数的返回值，其中 return 是 Shell 关键字，专门用在函数中返回一个值；这一部分可以写也可以不写。
	
	函数定义的简化写法

	如果你嫌麻烦，函数定义时也可以不写 function 关键字：
	name() {
		statements
		[return value]
	}
	如果写了 function 关键字，也可以省略函数名后面的小括号：
	function name {
		statements
		[return value]
	}

	函数调用

	调用 Shell 函数时可以给它传递参数，也可以不传递。如果不传递参数，直接给出函数名字即可：
	name
	如果传递参数，那么多个参数之间以空格分隔：
	name param1 param2 param3
	不管是哪种形式，函数名字后面都不需要带括号。

	和其它编程语言不同的是，Shell 函数在定义时不能指明参数，但是在调用时却可以传递参数，并且给它传递什么参数它就接收什么参数。

	Shell 也不限制定义和调用的顺序，你可以将定义放在调用的前面，也可以反过来，将定义放在调用的后面。

	实例演示

	1) 定义一个函数，输出 Shell 教程的地址：
	#!/bin/bash
	#函数定义
	function url(){
		echo "http://c.biancheng.net/shell/"
	}
	#函数调用
	url
	运行结果：
	http://c.biancheng.net/shell/

	你可以将调用放在定义的前面，也就是写成下面的形式：
	#!/bin/bash
	#函数调用
	url
	#函数定义
	function url(){
		echo "http://c.biancheng.net/shell/"
	}

	2) 定义一个函数，计算所有参数的和：
	#!/bin/bash
	function getsum(){
		local sum=0
		for n in $@
		do
			 ((sum+=n))
		done
		return $sum
	}
	getsum 10 20 55 15  #调用函数并传递参数
	echo $?
	运行结果：
	100

	$@表示函数的所有参数，$?表示函数的退出状态（返回值）。关于如何获取函数的参数
	
    Shell函数参数
    函数在定义时不能指明参数，但是在调用时却可以传递参数
    在函数内部可以使用$n来接收，例如，$1 表示第一个参数，$2 表示第二个参数
    $#可以获取传递的参数的个数；
    $@或者$*可以一次性获取所有的参数
    
    【实例1】使用 $n 来接收函数参数。
	纯文本复制
	#!/bin/bash
	#定义函数
	function show(){
		echo "Tutorial: $1"
		echo "URL: $2"
		echo "Author: "$3 //与上面有所不同，这里使用了 Shell 字符串拼接技巧。
		echo "Total $# parameters"
	}
	#调用函数
	show C# http://c.biancheng.net/csharp/ Tom
	运行结果：
	Tutorial: C#
	URL: http://c.biancheng.net/csharp/
	Author: Tom
	Total 3 parameters
	
	
	【实例2】使用 $@ 来遍历函数参数。

	定义一个函数，计算所有参数的和：
	#!/bin/bash
	function getsum(){
		local sum=0
		for n in $@
		do
			 ((sum+=n))
		done
		echo $sum
		return 0
	}
	#调用函数并传递参数，最后将结果赋值给一个变量
	total=$(getsum 10 20 55 15)
	echo $total
	#也可以将变量省略
	echo $(getsum 10 20 55 15)
	运行结果：
	100
	100
	
	
Shell函数返回值（return关键字）
 Shell 中的返回值表示的是函数的退出状态：返回值为 0 表示函数执行成功了，返回值为非 0 表示函数执行失败（出错）了。
 if、while、for 等语句都是根据函数的退出状态来判断条件是否成立。
 Shell 函数的返回值只能是一个介于 0~255 之间的整数，其中只有 0 表示成功，其它值都表示失败
 函数执行失败时，可以根据返回值（退出状态）来判断具体出现了什么错误，比如一个打开文件的函数，
 我们可以指定 1 表示文件不存在，2 表示文件没有读取权限，3 表示文件类型不对。
 如果函数体中没有 return 语句，那么使用默认的退出状态，也就是最后一条命令的退出状态。如果这就是你想要的，那么更加严谨的写法为：
 return $?
 $?是一个特殊变量，用来获取上一个命令的退出状态，或者上一个函数的返回值
 
 如何得到函数的处理结果？
 这个问题有两种解决方案：
 一种是借助全局变量，将得到的结果赋值给全局变量；
 一种是在函数内部使用 echo、printf 命令将结果输出，在函数外部使用$()或者``捕获结果。
 
 
 【实例1】将函数处理结果赋值给一个全局变量。
	#!/bin/bash
	sum=0  #全局变量
	function getsum(){
		for((i=$1; i<=$2; i++)); do
			((sum+=i))  #改变全局变量
		done
		return $?  #返回上一条命令的退出状态
	}
	read m   //读取输入的变量
	read n
	if getsum $m $n; then   //调用函数并传入参数m,n
		echo "The sum is $sum"  #输出全局变量
	else
		echo "Error!"
	fi
	运行结果：
	1
	100
	The sum is 5050
	这种方案的弊端是：定义函数的同时还得额外定义一个全局变量，如果我们仅仅知道函数的名字，但是不知道全局变量的名字，那么也是无法获取结果的。
	
	实例2】在函数内部使用 echo 输出结果。
	#!/bin/bash
	function getsum(){
		local sum=0  #局部变量
		for((i=$1; i<=$2; i++)); do
			((sum+=i))
		done
   
		echo $sum
		return $?
	}
	read m
	read n
	total=$(getsum $m $n)
	echo "The sum is $total"
	#也可以省略 total 变量，直接写成下面的形式
	#echo "The sum is "$(getsum $m $n)
	运行结果：
	1↙
	100↙
	The sum is 5050

	代码中总共执行了两次 echo 命令，但是却只输出一次，这是因为$()捕获了第一个 echo 的输出结果，它并没有真正输出到终端上。
	除了$()，你也可以使用``来捕获 echo 的输出结果，
    这种方案的弊端是：如果不使用$()，而是直接调用函数，那么就会将结果直接输出到终端上，不过这貌似也无所谓，所以我推荐这种方案。
    

10-Shell脚本语言-输入和输出重定向-基本概念  
            输入重定向->语法
			语法结构：wc 文件名称
			命令代码：wc fileA.sh	
			将fileA中内容读取到控制台并显示出来
					wc读取到了三个重要信息
					第一个参数：文本行数
					第二个参数：文本词数
					第三个参数：文本字节数
            结果：2  3 33  fileA.sh	
            
            "<<"：创建文件  后面再说
            
            ">"：我们把方向指向一份文件，那么将文件中的内容删除，写入新的内容
            脚本文件fileA.sh代码
					#!/bin/bash
					echo "我是文件A"
				脚本文件fileB.sh代码
					#!/bin/bash
					echo "我是文件B"			
					echo "Hello Dream" > fileA.sh	
				执行脚本代码
					./fileB.sh	
				总结：替换内容->将fileB.sh输出内容替换了fileA.sh中内容
           ">>"：追加：
                echo "Hello Dream" >> fileA.sh  把文件内容追加给fileA.sh内容后面




8  20171103-第5次课-Shell脚本语言-第4讲


01-Shell脚本语言-管道
	可以将两个或者多个命令（程序或者进程）连接到一起，把一个命令的输出作为下一个命令的输入，
	以这种方式连接的两个或者多个命令就形成了管道（pipe）。
	Linux 管道使用竖线|连接多个命令，这被称为管道符
	例：
	command1 | command2
	command1 | command2 [ | commandN... ]
	当在两个命令之间设置管道时，管道符|左边命令的输出就变成了右边命令的输入。
	只要第一个命令向标准输出写入，而第二个命令是从标准输入读取，那么这两个命令就可以形成一个管道
	注意：
	command1 必须有正确输出，而 command2 必须可以处理 command2 的输出结果；
	而且 command2 只能处理 command1 的正确输出结果，不能处理 command1 的错误信息。
	
	为什么使用管道？

	我们先看下面一组命令，使用 mysqldump（一个数据库备份程序）来备份一个叫做 wiki 的数据库：
	mysqldump -u root -p '123456' wiki > /tmp/wikidb.backup
	gzip -9 /tmp/wikidb.backup
	scp /tmp/wikidb.backup username@remote_ip:/backup/mysql/
	上述这组命令主要做了如下任务：
	mysqldump 命令用于将名为 wike 的数据库备份到文件 /tmp/wikidb.backup；其中-u和-p选项分别指出数据库的用户名和密码。
	gzip 命令用于压缩较大的数据库文件以节省磁盘空间；其中-9表示最慢的压缩速度最好的压缩效果。
	scp 命令（secure copy，安全拷贝）用于将数据库备份文件复制到 IP 地址为 remote_ip 的备份服务器的 /backup/mysql/ 目录下
	。其中username是登录远程服务器的用户名，命令执行后需要输入密码。

	上述三个命令依次执行。然而，如果使用管道的话，你就可以将 mysqldump、gzip、ssh 命令相连接，这样就避免了创建
	临时文件 /tmp/wikidb.backup，而且可以同时执行这些命令并达到相同的效果。

	使用管道后的命令如下所示：
	mysqldump -u root -p '123456' wiki | gzip -9 | ssh username@remote_ip "cat > /backup/wikidb.gz"
	这些使用了管道的命令有如下特点：
	命令的语法紧凑并且使用简单。
	通过使用管道，将三个命令串联到一起就完成了远程 mysql 备份的复杂任务。
	从管道输出的标准错误会混合到一起。
	
	重定向和管道的区别

    乍看起来，管道也有重定向的作用，它也改变了数据输入输出的方向，那么，管道和重定向之间到底有什么不同呢？

    简单地说，重定向操作符>将命令与文件连接起来，用文件来接收命令的输出；而管道符|将命令与命令连接起来，
    用第二个命令来接收第一个命令的输出。如下所示：
    command > file
	command1 | command1
	错误写法：command1 > command2 命令通过重定向连接是错误的
	错误二，使用重定向重写了一个系统文件less的内容，导致系统出错：
		cd /usr/bin
		ls > less
		第一条命令将当前目录切换到了大多数程序所存放的目录，第二条命令是告诉 Shell 用 ls 命令的输出重写文件 less。
		因为 /usr/bin 目录已经包含了名称为 less（less 程序）的文件，第二条命令用 ls 输出的文本重写了 less 程序，
		因此破坏了文件系统中的 less 程序。
	
	Linux管道实例  grep是搜索命令，将查找的结果显示输出

	【实例1】将 ls 命令的输出发送到 grep 命令：
	[c.biancheng.net]$ ls | grep log.txt
	log.txt
	上述命令是查看文件 log.txt 是否存在于当前目录下。
	
	我们可以在命令的后面使用选项，例如使用-al选项：
	[c.biancheng.net]$ ls -al | grep log.txt
	-rw-rw-r--.  1 mozhiyan mozhiyan    0 4月  15 17:26 log.txt
	注意：管道符|与两侧的命令之间也可以不存在空格，例如将上述命令写作ls -al|grep log.txt；
	然而我还是推荐在管道符|和两侧的命令之间使用空格，以增加代码的可读性。
	
	可以重定向管道的输出到一个文件，比如将上述管道命令的输出结果发送到文件 output.txt 中：
	[c.biancheng.net]$ ls -al | grep log.txt >output.txt
	[c.biancheng.net]$ cat output.txt
	-rw-rw-r--.  1 mozhiyan mozhiyan    0 4月  15 17:26 log.txt
	
	【实例2】使用管道将 cat 命令的输出作为 less 命令的输入，这样就可以将 cat 命令的输出每次按照一个屏幕的长度显示，
	 这对于查看长度大于一个屏幕的文件内容很有帮助。
	 cat /var/log/message | less
	 
	 
	 【实例3】查看指定程序的进程运行状态，并将输出重定向到文件中。
	[c.biancheng.net]$ ps aux | grep httpd > /tmp/ps.output  //输出进程，并查找关于httpd 输出到ps.output中
	[c.biancheng.net]$ cat /tem/ps.output
	mozhiyan  4101     13776  0   10:11 pts/3  00:00:00 grep httpd
	root      4578     1      0   Dec09 ?      00:00:00 /usr/sbin/httpd
	apache    19984    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19985    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19986    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19987    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19988    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19989    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19990    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	apache    19991    4578   0   Dec29 ?      00:00:00 /usr/sbin/httpd
	
	【实例4】显示按用户名排序后的当前登录系统的用户的信息。
	[c.biancheng.net]$ who | sort
	mozhiyan :0           2019-04-16 12:55 (:0)
	mozhiyan pts/0        2019-04-16 13:16 (:0)
	who 命令的输出将作为 sort 命令的输入，所以这两个命令通过管道连接后会显示按照用户名排序的已登录用户的信息。
	
	【实例5】统计系统中当前登录的用户数。
	[c.biancheng.net]$ who | wc -l
     5
     
     管道与输入重定向：
	输入重定向操作符<可以在管道中使用，以用来从文件中获取输入，其语法类似下面这样：
	command1 < input.txt | command2
	command1 < input.txt | command2 -option | command3
	
	tr是个简单的替换命令，从标准输入中替换、缩减和/或删除字符，并将结果写到标准输出
	例如，使用 tr 命令从 os.txt 文件中获取输入，然后通过管道将输出发送给 sort 或 uniq 等命令：
	[c.biancheng.net]$ cat os.txt
	redhat
	suse
	centos
	ubuntu
	solaris
	hp-ux
	fedora
	centos
	redhat
	hp-ux
	[c.biancheng.net]$ tr a-z A-Z <os.txt | sort
	CENTOS
	CENTOS
	FEDORA
	HP-UX
	HP-UX
	REDHAT
	REDHAT
	SOLARIS
	SUSE
	UBUNTU
	[c.biancheng.net]$ tr a-z A-Z <os.txt | sort | uniq
	CENTOS
	FEDORA
	HP-UX
	REDHAT
	SOLARIS
	SUSE
	UBUNTU
	 
	 管道与输出重定向

	你也可以使用重定向操作符>或>>将管道中的最后一个命令的标准输出进行重定向，其语法如下所示：
	command1 | command2 | ... | commandN > output.txt
	command1 < input.txt | command2 | ... | commandN > output.txt
	
	【实例1】使用 mount 命令显示当前挂载的文件系统的信息，并使用 column 命令格式化列的输出，最后将输出结果保存到一个文件中。
	[c.biancheng.net]$ mount | column -t >mounted.txt
	[c.biancheng.net]$ cat mounted.txt
	proc         on  /proc                  type  proc        (rw,nosuid,nodev,noexec,relatime)
	sysfs        on  /sys                   type  sysfs       (rw,nosuid,nodev,noexec,relatime,seclabel)
	devtmpfs     on  /dev                   type  devtmpfs    (rw,nosuid,seclabel,size=496136k,nr_inodes=124034,mode=755)
	securityfs   on  /sys/kernel/security   type  securityfs  (rw,nosuid,nodev,noexec,relatime)
	tmpfs        on  /dev/shm               type  tmpfs       (rw,nosuid,nodev,seclabel)
	devpts       on  /dev/pts               type  devpts      (rw,nosuid,noexec,relatime,seclabel,gid=5,mode=620,ptmxmode=000)
	tmpfs        on  /run                   type  tmpfs       (rw,nosuid,nodev,seclabel,mode=755)
	tmpfs        on  /sys/fs/cgroup         type  tmpfs       (rw,nosuid,nodev,noexec,seclabel,mode=755)
	#####此处省略部分内容#####
	
	【实例2】使用 tr 命令将 os.txt 文件中的内容转化为大写，并使用 sort 命令将内容排序，
	使用 uniq 命令去除重复的行，最后将输出重定向到文件 ox.txt.new。
	[c.biancheng.net]$ cat os.txt
	redhat
	suse
	centos
	ubuntu
	solaris
	hp-ux
	fedora
	centos
	redhat
	hp-ux
	[c.biancheng.net]$ tr a-z A-Z <os.txt | sort | uniq >os.txt.new
	[c.biancheng.net]$ cat os.txt.new
	CENTOS
	FEDORA
	HP-UX
	REDHAT
	SOLARIS
	SUSE
	
02-Shell脚本语言-expr命令
    expr 是 evaluate expressions 的缩写，译为“表达式求值”。Shell expr 是一个功能强大，并且比较复杂的命令，
    它除了可以实现整数计算，还可以结合一些选项对字符串进行处理，例如计算字符串长度、字符串比较、字符串匹配、字符串提取等。
    本节只讲解 expr 在整数计算方面的应用，并不涉及字符串处理，有兴趣的读者请自行研究。
	
	expr 对表达式的格式有几点特殊的要求：
		出现在表达式中的运算符、数字、变量和小括号的左右两边至少要有一个空格，否则会报错。
		有些特殊符号必须用反斜杠\进行转义（屏蔽其特殊含义），比如乘号*和小括号()，如果不用\转义，
		那么 Shell 会把它们误解为正则表达式中的符号（*对应通配符，()对应分组）。
		使用变量时要加$前缀。
	【实例1】expr 整数计算简单举例：
		[c.biancheng.net]$ expr 2 +3  #错误：加号和 3 之前没有空格
		expr: 语法错误
		[c.biancheng.net]$ expr 2 + 3  #这样才是正确的
		5
		[c.biancheng.net]$ expr 4 * 5  #错误：乘号没有转义
		expr: 语法错误
		[c.biancheng.net]$ expr 4 \* 5  #使用 \ 转义后才是正确的
		20
		[c.biancheng.net]$ expr ( 2 + 3 ) \* 4  #小括号也需要转义
		bash: 未预期的符号 `2' 附近有语法错误
		[c.biancheng.net]$ expr \( 2 + 3 \) \* 4  #使用 \ 转义后才是正确的
		20
		[c.biancheng.net]$ n=3
		[c.biancheng.net]$ expr n + 2  #使用变量时要加 $
		expr: 非整数参数
		[c.biancheng.net]$ expr $n + 2  #加上 $ 才是正确的
		5
		[c.biancheng.net]$ m=7
		[c.biancheng.net]$ expr $m \* \( $n + 5 \)
		56
		以上是直接使用 expr 命令，计算结果会直接输出，如果你希望将计算结果赋值给变量，那么需要将整个表达式用反引号``
		（位于 Tab 键的上方）包围起来，请看下面的例子。
		
		【实例2】将 expr 的计算结果赋值给变量：
			[c.biancheng.net]$ m=5
			[c.biancheng.net]$ n=`expr $m + 10`
			[c.biancheng.net]$ echo $n
			15
			
03-Shell脚本语言-浮点数  04-Shell脚本语言-bash计算器介绍
    Bash Shell 内置了对整数运算的支持，但是并不支持浮点运算，而 Linux bc 命令可以很方便的进行浮点运算，当然整数运算也不再话下。
    bc 甚至可以称得上是一种编程语言了，它支持变量、数组、输入输出、分支结构、循环结构、函数等基本的编程元素
    就是“一个任意精度的计算器语言”。
    在终端输入bc命令，然后回车即可进入 bc 进行交互式的数学计算。在 Shell 编程中，我们也可以通过管道和输入重定向来使用 bc。
    
    在终端输入 bc 命令，然后回车，就可以进入 bc，可以看到bc计算器的版本号等信息
    bc 命令还有一些选项，可能你会用到，请看下表。
		选项	说明
		-h | --help	帮助信息
		-v | --version	显示命令版本信息
		-l | --mathlib	使用标准数学库
		-i | --interactive	强制交互
		-w | --warn	显示 POSIX 的警告信息
		-s | --standard	使用 POSIX 标准来处理
		-q | --quiet	不显示欢迎信息
	例如你不想输入 bc 命令后显示一堆没用的信息，那么可以输入bc -q：
	
	在交互式环境下使用 bc：
    使用 bc 进行数学计算是非常容易的，像平常一样输入数学表达式，然后按下回车键就可以看到结果
    3*3
    9
    n=10 //bc 是支持变量的
    ++n
    11
    
    内置变量

	bc 有四个内置变量，我们在计算时会经常用到，如下表所示：
	变量名	作 用
	scale	指定精度，也即小数点后的位数；默认为 0，也即不使用小数部分。
	ibase	指定输入的数字的进制，默认为十进制。
	obase	指定输出的数字的进制，默认为十进制。
	last 或者 .	表示最近打印的数字
	
	scale=3
	10/3
	3.33333333
	刚开始的时候，10/3 的值为 3，不带小数部分，就是因为 scale 变量的默认值为 0；后边给 scale 指定了一个大于 0 的值，
	就能看到小数部分了。
	
	【实例2】ibase 和 obase 变量用法举例:
	obase=16
	23*2
	2E
	obase=10  输出10进制
	ibase=16  输入16进制
	10*10
	256
	
	注意：obase 要尽量放在 ibase 前面，因为 ibase 设置后，后面的数字都是以 ibase 的进制来换算的

	内置函数

	除了内置变量，bc 还有一些内置函数，如下表所示：
	函数名	作用
	s(x)	计算 x 的正弦值，x 是弧度值。
	c(x)	计算 x 的余弦值，x 是弧度值。
	a(x)	计算 x 的反正切值，返回弧度值。
	l(x)	计算 x 的自然对数。
	e(x)	求 e 的 x 次方。
	j(n, x)	贝塞尔函数，计算从 n 到 x 的阶数。
	
	要想使用这些数学函数，在输入 bc 命令时需要使用-l选项，表示启用数学库。请看下面的例子：
	bc -q -l
	x=5
	s(5)
	
	一行中使用多个表达式：
	在前边的例子中，我们基本上是一行一个表达式，这样看起来更加舒服；如果你愿意，也可以将多个表达式放在一行，
	只要用分号;隔开就行。请看下面的例子：
	m=2;n=10;(2+m)*(n+12)
	
	在 Shell 中使用 bc 计算器

在 Shell 脚本中，我们可以借助管道或者输入重定向来使用 bc 计算器。
	管道是 Linux 进程间的一种通信机制，它可以将前一个命令（进程）的输出作为下一个命令（进程）的输入，两个命令之间使用竖线|分隔。
	通常情况下，一个命令从终端获得用户输入的内容，如果让它从其他地方（比如文件）获得输入，那么就需要重定向。

借助管道使用 bc 计算器

如果读者希望直接输出 bc 的计算结果，那么可以使用下面的形式：
	echo "expression" | bc
	expression就是希望计算的数学表达式，它必须符合 bc 的语法，上面我们已经进行了介绍。在 expression 中，
	还可以使用 Shell 脚本中的变量。
	
	使用下面的形式可以将 bc 的计算结果赋值给 Shell 变量：
		variable=$(echo "expression" | bc)   variable 就是变量名。
		
	【实例1】最简单的形式：
		[c.biancheng.net]$ echo "3*8"|bc
		24
		[c.biancheng.net]$ ret=$(echo "4+9"|bc)
		[c.biancheng.net]$ echo $ret
		13
		
	【实例2】使用 bc 中的变量：
		[c.biancheng.net]$ echo "scale=4;3*8/7"|bc
		3.4285
		[c.biancheng.net]$ echo "scale=4;3*8/7;last*5"|bc
		3.4285
		17.1425
		
	【实例3】使用 Shell 脚本中的变量：
		[c.biancheng.net]$ x=4
		[c.biancheng.net]$ echo "scale=5;n=$x+2;e(n)"|bc -l
		403.42879
		在第二条命令中，$x表示使用第一条 Shell 命令中定义的变量，n是在 bc 中定义的新变量，它和 Shell 脚本是没关系的。
		
	实例4】进制转换：
		#十进制转十六进制
		[mozhiyan@localhost ~]$ m=31
		[mozhiyan@localhost ~]$ n=$(echo "obase=16;$m"|bc)
		[mozhiyan@localhost ~]$ echo $n
		1F
		#十六进制转十进制
		[mozhiyan@localhost ~]$ m=1E
		[mozhiyan@localhost ~]$ n=$(echo "obase=10;ibase=16;$m"|bc)
		[mozhiyan@localhost ~]$ echo $n
		30
		
借助输入重定向使用 bc 计算器

	可以使用下面的形式将 bc 的计算结果赋值给 Shell 变量：
	variable=$(bc << EOF
	expressions
	EOF
	)
	其中，variable是 Shell 变量名，express是要计算的数学表达式（可以换行，和进入 bc 以后的书写形式一样），
	EOF是数学表达式的开始和结束标识（你也可以换成其它的名字，比如 aaa、bbb 等）。
	
	请看下面的例子：
		[c.biancheng.net]$ m=1E
		[c.biancheng.net]$ n=$(bc << EOF
		> obase=10;
		> ibase=16;
		> print $m
		> EOF
		> )
		[c.biancheng.net]$ echo $n
		30
		如果你有大量的数学计算，那么使用输入重定向就比较方便，因为数学表达式可以换行，写起来更加清晰明了。
		

05-Shell脚本语言-重定向-外部文件操作-系统操作符

Linux Shell 重定向分为两种，一种输入重定向，一种是输出重定向；从字面上理解，输入输出重定向就是「改变输入与输出的方向」的意思。
标准的输入方向：从键盘读取用户输入的数据，然后再把数据拿到程序（C语言程序、Shell 脚本程序等）中使用
标准的输出方向：程序中也会产生数据，这些数据一般都是直接呈现到显示器上
输入输出方向就是数据的流动方向：
输入方向就是数据从哪里流向程序。数据默认从键盘流向程序，如果改变了它的方向，数据就从其它地方流入，这就是输入重定向。
输出方向就是数据从程序流向哪里。数据默认从程序流向显示器，如果改变了它的方向，数据就流向其它地方，这就是输出重定向。

硬件设备和文件描述符
常见的输入设备有键盘、鼠标、麦克风、手写板等，输出设备有显示器、投影仪、打印机等。不过，
在 Linux 中，标准输入设备指的是键盘，标准输出设备指的是显示器。
Linux 中一切皆文件，包括标准输入设备（键盘）和标准输出设备（显示器）在内的所有计算机硬件都是文件

为了表示和区分已经打开的文件，Linux 会给每个文件分配一个 ID，这个 ID 就是一个整数，被称为文件描述符（File Descriptor）。
	表1：与输入输出有关的文件描述符
	文件描述符	文件名	类型	硬件
	0	stdin	标准输入文件	键盘
	1	stdout	标准输出文件	显示器
	2	stderr	标准错误输出文件	显示器
	
Linux 程序在执行任何形式的 I/O 操作时，都是在读取或者写入一个文件描述符。一个文件描述符只是一个和打开的文件相关联的整数，
它的背后可能是一个硬盘上的普通文件、FIFO、管道、终端、键盘、显示器，甚至是一个网络连接。
stdin、stdout、stderr 默认都是打开的，在重定向的过程中，0、1、2 这三个文件描述符可以直接使

Linux Shell 输出重定向 
输出重定向是指命令的结果不再输出到显示器上，而是输出到其它地方，一般是文件中。这样做的最大好处就是把命令的结果保存起来，
当我们需要的时候可以随时查询。Bash 支持的输出重定向符号如下表所示。
在输出重定向中，>代表的是覆盖，>>代表的是追加。

	类 型	            符 号	         作 用
标准输出重定向：
					  command >file	    以覆盖的方式，把 command 的正确输出结果输出到 file 文件中。
					  command >>file	以追加的方式，把 command 的正确输出结果输出到 file 文件中。
标准错误输出重定向：
					   command 2>file	以覆盖的方式，把 command 的错误信息输出到 file 文件中。
					   command 2>>file	以追加的方式，把 command 的错误信息输出到 file 文件中。
正确输出和错误信息同时保存：
					   command >file 2>&1	以覆盖的方式，把正确输出和错误信息同时保存到同一个文件（file）中。
                       command >>file 2>&1	以追加的方式，把正确输出和错误信息同时保存到同一个文件（file）中。
                       command >file1 2>file2	以覆盖的方式，把正确的输出结果输出到 file1 文件中，把错误信息输出到 file2 文件中。
                       command >>file1  2>>file2	以追加的方式，把正确的输出结果输出到 file1 文件中，把错误信息输出到 file2 文件中。
【不推荐】这两种写法会导致 file 被打开两次，引起资源竞争，
所以 stdout 和 stderr 会互相覆盖，我们将在《结合Linux文件描述符谈重定向，彻底理解重定向的本质》一节中深入剖析：
 command >file 2>file	
command >>file 2>>file

注意

输出重定向的完整写法其实是fd>file或者fd>>file，其中 fd 表示文件描述符，如果不写，默认为 1，也就是标准输出文件。

当文件描述符为 1 时，一般都省略不写，如上表所示；当然，如果你愿意，也可以将command >file写作command 1>file，但这样做是多此一举。

当文件描述符为大于 1 的值时，比如 2，就必须写上。

需要重点说明的是，fd和>之间不能有空格，否则 Shell 会解析失败；>和file之间的空格可有可无。为了保持一致，我习惯在>两边都不加空格。

下面的语句是一个反面教材：
echo "c.biancheng.net" 1 >log.txt
注意1和>之间的空格。echo 命令的输出结果是c.biancheng.net，我们的初衷是将输出结果重定向到 log.txt，但是当你打开 log.txt 文件后，发现文件的内容为c.biancheng.net 1，这就是多余的空格导致的解析错误。也就是说，Shell 将该条语句理解成了下面的形式：
echo "c.biancheng.net" 1 1>log.txt

输出重定向举例

【实例1】将 echo 命令的输出结果以追加的方式写入到 demo.txt 文件中。
纯文本复制
#!/bin/bash
for str in "C语言中文网" "http://c.biancheng.net/" "成立7年了" "日IP数万"
do
    echo $str >>demo.txt  #将输入结果以追加的方式重定向到文件
done
运行以上脚本，使用cat demo.txt查看文件内容，显示如下：
C语言中文网
http://c.biancheng.net/
成立7年了
日IP数万

【实例2】将ls -l命令的输出结果重定向到文件中。
[c.biancheng.net]$ ls -l  #先预览一下输出结果
总用量 16
drwxr-xr-x. 2 root     root      21 7月   1 2016 abc
-rw-r--r--. 1 mozhiyan mozhiyan 399 3月  11 17:12 demo.sh
-rw-rw-r--. 1 mozhiyan mozhiyan  67 3月  22 17:16 demo.txt
-rw-rw-r--. 1 mozhiyan mozhiyan 278 3月  16 17:17 main.c
-rwxr-xr-x. 1 mozhiyan mozhiyan 187 3月  22 17:16 test.sh
[c.biancheng.net]$ ls -l >demo.txt  #重定向
[c.biancheng.net]$ cat demo.txt  #查看文件内容
总用量 12
drwxr-xr-x. 2 root     root      21 7月   1 2016 abc
-rw-r--r--. 1 mozhiyan mozhiyan 399 3月  11 17:12 demo.sh
-rw-rw-r--. 1 mozhiyan mozhiyan   0 3月  22 17:21 demo.txt
-rw-rw-r--. 1 mozhiyan mozhiyan 278 3月  16 17:17 main.c
-rwxr-xr-x. 1 mozhiyan mozhiyan 187 3月  22 17:16 test.sh

错误输出重定向举例

命令正确执行是没有错误信息的，我们必须刻意地让命令执行出错，如下所示：
[c.biancheng.net]$ ls java  #先预览一下错误信息
ls: 无法访问java: 没有那个文件或目录
[c.biancheng.net]$ ls java 2>err.log  #重定向
[c.biancheng.net]$ cat err.log  #查看文件
ls: 无法访问java: 没有那个文件或目录


正确输出和错误信息同时保存

【实例1】把正确结果和错误信息都保存到一个文件中，例如：
[c.biancheng.net]$ ls -l >out.log 2>&1  //把ls -l结果输入到out.log 同时把错误的用2代表，输入到&1 指参数out.log
[c.biancheng.net]$ ls java >>out.log 2>&1
[c.biancheng.net]$ cat out.log
总用量 12
drwxr-xr-x. 2 root     root      21 7月   1 2016 abc
-rw-r--r--. 1 mozhiyan mozhiyan 399 3月  11 17:12 demo.sh
-rw-rw-r--. 1 mozhiyan mozhiyan 278 3月  16 17:17 main.c
-rw-rw-r--. 1 mozhiyan mozhiyan   0 3月  22 17:39 out.log
-rwxr-xr-x. 1 mozhiyan mozhiyan 187 3月  22 17:16 test.sh
ls: 无法访问java: 没有那个文件或目录
out.log 的最后一行是错误信息，其它行都是正确的输出结果。


【实例2】上面的实例将正确结果和错误信息都写入同一个文件中，这样会导致视觉上的混乱，不利于以后的检索，所以我建议把正确结果和错误信息分开保存到不同的文件中，也即写成下面的形式：
ls -l >>out.log 2>>err.log
这样一来，正确的输出结果会写入到 out.log，而错误的信息则会写入到 err.log。
/dev/null 文件

如果你既不想把命令的输出结果保存到文件，也不想把命令的输出结果显示到屏幕上，干扰命令的执行，那么可以把命令的所有结果重定向到 /dev/null 文件中。如下所示：
ls -l &>/dev/null
大家可以把 /dev/null 当成 Linux 系统的垃圾箱，任何放入垃圾箱的数据都会被丢弃，不能恢复。


Linux Shell 输入重定向

输入重定向就是改变输入的方向，不再使用键盘作为命令输入的来源，而是使用文件作为命令的输入。

表3：Bash 支持的输出重定向符号
符号	说明
command <file	将 file 文件中的内容作为 command 的输入。
command <<END	从标准输入（键盘）中读取数据，直到遇见分界符 END 才停止（分界符可以是任意的字符串，用户自己定义）。
command <file1 >file2	将 file1 作为 command 的输入，并将 command 的处理结果输出到 file2。
和输出重定向类似，输入重定向的完整写法是fd<file，其中 fd 表示文件描述符，如果不写，默认为 0，也就是标准输入文件。

输入重定向举例：

	【示例1】统计文档中有多少行文字。

	Linux wc 命令可以用来对文本进行统计，包括单词个数、行数、字节数，它的用法如下：
	wc  [选项]  [文件名]
	其中，-c选项统计字节数，-w选项统计单词数，-l选项统计行数。

	统计 readme.txt 文件中有多少行文本：
	[c.biancheng.net]$ cat readme.txt  #预览一下文件内容
	C语言中文网
	http://c.biancheng.net/
	成立7年了
	日IP数万
	[c.biancheng.net]$ wc -l <readme.txt  #输入重定向
	4


	【实例2】逐行读取文件内容。
	#!/bin/bash

	while read str; do
		echo $str
	done <readme.txt
	运行结果：
	C语言中文网
	http://c.biancheng.net/
	成立7年了
	日IP数万

	这种写法叫做代码块重定向，也就是把一组命令同时重定向到一个文件，我们将在《Shell代码块重定向》一节中详细讲解。
	
	
	【实例3】统计用户在终端输入的文本的行数。

	此处我们使用输入重定向符号<<，这个符号的作用是使用特定的分界符作为命令输入的结束标志，而不使用 Ctrl+D 键。
	[c.biancheng.net]$ wc -l <<END
	> 123
	> 789
	> abc
	> xyz
	> END
	4
	wc 命令会一直等待用输入，直到遇见分界符 END 才结束读取。

	<<之后的分界符可以自由定义，只要再碰到相同的分界符，两个分界符之间的内容将作为命令的输入（不包括分界符本身）。



   Linux文件描述符到底是什么？
   Linux 中一切皆文件，比如 C++ 源文件、视频文件、Shell脚本、可执行文件等，就连键盘、显示器、鼠标等硬件设备也都是文件。

	一个 Linux 进程可以打开成百上千个文件，为了表示和区分已经打开的文件，Linux 会给每个文件分配一个编号（一个 ID）
	，这个编号就是一个整数，被称为文件描述符（File Descriptor）。
	
  Linux 文件描述符到底是什么？

	一个 Linux 进程启动后，会在内核空间中创建一个 PCB 控制块，PCB 内部有一个文件描述符表（File descriptor table），
	记录着当前进程所有可用的文件描述符，也即当前进程所有打开的文件。

 除了文件描述符表，系统还需要维护另外两张表：
	打开文件表（Open file table）
	i-node 表（i-node table）
	文件描述符表每个进程都有一个，打开文件表和 i-node 表整个系统只有一个
	
	
	通过文件描述符表中的文件指针，从而进入打开文件表。该表存储了以下信息：
		文件偏移量，也就是文件内部指针偏移量。调用 read() 或者 write() 函数时，
		文件偏移量会自动更新，当然也可以使用 lseek() 直接修改。
		状态标志，比如只读模式、读写模式、追加模式、覆盖模式等。
		i-node 表指针。

   读写文件，还得通过打开文件表的 i-node 指针进入 i-node 表，该表包含了诸如以下的信息：
		文件类型，例如常规文件、套接字或 FIFO。
		文件大小。
		时间戳，比如创建时间、更新时间。
		文件锁。
		
	同一个进程的不同文件描述符可以指向同一个文件描述符表；
	不同进程可以拥有相同的文件描述符表；
	不同进程的同一个文件描述符可以指向不同的文件描述符表（一般也是这样，除了 0、1、2 这三个特殊的文件）；
	不同进程的不同文件描述符也可以指向同一个文件。
	
	
结合Linux文件描述符谈重定向，彻底理解重定向的本质：
    如果我们改变了文件指针的指向，不就改变了文件描述符对应的真实文件吗？
    比如文件描述符 1 本来对应显示器，但是我们偷偷将文件指针指向了 log.txt 文件，那么文件描述符 1 也就和 log.txt 对应起来了。
    文件指针只不过是一个内存地址，修改它是轻而易举的事情。文件指针是文件描述符和真实文件之间最关键的“纽带”，然而这条纽带却非常脆弱，很容易被修改。

    Linux 系统提供的函数可以修改文件指针，比如 dup()、dup2()；Shell 也能修改文件指针，输入输出重定向就是这么干的。
    
    输入输出重定向就是通过修改文件指针实现的！更准确地说，发生重定向时，Linux 会用文件描述符表（一个结构体数组）中的一个元素给另一个元素赋值，
    或者用一个结构体变量给数组元素赋值，整体上的资源开销相当低。
    你看，发生重定向的时候，文件描述符并没有改变，改变的是文件描述符对应的文件指针。对于标准输出，Linux 系统始终向文件描述符 
    1 中输出内容，而不管它的文件指针指向哪里；只要我们修改了文件指针，就能向任意文件中输出内容。

	以下面的语句为例来说明：
	echo "c.biancheng.net" 1>log.txt

	文件描述符表本质上是一个结构体数组，假设这个结构体的名字叫做 FD。发生重定向时，Linux 系统首先会打开 log.txt 文件，
	并把各种信息添加到 i-node 表和文件打开表，然后再创建一个 FD 变量（通过这个变量其实就能读写文件了），
	并用这个变量给下标为 1 的数组元素赋值，覆盖原来的内容，这样就改变了文件指针的指向，完成了重定向。
	
	
	Shell 对文件描述符的操作

前面提到，>是输出重定向符号，<是输入重定向符号；更准确地说，它们应该叫做文件描述符操作符。> 和 < 通过修改文件描述符改变了文件指针的指向，
所以能够实现重定向的功能。
除了 > 和 <，Shell 还是支持<>，它的效果是前面两者的总和。

Shell 文件描述符操作方法一览表
分类  	用法	         说明
输出：
	n>filename	以输出的方式打开文件 filename，并绑定到文件描述符 n。n 可以不写，默认为 1，也即标准输出文件。
    n>&m	    用文件描述符 m 修改文件描述符 n，或者说用文件描述符 m 的内容覆盖文件描述符 n，
                结果就是 n 和 m 都代表了同一个文件，因为 n 和 m 的文件指针都指向了同一个文件。
                因为使用的是>，所以 n 和 m 只能用作命令的输出文件。n 可以不写，默认为 1。
    n>&-	    关闭文件描述符 n 及其代表的文件。n 可以不写，默认为 1。
    &>filename	将正确输出结果和错误信息全部重定向到 filename。
输入：
	n<filename	以输入的方式打开文件 filename，并绑定到文件描述符 n。n 可以不写，默认为 0，也即标准输入文件。
    n<&m	    类似于 n>&m，但是因为使用的是<，所以 n 和 m 只能用作命令的输入文件。n 可以不写，默认为 0。
    n<&-	    关闭文件描述符 n 及其代表的文件。n 可以不写，默认为 0。
    输入和输出	n<>filename	同时以输入和输出的方式打开文件 filename，并绑定到文件描述符 n，
                相当于 n>filename 和 n<filename 的总和。。n 可以不写，默认为 0。
                
                
                

【实例1】前面的文章中提到了下面这种用法：
command >file 2>&1
它省略了文件描述符 1，所以等价于：
command 1>file 2>&1

这个语句可以分成两步：先执行1>file，让文件描述符 1 指向 file；再执行2>&1，用文件描述符 1 修改文件描述符 2，
因为1是指向file的，修改后2也指向了file，1代表显示器，2代表错误
最终 1 和 2 都指向了同一个文件，也就是 file。所以不管是向 1 还是向 2 中输出内容，最终都输出到 file 文件中。

注意执行顺序，多个操作符在一起会从左往右依次执行。对于上面的语句，就是先执行1>file，再执行2>&1；如果写作下面的形式，那就南辕北辙了：
command 2>&1 1>file
Shell 会先执行2>&1，这样 1 和 2 都指向了标准错误输出文件，因为1是输出到显示器的，这时候修改了2，2也指向显示器；
接着执行1>file，这样 1 就指向了 file 文件，但是 2 依然指向显示器。
最终的结果是，正确的输出结果输出到了 file 文件，错误信息却还是输出到显示器。

【实例2】一个比较奇葩的重定向写法。
echo "C语言中文网" 10>log.txt >&10
先执行10>log.txt，打开 log.txt，并给它分配文件描述符 10；接着执行>&10，用文件描述符 10 来修改文件描述符 1（对于>，省略不写的话默认为 1），让 1 和 10 都指向 log.txt 文件，最终的结果是向 log.txt 文件中输出内容。

这条语句其实等价于echo "C语言中文网" >log.txt，我之所以写得这么绕，是为了让大家理解各种操作符的用法。

文件描述符 10 只用了一次，我们在末尾最好将它关闭，这是一个好习惯。
echo "C语言中文网" 10>log.txt >&10 10>&-


Shell exec命令操作文件描述符
exec 是 Shell 内置命令，一种是执行 Shell 命令，一种是操作文件描述符。
使用 exec 命令可以永久性地重定向，后续命令的输入输出方向也被确定了，直到再次遇到 exec 命令才会改变重定向的方向；
换句话说，一次重定向，永久有效。
嗯？什么意思？难道说我们以前使用的重定向都是临时的吗？是的！前面使用的重定向都是临时的，
它们只对当前的命令有效，对后面的命令无效。

请看下面的例子：
[mozhiyan@localhost ~]$ echo "c.biancheng.net" > log.txt
[mozhiyan@localhost ~]$ echo "C语言中文网"
C语言中文网
[mozhiyan@localhost ~]$ cat log.txt
c.biancheng.net
第一个 echo 命令使用了重定向，将内容输出到 log.txt 文件；第二个 echo 命令没有再次使用重定向，内容就直接输出到显示器上了。很明显，重定向只对第一个 echo 有效，对第二个 echo 无效。

有些脚本文件的输出内容很多，我们不希望直接输出到显示器上，或者我们需要把输出内容备份到文件中，方便以后检索，按照以前的思路，必须在每个命令后面都使用一次重定向，写起来非常麻烦。如果以后想修改重定向的方向，那工作量也是不小的。

exec 命令就是为解决这种困境而生的，它可以让重定向对当前 Shell 进程中的所有命令有效，它的用法为：
exec 文件描述符操作

所有对文件描述符的操作方式 exec 都支持，请看下面的例子：
[mozhiyan@localhost ~]$ echo "重定向未发生"
重定向未发生
[mozhiyan@localhost ~]$ exec >log.txt
[mozhiyan@localhost ~]$ echo "c.biancheng.net"
[mozhiyan@localhost ~]$ echo "C语言中文网"
[mozhiyan@localhost ~]$ exec >&2
[mozhiyan@localhost ~]$ echo "重定向已恢复"
重定向已恢复
[mozhiyan@localhost ~]$ cat log.txt
c.biancheng.net
C语言中文网
对代码的说明：
exec >log.txt将当前 Shell 进程的所有标准输出重定向到 log.txt 文件，它等价于exec 1>log.txt。
后面的两个 echo 命令都没有在显示器上输出，而是输出到了 log.txt 文件。
exec >&2用来恢复重定向，让标准输出重新回到显示器，它等价于exec 1>&2。2 是标准错误输出的文件描述符，它也是输出到显示器，
并且没有遭到破坏，我们用 2 来覆盖 1，就能修复 1，让 1 重新指向显示器。
接下来的 echo 命令将结果输出到显示器上，证明exec >&2奏效了。
最后我们用 cat 命令来查看 log.txt 文件的内容，发现就是中间两个 echo 命令的输出。

重定向的恢复
类似echo "1234" >log.txt这样的重定向只是临时的，当前命名执行完毕后会自动恢复到显示器，我们不用担心。
但是诸如exec >log.txt这种使用 exec 命令的重定向都是持久的，
如果我们想再次回到显示器，就必须手动恢复。
以输出重定向为例，手动恢复的方法有两种：
/dev/tty 文件代表的就是显示器，将标准输出重定向到 /dev/tty 即可，也就是 exec >/dev/tty。
如果还有别的文件描述符指向了显示器，那么也可以别的文件描述符来恢复标号为 1 的文件描述符，
例如 exec >&2。（因为2指向显示器，如果2覆盖1，1也指向显示器了）注意，如果文件描述符 2 也被重定向了，那么这种方式就无效了。

下面的例子演示了输入重定向的恢复：
纯文本复制
#!/bin/bash
exec 6<&0  #先将0号文件描述符保存
exec <nums.txt  #输入重定向
sum=0
while read n; do
    ((sum += n))
done
echo "sum=$sum"
exec 0<&6 6<&-  #恢复输入重定向，并关闭文件描述符6
read -p "请输入名字、网址和年龄：" name url age
echo "$name已经$age岁了，它的网址是 $url"
将代码保存到 test.txt，并执行下面的命令：
[mozhiyan@localhost ~]$ cat nums.txt
80
33
129
71
100
222
8
[mozhiyan@localhost ~]$ bash ./test.sh
sum=643
请输入名字、网址和年龄：C语言中文网 http://c.biancheng.net 7
C语言中文网已经7岁了，它的网址是 http://c.biancheng.net


Shell代码块重定向
所谓代码块，就是由多条语句组成的一个整体；for、while、until 循环，
或者 if...else、case...in 选择结构，或者由{ }包围的命令都可以称为代码块。
将重定向命令放在代码块的结尾处，就可以对代码块中的所有命令实施重定向。

【实例1】使用 while 循环不断读取 nums.txt 中的数字，计算它们的总和。
纯文本复制
#!/bin/bash
sum=0
while read n; do
    ((sum += n))
done <nums.txt  #输入重定向
echo "sum=$sum"
将代码保存到 test.sh 并运行：
[c.biancheng.net]$ cat nums.txt
80
33
129
71
100
222
8
[c.biancheng.net]$ . ./test.sh
sum=643

对上面的代码进行改进，记录 while 的读取过程，并将输出结果重定向到 log.txt 文件：
#!/bin/bash
sum=0
while read n; do
    ((sum += n))
    echo "this number: $n"
done <nums.txt >log.txt  #同时使用输入输出重定向
echo "sum=$sum"
将代码保存到 test.sh 并运行：
[c.biancheng.net]$ . ./test.sh
sum=643
[c.biancheng.net]$ cat log.txt
this number: 80
this number: 33
this number: 129
this number: 71
this number: 100
this number: 222
this number: 8

【实例2】对{}包围的代码使用重定向。
#!/bin/bash
{
    echo "C语言中文网";
    echo "http://c.biancheng.net";
    echo "7"
} >log.txt  #输出重定向
{
    read name;
    read url;
    read age
} <log.txt  #输入重定向
echo "$name已经$age岁了，它的网址是 $url"
将代码保存到 test.sh 并运行：
[c.biancheng.net]$ . ./test.sh
C语言中文网已经7岁了，它的网址是 http://c.biancheng.net
[c.biancheng.net]$ cat log.txt
C语言中文网
http://c.biancheng.net
7


06 第7次课-Shell脚本语言-第6讲

Shell最后一节课：周四、周五、周六、周日，复习
作业：写一下，汇总，上传

下周一开始：第二个模块->音视频技术->Draem教

三个内容

第一个内容：Shell脚本->数据库SQL语句->基础（回顾）
	1、安装mysql数据库

	2、连接数据库->登录数据库
		Dream$ mysql -u root -p
		Enter password:输入密码

	3、退出数据库
		mysql> exit
		
	4、显示所有的数据库
		mysql> show databases;
		可视化界面：appstroe买一个->100左右->正版

	5、进入数据库
		mysql> use db_test;

	6、删除数据库
		mysql> drop database db_androidpn;

	7、创建数据库
		mysql> create database db_123;

	8、创建数据库表
		mysql> create table t_student(s_id int(4) not null primary key, s_name char(20), s_sex int(4) not null default '0');

	9、显示数据库表
		mysql> show tables;

	10、插入表数据
		mysql> insert into t_student values(0, 'JAR',0);
		mysql> insert into t_student values(1, 'Andy',0);
		mysql> insert into t_student values(2, 'MN',0);

	11、查询表数据
		mysql> select * from t_student;
		mysql> select * from t_student where s_id = 2;
		子查询、排序

	12、更新表数据
		mysql> update t_student set s_sex=1 where s_name='MN';

	13、删除表数据
		mysql> delete from t_student where s_id = 1;

第二个内容：Shell脚本语言->数据库操作->在Shell脚本应用
	1、登录数据库
		脚本代码->fileA.sh
			#!/bin/bash
			MYSQL=$(which mysql)
			$MYSQL -u root -p
		执行脚本
			Dream$ ./fileA.sh
	2、退出数据库
		脚本代码->fileA.sh
			#!/bin/bash
			MYSQL=$(which mysql)
			$MYSQL -u root -p -e 'exit'
		执行脚本
			Dream$ ./fileA.sh
		总结分析
			"$MYSQL -u root -p"表示登录数据库
			"-e"表示执行某一个SQL语句
			"-e 'exit'"表示执行数据库命令

	3、显示数据库列表
		脚本代码
			#!/bin/bash
			MYSQL=$(which mysql)
			$MYSQL -u root -p -e 'show databases'
		执行脚本
			Dream$ ./fileA.sh
		总结分析
			-e 'SQL语句'

	4、查询数据库表
		案例一：错误代码
			脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				$MYSQL -u root -p -e 'select * from t_student'
			执行脚本
				Dream$ ./fileA.sh
				ERROR 1046 (3D000) at line 1: No database selected
		案例二：正确代码
			脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				$MYSQL db_20171108 -u root -p -e 'select * from t_student'
			执行脚本
				Dream$ ./fileA.sh
				+------+--------+-------+
					| s_id | s_name | s_sex |
					+------+--------+-------+
					|    0 | JAR    |     0 |
					|    2 | MN     |     1 |
					+------+--------+-------+

		总结分析
			注意：在用户名之前，指定要查询数据库
			例如：mysql db_20171108 -u root -p -e 'select * from t_student'

	5、查询数据库表->开始标记和结束标记->输入重定向
		复习语法
			JAR 
			代码 
			JAR
		脚本代码
			#!/bin/bash
			MYSQL=$(which mysql)
			$MYSQL db_20171108 -u root -p << JAR
			select * from t_student;
			JAR
		执行脚本
			Dream$ ./fileA.sh
			s_id	s_name	s_sex
			0	JAR		0
			2	MN		1
	6、插入表数据
		案例一：写死了
			脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				$MYSQL db_20171108 -u root -p << JAR
				insert into t_student values(3, 'Ricky',0);
				JAR
			执行脚本
				Dream$ ./fileA.sh

		案例二：动态传递参数，并且还要获得数据库SQL执行状态
			脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				#不等于某个长度-> "-ne"
				if [ $# -ne 3 ] 
				then 
					echo "参数个数不对，必需是3个参数"
				else
					#插入数据
					$MYSQL db_20171108 -u root -p << JAR
					insert into t_student values($1, '$2', $3);
					JAR
					#执行状态
					if [ $? -eq 0 ]
					then
						echo "插入成功"
					else
						echo "插入失败"
					fi
				fi
			执行脚本
				Dream$ ./fileA.sh

	7、插入数据+更新数据
		脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				#不等于某个长度-> "-ne"
				#需要：参数列表是5个参数，前3个是插入
				#第四个参数是条件，第五个参数是值
				if [ $# -ne 5 ] 
				then 
					echo "参数个数不对，必需是5个参数"
				else
					#插入数据
					$MYSQL db_20171108 -u root -p << JAR
					insert into t_student values($1, '$2', $3);
					JAR
					#执行状态
					if [ $? -eq 0 ]
					then
						echo "插入成功"
					else
						echo "插入失败"
					fi
					
					#更新数据
					$MYSQL db_20171108 -u root -p << ANDY
					update t_student set s_sex=$5 where s_id=$4;
					ANDY
					#执行状态
					if [ $? -eq 0 ]
					then
						echo "更新成功"
					else
						echo "更新失败"
					fi
				fi
				
			执行脚本
				Dream$ ./fileA.sh

	8、坑爹了？每次都要输入密码，想死？->解决这个问题？
		第一步：在mysql安装目录下找到一个mysql配置文件
			windwos系统下：配置文件名称->my.ini
			mac系统下：配置文件名称->my.cnf
			配置了mysql启动相关配置参数
			文件目录：/usr/local/mysql-5.7.17-macos10.12-x86_64/support-files下，找到my-default.cnf文件
		第二步：拷贝到桌面，进行修改，添加默认密码，并且将"my-default.cnf"名称修改为"my.cnf"
		第三步：将"my.cnf"文件拷贝到mysql数据库执行目录
			命令查看目录：Dream$ mysql —help -verbose | grep -B1 -i "my.cnf"
			选定了目录：/etc
		第四步：重启mysql数据库
		第五步：测试命令行
		第六步：测试脚本
	
	9、无需密码->操作数据库？
		注意：将"-p"去掉即可
		脚本代码
				#!/bin/bash
				MYSQL=$(which mysql)
				#不等于某个长度-> "-ne"
				#需要：参数列表是5个参数，前3个是插入
				#第四个参数是条件，第五个参数是值
				if [ $# -ne 5 ] 
				then 
					echo "参数个数不对，必需是5个参数"
				else
					#插入数据
					$MYSQL db_20171108 -u root << JAR
					insert into t_student values($1, '$2', $3);
					JAR
					#执行状态
					if [ $? -eq 0 ]
					then
						echo "插入成功"
					else
						echo "插入失败"
					fi
					
					#更新数据
					$MYSQL db_20171108 -u root << ANDY
					update t_student set s_sex=$5 where s_id=$4;
					ANDY
					#执行状态
					if [ $? -eq 0 ]
					then
						echo "更新成功"
					else
						echo "更新失败"
					fi
				fi
				
			执行脚本
				Dream$ ./fileA.sh
			
	10、结合上一节课讲解内容，统一来进行测试
		脚本实现
			#!/bin/bash
			#定义域分隔符->分割字符串
			IFS=','
			MYSQL=$(which mysql)
			while read id name sex
			do
				$MYSQL db_20171108 -u root << EOF
				insert into t_student(s_id, s_name, s_sex) values ($id,'$name', $sex);
			EOF
			done < ${1}
		执行脚本
			Dream$ ./fileA.sh

内容三：扩展知识->简单发送消息？
	第一步：确定系统所有用户
		 命令代码
			Dream$ who
			Dream    console  Nov  8 12:28 
			Dream    ttys000  Nov  8 22:39 
			Dream    ttys001  Nov  8 22:40
		分析结果
			参数一：用户名
			参数二：用户所在终端
			参数三：用户登录时间
	第二步：启动发消息功能
		命令代码
			Dream$ mesg
			is y
		分析结果
			"is y"表示有发消息的权限（开启了功能）
			"is n"表示没有发消息的权限（没有开启）
	第三步：查看消息状态
		命令代码
			Dream$ who -T
			Dream    - console  Nov  8 12:28 
			Dream    + ttys000  Nov  8 22:39 
			Dream    + ttys001  Nov  8 22:40 
		分析结果
			"-"表示没有开启发消息功能
			"+"表示开通了发消息功能
	第四步：发送消息
		命令代码
			Dream$ write Dream ttys001

	第五步：开启消息功能
		命令代码
			Dream$ mesg y
			
			
			
ffmpeg学习

1  下载音视频框架
		两种方式
		第一种：上网下载->非常简单
			下载网址：http://www.ffmpeg.org/download.html
		第二种：通过Shell脚本下载音视频框架
			脚本代码
			1  ffmpeg-download.sh文件内容：
			
				#!/bin/bash

				#库名称
				source="ffmpeg-3.4"
				#下载这个库
				if [ ! -r $source ]
				then
				#没有下载，那么我需要执行下载操作
					echo "没有FFmpeg库，我们需要下载….."
				#下载：怎么下载？
				#"curl"命令表示：它可以通过Http\ftp等等这样的网络方式下载和上传文件（它是一个强大网络工具）
				#基本格式：curl 地址
				#指定下载版本
				#下载完成之后，那么我们需要解压(通过自动解压)
				#"tar"命令：表示解压和压缩（打包）
				#基本语法：tar options
				#例如：tar xj
				#options选项分为很多中类型
				#-x 表示：解压文件选项
				#-j 表示：是否需要解压bz2压缩包（压缩包格式类型有很多：zip、bz2等等…）
					curl http://ffmpeg.org/releases/${source}.tar.bz2 | tar xj || exit 1
				fi

       上面代码说明：
			   文件表达式  if [ ! -r $source ] 如果文件不可读
		-e filename 如果 filename存在，则为真
		-d filename 如果 filename为目录，则为真 
		-f filename 如果 filename为常规文件，则为真
		-L filename 如果 filename为符号链接，则为真
		-r filename 如果 filename可读，则为真 
		-w filename 如果 filename可写，则为真 
		-x filename 如果 filename可执行，则为真
		-s filename 如果文件长度不为0，则为真
		-h filename 如果文件是软链接，则为真
		filename1 -nt filename2 如果 filename1比 filename2新，则为真。
		filename1 -ot filename2 如果 filename1比 filename2旧，则为真。
		
		curl http://ffmpeg.org/releases/${source}.tar.bz2 | tar xj || exit 1
		下载文件 管道（前一个命令结果作为输入到后一个命令） 解压文件tar xj  || exit 1（或操作表示如果解压下载失败或则退出了）

        2  切换到ffmpeg-download.sh所在目录下：
           chmod +x ./ffmpeg-download.sh 添加可执行权限
        3  ./ffmpeg-download.sh 执行下载
        
        
02-FFmpeg-脚本-分析FFmpeg编译配置选项

       1 FFmpeg查看配置命令
       
       查看FFmpeg音视频编译配置选项
		1、查看选项
			首先：进入FFmpeg框架包中
			其次：执行命令->查看配置
				./configure --help	
		2、解释这些选项
        Usage: configure [options]  用法
        Options: [defaults in brackets after descriptions]  下面是参数
        
帮助选项：
        Help options:  
  --help                    显示此帮助信息
  --quiet                   静默工作,不输出版本、工作信息
  --list-decoders          显示所有可用的解码器（h264/mjpeg等）
  --list-encoders          显示所有可用的编码器（h264/mjpeg等）
  --list-hwaccels          显示所有支持的硬编解码器（h264_videotoolbox/h264_mediacodec等）
  --list-demuxers          显示所有支持解复用的容器（mp4/h264等），容器中支持哪些音频流、视频流、字幕流、数据流格式
  --list-muxers            显示所有支持复用的容器（mp4/h264等）
  --list-parsers           显示全部可用的分析器
  --list-protocols         显示所有支持的传输协议（rtmp/rtp等）
  --list-bsfs              显示所有可用的格式转换（h264_mp4toannexb/aac_adtstoasc等）
  --list-indevs            显示所有支持的输入设备（alsa/v4l2等）
  --list-outdevs           显示所有支持的输出设备（alsa/opengl等）
  --list-filters           显示支持的所有过滤器（scale/volume/fps/allyuv等）
  
标准选项：日志 静动态库输出位置 头文件 主文件的位置
  --logfile=FILE           配置过程中的log输出文件，默认输出到当前位置的ffbuild/config.log文件
  --disable-logging        配置过程中不输出日志
  --fatal-warnings         把配置过程中的任何警告当做致命的错误处理
  --prefix=PREFIX          设定安装的跟目录，如果不指定默认是 [/usr/local]
  --bindir=DIR             设置可执行程序的安装位置，默认是[PREFIX/bin]
  --datadir=DIR            设置测试程序以及数据的安装位置，默认是 [PREFIX/share/ffmpeg]
  --docdir=DIR             设置文档的安装目录，默认是[PREFIX/share/doc/ffmpeg]
  --libdir=DIR             设置静态库的安装位置，默认是 [PREFIX/lib]
  --shlibdir=DIR           设置动态库的安装位置，默认是 [LIBDIR]
  --incdir=DIR             设置头文件的安装位置，默认是[PREFIX/include]；一般来说用于依赖此头文件来开发就够了
  --mandir=DIR             设置man文件的安装目录，默认是[PREFIX/share/man]
  --pkgconfigdir=DIR       设置pkgconfig的安装目录，默认是[LIBDIR/pkgconfig]，只有--enable-shared使能的时候这个选项才有效
  --enable-rpath           允许使用rpath方式安装库，不是通过动态链接器搜索路径，链接使用rpath方式，小心使用
  --install-name-dir=DIR   安装目标Darwin 目录的名称

Licensing options:许可选项（包括可以扩展不侵权的功能）
选择许可证，FFMPEG默认许可证LGPL 2.1，如果需要加gpl的库需要使用gpl的许可证，例如libx264就是gpl的，
如果需要加入libx264则需要--enable-gpl。GPL（许可证）：开源、免费、公用、修改、扩展

  --enable-gpl             允许使用GPL代码，由此生成你的库或者二进制文件	
  --enable-version3        upgrade (L)GPL to version 3 [no]
  --enable-nonfree         allow use of nonfree code, the resulting libs
                           and binaries will be unredistributable [no]
                           
                           
配置选项（Configuration options）： 是否生成静动态库 加速器开启 是否可编译可执行， 全灰度支持，运行时功能
  --disable-static         不生成静态库，默认生成静态库
  --enable-shared          生成动态库，默认不生成动态库
  --enable-small           加速器优化，默认是开启的
  --disable-runtime-cpudetect 在运行时禁用检测CPU功能（较小的二进制文件）
  --enable-gray            启用全灰度支持（较慢的颜色）
  --disable-swscale-alpha  禁用swscale中的alpha通道支持
  --disable-all            禁止编译所有库和可执行程序
  --disable-autodetect     增加主版本号
  

程序选项（Program options）

可执行程序开启选项，默认编译ffmpeg中的所有可执行程序，包括ffmpeg、ffplay、ffprobe、ffserver，
不过Mac平台默认情况下不生成ffplay，目前暂未知道啥原因。

选项	说明
–disable-programs	do not build command line programs
–disable-ffmpeg	disable ffmpeg build
–disable-ffplay	disable ffplay build
–disable-ffprobe	disable ffprobe build
–disable-ffserver	disable ffserver build


文档选项（Documentation options）

离线文档选择

选项	说明
–disable-doc	do not build documentation
–disable-htmlpages	do not build HTML documentation pages
–disable-manpages	do not build man documentation pages
–disable-podpages	do not build POD documentation pages
–disable-txtpages	do not build text documentation pages



组件选项（Component options）
除了avresample模块，默认编译所有模块。一般来说用于轻量化ffmpeg库的大小，可以仅仅开启指定某些组件的某些功能。

选项	说明
–disable-avdevice	disable libavdevice build
–disable-avcodec	disable libavcodec build
–disable-avformat	disable libavformat build
–disable-swresample	disable libswresample build
–disable-swscale	disable libswscale build
–disable-postproc	disable libpostproc build
–disable-avfilter	disable libavfilter build
–enable-avresample	enable libavresample build [no]
–disable-pthreads	disable pthreads [autodetect]
–disable-w32threads	disable Win32 threads [autodetect]
–disable-os2threads	disable OS/2 threads [autodetect]
–disable-network	disable network support [no]
–disable-dct	disable DCT code
–disable-dwt	disable DWT code
–disable-error-resilience	disable error resilience code
–disable-lsp	disable LSP code
–disable-lzo	disable LZO decoder code
–disable-mdct	disable MDCT code
–disable-rdft	disable RDFT code
–disable-fft	disable FFT code
–disable-faan	disable floating point AAN (I)DCT code
–disable-pixelutils	disable pixel utils in libavutil 
 
 
 
个别组件选项（Individual component options）
可以用于设定开启指定功能，例如禁止所有encoders编码器，过滤器，硬编码开启关闭等，在这里可以开启特定的encoders（x264、aac等）

选项	说明
–disable-everything	disable all components listed below
–disable-encoder=NAME	disable encoder NAME
–enable-encoder=NAME	enable encoder NAME
–disable-encoders	disable all encoders
–disable-decoder=NAME	disable decoder NAME
–enable-decoder=NAME	enable decoder NAME
–disable-decoders	disable all decoders
–disable-hwaccel=NAME	disable hwaccel NAME
–enable-hwaccel=NAME	enable hwaccel NAME
–disable-hwaccels	disable all hwaccels
–disable-muxer=NAME	disable muxer NAME
–enable-muxer=NAME	enable muxer NAME
–disable-muxers	disable all muxers
–disable-demuxer=NAME	disable demuxer NAME
–enable-demuxer=NAME	enable demuxer NAME
–disable-demuxers	disable all demuxers
–enable-parser=NAME	enable parser NAME
–disable-parser=NAME	disable parser NAME
–disable-parsers	disable all parsers
–enable-bsf=NAME	enable bitstream filter NAME
–disable-bsf=NAME	disable bitstream filter NAME
–disable-bsfs	disable all bitstream filters
–enable-protocol=NAME	enable protocol NAME
–disable-protocol=NAME	disable protocol NAME
–disable-protocols	disable all protocols
–enable-indev=NAME	enable input device NAME
–disable-indev=NAME	disable input device NAME
–disable-indevs	disable input devices
–enable-outdev=NAME	enable output device NAME
–disable-outdev=NAME	disable output device NAME
–disable-outdevs	disable output devices
–disable-devices	disable all devices
–enable-filter=NAME	enable filter NAME
–disable-filter=NAME	disable filter NAME
–disable-filters	disable all filters 



External library support：外部库支持  重要：
ffmpeg提供的一些功能是由其他扩展库支持的，如果使用这些扩展库需要明确申明，，确定编译的第三方库的目标架构--arch相同就好了，
在编译ffmpeg的时候需加入第三方库的头文和库搜索路径（通过extra-cflags和extra-ldflags指定即可），剩下的事ffmpeg都给你做好了。
扩展了很多功能模块

libx264例子 
ffmpeg集成libx264官方文档
$ git clone http://source.ffmpeg.org/git/ffmpeg.git
$ cd x264
$ ./configure --prefix=$FFMPEG_PREFIX --enable-static --enable-shared
$ make -j8 && make install 


–enable-avisynth	启用AviSynth脚本文件的读取默认[否]
–disable-bzlib	    禁用bzlib[自动检测]
–enable-chromaprint	启用带ChromaPrint的音频指纹[否]
–enable-frei0r	    启用frei0r视频过滤[否]
–enable-gcrypt	    如果未使用openssl、librtmp或gmp，则需要支持rtmp（t）e[no]
–enable-gmp	        启用gmp，如果未使用openssl或librtmp，则需要rtmp（t）e支持[no]
–enable-gnutls	    启用gnutls，如果未使用openssl，则需要用于https支持[no]
–disable-iconv	    禁用iconv[自动检测]
–enable-jni	enable  启用JNI支持[否]
–enable-ladspa	    启用ladspa音频过滤[否]
–enable-libass	    启用libass字幕渲染，字幕和ass过滤器需要[no]
–enable-libbluray	使用libbluray启用bluray读取[否]
–enable-libbs2b	    启用bs2b dsp库[否]
–enable-libcaca	    使用libcaca启用文本显示[否]
–enable-libcelt	    通过libcelt启用celt解码[否]
–enable-libcdio	    使用libcdio启用音频CD抓取[否]
–enable-libdc1394	使用libdc1394和libw1394启用IIDC-1394抓取[否]
–enable-libebur128	启用libebur128进行ebu R128测量，LoudNorm滤波器需要[NO]
–enable-libfdk-aac	通过libfdk aac启用aac de/编码[否]
–enable-libflite	启用libflite（语音合成）支持[否]
–enable-libfontconfig	启用libfontconfig，对drawtext过滤器很有用[no]
–enable-libfreetype	启用drawtext筛选器所需的libfreetype[否]
–enable-libfribidi	启用libfribidi，改进drawtext过滤器[否]
–enable-libgme	    通过libgme启用游戏音乐emu[否]
–enable-libgsm	    通过libgsm启用gsm de/编码[否]
–enable-libiec61883	通过libiec61883启用iec61883[否]
–enable-libilbc	    通过libilbc启用ilbc de/encoding[否]
–enable-libkvazaar	通过libkvazaar启用HEVC编码[否]
–enable-libmodplug	启用libmodplug启用modplug[否]
–enable-libmp3lame	通过LIBMP3LAME启用MP3编码[否]
–enable-libnut	    启用nut（de）muxing，本地（de）muxer存在[no]
–enable-libopencore-amrnb	amrnb启用amr-nb de/编码[否]
–enable-libopencore-amrwb	通过libopencore amrwb进行amr-wb解码[否]
–enable-libopencv	通过libopencv启用视频过滤[否]
–enable-libopenh264	通过openh264启用H.264编码[否]
–enable-libopenjpeg	通过openjpeg启用jpeg 2000 de/编码[否]
–enable-libopenmpt	启用通过libopenmpt解码跟踪文件[否]
–enable-libopus	    通过libopus启用opus de/编码[否]
–enable-libpulse	通过libpulse启用pulseaudio输入[no]
–enable-librubberband	启用rubberband过滤器所需的rubberband[否]
–enable-librtmp	     通过librtmp启用rtmp[e]支持[否]
–enable-libschroedinger	通过libschroedinger启用dirac de/encoding[否]
–enable-libshine	通过libshine启用定点MP3编码[否]
–enable-libsmbclient	启用libsmbclient启用samba协议[否]
–enable-libsnappy	启用hap编码所需的snappy压缩[no]
–enable-libsoxr	    启用包括libsoxr重新采样[否]
–enable-libspeex	启用包括libsoxr重新采样[否]
–enable-libssh	    启用libssh启用sftp协议[否]
–enable-libtesseract	启用OCR过滤器所需的tesseract[否]
–enable-libtheora	通过libtheora启用theora编码[否]
–enable-libtwolame	通过libtwolame启用MP2编码[否]
–enable-libv4l2	enable 启用libv4l2/v4l实用程序[否]
–enable-libvidstab	使用vid.stab启用视频稳定[否]
–enable-libvo-amrwbenc	通过libvo amrwbenc启用amr-wb编码[否]
–enable-libvorbis	通过libvorbis启用vorbis en/解码，存在本机实现[no]
–enable-libvpx	    通过libvpx启用vp8和vp9 de/编码[否]
–enable-libwavpack	通过libwavpack启用wavpack编码[否]
–enable-libwebp	    通过libwebp启用webp编码[否]
–enable-libx264	    通过x264启用H.264编码[否]
–enable-libx265	    通过X265启用HEVC编码[否]
–enable-libxavs	    通过xavs启用avs编码[否]
–enable-libxcb	    使用xcb启用x11抓取[autodetect]
–enable-libxcb-shm	启用x11抓取shm通信[自动检测]
–enable-libxcb-xfixes	启用x11抓取鼠标呈现[自动检测]
–enable-libxcb-shape	启用x11抓取形状呈现[自动检测]
–enable-libxvid	    通过xvidcore启用xvid编码，存在本机MPEG-4/xvid编码器[否]
–enable-libzimg	    筛选器所需的libzimg enable z.lib[no]
–enable-libzmq	    启用通过libzmq传递消息[否]
–enable-libzvbi	    通过libzvbi启用远程文本支持[否]
–disable-lzma	    禁用LZMA[自动检测]
–enable-decklink	启用Blackmagic decklink I/O支持[否]
–enable-mediacodec	启用Android Mediacodec支持[否]
–enable-netcdf	启用netcdf，Sofizer过滤器需要[no]
–enable-openal	启用Openal 1.1捕获支持[否]
–enable-opencl	启用opencl代码
–enable-opengl	启用OpenGL渲染[否]
–enable-openssl	启用openssl，如果gnutls为n，则需要用于https支持
–disable-schannel 如果未使用openssl和gnutls，则Windows上的tls支持需要disable schannel ssp[autodetect]
–disable-sdl2	disable sdl2[自动检测]
–disable-securetransport	 如果未使用openssl和gnutls，则OSX上的TLS支持需要禁用安全传输[autodetect]
–enable-x11grab	启用x11抓取（旧版）[no]
–disable-xlib	禁用xlib[自动检测]
–disable-zlib	禁用zlib[自动检测]



硬件加速功能：
ffmpeg默认实现了移动端（Android和IOS）的硬编解码，可以选择disable的都是默认开启的，可以关闭，
可以选择enable的都是需要自己解决依赖的。开和关闭一些渲染器
以下库提供各种硬件加速功能（ The following libraries provide various hardware acceleration features）

–disable-audiotoolbox	禁用音频工具箱禁用Apple音频工具箱代码[自动检测]
–enable-cuda	启用动态链接的NVIDIA CUDA代码[否]
–enable-cuvid	enable Nvidia CUVID support [autodetect]
–disable-d3d11va	启用nvidia cuvid支持[自动检测]
–disable-dxva2	禁用Microsoft Direct3D 11视频加速代码[自动检测]
–enable-libmfx	通过libmfx启用Intel MediaSDK（即快速同步视频）代码[否]
–enable-libnpp	启用基于Nvidia性能原语的代码[否]
–enable-mmal	启用mmal启用Broadcom多媒体抽象层（Raspberry PI）[否]
–disable-nvenc	禁用NVIDIA视频编码代码[自动检测]
–enable-omx	    启用OpenMax IL代码[否]
–enable-omx-rpi	启用树莓pi的openmax il代码[否]
–disable-vaapi	 vaapi disable video acceleration api（主要是unix/intel）code[autodetect]
–disable-vda	禁用Apple视频解码加速代码[自动检测]
–disable-vdpau	disable Nvidia Video Decode and Presentation API for Unix code [autodetect]
–disable-videotoolbox	disable VideoToolbox code [autodetect]
 
 
Toolchain options：
工具链选项（指定我么需要编译平台CPU架构类型，例如：arm64、x86等等…）
fmpeg代码本身是支持跨平台的，要编译不同的平台需要配置不同平台的交叉编译工具链。ffmpeg都是c代码，
所以不需要配置c++的sysroot。常用的就几个arch,cpu,cross-prefix,enable-cross-compile,sysroot,target-os,
extra-cflags,extra-ldflags,enable-pic。现在Android和IOS几乎没有armv5的设备了，
所以如果编译这两个平台配置armv7和armv8就好了。

–arch=ARCH	选择目标架构[armv7a/aarch64/x86/x86_64等]
–cpu=CPU	选择目标cpu[armv7-a/armv8-a/x86/x86_64]
–cross-prefix=PREFIX	设定交叉编译工具链的前缀,不算gcc/nm/as命令，例如android 32位的交叉编译链
                        $ndk_dir/toolchains/arm-linux-androideabi-$toolchain_version/prebuilt/
                        linux-$host_arch/bin/arm-linux-androideabi-
–progs-suffix=SUFFIX	程序名称后缀 []
–enable-cross-compile	如果目标平台和编译平台不同则需要使用它
–sysroot=PATH	    交叉工具链的头文件和库位，例如Android 32位位置$ndk_dir/platforms/android-14/arch-arm
–sysinclude=PATH	交叉编译系统头文件的位置
–target-os=OS	    设置目标系统
–target-exec=CMD	在目标上运行可执行文件的命令
–target-path=DIR	目标上生成目录的视图路径
–target-samples=DIR	目标上samples目录的路径
–tempprefix=PATH	强制修改 dir/prefix  而不是mktemp用于检查
–toolchain=NAME	    根据名称设置工具默认值
–nm=NM	            使用NM工具NM[NM-G]
–ar=AR	            使用存档工具ar[ar]
–as=AS	use assembler AS []
–ln_s=LN_S	        使用符号链接工具ln_s[ln-s-f]
–strip=STRIP	    使用剪切工具条[strip]
–windres=WINDRES	使用Windows资源编译器windres[windres] 
–yasmexe=EXE	    使用与yasm兼容的汇编程序exe[yasm]
–cc=CC	            使用c编译器c c[gcc]
–cxx=CXX	        使用C编译器cxx[g++]
–objcc=OCC	        使用objc编译器occ[gcc]
–dep-cc=DEPCC	    使用依赖生成器dep cc[gcc]
–ld=LD	            使用链接器ld[]
–pkg-config=PKGCONFIG	使用pkg config工具pkg config[pkg config]
–pkg-config-flags=FLAGS	 将附加标志传递给pkgconf[]
–ranlib=RANLIB	    使用ranlib ranlib[ranlib]
–doxygen=DOXYGEN	使用doxygen生成api文档[doxygen]
–host-cc=HOSTCC	    使用主机c编译器host c c
–host-cflags=HCFLAGS	为主机编译时使用hcflags
–host-cppflags=HCPPFLAGS	为主机编译时使用hcppflags
–host-ld=HOSTLD	        使用主机链接器host ld
–host-ldflags=HLDFLAGS	链接主机时使用hldflags
–host-libs=HLIBS	    主机链接时使用libs hlibs
–host-os=OS         编译器主机OS[]
–extra-cflags=ECFLAGS	设置cflags，如果是Android平台可以根据ndk内的设定,arm-linux-androideabi-4.6/setup.mk，
                        建议参考你当前的setup来配置
–extra-cxxflags=ECFLAGS	将ecflags添加到cxflags[]
–extra-objcflags=FLAGS	将标记添加到objclags[]
–extra-ldflags=ELDFLAGS	参考cflags
–extra-ldexeflags=ELDFLAGS	将eldFlags添加到ldExeFlags[]
–extra-ldlibflags=ELDFLAGS	将eldflags添加到ldlibflags[]
–extra-libs=ELIBS	    添加elibs[]
–extra-version=STRING	版本字符串后缀[]
–optflags=OPTFLAGS	    重写与优化相关的编译器标志
–build-suffix=SUFFIX	库名称后缀[]
–enable-pic	build       构建位置独立代码    
–enable-thumb	指令集的Thumb编译设置
–enable-lto	    覆盖环境变量


高级选项（Advanced options）

–malloc-prefix=PREFIX	malloc和带前缀的相关名称
–custom-allocator=NAME	使用支持的自定义分配器
–disable-symver	        禁用符号版本控制
–enable-hardcoded-tables	使用硬编码表而不是运行时生成
–disable-safe-bitstream-reader	禁用位读卡器中的缓冲区边界检查（更快，但可能崩溃）
–enable-memalign-hack	模拟memAlign，干扰内存调试程序
–sws-max-filter-size=N	最大过滤器尺寸swscale使用[256] 
–env=”ENV=override”	重写环境变量



优化选项（Optimization options）

默认开启各个平台的汇编优化，有些嵌入式平台可能并不能完整的支持架构的所有汇编指令，
所以需要关闭。（自己理解的，没有实战）

–disable-asm	禁用所有程序集优化
–disable-altivec	禁用Altivec优化
–disable-vsx	disable VSX optimizations
–disable-power8	disable POWER8 optimizations
–disable-amd3dnow	disable 3DNow! optimizations
–disable-amd3dnowext	disable 3DNow! extended optimizations
–disable-mmx	disable MMX optimizations
–disable-mmxext	disable MMXEXT optimizations
–disable-sse	disable SSE optimizations
–disable-sse2	disable SSE2 optimizations
–disable-sse3	disable SSE3 optimizations
–disable-ssse3	disable SSSE3 optimizations
–disable-sse4	disable SSE4 optimizations
–disable-sse42	disable SSE4.2 optimizations
–disable-avx	disable AVX optimizations
–disable-xop	disable XOP optimizations
–disable-fma3	disable FMA3 optimizations
–disable-fma4	disable FMA4 optimizations
–disable-avx2	disable AVX2 optimizations
–disable-aesni	disable AESNI optimizations
–disable-armv5te	disable armv5te optimizations
–disable-armv6	disable armv6 optimizations
–disable-armv6t2	disable armv6t2 optimizations
–disable-vfp	disable VFP optimizations
–disable-neon	disable NEON optimizations
–disable-inline-asm	disable use of inline assembly
–disable-yasm	disable use of nasm/yasm assembly
–disable-mipsdsp	disable MIPS DSP ASE R1 optimizations
–disable-mipsdspr2	disable MIPS DSP ASE R2 optimizations
–disable-msa	disable MSA optimizations
–disable-mipsfpu	disable floating point MIPS optimizations
–disable-mmi	disable Loongson SIMD optimizations
–disable-fast-unaligned	consider unaligned accesses slow 



开发者选项（Developer options）

调试用的一些开关
–disable-debug	禁用调试符号
–enable-debug=LEVEL	设置调试级别[]
–disable-optimizations	禁用编译器优化
–enable-extra-warnings	启用更多编译器警告
–disable-stripping	禁用剥离可执行文件和共享库
–assert-level=level	断言级别=级别0（默认值）、1或2、断言测试数量、2会导致运行时速度减慢。
–enable-memory-poisoning	使用任意数据填充未初始化的已分配空间堆
–valgrind=VALGRIND	通过valgrind运行“make fate”测试，
                    使用指定的valgrind二进制文件检测内存泄漏和错误。不能与–target exec组合使用
–enable-ftrapv	陷阱算术溢出
–samples=PATH	测试样本的路径位置, 如果没有设置则在make调用时使用$FATE_SAMPLES 
–enable-neon-clobber-test	测试检查neon寄存器的clobbering（应仅用于调试目的）
–enable-xmm-clobber-test	寄存器进行clobbering（仅限Win64；应仅用于调试目的）
–enable-random	随机启用/禁用组件
–disable-random	
–enable-random=LIST	列出随机启用/禁用特定组件或
–disable-random=LIST	component groups. LIST is a comma-separated list of NAME[:PROB] entries where NAME is a component (group) and PROB the probability associated with
–random-seed=VALUE	种子值–启用/禁用随机
–disable-valgrind-backtrace	  backtrace不要在valgrind下打印backtrace（仅适用于–disable optimizations builds）





#!/bin/bash

#1、首先：定义下载的库名称 的变量
source="ffmpeg-3.4"

#2、其次：定义".h/.m/.c"文件编译的结果目录
#目录作用：用于保存.h/.m/.c文件编译后的结果.o文件 创建.o文件的编译目录  用于保存.h/.m/.c文件编译后的结果.o文件
cache="cache"

#3、定义".a"静态库保存目录
#pwd命令：表示获取当前目录 返引号中代表shell命令 
staticdir=`pwd`/"dream-ffmpeg-iOS"

#4、添加FFmpeg配置选项->默认配置
#Toolchain options:工具链选项（指定我么需要编译平台CPU架构类型，例如：arm64、x86等等…）
#--enable-cross-compile: 交叉编译
#Developer options:开发者选项
#--disable-debug: 禁止使用调试模式
#Program options选项
#--disable-programs:禁用程序(不允许建立命令行程序)
#Documentation options：文档选项
#--disable-doc：不需要编译文档
#Toolchain options：工具链选项
#--enable-pic：允许建立与位置无关代码
configure_flags="--enable-cross-compile --disable-debug --disable-programs --disable-doc --enable-pic"

#5、定义默认CPU平台架构类型
#arm64 armv7->真机->CPU架构类型
#x86_64 i386->模拟器->CPU架构类型
archs="arm64 armv7 x86_64 i386"

#6、指定我们的这个库编译系统版本->iOS系统下的7.0以及以上版本使用这个静态库
targetversion="7.0"

#7、接受命令后输入参数
#我是动态接受命令行输入CPU平台架构类型(输入参数：编译指定的CPU库)
if [ "$*" ]
then
    #存在输入参数，也就说：外部指定需要编译CPU架构类型，如果未传能数，那默认编译支持"arm64 armv7 x86_64 i386"，
    #但如果传参，则按传入的平台参数进行编译
    archs="$*"
fi

#8、安装汇编器->yasm
#判断一下是否存在这个汇编器
#目的：通过软件管理器(Homebrew)，然后下载安装（或者更新）我的汇编器
#一个命令就能够帮助我们完成所有的操作
#错误一：`which` yasm
#正确一：`which yasm`
if [ ! `which yasm`  ]
then
    #Homebrew:软件管理器
    #下载一个软件管理器:安装、卸载、更新、搜索等等...
    #错误二：`which` brew
    #正确二：`which brew`
    if [ ! `which brew` ]
    then
        echo "安装brew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || exit 1
    fi
    echo "安装yasm"
    #成功了
    #下载安装这个汇编器
    #exit 1->安装失败了，那么退出程序
    brew install yasm || exit 1
fi

echo "循环编译"

#9、for循环编译FFmpeg静态库
currentdir=`pwd`
for arch in $archs
do
    echo "开始编译"
    #9.1、创建目录
    #在编译结果目录下-创建对应的平台架构类型目录 arm7 arm6，里面是保存.o文件
    mkdir -p "$cache/$arch"
    #9.2、进入这个目录
    cd "$cache/$arch"

    #9.3、配置编译CPU架构类型->指定当前编译CPU架构类型 Tool chain中的参数
    #错误三："--arch $arch"
    #正确三："-arch $arch"
    archflags="-arch $arch"

    #9.4、判定一下你到底是编译的是模拟器.a静态库，还是真机.a静态库 $arch是输入的字符串参数变量 -o是或者
    if [ "$arch" = "i386" -o "$arch" = "x86_64" ]
    then
        #模拟器
        platform="iPhoneSimulator"
        #支持最小系统版本->iOS系统
        archflags="$archflags -mios-simulator-version-min=$targetversion"
    else
        #真机(mac、iOS都支持)
        platform="iPhoneOS"
        #支持最小系统版本->iOS系统 -mios-version-min=$targetversion 最小版本号
        #-fembed-bitcode 编译成二进制
        archflags="$archflags -mios-version-min=$targetversion -fembed-bitcode"
        #注意:优化处理(可有可无)
        #如果架构类型是"arm64"，那么
        if [ "$arch" = "arm64" ]
        then
            #GNU汇编器（GNU Assembler），简称为GAS
            #GASPP->汇编器预处理程序
            #解决问题：分段错误
            #通俗一点：就是程序运行时,变量访问越界一类的问题
            #如果xcode5以及之前编译会出现程序运行时,变量访问越界一类的问题，分段错误
            EXPORT="GASPP_FIX_XCODE5=1"
        fi
    fi


    #10、正式编译
    #tr命令可以对来自标准输入的字符进行替换、压缩和删除
    #'[:upper:]'->将小写转成大写
    #'[:lower:]'->将大写转成小写
    #将platform->转成大写或者小写
    #echo $platform 输出一个目录，将目录转成大写或者小写，保证统一
    XCRUN_SDK=`echo $platform | tr '[:upper:]' '[:lower:]'`
    #编译器->编译平台  CC指gcc编译器
    CC="xcrun -sdk $XCRUN_SDK clang"

    #架构类型->arm64
    if [ "$arch" = "arm64" ]
    then
        #音视频默认一个编译命令 编译脚本，这是个文件，gas-preprocessor.pl能帮我们编译ffpeg
        #preprocessor.pl帮助我们编译FFmpeg->arm64位静态库
        AS="gas-preprocessor.pl -arch aarch64 -- $CC"
    else
        #不是arm64采用默认的编译器 默认编译平台
        AS="$CC"
    fi

    echo "执行到了1"

    #目录找到FFmepg编译源代码目录->设置编译配置->编译FFmpeg源码
    #--target-os:目标系统->darwin(mac系统早起版本名字)
    #darwin:是mac系统、iOS系统祖宗，是最早的系统，所以目标系统是这个
    #--arch:CPU平台架构类型
    #--cc：指定编译器类型选项，使用什么样的编译器类型
    #--as:汇编程序
    #$configure_flags最初配置
    #--extra-cflags 最小的版本号
    #--prefix：静态库输出目录
    TMPDIR=${TMPDIR/%\/} $currentdir/$source/configure \ #输出到当前目录
        --target-os=darwin \
        --arch=$arch \
        --cc="$CC" \ 
        --as="$AS" \
        $configure_flags \  #ffmpeg的配置
        --extra-cflags="$archflags" \
        --extra-ldflags="$archflags" \
        --prefix="$staticdir/$arch" \ #静态库输出目录
        || exit 1

    echo "执行了"

    #解决问题->分段错误问题
    #安装->导出静态库(编译.a静态库)
    #执行命令
    #-j设置多核线程的设置，在编译时候支持多线程的
    make -j3 install $EXPORT || exit 1  #最终安装导出到这个目录下 "$staticdir/$arch" \   $EXPORT是解决分段问题xcode5下
    #回到了我们的脚本文件目录
    cd $currentdir
done



解释：
$*和$@以及$#的区别
举例说：
脚本名称叫test.sh 入参三个: 1 2 3
运行test.sh 1 2 3后
$*为"1 2 3"（一起被引号包住）
$@为"1" "2" "3"（分别被包住）
$#为3（参数数量）


#7、接受命令后输入参数
#我是动态接受命令行输入CPU平台架构类型(输入参数：编译指定的CPU库)
if [ "$*" ]
then
    #存在输入参数，也就说：外部指定需要编译CPU架构类型，如果未传能数，那默认编译支持"arm64 armv7 x86_64 i386"，
    #但如果传参，则按传入的平台参数进行编译
    archs="$*"
fi

   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || exit 1
   
   下载并安装:
    curl下载  ruby可以在命令行中执行脚本 意思是执行curl下载的脚本,安装
    #下载安装这个汇编器
    brew install yasm || exit 1
    
    
测试是否成功：
./ffmpeg-bulid.sh arm64

if 后面要有空格

报错：
GNU assembler not found, install/update gas-preprocessor

解决方法：
1. 下载最新的gas-preprocessor.pl,地址是https://github.com/libav/gas-preprocessor
1.下载完成后打开终端 进入gas-preprocessor文件夹
cd 将文件拖进来回车
2.将文件夹内的gas-preprocessor.pl文件拷贝到/usr/sbin/目录下
sudo cp /Users/chenqiang/Downloads/gas-preprocessor-master/gas-preprocessor.pl /usr/local/bin

注意上面的sudo cp(这个地方是gas-preprocessor文件下gas-preprocessor.pl的地址,只需要将gas-preprocessor.pl文件拖进来就行了) /usr/local/bin 回车
3.修改/usr/sbin/gas-preprocessor.pl的文件权限为可执行权限
如果1.命令如果不行就使用2.命令(我当时用的是2.命令)
1.

cd /usr/local/bin
 sudo chmod 777 gas-preprocessor.pl



20171113-第8节课-FFmpeg-第1讲-编译库

FFmpeg一共：9个库->常用是7个库
选择性编译一些库，不一定编译所有？如何选择？下面配置是选择库  默认是编译的
configure_flags="--enable-cross-compile --disable-debug --disable-programs --disable-doc --enable-pic"

#核心库(编解码->最重要的库)：avcodec 音视频的编解码库--disable-avdevice不允许编译    --enable-avcodec可以编译
这些库在 组件选项（Component options）配置中
configure_flags="$configure_flags --enable-avdevice --enable-avcodec --enable-avformat"
configure_flags="$configure_flags --enable-swresample --enable-swscale --disable-postproc"
configure_flags="$configure_flags --enable-avfilter --enable-avutil --enable-avresample "



03-FFmpeg-应用-测试FFmpeg配置

1 在xcode中新建ffmpeg文件夹，把ffmepg的include头文件和lib中的.a文件拷贝进来。
2 在xcode中bulidphacs中添加依赖库
coremedia 多媒体相关
vedioToolBox  视频
audioToolBox 音频
libicon.tbd  临时生成的存储一些信息的文件，属于系统文件类似一个文件数据库
coregraphics uikit对coregraphics高度封装
libz.tbd
libbz2.tbd
3 查看库的路中是否配置
  在xcode中bulid seting中搜索libary 
  libar search path
  发现有：$(PROJECT_DIR)/工程名称／库文件路径
  $(SRCROOT)代表的项目根目录
  $(PROJECT_DIR)代表项目的二级目录及项目目库
4 查看头文件是否配置
	在xcode中bulid seting中搜索header
	在header search paths中配置头文件的路径
    $(PROJECT_DIR)/工程名称／头文件路径
5 在代码中测试ffmpeg配置信息
    新建FFmpegTest类
    
    FFmpegTest.h
    
		#import <Foundation/Foundation.h>

		//引入头文件
		//核心库->音视频编解码库
		#import <libavcodec/avcodec.h>
		//导入封装格式库
		#import <libavformat/avformat.h>

		@interface FFmpegTest : NSObject

			//测试FFmpeg配置
			+(void)ffmpegTestConfig;
	
			//打开视频文件
			+(void)ffmpegVideoOpenfile:(NSString*)filePath;
	
		@end
    
    
    FFmpegTest.m
    
    #import "FFmpegTest.h"

	@implementation FFmpegTest

		//测试FFmpeg配置
		+(void)ffmpegTestConfig{
			const char *configuration = avcodec_configuration();
			NSLog(@"配置信息: %s", configuration);
		}
	
		//打开视频文件
		+(void)ffmpegVideoOpenfile:(NSString*)filePath{
			//第一步：注册组件
			av_register_all();
		
			//第二步：打开封装格式文件
			//参数一：封装格式上下文
			AVFormatContext* avformat_context = avformat_alloc_context();
			//参数二：打开视频地址->path
			const char *url = [filePath UTF8String];
			//参数三：指定输入封装格式->默认格式
			//参数四：指定默认配置信息->默认配置
			int avformat_open_input_reuslt = avformat_open_input(&avformat_context, url, NULL, NULL);
			if (avformat_open_input_reuslt != 0){
				//失败了
				//获取错误信息
	//            char* error_info = NULL;
	//            av_strerror(avformat_open_input_reuslt, error_info, 1024);
				NSLog(@"打开文件失败");
				return;
			}
		
			NSLog(@"打开文件成功");
		
		}
	
	@end
	
	
	测试类
	ViewController.m
		#import "ViewController.h"
		#import "FFmpegTest.h"

		@interface ViewController ()

		@end

		@implementation ViewController

		- (void)viewDidLoad {
			[super viewDidLoad];
			//测试一
		//    [FFmpegTest ffmpegTestConfig];
			//测试二
		//    NSString* path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@".mov"];
			[FFmpegTest ffmpegVideoOpenfile:@""];
		}


		- (void)didReceiveMemoryWarning {
			[super didReceiveMemoryWarning];
			// Dispose of any resources that can be recreated.
		}


		@end
		
		测试：连真机投屏  quicktime player中 新建影片设置，选择iphone就可以投屏
		运行：配置信息如果成功就会打印出来
		
		
		
05-FFmpeg-应用-Android平台-新建NDK项目

动态库的编译下一节课来讲
  动态库是.so android是使用的.so动态库
  1 编译.so动态库 下节课讲解
  2 新建android平台下ndk项目 
    本身默认的android的项目是不支持c,c++开发的，需要配置
    ndk是基于c,c++底层开发的一套工具库
    开发中需要手动勾选ndk
  3 android studio
    new project 弹出界面
    application name 项目名
    company domain 公司域随便填
    package name  项目包，相当于bund id
    include c++ support 勾选
  4  傻傻的一下步，直到显示customize c++ support
    勾选上下面两项，能捕获到c++异常 C/C++出错了，那么在Java程序中，我们可以铺货这个错误，并且处理
    exceptions support(-fexceptions)
    runtime type information support(-frtti)
    c++ standard 默认选toolchain deafult
    最后完成
    安卓你需要实现的是NDK底层代码->上层Java开发你不需要关心
  5 mainactivity.java介绍
     src:（常用） 展开在包名下的文件：mainactivity.java
	 mainactivity.java刚进来的时候会调用oncreate方法，该方法会调用activity_main.xml视图
	 setcontentview(r.layout.activity_main)//将这个类和布局相关联
	 以后安卓程序，如果写代码的部份所有都放到src下


06-FFmpeg-应用-Android平台-配置FFmpeg环境
   如果是在eclipse中，需要放到libs下对应库的目录。 
   如果是在Android Studio中，则会默认匹配main下的jniLibs目录
   配置好的库都需要下面代码作链接
   target_link_libraries( # Specifies the target library.
									   native-lib avcodec-57 avfilter-6 avformat-57 avutil-55 swresample-2 swscale-4
   
   1  在src / main /jnilibs 中复制.so文件目录和.h的include目录
   
   2  配置.so动态库和引入头文件 在CMakeLists.txt文件中写入配置信息,这个文件是在app的目录下的
      不要手写，直接拿过来使用
   
			    # For more information about using CMake with Android Studio, read the
				# documentation: https://d.android.com/studio/projects/add-native-code.html

				# Sets the minimum version of CMake required to build the native library.

				cmake_minimum_required(VERSION 3.4.1)

				#FFMpeg配置
				#FFmpeg配置目录
				set(distribution_DIR ${CMAKE_SOURCE_DIR}/../../../../src/main/jniLibs)

				# 编解码(最重要的库)
				add_library(
							avcodec-57
							SHARED
							IMPORTED)
				set_target_properties(
							avcodec-57
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libavcodec-57.so)


				# 滤镜特效处理库
				add_library(
							avfilter-6
							SHARED
							IMPORTED)
				set_target_properties(
							avfilter-6
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libavfilter-6.so)

				# 封装格式处理库
				add_library(
							avformat-57
							SHARED
							IMPORTED)
				set_target_properties(
							avformat-57
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libavformat-57.so)

				# 工具库(大部分库都需要这个库的支持)
				add_library(
							avutil-55
							SHARED
							IMPORTED)
				set_target_properties(
							avutil-55
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libavutil-55.so)

				# 音频采样数据格式转换库
				add_library(
							swresample-2
							SHARED
							IMPORTED)
				set_target_properties(
							swresample-2
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libswresample-2.so)

				# 视频像素数据格式转换
				add_library(
							swscale-4
							SHARED
							IMPORTED)
				set_target_properties(
							swscale-4
							PROPERTIES IMPORTED_LOCATION
							../../../../src/main/jniLibs/armeabi/libswscale-4.so)


				#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
				#判断编译器类型,如果是gcc编译器,则在编译选项中加入c++11支持
				if(CMAKE_COMPILER_IS_GNUCXX)
					set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
					message(STATUS "optional:-std=c++11")
				endif(CMAKE_COMPILER_IS_GNUCXX)


				#配置编译的头文件
				include_directories(src/main/jniLibs/include)




				# Creates and names a library, sets it as either STATIC
				# or SHARED, and provides the relative paths to its source code.
				# You can define multiple libraries, and CMake builds them for you.
				# Gradle automatically packages shared libraries with your APK.

				add_library( # Sets the name of the library.
							 native-lib

							 # Sets the library as a shared library.
							 SHARED

							 # Provides a relative path to your source file(s).
							 src/main/cpp/native-lib.cpp )

				# Searches for a specified prebuilt library and stores the path as a
				# variable. Because CMake includes system libraries in the search path by
				# default, you only need to specify the name of the public NDK library
				# you want to add. CMake verifies that the library exists before
				# completing its build.

				find_library( # Sets the name of the path variable.
							  log-lib

							  # Specifies the name of the NDK library that
							  # you want CMake to locate.
							  log )

				# Specifies libraries CMake should link to your target library. You
				# can link multiple libraries, such as libraries you define in this
				# build script, prebuilt third-party libraries, or system libraries.

				target_link_libraries( # Specifies the target library.
									   native-lib avcodec-57 avfilter-6 avformat-57 avutil-55 swresample-2 swscale-4

									   # Links the target library to the log library
									   # included in the NDK.
									   ${log-lib} )
									   
	   3  配置cpu平台架构类型 
		cmake {
					cppFlags "-frtti -fexceptions"
					abiFilters 'armeabi' //这里是.so动态库目录的名称
				}
	      build.grade文件：
	      
				apply plugin: 'com.android.application'

				android {
					compileSdkVersion 26
					buildToolsVersion "26.0.1"
					defaultConfig {
						applicationId "com.tz.dream.ffmpeg.test.demo"
						minSdkVersion 14
						targetSdkVersion 26
						versionCode 1
						versionName "1.0"
						testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
						externalNativeBuild {
							cmake {
								cppFlags "-frtti -fexceptions"
								abiFilters 'armeabi'//配置cpu架构类型
							}
						}
					}
					buildTypes {
						release {
							minifyEnabled false
							proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
						}
					}
					externalNativeBuild {
						cmake {
							path "CMakeLists.txt"
						}
					}
				}

				dependencies {
					compile fileTree(dir: 'libs', include: ['*.jar'])
					androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
						exclude group: 'com.android.support', module: 'support-annotations'
					})
					compile 'com.android.support:appcompat-v7:26.+'
					compile 'com.android.support.constraint:constraint-layout:1.0.2'
					testCompile 'junit:junit:4.12'
				}
				
			4  编译
			   bulid -  rebulid project
			   
			   
			   
07-FFmpeg-应用-Android平台-测试FFmpeg配置
      注：native表示这个方法是一个特殊的方法，是与java中 ndk交互的方法，它修饰的方法没有实现，它的实现在c/c++中
          在src/main/cpp/native-lib.cpp中
      第一步：定义Java方法->类似于定义iOS方法
      1  在src/main/java/package name下 new - java class 
         FFmpegTest.java:
				package com.tz.dream.ffmpeg.test.demo;
				/**
				 * 作者: Dream on 2017/8/11 21:11
				 * QQ:510278658
				 * E-mail:510278658@qq.com
				 */

				//NDK方法
				public class FFmpegTest {

					//加载动态库
					static {
						System.loadLibrary("native-lib");
					}

					//1、NDK音视频编解码：FFmpeg-测试配置
					//2、native表示这个方法是一个特殊的方法，是与java中 ndk交互的方法，它修饰的方法没有实现，它的实现在c/c++中
					public static native void ffmpegTest();
					//测试视频
					public static native void ffmpegVideoOpenfile(String filepath);
				}

      2   MainActivity.java 
				package com.tz.dream.ffmpeg.test.demo;
				import android.os.Bundle;
				import android.support.v7.app.AppCompatActivity;

				public class MainActivity extends AppCompatActivity {

					@Override
					protected void onCreate(Bundle savedInstanceState) {
						super.onCreate(savedInstanceState);
						setContentView(R.layout.activity_main);
						FFmpegTest.ffmpegTest();
						//获取sdcard路径
						String rootPath = Enviroment.getExternalStorageDirectory().getAbsolutePath();
						String inFilePath = rootPath.concat("/DreamFFmpeg/Test.mov");
						FFmpegTest.ffmpegVideoOpenfile(inFilePath);
					}

				}
				
	   3 
	      注意：
	      build.grade文件中的下面代码native-lib.cpp与src/main/cpp/native-lib.cpp文件名相同，
	      告诉我们c++中有哪些类与java中类对应，关联java
	      add_library( # Sets the name of the library.
							 native-lib

							 # Sets the library as a shared library.
							 SHARED

							 # Provides a relative path to your source file(s).
							 src/main/cpp/native-lib.cpp )
	      
	      native-lib.cpp
	      #include <jni.h>
			#include <android/log.h>

			//当前C++兼容C语言 ffmpeg是c开发的  
			extern "C"{
			//avcodec:编解码(最重要的库)include import都可以用
			#include <libavcodec/avcodec.h>
			//avformat:封装格式处理
			//#include "libavformat/avformat.h"
			//avutil:工具库(大部分库都需要这个库的支持)
			//#include "libavutil/imgutils.h"
            //调用Java_com_tz_dream_ffmpeg_test_demo包下FFmpegTest下的ffmpegTest方法  声明方法
			JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_test_demo_FFmpegTest_ffmpegTest
					(JNIEnv *, jobject);
			//打开视频方法声明
			JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_test_demo_FFmpegTest_ffmpegVideoOpenfile
					(JNIEnv *, jobject,jstring jfilePath);
			}

			//方法实现
			JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_test_demo_FFmpegTest_ffmpegTest(
					JNIEnv *env, jobject jobj) {
				//(char *)表示C语言字符串
				const char *configuration = avcodec_configuration();
				__android_log_print(ANDROID_LOG_INFO,"main","%s",configuration);
			}
			//打开视频方法实现
			JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_test_demo_FFmpegTest_ffmpegVideoOpenfile
					(JNIEnv *, jobject,jstring jfilePath);
					//里面的代码和ios案例代码一样，都是c代码
			
			        //第一步：注册组件
					av_register_all();
		
					//第二步：打开封装格式文件
					//参数一：封装格式上下文
					AVFormatContext* avformat_context = avformat_alloc_context();
					//参数二：打开视频地址->path 将java字符串转成c字符串
					const char *url = env->GetStringUTFChars(jfilePath,NULL);
					//参数三：指定输入封装格式->默认格式
					//参数四：指定默认配置信息->默认配置
					int avformat_open_input_reuslt = avformat_open_input(&avformat_context, url, NULL, NULL);
					if (avformat_open_input_reuslt != 0){
						//失败了
						//获取错误信息
			//            char* error_info = NULL;
			//            av_strerror(avformat_open_input_reuslt, error_info, 1024);
						__android_log_print(ANDROID_LOG_INFO,"main","打开失败");
						return;
					}
		
					__android_log_print(ANDROID_LOG_INFO,"main","打开成功");
		}



08-FFmpeg-应用-Android平台-测试FFmpeg打开文件
mainactive.java中增加
			//测试视频
					public static native void ffmpegVideoOpenfile(String filepath);
					
在native-lib.cpp中增加
			//打开视频方法实现
			JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_test_demo_FFmpegTest_ffmpegVideoOpenfile
					(JNIEnv *, jobject,jstring jfilePath);
					//里面的代码和ios案例代码一样，都是c代码
			
			        //第一步：注册组件
					av_register_all();
		
					//第二步：打开封装格式文件
					//参数一：封装格式上下文
					AVFormatContext* avformat_context = avformat_alloc_context();
					//参数二：打开视频地址->path 将java字符串转成c字符串
					const char *url = env->GetStringUTFChars(jfilePath,NULL);
					//参数三：指定输入封装格式->默认格式
					//参数四：指定默认配置信息->默认配置
					int avformat_open_input_reuslt = avformat_open_input(&avformat_context, url, NULL, NULL);
					if (avformat_open_input_reuslt != 0){
						//失败了
						//获取错误信息
			//            char* error_info = NULL;
			//            av_strerror(avformat_open_input_reuslt, error_info, 1024);
						__android_log_print(ANDROID_LOG_INFO,"main","打开失败");
						return;
					}
		
					__android_log_print(ANDROID_LOG_INFO,"main","打开成功");
		}
		
在MainActivity.java 中增加：
						//获取sdcard路径
						String rootPath = Enviroment.getExternalStorageDirectory().getAbsolutePath();
						String inFilePath = rootPath.concat("/DreamFFmpeg/Test.mov");
						FFmpegTest.ffmpegVideoOpenfile(inFilePath);
加上sd卡打开读写权限相当于plist文件：
在AndroidMainfest.xml中
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>



第10次课-FFmepg-第3讲-Androidso动态库编译+FFmpeg介绍

01-FFmpeg-编译动态库-脚本分析

build-ffmpeg-armeabi.sh ：

#!/bin/bash

#第一步：进入到指定目录，当前sh脚本位置和ffmpeg-3.4目录同级
cd ffmpeg-3.4

#第二步：指定NDK路径(编译什么样的平台->采用什么样的平台编译器)
#Android平台NDK技术->做C/C++开发和编译Android平台下.so动态库
#注意：放在英文目录(中文目录报错)
#修改一：修改为你自己NDK存放目录,ndk是一个压缩包android-ndk-r10e-darwin-x86_64.bin，可下载，可在android studio中找到
#Mac解压NDK . bin文件
#1.获取文件权限
#chmod a+x android-ndk-r10c-darwin-x86_64.bin
#a+x 是给所有人加上可执行权限，包括所有者，所属组，和其他人
#o+x 只是给其他人加上可执行权限
#2. 解压出文件
#./android-ndk-r10c-darwin-x86_64.bin
#解压后的ndk目录与.sh文件同级
NDK_DIR=/Users/admin/Desktop/ffmpg/android-ndk-r10e

#第三步：配置Android系统版本(支持最小的版本)
#指定使用NDK Platform版本(对应系统版本)这里指定的是支持最小版本为android18
SYSROOT=$NDK_DIR/platforms/android-18/arch-arm

#第四步：指定编译工具链->(通俗：指定编译器)->CPU架构（Android手机通用的CPU架构类型）
#：armeabi是这里要编译的架构，是android通用的架构，是arm架构的儿子
#  Android Killer 是一个反编译工具，可反编译android的app，即能看到它使用的库和cpu架构
TOOLCHAIN=$NDK_DIR/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64

#第五步：指定CPU平台架构类型
#指定编译后的安装目录
ARCH=arm
ADDI_CFLAGS="-marm"

#第六步：指定编译成功之后，.so动态库存放位置
#修改二：这个目录你需要修改为你自己目录
PREFIX=/Users/yangshaohong/Desktop/ffmpg/android-build/$ARCH

#第七步：编写执行编译脚本->调用FFmpeg进行配置
#定义了Shell脚本函数(方法)
function build_armeabi
{
./configure \  # No such file or directory  这里的\去掉，该命令并成一行
--prefix=$PREFIX \
--enable-shared \ #编译动态库
--enable-gpl \
--disable-static \ #静止编译静态库
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-doc \
--disable-symver \
--enable-small \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \ #指定编译器
--target-os=android \ #指定是android系统
--arch=$ARCH \ #架构类型
--enable-cross-compile \ #交叉编译
--sysroot=$SYSROOT \
--extra-cflags="-Os -fpic $ADDI_CFLAGS" \
--enable-pic \
$ADDITIONAL_CONFIGURE_FLAG

make clean
make -j4
make install
}

#第八步：执行函数->开始编译
build_armeabi
echo "Android armeabi builds finished"




02-FFmpeg-编译动态库-注意事项
注意：
目标编译出来.so动态库格式libavcodec.so.57.2.100，放入到andriod项目中会报错，即是是把so后面的名字修改掉也报错
解决方案
				首先：进入FFmpeg-3.4开发包
				其次：打开configure文件
				最后：修改配置 修改的大意为编译的动态库减去版本号
原始
			#SLIBNAME_WITH_MAJOR='$(SLIBNAME).$(LIBMAJOR)'
			#LIB_INSTALL_EXTRA_CMD='$$(RANLIB) "$(LIBDIR)/$(LIBNAME)"'
			#SLIB_INSTALL_NAME='$(SLIBNAME_WITH_VERSION)'
			#SLIB_INSTALL_LINKS='$(SLIBNAME_WITH_MAJOR) $(SLIBNAME)'

			修改
			SLIBNAME_WITH_MAJOR='$(SLIBPREF)$(FULLNAME)-$(LIBMAJOR)$(SLIBSUF)'
			LIB_INSTALL_EXTRA_CMD='$$(RANLIB) "$(LIBDIR)/$(LIBNAME)"'  #注意这里有个空格
			SLIB_INSTALL_NAME='$(SLIBNAME_WITH_MAJOR)'
			SLIB_INSTALL_LINKS='$(SLIBNAME)'

修改后再编译：
执行脚本，编译.so动态库（不演示了->耗时）
		Dream$ ./build-ffmpeg-armeabi.sh
		
		



03-FFmpeg-编译动态库-执行脚本
注意二：找不到目录		https://www.jianshu.com/p/3fb7419f1a96
./configure \  # No such file or directory  这里的\去掉，该命令并成一行

04-FFmpeg-编译动态库-集成使用

在android studio中
切换项目模式为andrion：在gradle scripts ／bulid.gradle  中修改系统最小支持的版本号 minSdkVersion 14
集成可看前面的，android版本的后面去测试。


05-FFmpeg-基础知识-视频播放流程
封装格式数据： flv mp4 mkv
解封装格工： 把flv mp4解封装后得到音频压缩数据 视频压缩数据
音频压缩数据： aac,mp3
视频压缩数据：  h.264,mpeg2
音频解码：把acc,mp3解码得到音频采样数据
视频解码：把h.264,mpeg2解码得到视频像素数据
音频采样数据：pcm
视频像素数据：yuv  一个2M的mp4视频解码成yuv大概会变成200M
音视频同步：在设备上渲染同步播放pcm yuv


06-FFmpeg-基础知识-视频播放器
有两种模式下的播放器：
1：可视化界面播放器：腾讯视频 qq视频 暴风影音 爱奇艺，用户直观可以操作的，简单，是对非可视化的封装
2：非可视化界面播放器：如ffmpeg中有一个ffplay播放器，音视频框架内置的播放器  其它的vlc mplayer播放器，是命令操作的，用户看不懂


07-FFmpeg-基础知识-视频播放器信息查看工具
	查看整个视频信息：MediaInfo工具帮助我们查看视频完整信息
		音视频二进制查看信息：直接查看视频二进制数据（0101010）->UItraEdit
		视频单项信息
			封装格式信息工具->Elecard Format Analyzer
			视频编码信息工具->Elecard Stream Eye
			视频像素信息工具->YUVPlayer 查看yuv格式的信息工具
			音频采样数据工具->Adobe Audition  查看pcm格式的信息工具


08-FFmpeg-基础知识-封装格式
		1、封装格式：mp4、mov、flv、wmv等等…
		2、封装格式作用？
			视频流+音频流按照格式进行存储在一个文件中
		
		3、MPEG2-TS格式，是视频压缩数据槿式
			视频压缩数据格式：MPEG2-TS
			特定：数据排版，不包含头文件，数据大小固定（188byte）的TS-Packet  每处理一次都会发送一个这样大小的数据包
		4、FLV格式？
			优势：由于它形成的文件极小、加载速度极快，使得网络观看视频文件成为可能，它的出现有效地解决了视频文件导入Flash后，使导出的SWF文件体积庞大，不能在网络上很好的使用等问题。
 
			文件结构：FLV是一个二进制文件，由文件头（FLV header）和很多tag组成。tag又可以分成三类：audio,video,script，分别代表音频流，视频流，脚本流（关键字或者文件信息之类字幕，弹幕等）。
			FLV文件=FLV头文件+ tag1+tag内容1 + tag2+tag内容2 + ...+... + tagN+tag内容N。
			FLV头文件:(9字节)
			1-3： 前3个字节是文件格式标识(FLV 0x46 0x4C 0x56). 格式
			4-4： 第4个字节是版本（0x01） 版本
			5-5： 第5个字节的前5个bit是保留的必须是0. 预留
			6-9: 第6-9的四个字节还是保留的.其数据为 00000009 .
			整个文件头的长度，一般是9（3+1+1+4）
			
			
09-FFmpeg-基础知识-视频编码数据了解

		1、视频编码作用？
				将视频像素数据（YUV、RGB）进行压缩成为视频码流H.264，从而降低视频数据量。（减小内存暂用）
			
			2、视频编码格式有哪些？
				hevc(h.265)  推出机构：mpeg/itu-t
				h.264  推出机构：mpeg/itu-t
				mpeg4   推出机构：mpeg
				mpeg2   推出机构：mpeg
				vp9    推出机构：google
				vp8    推出机构：google
				vc-1   推出机构：microsoft inc
			3、H.264视频压缩数据格式？
				非常复杂算法->压缩->占用内存那么少？（例如：帧间预测、帧内预测…）->提高压缩性能

10-FFmpeg-基础知识-音频编码数据了解

1、音频编码作用？
			将音频采样数据（PCM格式）进行压缩成为音频码流，从而降低音频数据量。（减小内存暂用）
			2、音频编码格式有哪些？
				AAC   MPEG
				AC-3  Dolby Inc
				MP3   MPEG
				WMA   Microsoft Inc
			3、AAC格式,编解码比mp3快  音频文件更小
				AAC，全称Advanced Audio Coding，是一种专为声音数据设计的文件压缩格式。与MP3不同，它采用了全新的算法进行编码，更加高效，具有更高的“性价比”。利用AAC格式，可使人感觉声音质量没有明显降低的前提下，更加小巧。苹果ipod、诺基亚手机支持AAC格式的音频文件。
				优点：相对于mp3，AAC格式的音质更佳，文件更小。
				不足：AAC属于有损压缩的格式，与时下流行的APE、FLAC等无损格式相比音质存在“本质上”的差距。加之，传输速度更快的USB3.0和16G以上大容量MP3正在加速普及，也使得AAC头上“小巧”的光环不复存在。
				①提升的压缩率：可以以更小的文件大小获得更高的音质；
				②支持多声道：可提供最多48个全音域声道；
				③更高的解析度：最高支持96KHz的采样频率；
				④提升的解码效率：解码播放所占的资源更少；



11-FFmpeg-基础知识-视频像素数据格式
			1、作用？
				保存了屏幕上面每一个像素点的值
			2、视频像素数据格式种类？
				常见格式：RGB24、RGB32、YUV420P、YUV422P、YUV444P等等…一般最常见：YUV420P
			3、视频像素数据文件大小计算？
				例如：RGB24高清视频体积？（1个小时时长）
				体积：3600（秒） * 25（帧率） * 1920（屏幕尺寸） * 1080（屏幕尺寸） * 3 = 559GB（非常大）
				假设：帧率25HZ，采样精度8bit，3个字节
			4、YUV播放器
				人类：对色度不敏感，对亮度敏感 
				Y表示：亮度
				UV表示：色度
				
				
12-FFmpeg-基础知识-音频采用数据格式
1、作用？
				保存了音频中的每一个采样点值
			2、音频采样数据文件大小计算？
				例如：1分钟PCM格式歌曲
				体积：60（秒） * 44100（采样率赫兹） * 2（双声道左右声道） * 2（采样精度） = 11MB
				分析：60表示时间，44100表示采样率（一般情况下，都是这个采样率，人的耳朵能够分辨的声音），2表示声道数量，2表示采样精度16位 = 2字节 
			3、音频采样数据查看工具
				Adobe Audition
			4、PCM格式？
				存储顺序
				单声道 L L L L 或R R R R
				双声道 L R L R
				
				
13-FFmpeg-基础知识-命令行工具使用
     FFMPEG是核心加插件的设计方式，它的核心库avcodec编解码库
     
     -h  帮助
     -t duration 设置处理时间，格式为hh:mm:ss   截取多少秒
     -ss position 设置起始时间，格式为hh:mm:ss  截取视频起始多少秒开始
     -b:v bitrate 设置视频码率
     -b:a bitrate 设置音频码率
     -r fps 设置帧率
     -s wxh 设置帧大小，格式为WxH
     -c:v codec 设置视频编码器
     -c:a codec 设置音频编码器
     -ar freq 设置音频采样率
     
     注意：再转视频时，视频码率和音频码率应该等比例缩小，如同时除以二，保证音视频同步
			1、ffmpeg.exe（视频压缩->转码来完成）
				作用：用于对视频进行转码
				将mp4->mov，mov->mp4，wmv->mp4等等…
				命令格式：ffmpeg -i {指定输入文件路径} -b:v {输出视频码率} {输出文件路径}
				测试运行：将Test.mov转成Test.mp4
				./ffmpeg -i（执行） Test.mov（不指定目录则表示当前目录） -b:v 368（输出视频码率）  -b:a 222（音频码率）  Test.mp4
				
		        截取视频：./ffmpeg -i（执行） Test.mov（当前目录） -ss
				参数解析：
				-vcodec copy表示使用跟原视频一样的视频编解码器。

				-acodec copy表示使用跟原视频一样的音频编解码器。

				-i 表示源视频文件

				-y 表示如果输出文件已存在则覆盖。
				ffmpeg  -i D:/2018-08-16-14_20.avi -vcodec copy -acodec copy -ss 00:00:10 -to 00:00:15 D:/out1.mp4 -y
			2、ffplay.exe
				作用：播放视频
				格式：ffplay {文件路径}
				例如：./ffplay Test.mov
				
				
				
	摘自网络：https://blog.csdn.net/lipengshiwo/article/details/79252028
	  强大的FFmpeg，能够实现视频采集、视频格式转化、视频截图、视频添加水印、视频切片、视频录制、视频推流、更改音视频参数功能等。
	  平常会直接用到一些主要的功能命令，所以下述先列举功能命令，再整体的列举搜集的命令中的参数的解释说明
	  第一组

1.分离视频音频流

ffmpeg -i input_file -vcodec copy -an output_file_video　　//分离视频流ffmpeg -i input_file -acodec copy -vn output_file_audio　　//分离音频流

2.视频解复用

ffmpeg –i test.mp4 –vcodec copy –an –f m4v test.264

ffmpeg –i test.avi –vcodec copy –an –f m4v test.264

3.视频转码

ffmpeg –i test.mp4 –vcodec h264 –s 352*278 –an –f m4v test.264

//转码为码流原始文件

ffmpeg –i test.mp4 –vcodec h264 –bf 0 –g 25 –s 352*278 –an –f m4v test.264 //转码为码流原始文件

ffmpeg –i test.avi -vcodec mpeg4 –vtag xvid –qsame test_xvid.avi //转码为封装文件

说明：-bf B帧数目控制，-g 关键帧间隔控制，-s 分辨率控制

4.视频封装

ffmpeg –i video_file –i audio_file –vcodec copy –acodec copy output_file

5.视频剪切

ffmpeg –i test.avi –r 1 –f image2 image-%3d.jpeg //提取图片

ffmpeg -ss 0:1:30 -t 0:0:20 -i input.avi -vcodec copy -acodec copy output.avi //剪切视频//-r 提取图像的频率，-ss 开始时间，-t 持续时间

6.视频录制

ffmpeg –i rtsp://192.168.3.205:5555/test –vcodec copy out.avi

7、利用ffmpeg视频切片

主要把视频源切成若干个.ts格式的视频片段然后生成一个.m3u8的切片文件索引提供给html5的video做hls直播源

命令如下：

ffmpeg -i 视频源地址 -strict -2 -c:v libx264 -c:a aac -f hls m3u8文件输出地址

8、ffmpeg缩放视频

假设原始视频尺寸是 1080p（即 1920×1080 px，16:9），使用下面命令可以缩小到 480p：

命令如下：

ffmpeg -i 视频源地址 -vf scale=853:480 -acodec aac -vcodec h264 视频输出地址（如：out.mp4）

各个参数的含义：-i a.mov 指定待处理视频的文件名-vf scale=853:480 vf 参数用于指定视频滤镜，其中 scale 表示缩放，后面的数字表示缩放至 853×480 px，其中的 853px 是计算而得，因为原始视频的宽高比为 16:9，所以为了让目标视频的高度为 480px，则宽度 = 480 x 9 / 16 = 853-acodec aac 指定音频使用 aac 编码。注：因为 ffmpeg 的内置 aac 编码目前（写这篇文章时）还是试验阶段，故会提示添加参数 “-strict -2” 才能继续，尽管添加即可。又或者使用外部的 libfaac（需要重新编译 ffmpeg）。-vcodec h264 指定视频使用 h264 编码。注：目前手机一般视频拍摄的格式（封装格式、文件格式）为 mov 或者 mp4，这两者的音频编码都是 aac，视频都是 h264。out.mp4 指定输出文件名上面的参数 scale=853:480 当中的宽度和高度实际应用场景中通常只需指定一个，比如指定高度为 480 或者 720，至于宽度则可以传入 “-1” 表示由原始视频的宽高比自动计算而得。即参数可以写为：scale=-1:480，当然也可以 scale=480:-1

9、ffmpeg裁剪

有时可能只需要视频的正中一块，而两头的内容不需要，这时可以对视频进行裁剪（crop），比如有一个竖向的视频 1080 x 1920，如果指向保留中间 1080×1080 部分命令如下：ffmpeg -i 视频源地址 -strict -2 -vf crop=1080:1080:0:420 视频输出地址（如：out.mp4）

其中的 crop=1080:1080:0:420 才裁剪参数，具体含义是 crop=width:height:x:y，其中 width 和 height 表示裁剪后的尺寸，x:y 表示裁剪区域的左上角坐标。比如当前这个示例，我们只需要保留竖向视频的中间部分，所以 x 不用偏移，故传入0，而 y 则需要向下偏移：(1920 – 1080) / 2 = 420

10. 转视频格式

ffmpeng -i source.mp4 -c:v libx264 -crf 24 destination.flv

其中 -crf 很重要，是控制转码后视频的质量，质量越高，文件也就越大。

此值的范围是 0 到 51：0 表示高清无损；23 是默认值（如果没有指定此参数）；51 虽然文件最小，但效果是最差的。

值越小，质量越高，但文件也越大，建议的值范围是 18 到 28。而值 18 是视觉上看起来无损或接近无损的，当然不代表是数据（技术上）的转码无损。





第二组

1.ffmpeg 把文件当做直播推送至服务器 (RTMP + FLV)

ffmpeg - re -i demo.mp4 -c copy - f flv rtmp://w.gslb.letv/live/streamid

2.将直播的媒体保存到本地

ffmpeg -i rtmp://r.glsb.letv/live/streamid -c copy streamfile.flv

3.将一个直播流，视频改用h264压缩，音频改用faac压缩，送至另一个直播服务器

ffmpeg -i rtmp://r.glsb.letv/live/streamidA -c:a libfaac -ar 44100 -ab 48k -c:v libx264 -vpre slow -vpre baseline -f flv rtmp://w.glsb.letv/live/streamb

4.提取视频中的音频,并保存为mp3 然后输出

ffmpeg -i input.avi -b:a 128k output.mp3





第三组

1.获取视频的信息

ffmpeg -i video.avi

2.将图片序列合成视频

ffmpeg -f image2 -i image%d.jpg video.mpg

上面的命令会把当前目录下的图片（名字如：image1.jpg. image2.jpg. 等...）合并成video.mpg

3.将视频分解成图片序列

ffmpeg -i video.mpg image%d.jpg

上面的命令会生成image1.jpg. image2.jpg. ...

支持的图片格式有：PGM. PPM. PAM. PGMYUV. JPEG. GIF. PNG. TIFF. SGI

4.为视频重新编码以适合在iPod/iPhone上播放

ffmpeg -i source_video.avi input -acodec aac -ab 128kb -vcodec mpeg4 -b 1200kb -mbd 2 -flags +4mv+trell -aic 2 -cmp 2 -subcmp 2 -s 320x180 -title X final_video.mp4

5.为视频重新编码以适合在PSP上播放

ffmpeg -i source_video.avi -b 300 -s 320x240 -vcodec xvid -ab 32 -ar 24000 -acodec aac final_video.mp4

6.从视频抽出声音.并存为Mp3

ffmpeg -i source_video.avi -vn -ar 44100 -ac 2 -ab 192 -f mp3 sound.mp3

7.将wav文件转成Mp3

ffmpeg -i son_origine.avi -vn -ar 44100 -ac 2 -ab 192 -f mp3 son_final.mp3

8.将.avi视频转成.mpg

ffmpeg -i video_origine.avi video_finale.mpg

9.将.mpg转成.avi

ffmpeg -i video_origine.mpg video_finale.avi

10.将.avi转成gif动画（未压缩）

ffmpeg -i video_origine.avi gif_anime.gif

11.合成视频和音频

ffmpeg -i son.wav -i video_origine.avi video_finale.mpg

12.将.avi转成.flv

ffmpeg -i video_origine.avi -ab 56 -ar 44100 -b 200 -r 15 -s 320x240 -f flv video_finale.flv

13.将.avi转成dv

ffmpeg -i video_origine.avi -s pal -r pal -aspect 4:3 -ar 48000 -ac 2 video_finale.dv

或者：

ffmpeg -i video_origine.avi -target pal-dv video_finale.dv

14.将.avi压缩成divx

ffmpeg -i video_origine.avi -s 320x240 -vcodec msmpeg4v2 video_finale.avi

15.将Ogg Theora压缩成Mpeg dvd

ffmpeg -i film_sortie_cinelerra.ogm -s 720x576 -vcodec mpeg2video -acodec mp3 film_terminate.mpg

16.将.avi压缩成SVCD mpeg2

NTSC格式：

ffmpeg -i video_origine.avi -target ntsc-svcd video_finale.mpg

PAL格式：

ffmpeg -i video_origine.avi -target pal-dvcd video_finale.mpg

17.将.avi压缩成VCD mpeg2

NTSC格式：

ffmpeg -i video_origine.avi -target ntsc-vcd video_finale.mpg

PAL格式：

ffmpeg -i video_origine.avi -target pal-vcd video_finale.mpg

18.多通道编码

ffmpeg -i fichierentree -pass 2 -passlogfile ffmpeg2pass fichiersortie-2

19.从flv提取mp3

ffmpeg -i source.flv -ab 128k dest.mp3





第四组

1、将文件当做直播送至live

ffmpeg -re -i localFile.mp4 -c copy -f flv rtmp://server/live/streamName

2、将直播媒体保存至本地文件

ffmpeg -i rtmp://server/live/streamName -c copy dump.flv

3、将其中一个直播流，视频改用h264压缩，音频不变，送至另外一个直播服务流

ffmpeg -i rtmp://server/live/originalStream -c:a copy -c:v libx264 -vpre slow -f flv rtmp://server/live/h264Stream

4、将其中一个直播流，视频改用h264压缩，音频改用faac压缩，送至另外一个直播服务流

ffmpeg -i rtmp://server/live/originalStream -c:a libfaac -ar 44100 -ab 48k -c:v libx264 -vpre slow -vpre baseline -f flv rtmp://server/live/h264Stream

5、将其中一个直播流，视频不变，音频改用faac压缩，送至另外一个直播服务流

ffmpeg -i rtmp://server/live/originalStream -acodec libfaac -ar 44100 -ab 48k -vcodec copy -f flv rtmp://server/live/h264_AAC_Stream

6、将一个高清流，复制为几个不同视频清晰度的流重新发布，其中音频不变

ffmpeg -re -i rtmp://server/live/high_FMLE_stream -acodec copy -vcodec x264lib -s 640×360 -b 500k -vpre medium -vpre baseline rtmp://server/live/baseline_500k -acodec copy -vcodec x264lib -s 480×272 -b 300k -vpre medium -vpre baseline rtmp://server/live/baseline_300k -acodec copy -vcodec x264lib -s 320×200 -b 150k -vpre medium -vpre baseline rtmp://server/live/baseline_150k -acodec libfaac -vn -ab 48k rtmp://server/live/audio_only_AAC_48k

7、功能一样，只是采用-x264opts选项

ffmpeg -re -i rtmp://server/live/high_FMLE_stream -c:a copy -c:v x264lib -s 640×360 -x264opts bitrate=500:profile=baseline:preset=slow rtmp://server/live/baseline_500k -c:a copy -c:v x264lib -s 480×272 -x264opts bitrate=300:profile=baseline:preset=slow rtmp://server/live/baseline_300k -c:a copy -c:v x264lib -s 320×200 -x264opts bitrate=150:profile=baseline:preset=slow rtmp://server/live/baseline_150k -c:a libfaac -vn -b:a 48k rtmp://server/live/audio_only_AAC_48k

8、将当前摄像头及音频通过DSSHOW采集，视频h264、音频faac压缩后发布

ffmpeg -r 25 -f dshow -s 640×480 -i video=”video source name”:audio=”audio source name” -vcodec libx264 -b 600k -vpre slow -acodec libfaac -ab 128k -f flv rtmp://server/application/stream_name

9、将一个JPG图片经过h264压缩循环输出为mp4视频

ffmpeg.exe -i INPUT.jpg -an -vcodec libx264 -coder 1 -flags +loop -cmp +chroma -subq 10 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -flags2 +dct8x8 -trellis 2 -partitions +parti8x8+parti4x4 -crf 24 -threads 0 -r 25 -g 25 -y OUTPUT.mp4

10、将普通流视频改用h264压缩，音频不变，送至高清流服务(新版本FMS live=1)

ffmpeg -i rtmp://server/live/originalStream -c:a copy -c:v libx264 -vpre slow -f flv “rtmp://server/live/h264Stream live=1〃

参数及解释

  
a) 通用选项

-L license
-h 帮助
-fromats 显示可用的格式，编解码的，协议的...
-f fmt 强迫采用格式fmt
-I filename 输入文件
-y 覆盖输出文件
-t duration 设置纪录时间 hh:mm:ss[.xxx]格式的记录时间也支持
-ss position 搜索到指定的时间 [-]hh:mm:ss[.xxx]的格式也支持
-title string 设置标题
-author string 设置作者
-copyright string 设置版权
-comment string 设置评论
-target type 设置目标文件类型(vcd,svcd,dvd) 所有的格式选项（比特率，编解码以及缓冲区大小）自动设置，只需要输入如下的就可以了：ffmpeg -i myfile.avi -target vcd /tmp/vcd.mpg
-hq 激活高质量设置
-itsoffset offset 设置以秒为基准的时间偏移，该选项影响所有后面的输入文件。该偏移被加到输入文件的时戳，定义一个正偏移意味着相应的流被延迟了 offset秒。 [-]hh:mm:ss[.xxx]的格式也支持


b) 视频选项

-b bitrate 设置比特率，缺省200kb/s
-r fps 设置帧频 缺省25
-s size 设置帧大小 格式为WXH 缺省160X128.下面的简写也可以直接使用：
Sqcif 128X96 qcif 176X144 cif 252X288 4cif 704X576
-aspect aspect 设置横纵比 4:3 16:9 或 1.3333 1.7777
-croptop size 设置顶部切除带大小 像素单位
-cropbottom size –cropleft size –cropright size
-padtop size 设置顶部补齐的大小 像素单位
-padbottom size –padleft size –padright size –padcolor color 设置补齐条颜色(hex,6个16进制的数，红:绿:兰排列，比如 000000代表黑色)
-vn 不做视频记录
-bt tolerance 设置视频码率容忍度kbit/s
-maxrate bitrate设置最大视频码率容忍度
-minrate bitreate 设置最小视频码率容忍度
-bufsize size 设置码率控制缓冲区大小
-vcodec codec 强制使用codec编解码方式。如果用copy表示原始编解码数据必须被拷贝。
-sameq 使用同样视频质量作为源（VBR）
-pass n 选择处理遍数（1或者2）。两遍编码非常有用。第一遍生成统计信息，第二遍生成精确的请求的码率
-passlogfile file 选择两遍的纪录文件名为file


c)高级视频选项

-g gop_size 设置图像组大小
-intra 仅适用帧内编码
-qscale q 使用固定的视频量化标度(VBR)
-qmin q 最小视频量化标度(VBR)
-qmax q 最大视频量化标度(VBR)
-qdiff q 量化标度间最大偏差 (VBR)
-qblur blur 视频量化标度柔化(VBR)
-qcomp compression 视频量化标度压缩(VBR)
-rc_init_cplx complexity 一遍编码的初始复杂度
-b_qfactor factor 在p和b帧间的qp因子
-i_qfactor factor 在p和i帧间的qp因子
-b_qoffset offset 在p和b帧间的qp偏差
-i_qoffset offset 在p和i帧间的qp偏差
-rc_eq equation 设置码率控制方程 默认tex^qComp
-rc_override override 特定间隔下的速率控制重载
-me method 设置运动估计的方法 可用方法有 zero phods log x1 epzs(缺省) full
-dct_algo algo 设置dct的算法 可用的有 0 FF_DCT_AUTO 缺省的DCT 1 FF_DCT_FASTINT 2 FF_DCT_INT 3 FF_DCT_MMX 4 FF_DCT_MLIB 5 FF_DCT_ALTIVEC
-idct_algo algo 设置idct算法。可用的有 0 FF_IDCT_AUTO 缺省的IDCT 1 FF_IDCT_INT 2 FF_IDCT_SIMPLE 3 FF_IDCT_SIMPLEMMX 4 FF_IDCT_LIBMPEG2MMX 5 FF_IDCT_PS2 6 FF_IDCT_MLIB 7 FF_IDCT_ARM 8 FF_IDCT_ALTIVEC 9 FF_IDCT_SH4 10 FF_IDCT_SIMPLEARM
-er n 设置错误残留为n 1 FF_ER_CAREFULL 缺省 2 FF_ER_COMPLIANT 3 FF_ER_AGGRESSIVE 4 FF_ER_VERY_AGGRESSIVE
-ec bit_mask 设置错误掩蔽为bit_mask,该值为如下值的位掩码 1 FF_EC_GUESS_MVS (default=enabled) 2 FF_EC_DEBLOCK (default=enabled)
-bf frames 使用frames B 帧，支持mpeg1,mpeg2,mpeg4
-mbd mode 宏块决策 0 FF_MB_DECISION_SIMPLE 使用mb_cmp 1 FF_MB_DECISION_BITS 2 FF_MB_DECISION_RD
-4mv 使用4个运动矢量 仅用于mpeg4
-part 使用数据划分 仅用于mpeg4
-bug param 绕过没有被自动监测到编码器的问题
-strict strictness 跟标准的严格性
-aic 使能高级帧内编码 h263+
-umv 使能无限运动矢量 h263+
-deinterlace 不采用交织方法
-interlace 强迫交织法编码仅对mpeg2和mpeg4有效。当你的输入是交织的并且你想要保持交织以最小图像损失的时候采用该选项。可选的方法是不交织，但是损失更大
-psnr 计算压缩帧的psnr
-vstats 输出视频编码统计到vstats_hhmmss.log
-vhook module 插入视频处理模块 module 包括了模块名和参数，用空格分开


d)音频选项

-ab bitrate 设置音频码率
-ar freq 设置音频采样率
-ac channels 设置通道 缺省为1
-an 不使能音频纪录
-acodec codec 使用codec编解码


e)音频/视频捕获选项

-vd device 设置视频捕获设备。比如/dev/video0
-vc channel 设置视频捕获通道 DV1394专用
-tvstd standard 设置电视标准 NTSC PAL(SECAM)
-dv1394 设置DV1394捕获
-av device 设置音频设备 比如/dev/dsp


f)高级选项

-map file:stream 设置输入流映射
-debug 打印特定调试信息
-benchmark 为基准测试加入时间
-hex 倾倒每一个输入包
-bitexact 仅使用位精确算法 用于编解码测试
-ps size 设置包大小，以bits为单位
-re 以本地帧频读数据，主要用于模拟捕获设备
-loop 循环输入流（只工作于图像流，用于ffserver测试）




第11次课-FFmepg-第4讲-视频解码

01-FFmpeg-视频解码-流程分析
内容一：FFmpeg-命令行补充？
	案例：视频，转为高质量 GIF 动图？
	命令：./ffmpeg -ss 00:00:03 -t 3 -i Test.mov -s 640x360 -r “15” dongtu.gif
	解释：
		1、ffmpeg 是你刚才安装的程序；

		2、-ss 00:00:03 表示从第 00 分钟 03 秒开始制作 GIF，如果你想从第 9 秒开始，则输入 -ss 00:00:09，或者 -ss 9，
		支持小数点，所以也可以输入 -ss 00:00:11.3，或者 -ss 34.6 之类的，如果不加该命令，则从 0 秒开始制作；

		3、-t 3 表示把持续 3 秒的视频转换为 GIF，你可以把它改为其他数字，例如 1.5，7 等等，时间越长，GIF 体积越大，
		如果不加该命令，则把整个视频转为 GIF；

		4、-i 表示 invert 的意思吧，转换；

		5、Test.mov 就是你要转换的视频，名称最好不要有中文，不要留空格，支持多种视频格式；

		6、-s 640x360 是 GIF 的分辨率，视频分辨率可能是 1080p，但你制作的 GIF 可以转为 720p 等，允许自定义，
		分辨率越高体积越大，如果不加该命令，则保持分辨率不变；

		7、-r “15” 表示帧率，网上下载的视频帧率通常为 24，设为 15 效果挺好了，帧率越高体积越大，如果不加该命令，则保持帧率不变；

		8、dongtu.gif：就是你要输出的文件，你也可以把它命名为 hello.gif 等等。
		
将音视频解码在Android平台进行实现：

第一步：组册组件
			av_register_all()
编码器，解码器都属于组件 ，这里注册表示支持哪些组件

第二步：打开封装格式，其实就是去打开视频文件
            avformat_open_input();
			例如：.mp4、.mov、.wmv文件等等...
			
			
第三步：查找视频流
	如果是视频解码，那么查找视频流，如果是音频解码，那么就查找音频流
	avformat_find_stream_info();

		第四步：查找视频解码器
			1、查找视频流索引位置
			2、根据视频流索引，获取解码器上下文,即解码器信息
			3、根据解码器上下文，获得解码器ID，然后查找解码器
			
第五步：打开解码器
			avcodec_open2();

第六步：读取视频压缩数据->循环读取
	每读取一帧数据，立马解码一帧数据 得到yuv视频相素数据

第七步：视频解码->得到视频像素数据->播放视频->

第八步：关闭解码器->解码完成




02-FFmpeg-视频解码-打开解码器
  1 下载android studio 3.4
  2 新建项目，选native c++
  3 选android模式，Gradle Scripts/build.gradle(Module:app)打开
    版本改成minSdkVersion 14
    bulid.grade：
		是配置版本信息，引用库，以及编译所需的配置
		compileSdkVersion 21，说明要运行该源码，你必选已经安装了android API 21。
		buildToolsVersion 21.1.2 说明要运行该源码，你必须已经安装了 android sdk build-tools 21.1.2。
		minSdkVerison 表示向下低至android API 14，即androd 4.0和4.0以上的版本都可以运行该工程。
		targetSdkVerision 表示采用的目标android API是 API 21即 android 5.0
  4 导入动态库
  切换到project模式，copy动态库.so 和include文件到src/man下面
  5 修改CMakeLists.txt内容
  查看CMakeLists.txt路径：
  选android模式，Gradle Scripts/build.gradle(Module:app)打开
   externalNativeBuild {
        cmake {
            path "src/main/cpp/CMakeLists.txt"
            version "3.10.2"
        }
    }
  打开CMakeLists.txt
  添加如下代码：
			  # FFMpeg配置
			# FFmpeg配置目录
			set(distribution_DIR ${CMAKE_SOURCE_DIR}/../../../../src/main/jniLibs)

			# 编解码(最重要的库)
			add_library(
					avcodec
					SHARED
					IMPORTED)
			set_target_properties(
					avcodec
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libavcodec.so)


			# 设备
			add_library(
					avdevice
					SHARED
					IMPORTED)
			set_target_properties(
					avdevice
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libavdevice.so)


			# 滤镜特效处理库
			add_library(
					avfilter
					SHARED
					IMPORTED)
			set_target_properties(
					avfilter
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libavfilter.so)

			# 封装格式处理库
			add_library(
					avformat
					SHARED
					IMPORTED)
			set_target_properties(
					avformat
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libavformat.so)

			# 工具库(大部分库都需要这个库的支持)
			add_library(
					avutil
					SHARED
					IMPORTED)
			set_target_properties(
					avutil
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libavutil.so)

			add_library(
					postproc
					SHARED
					IMPORTED)
			set_target_properties(
					postproc
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libpostproc.so)

			# 音频采样数据格式转换库
			add_library(
					swresample
					SHARED
					IMPORTED)
			set_target_properties(
					swresample
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libswresample.so)

			# 视频像素数据格式转换
			add_library(
					swscale
					SHARED
					IMPORTED)
			set_target_properties(
					swscale
					PROPERTIES IMPORTED_LOCATION
					../../../../src/main/jniLibs/armeabi/libswscale.so)


			#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
			#判断编译器类型,如果是gcc编译器,则在编译选项中加入c++11支持
			if(CMAKE_COMPILER_IS_GNUCXX)
				set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
				message(STATUS "optional:-std=c++11")
			endif(CMAKE_COMPILER_IS_GNUCXX)


			#配置编译的头文件
			include_directories(src/main/jniLibs/include)
		
			#链接动态库
			target_link_libraries( # Specifies the target library.
								   native-lib avcodec avdevice avfilter avformat avutil postproc swresample swscale

								   # Links the target library to the log library
								   # included in the NDK.
								   ${log-lib} )
							   
		6.配置采用的cpu架构类型
		选android模式，Gradle Scripts/build.gradle(Module:app)打开
		修改：
		externalNativeBuild {
            cmake {
                cppFlags ""
            }
        }
        改后
        externalNativeBuild {
            cmake {
                cppFlags "-frtti -fexceptions"
                abiFilters 'armeabi'
            }
        }
        
        7.加上sd卡打开读写权限相当于plist文件：
			在AndroidMainfest.xml中
			<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
			<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
        
        8.在MainActivity.java中定义方法：
				package com.example.admin.myapplication;

				import android.support.v7.app.AppCompatActivity;
				import android.os.Bundle;
				import android.os.Environment;
				import android.util.Log;
				import java.io.File;
				import java.io.IOException;

				public class MainActivity extends AppCompatActivity {

					// Used to load the 'native-lib' library on application startup.
					static {
						System.loadLibrary("native-lib");
					}

					@Override
					protected void onCreate(Bundle savedInstanceState) {
						super.onCreate(savedInstanceState);
						setContentView(R.layout.activity_main);
						String rootPath = Environment.getExternalStorageDirectory()
								.getAbsolutePath();
						String inFilePath = rootPath.concat("/DreamFFmpeg/Test.mov");
						String outFilePath = rootPath.concat("/DreamFFmpeg/Test.yuv");

						//输出文件不存在我创建一个文件
						File file = new File(outFilePath);
						if (file.exists()){
							Log.i("日志：","存在");
						}else {
							try {
								file.createNewFile();
							} catch (IOException e) {
								e.printStackTrace();
							}
						}

						ffmepgDecodeVideo(inFilePath, outFilePath);
					}

					public native void ffmepgDecodeVideo(String inFilePath, String outFilePath);
				}

        8 在native-lib.cpp中关联方法的实现
				#include <jni.h>
				#include <string>
				#include <android/log.h>

				extern "C" {
				//核心库
				#include "libavcodec/avcodec.h"
				//封装格式处理库
				#include "libavformat/avformat.h"
				//工具库
				#include "libavutil/imgutils.h"
				//视频像素数据格式库
				#include "libswscale/swscale.h"

				//视频解码
				JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_decodevideo_MainActivity_ffmepgDecodeVideo(JNIEnv *env, jobject jobj,
																										   jstring jinFilePath,
																										   jstring joutFilePath);

				}
				JNIEXPORT void JNICALL Java_com_tz_dream_ffmpeg_decodevideo_MainActivity_ffmepgDecodeVideo(
						JNIEnv *env,
						jobject jobj, jstring jinFilePath, jstring joutFilePath) {

					//第一步：组册组件
					 av_register_all();
					//第二步：打开封装格式->打开文件
					//参数一：封装格式上下文
					//作用：保存整个视频信息.mp4类型的(解码器、编码器等等...)
					//信息：码率、帧率等...
					AVFormatContext* avformat_context = avformat_alloc_context();
					//参数二：视频路径
					const char *url = env->GetStringUTFChars(jinFilePath, NULL);
					//在我们iOS里面
					//NSString* path = @"/user/dream/test.mov";
					//const char *url = [path UTF8String]
					//参数一：把输入的视频读入到了avformat_context地址中
					//参数三：指定输入的格式
					//参数四：设置默认参数 
					int avformat_open_input_result = avformat_open_input(&avformat_context, url, NULL, NULL);
					if (avformat_open_input_result != 0){
						//安卓平台下log
						__android_log_print(ANDROID_LOG_INFO, "main", "打开文件失败");
						//iOS平台下log
						//NSLog("打开文件失败");
						//不同的平台替换不同平台log日志
						return;
					}

					//第三步：查找视频流->拿到视频信息 找不到视频信息就return不执行下面的代码了
					//avformat_find_stream_info_result变量在下面没有使用
					//参数一：封装格式上下文
					//参数二：指定默认配置
					int avformat_find_stream_info_result = avformat_find_stream_info(avformat_context, NULL);
					if (avformat_find_stream_info_result < 0){
						__android_log_print(ANDROID_LOG_INFO, "main", "查找失败");
						return;
					}

					//第四步：查找视频解码器
					//1、查找视频流索引位置，视频封装上下文进行查找，如果找到video类型说明找到
					int av_stream_index = -1;
					for (int i = 0; i < avformat_context->nb_streams; ++i) {
						//判断流类型：视频流、音频流、字幕流等等...
						if (avformat_context->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO){
							av_stream_index = i;
							break;
						}
					}

					//2、根据视频流索引av_stream_index，获取解码器上下文
					AVCodecContext *avcodec_context = avformat_context->streams[av_stream_index]->codec;

					//3、根据解码器上下文vcodec_context，解码器ID，然后查找解码器,因为解码器有很多种
					AVCodec *avcodec = avcodec_find_decoder(avcodec_context->codec_id);


					//第五步：打开解码器 拿到解码器后必须要打开
					int avcodec_open2_result = avcodec_open2(avcodec_context, avcodec, NULL);
					if (avcodec_open2_result != 0){
						__android_log_print(ANDROID_LOG_INFO, "main", "打开解码器失败");
						return;
					}

					//测试一下
					//打印信息
					__android_log_print(ANDROID_LOG_INFO, "main", "解码器名称：%s", avcodec->name);



					//第六步：读取视频压缩数据->循环读取
					//1、分析av_read_frame参数
					//参数一：封装格式上下文
					//参数二：一帧压缩数据 = 一张图片
					//av_read_frame()
					//结构体大小计算：字节对齐原则 创建一帧h264压缩数据
					AVPacket* packet = (AVPacket*)av_malloc(sizeof(AVPacket));

					//3.2 解码一帧视频压缩数据->进行解码(作用：用于解码操作)
					//开辟一块内存空间
					AVFrame* avframe_in = av_frame_alloc();
					int decode_result = 0;


					//4、注意：视频相素格式的上下文在这里我们不能够保证解码出来的一帧视频像素数据格式是yuv格式
					//参数一：源文件->原始视频像素数据格式宽
					//参数二：源文件->原始视频像素数据格式高
					//参数三：源文件->原始视频像素数据格式类型
					//参数四：目标文件->目标视频像素数据格式宽
					//参数五：目标文件->目标视频像素数据格式高
					//参数六：目标文件->目标视频像素数据格式类型
					//参数七：字节对齐的方式
					SwsContext *swscontext = sws_getContext(avcodec_context->width,
															avcodec_context->height,
															avcodec_context->pix_fmt,
															avcodec_context->width,
															avcodec_context->height,
															AV_PIX_FMT_YUV420P,
															SWS_BICUBIC,
															NULL,
															NULL,
															NULL);

					//创建一个yuv420视频像素数据格式缓冲区(一帧数据)
					//往下的代码表示设置avframe_yuv420p 按yuv420p这种规则进行存储
					AVFrame* avframe_yuv420p = av_frame_alloc();
					//给缓冲区设置类型->yuv420类型
					//得到YUV420P缓冲区大小
					//参数一：视频像素数据格式类型->YUV420P格式
					//参数二：一帧视频像素数据宽 = 视频宽
					//参数三：一帧视频像素数据高 = 视频高
					//参数四：字节对齐方式->默认是1
					//返回缓冲区的大小
					int buffer_size = av_image_get_buffer_size(AV_PIX_FMT_YUV420P,
															   avcodec_context->width,
															   avcodec_context->height,
															   1);

					//根据大小开辟一块内存空间
					uint8_t *out_buffer = (uint8_t *)av_malloc(buffer_size);
					//向avframe_yuv420p->填充数据  给avframe_yuv420p填充数据，
					//实现了avframe_yuv420p里面保存yuv420p格式，就会以这种yuv420p的方式存储数据
					//参数一：目标->填充数据(avframe_yuv420p)
					//参数二：目标->每一行大小
					//参数三：原始数据
					//参数四：目标->格式类型
					//参数五：一帧视频宽
					//参数六：一帧视频高
					//参数七：字节对齐方式
					av_image_fill_arrays(avframe_yuv420p->data,
										 avframe_yuv420p->linesize,
										 out_buffer,
										 AV_PIX_FMT_YUV420P,
										 avcodec_context->width,
										 avcodec_context->height,
										 1);

					int y_size, u_size, v_size;


					//5.2 将yuv420p数据写入.yuv文件中
					//打开写入文件
					const char *outfile = env->GetStringUTFChars(joutFilePath, NULL);
					FILE* file_yuv420p = fopen(outfile, "wb+");
					if (file_yuv420p == NULL){
						__android_log_print(ANDROID_LOG_INFO, "main", "输出文件打开失败");
						return;
					}

					int current_index = 0;

					while (av_read_frame(avformat_context, packet) >= 0){//每次读取一帧，每一个是封装视频上下文，每二个是一帧压缩数据h264	
						//>=:读取到了
						//<0:读取错误或者读取完毕
						//2、是否是我们的视频流 av_stream_index 是之前的索引项
						if (packet->stream_index == av_stream_index){
							//第七步：解码
							//学习一下C基础，结构体
							//3、解码一帧压缩数据->得到视频像素数据->yuv格式
							//采用新的API
							//3.1 发送一帧视频压缩数据给解码器上下文
							avcodec_send_packet(avcodec_context, packet);
							//3.2 解码一帧视频压缩数据->进行解码(作用：用于解码操作)decode_result=0 表示解码成功
							//解码出来的一帧数据放入到avframe_in中
							decode_result = avcodec_receive_frame(avcodec_context, avframe_in);
							if (decode_result == 0){
								//解码成功
								//4、注意：在这里我们不能够保证解码出来的一帧视频像素数据格式是yuv格式
								//视频像素数据格式很多种类型: yuv420P、yuv422p、yuv444p等等...
								//AVPixelFormat结构体中包含了很多种相素格式的视频
								//保证：我的解码后的视频像素数据格式统一为yuv420P->通用的格式
								//yuv420P一般是通用格式，为4:2:0P
								//进行类型转换: 将解码出来的视频像素点数据格式->统一转类型为yuv420P
								//sws_scale作用：进行类型转换的
								//参数一：swscontext视频像素数据格式上下文
								//参数二：原来的视频像素数据格式->输入数据
								//参数三：原来的视频像素数据格式->输入画面每一行大小
								//参数四：原来的视频像素数据格式->输入画面每一行开始位置(填写：0->表示从原点开始读取)
								//参数五：原来的视频像素数据格式->输入数据行数
								//参数六：转换类型后视频像素数据格式->输出数据
								//参数七：转换类型后视频像素数据格式->输出画面每一行大小
								// avframe_yuv420p这里是一帧yuv420p相素数据
								//avframe_in一帧的数据转为yuv420p
								sws_scale(swscontext,
										  (const uint8_t *const *)avframe_in->data,
										  avframe_in->linesize,
										  0,
										  avcodec_context->height,
										  avframe_yuv420p->data,
										  avframe_yuv420p->linesize);

								//方式一：转换后的yuv数据直接显示视频上面去
								//方式二：写入yuv文件格式
								//5、将yuv420p数据写入.yuv文件中
								//5.1 计算YUV大小
								//分析一下原理?
								//Y表示：亮度
								//UV表示：色度
								//有规律
								//YUV420P格式规范一：Y结构表示一个像素(一个像素对应一个Y)
								//YUV420P格式规范二：4个像素点对应一个(U和V: 4Y = U = V)
								y_size = avcodec_context->width * avcodec_context->height;
								u_size = y_size / 4;
								v_size = y_size / 4;
								//5.2 写入.yuv文件 yuv的存放是先存y再存u再存v
								//file_yuv420p是要写入的文件类型file
								//首先->Y数据 从第1个开始写y_size这么大
								fwrite(avframe_yuv420p->data[0], 1, y_size, file_yuv420p);
								//其次->U数据
								fwrite(avframe_yuv420p->data[1], 1, u_size, file_yuv420p);
								//再其次->V数据
								fwrite(avframe_yuv420p->data[2], 1, v_size, file_yuv420p);

								current_index++;
								__android_log_print(ANDROID_LOG_INFO, "main", "当前解码第%d帧", current_index);
							}

						}
					}

					//第八步：释放内存资源，关闭解码器
					av_packet_free(&packet); //一帧压缩数据释放内存
					fclose(file_yuv420p);//存的视频文件
					av_frame_free(&avframe_in);//输入的一帧
					av_frame_free(&avframe_yuv420p);//输入的一帧转为相素数据
					free(out_buffer);//释放输出内存
					avcodec_close(avcodec_context);//关闭解闭器
					avformat_free_context(avformat_context); //关闭视频封装格式解码器


				}


        
        
        
        
        
        
        
        分析：
        获取avformat_context
        avformat_open_input_result   打开文件
        avformat_find_stream_info_result 视频流通过avformat_context查找
        av_stream_index 查找视频流索引  avformat_context->nb_streams遍历，如果等于vedio，则找到
        avcodec_context 解码器上下文               通过avformat_context的流，索引得到
        avcodec 解码器id得到解码器 通过解码器上下文获取->id获取
         avcodec_open2(avcodec_context, avcodec, NULL)
        AVPacket* packet 一帧的数据结构体
        AVFrame* avframe_in 输入一帧
        SwsContext *swscontext 转换视频的上下文参数设置 包括要输出的格式及宽高
        AVFrame* avframe_yuv420p 输出一帧缓冲区
        int buffer_size 得到yuv420p这种缓冲帧的数据大小
        uint8_t *out_buffer 根据大小开辟一块内存空间
        向avframe_yuv420p->填充数据   av_image_fill_arrays
        定义     int y_size, u_size, v_size;
        FILE* file_yuv420p = fopen(outfile, "wb+"); 打开输出文件
        while (av_read_frame(avformat_context, packet) >= 0){  读avformat_context，里面包含了输入的视频文件
        avcodec_send_packet(avcodec_context, packet); 发送一帧压缩数据
        decode_result = avcodec_receive_frame(avcodec_context, avframe_in); 解码一帧压缩数据放到avframe_in中
        sws_scale(swscontext, 把解码的这一帧avframe_in转为yuv420p
        //YUV420P格式规范一：Y结构表示一个像素(一个像素对应一个Y)
                //YUV420P格式规范二：4个像素点对应一个(U和V: 4Y = U = V)
                y_size = avcodec_context->width * avcodec_context->height;
                u_size = y_size / 4;
                v_size = y_size / 4;
         //5.2 写入.yuv文件到file_yuv420p
		//首先->Y数据
		fwrite(avframe_yuv420p->data[0], 1, y_size, file_yuv420p);
		//其次->U数据
		fwrite(avframe_yuv420p->data[1], 1, u_size, file_yuv420p);
		//再其次->V数据
		fwrite(avframe_yuv420p->data[2], 1, v_size, file_yuv420p);
		
		    //第八步：释放内存资源，关闭解码器
		av_packet_free(&packet);
		fclose(file_yuv420p);
		av_frame_free(&avframe_in);
		av_frame_free(&avframe_yuv420p);
		free(out_buffer);
		avcodec_close(avcodec_context);
		avformat_free_context(avformat_context);
        