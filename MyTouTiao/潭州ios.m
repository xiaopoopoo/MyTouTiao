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





