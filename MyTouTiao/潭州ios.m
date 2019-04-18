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
      
      
      
      
      
5  Shell脚本语言-第1讲

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

