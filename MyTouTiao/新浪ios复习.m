1-1 课程导学
深入ios底层技术机制，原理
完善ios技术知识体系
中级 ：ui视图 oc语言 runtime 内存，block,多线程，runloop，网络，
高级：设计模式 架构／框架 算法 第三方使用
ui视图：
uitableview 重用机制理解 运用 数据源多线程操作同步问题
事件传递，视图响应
图像显示原理 控件是如何转换为相素点的 理解ui卡顿 掉帧原因
ui绘制原理／异步绘制
离屏渲染

oc语言
分类 实现机制 原理
关联对象 分类添加变量
扩展 代理
kvo,kvc 系统实现原理机制 设计模式
nsnotification 机制实现原理
属情关键字

runtime
对象，类对象，元类对象分别是什么
消息传递机制是怎样的
消息转发流程是怎样的
方法缓存机制是怎样运行的
method-swizzling runtime的技术实际应用
动态添加方法

内存管理
arc
mrc
引用计数机制
弱引用表
autoreleasepool
循环引用

block
block的本质
截获变量特性
__block修饰的本质
block的内存管理
循环引用

多线程
gcd
nsoperation/nsoperationqueue
nsthread
线程同步，资源共享问题
三种技术怎么解决线程同步，资源共享问题，几种线程有什么特点，区别
互斥锁，自旋锁，递归锁

runloop
什么是runloop
mode/source /timer/observer
事件循环机制是怎样的
runloop与nstimer的关系
runloop与线程之间的关系
如何实现一个常驻线程

网络
http协议 get post区别
https与网络安全 建立链接的流程
tcp/udp 三次握手 四次挥手
dns解析
session/cookie

设计模式
六大设计原则
责任链
桥接
适配器
单例
命令

架构／框架
图片缓存框架
时长统计框架
复杂页面架构
客户端整体架构

算法
字符串反转
链表反转
有序数组合并
hash算法
查找两个子视图的共同父视图
求无序数组当中的中位数

第三库
afnetworking
sdwebimageview
reactive cocoa
asyncdisplaykit

2-1 各大公司初中高IOS工程师岗位技能要求
初级工程师 
会用 精通oc语言基础 正确使用oc分类扩展kvo kvc
uikit cocoa framework 自定义ui控件
网络通信机制，常用数据传输协议的理解 http https 对称加密 非对称 json xml
主流开源框架使用经验 afnetworking 图片异步下载 使用心得
中级工程师
为什么要这样用
编程基础，数据结构，算法解决实际问题
深入理解oc语言机制 runtime 内存管理要求 网络多线程 图形用户ui
常用设计模式，框架，架构
良好分析解决问题能力 最好的学习对象就是源码，深入了解解决问题思路 逻辑
高级工程师
创造性解决开发中关键问题和技术难题
设备流量，性能，电量等调优如外卖 今日头条，视频滑动流畅性
较强的软件设计能力 对超级复杂页面架构设计
ios内部原理有深刻了解
资深工程师
精通高性能编程，性能调优 在前期设计会考虑架构的问题 如字符串大量遍历，选技较优算法
灵活运用数据结构，算法解决复杂程序设计问题
提供性能优化，日志搜集，统计分析方案
架构，模块设计

2-2 如何编写一份让HR或面试官眼前一亮的简历？
遵从：简洁性，真实性，全面性
简洁性：排版清晰，亮点，优势 5年以上的简历不要超过三页，挑选重要突出表达，无关的不需要表达
真实性：可以包装，但不能作假 量化指标去说明问题 如项目表达闪退量的变化，开发前和开发后crash量小于多少，线上bug数变化，开发成本节约了多少，一定有一个量去定论
不要用pv,uv去说，这是用于产品方面的
全面性：个人基本信息邮箱，联系方式很重要，履历过公司要全面，尽量有一个十分亮点的体现
简历四要素：
基本信息 姓名 现居住地 学历 工作年限 专业 邮箱用hotmail gmail比较好 电话 有头像也不错
工作经历 在哪个时间段就职哪个公司什么职位 角色变化体现进步
项目经验 列举比较有亮点的2-3个项目，在项目中承担的角色 是主导 参与 核心研发者
擅长技能 项目背景，方案，效果 了解背景交待 技术方案 效果是方案的验证

主导／参与／核心参与xxx项目
背景 改善原有代码，不易维护，需求快速迭代
方案，合理运用桥接，命令设计模式，对原有业务进行分层，解耦，降低代码重合度
效果 体现出简历全面性 重构前崩溃量 重构后崩溃 重构后清除多少行代码

擅长技能
尽可能突出亮点重点
擅长feed流性能优化，性能优化
是精通，掌握，精通，了解， 中高级要写精通
能通过多线程，runtime机制解决一些难点问题
还有对其它语言，也实事求事，熟悉，精通。
简历是一块敲门砖


3-1 UITableView 相关面试问题
UITableView的重用机制和原理是什么样的
引出事件传递&视图响应的机制和流程
图像显示原理，更好的理解ui卡顿和掉帧的原因
绘制原理&异步绘制，异步绘制是解决ui滑动性能的技术解决方案，什么是离屏渲染，为什么要规避离屏渲染

UITableView 相关
重用机制
cell = [tableview dequeuereusablecellwithidentifer:identifer];

A1  所有在屏外  
A2 一部份显示在屏幕中
A3  所有在屏内
A4  所有在屏内
A5  所有在屏内
A6 一部份显示在屏幕中
A7 所有在屏外
多线程下，数据源同步问题
在继续滑动的情况下，a1是所有都在屏幕外的，会放入到重用池中，当a7要进入屏幕显示的时候
会从重用池中跟据identifer拿内存复用，如果a1，a7都是同一个标识符，a7就可以在重用池中用
a1的内存

下面通过自定义ui控件，字母索引条，来体现在ui重用机制


ViewReusePool 类，代表视图的重用池

ViewReusePool.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 实现重用机制的类
@interface ViewReusePool : NSObject

// 从重用池当中取出一个可重用的view
- (UIView *)dequeueReusableView;

// 向重用池当中添加一个视图
- (void)addUsingView:(UIView *)view;

// 重置方法，将当前使用中的视图移动到可重用队列当中
- (void)reset;

@end

ViewReusePool.m

#import "ViewReusePool.h"

@interface ViewReusePool ()//创建了一个扩展，在里面添加了两个变量
// 等待使用的队列，集合实现
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 使用中的队列，集合实现
@property (nonatomic, strong) NSMutableSet *usingQueue;
@end

@implementation ViewReusePool
//创建两个对列的内存
- (id)init{
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReusableView{
    UIView *view = [_waitUsedQueue anyObject];//从等待的对列当中随机取出一个对象
    if (view == nil) {//如果没有，返回view
        return nil;
    }
    else{
        // 进行队列移动
        [_waitUsedQueue removeObject:view];//如果有，则把这个view从这个等待队列移掉
        [_usingQueue addObject:view];//添加到正在使用的队列中
        return view;//返回这个视图的内存
    }
}

- (void)addUsingView:(UIView *)view
{
    if (view == nil) {//如果是空的，直接返回
        return;
    }
    
    // 如果有则添加视图到使用中的队列
    [_usingQueue addObject:view];
}

- (void)reset{
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {//遍列使用队列中的所有视图，如果有
        // 从使用中队列移除
        [_usingQueue removeObject:view];
        // 加入等待使用的队列
        [_waitUsedQueue addObject:view];
    }
}

@end



IndexedTableView类，是uitableview的子类，实现了带索引条的类

IndexedTableView.h

#import <UIKit/UIKit.h>


@protocol IndexedTableViewDataSource <NSObject>//定义了一个索引条的数据源协议

// 获取一个tableview的字母索引条数据的方法，为字母条提供显示哪些字母
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexedTableView : UITableView
@property (nonatomic, weak) id <IndexedTableViewDataSource> indexedDataSource;//定义一个weak属性关建字的数据源
@end



IndexedTableView.m
//
//  IndexedTableView.m
//  IndexedBar
//
//  Created by yangyang38 on 2018/2/14.
//  Copyright © 2018年 yangyang. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"
@interface IndexedTableView ()//在扩展当中定义了两个成员变量
{
    UIView *containerView;//容器view，用来装载所有字母的控件
    ViewReusePool *reusePool;//声明字母重用池
}
@end

@implementation IndexedTableView

- (void)reloadData{//重写reloaddata方法，在其中实现字母条的重用
    [super reloadData];
    
    // 懒加载，创建容器的view，指定它的背景色为白色
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        //把字母索引条容器插入当前视图的最上边，避免索引条随着table滚动，不写这句话，字母索引条会随着uitableview滚动而滚动
        
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reusePool == nil) {//懒加载去创建重用池
        reusePool = [[ViewReusePool alloc] init];
    }
    
    // 标记所有视图为可重用状态，就是把正在重用队列中的所有视图移除掉，添加到等待重用队列中
    [reusePool reset];
    
    // reload字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar
{
    // 获取字母索引条的显示内容
    NSArray <NSString *> *arrayTitles = nil;//用来表达字母索引条中的所有字母
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {//判断是否响应这个数据源方法
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];//响应则实现它的代理，通过数据源提供方获取这个数据源的数组
    }
    
    // 判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {//如果说获取到的数据源为空
        [containerView setHidden:YES];//没有数据源，设计容器隐藏
        return;
    }
    
    NSUInteger count = arrayTitles.count;//如果有数据
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;//平分tableview获取高度
    
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];//取现每个字母
        
        // 从重用池当中取一个Button出来
        UIButton *button = (UIButton *)[reusePool dequeueReusableView];//取出一个等待重用池中的视图
        // 如果没有可重用的Button重新创建一个
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            
            // 注册button到使用中的重用池当中
            [reusePool addUsingView:button];
            NSLog(@"新创建一个Button");
        }
        else{
            NSLog(@"Button 重用了");
        }
        
        // 添加button到父视图控件
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置button的坐标
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
    }
    
    [containerView setHidden:NO];//设置隐藏属性为no
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}


@end


 
ViewController类，中使用字母索引条类

ViewController.h 
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

ViewController.m


#import "ViewController.h"
#import "IndexedTableView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,IndexedTableViewDataSource>//自定义的数据源IndexedTableViewDataSource
{
    IndexedTableView *tableView;//带有索引条的tableview
    UIButton *button;//点击一下button来reloadload看看在这个自定义字母索引的流程
    NSMutableArray *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个Tableview
    tableView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 设置table的索引数据源
    tableView.indexedDataSource = self;
    
    [self.view addSubview:tableView];
    
    //创建一个按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"reloadTable" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 数据源，1到99的数据
    dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSource addObject:@(i+1)];
    }
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark IndexedTableViewDataSource

- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView{
    
    //奇数次调用返回6个字母，偶数次调用返回11个，这里声名静态的bool值变量
    static BOOL change = NO;
    
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }
    else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果重用池当中没有可重用的cell，那么创建一个cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 文案设置
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] stringValue];
    
    //返回一个cell
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)doAction:(id)sender{
    NSLog(@"reloadData");
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



3-2 UI数据源同步 相关面试问题

新闻，咨询类的app会涉及到数据源同步问题，如头条，微博

场景：
数据源列表a
对数据源列表a进行删除操作，因为是用户手动删除，所以发生在主线程
同时loadmore加载更多数据的操作也发生了，往往是在子线程当中后项刷新网络请求

这个场景就涉及到了多线程对数据源的访问，需要考虑数据源同步问题

两和方案
方案1：并发访问 ，持续拷贝
1。主线程作数据拷贝，拷贝的结果给子线程使用
2。子线程的工作是对新数据的网络请求，数据解析，预排版等内容
3。主线程删除一行数据，reloadui后数据就不见了，如果还有时间，主线程还会作一些其它的任务
4。子线程返回请求的结果，再重新reloadui
5。假设子线程使用的数据是主线程给的数据拷贝，那拷贝的数据是在主线程删除一行数据之前，也就是说子线程返回数据到主线程
仍然包含主线程删除之前的数据，此时会产生删除的那条数据仍然在显示
6。记录主线程之前删除的是哪一条数据，在子线程返回结果的时候再同步删除掉这条数据


方案2：串行访问

1。子线程，在进行网络请求和数据解析
2。子线程作完请求和数据解析后放入到串行对列，对这些数据进行排版
3。主线程此时要删除一行数据，把这个操作放到串行队列当中，等待子线程数据排版完成
后才会同步数据删除，再readui

方案1对内存的开销会有一定影响，方案2删除需要等子线程数据先排版，会有删除延时




3-3 UI事件传递&响应 相关面试问题

首先看一下uiview和calayer的关系

1。uiview包含layer,backgroundcolor两个属性,backgroundcolor是对calayer的属性方法的包装
2。layer包含calayer,calayer包含contents属性，contents决定了uiview的显示
3。contents对应的backing store其实是一个位图，最终显示到屏幕上面的控件都是位图

区别：
uiview
1。uiview为calayer提供显示的内容，如显示红色，白色
2。以及负责处理触摸等事件，参与响应链

calayer
只是负责显示内容，通过contents去显示内容

1。为什么uiview只负责提供显示内容，和响应链，calayer只负责显示
这是一个单一设计原则，体现了职责上的分工

1。事件传递与视图响应链的机制和流程

viewa
  |- viewb1
  |- viewb2
        |-viewc1
            |-viewd
        |-viewc2
        
当点击viewc2发生了什么？

事件传递的两个方法：
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event

1.hitTest返回uiview，最终哪个视图响应事件，就把这个视图返回
2. pointInside判断某一个点击位置是否在视图范围内，如果在就会返回yes

事件传递的流程：
点击屏幕
  |(传递)
uiapplication
  |（传递）
uiwindow
  |(中会判断哪个视图最终响应)  
hitTest （返回最终响应点击事件的视图）
  | （hittest会调用pointinside）
pointInside（判断点击事件是否在uiwindow范围内）
  |  （如果点击事件在uiwindow范围内查找）
subviews（遍列查找子视图，找出最终响应视件的子视图）
      |遍列方式，是以倒序偏历查找的方式
           |最后添加到uiwindows上的视图最优先被遍历
               |在每个子uiview当中会再次调用hittest方法，uiview的子视图又会再调用hittest方法
                    |如果hittest方法返回的是有值的，则这个视图就作为最终点击响应的视图返回
                    
以上流程简要概括：
点击屏幕传递给uiapplication,传递给uiwindow，uiwindow根据hitest去返回最终响应的那个视图，
hitest方法会先调用pointinside方法判断是否点击事件在uiwindow范围内，如果在，则去遍列uiwindow的
subviews所有子视图，遍列是由最顶层先遍列的，每个遍列的子视图，都会调用hitest方法，如果这个子视图内还包含
了子子视图，则选从子子视图开始遍列，如果子子视图的hittest方法返回有值，则这个视图为最终点击响应的视图


hittest方法内部流程：
1。判断视图是否alpha大于0.0.1,是否ishidden,是否userinteraction可点（成立继续第二步，否则返回nil）
2。pointInside方法判断当前点击的点是否在视图范围内（成立继续第三步，否则返回nil）
3。for(int i=v.subviews.count-1;i>0;i--){ sv=v.subviews[i]}
4.sv再调用hittest，如果返回不为空，则返回这个视图sv，响应链结束，这个sv为最终响应的视图
5。如果第3步遍列的子视图的hittest方法返回nil，未找到响应视图，就会把第二步的视图返回

代码实战
一个方形的按钮里面有一个圆形的区域，只有点击圆形区域有响应事件，圆形区域外点击无响应

CustomButton类



CustomButton.h

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@end







CustomButton.m

#import "CustomButton.h"

@implementation CustomButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.userInteractionEnabled ||
        [self isHidden] ||
        self.alpha <= 0.01) {
        return nil;
    }//判断自身如果是隐藏，透明，不可点击，返回nil
    
    if ([self pointInside:point withEvent:event]) {//如果在点击是在范围类
        //NSEnumerationReverse倒序遍历当前对象的子视图，定义每个子视图为hit
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 当前点击的点转换一下坐标转换
            CGPoint vonvertPoint = [self convertPoint:point toView:obj];
            //调用子视图的hittest方法，返回不为空，则表明这个子视图接收了响应
            hit = [obj hitTest:vonvertPoint withEvent:event];
            // 如果找到了接受事件的对象，则停止遍历
            if (hit) {
                *stop = YES;//这里是停止遍历
            }
        }];
        
        if (hit) {
            return hit;
        }
        else{
            return self;
        }
    }
    else{
        return nil;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //取出点击位置的横纵坐标
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    //表示方形按钮的中心
    CGFloat x2 = self.frame.size.width / 2;
    CGFloat y2 = self.frame.size.height / 2;
    
    //计算当前点击的这个点距离方形中心的实际距离
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    // 如果这个距离小于方形按钮半径，则在圆形范围内，返回yes
    if (dis <= self.frame.size.width / 2) {
        return YES;
    }
    else{
        return NO;
    }
}

@end


ViewController类

ViewController.h
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end



ViewController.m
#import "ViewController.h"
#import "CustomButton.h"
@interface ViewController ()
{
    CustomButton *cornerButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cornerButton = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    cornerButton.backgroundColor = [UIColor blueColor];
    [cornerButton addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cornerButton];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)doAction:(id)sender{
    NSLog(@"click");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


视图响应链的传递，如果这个过程中传到uiapplicationdelegate也没有响应，则当这个事件没有发生

uivewa-uicontrolview的view-uiwindow-uiapplication-uiapplicationdelegate


uiview继承自UIResponder，UIResponder视图响应方法：

//当手指触摸屏幕时触发(刚开始接触
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

//当手指触摸屏幕, 并且在视图内移动时触发(此时手指不离开屏幕
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

//当手指离开屏幕时触发(接触结束)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event


其它方法
//当触摸被取消时, 前提是手指必须触摸屏幕(例如, 电话进入时)
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event

//修改自身视图颜色
- (void)changeSelfColor
{
    self.backgroundColor = [UIColor randomColor];
}
 
//修该父视图颜色
- (void)changeSuperviewColor
{
    self.superview.backgroundColor = [UIColor randomColor];
}

//改变自身视图位置
- (void)changeSelfLocation
{
    self.center = CGPointMake(arc4random() % (270 - 50 + 1) + 50, arc4random() % (518 - 50 + 1) + 50 );
}


3-4 UI图像显示原理 相关面试问题
ui卡顿及掉帧原因
cpu和gpu是通过总线连接的，cpu的数据最终通过总线上传给gpu，gpu会
作相应位图的图层的渲染包括纹理的合成，之后把结果放到帧缓冲区中（frame buffer），由视频控制器
根据微信格信号在指定时间之前去提取帧缓冲区中屏幕显示内容，最终显示到手机屏幕上。
首先创建一个uiview，显示部份由calayer负责，calayer中有一个contents属性是最终要绘制到屏幕上的
位图，如一个uilable上显示hello word，contents属性包含了一个hello world的位图，系统在合适的时机回调一个drawrect方法，
我们可以在此方法内绘制其它内容在hello word之上。绘制好之后会经由core animation
框架交给opengl es渲染管线（gpu），进行渲染及文理的合成。最终显示在屏幕上。
calayer|core animation都发生在cpu
opengl发生在gpu

cpu的工作
layout display prepare commit  布局(frame设置及文字宽高计算)-显示或绘制（实际上是绘制的过程，drawrect）-作一些准备（图片的解码编码）-把位图提交到gpu（coreanimation）

gpu的渲染管线
5个步骤：
顶点着色 - 图元装配 - 光栅化 - 片断着色 - 片断处理
5个步骤完成之后提交到framebuffer中
由视频控制器到framebuffer中提取要显示的内容。



3-5 UI卡顿&掉帧原因 相关面试问题
正常情况下不卡顿是每秒60帧，相当于1帧16.7秒，在16.7秒的时候微信格信号会来取
cpu和gpu合成的frame buffer数据，如果gpu,cpu计算时间过长，当微信格信号来取帧的时候会取不到或取到一部份，就会产生卡顿掉帧现象

原因分析后如何提高tableview,scrollview滑动流畅性？
滑动优化方案：
cpu优化：
 对象创建调整销毁可以放到子线程去作，以节省cpu的时间。
 预排版（布局计算，文本计算）放到子线程去作
 预渲染（文本等异步绘制，图片解码方案）
 gpu优化：
 纹理渲染：（圆角，阴影蒙层，masterbounds设置 ）尽量避免离屏渲染
 可以根据异步绘制机制减轻压力
 视图混会：视图层级比较复杂，gpu会合成每一个相素点的相素值，gpu会作大量的计算，
 如果减轻视图层级的复杂性，也可以减轻gpu的压力，异步绘制机制减轻压力。
 
 

 3-6 UI绘制原理&异步绘制 相关面试问题
 设用uiview setneedsdisplay 并没有立即发生当前视频的绘制工作，而是在之后的某一时机
 才会进行绘制。为什么呢？
 uiview setneedsdisplay
       | 调用
       | 
 view.layer setneddsdisplay(会打一个脏标记)
       |
       |
 calayer display（当前runloop将要结束的时候才调用介入到绘制流程中）
       |  calayer display会判断layer是否响应displaylayer代理方法
       |
 layer.delegate responds to @selector(displaylayer:)
 （displayer代理方法不响应，则会进入系统绘制流程中）
 （displayer代理方法响应，则会进入异步绘制入口中）
 
 
 系统绘制流程：
  系统的内部calayer会创建一个backings store（cgcontextref上下文椎站中部顶取出context）
      |
  layer会判断是否有代理
   |              |
   |              | （没有代理）执行
   |
   |           layer drawincontext
   |（有代理）执行
layer.delegate drawlayer:incontext(作系统内部的绘制工作)
   |在合适的时机回调drawrect方法
   uiview drawrect
           |（无论是哪种分支，最后都由calayer上传到gpu中，也就是系统的位图）
           |
    calayer uploads backing store to gpu
    
    
异步绘制的原理
 如果实现了layer.delegate displaylayer这个代理方法，就会进入到异步绘制流程当中
 在这个代理方法中负责生成对应的位图，并把位图作为layer.contents属性提交
 
流程1主线程：
   view setneedsdisplay
      当runloop将要结束的时候调用
   calayer display 
      判断是否实现代理方法displaylayer函数
      如果实现会调用这个代理方法displaylayer以及方法内部的其它内容（切到子线程）
      
      
流程2子线程：
cgbitmapcontextcreate()创建位图上下文
corecraphic api 位图的绘制工作api
cgbitmapcontextcreateimage() 根据上下文这个方法生成位图图片再（切到主线程）

流程3主线程
calayer setcontents设置位图到contents中




3-7 UI离屏渲染 相关面试问题&面试总结

什么是离屏渲染，你对离屏渲染是怎样理解的？

在屏渲染：
当前屏幕渲染，gpu的渲染操作是在当前用于显示的屏幕缓冲区中过行
离屏渲染：
gpu在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染。当设置某些图层属性，在这些属性已经准备好后才能显示到屏幕上，这样才触发了
离屏渲染。如设置视图圆角，蒙层遮罩

何时会触发离屏渲染？
圆角和masktobounds一起使用时
图层蒙版
阴影
光栅化

为何要避免离屏渲染？
cpu和gpu在绘制中作了大量工作，离屏渲染让opengles 触发了多通道渲染管件，产生额外开销
这样产生cpu和gpu耗时超过16.7耗秒(高级工程师回答)。初中级工程师回答：创建新的渲染缓冲区，上下文切换。会有gpu额外开销

uitableview滚动流畅性方案或思路？
cpu 子线程创建对象，销毁，布局

uiview和calayer关系
uiview事件传递响应
calayer显示工作  
用到了单一职责的设计原则，6大设计对象中



第4章

4-1 Objective-C相关面试问题

什么的分类，分类的实现机制和原理？（可以通过runtime去查看原理）

能否为分类添加实例变量？（考察关联对象的技术）

分类和扩展的区别？

代理的相关技术知识？

通知的实现机制和原理？ns开头的，没有开放出源码，考察对通知实现机制的理解

kvo的实现机制是怎样的，监听内容，以及kvc的原理

属性关键字，在定义创建类声明一些属性，retain copy assgin weak ，怎样使用copy
关键字



4-2 分类相关面试问题-1 category

你用分类都做了哪些事？
1。分类声明私有方法
定义一个分类，只把它的头文件引入到某些工具类的.m当中，对外不报露
2。分解体积庞大的类文件
类的功能复杂，把同一功能分类的放到一个分类文件当中
3。把framework的私有方法公开化

分类的特点？
运行时决议：编好分类文件之后并未把对应的内容给数组类中，而是在运行时加入
可以为系统类添加分类：uiview获取坐标的分类方法，系统类是不能添加扩展的

分类中都可以添加哪些内容？
实例方法 可以
类方法  可以
协议  可以
属性 可以 在分类中定义属性，只生成了get set方法，并未有添加实例变量
实例变量添加  可以通过运行时关联对象添加

分类的结构体分析

struct category_t{
    const char *name; 分类名称
    classref_t cls;  分类所属的数组类
    struct method_list_t *instancemethods;  实例方法列表
    struct method_list_t *classmethods;    类方法列表
    strut protocol_list_t *protocols;   协议方法列表
    struct property_list_t *instanceproperties;  实例属性例表
    
    method_list_t *methodsformeta(boll ismeta){
        if(ismeta) return classmethods;
        else return instancemethods;
    } 
    
    porperty_list_t *propertiesformeta(bool ismeta){
        if(ismeta)return nil;
        else return instanceproperties;
    }

通过分类的结构可以验证分类可以添加哪些内容 object-680版本runtime源代码

分类加载调用栈

_objc_init(程序启用时在运行时会调用这个方法，rutntime的初始化，然后再调用一系列方法后加载分类)
  | map_2_images(调用) 静象，程序，内存静象的处理
      |map_images_nolock(调用) 
          |_read_images(调用)  读静象。加载可执行文件到内存中
              | remethodizeclass(分类的加载内容从这个方法开始)
              
remethodiaeclass方法：

static void remthodizeclass(class cls)//(分类添加实例方法，类方法，属性，实例等，这里分析实例方法逻缉)
  category_list *cats;
  bool ismeta;
  
  runtimelock.assertwriting();
  
  ismeta = cls->ismetaclass();//判断当前类是否为元类对象，取决于当前添加的方法是实例方法还是类方法，这里假设实例方法，变量为no
  if(cats = unattachedcategoriesforclass(cls,false)){//获取类对应的还未有拼接整合的分类，从方法名可以看出，如果这个类有分类
      if(printconnecting){
          _objc_inform("class:attaching categories to class '%s' '%s'",cls->nameforlogging(),ismeta?"(meta):""");
      }
      //将分类cats拼接到cls上
      attachcategories(cls,cats,true);
      free(cats);
  }
 
 
attachcategories并接分类方法内部实现：

static void stachcategories(class cls,category_list *cats,bool flush_caches)
  if(!cats)return;//没分类就return
  if(printreplacemethods) printreplacements(cls,cats);
  
  bool ismeta = cls->ismetaclass();//如果这里是no，实例方法分类,为类（alloc出来的）添加分类，不是为元类添加分类
  
  //声明三个实例变量，都是二维数组,里面代表的是一个分类有几个方法
  [[method_t,method_t],[method_t,method_t]]
  method_list_t **mlists = (method_list_t**)malloc(cats->count *sizeof(*mlists));//方法列表
  property_list_t **proplists = (property_list_t**)malloc(cats->count *sizeof(*proplists));//属性列表
  protocol_list_t **proplists = (protocol_list_t**)malloc(cats->count *sizeof(*protocolists));//协议列表
  
  int mcount =0;//方法参总数
  int propcount =0;//属性总数
  int protocount = 0;//协议总
  int i = cats->count;//宿主类分类的总数
  bool frombundle = no;
  while(i--){//倒序遍历，最先访问最后编译的分类,多个分类有同名方法，最后编译的分类的同名方法会生效
     //获取一个分类
     auto&entry = cats->list[i];
     //获取该分类的方法列表
     method_list_t *mlist = entry.cat->methodsformeta(ismeta);
     if(mlist){
         //最后编译的分类最先添加到分类数组中
         mlists[mcount++] = mlist;
         frombundle |= entry.hi->isbundle();
      }
      //属性列表添加规则 同方法列表添加规则
      property_list_t *proplist = entry.cat->propertiesformeta(ismeta);
      if(proplist){
          proplists[propcount++] = proplist;
      }
      //协议列表添加规则 同方法列表添加规则
      protocol_list_t *protolist = entry.cat->protocols;
      if(protolist){
          proplists[propcount++] = proplist;
      }
      //获取宿主类当中的rw数据，其中包含宿主类的方法列表信息
      auto rw = cls->data();
      //主要是针对 分类中有关于实现内存管理相关方法情况下，就会覆盖掉系统原生的方法，retain release等
      preparemethodlists(cls,mlists,mcount,no,formbundle);
      /*
      rw 代表类
      methods 代表类的方法列表
      attachlists 方法的含义是 将含有mcount个元素的mlists拼接到rw的methods上
      *／
      rw->methods.attachlists(mlists,mcount);//分类的方法添加到宿主上面
      free(mlists);
      if(flush_caches && mcount>0) flushcaches(cls);
      rw->properties.attachlists(proplists,propcount);
      free(proplists);
  }
 


4-3 分类相关面试问题-2
addedlists是刚才传过来的二维数组,最面包含了多个分类，以及每个分类有多少个方法的二维数组
[method_t,method_t,...],[method_t]

attachlists拼接列表具体函数的实现，addedlists准备拼接的分类列表  准备添加的分类列表个数
void attachlists(list* const * addedlists, uint32_t addedcount){
    if(addedcount ==0)return;
    if(hasarray()){//主要分析这个if语句
        //列表中原有的元素方法总数 oldcount =2;
        unit32_t oldcount = array()->count;
        //拼接后的元素总数
        uint32_t newcount = oldcount +addedcount;
        //根据新总数重新分配内存
        setarray(array_t *)realloc(array(),array_t::bytesize)
        //重新设置元素总数
        array()->count = newcount;
        //内存移动 [[],[],[] [原有的第一个元素],[原有的第二个元素]]
        memmove(array()->lists+addedcount,array()->lists,oldcount*sizeof(array()->lists[0]));
        //内存拷贝
        [a--->[addedlists中的第一个元素]]，
        [a--->[addedlists中的第二个元素]]，
        [a--->[addedlists中的第三个元素]]，
        [原有的第一个元素],
        [原有的第二个元素],
        //把addedlists元素拷贝到list当中
        memcpy(array()->lists,addedlists,addedcount *sizeof(array()->lists[0]));
    }else if(!list && addedcount==1){
        //0 lists->1 list
        list = addedlists[0];
    }else{
        //1 list->many lists
        list * oldlist = list;
        uint32_t oldcount = lodlist ? 1:0;
        unit32_t newcount =  oldcount + addedcount;
        setarray(array_t *)malloc(array_t::bytesize(newcount));
        array()->count = newcount;
        if(oldlist)array()->lists[addedcount] = oldlist);
        memcpy(array()->lists,addedlists)
    }
}

通这上面这个列子，可以看出分类方法是可以覆盖掉宿主类方法的原因，宿主类方法实际是存在的
因为查找方法是根据选择器先查找的，所以同名方法是先执行分类方法，如果没有分类方法，再执行宿主类方法

分类添加的方法可以“覆盖”原类方法
同名分类方法谁能生效取决于编译顺序，最后被编译的分类会最优先被生效
名字相同的分类会引起编译报错，



4-4 关联对象相关面试问题
怎样为分类添加“成员变量”？
不能在定义声明上添加成员变量，可以用关联对象的技术为分类添加成员变量

相关方法： 
id objc_getassociatedobject(id object,const void *key)//根据指定的key到object这个对象当中获取指定的对象关联值
void objc_setassociatedobject(id object,const void*key,id value,objc_associationpolicy policy)//设定value，通过key与value建立关系，通过关联策略policy把key与value的关系关联到object上
关联策略分为copy retain assgin
void objc_removeassociatedobjects(id object)//根据指定对象移除它的所有关联对象

关联对象技术添加的成员变量被添加到哪儿里了？是不是添加到该分类对应的宿主类上了，还是添加到别的地方了？
答：肯定没被添加到宿主类上面，被添加到哪里了呢？

关联对象的本质：

关联对象是由associationsmanager 管理并在associationshashmap中存储，associationsmanager的成员变量associationshashmap去存储关联对象，
associationshashmap是一个全局容器，无论哪个对象添加了关联，都放到了这个同一个全局容器中。

如下结构：
objcassociation
      |
objc_association_copy_nonatomic(关联的协议，用copy协议关联了hello)
      |
    @"hello"





调用objc_setassociatedobject方法：
第一步：生成objecassociation，objecassociation 包含的成员结构 (objc_association_copy_nonatomic  @"hello")，这里描述通过assgin或retain关键字关联hello
第二步：通过objectassciationmap 包含（@selector(text) ，这个相当于sethello方法选择器），与 objcassociation再作关联
第三步：objectassciationmap 对象是放在associationshashmap 这个全局对象中的
第四步：associationshashmap（disguise(obj)当前被关联对象的指针值与objectassciationmap建立关联）
总结：associationshashmap全局容器关联 objectassciationmap    objectassciationmap 关联objecassociation

源码分析：
id objc_getassociateobject(id object, const void *key)
{
  return objc_getassociateobject_non_gc(object,key);
}
主要分析set函数：
void objc_setassociatedobject(id object ,const void *key,id value,objc_associationpolicy policy)
{
   objc_setassociatedobject_non_gc(object,key,value,policy);
}
void objc_removeassciatedobjects(id object){
  #if support _gc
      if(UseGC){
          auto_zone_erase_associative_refs(gc_zone,object);
      }
}

void _object_set_associative_reference(id object ,void *key,id value ,uintptr_t policy)
{
    objcassociation old_association(0,nil);
    id new_value = value? acquirevalue(value,policy):nil;
    {
        //关联对象管理类，c++实现一个类
        associationmanager manager;
        //获取其维护的一个associationshashmap,我们可以理解为是一个字典
        //是一个全局容器
        associationshashmap &associations(manager.associations());
        disguised_ptr_t disguised_object = disguise(object);
        if(new_value){
            //break any existing association
            //根据对象指针查找对应一个objectassociationmap结构的map
            associationshashmap::iterator i = associations.find(disguised_object);
            if(i != associations.end())
        }
    }
}

关联对象的数据结构

{
  "0x38473893":{
      "@selector(text)":{ //@property(retain) NSString *text;
        "value": "hello",
        "policy": "retain"
      }
     },
  "0x23373893":{
      "@selector(title)":{
        "value": "a obj",
        "policy": "copy"
      }
     },
}

怎样清除某个关联对象被关联的值呢？
setobject的value设为nil
void objc_setassociatedobject(id object,const void*key,id value,objc_associationpolicy policy)


4-5 扩展相关面试问题
扩展 extension

一般用扩展来做什么？
声明私用属性，不对子类报露
声明私有方法，为了方便阅读
声明私有成员变量与属性是有区别的

分类与扩展区别？
扩展是编译时决定的，分类是运行时决定
扩展只以声明的形式存在，多数情况下寄生于宿主类.m中
不能为系统类添加扩展 但可以为系统类添加分类

4-6 代理相关面试问题
准确的说是一种软件设计模式
ios中以@protocol形式体现
传递方式一对一 通知一对多方式

代理的工个流程是怎么样的

代理的协议生成   

协议  代理方  委托方
委托方要求代理方实现的接口全都定义在协议当中，协议中可声明属性以及方法。
协议方声明的方法由代理方进行实现，代理方实现的具体的方法可以会有返回值，返回值返回给委托方
委托方需要调用代理方遵从的协议和方法

协议中可以定义成员属性和方法，在协议中所声明的方法和属性代理方需要必需实现吗？
不一定，如果协议中声明的方法如果requider必须实现，如果是options则可实现可不实现

代理中可能遇到的问题？

一般委托方以weak关键字声明以规避循环引用

代理方  strong  委托方
委托方  weak声明  代理方



4-7 通知相关面试问题
代理和通知区别

通知：
使用观察者模式来实现的用于跨层传递消息的机制
传递方式是一对多的

代理：
代理是由代理模式实现的，代理传递方式是一对一，通知是一对多

通知实现：
发送者  经由通知中心 广播给多个观察者

如何实现通知机制？
ns开头的系统类是没有源代码的，不知道实现原理
假如自己设计实现通知，怎么实现？
通知中心类中可能会维护一个子典，它的key是noificationname,
value是observer_listo数组列表，包含通知接收的观察者，以及
观察者的回调方法相关信息。



4-8 KVO相关面试问题-1 
什么是kvo，kvo实现机制是什么样的

kvo全称是key-value observing
kvo是oc对观察者设计模式的又一实现
apple使用了isa混写（isa-swizzling）来实现kvo

isa混写技术在kvo中是怎样实现的呢？

当向通知中心注册了通知以后，观察者a中包括setter方法，isa pointer
系统会动态创建一个nskvonotifying_a的类，这个类重写setter方法，同时原来的
观察者a的isa指针会指向动态创建的这个nskvonotifying_a类，把isa的指向进行修改称为isa混写技术的方式
nskvonotifying_a的类实际上是观察者a的子类，通过子类重写setter方法来达到通知观察者的目的。


kvo的使用案例：

 AppDelegate.m
 
 
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建两个对象
    
    MObject *obj = [[MObject alloc] init];
    MObserver *observer = [[MObserver alloc] init];
    
    //调用kvo方法监听obj的value属性的变化，完成observer对obj对象value成员值临听，断点在这里的时候打印obj是mobserver
    [obj addObserver:observer forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
   
    //通过setter方法修改value，这时候value值变了，所以mobserver中的方法会临听到,断点在这里的
    时候打印obj是nskvonotifying_mobserver,isa指针已经重新指向了
    obj.value = 1;
    
    // 1 通过kvc设置value能否生效？
    [obj setValue:@2 forKey:@"value"];
}

@end


代码实现kvo

MObject.h

#import <Foundation/Foundation.h>

@interface MObject : NSObject

@property (nonatomic, assign) int value;

- (void)increase;

@end





MObject.m

#import "MObject.h"


@implementation MObject

- (id)init
{
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}

- (void)increase
{
    //直接为成员变量赋值
    [self willChangeValueForKey:@"value"];
    _value += 1;
    [self didChangeValueForK
    ey:@"value"];
}

@end



MObserver.h


#import <Foundation/Foundation.h>

@interface MObserver : NSObject

@end





MObserver.m

#import "MObserver.h"
#import "MObject.h"
@implementation MObserver

//一旦MObject的value值有变化，就会进入这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //判断是不是被监听的成员对象以及成员变量
    if ([object isKindOfClass:[MObject class]] &&
         [keyPath isEqualToString:@"value"]) {
        
        // 获取value的新值
        NSNumber *valueNum = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"value is %@", valueNum);
    }
}

@end




  4-9 KVO相关面试问题-2
  
  系统重写的set方法增加了两行代码如下
//NSKVONotifying_A的setter实现
-(void)setValue:(id)obj
{
   //增加的一
  [self willChangeValueForkey:@"keyPath"];
  //调用父类实现，也即原来类的setter方法实现
  [super setValue:obj];
  //增加的二，这个方法会触发监听回调的方法- (void)observeValueForKeyPath:
  [self didChangeValueForKey:@"keyPath"];
}

面试的两个问题：
    // 1 通过kvc设置valuekvo能否生效？
    [obj setValue:@2 forKey:@"value"];
    问题一是在描述kvo与kvc之间的关系，这个是能生效的。为什么kvc设置value会使kvo生效呢？因为这个方法最
    终会调用obj中的setter方法，所以setter又是重写的，就能生效。
    
    // 2. 通过成员变量直接赋值value，kvo能否生效?
    [obj increase];，increase方法中_value += 1;
  


kvo的使用案例：

 AppDelegate.m
 
 
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建两个对象
    
    MObject *obj = [[MObject alloc] init];
    MObserver *observer = [[MObserver alloc] init];
    
    //调用kvo方法监听obj的value属性的变化，完成observer对obj对象value成员值临听，断点在这里的时候打印obj是mobserver
    [obj addObserver:observer forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
   
    //通过setter方法修改value，这时候value值变了，所以mobserver中的方法会临听到,断点在这里的
    时候打印obj是nskvonotifying_mobserver,isa指针已经重新指向了
    obj.value = 1;
    
    // 1 通过kvc设置value能否生效？
    [obj setValue:@2 forKey:@"value"];
    
    // 2. 通过成员变量直接赋值value能否生效?不生效。
    //为使生效，在increase方法手动让kvo生效，加入 willChangeValueForKey，didChangeValueForK
    ey就可监听到kvo的
    [obj increase];
    
    return YES;
}

@end


代码实现kvo

MObject.h

#import <Foundation/Foundation.h>

@interface MObject : NSObject

@property (nonatomic, assign) int value;

- (void)increase;

@end





MObject.m

#import "MObject.h"


@implementation MObject

- (id)init
{
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}

//increase方法手动让kvo生效，加入 willChangeValueForKey，didChangeValueForK
    ey就可监听到kvo的
- (void)increase
{
    //直接为成员变量赋值
    [self willChangeValueForKey:@"value"];
    _value += 1;
    [self didChangeValueForK
    ey:@"value"];
}

@end



MObserver.h


#import <Foundation/Foundation.h>

@interface MObserver : NSObject

@end





MObserver.m

#import "MObserver.h"
#import "MObject.h"
@implementation MObserver

//一旦MObject的value值有变化，就会进入这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //判断是不是被监听的成员对象以及成员变量
    if ([object isKindOfClass:[MObject class]] &&
         [keyPath isEqualToString:@"value"]) {
        
        // 获取value的新值
        NSNumber *valueNum = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"value is %@", valueNum);
    }
}

@end






ViewController.h

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end




ViewController.m

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",array);
}


@end



4-10 KVC相关面试问题

KVC是key-value coding的缩写
是苹果系统为我们提供的一种键值编码技术
两个方法：
方法1：
-(id)valueForKey:(NSString*)key
来获取和key同名或者所相似名称的一个实例变量的值
-(void)setValue:(id)value forKey:(NSString:)key
来设置某一对象当中和这个key同名或者说相似实例变量的值进行设置

键值编码技术是否会破坏面向对象编程方法或违背面向对象编程思想呢？
如果我们在知道某一个类或者说实例某一个私有变量名称的情况下，可在外界对已知的key可以对类内部的变量访问和设置的
所有会破坏面向对象编程思想

这两个方法的系统实现流程？

valueForKey调用流程：

系统通过key判断所访问的实例变量是否有get方法，如果有，会进行调用get方法，结束valueforkey方法，如果不存在get方法
会判断实例变量是否存在，+(BOOL)accessInstanceVariablesDirectly,这个方法默认返回yes，如果和key相同相似的成员变量存在
返回yes ，如果重写这个方法返回值，返回no，即使这会和key相同相似的成员变量存在，但返回no，也不能通过valueforkey获取到这个成员
变量，如果实例变量存在，会获取这个实例变量的值，结束valueforkey的调用流程。如果实例变量不存在，系统会调用当前valueforundefinedkey方法
会给出一个未定义key的异常结束这个流程

accessor method访问器方法是否存在的判断规则：
访问器方法定义是相仿的概念，key 对应 getKey , 属性名称为key和key相同，也可以返回这个key,key和isKey方法也对应

instance var
同名和相似成员变量
比如参数为key，获取的是_key，也可以获取_iskey, key,isKey,都可以满足成员变量的获取。



setValue的调用流程：
判断是否有和key相关的setter方法，如果有，会调用set方法，结束setValue方法，如果没有，会找和key相同相似的成员变量，
+(BOOL)accessInstanceVariablesDirectly这个方法去判断成员变量是否存在。是存在，给key对应的成员变量传值，如果不存在会调用
系统会调用当前valueforundefinedkey方法。会给出一个未定义key的异常结束这个流程





4-11 属性关键字相关面试问题&面试总结

属性关键字的分类：

1：读写权限相关关键字
readonly readwrite 默认是redwrite

2：原子性
atomic nonatomic 默认是atomic，这个会产生什么效果，它是可以保证赋值和获取是线程安全的，对成员的直接的一个获取赋值，
这个并不代表操作和访问，怎么理解呢？比如atomic修饰的是一个数组，对这个数组赋值获取能保证线程安全，但是如果对数组添加对象和移除对象，
是不能保证线程安全的，只保证数组的获取和赋值

3。引用计数关键字
retain/strong retain arc使用，strong mrc中使用
assign/unsafe_unretained assign基本数据修饰，对象数据类型能修饰但会产生野指针，因为基本数据类型在栈中，如果修饰对象，堆中类存释放了，但栈中还
有指针存在。而unsafe_unretained，不知道自己自己已经被释放，会野指针，闪退
mrc中使用频繁，arc中已经退出历史了。
weak copy

assign weak区别有哪些？
assign基本数据类型int bool，修饰对象类型时不改变引用计数。
assign修饰对象会产生悬垂指针。释放之后assign仍会指向原对象内存地址，这时访问对象会导致内存泄露

weak
不改变修饰对象的引用计数
所指的对象在被释放之后会自动置为nil

区别：
weak可以修饰对象，但不能修饰基本数据类型，assign两者都可修饰，但对象会产生内存泄漏。
assign修饰对象会产生悬垂指针。释放之后assign仍会指向原对象内存地址，这时访问对象会导致内存泄露
weak所指的对象在被释放之后会自动置为nil
两者都不改变被修饰对象的引用计数


weak指针修饰的对象在被弃掉之后为什么被指为nil呢？

copy
@property(copy)nsmutablearray *array? 这样的申明会导致什么问题呢？会产生的对象是不可变的对象数组

浅拷贝深拷贝理解：
浅拷贝：
有一个指针a，指向某一个对象内存，如果这时浅拷贝，会有一个b指针会指向一个同一内存地址
浅拷贝会增加对象的引用计数，并未发生内存分配
深拷贝：
有一个指针a指向一个对象内存，深拷贝，会产生另一个内容相同的内存，然后会有一个b指针指向
这块内存，两不指针指向不同的内存，但两块内存的内容相同

深拷贝不会增加引用计数，深拷贝产生内存分配，产生两块内存

如何区分，看是否开辟内存空间，是否影响引用计数，深拷贝不影响引用计数

copy
可变对象用copy，拷贝出的对象是不可变对象，深拷贝
可变对象用mutablecopy,拷贝出的对象是可变，深拷贝
不可变对象用copy,拷贝出的对象是不可变对象，浅拷贝
不可变对象用mutablecopy,拷贝出的对象是可变对象，深拷贝

总结：
可变对象的copy和mutablecopy都是深拷贝
不可变对象的copy是浅拷贝，指针拷贝，不可变对象的mutablecopy是深拷贝，内存拷贝
copy方法返回的都是不可变对象
mutablecopy方法返回的都是可变对象


@property(copy)nsmutablearray *array? 这样的申明会导致什么问题呢？
会产生的对象是不可变的对象数组，是深拷贝。只要copy操作就是不可变对象，不能添加，删除对象内容，这时会引起闪退。

oc笔试题总结

mrc下如何重写retain修饰变量的setter方法？
@property(nonatomic,retain) id obj;
-(void)setObj:(id)obj
{
  if(_obj != obj){//判断是为防止传入的是一个相同对象，会提前释放
     [_obj release];
     _obj = [_obj retain];
  }
}

请简述分类实现原理：
是由运行时决议的，不同分类当中含用同名分类方法，谁最终生效，取决于谁最后参与
编译，如果分类方法所添加的一个方法恰好是宿主类的一个同名方法，分类方法会覆盖
宿主类方法，这里的覆盖是指会遍历查找优选调用分类方法，实际上宿主类原名方法还是存在的。

kvo实现原理是怎样的？
kvo是系统观察者模式的别一种实现，kvo运用了isa混写技术，来动态运行时去为某一个类添加子类，子类重写
setter方法，同时把原有类isa指针指向这个子类。

能否为分类添加实例变量？
可通过关联对象为分类添加成员变量。





第5章节   动态运行时runtime的相关原理


5-1 Runtime数据结构相关面试题-1

1。编译时语言与obj这种动态语言之间的区别是什么？
2。消息传递与函数调用之间有什么区别？
3.当一个方法没有实现的时候，系统是怎样实现消息转发过程的？

想要得到上面答案，
从runtime的数据结构学起？
类对象与元类对象分别代表什么？
实例与类对象之间的关系？
类对象与元类对象之间的关系？
消息传递机制是怎样的？
消息传递过程中，如何进行缓存的方法查找？
消息转发流程是怎样的？
method-swizzling 方法混xiao  在运行时去替换一些方法的实现？
动态添加方法，动态方法解析？



数据结构？

objc_object:
id = objc_object，id对象在runtime中对应objc_object
objc_object结构体包括：
isa_t 共用体
关于isa操作相关方法：如通过结构体获取isa所指向的类对象，或者通过类对象的isa指针获取它的元类对象，以及遍列的方法。
弱引用相关的方法：标记一个对象它是否曾经有过弱引用指针
关联对象相关方法：比如说这个对象设置了一些关联属性，关联属性相关方法也在这个结构体中
内存管理相关方法实现：在mrc中retain,release,或arc,mrc下面都用到的autoreleasepool




objc_class:
Class = objc_class,OC中Class在runtime中对应objc_class，它也是一个结构体
objc_class继承自objc_object的结构体。
Class这个类是否是一个对象呢？Class这个类也是一个对象，称之为类对象，因为它继承自objc_object，
objc_class结构体包括：
Class  superClass:如果objc_class是类对象，superClass那指向的是父类对象，平时的类与父类的关系是通过
superClass去定义的。
cache_t  cache:表达方法缓存的，在消息传递过程中，会使用方法缓存的数据结构
class_data_bits_t   bits:一个类所定义的一些变量属性包括它的一些方法都在bits它的成员结构中，主要是对class_rw_t的封装。
class_rw_t代表类相关读写信息，对class_ro_t的封装，class_ro_t包括比如为分类添加的一些方法，以及协议在其中。ro表示readonly，代表只读
class_rw_t包含：class_ro_t,protocols,properties,methods,后面三个都是list_array_tt类型二维数组。如methods，第一层由不同分类构成数组，每个分类都是数组，里面包含method_t这样
数据结构  
class_ro_t，name类名（可以通过string获取一个类） ivars（声明定义的一些类的成员变量,一维数组） properties(一维数组)， protocols(一维数组),methods(一维数组)和class_rw_t中成员是有区别的。
class_rw_t里是二维数组，methodList存的内容一般是分类添加的内容，class_ro_t一维数组，methodList存的内容存的是原来类中添加的一些方法内容，包含method_t结构





isa指针:
共用体isa_t,共用体无论是32,64位架构中内存地址要么都是0,要么都是1
isa指针分两种类型：指针型isa，非指针型isa。指针型isa表示内存地址所有为,或我代表它指向的class地址。
比如说我们使用一个id = objc_object对象的时候，通过isa的内容，或取到它的类对象的地址。非指针型isa，它的
值的部份代表class地址，目的是节省内存的目的。
isa指针含义：可以回答指针型isa，非指针型isa。
isa指向：关于对象，其指向类对象，比如说实例，也就是oc当中id类型，runtime中的objc_object结构体，它的isa指针指向了
Class(类对象及objc_class)，Class(类对象)的isa指向元类对象（MetaClass）.
一个对象的方法调用，先找到这个对象的类对象，也就是class中进行方法查找
一个类方法的调用，通过类对象（class）的isa指针到它的元类对象中去查找方法
总结：没有创建实例的类，isa指针指向元类，类方法都会在元类中去查找
有创建实例的类，isa指针指向类对象，也就是这个类，方法在这个类对象中查找。



cache_t:
用于快速查找方法执行函数：比如说调用一个方法时，如果有缓存，就不需要在它的方法列表中一个个遍列
可以提高方法调用或消息传递的速度
是可增量扩展的哈希表结构：当结构存的量在增大，它会增量扩大内存空间，hash表提高查找效率
是局部性原理的最佳应用：在一般调用方法，调用频率高的方法放到缓存中
cache_t结构体：
cache_t是一个数组实现的，里面每个对象都是bucket_t结构体
bucket_t包含key,IMP. key对应oc中的select方法选择器，IMP是一个无类型函数指针，指向具体函数实现




method_t:
实际上是对于一个方法的抽象说明



5-2 Runtime数据结构相关面试题-2
method_t数据结构：
函数四要素：名称，返回值，参数，函数体
method_t：
SEL name;代表方法的名称 相当于name
const char* types;函数的返回值和参数的组合  返回值和参数
IMP imp;无类型函数指针，对应的函数体

types怎么表达函数的返回值和参数
type encodings苹果技术来表达
const char* types;
返回值（第一位置，因为在函数中返回值往往一个） 参数1 参数2 参数n
-(void)aMethod; v@:  v（void） @(id) ：(sel选择器)

整体数据结构runtime

objc_class继承自objc_object，objc_object有一个isa_t指针指向objc_class类型的类对象或者说元类对象
objc_class主要包含superclass(指向当前类的父类，是一个class类型，指向一个objc_class类型的指针) 
cache_t（消息传递中的缓存方法查找，装着8k的bucket_t的hash表 ）  
class_data_bits_t（表达的是类的基本信息，成员，属性，方法列表，以及分类的方法等，是对class_rw_t数据结构的封装）
class_rw_t包含class_ro_t ,methods,properties,protocols
class_ro_t包含分类相关的 name（类名称）,methodList,ivars(变量列表)，properties（属性列表）,protocols（协议列表）  



5-3 类对象与元类对象&消息传递相关面试问题


1。类对象和元类对象分别是什么，类对象和元类对象有什么区别？
类对象存储实例方法列表等信息 
元类对象是存储类方法列表信息内容

根类NSObject类，root class： 指向的父类是nil，即没父类
子类以及子类的子类，当一个实例是id类型时，当中有一个isa成员变量所指向的就是这个id所对应的类对象（子类或子类的子类）
如UIView *v = [[UIView alloc]init]; v中的isa指针指向类对象UIView
如Person类，有一个类方法+(void)eat; Person类中isa指针指向它的person元类对象，元类维护了这个类方法列表如eat方法，person的子类
同样也会指向一个person子类的元类对象
这些都是继承自objc_class，objc_class又继承自objc_object，所以才会有isa指针找到它们的类对象或元类对象

元类对象的isa指针指向哪里？
无论是子元类对象，根元类对象，它们的isa指针都是指向根元类对象，根元类对象的指针指向它本身

根元类对象它的superclass指针指向了根类对象root class这个比较特殊：

比如调用类方法是从元类对象方法列表中查找，从子类到父类
一级级查找，当调用的这个类方法在根元类对象找不到时，会找根类对象当中同名的实例方法实现
如果用同名方法，就会执行同名方法的调用。不会造成闪退。如果没找到，就会找根类对象的父类，即nil

比如调用实例方法，首先从类对象由子类到父类去遍列方法列表，没找到方法找父类的方法列表，未找到找
根类的方法列表，如果未找到就会走到消息转发流程

面试题：
#import "Mobile.h"
@interface phone :Mobile

@end

@implementation Phone
-(id)init
{ 
  self = [super init];
  if(self){
      NSLog("%@",NSStringFromClass([self class]));//消息的接收者是当前对象，class这个方法是在nsobject当中才有实现的
      NSLog("%@",NSStringFromClass([super class]));//super调用它的class实际接收者任然是当前对象，也就是phone，
      调super class是从当前对象的父类对象中开始查找方法实现，无论从哪查找都是找到nsobject当中，因为这里面有class方法
  }
}
@end


消息传递
方法1:
void objc_msgSend(void/*id self, SEL OP,...*) 第一个参数是对象消息的接收者，第二个是方法选择器名称，第三个是真正消息传递的方法参数
任何一个消息传递的书写[self class],通过编译器会转换成objc_msgSend(self,@selector(class))
方法2：
void objc_msgSendSuper(void/*struct objc_super *super,SEL op,...*/)  //接收对象objc_super，其实还是self对象，只是会从该对象所属的类的父类去查找方法，不对该类本身的方法去查找

super在编译中会是编译成objc_super
struct objc_super{
  _unsafe_unretained id receiver;//这个接收者其实就是当前对象self，即phone
  
  [super class]转换后objc_msgSendSuper(super,@selector(class)),所以无论调用super class 还是self class
  消息的接收者都是当前对象，打印都是phone
}


方法1与方法2的区别：
调用方法-查找缓存-有方法实现-invoke函数指针调用函数实现一次消息传递
调用方法-查找缓存-没有方法实现-根据当前实例的isa指针查找当前类对象方法列表-找到后-invoke函数指针调用函数实现一次消息传递
调用方法-查找缓存-没有方法实现-根据当前实例的isa指针查找当前类对象方法列表-未找到-向父类一级级方法列表查找，通过当前类对象superclass
指针去查找父类方法列表，一直往向查指到nil为止
-未找到-会进入消息转发流程

消息转发流程的回答？



5-4 方法缓存查找相关面试问题
消息传递机制重要的一个流程，消息缓存查找。它的流程和步骤：

步骤1缓存查找：
例：给定的方法选择器sel，来查找是对应bucket_t中的方法实现imp，bucket_t数据结构是方法选择器和实现的一个封装体。
实际上是在objc_class中cache_t这个结构体，通过方法选择器sel，通过一个hash函数，算出它以及mask，作位与操作，求出函数的实现在数组中的一个索引位置，
从bucket_t数据结构中找出来函数的实现，通过函数指针返回给调用方，mask也是bucket_t的一个成员，这是一个hash查找，解决查找效率的问题。

频聚2当前类查找
消息传递中每一步骤，在消息缓存中查找，第二步骤在当前类中查找：
当前类实际上是有对应的方法列表的，对于已排序好的方法列表，采用二分查找算法查找方法对应的执行函数实现。
对于没有排序的列表，采用一般遍历查找方法对应执行函数实现。

频聚3 父类逐级查找

通过当前类的superclass成员变理，去查找它的父类，到父类后判断父类是否为nil，如果有父类，在父类缓存中查到方法实现，就结束，如果缓存中没找到，需到当前父类的方法
列表查找，如果有把函数实现返给调用方，如果还未查找到，再到父类的父类查找，直到查到nsobject的父类为nil是，没找到，就结束父类的查找，进入到消息转发流程，这是关于父类逐级查找过程。



5-5 消息转发相关面试问题

消息转发流程是怎样的：
对于实例消息转发流程，系统会回调：resolveInstanceMethod:
对于类方法消息转发流程，系统会回调：resolveClassMethod:
主要研究实例消息转发流程：
类方法resolveInstanceMethod有一个参数sel消息选择器，返回值是bool，告诉系统要不要解决当前实例方法的实现，返回yes，
通知系统消息已经处理，结束消息转发流程，如果说返回no，系统会回调forwardingTargetForSelector:这个方法，给每二次机会
处理消息。、
第二次处理机会：
forwardingTargetForSelector:参数也是sel，返回值id,告诉系统这次系统实例的方法调用应该由哪个对象来处理，如果指定转发目标，系统
会把这条消息指定给此转发目标，系统结束消息转发流程，如果每二次机会返回nil，未给转发目标，系统会给我们第三次处理消息的机会，系统会调用
methodSignatureForSelector:
第三次处理机会：
methodSignatureForSelector:参数也是sel，返回是一个类或一个对象，这个对象是对于方法这个方法选择器sel返回值的类型，以及参数个数，类型的封装，
些时如果返回了方法签名，那系统会调用forwardInvocation:如果forwardInvocation:方法能处理这条消息，那消息转发流程结束，如果methodSignatureForSelector返
回nil，或者forwardInvocation:没有办法处理这条消息，被标记为消息无法处理，常见的carsh未识别消息选择器，实际上就是走到这里所产生的打印结果。

代码感受系统消息转发流程顺序。

RuntimeObject.h

#import <Foundation/Foundation.h>

@interface RuntimeObject : NSObject

- (void)test;

@end


RuntimeObject.m

//
//  RuntimeObject.m
//  RuntimeTest
//
//  Created by yangyang38 on 2018/2/25.
//  Copyright © 2018年 yangyang. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>
@implementation RuntimeObject

void testImp (void)
{
    NSLog(@"test invoke");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // 如果调用的是当前类对象的test方法 打印日志
    
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod:");

        // 动态添加test方法的实现
        class_addMethod(self, @selector(test), testImp, "v@:");
        
        return YES;//如果返回no，会到forwardingTargetForSelector中
    }
    else{
        // 返回父类的默认调用
        return [super resolveInstanceMethod:sel];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"forwardingTargetForSelector:");
    return nil;//返回nil，回到methodSignatureForSelector
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(test)) {//如果是test方法，返回方法签名 
        NSLog(@"methodSignatureForSelector:");
        // v 代表返回值是void类型的  @代表第一个参数类型时id，即self
        // : 代表第二个参数是SEL类型的  即@selector(test)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//void self sel
    }
    else{
        return [super methodSignatureForSelector:aSelector];//否则返回父类调用，这会调用forwardInvocation:(NSInvocation *)anInvocation
    }
}

//打印这条方法命称日志
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"forwardInvocation:");
}

@end

AppDelegate.m

#import "AppDelegate.h"
#import "RuntimeObject.h"
#import "Account.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RuntimeObject *obj = [[RuntimeObject alloc] init];
    // 调用test方法，只有声明，没有实现,这会看到消息转发流程的实现
    [obj test];
    
    return YES;
}











5-6 Method-Swizzling相关面试问题

在现有的类中有两个方法：
方法slelector1   对应的实现  imp1 
方法slelector2   对应的实现  imp2
当经过Method-Swizzling之后，实际上就是修改slelector1所对应的方法实现
slelector1 此时对应实现imp2， slelector2此时对应实现imp1
当给对象发送消息时，会对应修改后的实现

通过代码来了解：Method-Swizzling


RuntimeObject.h

#import <Foundation/Foundation.h>

@interface RuntimeObject : NSObject

- (void)test;
- (void)otherTest;

@end





RuntimeObject.m

#import "RuntimeObject.h"
#import <objc/runtime.h>
@implementation RuntimeObject

+(void)load
{
    //获取test方法的结构体
    Method test = class_getInstanceMethod(self,@selector(test));
    //获取otherTest方法的结构体
    Method otherTest = class_getInstanceMethod(self,@selector(otherTest));
    //交换两个方法的实现
    method_exchangeImplementations(test,otherTest);
}

-(void) test
{
    NSLog(@"test");
}

-(void) otherTest
{
    [self otherTest];//这里会产生死循环吗？不会，因为作了方法替换，在向该对向发送otherTest消息的时候，实际上是向test的实现发送了消息
    NSLog(@"otherTest");
}
//打印结果，选打印test,再打印了otherTest，当执行test方法时，执行的是[self otherTest],这个又相当于执行了test的实现打印了test,然后再打印NSLog(@"otherTest");

@end

//主要用在开发中我们打印一些系统日志，如在viewdidload中打印日志，不用在每个viewcontrol的viewdidload中写上打印的代码，只需要写一些替换方法，这个时候
//把打印的代码放到替换的方法中能看到日志信息，而不用每个类去添加这样的打印日志代码。





5-7 动态添加方法相关面试问题

你是否有使用过performSelector:方法？
主要考runtime动态添加方法的特性

performSelector应用场景：
可能一个类在编译时没有这个方法实现，在运行时才产生了这个方法。在此场景下要调用这个方法，需要使用
performSelector

代码实现为一个类动态添加方法：

AppDelegate.m
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RuntimeObject *obj = [[RuntimeObject alloc] init];
    // 调用test方法，只有声明，没有实现
    [obj test];
    
    return YES;
}



 RuntimeObject.h

#import <Foundation/Foundation.h>

@interface RuntimeObject : NSObject

- (void)test;

@end



 RuntimeObject.m
 
#import "RuntimeObject.h"
#import <objc/runtime.h>
@implementation RuntimeObject

//test方法执行体，是一个函数指针
void testImp (void)
{
    NSLog(@"test invoke");
}

//对象的方法只声明未实现会走到这个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // 如果是test方法 打印日志
    
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod:");

        // 动态添加test方法的实现  参数1：为该类对象添加方法 参数2：方法名称 参数3：方法实现 参数4:v，返回类型，@当前对象self，：方法的返回值类型 @selector(test)，对应的参数个数，参数类型，后面三个参数其实是method_t的成员变量
        class_addMethod(self, @selector(test), testImp, "v@:");
        //会打印resolveInstanceMethod  test invoke
        return YES;//告诉系统我们处理了
    }
    else{
        // 返回父类的默认调用
        return [super resolveInstanceMethod:sel];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"forwardingTargetForSelector:");
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector:");
        // v 代表返回值是void类型的  @代表第一个参数类型时id，即self
        // : 代表第二个参数是SEL类型的  即@selector(test)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    else{
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"forwardInvocation:");
}

@end




5-8 动态方法解析相关面试问题&面试总结

你使用过@dynamic这个编译器关键字吗？
声明的属性用@dynamic这个关键字修饰的时候，实际上对应的set,get方法不是在编译时去声明好实现的，而是运行时添加的。
考察编译时语言和动态时语言的区别。
动态运行时语言将函数决议推迟到运行时。把一个属性设为@dynamic时，代表在编译时不需要生成get ,set方法实现，而是在
运行时调用get,set方法时再为它添加get,set方法的实现，这只有运行时语言才支持的功能。
编译时语言编译期决译，在编译期执行函数是哪个，运行时是无法进行修改的。

runtime实战问题：
1。[obj foo]向obj对象发送foo这个消息和objc_msgsend()函数之间有什么关系？
在编译器的处理过程之后，objc_msgsend第一个参数obj ，第二个参数为foo的选择器，编译后就转化为函数调用了，然后进行runtime的消息传递流程ru

2。runtime如何通过selector找到对应的imp地址的？
消息传递机制是查找当前实例对象缓存是否有imp实现，没命中，查当前类方法列表，
如果未找到实现，找当前类父类方法列表的实现，找到就返回方法实现的指针。

3。能否向编译后的类中增加实例变量？
编译后的类，由于runtime支持运行时动态添加类的。
编译后的类，它已经完成了实例变量的布局，class_ro_t已经代表了readonly，所以编译后的类是不能增加实例变量的，
如果是动态添加的类，是可以添加实例变量的。分类中可以添加实例变量，因为分类是在运行时中进行的。





第六章   内存相关

6-1 内存布局相关面试问题
内存布局
内存管理方案
数据结构
arc & mrc
引用计数
弱引用
自动释放池
循环引用  对内存管理的理解深度


内存布局：由下到上，低地址到高地址

内核区
栈（stack） 方法和函数都是在在栈上工作的 高地址向低地址向下扩展，方法调用在这个区展开
堆（heap） block 或对象copy之后放这里，堆是向上增长的  通过alloc等分配的对象
未初始化数据(.bss)  未初始化静态变量 全局变量
已初始化数据(.data) 已初始化静态变量 全局变量
代码段(.text) 
保留



6-2 内存管理方案相关面试问题

问题：ios是怎样对内存进行管理的？
分析：ios会根据不同的场景提供内存管理方案：
答：
比如对一些小对象如nsnumber这种，采用的是taggedpointer管理方案

对于64位架构下的ios程序，采用的是nonpointer_isa管理方案，在这种架构下，isa指针是是这个比特位的
其实有32个bit位就够用了，其它是浪费的，苹果为了提高这内存的利用率，isa余下的bit位中存储了内存管理相关的内容
所以这叫非指针型isa管理方案

散列表内存管理方案 散列表是一个复杂的数据结构，其中包括了引用计数表和弱引用表


在后面的小节中关于内存管理源码分析都是基于objc-runtime-680版本讲解



nonpointer_isa（非指针型）管理方案：

在arm64位架构中，一共有64个bit位，

前内存管理存储的前16位：

0  0  0 0  0  0  0  0  0  0  0  0            0                        0                                 0
（            shifcls            ）    （has_cxx_dtor）          （第1位has_assoc）                    （第0位）
如果这里第0位是0，表示此isa指针是一个纯的isa指针，那它其它16位的地址内容就代表了当前纯对象的ios地址
如果第0位是1,就表示它不仅是一个对象地址，里面还包含了一些类对象的管理数据，第1位表示当前对象是否有关联对象，0代理没有，1代表有
第2位has_cxx_dtor表示当前对象是否有使用c++方面的代码或c++方面的内容，也可表示有些对象是通过arc管理的
第3-15位 shifcls 表示当前对象类对象的指针地址
  
前内存管理存储的后16位：

0  0  0 0  0  0  0  0  0  0  0  0            0                        0 
（            shifcls                                                 ）  
shifcls  表示当前对象类对象的指针地址

前内存管理存储的47位往前：
47位
0  0  0 0  0  0  0  0  0  0  0  0            0                        0 
（extra_rc 引用计数未上限存到散列表中）   
（has_sidetable_rc当前isa指针当中引用计数如果达上线，需外挂一个sidetable数据结构去存相关引用计数，也就是闪列表）       
（  deallocating标志当前对象是否在进行dealloc操作  ）     
（  weakly_referenced范围的位数表示对象是否有弱引用指针    ）   
 （  magic位段不作解释    ）
 
 前内存管理存储的63位往前：
 （extra_rc 引用计数未上限存到散列表中） 
 0  0  0 0  0  0  0  0  0  0  0  0            0                        0
 
 
 sideTables()结构 散列表面试相关的问题：
 
 sideTables()是一个hash面，在非嵌入式系统中，里面包括了64个sideTable数据结构
 可以根据对象指针找到它的引用计数表在哪一个sideTable当中，
 
 
sideTable结构：

自旋锁（spinlock_t多线程资源竞争相关）    引用计数表（refcountmap）   弱引用计数表(weak_table_t)

思考；为什么不是一个sideTable呢，而是64个？

  如果只有一张表，所有的对象引用计数在这张表中，如果某些对象的操作是在多线程下进行的，这时就需要给对象加锁处理保证线程安全，
  这就存在效率问题，一个对象在操作这张表，下一个对象去操作就得等前一个对象操作完了把锁释放掉后才能操作。
  
系统引用分离锁，把表分成8个，不同的表加锁，可并发操作，提高访问效率。


怎样实现快速分流呢？
sidetables的本质是一张hash表，有64张sideTable存储
hash表的概念讲解一下：

对象指针（key）经过hash函数计算出是哪张sidetable(value)，索引是哪个

hash查找： 给一个内存指针地址prt 用函数f(ptr)计算  得到index索引
f(ptr) = (uintptr_t)ptr % array.count 取余计算

为什么hash查找，是因为存储通过hash函数存的，比如内存地址是8，与数组总数取余
得到一个数组的index存进去，访问的时候也通过这种hash函数方式去访问题高效率。




6-3 自旋锁，引用计数表，弱引用计数表数据结构相关面试问题 

spinlock_t自旋锁（spinlock_t多线程资源竞争相关）
是忙等的锁，如果当前锁已被其它线程获取，当前线程会不断探寻锁是否被释放
其它锁，如信号量，当获取不到锁会把这个线程阻塞休眠，等到其它线程释放锁唤醒线程
自旋锁比较适合轻量访问，也就是加1减1  
面试题：你是否使用过自旋锁，自旋锁和普通锁有什么区别，适用于什么场景，这样的面试题应该有答案了

引用计数表（refcountmap） 
是一个hash表，通过指针找到对应对象引用计算，对传入对象指针用函数来计算存储位置的，获取也是
通过函数计算位置的，提高效率。
引用计数表的内存分析：

0  0  0 0  0  0  0  0  0  0      0      0            0 
            （deallocating是不是正在dealloc）     （weakly_reference是否有引用计数）
  

弱引用计数表(weak_table_t)
也是一张hash表，通过hash函数，传入指针，计算出一个弱引用指针的位置（weak_entry_t）



6-4 MRC&ARC相关面试问题

mrc是手动引用计数进行管理内存
alloc分配一个内存空间  retain 引用计数加1  release引用计数减1
retaincount获取对象的引用计数值   autorelease 这个对象会在autoreleasepool结束的时候调用它的release操作，引用计数减1
dealloc 在mac当中调用这个需要显示调用 super dealloc来释放父类的相关成员变量


arc是自动引用计数进行管理内存
编译器会自动在相应的位置插入reatin,release操作，这样的回答不足
还需要runtime和编译器共同协作才能组成arc的结果
在arc中调用retain release retaincount autorelease dealloc会引起编译报错 ,但可重写某个对象的
dealloc方法，但不能调用super dealloc
arc中新增weak,strong属性关键字

arc和mrc有什么区别？
arc是由编译器和runtime协作实现的自动引用计数管理
mrc是手动引用计数管理，同是可以调用一些引用计数相关的方法
arc中禁止调用retain/release/retaincount/dealloc
arc中新增weak,strong属性关键字

1.何为assign?assign 是oc中定义对象属性property时用于修饰基本数据类型和oc数据类型的关键字。
2.为什么assign不能用于修饰对象？首先我们需要明确，对象的内存一般被分配到堆上，基本数据类型和oc数据类型的内存一般被分配在栈上。
如果用assign修饰对象，当对象被释放后，指针的地址还是存在的，也就是说指针并没有被置为nil，从而造成了野指针。
因为对象是分配在堆上的，堆上的内存由程序员分配释放。而因为指针没有被置为nil,如果后续的内存分配中，刚好分配到了这块内存，就会造成崩溃。
而assign修饰基本数据类型或oc数据类型，因为基本数据类型是分配在栈上的，由系统分配和释放，所以不会造成野指针。




6-5 引用计数管理相关面试问题
实现原理分析：

alloc实现：
经过一系列调用，最终调用了c函数calloc。此时并没有设置引用计数为1，
但retaincount获取的引用计数为1，我们可以看retaincount的实现

retain实现：
    sidetable & table = sidetables()[this];
这是objc680原码，这里是通过当前对象的指针到sidetables中获取它所属的sidetable，关于sidetables是由多个sidetable组成的hash表，可通过hash函数指针
通过hash函数计算，可快速找到对应的sidetable。
size_t& refcntstorage = table.refcnts[this];
在sidetable结构中获取引用计数map的成员变量，通过当前对象的指针在这个sidetable引用计数表中去获取当前对象的引用计数人土目土
这个查找过程也是一次hash查找
refcntstorage += side_table_rc_one;
size_t是一个无符号的引用计数值，我们对这个值进行引用计数加1操作,这里加的是一个宏定义，而不是1，因为在存引用计数的时候前两位
不是存引用计数的，后62位才是存引用计数的。这里实际是加上了一个偏移量的操作。反应后的结果是加1
面试题产生：我们在进行加1操作的时候系统是怎样查找它的引用计数的？
经过两次hash查找，查找到对应的引用计数值进行加1操作

release实现：
sidetable & table = sidetables()[this];
通过hash算法找到sidetable，
refcountmap::iterator it = table.refcnts.find(this);
通过当前对象指针访问当前table的引用计数表去查找它对应的引用计数表，
it->send -= side_table_rc_one;
查找到之后对引用计数减1操作

retaincount实现：
sidetable & table = sidetables()[this];
通过hash算法找到sidetable，
size_t refcn_result = 1;
声名它的局部变量，指定它的值是1
refcountmap::iterator it = table.refcnts.find(this);
通过对象指针去引用计数表查找
refcnt_result+= it->second >>side_table_rc_shift;
查找结果作一个向右偏移操作，再结合局部变量refcn_result，进行加操作。
所以刚alloc出来的对象，是没有引用计数为1的，因为这个refcn_result = 1，当
去调用retaincount时才能获取到它的值为1.


dealloc实现：重要

调用_objc_rootdealloc()函数，该函数会调用一个rootdealloc()函数，这个函数会判断

当前对象是否可以直接释放，直接释放的判断条件依据于右侧的这个列表：
nonpointer_isa  判断当前对象是否使用非指针型的isa
weakly_referenced 当前对象是否有weak指针指向它
has_assoc  判断当前对象是否有关联对象
has_cxx_dtor  判断当前对象内部实现是否有c++涉及内容，以及当前对象是否有arc来管理内存，如果使用arc管理内存，或涉及c++内容就会yes
has_sidetable_rc 当前对象的引用计数是否是通过sidetable表来维护的，因为如果是非指针型的指针时，它内部是存储了关于引用计数指针的值，当超出上限的时候，
会使用sidetable进行存储引用计数

只有上面5个内容同时符合时，才能调用c函数free()进行释放
否则会调用object_dispose()对象作后续的清理。这个函数会对有弱引用的对象先进行一些处理，以及关联对象，引用计数，c++相关处理

 object_dispose()作了哪些事情？
 首先调用objc_destructinstance() 消毁实例的函数
 再调用c函数free();
 
 objc_destructinstance()具体实现：
 首先判断当前对象是否有c++相关内容，是否采用的arc，如果有相关内容调用object_cxxdesturt()方法对c++语言处理
 如果没有相关c++内容，调用hasassociatedobjects判断当前对象是否有关联对象
 如果有调用_object_remove_assocations()关联对象移除，这里有一个面试题：
 通过关联对象技术为类添加一些实例变量，我们在deacoll中是否需要对关联对象移除呢？这里已经知道不需要，系统内部已经作了处理
 如果没有关联对象，系统继续调用一个函数cleardeallocating()，结束调用
 
 cleardeallocating()具本实现：
 调用sidetable_cleardeallocating()这个函数调完又会调用weak_clear_no_lock()将指向该对象的弱引用指针置为nil
 如果weak指针指向对象，当对象deacoll后为什么被置为nil了，这里可作回答。
 weak_clear_no_lock()调用之后又会调用table.refcnts.erase()清除掉当前对象在引用计数表中的一些存储数据，然后结束调用。
 
 
 
 6-6 弱引用管理相关面试问题
 一个weak变量是怎样添加到弱引用表中的？
 id __weak obj1 = obj;此时产生了一个弱引用指针，经过编译后会生成下面代码：
 id obj1;
 objc_initweak(&obj1,obj);//&obj1弱引用变量，obj是弱引用的修饰对象，
 objc_initweak会调用storeweak();
 storeweak()会调用weak_register_no_lock()进行弱引用变量的添加，具体通过hash算法查找弱引用表，再找到弱引用数组，把新弱引用指针加入弱引用表
 打开xcode分析一个弱引用变量是怎样添加到弱引用表中的：
 
 weak_register_no_lock(对象所属的sidetable的弱引用表，被弱引用指向的原对象，弱引用指针，对象在弃用的时候crash的标志位)
 产生一个newobj，新对象，这个新对象如果有值
 调用newobj->setweaklyreference_nolock();产生一个弱引用标志位
 
  weak_register_no_lock(对象所属的sidetable的弱引用表，被弱引用指向的原对象，弱引用指针，对象在弃用的时候crash的标志位)的具体实现：
  if(entry = weak_entry_for_referent(weak_table,referent)){//通过原对象指针去查找它在弱引用表的数组，涉及到弱引用对hash算法查到弱引用表
      append_referrer(entry,referrer)//把新产生的指针添加到弱引用表
  }
  
  当一个对象被释放时，weak变量是怎样被处理的？
  会被自动设为nil
  内部会调用weak_clear_no_lock()弱引用清除函数函数，这个函数源码分析：
  weak_clear_no_lock(弱引用表，dealloc的那个对象)
  weak_entry_t *entry = weak_entry_for_referent(weak_table,referent);//通过dealloc的那个对象产生的局部变量，查找弱引用数组
  遍列弱引用所取出来的所有弱引用对象，如果弱引用指针存在，就把弱引用指针设为nil
  
  
  
  6-7 自动释放池相关面试问题
  
  -(void)viewDidLoad
  {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",array);
  }
  请思考这个array是在什么时候释放的？
  在每一次runloop将要结束的时候对前一次创建的autoreleasepool进行释放操作，会调用autoreleastpoolpage::pop方法，会push一个新的
  autoreleasepool，所以这个array对象是在当次runloop将要结束的时候调用autoreleastpoolpage::pop方法进行释放
  
  autoreleasepool的实现原理是怎样的？
  
  autoreleasepool为何可以嵌套使用？
  就是多次插入哨兵对象，及插入要释放的对象，每次进行一个autoreleasepool代码块创建的时候，系统会为我们进行一个哨兵对象插入，完成一个
  新的autoreleasepoolPage创建，autoreleasepoolPage是一个栈，用一个双向链表维护的，如果page没有满，就插入一个哨兵对象，所以autoreleasepool就是
  多次插入哨兵对象，及要释放的对象
  
 
 编译器会将@autoreleasepool{}改写为如下代码：
 void *ctx = objc_autoreleasePoolPush();
 objc_autoreleasePoolPop(ctx);
 
objc_autoreleasePoolPush()的内部实现：
会调用c++方法  autoreleasepoolpage:push(void)

objc_autoreleasePoolPop(ctx)的内部实现：
会调用autoreleasepoolpage::pop(void* ctxt)
一次pop实际上相当于一次批量的pop操作：
在autoreleasepool这个方法花括号当中所有对象，都会添加到
自动释放池中，当进行pop后，所有的对象都会被发送一次release消息，
所以是一次批量操作

自动释放池的数据结构是怎样的？
是以栈为节点通过双向链表的形式组合而成的，
是和线程一一对应的。

什么是自动释放池，自动释放池的实现结构是怎样的，面试题？

双向链表：
parentptr 父指针
childptr 子指针

头节点父指针指向空，子指针指向头节点的下一个节点，下一个节点有两个子针，一个父子针指向头节点，
   子指针指向下一个节点，尾结点的子指针指向一个空。
   
栈结构：
栈是向下增长的，下面高地址，上面是高地址

栈顶 从栈顶后加入的对象先弹出来， 后入先出

栈底
   
   
autoreleasepoolpage这个c++类的分析：
它的组成成员如下：
id *next; 指向栈当中下一个可填充的位置
autoreleasepoolpage *const parent; 双向链表父指针
autoreleasepoolpage *child;双向链表孩子指针
pthread_t const thread;线程成员变量一一对应的

autoreleasepoolpage的栈结构：

  低地址    栈顶
  next     next指针指向栈的一个空位置，有新的对象就添加到next指向的位置
  id obj1  花括号中填写的要释放的autorelease对象
  id obj2
  autoreleasepoolpage  低地址 栈底
  自身占用的内存

autoreleasepoolpage::push的内部实现：
把next向上移，然后之前的next指向位置插入要释放的对象

[obj autorelease]；这个方法的autorelease实现？
会判断当前next指针是否指向了栈顶，如果没有指向栈顶直接把当前对象添加到next栈指向的位置，结束流程
如果next是指向了栈顶，增加一个autoreleasepoolpage节点拼结到链表上，在新的栈上去添加对象，并把next向上移动。


autoreleasepoolpage::pop的内部实现：
根据传入的哨兵对象（要释放的对象）找到对应对象在栈中的位置。然后给上次push操作之后添加的对象依次发送
release消息。回退next指针到正确的位置，即next指针下移致力正确位置


什么情况下需要我们手动创建autoreleasepool呢？
在for循环中alloc出大量的图片数据，这些数据对内存消耗非常大，需要在for循环内部创建一个autoreleasepool
每一次for循环都对内存进行一次释放

autoreleasepool的实现原理是怎样的？
就是以栈为节点通过双向链表组成的数据结构，一个autoreleasepoolpage是一个栈，添加时把对象放入到这个栈的next指针指向位置，然后next指针
向上移动，如果这个栈满了，就会再增加一个autoreleasepoolpage，把对象添加到新的栈上，并把next指针向上移。释放的时候找到这些对象，发送release消息，
然后next指针向下移动回到应有的位置。



6-8 循环引用相关面试问题&面试总结-1
循环引用分为三种类型：

自循环引用：
有一个对象，它有一个成员变量 id strong obj，这时对象强执有这个成员变量，此时给obj=self（原对象）造成一个自循环引用

相互循环引用：
对象a，它有一个成员变量 id strong obj
对象b，它有一个成员变量 id strong obj
此时对象a的obj指向对象b，对象b的obj指象对象a，造成相互循环引用


多循环引用
对象a，它有一个成员变量 id strong obj
对象b，它有一个成员变量 id strong obj
对象c，它有一个成员变量 id strong obj
对象d，它有一个成员变量 id strong obj
对象e，它有一个成员变量 id strong obj
对象f，它有一个成员变量 id strong obj
每个对象的obj都指向下一个对象，就产生大环的循环引用

考点：
  代理 是相互循环引用，所以代理不能用strong类型
  block（爱考）block章节再讲解
  nstimer（爱考）
  大环引用
  
如何破除循环引用呢？
避免产生循环引用  如代理设为weak
在合适的时机手动断环 

具体解决方案有哪些？
__weak 在代理 block中会用到
__block 一般使用在block中解决循环引用问题
__unsafe_unretained 修饰的关键字是未增加引用计数的

__weak破解循环引用的解决方案：
对象a，它有一个成员变量 id weak obj
对象b，它有一个成员变量 id strong obj

__block破解方案：

mrc下,__block修饰对象不会增加其引用计数，避免了循环引用
arc下，__block修饰对象会被强引用，无法避免循环引用，需手动解环

__unsafe_unretained方式破解循环引用：
修饰对象不会增加其引用计数，避免了循环引用。
如果被修饰对象在某一时机被释放，会产生悬垂指针！这会访问对象会出错，所以不建议使用这种方式


循环引用示例：
你在平时开发过程中是否遇到过循环引用，你是怎么解决循环引用问题的？
block的使用示例，请参看block章节讲解

nstimer循环引用问题：
比如有一个vc控制器，里面有一个scrollview的对象obj，负责轮播广告
此时vc对obj是strong持有的，obj广告需每隔一次进行播放，涉及到定时器的使用
所以需要在obj广告栏所属这个类中添加成员变量nstimer强引用,为nstimer添加回调事件后，
nstimer会对这个对象obj进行强引用，产生了相互循环引用问题？
思考：
把这个obj广告栏对象弱引用nstimer，能破除循环引用吗？
不会，因为nstimer被分配内存之后，还会被当前线程的runloop进行一个强引用，如果nstimer是在
主线程创建的，那么就由主线程持有这个nstimer. 就形成runloop强引用nstimer,nstimer强引用obj广告栏，
vc也强引用obj广告栏，这时即使vc不引用obj广告栏，但是nstimer被runloop强引用不能消毁，所以nstimer还是
强引用obj，使obj广告栏不能释放。

nstimer有重复定时器和非重复定时器的区分：
如果创建的这个nstimer是非重复定时器，即只调用一次回调方法，那么会在定时器回调方法中调用nstimer invalidate()方法，停止定时器，然后nstimer=nil
如果创建的这个nstimer是一个重复多产回调方法的定时器，就不能作nvalidate()，nstimer=nil的操作，
解决方案：增加一个中间对象，nstimer不再指向这个obj，而是强引用中间对象，中间对象弱引用nstimer,和obj.  在中间对象的类中，nstimer回调方法中
判断弱引用的obj是否为nil，如果为nil，表示vc控制器消毁，及广告栏消毁，则可在回调方法中设置nvalidate()，nstimer=nil的操作





6-8 循环引用相关面试问题&面试总结-2

关于这个nstimer破除循环引用方法的内部实现：
+(NSTimer *)schedledWeakTimerWithTimeInternal:(NSTimeInterval)interval
 target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats;


NSTimer+WeakTimer.h
#import <Foundation/Foundation.h>

@interface NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats;

@end



NSTimer+WeakTimer.m
#import "NSTimer+WeakTimer.h"

@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;//weak指向的
@property (nonatomic, assign) SEL selector;//定时器到时之后的回调方法
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer
{
    if (self.target) {//判断如果当前持有的target存在，
        if ([self.target respondsToSelector:self.selector]) {//是否响应这个选择器，如果响应就回调下面这个方法
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    }
    else{
        [self.timer invalidate];//不响应就把timer置为无效，就达到timer强引用及弱引用的释放
    }
}

@end

@implementation NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats
{
    TimerWeakObject *object = [[TimerWeakObject alloc] init];//创建一个中间对象
    object.target = aTarget;//把这个target指给中间对象
    object.selector = aSelector;//把这个回调指给中间对象
    //调用系统的nstimer方法去创建nstimer，同时把它的回调方法指向中间对象的fire方法，在fire方法当中再对实际对象的fire方法进行回调调用
    object.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:object selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    
    return object.timer;
}

@end            


在日常开发过程当中是否遇到过循环引用，遇到过是怎样解决的？
在日常开发过程中遇到过nstimer这种循环引用，解决nstimer循环引用是创建一个中间对象，
令中间对象持有两个弱引用对象nstimer和原对象，然后在nstimer中直接分派的回调是在中间对象当中创建的，中间对象持有的回调方法当中所持有的target值的
判断，如果说值存在，直接把nstimer回调给原对象，如果当前self.target对象被释放了，则把nstimer设为无效状态，就可以解除线程的runloop对nstimer的
强引用，以及nstimer对中间对象的强引用。

什么是arc?
arc是由llvm编译器和runtime共同协作为我们实现引用计数的管理。

为什么weak指针指向的对象在弃掉时之后会被自动设为nil？
当对象弃用之后，decallo方法的内部实现当中，会调用清除弱引用方法，
在清除弱引用的方法当中会调用hash算法来查找被弃对象在弱引用表中的位置，
来提取它所对应的弱引用指针的列表数组，然后进行for循环遍列把每个weak指针
都置为nil。

苹果是如何实现autoreleasepool的？
autoreleasepool是以栈为节点，由双向链表形式来合成的数据结构。

什么是循环引用？你遇到过哪些循环引用，是怎样解决的？
nstimer的循环引用问题就可以作为这道面试题的答案。




第7章，block相关的面试问题


7-1 Block本质相关面试问题
block介绍：什么是block，你对block的调用是怎样理解的？
截获变量：block的一大特性是截获变量，系统关于block的截获变量特性是怎样实现的？
__block修饰符：使用这个修饰符是用来作什么事情的？
block的内存管理：这方面考察的内容比较多，什么时候需对block进行copy操作，栈block和堆block你是否了解？block的内存管理，因为在使用不当产生循环引用。
            
            
什么是block?
block是将函数及其执行上下文封装起来的对象

下面看一段block的代码段定义：
{
   int multiplier = 6;
   int(^Block)(int) =  ^int(int nume){
        return num*multiplier;
   };
   Block(2);
}
这段代码在编译器编译后会是什么样子呢？
合用【clang -rewrite-objc file.m】查看编译之后的内容

打开xcode

MCBlock.h
#import <Foundation/Foundation.h>

@interface MCBlock : NSObject

- (void)method;

@end


MCBlock.m

#import "MCBlock.h"

@implementation MCBlock
- (void)method
{
    static int multiplier = 6;
    int(^Block)(int) = ^int(int num)
    {
        return num * multiplier;
    };
    Block(2);
}

@end

打开命令窗口： clang -rewrite-objc MCBlock.m
运行完成后会在同级目录中生成MCBlock.cpp文件,这个文件编译后很大

首先会生成下面函数：
//_I_MCBlock_method I表示这个函数是当前类的一个实例方法，MCBlock当前类的类名，在oc文件当中编写的实际方法名称method
static void _I_MCBlock_method(MCBlock * self, SEL _cmd) {//self 和选择器因子两参数
    static int multiplier = 6;
    //__MCBlock__method_block_impl_0是一个结构体传入3个参数，第一个是__MCBlock__method_block_func_0函数指针，第2个__MCBlock__method_block_desc_0_DATA是block描述，第三个是传入的常量
    //__MCBlock__method_block_impl_0结构体强制转换以后赋值给我们的block变量
    int(*Block)(int) = ((int (*)(int))&__MCBlock__method_block_impl_0((void *)__MCBlock__method_block_func_0,
     &__MCBlock__method_block_desc_0_DATA, &multiplier));
}

什么是block呢？查找上面函数中__MCBlock__method_block_impl_0结构体的函义
struct __MCBlock__method_block_impl_0 {
  //结构体1
  struct __block_impl impl;
  //结构体2 关于block的描述
  struct __MCBlock__method_block_desc_0* Desc;
  //block中使用到的局部变量
  int *multiplier;
  //当前结构体构造函数的声名及定义  参数为：函数指针， block描述，使用到的变量，flags标记  multiplier(_multiplier)表示将传入的函数直接赋值给int *multiplier变量
  __MCBlock__method_block_impl_0(void *fp, struct __MCBlock__method_block_desc_0 *desc, int *_multiplier, int flags=0) : multiplier(_multiplier) {
    impl.isa = &_NSConcreteStackBlock;
    //标记位的赋值
    impl.Flags = flags;
    //函数指针的赋值
    impl.FuncPtr = fp;
    //描述的赋值
    Desc = desc;
  }
};

查看  结构体1struct __block_impl impl代表的含义：

struct __block_impl {
  void *isa;//isa指针，是指这个block对象，因为block有isa指针，所以也是objclass，也是对象
  int Flags;
  int Reserved;
  void *FuncPtr;//无类型的函数指针，指向对应函数实现
};

往下再看一个函数：
//命名__MCBlock所以类的名称   所在类的方法method  block代表block  func代表函数
//参数：第一个是 __MCBlock__method_block_impl_0结构体  num是传递进来的参数
static int __MCBlock__method_block_func_0(struct __MCBlock__method_block_impl_0 *__cself, int num) {
  int *multiplier = __cself->multiplier; // 取它的成员变量


        return num * (*multiplier);//被转化成了函数指针
    }
    

什么是block？
block就是一个对象，封装了函数以及函数执行上下文

什么是block调用？
刚源码产生了函数，block调用即是函数调用
看源码：//对block进行强制类型转换，然后取出成员变量funptr，这个是函数指针，对应了当前的函数指针，再把对应参数传进去，block本身，和2，就进行了函数调用。
int (*)(__block_impl *, int))((__block_impl *)Block)->FuncPtr)((__block_impl *)Block, 2);




7-2 Block截获变量相关面试问题
看一段滴滴出行的笔试真题：下面代码打印是2*4还是2*6呢？正确答案是12
- (void)method
{
    int multiplier = 6;
    int(^Block)(int) = ^int(int num)
    {
//        __block
        return num * multiplier;
    };
    multiplier = 4;
    NSLog(@"result is %d", Block(2));
}

@end

block截获变量：
截获变量涉及到被截获变量的类型，不同类型的变量，block截获变量的特点也是不一样的
局部变量：基本数据类型 对象类型 变量的截获是不一样的
block对静态局部变量 全局变量 静态全局变量截获又有什么特性呢？

关于block的截获特性你是否有了解，block的截获变量特性又是怎样的呢？


回答这方面问题应该答到针对不同变量类型block是怎样截获的：
对基本数据类型的局部变量是截获其值。
对于对象类型的局部变量连同所有权修饰符一起截获。
局部变量，局部静态变量的截获是以指针形式截获。
全局变量，全局静态变量是不对其截获的。

打开命令窗口： clang -rewrite-objc -fobjc-arc MCBlock.m 查看编译代码来分析block对不同类型数据是如何截获的。

MCBlock.m
#import "MCBlock.h"

@implementation MCBlock

// 全局变量
int global_var = 4;
// 静态全局变量
static int static_global_var = 5;

- (void)method
{   
   //基本数据类型的局部变量
    int var = 1;
    //对象类型的局部变量
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    //局部静态变量
    static int static_var = 6;
    void(^Block)(void) = ^
    {
       //在block中使用到的变量，block会对变量进行截获
       NSLog(@"局部变量<基本数据类型> var %d",var);//block中就是对值截获，作了赋值操作
       //对象类型局部变量是把修饰符都一并传入到编译后的block代码，所以对象类型的所有权修饰符都是一并截获的
       NSLog(@"局部变量<__unsafe_unretained 对象类型> var %d",unsafe_obj);
       NSLog(@"局部变量<__strong 对象类型> var %d",strong_obj);
       //int *static_var ，是截获了这个局部变量的指针，如果这个block方法体中是静态局部变量，因为它是指针截获，所以当静态局部变量值在block方法执行修改后，block方法体类的静态的值是会有所改变的
       NSLog(@"局部静态变量 %d",static_var);
       //block中未定义如下两个变量，所以不对全局变量截获
       NSLog(@"全局变量 %d",static_var);
       NSLog(@"静态全局变量 %d",static_var);
    };
    Block();
}


局部静态变量：
- (void)method
{
    static int multiplier = 6;
    int(^Block)(int) = ^int(int num)
    {
//        __block
        return num * multiplier;
    };
    multiplier = 4;
    NSLog(@"result is %d", Block(2));//指印结果为8，不是12，因为局部静态变量以指针形式截获
}

@end

如果在block体中对multiplier值进行修改，需要用到 __block修饰符。


7-3 __block修饰符相关面试问题
在什么情况下会用这个修饰符呢？
对被截获变量进行赋值操作需添加__block修饰符

什么是赋值操作，什么是使用操作？

NSMutableArray *array = [NSMutableArray array];
void(^Block)(void) =  ^{
    [array addObject:@123]
};
Block（）;
上面只是一个使用，没有对指针赋值，所以不用__block；
array = [NSMutableArray array];//这种情况需要使用__block因为改变了指针

对变量赋值时__block修饰符的一个特点：

局部变量基本类型和对象类型需要__block。
静态局部变量，静态全局变量，全局变量不需要添加__block修饰符，因为这几个变量不涉及截获操作，

__block int multiplier = 6;
NSMutableArray *array = [NSMutableArray array];
void(^Block)(int) =  ^int(int num){
    return num*nultiplier;
};
multiplier = 4;
Block（2）;
打印结果是8

__block 修饰的变量最后变成了对象，有isa指针，也有一个__forwarding指针，如果是栈上创
建的block，指向其__block变量，如果是堆上创建的block变量，__forwarding指向其它地方，
所以最终截获的是__forwarding指针指向的对象改变的值。

为什么需要__forwarding指针呢？


 
7-4 Block内存管理相关面试问题
在block的编译中能看到有这么一句代码：
impl.isa = &_NSConcreteStackBlock;
isa就是标识block是哪种类型的。

block有三种类型：
_NSConcreteGlobalBlock;全局类型block
_NSConcreteStackBlock;栈类型block
_NSConcreteMallocBlock;堆类型block

内存分布情况：

内核区
栈（stack） 方法和函数都是在在栈上工作的 高地址向低地址向下扩展，方法调用在这个区展开  _NSConcreteStackBlock
堆（heap） block 或对象copy之后放这里，堆是向上增长的  通过alloc等分配的对象  _NSConcreteMallocBlock
未初始化数据(.bss)  未初始化静态变量 全局变量
已初始化数据(.data) 已初始化静态变量 全局变量  _NSConcreteGlobalBlock
代码段(.text) 
保留

不同类型Block的copy操作会产生怎样的效果？
栈上的block  copy后在堆上面  
全局类型的block 在数据区的 copy后什么也不做
堆上面的block  在堆的 copy后引用计数加1

所以在栈上block不能用assgin修饰,因为它在栈上，有可以会成为野指针

栈上block的销毁：
__block变量在栈上，当变量作用域结束之后它以及它所在的block就会销毁，它修饰的会变成对象

如果栈上有一个block，这个block中使用到了__block变量，栈上的block copy操作，会
产生一个在堆上的block，并且这个block中也有__block变量，唯一不同的是这个是在堆上的block
copy后，随着__block变量的作用域结束，栈上的block会销毁，堆上的block和__block仍然存在

在mrc中，栈上block作copy操作，和平常对象一样，如果没有一个指针去指向它，会内存泄漏。

__block变量copy之前，它的__forwarding指向了它自身，
对栈上block中的__block变量copy操作之后，同样在堆上产生一个__block变量，新产生的__block变量的__forwarding指针指向了它本身，旧的栈上的
__block变量的__forwarding指针指向了新的__block变量。

所以当对一个栈上的__block变量，已经copy了的，进行修改，实际上是通过__block变量里的__forwarding
指针找到堆上的__block变量，并修改了堆上__block变量的值。

如果说未对栈上的__block变量进行copy，那修改的就是__block变量的__forwarding指针指向它自身去修改，属指针修改，在block截获的时候
会截获到最后指针对应的值。


例：
__block int multiplier = 10;//变成了一个对象
//_blk是一个对象的block类型的成员变量，这里赋值实际上是一个copy，block会在堆上有另一拷贝
_blk  = ^int(int num){
    return num * multiplier; 
};
multiplier = 6;//这里是对__block中的__forwarding指针指向它的__block multiplier进行赋值，这里是在堆上的，因为上面是一拷贝
[self executeBlock];
-(void)executeBlock{
    int reslut = _blk(4);
    NSLog(@"%d",result);
}
打印结果为24。

__forwarding存在的意义，无论在仍合位置，都能通过__forwarding访问同一个__block变量，如果未对栈上的__block copy
那就是__forwarding指向它栈上的__block变量本身，如果发生copy，无论在栈上，堆上的__block进行赋值，其实都是在copy后的
堆上的__block变量进行赋值。


7-5 Block循环引用相关面试问题&面试总结

//array一般用strong修饰
_array = [NSMutableArray arrayWithObject:@"block"];
//block一般用copy修饰
_strBlk = ^NSString*(NSString* num){
    return [NSString stringWithFromat:@"%@",_array[0]];
}
_strBlk(@"hello");

会产生自循环引用，因为对象对block是强引用，block中用到了array成员变量，
block中截获的对象类型变量会连同strong一块截获，所以会有strong指针指向
block，所以当_strBlk变量生存周期结束后，还用一个strong的_array持有这个block块，不能释放，会产生循环引用

怎么解决：

避免产生循环引用的方式去解决：
//array一般用strong修饰
_array = [NSMutableArray arrayWithObject:@"block"];
__weak NSArray* weakArray = _array;
//block一般用copy修饰
_strBlk = ^NSString*(NSString* num){
    return [NSString stringWithFromat:@"%@"weakArray[0]];
}
_strBlk(@"hello");


为什么__weak会解决这问题呢？
因为block截取的是对象类型的，所以连所有权strong都会截获，

__block引起的循环引用：

__block MCBlock* blockSelf = self;
_blk = ^int(int num){
  return num*blockSelf.var;
}
_blk(3);

答案：
在mrc中是不会产生循环引用，arc下会产生循环引用

在arc下：
_blk强持有了block，block又持有了blockSelf,blockSelf又持用了原来的对象，会产生大环引用

解除方法：
__block MCBlock* blockSelf = self;
_blk = ^int(int num){
  int result = num*blockSelf.var;
  blockSelf = nil;//解除它对self的持有。
  return result;
}
_blk(3)

这个有个避端，如果很久都不调用_blk(3)，就不会执行blockSelf=nil,环就一直存在


block面试题总结：

什么是block？
block是关于函数以及上下文封装起来的对象

为什么block产生循环引用：
如果当前block对当前对象截获会有一个强引用，当前变量又对block块有强引用，需要weak修饰去解决
如果截获的是blockSelf=self，在mrc下不会产生循环引用，在arc下会产生循环引用

怎样理解block截获变量的特性？
对于基本数据类型对其值截获
对象类型是所有权修饰符进行截获
对于局部静态变量是对其指针截获
对于全局变量，全局静态变量不截获

你遇到过哪些循环引用，你又是怎样解决的？
从block，nstimer讲 请看如上





第8章 gdc面试相关问题

8-1 GCD相关面试问题：

多线程几种考察：
在ios系统中为我们提供了哪些多线程技术方案：
gck 使用最多
nsoperation afnetwork所有网络请求都对应封装成nsoperation，图片异步下载也涉及到
nsthread 实现一个长驻线程会用到这个技术
线程同步和资源共享方面问题，多线程和锁

同步是指在当前线程下执行
异步是指在当前线程重新开一个线程下执行

gcd:

同步/异步  串行/并发：
dispatch_sync(serial_queue,^{//任务})／／同步分配任务到串行队列上
dispatch_async(serial_queue,^{//任务})／／异步分配任务到串行队列上
dispatch_sync(cocurrent_queue,^{//任务})／／同步分配任务到并发队列上
dispatch_async(cocurrent_queue,^{//任务})／／异步分配任务到并发队列上

面试题1：
同步串行：
在viewDidLoad中
dispatch_sync(dispatch_get_main_queue(),^{
  [self doSomething];
});
这道面试是会产生死锁。队列引起的循环等待

比如说在主队列中提交了两个任务，一个是viewdidload，一个是block任务，最后
分配到主线程执行。当block中的方法调用完成之后，这个viewdidload方法中的执行才会
向下走，所以先进队列的是viewdidload，viewdidload中又调用了block，所以block又
进入了队列，viewdidload要执行完需要执行完block，block执行完需要等队列中viewdidload执行
完，所以相互等待的死锁。

换成异步提交到主线程也一样，它也是放到主队列中，分配给主线程去处理的，一样会产生死锁
dispatch_async(dispatch_get_main_queue(),^{
  [self doSomething];
});


同步串行另一个问题：

在某个方法调用viewDidLoad方法中
dispatch_sync(seriqlqueue(),^{
  [self doSomething];
});
同步提交一个任务在串行队列中，是不会产生互锁的。
viewdidload放到了主队列，分配到主线程上的， 同步是在当前线程下执行
block是放到串行队列，分配到主线程上的
所以viewdidload方法执行不用去在主队列中等block执行完再执行其它的代码
block方法执行不用等viewdidload执行完再执行block，因为它们排在不同的队列中

如果viewdidload放到同一串行队列中，也会产生死锁循环等街问题


同步并发面试是：

在某个方法调用viewdidload方法中：
nslog(@"1");
dispatch_sync(global_queue(),^{
  nslog(@"2");
    dispatch_sync(global_queue(),^{
      nslog(@"3"); 
     });
     nslog(@"4");
});
nslog(@"5");

打印结果：
1
2
3 并发队列的特点，所有提交的任务，block不用排队执行，可以并发执行
4
5

如果换成串行队列同样产生死锁，2执行完成需要执行到3，3又需要等2执行完成：
在某个方法调用viewdidload方法中：
nslog(@"1");
dispatch_sync(seriqlqueue(),^{
  nslog(@"2");
    dispatch_sync(seriqlqueue(),^{
      nslog(@"3"); 
     });
     nslog(@"4");
});
nslog(@"5");

异步串行面试题：
在viewdidload中，经常会这么用，没问题，因为不是调用viewdidload，也就不存在把viewdidload放到主队列
dispatch_async(dispatch_get_main_queue(),^{
  [self doSomething];
});

异步并发面试题：
-(void)viewdidload{
  dispatch_async(global_queue(),^{
  NSLOG(@"1");
  [self performSelector:@selector(print) withObject:nil afterDelay:0];
  nslog(@"3");
  });
}

-(void )print
{
  nslog(@"2");
}
答案,1,3

异步方式分配到全局并发对列，它是会在gcd所维护的某个线程池上面进行执行处理。gcd维护的线程默认是未开启
runloop的。[self performSelector:@selector(print) withObject:nil afterDelay:0];这个是要提交到runloop
上面的一个逻辑的。所以在gcd所维护的这个线程内是没有runloop的，调用刚那个方法的前提是当前线程是有runloop，所以
这个方法就失效了。并发对列只是个障演法。





其它章节内容：
dispatch_barrier_async 异步炸拦调用 解决多读单写的问题

dispath_group



8-2 dispatch_barrier_async()函数相关面试问题

怎样利用gcd多读单写？
读者与读者是并发的 读者读的时候不能有写数据操作互斥  写与写也是互斥

dispatch_barrier_async(concurrent_queue,^{写操作})


dispatch_barrier_async和dispatch_barrier_sync都会把自己括号体内的任务放入队列中，只有当队列中的
任务执行完为0后才会执行它自己括号体内的代码，区别在于当任务为零时，这时执行dispatch_barrier_async括号内的代码，如果这段代码的执行时间太长，
程序不会等待这段代码执行完成后再继续往下执行其它代码。而dispatch_barrier_sync会等待它括号体内的代码执行完成，再执行其它代码。


代码案例：


代码案例：

UserCenter.h:
#import <Foundation/Foundation.h>

@interface UserCenter : NSObject

@end

 
 
UserCenter.m
 
 
#import "UserCenter.h"

@interface UserCenter()
{
    //定义一个并发队列
    dispatch_queue_t concurrent_queue;
    //用户数据中心，可能多个线程需要数据访问，这个存的是数据，可充许多个线程同时访问这个字典
    NSMutableDictionary  *userCenterDic;
}

@end

@implementation UserCenter

- (id)init
{
    self = [super init];
    if (self) {
        // 创建并发队列
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        userCenterDic = [NSMutableDictionary dictionary];
    }

    return self;
}

- (id)objectFbrKey:(NSString*)key
{
    __block id obj;
        // 同步读取指定数据,多个读可并发执行，并同步立刻返回结果。满足同时并发返回调用结果
        dispatch_sync( concurrent_queue, ^{
            obj = [userCenterDic objectForKey:key];
        });
    
    return obj;
}
//当队列中的读操作完成，这会队列中任务为0时，才会执行dispatch_barrier_async中的代码，实现了多读单写的效果
-(void)setObject:(id)obj forKey:(NSString *)key
{
    //异步栅栏调用设置数据，在一个并发队列去写数据，
    dispatch_barrier_async( concurrent_queue, ^{
            [userCenterDic setObject:obj forKey:key];
        });
}


@end






8-3 dispatch_group_async()函数相关面试问题
使用gcd实现a,b,c三个任务并发执行，当这三个任务完成之后再执行d任务。

GroupObject.h
#import <Foundation/Foundation.h>

@interface GroupObject : NSObject

@end


GroupObject.m

#import "GroupObject.h"

@interface GroupObject()
{   //并发队列  这道面试题场景会并发下载数据，数据下载任务都完成了再拼成一幅图片
    dispatch_queue_t concurrent_queue;
    NSMutableArray <NSURL *> *arrayURLs;
}

@end

@implementation GroupObject

- (id)init
{
    self = [super init];
    if (self) {
        // 创建并发队列
        concurrent_queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
        arrayURLs = [NSMutableArray array];
    }

    return self;
}

- (void)handle
{
    // 创建一个group
    dispatch_group_t group = dispatch_group_create();
    
    // for循环遍历各个元素执行操作
    for (NSURL *url in arrayURLs) {
        
        // 异步组分派到并发队列当中，图片下载逻辑分配到这里，dispatch_group_async与dispatch_group_t配对使用，这些任任都在一个组内
        dispatch_group_async(group, concurrent_queue, ^{
            
            //根据url去下载图片
            
            NSLog(@"url is %@", url);
        });
    }
    //所以并发任务执行完成才会执行这个，这时回到主队列去执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 当添加到组中的所有任务执行完成之后会调用该Block
        NSLog(@"所有图片已全部下载完成");
    });
}




@end




8-4 NSOperation相关面试问题

实现多线程的方案需要结合NSOperationQueue配合实现多线程方案。

 NSOperationQueue实现多线程方案它有哪些优势和特点呢？
 答：主要有三方面：
 添加任务依赖移除依赖，这是gcd,nsthread所不具备的，gcd要实现我这里思考可以用dispatch_group_t 
 任务状态的控制，提供了执行状态的控制
 可以控制它的最大并发量，设为1就是串行
 
 
 有哪些任务状态控制？
 isReady 当前任务是否处于就绪状态，及准备状态
 isExecuting 当前任务是否处于进行中的状态
 isFinished 当前任务是否处于完成状态
 isCancelled 当前任务是否已经取消
 
 状态控制：
 主要看是否重写了start方法或者main方法
 
 如果只重写main方法，底层实现控制变更任务执行完成状态，以及任务退出，不需要我们自己控制状态，系统代我们处理状态
 如果重写了start方法，自行控制任务状态，会在不同的情况下自己去写isFinished等状态
 
 源
 码分析基于gnustep-base-1.24.9
 
 有一个start方法，创建一个自动释放池，以及线程的优先级获取，作一系列异常判断，
 如果前面异常判断通过了，会去判断当前是否处于执行中，如果没处理执行中，设置它的
 状态，判断当前任务如果未被取消就调用main方法，最后调用finsh方法
 finsh方法中kvo调用finsh的标志位，这里看出如果只重写main方法，系统会自动调用状态变列，
 如果重写了start方法，系统默认实现都被我们覆写掉了。
 
 系统是怎样移除一个isFinished=YES的NSOperation的？
 通过kvo的方式来移除operationqueue中所对应的operation的。来达到正常退出消毁operation这个对象。
 
 
 
 
 
 8-5 NSThread相关面试问题
  NSThread方面的面试问题一般和runloop结合考察，这里主要讲 NSThread的启动流程：
  创建一个 NSThread后会调用start()启动线程，start方法内部会创建pthread线程，指定pthread的启动函数
  在启动函数中调用 NSThread所定义的main(),main中会通过[target performSelector:selector]来调用
   NSThread中指定的方法，这后调用exit()函数关闭线程。
   
往往 NSThread的考察都是结合常驻线程来考察的：
在对应的一个 NSThread入口函数中添加一个runloop或事件循环，往往这个事件循环就是添加到 NSThread所指定的调用方法当中，
在这个方法中维护一个runloop来达到常驻线程的目的

 NSThread的start方法源码分析：
 functon中的源码是没公共的，但可以通过下面的源码去分析，因为大体实现是一样的
 基于gnustep-base-1.24.9进行源码解析
 在start方法中：
 先判断是否有异常
 调用pthread_create(&thr,&attr,nsthreadLuncher,self)创建一个线程，然后调用nsthreadLuncher启动函数
 nsthreadLuncher启动函数中获取线程t，发送一个通知告诉观察者已经启动了，设置线程名称，再调用main函数，再exit退出线程
 在main函数中什么都不作，要保证常驻线程，就需在main函数中开启一个runloop，实现常驻，main函数中只调用了[target performSelector:selector]
 [target performSelector:selector]又调用了NSThread中指定的方法，target和selector是怎样和NSThread绑定的，因为
 NSThread中的类方法+(void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget 会传入target和selector参数，所以绑定在一起。
 initWithTarget方法同样会传入target和selector参数，所以绑定在一起。
 
 
 8-6 多线程与锁相关面试问题&面试总结
 多线程和锁相关的问题
 
 ios中都有哪些锁呢？开发中使用过哪引起锁，怎样使用的？
 ios中的锁：
 @synchronized
 atomic
 OSSpinLock
 NSRecursiveLock
 NSLock
 dispatch_semaphore_t
 
 
 @synchronized 一般创建单例对象的时候使用，保证多线程情况下创建对象是唯一的
atomic 是属性关键字，对被修饰对象进行原子操作，不负责使用
如：@property(atomic)NSMutableArray *array;
self.array = [NSMutableArray array];//可以保证线程安全性
[self.array addObject:obj];//不保证线程安全性

 OSSpinLock自旋锁 经常考察，会循环等待访问，不释放当前资源，while循环一直看是否获取到这锁，直到获取到这个锁才
 会停止循环，但不释放资源。和普通锁不一样，普通锁逻辑是否个线程获取到这把锁，其它线程就不能获取到，没有循环获取这样的概念。
 应用场景是一些轻量级的数据访问，简单的加1,减1操作，内存管理和runtime相关的面试题有提到。对引用计数加减操作
 
 NSLock 一般解决一些细粒度的线程同步问题，来保证各个线程互斥进入自己的零介区
 -(void)methodA
 {
  [NSLock lock];
  [self methodB];
  [NSLock unlock];
 
 }
 
  -(void)methodB
 {
  [NSLock lock];
  .....//逻辑操作代码。。。
  [NSLock unlock];
 
 }
 
 会导致死锁
 方法a，加锁的时候，[NSLock lock];某个线程加锁获取到锁
 方法b，再次调用[NSLock lock];再次获取锁，重获取会导制死锁，因为方法b要获取到获，必须方法a执行完释放所，但方法
 a的执行完成又需要方法b先执行完成，解决这种问题需要用到递归锁
 
 
  NSRecursiveLock
  递归锁是可以重入的，可以解决这个问题，递归锁可以获取自身多次
  
  -(void)methodA
 {
  [NSRecursiveLock lock];
  [self methodB];
  [NSRecursiveLock unlock];
 
 }
 
  -(void)methodB
 {
  [NSRecursiveLock lock];
  .....//逻辑操作代码。。。
  [NSRecursiveLock unlock];
 
 }
 
 
  dispatch_semaphore_t信号量机制
  
//创建信号量，参数：信号量的初值，如果小于0则会返回NULL
dispatch_semaphore_create（信号量值）
 
//等待降低信号量
dispatch_semaphore_wait（信号量，等待时间）等待哪个信号量
 
//提高信号量
dispatch_semaphore_signal(信号量)

dispatch_semaphore_create内部实现
实例化了结构体
struct semphore{
  int value;//信号量值
  List<thread>;//关于线程进程控制表，一个线程死表
}


 dispatch_semaphore_wait内部实现
 信号量值减1，来获取信号量
 如果信号量值小于等于0,那这个信号的所在的线程就是会阻塞行为把自己阻塞行为，是一个主动行为
 
 //提高信号量
dispatch_semaphore_signal(信号量)
信号量值加1
如果信号量值小于等于0，意味着释放信号之前有队列的任务在排队，因为在进行wait 操作的时候如果说之前的
线程没有办法获取到信号量，会主动把自己挂到这个队列列表上，作信号量加1后value值仍然小于等于0,表示列表当中相应
的线程需要唤醒，就可实现线程同步，唤醒是一个被动行为，同释放信号的线程来唤醒一个被阻碍的线程

正常的使用顺序是先降低然后再提高，这两个函数通常成对使用。


线程安全：如果你的代码所在的进程中有多个线程在同时运行，而这些线程可能会同时运行这段代码。如果每次运行结果和单线程运行的结果是一样的，而且其他的变量的值也和预期的是一样的，就是线程安全的。
若每个线程中对全局变量、静态变量只有读操作，而无写操作，一般来说，这个全局变量是线程安全的；若有多个线程同时执行写操作（更改变量），一般都需要考虑线程同步，否则的话就可能影响线程安全。
线程同步：可理解为线程 A 和 线程 B 一块配合，A 执行到一定程度时要依靠线程 B 的某个结果，于是停下来，示意 B 运行；B 依言执行，再将结果给 A；A 再继续操作。
举个简单例子就是：两个人在一起聊天。两个人不能同时说话，避免听不清(操作冲突)。等一个人说完(一个线程结束操作)，另一个再说(另一个线程再开始操作)。
下面，我们模拟火车票售卖的方式，实现 NSThread 线程安全和解决线程同步问题。
场景：总共有50张火车票，有两个售卖火车票的窗口，一个是北京火车票售卖窗口，另一个是上海火车票售卖窗口。两个窗口同时售卖火车票，卖完为止。


总结：
gcd实现多读单写？
ios为我们提供了几种线程技术，它们的特点是怎么样的？
gcd nsoperation nsthread
gcd实现一些简单的线程同步，子线程的分派，包括实现一些多读单写的场景
nfnetwork 图片下载 用nsoperation，因为可以对状态控制，添加依赖，移除依赖，以及并发量控制
nsthread常驻线程的实现
nsoperation对象在finished之后是怎样从queue当中移除的？
你用过哪些锁，结合实际弹弹是怎么使用的？





第9章   runloop 相关面试问题

9-1 RunLoop本质相关面试问题
什么是runloop,runloop的实现机制？这涉及到一个runloop的概念问题
以及runloop的数据结构
runloop的效果是有事作的时候作事没事作的时候休息。这是runloop的事件循环机制有关
runloop与nstimer之间的关系，nstimer有什么特殊的地方需要注意
以及runloop与多线程的关系，如何实现常驻线程

什么是runloop？
runloop是通过内部维护的事件循环，来对事件/消息管理的一个对象
维护的事件循环是怎样的？

事件循环是什么呢？
没有消息处理时，休眠以避免资源占用：
没有消息处理时，进程或线程休眠，当前线程从用户态把控制权转移到内核态进行休眠

有消息需要处理，立刻唤醒：
由内核态到用户态的状态切换

用户态和内核态理解
我们的应用程序，aip，用户进程都是运行在用户态的，当进行系统调用，需要使用一些操作系统以及底层内核相关的指令,api会触发系统调用，有些系统调用
会发生一个状态空间的切换，这种切换空间之所以区分用户态，内核态，是对计算机资源调度管理一个统一性的操作，可以合理安排资源调度，避免一些
特殊异常，比如内核态有些陷井指令，关机开机操作。因为每一个app如果都可以引发手机关机，那这是无法想像的，所以有一个用户态到内核态的区分
内核态中的有些内容可以对用户态的线程进行一些调度管理，包括通信

什么是事件循环，事件循环的机制是怎么样的？
维护的事件循环可以处理消息和事件，对它们进行管理，同时当没消息处理时，会发生一个从用户态到内核态的切换
当前线程会休眠，避免资源占用
有消息需要处理时，会从内核态到用户态的切换，当前线程会被唤醒
状态的切换才是回答runloop的关键点


在程序运行中一般：
int main()是程序的入口，main函数顺着代码依次执行，然后退出。
main函数为什么会不保持不退出？
在main函数中会调用uiapplicaion函数，在这个函数内部会启动一个runloop
这个runloop会不断执着收事件消息，比如点击屏幕，滑动列表，网络请求返回
接收消息之后对事件进行处理，处理完后再会进等待，这个循环不是一个单纯的
循环，而是从用户态到内核态的相互切换，这里的等待并不等于死循环。

总结上题答案：
main函数调用application函数，会启动一个主线程的runloop，runloop又是对
事件循环的一种维护机制，可以作到在有事作的时候可以作事，没有事作的时候会通过用户态到
内核态的切唤，从而导致避免资源占用，当前线程作为一个休眠的状态。

runloop是怎样维护事件循环机制的呢，请看下一章，runloop的数据结构：




9-2 RunLoop数据结构相关面试问题

只有对runloop的数据结构有更好的理解，才能讲解runloop的事件机制以及面试问题。
在oc当中提供了两个runloop，一个是nsrunloop,cfrunloop，nsruloop对cfrunloop
进行封装，提供了一些面向对象的api,nsrunloop是位于fundation框架当中，
cfrunloop是位于corefunction当中
苹果对cfrunloop源码是开源的

三个数据结构：
cfrunloop cfrunloopmode  source/timer/observer


cfrunloop包含以下几个：
pthread c语言的线程对象
currentmode runloop当前所处的一个模式
modes runloop多个mode的一个集合，一对多的关系
commonmodes 
commonmodeitems

一一解释：

pthread c语言的线程对象:
代表线程，runloop和线程是一一对应的关系

currentmode runloop当前所处的一个模式：
是一个cfrunloopmode的数据结构，一会可以对其进行讲解

modes runloop多个mode的一个集合，一对多的关系：
是一个集合 nsmutableset<cfrunllopmode*>


commonmodes :
是一个集合 nsmutableset<nsstring*>,代表common模式的集合，为什么是字符串？


commonmodeitems:
是一个集合，集合中包含多个元素，包含多个 observer观察者（可为runloop添加观察者） 多个timer 多个source（可以提交到对应的某个runloop对应的某个runloopmode上面）




cfrunloopmode数据结构包含：

name:
字符串类型 对应的是某一个runloop它的nsdefaultrunloopmode默认mode的名称，可以通过name找到对应的mode，所以commonmodes 中
存储的是不同模式的名称，这个设计思想是怎么样的？

sources0：
和runloop包含的commonmodeitems存储的元素是不一样的，是代个s的。，是集合类型的数据结构 ， 无序

sources1：
和runloop包含的commonmodeitems存储的元素是不一样的，是代个s的。，是集合类型的数据结构 ，无序

observers:
是一个mutablearray数组，是有序的，集合是无序的

timers:
 是一个mutablearray数组，是有序的，集合是无序的
 
 
 
 
 cfrunloopsource数据据结构包含：
 
 
 source0：
 这里和上面的sources0集合存的数据类型是一样的，需要手动唤醒线程，把当前线程从内核态切换到用户态
 
 source1:
 具备唤醒线程的能力，不需要手动唤醒
 
 cfrunlooptimer：
 基于事件的定时器，它和我们使用的nstimer是具备免费桥转换的，toll-free bridged
 
 cfrunloopobserver:
 可以注册一些observer对runloop进行一些相关时间点的监测，观察
 
 可以监测runloop哪些时间点呢？
 
 主要有以下6个：
 kcfrunloopentry：
  入口时机，当runloop准备启动的时候系统会给一个回调通知，这个通知叫 kcfrunloopentry
  
 kcfrunloopbeforetimers：
  通知观察者runloop将要对timer一些相关事件进行处理了
  
  kcfrunloopbeforesources:
  通知观察者runloop将要处理一些source事件
  
  kcfrunloopbeforewaition:
  通知观察者当前runloop将要进入休眠状态，比较重要，当收到这个通知时，即将要发生用户态到内核态的切换
  
  kcfrunloopafterwaiting:
  从内核态切换到用户态不久的时间系统会发出这个通知
  
  kcfrunloopexit:
  代表runloop退出的通知
  
  
  
  各个数据结构之间的关系：
  
  线程和runloop是一一对应的。
  runloop和runloop的mode是一对多的关系，因为runloop有一个modes的成员
  mode与source,timer,observer也是一对多的关系
  
  引出面试问题：
  runloop和mode，以及mode和source,timer,observer是怎样一个关系呢？
  可以从一对多，一对一的角度回答这个问题
  
  
  runloop的mode：
  这个也是面试经常问题，runloop为什么会有多个mode
  
  一个runloop对应多个mode，每个mode又对应多个sources1,observers,timers,
  当一个runloop运行在某一个mode上的时候，如mode1上面，这时候model2的比如timers事件
  回调了，发出通知了这个时候我们是没办法知道model2回调的timer，source事件的。
  runloop有多个mode的原因实际上起到的就是一个屏闭的效果。当运行在mode1上的时候只能接收处理
  mode1上的source,timer,observer，如果此时有其它model的事件处理时，runloop是不会处理的
  这个就是有多个mode的原因。
  
  我个在滑动tableview的时候如果里面有滚动广告栏，这个广告栏不会自动滚动了，为什么？
  
  一个timer如果要加入到两个model里面我们需要怎么作呢？
  timer即想在model1上运行，在时间回调函数作相应处理，在model2上也需要作处理和相应事件的回
  调接收，我们怎样添加到两个model中，系统为了满足开发中需要的这种场景，提供了方法可以把同一个
  timer或source或observer添加到多个mode上，实现多个mode上都可以事件处理。保证当runloop发生
  model切换的时候也可以保证timer/source/observer能得到处理，这里会用到commonmode的特性。
  
 
 
  commonmode的特性：
  nsrunloopcommonmodes:
  commonmode并不是一个实际存在的模式，在oc当中通常会通过nsrunloopcommonmodes这样的字符串常量来
  表达commonmode，commonmode本身和defaultmode是有区分的，实际上我们调用一个线程运行在commonmode上面
  和运行在defaultmode上面是有区别的。
  是同步source/timer/observer到多个mode中的一种技术方案
  
  
  
  
  9-3 RunLoop事件循环机制相关面试问题
  
  在开发过程中调用的nsrunloop的run方法最终会调用下面这个方法：
  void cfrunlooprun()  
  什么是runloop,runloop事件循环机制是怎样的
  
  我们的一个程序从点击一个图标到程序启动到系统杀死，我们的系统是怎样实现的？
  这个问题是你对于一个runloop的理解。
  要给出一个区分初级和中级的答案
  
  runloop整个事件循环机制：
  
  当runloop启动的时候会发送一个通知给observer告诉观察者runloop即将启动
  将要处理timer/source0事件（手动唤醒线程）
  正事处理source0事件
  如果有source1事件（自动唤醒线程）要处理，会跳过休眠。可通过goto语句来进行代码跳转处理source1自动唤醒时收到的消息
  如果没有source1要处理，线程会休眠，同时发送通知给observer,告诉observer要休眠
  正事休眠，等待唤醒，正式发生从用户态到内核态的切换
  等待唤醒的条件有三个：source1唤醒 timer事件的回调到了  外部手动唤醒
  线程被唤醒也发一个通知给observer通知已经唤醒
  处理唤醒后接收到的消息，再回到将要处理timer/source0事件（手动唤醒线程）的步骤
  
  
  引出的面试题：
  当一个处于休眠状态的runloop我们可以通过哪些方式唤醒它呢？
  source1唤醒 timer事件的回调到了  外部手动唤醒
  
  
  我们的一个程序从点击一个图标到程序启动，运行，到系统杀死，我们的系统是怎样实现的？
  调用main函数之后会调用uiapplication的main函数，在函数内部启动主线程的runloop，经过
  一系列的处理，主线程的runloop处于休眠状态，如果此时点击一个屏幕，会转程一个source1(自动唤醒)
  把主线程唤醒，运行处理收到的点击事件，之后把程序杀死会发生runloop的退出，也会发送一个通知给observer
  再销毁掉线程，这个是关于runloop的整体的事件循环机制。
  
  
  
  runloop的核心，可以从用户态到内核态来讲述
  
  main()函数
{
   mach_mag()
}
经过一系列处理之后，会调用一个系统函数 mach_mag()，发生了系统调用，当前用户线程就把控制权转交给内核态，
mach_mag()在一定条件下会返回给调用方，返回的逻辑就是唤醒线程的逻辑，比如说收到一个source1,timer事件
回调，包括外部手动唤醒，触发从内核态到用户态的切唤，当前app的主运行循环会被唤醒，这是runloop的核心。
  
  
  
 9-4 RunLoop与NSTimer相关面试问题
 
 
 滑动tableview的时候定时器还生效吗？
 
 当前的线程正常是运行在kcfrunloopdefaultmode模式下的
 对tableview滑动会发生切换，会切到uitrackingrunloopmode上
 把一个timer/source/observer添加到某一个model上的时候，如果当前
 runloop是运行在另一个model上面，对应的timer/source/observer是没有办法处理
 和回调的，这种隔离产生了这种问题，怎么解决？怎么生效？
 
 可以void cfrunloopaddtimer(runloop,timer,commonmode)
 这个函数把当前的timer添加到commonmode中，commonmode不是一个实际的mode，
 只是把一些mode打上一些标记，我们可以把某一个事件源，如timer同步到多个mode当中，
 在xcode中看源码：
 
 void cfrunloopaddtimer(runloop,timer,commonmode)
 中有判断
 如果说当前是commonmode，会提取commonmodes，这里面是一些字符串元素
 同是判断这个runloop对应的commonmode是否为空，如果为空会创建一个commonmodeitems集合
 把timer加到了commonmodeitems这样的数组集合中，把runloop和timer封装成context，对这个
 集合中的每一个元素都调用cfrunloopadditemtocommonmodes这个函数
 这个函数两个参数，集合当中对象的元素，另一个是contexts，
 这个cfrunloopadditemtocommonmodes实现：
 首先会取当前mode的名称，再把对应的runloop和commonmodeitem取出来
 根据item当前的类型判断来决定调用是cfrunloopaddsource还是cfrunloopaddobserver或/cfrunloopaddtimer
 这里没产生循环调用，因为这会传入的commonmode是被打上标记的具体的一个实际的model
 
 cfrunloopaddtimer如果传的是一个具体的model，就会实现把多个model中都添加一个事件源
 把一个timer添加到多个model后，实际上uitrackingrunloopmode也是打上标际的，这时候timer也能在这个
 model下运行，滑动的时候timer也能正常回调的。
 
 
 
 
 9-5 RunLoop与多线程相关面试问题&面试总结
 
 runloop与多线程之间的关系：
 线程与runloop是一一对应的
 自己创建的线程是没有runloop的，我们需要手动创建
 
 怎样实现一个常驻线程：
 1。为当前线程开启一个runloop
 2。向该runloop中添加一个port/source等维持runloop的事件循环。
 3。启动该runloop
 
 为当前线程开启一个runloop：
 [NSRunLoop currentRunLoop];//获取当前线程的RunLoop
+(NSRunLoop　*)mainRunLoop;//获取主线程的NSRunLoop

向该runloop中添加一个port/source等维持runloop的事件循环：
如果runloop线程没有资源事件源需要处理，默认情况下不能维持事件循环就会退出，所以需要添加一个port/source来维持事件循环

 启动该runloop：
 调用runloop的run方法启动runloop，实现一个常驻线程
 
 
 代码案例：
 
 MCObject.h
 
#import <Foundation/Foundation.h>

@interface MCObject : NSObject

@end


MCObject.m

#import "MCObject.h"

@implementation MCObject

static NSThread *thread = nil; //自定义的线程
// 标记当前线程是否要继续它的事件循环
static BOOL runAlways = YES;

+ (NSThread *)threadForDispatch{
    if (thread == nil) {
        @synchronized(self) {//线程安全的方式去创建
            if (thread == nil) {
                // 线程的创建
                thread = [[NSThread alloc] initWithTarget:self selector:@selector(runRequest) object:nil];
                [thread setName:@"com.imooc.thread"];//线程名称
                //启动线程
                [thread start];
            }
        }
    }
    return thread;
}

+ (void)runRequest
{
    // 创建一个Source
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};//上下文，作为创建source的一个参数
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    // 创建RunLoop，同时向RunLoop的DefaultMode下面添加Source  CFRunLoopGetCurrent()为当前线程创建一个runloop，没有runloop会创建一个runloop，并把事件源添加到这个runloop的defaultmode中
    // 主线程中系统已经为我们创建好了这个事件循环
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    // 通过while循环来维持一个runloop的事件循环
    while (runAlways) {
        @autoreleasepool {//达到每次运行完会对内存释放
            // 令当前RunLoop运行在DefaultMode这种模式下面，添加资源的model和这里抽mode必须是一个，这里不会死循环，这个函数会让用户状态到内核状态，线程会休眠，会停在这里面
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);//runloop运行到 1.0e10,会退出，1.0e10很大，不会退出的
        }
    }
    
    // 如果runAlways==no，才会执行这里，某一时机 静态变量runAlways = NO时 可以保证跳出RunLoop，线程退出，
   // 因为runloop对应的mode这时移除事件源，没有对应的事件源处理，runloop会退出，线程处理结束后也会自动退出   
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
  //释放掉，防内存泄漏
    CFRelease(source);
}

@end


总结：
1。什么是runloop，它是怎么做到有事做事，没事休息的？
实际上是两个问题.runloop实际上是一个事件循环，用以处理事件和消息，便于我们管理
它是怎么做到有事做事，没事休息的：在调用cfrunloop的run相关方法后，会调用系统的一个函数matchmessage，
同时发生了用户态向核心态的切换，当前线程处于休眠，作到了有事作事，没事休息

2.runloop与线程是怎样的关系？
runloop和线程是一一对应关系，线程是没有runloop的，我们需要为它手动创建。

3.如何实现一个常驻线程？
创建一个线程，在线程回调方法中创建它对应的一个runloop，可以在这个runloop对应的mode中添加一个事件源，如source，
timer/observer/port等source，在调用cfrunloop的run方法，让这个runloop运行在对应的mode下。运行的这个mode和你
添加source到一个mode，这两个是同一个mode，这样才能实现runloop运行在某个mode下的，如果该mode有事件源会继续运行‘
如果没有事件源了，则会runloop退出。

4.怎样保证子线程数据回来更新ui的时候不打断用户的滑动操作？
用户的滑动一般在uitrackingmode下面，一般对网络的请求是放在子线程中进行的
子线程返回的数据给主线程以及更新ui这块逻辑可以把它封装成一个方法，把它提交到defaultmode下，
这样回来的任务，当滑动的时候就能保证界面数据没有更新，当滑动停止切到defaultmode下，才会更新
数据到ui界面上
添加事件源到mode中的方法如：
 NSRunLoop *runLoop = [NSRunLoop currentRunLoop]; 
 runLoop addPort: addtimer
 
 系统默认注册了5个Mode：

NSDefaultRunLoopMode：App 的默认 Mode，通常主线程是在这个 Mode 下运行(默认情况下运行)
UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响(操作 UI 界面的情况下运行)
UIInitializationRunLoopMode：在刚启动 App 时进入的第一个 Mode，启动完成后就不再使用
GSEventReceiveRunLoopMode：接受系统事件的内部 Mode，通常用不到(绘图服务)
NSRunLoopCommonModes：这是一个占位用的 Mode，不是一种真正的 Mode (只是对添加的model作了一个标记，通过这个标记把对应的runloop和commonmodeitem取出来，
commonmodeitem中再添加当前的事件源到这个mode中，实现一个事件源可以在多个model中运行)



第十章

10-1 HTTP了协议相关面试问题-1

网络相关问题：
http协议
https与网络安全
tcp/udp
dns解析
session/cookie


http协议：
超文本传输协议
  请求／响应报文
  连接建立流程
  http的特点
  
  请求报文：
  post,get，状态码
  
  请求报文格式：
  请求行包括：
     方法字段：get post
     url:请求地址
     协议版本:请求的版本往往是1.1
     crlf：回车换行
  头部字段（都是以key value组合在一起的）：
     首部字段名称：值   回车换行
     首部字段名称：值   回车换行
     回车换行
  实体主体：
     get请求不带实体主体
     post请求带有实体主体
     
  
  响应报文：
    响应行：
       版本
       状态码
       短语：状态码描述
       回车换行
    首部字段区：
       首部字段名称：值   回车换行
       首部字段名称：值   回车换行
       回车换行
    响应实体主体：
    
    什么是http?
    http是超文本传输协议，然后请求报文和响应报文的组成结构
    
    http请求方式有哪些？
    get 
    pos
    head 
    put
    delete
    options
    
    get和post方式区别？
    get请求参数是以?分隔，拼接到url后面
    post请求参数在body里面
    get参数长度限制20482个字符，post一般没有该限制
    get请求不安全
    post请求不安全？
    以上不一定满意
    
    标准答案从语义的解度回答此问题
    http的rfc协议中对些有描述
    
    get：获取资源  
        它是安全：多次获取资源，不会引起server端相关数据变化，get head options都是安全的
        幂等： 同一个请求方法执行一次和执行多次效果完全相同 如put delete  ，put获取server执行的效果是一样的  
        可缓存的： 请求是可以被缓存的，它传递的网络路径不确定，对于一些代理服务器它有缓存的，是官方定义的一种规范，多资执行可以得到的是缓存结果
    post：处理资源的 
        它是非安全 
        非幂等 
        不可缓存的
        
    你都了解哪些状态码？它们含义是什么？
    1，2，3，4，5开头的
    200 响应成功
    301 302 发生了网络的重定向
    401 404 客户端发起的请求本身存在某些问题
    501 502 代表server本身有异常的
    
    连接建立流程：
      tcp三次握手 四次挥手
      
      客户端：
          客户端与server端的三次交互：
            发送一个syn的同步报文到server端
            server端收到syn同步报文及连接请求报文之后会返回synack（同步ack的tcp报文）
            客户端再回复服务端一个ack的确认报文
          连接成功后：在tcp的通道上面进行http请求，响应，数据传递，http发一个请求报文，server端回一个响应报文，当完成这个请求之后，需4次挥手
          
          四次挥手 有四次交互：
            客户端发起一个fin终止报文到server端
            server收到报文后回给客户端ack确认报文  此时客户端到server端的连接断开，但是server端到客户端可能还传递数据
            某一时机再由server端向客户端发一个终止报文finack 来断开客户端到server端的连接
            由客户端再回给server端一个ack确认报文释放tcp连接
            
    为什么是三次握手不是两次？
    四次挥手为什么要进行两方面的断开呢？
    
    
    
    10-2 HTTP协议相关面试问题-2
    
    http的特点有哪些？
    无连接： http有建立连接释放连接的过程
    解次无连接的特点： http持久连接方案来补偿无连接
    
    http的持久连接是怎样理解的呢？
    
    无状态： 在多次发送http请求的时候，如果是同一个用户，server端不知道是同一个用户的
    基于这种无状态特点： server端补偿无状态特点需要  cookie，session
    
    持久连接：
    打开一个tcp通道，在一定时间内，我们的http请求在同一个tcp链路上进行请求响应传递补
    经因一定时间再关闭通道
    
    
    非持久连接：
    客户端打开一个tcp连接，网络数据连输，再关闭这条链接
    发送每二个请求时，同样打开一个tcp连接，网络数据连输，再关闭这条链接
    
    
    为什么http提供了持久连接方案？
    提高网络请求效率，一定时间内请求多个网络访问只需一次建立三次握手四次挥手资源
    
    持久连接的关部字段有哪些？
    connection: keep-alive 采用持久连接
    time:20  tcp连接在20秒之内是不会关闭的
    max:10   这条连接最多可发生多少个http请求响应对
    
    怎样判断一个请求是否结束？
    请求报文或者响应报文都有头部字段如下
    content-length:1024   发送一个请求server会给我们协带一个响应数据的字段大小
    客户端接收到的数据是否有到达content-length这个值，如果到达了就说明这个http响应接收完毕，请求结束
    
    chunked:当我们用post请求的时候，sever端返回给客户端的数据是需要通过多次响应返回给客户端数据的，
    可以根据http响应报文中的一个头部报文chunked，每一个返回的数据报文都会带有chunked字段，而最后一个块
    chunked是空的，如果哪个chunked是空的，就可判断前一个请求结束
    
    charles抓包原理是怎样的？
    关于http协议涉及到
    可以说利用了这种ht中间人攻击tp中间人攻击漏洞来实现的
    
    中间人攻击：
    客户端是与server端是直连的，请求响应在这通道上
    中间人相当于一个代理服务器，当发送请求的时候，由中间人假冒客户端身份向server端进行请求，并返回数据给中间人，再由中间人
    返回给客户端，中间人是可以改我们发起的请求参数，然后返回的数据中间人也可改了返给客户端。
    
    
    
    
    10-3 HTTPS协议与网络安全相关面试问题
    
    https和http有怎样的区别？
    https = http + ssl/tls 共同组成
    多了一个安全相关的模块ssl/tls
    
    http（应用层）  ssl/tls（应用层之下传输层之上的中间层）
    tcp(传输层)
    ip(网络层)
    协议栈    
    
    https就是在http原有的应用层之下，传输层之上插入了一个ssl/tls这个协议中间层为我们实现网络安全机制
    
    https是安全的http
    
    
    
    https连接建立流程是怎样的？
    
    考察安全怎么保障
    
    客户端向server发送报文，客户端支持的tls协议版本， 支持的加密算法， 一个随机数c
    server端返回一个握手报文消息包含后面内容：商定的加密算法（我选择哪个客户端支持的算法），随机数s，server证书(证书中包含了网站的地址，加密用的公钥，以及证书的颁发机构等) 而私钥则服务器保存
    客户端收到内容后 验证server证书，及对证书的一个公钥进行验证，判断当前server是否是一个合法的server(证书是用来标示一个站点是否合法的标志。如果说该证书由权威的第三方颁发和签名的，则说明证书合法)
    如果证书合法，或者客户端接受和信任了不合法的证书,客户端组装会话秘钥(一串序列号)，通过随机数c，s包括客户端产生的一个预主密钥(估计是服务器返回的公钥证书)来进行会话密钥组装
    客户端再发送一个报文到server端，通过server端的公钥对预主密钥进行加密传输
    server端通过私钥解密得到预主密钥
    server端通过随机数c,s,包括通过私钥解密得到预主密钥组装会话密钥
    从客户端发送一个加密的握手消息
    server返回给客户端加密的握手消息，来验证我们的安全通道是否建立完成
    
    会话秘钥：
       等于 随机数s + 随机数c +预主秘钥  通过算法 合成
    会话秘钥代表对称加密中的密钥结果
    
    https都使用了哪些加密手段，采用不同加密手段的原因是为什么？
    
    除了对称加密还有非对称加密，非对称加密很耗时，因为加密解密采用的手段不一样，如在连接中可保证建立连接的安全，
    但在后期数据传输中来采用对称来提高效率
    加密如刚提到有公钥又有私钥。是非对称加密
    https使用了对称加密和非对称加密
    
    非对称加密：
    发送方发送一个hello，通过一个公钥对hello加密操作，是非对称加密中一个重要概念
    把加密后的hello发给接收方
    接收方通过私钥对加密数据进行解密，拿到最后的hello
    如果加密有公钥，解密就用私钥，如果加密用私钥，解密就用公钥，加密和解密使用的钥是不一样的
    优点，只有公钥是在网络中传递的，私钥永远保留在server端，不涉及网络传递，安全性好很多。
    
    对称加密：
    发送方发送hello，发送中用对称秘钥加密操作，
    加密结果通过tcp传给接收方，接收方通过对称秘钥解密数据。
    加密解密用到同一把钥匙
    缺点需要通过tcp连接把对称秘钥传到server端，server端才能解密，一但对称密钥在网络中传递
    会发生中间人攻击，密钥被拦截
    
    
    下面这个https的说法更通俗理解：
    简化版
客户端发请求服务器，服务器最开始有私钥和公钥，私钥保存，只把公钥放到一个证书中，这个证书是受保护空间中的，证书是购买的，客户端需要选择是否安装这个证书，并信任它，如
果客户端信任，就建立了一个受保护层，服务器就可以在这个保护层把数据传给客户端
这个证书先客户端安装，安装后传的请求参数都通过这个证书的公钥进行了加密，发给服务器，服务器通过自己的私匙解密，然后把返回的数据通过私钥加密，发给客户端
客户端再通过公钥对这个服务器返回的数据解密
ssl或tls层是介于http与tcp层中间的，
复杂版 传输过程中传输内容都需要用hash加密，防止被更改
1、客户端把支持的协议版本，比如TLS 1.0版，客户端生成的随机数，支持的加密方法，压缩方法，信息发给服务器，
2、服务器有一个私钥，一个公钥，这时服务器生成一个随机数
，把这个随机数，还有公钥放到证收中，传给客户端，（像银行需要确认客户是否安全，这里可以发送一个正式客户提供USB密钥，里面就包含了一张客户端证书。密钥对了才能继续操作）
3、客户端安装信任证书后，再生成一个随机数，加上之前生成的随机数，和服务器发过来的随机数，结合这个证书的公钥
把请求参数加密，发给服务器，
4、服务器根据三个随机数，和私钥进行解密，再把返回的数据通过三个随机数，和私钥加密返回给客户端，(这里握手成功后一般可以用对称加密处理，因为已经认证了安全性，所以对称加密耗时更少)
5、客户端再通过三个随机数和证书中的
公钥解密数据。

如果是自签名没花钱买的证书，会弹一个框，提示不一定安全
有些网站不会询问你是否安装证书，因为这是强制安装的

//忽略host方式，可支持ip访问
[httpClient.requestSerializer setValue:httpClient.baseURL.host forHTTPHeaderField:@"host"];

urlsession的https方式，在代理方法中写上安装证书，信任证书的代码
afnetworking的https也是设置如域名信任，安装证书的代码就行，不需要作其它处理
   非对称加密算法：RSA, DSA/DSS
   对称加密算法： AES, 3DES
   HASH算法：MD5, SHA1, SHA256

服务器端会向CA申请认证书，此证书包含了CA及服务器端的一些信息（可以理解为类似公章），这样，服务器端将证书发给客户端的过程中，中间方是无法伪造的，保证了，发给客户端的公钥是服务器端发送的。

网络专业版：
1 客户端发起一个https的请求，把自身支持的一系列Cipher Suite（密钥算法套件，简称Cipher）发送给服务端

 

2  服务端，接收到客户端所有的Cipher后与自身支持的对比，如果不支持则连接断开，反之则会从中选出一种加密算法和HASH算法

   以证书的形式返回给客户端 证书中还包含了 公钥 颁证机构 网址 失效日期等等。

 

3 客户端收到服务端响应后会做以下几件事

    3.1 验证证书的合法性    

　　  颁发证书的机构是否合法与是否过期，证书中包含的网站地址是否与正在访问的地址一致等

        证书验证通过后，在浏览器的地址栏会加上一把小锁(每家浏览器验证通过后的提示不一样 不做讨论)

   3.2 生成随机密码

        如果证书验证通过，或者用户接受了不授信的证书，此时浏览器会生成一串随机数，然后用证书中的公钥加密。 　　　　　　

    3.3 HASH握手信息

       用最开始约定好的HASH方式，把握手消息取HASH值，  然后用 随机数加密 “握手消息+握手消息HASH值(签名)”  并一起发送给服务端

       在这里之所以要取握手消息的HASH值，主要是把握手消息做一个签名，用于验证握手消息在传输过程中没有被篡改过。

 

4  服务端拿到客户端传来的密文，用自己的私钥来解密握手消息取出随机数密码，再用随机数密码 解密 握手消息与HASH值，并与传过来的HASH值做对比确认是否一致。

    然后用随机密码加密一段握手消息(握手消息+握手消息的HASH值 )给客户端

 

5  客户端用随机数解密并计算握手消息的HASH，如果与服务端发来的HASH一致，此时握手过程结束，之后所有的通信数据将由之前浏览器生成的随机密码并利用对称加密算法进行加密  

     因为这串密钥只有客户端和服务端知道，所以即使中间请求被拦截也是没法解密数据的，以此保证了通信的安全

客户端如何验证 证书的合法性？

 

1. 验证证书是否在有效期内。

　　在服务端面返回的证书中会包含证书的有效期，可以通过失效日期来验证 证书是否过期

2. 验证证书是否被吊销了。

　　被吊销后的证书是无效的。验证吊销有CRL(证书吊销列表)和OCSP(在线证书检查)两种方法。

证书被吊销后会被记录在CRL中，CA会定期发布CRL。应用程序可以依靠CRL来检查证书是否被吊销了。

CRL有两个缺点，一是有可能会很大，下载很麻烦。针对这种情况有增量CRL这种方案。二是有滞后性，就算证书被吊销了，应用也只能等到发布最新的CRL后才能知道。

增量CRL也能解决一部分问题，但没有彻底解决。OCSP是在线证书状态检查协议。应用按照标准发送一个请求，对某张证书进行查询，之后服务器返回证书状态。

OCSP可以认为是即时的（实际实现中可能会有一定延迟），所以没有CRL的缺点。

 

3. 验证证书是否是上级CA签发的。


windows中保留了所有受信任的根证书，浏览器可以查看信任的根证书，自然可以验证web服务器的证书，
是不是由这些受信任根证书颁发的或者受信任根证书的二级证书机构颁发的（根证书机构可能会受权给底下的中级证书机构，然后由中级证书机构颁发中级证书）
在验证证书的时候，浏览器会调用系统的证书管理器接口对证书路径中的所有证书一级一级的进行验证，只有路径中所有的证书都是受信的，整个验证的结果才是受信



10-4 TCP与UDP相关面试问题-1  10-5 TCP与UDP相关面试问题-2

tcp,udp都位于传输层
传输层协议 ：
   tcp 传输控制协议
   udp 用户数据报协议
   
   udp（用户数据报协议）
   特点：无连接  发送udp数据报不需要建立好连接，不需要释放连接
        尽最大努力交付  不可靠传输
        面向报文  即不合并 也不拆分
        
        udp具体不合并，不拆分体现如下： 
        应用层会产生应用层报文，这个报文无论大小，udp都不会作合并拆分
        当交给传输层时：结构：udp首部 udp用户数据报文的数据部分（组成udp数据报）  这里把应用层用户数据报文原封不动的交给传输层
        ip层  把传输成的udp数据报放到ip数据报中  结构：ip首部 ip数据报的数据部分
        再通过数据链路层 物理层 进行数据传送
        
        udp用户数据报协议提供的功能有哪些呢？
          复用：
            建立传输中需要ip地址和端口号（tao接字）
            端口来说，有不同的应用对应不同的端口号，无论从哪个端口传数据出去，这些端口都可以复用udp的数据报，传输出去
          分用
            接收方通过ip接收了服务器传来的数据，然后拆成多个udp用户数据报，每个数据报中都有源端口和目的端口的标识概念，根据目的端口来分发数据，是分给端口1 或端口2，也就是回传给服务器上不同的应用
            在tcp上同样存在这种复用，分用的功能
          差错检测
             udp进行差错检测需要额外拼接12字节伪首部如下：
                  152.18.2.32
                  123.42.2.11
                  全0   12  5
            8字节udp首部：
                  1082  13
                  15     0
            7字节数据：
                  数据 数据 数据 数据
                  数据 数据 数据 0
                  
            通过上面这个结构的数据，可通过此方法求和结果：以16位字为一个单元，按二进制反码计算这些16位字的和，将和的二进制反码的结果写入检验和位
            当数据传输过来，通过此方法算出检验和位的数据是否一致，如果不一致，表明传输的数据有丢失。
            
            如im，qq,即时通讯软件，如何保证消息的正确性可以借鉴这种差错检测方式
            
            
tcp的特点：
    面向连接：
       传输前三次握手，传输完成后四次挥手
       
       为什么是三次握手？
       客户端发送了syn请求同步报文，如果发生网络超时
       客户端会重新发送syn请求同步报文
       服务端收到请求syn同步报文后，会发送同步应答报文，如果在这里又收到一个syn请求同步报文，服务端认为客户端想建立两次连接，但客户端其实是只想一次连接
       这个时候， server端发送两次同步确认报文syn ack，经过一段时间，客户端并没有传递客户端两次同步确认报文，这里候服务端就知道客户端并不是想要建立两次连接，因为第三次握手客户端只确认了一次连接  
    
       四次挥手？
       客户端：终止报文  服务端发送一个确认报文  这时客户端向server端方向连接关闭，半关闭状态
       在之后server端如果数据可向客户端发送，反过来不可
       之后在一定时机内，server端发送一个终止确认报文来断开server端到客户端这个方向的连接，
       客户端再回给server端一个ack确认报文
       之所以有两个方向连接断开是因为客户端和服务端所建立的tcp通道是全双工的，全双工一条通道两个端点都可发送和接收，所以需要双方的连接释放
       
    可靠传输：
      无差错无重复按序到达
      
      tcp是怎样保证可靠传输？
      
        无差错：
        
        不丢失：
        
        不重复：
        
        可靠传输是通过停止等待协议实现的：
            无差错情况
               客户端发送一个分组报文m1
               服务端给确认
               客户端发送m2报文
               服务端再确认m2报文给客户端
               

            超时重传
               此时，如果m1没有发送过去，由于网络，默客
               server端在一定时间未收到这个报文，就不会确认
               客户端未收到确认就会重传
               服务端再确认重传
            确认丢失
               客户端发送报文m1
               服务端确认报文丢失
               客户端超时重发报文m1
               服务端已经接收过m1报文，会丢弃重传的m1报文，重传确认报文
               客户端收到确认报文后继续发其它报文
            确认迟到
               客户端发送报文m1
               服务端发的确认报文迟到了
               超时后客户端重传m1报文
               server收到m1之后会丢弃重传的m1报文，再重传确认报文
               后续客户端收到两个确认报文，多收一个，可以不作任何处理
        
        按序到达：
            是通过滑动窗口来实现的

               
    面向字节流：
         发送方在发送的时候有一个发送的缓冲，接收方在接收的时候有一个接收的缓冲，
         最后通过tcp通道传输
         发送的时候发送的数据是由tcp把数据拼接发给接收方的，有可能把发送两次的报文拼成一次发给接收方
         发送方不管一次性提交给tcp缓冲是多大的数据，tcp根据一次性传多少数据进行划分成多次发给接收方，这是
         面向字节流的概念
    
    流量控制：
         是基于滑动窗口协议实现的
         
         你是怎样理解滑动窗口协议的？
            一方面实现流量控制和有序传输
            
         tcp的发送窗口是一个发送缓存，它里面的数据有字节编号的，是序号增大的排序发送，每次发送的数据最终需要有server告知是否收到
         所以这个发送窗口最左端是最后被服务器确认收到的的字节，最右端是最后发送的字节，发送窗口比发送缓存要小。
         
         比如接收方网不好，这时发送方发送太快，会导致接收方的缓存大量累计数据，接收方需要动态
         调整发送方的发送窗口以控制发送方发送速率，接收方告诉发送方这一时间只能接收两个字节，发送方就会调解发送窗口
         大小。
         发送窗口在发送缓存内，发送窗口包括（最后被确认的字节 已发送数据 待发送数据 最后写入字节）
         
         
         接收窗口：也是存在于接收缓存中
         收到的数据（按序到达）下一个期望收到的字节  未按序到达的字节 序号增大
         
         接收窗口可以反向制约发送窗口的大小，控制发送窗口大小，就是控制发送速率，
         接收窗口大小也是看接收缓存有多大
         按序到达可通过字节序号来控制
         
         当发送数据，可能服务端接收窗口很小，接收窗口需修改tcp报文首部字段值更正发送方窗口大小，传给客户端，
         客户端再更正窗口大小，控制发送速率
         
        
    
    拥塞控制：
         慢开始，拥塞避免
           请描述tcp慢启动特点？
            一开始发送一个报文，如果没有发送网络拥塞，则可以下次2个报文，如果网络还未拥塞，
            发送报文翻倍，4个报文，一直以指数增长发送，这叫慢增长算法，当增长到窗口的门限值
            16的时候，再采用拥塞避免策略发送，不再是指数增长，而是线性增长，16,17,18，当发送的报文太大达到拥塞窗口值24的时候
            比如连续三个确认报文的ack都没有收到的时候，发生网络拥塞，则cheng法减少策略来发送报文，同时头等少拥塞窗口值到一半12，再重新慢开始。
         快恢复，快重传
            比如达到拥塞窗口值的时候不慢开始，而是从窗口的门限值开始发送
         
         
         
    
再回答tcp功能,就可能说明什么是tcp




10-6 DNS相关面试问题

    了解dns解析吗？dns解析是怎样的过程？
    
      域名到ip地址的映射，dns解析请求采用udp数据报，且明文传输
      
      客户端通过dns协议 向dns服务器请求域名对应ip的一个解析
      dns服务器把ip地址返回给客户端  客户端再通过ip向服务器发送请求
      
    dns解析查询方式？
      递归查询：
        我去给你问一下
        客户端去询问本地的dns，本地的dns如果直接能解析结果，就返回一个ip给客户端
        如果本地的dns不能解析，则客户端会询问根域的dns，根域dns不知道再去询问顶级dns，
        顶级的也不知道会去询问权限dns，如果知道再原路层层返回客户端
        
    迭代查询：
       ”我告诉你谁可能知道“
       本地dns不知道，去询问顶级dns，顶级dns说根域dns知道，你去问根域dns，根域dns说我不知道，你问权限dns，权限dns把结果返回本地dns，
       本地dns再把结果返回客户端
       
       dns解析存在哪些常见的问题？
          dns劫持问题：
             客户端询问dns服务器ip地址，因为是udp数据报，明文传输，
             如果中间有一个钓鱼dns服务器，它在询问过程中劫持客户端询问，并返回一个
             钓鱼网站的ip地址。
          dns与http的关系是怎样的呢？
             是迷惑，没关系的，
             dns解析发生在http建立连接之前的
             dns解析请求使用的udp数据报，端口号53
             
             
          dns解析转发问题：
             客户端问本地dns服务器获取ip地址的时候，比如说用的手机，某某移动会解析手机
             访问的域名，但是有些小的运营商不遵守规范，为了节省资源，而去转给某某电信的dns
             去解析ip地址，某某电信又会去权威nds解析ip，权威dns会根据不同的小运营商进行解析，
             比如说一个域名可对应多个ip，它会返回其中一个ip，这个时候可能手机是移动的，访问的是电信的ip服务器
             跨网后效率慢的问题
             
      怎样解决dns劫持？
       httpdns：
         使用dns协议向服务器的53端口进行请求，
         这里可使用http向dns服务器的80端口进行请求
         http://119.29.39.29/d?dn=www.com&ip=123.12.34.23(客户端自带的ip地址)
         这可以得到ip地址
       长连接
          客户端 长连接通道到  server（代理服务器）
         server（代理服务器）通过内网专线请求api server 这个server可对dns作解析，同时返回ip地址。
      
      
      
      
      10-7 Session与Cookie相关面试问题
         http协议无状态特点的补偿session cookie
         客户端向server多次发请求，server不知道是不是同一个用户的，
         
         cook?
         
         cookie主要是记录用户状态，区分用户，状态保存在客户端
         
         客户端向服务端发送一个请求，服务端生成一个cookie，通过响应报文把cookie
         返回给客户端，客户端保存下来
         
         响应报文中有头部字段，里面添加setcookie传给客户端
         
         客户端再次请求中把cookie添加到首部字段传给sever，server再判断cookie知道是谁
         
         
         
         怎样修改cookie？
            新cookie替代旧cookie
            规则：name,path,domain都需要和原cookie一致才能覆盖
            
            删cookie？
            新cookie替代旧cookie
            设置cookie的expires=过去一个时间点
            或maxage=0来删一个cookie
            
            怎样保证cookie安全？
            为cookie进行加密处理
            或只在https上携带cookie
            或设置cookie为httponly，防跨站脚本攻击
            
        session：
            session记录的用户状态在服务端存的
            它与cookie的区别在于存放位置
            session需依赖cookie的机制来实现
            
            客户端发送http请求
            server记录用户状态，如用户名密码的记录
            server生成sessionid发给客户端，通过http响应的头部字段中，setcookie中放入sessionid
            发送信息的时候，cookie中已经有sessionid，服务端可以通过知道的sessionid区分它是哪个用户。
            
        网络面试问题总结：
           http中的get,post有什么区别？
             从语义的角度回答
           https连接建立流程怎样的？
              通过时序图回答
           客户端会发送服务端一个真实的加密算法列表，包括ssl/tls版本号，随机数c
           服务端再回给客户端证书，包括商定的加密算法
           通过非对称加密进行对称加密密钥传输
           之后http之间的网络请求就通过非对称加密所保护的对称密钥进行后续的一个网络访问
           
           tcp和udp有什么区别？
             特点功能入手
             tcp面向连接 可靠传输 面向字节流  提供了流量的控制 拥塞控制
             udp简单提供复用，分用，差错检测基本传输功能，包括udp是无连接的
           tcp的慢开始过程？
             tcp的拥塞控制原理  慢开始 拥塞避免算法来回答
             
            客户端怎样避免dns劫持？
            httpdns
            长连接方案
            
            
            
第十一章 各种模式

      
      
      11-1 六大设计原则相关面试问题
      
      任何一种设计模式都是遵从一些设计原则的
      
      六大设计原则
      
      责任链  如系统的响应机制
      桥接
      适配器模式
      单例  在使用上有很多注意的点的
      命令  
      
      六大设计原则
      你都了解知道哪些设计原则，对这些原则理解
      单一职责原则
      依赖倒置原则
      开闭原则
      里氏替换原则
      接口隔离原则
      迪米特法则
      
      单一职责原则：
      一个类只负责一件事 如：uiview只负责事件传递事件响应 calayer负责动画视图的展示显示
      
      开闭原则：
      对修改关闭，对扩展开放  比哪类的定义，以后迭代，如成员变量定义谨慎，避免反复修改类，同时扩展开发，类的数据结构定好了，就只关心接口和子类  
      
      接口隔离原则：
      使用多个专门的协议，而不是一个庞臃肿的协议 deleagate专处理回调事件 datasource专门获取数据源  多个专门协议作接口隔离
      协议中的方法尽量少
      
      依赖倒置原则：
      抽象不应该依赖于具体实现，具体实现不应该依赖于抽象
      比如我们在定义一些具体访问，增删改查接口调用，所有调用都应该依赖于你所定义的抽象的接口，接口内部怎么实现，用数据库，文件，plist它不知道
      对上层来说它只依赖于作好的接口定义，上层不关注里面具体实现。
      
      里氏替换原则：
      父类可以被子类无缝替换，且原有功能不受任何影响
      kvo机制利用到了这种原则 oc特性中，kvo，当调用addobersver这个方法的时候，系统在动态运行时为我们创建子类，我们虽然感受到使用的是父类，但实际上
      已经消无声息的被替换成对应的子类，体现到了原有功能不受影响
      
      迪米特法则：
      应该让一个对象对其它对象有尽可能的了解，作到高内聚 低耦合
      因为模块之间耦合低比较好。
      
      
      
      11-2 责任链模式相关面试问题
      
      现有业务有a,b,c  ，程序启动后调用a，调用b，最后调用c
      如果哪天业务变了，调用c 调用b 调用a
      怎么解决问题？
      
      类构成 
        有个类 类有个成员变量，这个成员变量的类型和这个类是一样的，这就是基础数据定义
        
 
 BusinessObject.h       
#import <Foundation/Foundation.h>

@class BusinessObject;//相当于业务 a b c
typedef void(^CompletionBlock)(BOOL handled);//表达某一业务处理完成之后，返回的结果代表它是否有处理对应的业务
typedef void(^ResultBlock)(BusinessObject *handler, BOOL handled);//业务最终处理者 参数2表达是否有处理这业务

@interface BusinessObject : NSObject

// 下一个响应者(响应链构成的关键)定义和当前类类型相同的成员变量，就组成了基本的责任链结构
@property (nonatomic, strong) BusinessObject *nextBusiness;
// 响应者的处理方法，作为响应链的入口函数
- (void)handle:(ResultBlock)result;

// 各个业务在该方法当中做实际业务处理，完成后通过block作为业务结果返回，因为可能有异步网络请示，用block
- (void)handleBusiness:(CompletionBlock)completion;
@end


BusinessObject.m
#import "BusinessObject.h"

@implementation BusinessObject

// 责任链入口方法
- (void)handle:(ResultBlock)result
{
    CompletionBlock completion = ^(BOOL handled){
        // 当前业务处理掉了，上抛结果
        if (handled) {
            result(self, handled);//处理了返回当前处理的对象以及返回结果
        }
        else{//没处理掉
            // 沿着责任链，指派给下一个业务处理，a业务处理完如果再处理b业务会走这段代码
            if (self.nextBusiness) {
                [self.nextBusiness handle:result];//递归的去调用
            }
            else{
                // 没有业务处理, 上抛，a后面没有下其它业务如b,c会返回这个处理结果
                result(nil, NO);
            }
        }
    };
    
    // 当前业务进行处理，这里就是不同的业务a,b,c，相当于当前不同的类对象，作不同的业务处理，如a业务处理完成之后就会调用上面代码的block
    [self handleBusiness:completion];
}

- (void)handleBusiness:(CompletionBlock)completion
{
    /*
     业务逻辑处理
     如网络请求、本地照片查询等
     */
}

@end

      
  答：使用责任链模式解决这种问题，业务c可以作为第一个要处理的，可把它的nextBusiness指向为b，b可把它的 nextBusiness指向为c，c的nextBusiness指向为nil
  
  
  
  11-3 桥接模式相关面试问题
  
  面试题：
  你是怎样理解桥接模式的？
  
  一个关于业务解耦相关的问题：
  
  一个vc列表，它由网络数据b1变到网络数据b2再变到网络数据b3
  同一列表的网络数据发生了三次变化，但这三套数据是需要并存的，比如说
  判断此时该用哪一套数据，对于这个需求，这个设计方案和思路？
  
  可以通过桥接模式解决列表与数据之间的耦合问题。
  
  桥接模式的类构成：
  
  比如说有一个抽象类a，有一个成员变量是抽象类b，这样构成桥接模式的关键
  抽象类a有三个子类a1,a2,a3，抽象类b有三个子类b1,b2,b3
  vc列表可以看作抽象类a的子类a2，三套列表可以看成是b1,b2,b3,可解决上述问题
  
  
   BridgeDemo桥接模式的使用方 
   BaseObjectA 就是上述的抽象类a
   ObjectA1 ，ObjectA2 是BaseObjectA 子类
   BaseObjectB 就是上述的抽象类b
   ObjectB1，ObjectB2 是BaseObjectB 子类
   
  
  代码示列：
  
 BridgeDemo.h 
  
  #import <Foundation/Foundation.h>

@interface BridgeDemo : NSObject

- (void)fetch;

@end



BridgeDemo.m



#import "BridgeDemo.h"

#import "BaseObjectA.h"
#import "BaseObjectB.h"

#import "ObjectA1.h"
#import "ObjectA2.h"

#import "ObjectB1.h"
#import "ObjectB2.h"

@interface BridgeDemo()
@property (nonatomic, strong) BaseObjectA *objA;
@end

@implementation BridgeDemo

/*
 根据实际业务判断使用那套具体数据   a1的业务逻辑使用三套数据  a2的业务逻辑又可以使用不同的三套数据
 A1 --> B1、B2、B3         3种
 A2 --> B1、B2、B3         3种
 A3 --> B1、B2、B3         3种
 */
- (void)fetch
{
    // 创建一个具体的ClassA 创建的是业务a1 或 a2 或 a3
    _objA = [[ObjectA1 alloc] init];
    
    // 创建一个具体的ClassB， 针对业务创建实现获取不同数据 ObjectB1获取第一套数据 ObjectB2获取第三套数据
    BaseObjectB *b1 = [[ObjectB1 alloc] init];
    // 将一个具体的ClassB1 指定给抽象的ClassB
    _objA.objB = b1;
    
    // 获取数据
    [_objA handle];
}

@end



BaseObjectA.h

#import <Foundation/Foundation.h>
#import "BaseObjectB.h"
@interface BaseObjectA : NSObject

// 桥接模式的核心实现，它的成员是BaseObjectB 一个抽象类，不是具体的类，它是感知不到BaseObjectB的子类作了哪些事情的
@property (nonatomic, strong) BaseObjectB *objB;

// 获取数据
- (void)handle;

@end



BaseObjectA.m

#import "BaseObjectA.h"

@implementation BaseObjectA

 /*
    A1 --> B1、B2、B3         3种    control1调用了
    A2 --> B1、B2、B3         3种
    A3 --> B1、B2、B3         3种
  */
  //调用的是它成员的fetchData
- (void)handle
{
    // override to subclass
    
    [self.objB fetchData];
}

@end


ObjectA1.h

#import "BaseObjectA.h"

@interface ObjectA1 : BaseObjectA

@end



ObjectA1.m

#import "ObjectA1.h"

@implementation ObjectA1

//覆写这个方法，写a1相关的业务逻辑
- (void)handle
{
    // before 业务逻辑操作
    
    [super handle];
    
    // after 业务逻辑操作
}


@end



ObjectA2.h
#import "BaseObjectA.h"

@interface ObjectA2 : BaseObjectA

@end


ObjectA2.m

#import "ObjectA2.h"

@implementation ObjectA2

- (void)handle
{
    // before 业务逻辑操作
    
    [super handle];
    
    // after 业务逻辑操作
}

@end




BaseObjectB.h
#import <Foundation/Foundation.h>

@interface BaseObjectB : NSObject

- (void)fetchData;

@end




BaseObjectB.m

#import "BaseObjectB.h"

@implementation BaseObjectB
//获取数据的方法，什么都没有作，作为一个抽象类让子类去实现
- (void)fetchData
{
    // override to subclass
}

@end




ObjectB1.h
#import "BaseObjectB.h"

@interface ObjectB1 : BaseObjectB

@end






ObjectB1.m

#import "ObjectB1.h"

@implementation ObjectB1
//这里覆写父类，写自己具体的逻辑，如下载对应的网络数据
- (void)fetchData{
    // 具体的逻辑处理
}

@end




ObjectB2.h
#import "BaseObjectB.h"

@interface ObjectB2 : BaseObjectB

@end




ObjectB2.m
#import "ObjectB2.h"

@implementation ObjectB2
//这里覆写父类，写自己具体的逻辑，如下载对应的网络数据
- (void)fetchData{
    // 具体的逻辑处理
}

@end







11-4 适配器模式相关面试问题

一个现有类需要适应变化，怎么解决这个问题？
场景，有个文件，在很早就产生了，因为这个文件可能设计很成熟，很多年未修改，但新的业务可能
会影响这个文件，所以需要适配器模式解决。

如果说原有类无法适用新变化，但项目又使用了这个原有类，需适配器解决问题

适配器分：
   对象适配器
   类适配器
   
   
   对象适配器的构成
   
   创建一个适配对象，把原有的类作为成员变量集成到这个适配对象中
   原有的类（需要适配的被适配的类）
   
   
   这种模式就是需要适配的类作为适配器类的成员变量   


-(void)request
{
     coding //适配逻辑 新增的业务功能
   [被适配对象 某方法]//比较老的功能需要保留的功能
     coding //适配逻辑 新增的业务功能
}

Target是需要被适配的类
CoolTarget是创建的适配器类新增的业务都写到这里
代码如下：

Target.h
#import <Foundation/Foundation.h>

@interface Target : NSObject

- (void)operation;

@end


Target.m
#import "Target.h"

@implementation Target

- (void)operation
{
    // 原有的具体业务逻辑
}

@end



CoolTarget.h
#import "Target.h"

// 适配对象
@interface CoolTarget : NSObject

// 被适配对象
@property (nonatomic, strong) Target *target;

// 对原有方法包装
- (void)request;

@end


CoolTarget.m
#import "CoolTarget.h"

@implementation CoolTarget

- (void)request
{
    // 额外处理
    
    [self.target operation];
    
    // 额外处理
}

@end



  
  11-5 单例模式相关面试问题
  
  你不一定能够使用的正确的模式
  单例模式要实现好考虑的问题还是比较多的
  
  Mooc.h
  #import <Foundation/Foundation.h>

@interface Mooc : NSObject

+ (id)sharedInstance;

@end


Mooc.m
#import "Mooc.h"

@implementation Mooc

+ (id)sharedInstance
{
    // 静态局部变量
    static Mooc *instance = nil;
    
    // 通过dispatch_once方式 确保instance在多线程环境下只被创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例，这里用super未用self，是避免产生循环调用，又再次调用allocWithZone
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 重写方法【必不可少】如果直接allocwithzone也是可以创建对象的
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// 重写方法【必不可少】 外界可能会copy一个对象，为保证永远只创建一次，则这样写
- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

@end
  
       
       
11-6 命令模式相关面试问题&面试总结

行为参数化的模式
比如说像微博app，里面各个模块都会涉及到转发 评论 赞
如果转发 评论赞 以行为参数化的方式封装起来，当点击按钮就会触发按钮的执行
而不需要每个模块都写一样的代码，降低代码重合度

什么是命令模式 ，它的作用是什么？
命令模式是作行为参数化的，它的作用是 降低代码重合度


代码实现：

Command.h //命令的抽象类，多个功能模块的命令可以创建多个此类的对象
#import <Foundation/Foundation.h>

@class Command;
typedef void(^CommandCompletionCallBack)(Command* cmd);//命令完成的回调，返回值是一个命令类型的对象

@interface Command : NSObject
@property (nonatomic, copy) CommandCompletionCallBack completion;

- (void)execute;//执行
- (void)cancel;//取消

- (void)done;//完成 如执行完成会block回调，告诉用户完成

@end  


Command.m

#import "Command.h"
#import "CommandManager.h"
@implementation Command

- (void)execute{
    
    //override to subclass;  定义很多抽象父类的命令子类去作自己想执行的逻辑
    
    [self done];//上面的逻辑完成之后调这个方法通知完成
}

- (void)cancel{
    
    self.completion = nil;//把回调为nil，获取不到回调则相当于未给上层通知
}

- (void)done
{
    dispatch_async(dispatch_get_main_queue(), ^{//异步加到主队列，因为命令可能在子线程或不在子线程，需要这种方式回到调用方
        
        if (_completion) {
            _completion(self);//回调完成之后
        }
        
        //释放block nil防止循环引用
        self.completion = nil;
        
        //调用命令管理者的移除操作把当前命令移除掉
        [[CommandManager sharedInstance].arrayCommands removeObject:self];
    });
}

@end 


CommandManager.h 
#import <Foundation/Foundation.h>
#import "Command.h"
@interface CommandManager : NSObject
// 命令管理容器，存储了正在执行的命令
@property (nonatomic, strong) NSMutableArray <Command*> *arrayCommands;

// 命令管理者以单例方式呈现
+ (instancetype)sharedInstance;

// 执行命令
+ (void)executeCommand:(Command *)cmd completion:(CommandCompletionCallBack)completion;

// 取消命令
+ (void)cancelCommand:(Command *)cmd;

@end 



CommandManager.m
#import "CommandManager.h"

@implementation CommandManager

// 命令管理者以单例方式呈现
+ (instancetype)sharedInstance
{
    static CommandManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 【必不可少】
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

// 【必不可少】
- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

// 初始化方法
- (id)init
{
    self = [super init];
    if (self) {
        // 初始化命令容器
        _arrayCommands = [NSMutableArray array];
    }
    return self;
}

+ (void)executeCommand:(Command *)cmd completion:(CommandCompletionCallBack)completion
{
    if (cmd) {//如果命令存在
        // 如果命令正在执行不做处理，否则添加并执行命令
        if (![self _isExecutingCommand:cmd]) {//如果命令已经正在执行，就忽略掉此次执行，这里表示这个命令没有执行
            // 添加到命令容器当中
            [[[self sharedInstance] arrayCommands] addObject:cmd];
            // 设置命令执行完成的回调的block，作一个命令完成的回调
            cmd.completion = completion;
            //执行命令
            [cmd execute];
        }
    }
}

// 取消命令
+ (void)cancelCommand:(Command *)cmd
{
    if (cmd) {
        // 从命令容器当中移除
        [[[self sharedInstance] arrayCommands] removeObject:cmd];
        // 取消命令执行
        [cmd cancel];
    }
}

// 判断当前命令是否正在执行
+ (BOOL)_isExecutingCommand:(Command *)cmd
{
    if (cmd) {//如果这个命令已经在命令容器中，则认为命令正在执行的
        NSArray *cmds = [[self sharedInstance] arrayCommands];
        for (Command *aCmd in cmds) {
            // 当前命令正在执行
            if (cmd == aCmd) {
                return YES;
            }
        }
    }
    return NO;
}


@end
            
            
面试题总结：
请手写单例实现，记得重写copy,allocwithzone 两的类方法，dispath_once中用super alloc创建

你都知道哪些设计原则，请谈谈你的理解
      单一职责原则：
      一个类只负责一件事 如：uiview只负责事件传递事件响应 calayer负责动画视图的展示显示
      
      开闭原则：
      对修改关闭，对扩展开放  比哪类的定义，以后迭代，如成员变量定义谨慎，避免反复修改类，同时扩展开发，类的数据结构定好了，就只关心接口和子类  
      
      接口隔离原则：
      使用多个专门的协议，而不是一个庞臃肿的协议 deleagate专处理回调事件 datasource专门获取数据源  多个专门协议作接口隔离
      协议中的方法尽量少
      
      依赖倒置原则：
      抽象不应该依赖于具体实现，具体实现不应该依赖于抽象
      比如我们在定义一些具体访问，增删改查接口调用，所有调用都应该依赖于你所定义的抽象的接口，接口内部怎么实现，用数据库，文件，plist它不知道
      对上层来说它只依赖于作好的接口定义，上层不关注里面具体实现。
      
      里氏替换原则：
      父类可以被子类无缝替换，且原有功能不受任何影响
      kvo机制利用到了这种原则 oc特性中，kvo，当调用addobersver这个方法的时候，系统在动态运行时为我们创建子类，我们虽然感受到使用的是父类，但实际上
      已经消无声息的被替换成对应的子类，体现到了原有功能不受影响
      
      迪米特法则：
      应该让一个对象对其它对象有尽可能的了解，作到高内聚 低耦合
      因为模块之间耦合低比较好。
      
能否用一幅图简单表示桥接模式的结构
定义一个抽象父类a ，一个抽象父类b，把抽象父类b作为抽象父类a的一个成员值，这个可
延伸出a1到b1,a2到b2这样的关系，呈现了一种桥梁的作用。达到解耦合的操作


ui事件传递机制是怎样实现的？你对其中运用的设计模式是怎样理解的？
从ui设计的角度来回答是一道问题，从设计模式来说又是一个问题，如这里用到责任链设计模式。
类构成 
有个类 类有个成员变量，这个成员变量的类型和这个类是一样的，这就是基础数据定义  





第12章  架构面试题

12-1 图片缓存框架相关面试问题

架构/框架：

图片缓存
阅读时长统计框架
复杂页面架构
客户端整体架构

架构和框架为了解决什么问题？

模块化：将各个功能模块化分
分层： 目的是解耦
解耦：最终效果降低代码重合度
降低代码重合度：

怎样设计一个图片缓存框架？

manager 管理者，以调度内部各个模块
内部模块有：
内存：内存管理模块，图片缓存，模拟计算机原理多级缓存
磁盘：图片磁盘上的处理
网络：本地没有图片，可通过网络下载图片
code manage解码管理者   ：如果图片是压缩编码过的，需要这个解码的模块
    图片解码模块
    图片压缩／解压缩



图片通过什么方式进行读写，过程是怎样的？

如sdwebimageview，是怎么方式进行读写的？

以图片url的单向hash值，就是把url转为hash值，然后作为key，图片对象来存储

读取过程是怎么样的？
根据key获取图片，首先在内存中去查找图片，如果找到返回调用方，如果内存中没找到
在磁盘中查找，找到返回结果，没找到进行相应的网络下载

为什么使用内存模块？
系统会采用多级缓存提高查找效率，这里借助这一思想，每次磁盘下载耗时，流量损耗，
内存中的话，下载过一次不用重复下载

内存方面的设计需要注意什么问题？
内存存储的大小，不能无限大空间，不能占用所有内存
淘汰策略，如果有size限制，后面有新的缓存，需要把旧的某些图片淘汰掉

内存存储的size，应该用什么数据结构实现呢？
分场景：
10kb以下的图片使用最多的，可以开避50个空间，来缓存图片
100kb以下比10kb大的图片，可以开辟20个，缓存20张图片就好
100kb以上的图片，开辟10个空间，缓存10张图片
可考虑图片本身和使用频率来设计图片大小，可采用队列的方式存储图片，
最先存的图片，以后最先移除。淘汰的策略是依赖存储方案的


淘汰策略，怎么实现图片的淘汰呢？
方式1:以队列先进先出的方式淘汰，最先存的图片，内存满了最先淘汰
方式2：lru算法，最近最久未使用算法，模拟计算机算法的策略，如在30分钟之内是否使用过这张图片，如果没有则淘汰掉
可以通过定时检查，每30秒对图片进行list遍历，看看哪张图片超30分钟淘汰，这种方式有些耗性能
别一种检查，提高检查触发频率，如每一次进行图片读写的时候，如果发现某一图与上次使用时间超过30分钟移掉
或者从前台到后台去判断图片是否长时间使用，这种方式需要注意时间和空间开消问题。


磁盘方面的设计需要考虑什么？
磁盘的空间很大，读取效率低，这是特点
考虑以下几点：
存储方式的选择
存储图片的大小限制：如100m
磁盘上淘汰策略：如有些图片是在三个月前浏览的，买过这个图片的东西，现在不需要就清掉
或图片超过7天则删除

网络设计相关内容

网络部份设计需要考虑哪些问题？

图片最大请求并发量的限制，最多请求几张
请求超时策略：如重试一次，再失败则不请求
请求的优先级：下载的图片是否是当前用户急需的，急需的优先级高


图片解码

对于不同格式的图片，解码采用什么方式来做？
应用策略模式对不同图片格式进行解码，一方面可解码不同格式，另一方面当替换一些
解码代码的时候不影响整体设计

在哪个阶段做解码处理呢？
在磁盘读取的是未解码的，放到内存中的时候去解码完成
网络请求返回后对图片解码，回传给内存模块缓存已经解码的


图片缓存中线程的处理
图片通过url编码后的key经由manager 去memory中查找，命中返回，未命中，通过磁盘缓存读 cache disk，如果有返回，并放入内存方便下次使用，如果没有发送 cache network download，并放到内存当。



12-2 阅读时长统计相关面试问题

怎样设计一个时长统计框架？
记录器：负责对每一条时长统计进行记录
记录管理者：记录器记录的每条记录都需要交给管理者进行管理

记录器包括模块：
页面式的记录器，从页面push开始pop之后代表记录结束
流式记录器：如访问或浏览头条每一个新闻的阅读时间记录，流式记录器
自定义记录器：如有些新闻是滚动播放，由业务方根据具体业务进行记录

记录管理者模块：
记录缓存：记录器记录的数据需要管理者缓存，记录缓存可进行维护，如果通过
内存去记录会有断电，程序死了，会丢失，为此会有磁盘存储模块
磁盘存储模块
上传器：本地记录的时长统计上传给服务器

记录器
为何要有不同类型的记录器，你的考虑是什么？
基于不同分类场景，提供的关于记录的封装，适配
流式，页面式，自定义的记录器可以说它们的特点回答这个问题

记录的数据会由于某些原因丢失，你怎么处理呢？
怎样降低时长统计丢失率的问题，因为在内存中总有可能丢推崇
定时写磁盘，每满多少时间把数据写入磁盘，没有条数限制
限定内存缓存条数，如超过几条，写磁盘

记录器上传器，关于延时上传的场景有哪些？
假如每次生一次记录，调用一次上传，会耗性能。
如每满50条上传，或多少时间内上传
场影如，前后台切换上传  从无网到有网变化中上传  通过轻量接口捎带上传，这个不一定要回答，后一种有偶合

上传时机是怎么把控的？
立刻上传
延时上传
定时上传


12-3 复杂页面架构相关面试问题-1

怎样的页面是复杂的呢？
微博app的正文页，去哪儿旅行app的航班列表，涉及单程，往返，国内，国际， 今日头条，腾讯新闻等咨询类app的多签首页，脉脉app
多签首页。

如微博app正文页作列子。打开app参照同步课程

复杂页面整体架构应该是怎样的？
数据流 数据效互反应到ui上?
如何实现反向更新?

整体架构：

借鉴mvvm方式。用于复杂页面，但又有些区别，相似处都有viewmodel，进行业务逻啊处理，viewcontrol view划分在
视图层，engine和model可以理解为广义上的mvvm中的数据层。

视图层可定义：viewcontrol view
viewmodel:
engine:
model:

关系：
view与viewcontrol关系：所有的view都是以容器的形式封装起来的，作为viewconrtol的成员变量
view产生的所有视图的交互事件都以deleaget回调给veiwcontrol

viewcontrol与viewmode的关系：一个viewcontrol可能对应多个viewmodel，viewmodel可能通过block,代理方式，把业务逻辑的处理结果作为
输入，输出传给viewcontrol去使用

viewmodel和engine关系：viewmodel可以通过桥接方式持有engine的，engine可以通过block,代理方式把处理结果回给viewmodel
为什么要用桥接方式表达它们关系呢？比如转发，评论，赞，三个按钮，如何作到网络数据与业务数据解耦。可用桥接模式。

engine和modle关系：engine持有了modle，可以对modle的数据进行加工操作。


各个层的职责：
视图层view,viewcontrol：
view 控件初始化，设置数据，事件代理，不涉及网络，业务数据，只是ui数据设置，有交互以代理方式回传给viewcontrol
viewcontrol:视图的创建，组合，包括视图之间协调逻辑，view事件回调处理
业务逻辑层viewmodel：
viewmodel业务逻辑处理，预排版，把网络数据转成ui数据。数据增删改查的封装者，不承担增删改查逻辑，线程安全处理，如微博下拉刷新，同时删除评论，需
保证线程安全。
数据层engine和model:
engine：负责网络请求，数据解析，实际增删改查，本地的处理逻辑，如对server适配，如返回的字段需要转化传给ui

数据流：
网络数据：网络数据作为engine输入，产生业务数据，再由engine层把业务数据输出给viewmodel层，viewmodel层处理业务数据成ui数据，再把数据交给viewcontrol
业务数据：
ui数据：


数据及数据关系：
网络数据：一级评论 二级评论 转评赞 广千，推荐等其它数据等原始数据。
业务数据： id类型的data，和业务类型的type,封装成id类型，根据type知道它是一级，二级评论
ui数据：如lable对象的farme,value ，ui数据对应ui的属性。

业务数据对网络数据强引用，网络数据作为业务数据的一个成员变量
ui数据也是业务数据的成员变量，ui数据可以通过一个weak来找到它所属的业务数据


反向更新：
如即有用户交互，又有网络更新，如下拉刷新，进某页刷新，都会通过view，以代理找到viewcontrol，再由
viewcontrol找到viewmodel，viewmodel是viewcontrol的一个成员变量，由viewmodel的处理ui数据打上一个脏标记，
再由viewmodel把处理的ui数据交给viewcontrol。



12-4 复杂页面架构相关面试问题-2总结
上一章微博的设计涉及到以下思想
mvvm框架思想：viewmodel
reactnative的数据流思想  视图数据  网络数据 业务数据
系统uiview反向更新机制思想，系统view绘制原理时，实际打了一个脏标记，当在runloop将结束时绘制。view通过返向找到viewmodel,变更数据打脏标记，再把数据返回view，更新视图
facebook开源框架asyncdisplaykit关于预排版思想  如view的frame，提前算好，解决性能问题

mvvm的标准框架是怎样的？
三部份组成：
model数据层
view视图层
viewmodel业务逻辑层

view和viewmodel的组成，view层的viewcontrol有一个强引用成员viewmodel,viewmodel通过block把输出结果或rac函数响应式编程把它的结果给viewcontrol
viewmodel和model的关系，viewmodel有一个强成员变量model，model可通过代理,block回传给viewmodel
view层包含viewcontrol和view  viewcontrol不是逻辑层，只是视图的容器。

rn数据流思想：
视图上面所添加的所有视图最后组成的是一个多叉树。对某一个页子结点数据更新，需要子结点的数据更新到它的根结点
再由根结点返向遍例其它子结点，看看哪些子结点并询问是否需要更新。或反向更新的时候先打脏标记，最后再更新带有脏标记的视图。
仍何一个子，子孙节点没有权力更新，只是把它更新的数据消息传给根节点，再由根节点遍列所有子节点，更新子节点
由最开始主动更新变为被动更新的这种方式。也叫反向更新。


12-5 客户端整体架构相关面试问题&面试总结

你所在公司客户端整体架构是怎样的？你怎么设计？
通过图来表达

通用层：最底层需要独立于app的通用层，如有时间统计框架，崩溃统计，网络第三方库，这一层它放到
任何app都可用为底层

通用的业务层：如特列uiimage封装。对于整个app都对这些业务有需求

中间层：协调和解耦通用业务器与具体业务关系

业务层：业务a 业务b 业务c

这样设计可以单独把某个业务拿出来


业务之间的解耦通信方式
openurl是一种解耦方式，实现app的跳转，还有其它的解耦方式吗？
依赖注入的方式对各个业务解耦。

如业务a需要使用业务c某个方法，如果直接使用就耦合一起了，这里加个中间层，
业务c可把自己注入中间层，由业务a去中间层获取业务c方法

ios中，中间层，让某一个业务方注册一个协议到中间层中，同时用代理方法返回给中间层实例对象
业务a可以使用协议，从中间层使用实例对象。

总结：
图片缓存：整体缓存框架的设计，内存，磁盘缓存设计
阅读时长统计框架是怎样的，时间记录的数据丢失率问题
复杂页面架构  mvvm  rn facebook的设计思想。
客户端的整体架构分层 上层可以依赖下层，下层不能依赖上层  解耦：openurl 依赖注入

openURL:方法

UIApplication有个功能十分强大的openURL:方法

-(BOOL)openURL:(NSURL *)url;

//openURL:方法的部分功能有
//打电话：
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@“tel://18812345678”]];

//发短信：
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@“sms://18812345678"]];

//发邮件：
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@“mailto://marlonxlj@163.com”]];

//打开网页：
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@“http://www.baidu.com”]];

//调用谷歌地图(Google Maps)
NSString *searchQuery = @"1 Infinite Loop, Cupertino, CA 95014";  
searchQuery = [addressText stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
NSString *urlString=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", searchQuery];  
[[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlString]];

//调用应用商店(AppStore),这个地址是可以官网上查到的
NSURL *appStoreUrl= [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=291589999&amp;mt=8"];
[[UIApplication sharedApplication] openURL:appStoreUrl];

//调用appstore中程序的评论
NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                         m_appleID ];  
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];





第13章   数据结构和算法

算法：
字符串反转
链表反转
有序数组合并
hash算法
查找两个子视图的共同父视图
求无序数组当中的中位数


给定字符串hello,world，对其反转：
一个数组，存储了hello,world
设置两个指针，一个指向h，一个指向d
遍历过程中逐步交换首尾，如h和d进行交换
交换之后移动指针到对应的下一个字符位置，再进行交换
退出条件，第一个指针移动到,号，第二个指针移动到,号，所以条件为第一个指针大于等于第二个指针

xcode中实现算法

CharReverse.h
#import <Foundation/Foundation.h>

@interface CharReverse : NSObject
// 字符串反转，函数 
void char_reverse(char* cha);
@end


CharReverse.m
#import "CharReverse.h"

@implementation CharReverse
//输入字符指针
void char_reverse(char* cha)
{
    // 指向第一个字符
    char* begin = cha;
    // 指向最后一个字符的结尾
    char* end = cha + strlen(cha) - 1;
    
    while (begin < end) {
        // 交换前后两个字符,同时移动指针
        char temp = *begin;
        *(begin++) = *end;//begin交换后向前移动
        *(end--) = temp;//end交换后向后移动
    }
}

@end

调用方法：
-(void)math
{
  char ch[] = "hello,world";
  char_reverse(ch);
  printf("%s",ch);
}





13-2 链表反转算法相关面试问题

1->2->3->4->null
返转后：
4->3->2->1->null

分析：
head->1->2->3->4->null
利用链表头插法思想实现单链表反转
定义一个newh新的头节点指针，初始化指向null
定义一个临时指针变量p，进行链表遍列动作，p会先指向1，再2，3，4
遍历时，先p移动到下一个位置2，再把newh指向1,1的后面指向null，必须先移动p，保证链表不会丢失
p再移动到3，把newh指向2,2再指向1
结束条件，直到p指针指向null

代码：


ReverseList.h
#import <Foundation/Foundation.h>

// 定义一个链表的结构体
struct Node {
    int data;//节点数据1,2,3,4
    struct Node *next;//代表链表下一个节点
};

@interface ReverseList : NSObject
// 链表反转逻辑
struct Node* reverseList(struct Node *head);
// 构造一个链表
struct Node* constructList(void);
// 打印链表中的数据
void printList(struct Node *head);

@end


ReverseList.m
#import "ReverseList.h"

@implementation ReverseList
//输入参数是原来链表的头节点，返回值是新的链表的头节点
struct Node* reverseList(struct Node *head)
{
    // 定义遍历指针，初始化为原链表头结点
    struct Node *p = head;
    // 反转后的链表头部
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        
        // 记录p节点的下一个结点，不太明白
        struct Node *temp = p->next;
        // 当前结点的next指向新链表头部
        p->next = newH;
        // 更改新链表头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    
    // 返回反转后的链表头结点
    return newH;
}

struct Node* constructList(void)
{
    // 头结点定义
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *cur = NULL;
    
    for (int i = 1; i < 5; i++) {//挂了链表4个元素
        struct Node *node = malloc(sizeof(struct Node));//创建一个链表结构空间
        node->data = i;//链表的数据为i  
        
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        // 当前结点的next为新结点,不太明白？
        else{
            cur->next = node;
        }
        
        // 设置当前结点为新结点
        cur = node;
    }
    
    return head;
}

void printList(struct Node *head)
{
    struct Node* temp = head;
    while (temp != NULL) {
        printf("node is %d \n", temp->data);
        temp = temp->next;//访问链表的下一个节点
    }
}

@end

使用方式：
struct node * head = constructlist();
printlist(head);




13-3 有序数组合并算法相关面试问题

[1 4  6  7  9]和[2 3 5 6 8 10 11 12]
合并后仍然是有序的

定义p,q两个指针
p指针指向每一个数组第一个位置1
q指针指向每二个数组第一个位置2
循环遍列两个数组，比较p,q指向的数据大小
如果p指向的数据小于q，就把p指向的数据填入到新的数组中
同时移动p指针，q指针不同
q小于p
把q指向的数据存入新的数组中
谁小就存到数组中
如果q移动下一个为null，就把p余下的数组放到新的数组中

代码：

MergeSortedList.h
#import <Foundation/Foundation.h>

@interface MergeSortedList : NSObject
// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序  参数，被合并的数组a 被合并数组a的长度 被合并的数组b 被合并数组b的长度  合并后的新数组result
void mergeList(int a[], int aLen, int b[], int bLen, int result[]);

@end


MergeSortedList.m

#import "MergeSortedList.h"

@implementation MergeSortedList

void mergeList(int a[], int aLen, int b[], int bLen, int result[])
{
    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i = 0; // 记录当前存储位置，当前比较最小的那个值应该存储到新数组的哪个位置
    
    // 任一数组没有到达边界则进行遍历，p,q都不能超过本身数组的长度
    while (p < aLen && q < bLen) {
        // 如果a数组对应位置的值小于b数组对应位置的值，就要把a数组的元素放入合并结果中，同时移动a数组
        if (a[p] <= b[q]) {
            // 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        }
        else{//如果a数姐对应的元素大于b数组元素，则把b数元素存到新数组中，同时移动b数组的下一个元素
            // 存储b数组的值
            result[i] = b[q];
            // 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余，因为上面 while (p < aLen && q < bLen) ，是与，所以这里肯定会有余下的情况
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面，移动a数组的指针
        result[i] = a[p++];
        i++;
    }
    
    // 如果b数组有剩余
    while (q < bLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}

@end

使用：
-(void)math
{
   int a[5] = {1,4,6,7,9};
   int b[8] = {2,3,5,6,8,10,11,12};
   int result[13];
   mergelist(a,5,b,8,result);
}




13-4 Hash算法相关面试问题

NSString转char*
NSString * str＝ @“Test”;
const char * a =[str UTF8String];

不是让你写一个hash算法或它的概念，而是一个应用声景

在一个字符串中找到第一个只出现一次的字符？
输入'abaccdeff' 输出结果为'b'

思路：
字符(char)是一个长度为8的数据类型，因此对应的ascii码值总共有256种可能，即字母a，对应的是97  逗号对应的是。。
每个字母对应的ascii码值作为数组的下标对应数组的一个数字。建立了字母本身和它存储位置的一个映射关系
数组中存储的每个字符出现的次数，哪个字符出现的次数为1，就可以找到结果。

哈希表的概念
例：给定值是字母a，对应ascii值是97,数组索引下标为97
ascii通过hash实现的 a -> f(a) ->97 
可通过hash函数找到字符所对应的存储位置


代码：

HashFind.h
#import <Foundation/Foundation.h>

@interface HashFind : NSObject

// 查找第一个只出现一次的字符,输入一个字符指针，返回每一次出现的字符
char findFirstChar(char* cha);

@end


HashFind.m
#import "HashFind.h"

@implementation HashFind

//"abaccdeff";
char findFirstChar(char* cha)
{
    char result = '\0';//初始化为空字符
    // 定义一个数组 用来存储各个字母出现次数，长度为256的字符，存每一个字母出现次数
    int array[256];
    // 对数组进行初始化操作，每一个值0
    for (int i=0; i<256; i++) {
        array[i] =0;
    }
    // 定义一个指针 指向当前字符串头部
    char* p = cha;
    // 遍历每个字符
    while (*p != '\0') {//遍列直到字符为空作为退出条件
        // 在字母对应存储位置 进行出现次数+1操作
        array[*(p++)]++;//p指向的这个字符作为数组的索引下标，作次数加加操作，之后再作p指针向后移动p++操作 完成之后就存储了每一个字母的出现次数
        //实现的效果为array[97]=1
    }
    
    // 将P指针重新指向字符串头部
    p = cha;
    // 遍历每个字母的出现次数
    while (*p != '\0') {
        // 遇到第一个出现次数为1的字符，打印结果，根据当前字母的ascii值去找当前字母的次数值
        if (array[*p] == 1)
        {
            result = *p;//找到就把结果返回*ascii码则返回字母
            break;
        }
        // 反之继续向后遍历
        p++;
    }
    
    return result;
}

@end


使用：
-(void)math
{
   char cha[] = "abaccdeff";
   char fc = findFirstChar(cha);
   printf("%c\n",fc);
}



13-5 查找两个子视图的共同父视图算法相关面试问题

viewA  viewB 查找两个视图的共同父视图

思路：记录viewA的所有父视图 superView->superView->nil
把所有父视图查找出来放到一个数组里保存
再查找b的父视图并保存到另一个数组里保存
倒序的方式比较superview是不是一样的，如果比较一样的父视图，再遍历下一个进行比较
直到比较到不一样的父视图，那它们前面的所有父视图则是共同父视图

代码如下：

CommonSuperFind.h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonSuperFind : NSObject

// 查找两个视图的共同父视图
- (NSArray<UIView *> *)findCommonSuperView:(UIView *)view other:(UIView *)viewOther;

@end






CommonSuperFind.m
#import "CommonSuperFind.h"

@implementation CommonSuperFind

- (NSArray <UIView *> *)findCommonSuperView:(UIView *)viewOne other:(UIView *)viewOther
{
    NSMutableArray *result = [NSMutableArray array];
    
    // 查找第一个视图的所有父视图 保存到数组中
    NSArray *arrayOne = [self findSuperViews:viewOne];
    // 查找第二个视图的所有父视图
    NSArray *arrayOther = [self findSuperViews:viewOther];
    
    int i = 0;
    // 越界限制条件
    while (i < MIN((int)arrayOne.count, (int)arrayOther.count)) {
        // 倒序方式获取各个视图的父视图
        UIView *superOne = [arrayOne objectAtIndex:arrayOne.count - i - 1];
        UIView *superOther = [arrayOther objectAtIndex:arrayOther.count - i - 1];
        
        // 比较如果相等 则为共同父视图
        if (superOne == superOther) {
            [result addObject:superOne];
            i++;
        }
        // 如果不相等，则结束遍历
        else{
            break;
        }
    }
    
    return result;
}

- (NSArray <UIView *> *)findSuperViews:(UIView *)view
{
    // 初始化为第一父视图
    UIView *temp = view.superview;
    // 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    while (temp) {
        [result addObject:temp];
        // 顺着superview指针一直向上查找
        temp = temp.superview;
    }
    return result;
}


@end



13-6 求无序数组当中的中位数算法相关面试问题

排序算法+中位数
利用快排思想（分治思想）也可实现，加分

排序算法+中位数：
冒泡排序 快速排序 堆排序

中位数： 当n为奇数的时候，(n+1)/2; 中间数加1
        当n为偶数的时候，(n/2+(n/2 +1))/2; 中间两个数的一半为中位数
        
求中位数需要先排序，如总共有n个数,奇数，它的中位数就是中间数加1，如果是偶数，它的中位数为中间两个数的和除以2
       
例1
找出这组数据：23、29、20、32、23、21、33、25 的中位数。
解：
首先将该组数据进行排列（这里按从小到大的顺序），得到：
20、21、23、23、25、29、32、33
因为该组数据一共由8个数据组成，即n为偶数，故按中位数的计算方法，得到中位数  ，即第四个数和第五个数的平均数。（23+25）／2

例2
找出这组数据：10、20、 20、 20、 30的中位数。
解：
首先将该组数据进行排列（这里按从小到大的顺序），得到：
10、 20、 20、 20、 30
因为该组数据一共由5个数据组成，即n为奇数，故按中位数的计算方法，得到中位数为20，即第3个数。


利用快排的思想：
选取关键字，实现指针的高低交替扫描，实现快排

  12    3   10   8   6  7   11   13    9
low指针                               high指针

 两个指针往里遍列
 选择一个关键字如121
 low指针找到比关键字大的第一个数字，那该指针指向的数据就和此关键字的位置进行交换
 high指针找到比交键字小的第一个数字，那该指针指向的数据就和此关键字的位置进行交换
 
 
 任意挑一个元素，以该元素为支点，划分集合为两部分，支点元素则为关键字
 
 如果左侧集合长度恰为(n-1)/2，那么支点恰好为中位数
 如果左侧长度<(n-1)/2，那么中位数在支点右侧，反之在左侧
 进入相应的一侧继续寻找中位数
 
 
 
 代码：
 
  MedianFind.h
 #import <Foundation/Foundation.h>

@interface MedianFind : NSObject
// 无序数组中位数查找
int findMedian(int a[], int aLen);

@end



 MedianFind.m
 
 
#import "MedianFind.h"

@implementation MedianFind

//求一个无序数组的中位数
int findMedian(int a[], int aLen)
{
    int low = 0;
    int high = aLen - 1;//指向数组的一个元素
    
    int mid = (aLen - 1) / 2;//中位点位置
    int div = PartSort(a, low, high);//快排返回支点
    
    while (div != mid)
    {
    //如果左侧长度<(n-1)/2，那么中位数在支点右侧，反之在左侧
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

//快排  数组 高低指针
int PartSort(int a[], int start, int end)
{
    int low = start;
    int high = end;
    
    //选取结尾元素作为关键字
    int key = a[end];
    
    while (low < high)
    {
        //左边找比第一个key大的值，移动
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        //右边找比key小的值
        while (low < high && a[high] >= key)
        {
            --high;
        }
        
        if (low < high)
        {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high]; 
            a[high] = temp;
        }
    }
    //high指针所指元素和low指针所指元素结尾对换
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;//把low这个作为支点返回给调用方
}

@end


使用：
-(void)math
{
 // 无序数组查找中位数
    int list[10] = {12,3,10,8,6,7,11,13,9};
    // 3 6 7 8 9 10 11 12 13
    //         ^
    int median = findMedian(list, 10);
    printf("the median is %d \n", median);
}



 第十四章  框架方面面试题
 
 14-1 AFNetworking第三方库相关的面试问题
 
 AFNetworking
 SDWebImageView
 Reactive Cocoa
 AsyncDisplayKit 性能优化方面的第三方库
 
  AFNetworking
  
   AFNetworking的整体框架怎样的？
   
   
   第一层：
   会话部份：NSUrlSession
   网络监听模块：监听网络的变化
   网络安全模块：网络安全方面
   
   第二层：
   请求序列化：对请求进行了一个请求序列化的封装
   响应序列化：对响应进行了一个响应序列化的封装
   
   第三层：
   uikit集成模块：uikit原生控件分类的添加
   
   主要类关系图
   
   AFURLSessionManager 核心类
   AFURLSessionManager 包含以下内容：
   NSURLSession:会话模块
   AFSecurityPolicy:保证安全，如网络证书校验，公钥的验证
   AFNetworkReachabilityManager:对网络连接的一个临听，与苹果提供的Reachabilit是一样的
   
   AFHTTPSessionManager 继承于核心类的子类， 使用频率最高
   AFHTTPSessionManager包含以下内容：
   AFURLRequestSerialzation:根据传递进来的参数组装拼接，最终转化成NSMutableRequest
   AFURLResponseSerialzation:负责响应序列化的，对网络的返回结果进行解析，如返回的json字符串，可能会调用系统的json库,或者imagewithdata，产生uiimage
   
   AFURLSessionManager主要负责哪些工作：
   1：创建和管理NSURLSession,以及调用系统的api来生成NSURLSessionTask
   NSURLSessionTask实际上可以理解为对应一个网络请求
   2：实现NSURLSessionDelegate等协议以及代理方法，处理网络请求过程中涉及重定向，认证，以及网络响应处理
   3:引入AFSecurityPolicy保证安全，比如发送https请求时，涉及证书校验，公钥验证过程
   4:引入AFNetworkReachabilityManager监听网络状态，根据状态进行相关逻辑处理
   
   发送一个get请求对源码进行讲解：
   方法1：
   - (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE;
   
   参数：url请求地址  要传递的url参数  成功block  失败block
   
   
   方法1内部调用了另一个方法：多了一个参数，downloadProgress一个上报进度的block
     方法2： - (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                   progress:(void(^))(NSProgress *_Nonnull)downloadProgress
                      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE;


    方法2内部调用了一个方法3,产生一个urltask：
    方法3:NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                    URLString:URLString
                                                   parameters:parameters
                                               uploadProgress:nil
                                             downloadProgress:downloadProgress
                                                      success:success
                                                      failure:failure];
    [dataTask resume];//开始一个网络请求
     return dataTask;//urltask返回给调用方
     
     方法3内部逻辑：
     - (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    //调用self.requestSerializer对请求进行序列化 根据url 请求方式 参数 生成一个NSMutableURLRequest，它的内部就是生成一个NSMutableURLRequest，对NSMutableURLRequest进行参数添加封装，把网络请求的参数字符串封装了
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }

        return nil;
    }

    __block NSURLSessionDataTask *dataTask = nil;
    //根据request生成最终的dataTask，返回给调用方，内部[self.session dataTaskWithRequest:request]生成一个datatask,给datatask设置代理
    //alloc一个AFURLSessionManagerTaskDelegate类，封装我们代理的一个回调 [self setDelegate:delegate forTask:dataTask];绑定一个datatask
    //具体绑定以key value形式 task.tasIdentifier为key value为delegate,回调的时候就可以根据task.tasIdentifier的delegate处理网络的一个响应结果。
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];

    return dataTask;
}

相关章节如下：

77、https
简化版
客户端发请求服务器，服务器最开始有私钥和公钥，私钥保存，只把公钥放到一个证书中，这个证书是受保护空间中的，证书是购买的，客户端需要选择是否安装这个证书，并信任它，如
果客户端信任，就建立了一个受保护层，服务器就可以在这个保护层把数据传给客户端
这个证书先客户端安装，安装后传的请求参数都通过这个证书的公钥进行了加密，发给服务器，服务器通过自己的私匙解密，然后把返回的数据通过私钥加密，发给客户端
客户端再通过公钥对这个服务器返回的数据解密
ssl或tls层是介于http与tcp层中间的，
复杂版 传输过程中传输内容都需要用hash加密，防止被更改
1、客户端把支持的协议版本，比如TLS 1.0版，客户端生成的随机数，支持的加密方法，压缩方法，信息发给服务器，
2、服务器有一个私钥，一个公钥，这时服务器生成一个随机数
，把这个随机数，还有公钥放到证收中，传给客户端，（像银行需要确认客户是否安全，这里可以发送一个正式客户提供USB密钥，里面就包含了一张客户端证书。密钥对了才能继续操作）
3、客户端安装信任证书后，再生成一个随机数，加上之前生成的随机数，和服务器发过来的随机数，结合这个证书的公钥
把请求参数加密，发给服务器，
4、服务器根据三个随机数，和私钥进行解密，再把返回的数据通过三个随机数，和私钥加密返回给客户端，(这里握手成功后一般可以用对称加密处理，因为已经认证了安全性，所以对称加密耗时更少)
5、客户端再通过三个随机数和证书中的
公钥解密数据。

如果是自签名没花钱买的证书，会弹一个框，提示不一定安全
有些网站不会询问你是否安装证书，因为这是强制安装的

//忽略host方式，可支持ip访问
[httpClient.requestSerializer setValue:httpClient.baseURL.host forHTTPHeaderField:@"host"];

urlsession的https方式，在代理方法中写上安装证书，信任证书的代码
afnetworking的https也是设置如域名信任，安装证书的代码就行，不需要作其它处理
   非对称加密算法：RSA, DSA/DSS
   对称加密算法： AES, 3DES
   HASH算法：MD5, SHA1, SHA256

服务器端会向CA申请认证书，此证书包含了CA及服务器端的一些信息（可以理解为类似公章），这样，服务器端将证书发给客户端的过程中，中间方是无法伪造的，保证了，发给客户端的公钥是服务器端发送的。

网络专业版：
1 客户端发起一个https的请求，把自身支持的一系列Cipher Suite（密钥算法套件，简称Cipher）发送给服务端

 

2  服务端，接收到客户端所有的Cipher后与自身支持的对比，如果不支持则连接断开，反之则会从中选出一种加密算法和HASH算法

   以证书的形式返回给客户端 证书中还包含了 公钥 颁证机构 网址 失效日期等等。

 

3 客户端收到服务端响应后会做以下几件事

    3.1 验证证书的合法性    

　　  颁发证书的机构是否合法与是否过期，证书中包含的网站地址是否与正在访问的地址一致等

        证书验证通过后，在浏览器的地址栏会加上一把小锁(每家浏览器验证通过后的提示不一样 不做讨论)

   3.2 生成随机密码

        如果证书验证通过，或者用户接受了不授信的证书，此时浏览器会生成一串随机数，然后用证书中的公钥加密。 　　　　　　

    3.3 HASH握手信息

       用最开始约定好的HASH方式，把握手消息取HASH值，  然后用 随机数加密 “握手消息+握手消息HASH值(签名)”  并一起发送给服务端

       在这里之所以要取握手消息的HASH值，主要是把握手消息做一个签名，用于验证握手消息在传输过程中没有被篡改过。

 

4  服务端拿到客户端传来的密文，用自己的私钥来解密握手消息取出随机数密码，再用随机数密码 解密 握手消息与HASH值，并与传过来的HASH值做对比确认是否一致。

    然后用随机密码加密一段握手消息(握手消息+握手消息的HASH值 )给客户端

 

5  客户端用随机数解密并计算握手消息的HASH，如果与服务端发来的HASH一致，此时握手过程结束，之后所有的通信数据将由之前浏览器生成的随机密码并利用对称加密算法进行加密  

     因为这串密钥只有客户端和服务端知道，所以即使中间请求被拦截也是没法解密数据的，以此保证了通信的安全

客户端如何验证 证书的合法性？

 

1. 验证证书是否在有效期内。

　　在服务端面返回的证书中会包含证书的有效期，可以通过失效日期来验证 证书是否过期

2. 验证证书是否被吊销了。

　　被吊销后的证书是无效的。验证吊销有CRL(证书吊销列表)和OCSP(在线证书检查)两种方法。

证书被吊销后会被记录在CRL中，CA会定期发布CRL。应用程序可以依靠CRL来检查证书是否被吊销了。

CRL有两个缺点，一是有可能会很大，下载很麻烦。针对这种情况有增量CRL这种方案。二是有滞后性，就算证书被吊销了，应用也只能等到发布最新的CRL后才能知道。

增量CRL也能解决一部分问题，但没有彻底解决。OCSP是在线证书状态检查协议。应用按照标准发送一个请求，对某张证书进行查询，之后服务器返回证书状态。

OCSP可以认为是即时的（实际实现中可能会有一定延迟），所以没有CRL的缺点。

 

3. 验证证书是否是上级CA签发的。


windows中保留了所有受信任的根证书，浏览器可以查看信任的根证书，自然可以验证web服务器的证书，
是不是由这些受信任根证书颁发的或者受信任根证书的二级证书机构颁发的（根证书机构可能会受权给底下的中级证书机构，然后由中级证书机构颁发中级证书）
在验证证书的时候，浏览器会调用系统的证书管理器接口对证书路径中的所有证书一级一级的进行验证，只有路径中所有的证书都是受信的，整个验证的结果才是受信
 

44、AFNetworking3.0后为什么不再需要常驻线程？
AFNetworking3.0不再使用NSURLConnection，因NSURLConnection需要一条线程负责等待代理方法回调并处理数据，所以使用了
NSURLSession
self.operationQueue = [[NSOperationQueue alloc] init];
self.operationQueue.maxConcurrentOperationCount = 1;
self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:self.operationQueue];
从上面的代码可以看出，NSURLSession发起的请求，不再需要在当前线程进行代理方法的回调！可以指定回调的delegateQueue，这样我们就不用为了等待代理回调方法而苦苦保活线程了。
指定的用于接收回调的Queue的maxConcurrentOperationCount设为了1，这里目的是想要让并发的请求串行的进行回调。
为什么要串行回调？
//线程的安全性
- (AFURLSessionManagerTaskDelegate *)delegateForTask:(NSURLSessionTask *)task {
    NSParameterAssert(task);
    AFURLSessionManagerTaskDelegate *delegate = nil;
    [self.lock lock];
    //给所要访问的资源加锁，防止造成数据混乱
    delegate = self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)];
    [self.lock unlock];
    return delegate;
}

NSURLConnection

NSURLSession 的优势

NSURLSession 支持 http2.0 协议  主要是因为它改变了客户端与服务器之间交换数据的方式，
HTTP 2.0 增加了新的二进制分帧数据层改进传输性能，实现低延迟和高吞吐量

在处理下载任务的时候可以直接把数据下载到磁盘

支持后台下载|上传

同一个 session 发送多个请求，只需要建立一次连接（复用了TCP）

提供了全局的 session 并且可以统一配置，使用更加方便

下载的时候是多线程异步处理，效率更高





14-2 SDWebImage第三方库相关面试问题

一个异步下载图片并且支持缓存的框架

它的架构简图？
其实封装得更多的是一些uikit的分类方法,如uiimageview setimageurl就可以下载一个图片

第一层：uikit的一些会类
UIImageView+webCache
第二层：
SDWebImageManager核心类，一个管理者，管理下载，缓存的调度
第三层：
SDImageCache 负责图片缓存，磁盘缓存，内存缓存
SDWebImageDownloader 图片下载器

加载图片流程是怎样的？
请求url作为key，查找内存缓存
没找到 找磁盘
如果未找到 发送网络请求下载图片
下载好后放入内存 再放入磁盘



14-3 ReactiveCocoa第三方库相关的面试问题

函数响应式编程框架：

信号 订阅 两个概念
rac是一个函数响应式编程，涉及到信号和订阅，可订阅一个信号

reactivecocoa中的核心类racsignal信号
racsignal继承于racstream
racsignal的子类有四个：
1。racdynamicsignal：一般racsignal的creatsignal会生成这个类，动态信号
2。racreturnsignal:这个信号比较简单
3。racemptysignal:
4.racerrorsignal:

racstream有哪些组成：
第一层：它的抽象方法如下，不能直接使用：
empty：空
return：返回
bind：绑定
concat：连接
zipwith
第二层：它的分类方法，对第一层抽象方法逻辑组合成下面内容，调用不同信号如map,take产生不同逻辑
map:
take:
skip:
ignore:
filter:

信号怎么理解：
信号代表一连串状态：
如信号由1状态切到2状态再切到3状态
在状态改变时，对应的订阅者racsubscriber就会收到通知执行相应的命令


代码解析racreturnsignal racdynamicsignal来帮助理解什么是信号

在racsignal类有一个createsignal方法，返回一个具体的子类信号如racdynamicsignal
涉及到一个概念类触，所以创建方法返回的信号都是一个抽象的信号，但创建的方法方式不一样

racdynamicsignal的创建把传进来的一个block参数作为信号的一个成员变量保存起来，并把信号作为简单返回

racreturnsignal的创建，覆写return方法，把传递进来的id对象进行包装，返回
就是把一个oc对象封装成一个信号返回给调用方


订阅

racsubscriber 订阅者

开始订阅一个信号 racsignal，调用subscribenext方法后，这个函数内
部就会产生一个racsubscriber类对象，会调用一个racsignal的sendnext方法
进行具体的逻辑执行,sennext又会调用sencompleted，然后结束订阅流程

racsubscriber内部原理：

当产生一个racsubscriber类时，会产生一个didsubscribe对象，
当调用racsignal的racsubscriber时，内部会执行内部保存的block

看如下代码段：
[racsignal return:@3];//产生的是一个信号对象
[racsignal subscribednext:^(id x){//创建了一个订阅者，把nextbllock和其它block作为成员变量绑定到信号中，返回给调用方
  打印的x为3
}]

racsignal调用subscribednext  实际上就是racsignal调用了sendnext方法，这个方法其实就是对
nextblock进行调用。


14-4 AsyncDisplayKit第三方库相关面试问题&总结

提升ios界面渲染的一个框架

主要解决哪些问题？
layout 解决布局耗时运算
文本宽高计算
视图布局计算 
从主线程到子线程去计算

渲染
文本渲染
图片解码
图形绘制

uikit对象创建
对象创建
对象调整
对象销毁

放到子线程作

把主线程中的压力都放到子线程中去作。


基本原理是怎样的？

系统：
uiview作为calayer的一个delegate
calyer作为uivew的一个成员变量作为视图展示工具

框架在此之上封装了一个asnode
它中有一个.view成员变量生成一个uiview
每个view都有一个.node属性可获取到它所对应的节点

产生的节点asnode就是放到后台线程处理的，
而系统部份是在主线程处理

asnode对uiview作了一个包装，所以渲染，对象创建都通过asnode
放到子线程中去作

基本原理：
uivew的修改都变成，针对asnode的修改和提交，会对其进行封装并提交到一个全局容器当中，
asnode监听runloop的beforewating通知，注册一个观察者observer对通知进行观察
当runloop休眠前，runloop发送通知后，asdk就把容器中的asnode提取出来，再把它的一些属性设置设置给uiview


总结：
afnetworking是怎样的，可通过架构图进行描述
sdwebimage框架是怎样加载图片的
sdwebimgage关于内存的设计是怎样的？最近最久未使用算法等
rac中的信号订阅是什么意思？信号是一连串状态抽象 订阅是一个block作为信号的成员最终调用block
askd实现原理，封装asnode节点，对一些属性的设置都转化成asnode，放到后台线程实现，runloop将结束的时候
接收到通知，从全局容器中提取asnode，并把属性设置到视图中。


第15章  课程全面总结

ui视图
tableview重用机制 ui视图绘制原理 如何异步绘制 离屏渲染
oc语言
kvo实现原理 分类实现原理  关联对象技术实现原理
runtime 
对象 类对象 元类对象 消息传递机制 消息转发机制
内存
arc weak指针内部实现原理
block
block实现本质  调用 截获变量特性 __block 含义本质
多线程
多线程实现技术方案 
runloop 为什么有事作事，没事休息。
网络  解决dns截持 https连接建立流程 tcp udp http
设计模式 责任链 桥接 单例
架构  如何设计复杂页面  客户端架构  图片缓存框架
算法  查一个字符串中和一个出现一次的字符
第三方库 最常问的afnetworking sdwebimage rac asdk比较针对性
常考：
系统ui事件传递机制是怎样的？
kvo的实现原理 isa混写技术的实现
runtimer 消息传递机制转发流程是怎样
当一个对象不用了，指向它的weak指针为何置为nil了
ios中是怎样进行内存管理的
block的实质是怎么样的？使用block为何产生循环引用
怎样用gcd实现多读单写
runloop为何能做到有事做事，没事休息？发生了用户态到核心态切换
解决dns劫持 常连接 httpdns解决
什么是桥接，责任链
怎样设计一个图片缓存框架？怎样设计一个网络框架
算法，查找一个字符串中出现一次字符的算法。是hash算法
afnetworking大致怎样实现的




              
            
                  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
            
         
          
         
 






 
 
 
 
 
 
 

 





