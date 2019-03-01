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
如果next是指向了栈顶，增加一个autoreleasepool节点拼结到链表上，在新的栈上去添加对象，并把next向上移动。


autoreleasepoolpage::pop的内部实现：
根据传入的哨兵对象（要释放的对象）找到对应对象在栈中的位置。然后给上次push操作之后添加的对象依次发送
release消息。回退next指针到正确的位置，即next指针下移致力正确位置


什么情况下需要我们手动创建autoreleasepool呢？
在for循环中alloc出大量的图片数据，这些数据对内存消耗非常大，需要在for循环内部创建一个autoreleasepool
每一次for循环都对内存进行一次释放

autoreleasepool的实现原理是怎样的？
就是以栈为节点通过双向链表组成的数据结构





            
            