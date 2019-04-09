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


总结：

UITableView只有当视图所有都在屏幕外，才会放到重用池中，滑动的时候只要有cell一部份在屏幕上，都会去重用池中找内存，进行复用。


重用池是两个队列：等待使用的队列  使用中的队列
从重用池当中取出一个可重用的view：从等待使用的队列中拿出一个view，如果view为nil，则return nil，否则放到正在使用的队列中，并移除掉等待使用的队列中的nil
- (void)addUsingView:(UIView *)view：如果参数view不为空，就添加view到正在使用中的队列中。
- (void)reset：把正在使用中的队列里的view移除掉，添加到等待使用的队列中


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

总结：
方案1:主线程在删除操作前已经复制了一份数据给子线程，子线程网络请求到新数据并合并当前复制的数据，当主线程删除某一数据后，子线程合并的数据又刷新了ui，造成之前删除的那条数据又出现了，这种情况最好就是记录当前
删除了哪些数据，在子线程新数据到来时，再把之前删除的数据记录从这个子线程新数据中清除，再更新ui。缺点会对内存有一定的开销。

方案2:把任何操作的指令都放入队列中，队列中的任务执行完成后再刷新ui，缺点会有删除延时。

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
把任何操作的指令都放入队列中，队列中的任务执行完成后再刷新ui，缺点会有删除延时。
1。子线程，在进行网络请求和数据解析
2。子线程作完请求和数据解析后放入到串行对列，对这些数据进行排版
3。主线程此时要删除一行数据，把这个操作放到串行队列当中，等待子线程数据排版完成
后才会同步数据删除，再readui

方案1对内存的开销会有一定影响，方案2删除需要等子线程数据先排版，会有删除延时




3-3 UI事件传递&响应 相关面试问题

总结：
uiview为layer提供显示的数据，同时负责处理触摸事件，参与响应链
layer中包含calayer，calayer中有contents，对应的backing store其实是一位图，负责最终显示到屏幕上的控件。
uiview的backgrondcolor属性其实是对calayer显示属性方法的包装
单一设计原则，uiview和layer，职责上的分工。
事件传递的两个方法：
hitTest：返回响应事件的那个视图
pointInside：点击位置如果在视图范围内，就返回yes



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
    
    //计算当前点击的这个点距离方形中心的实际距离 sqrt(5) 开平方是2.22
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

总结：cpu 对视图或文字高度计算布局，然后calayer的contents属性中包含了最终要绘制到屏幕上的内容，系统合适的时机回调drawrect方法，drawrect方法中
又可以添加绘制的其它内容，然后cpu作一些准备绘制的工作如图片解码编码，经过core animation框架，把位图数据提交给gpu，gpu的opengl es渲染管线进行
渲染和纹理合成，这后把结果放到帧缓冲区中，由视频控制器在指定时间去提取帧缓冲区中的内容显示在屏幕上。

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
当前屏幕渲染，gpu的渲染操作是在当前用于显示的屏幕缓冲区中进行
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
总结： objectForKey: 返回指定 key 的 value，若没有这个 key 返回 nil.不会返回异常
      valueForKey：找getkey，iskey,key方法，所果有此方法返回value，如果没有，找判断实例变量是否存在的方法，如果有key,iskey,_key，则返回value
      没有则调用valueforundefinedkey返回异常

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

总结：

只要用mutablecopy拷贝的对象都是可变对象
copy拷贝出来的任何对象都是不可变对象
copy拷贝不可变对象为浅拷贝，除此情况外的拷贝都是深拷贝

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


深浅拷贝：
mutablecopy 拷贝的所有对象都是深拷贝
copy 与的概念拷贝不可变对象浅拷贝，其它为深拷贝

可变不可变：
copy 拷贝的所有对象都不可变
mutablecopy 拷贝的所有对象都是浅拷贝

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

运行时语言：将某个函数的决议推迟到运行时
编译时语言：函数已经在编译期生成，在编译期执行哪个函数，在运行期无法修改。


2。消息传递与函数调用之间有什么区别？
在编译器的处理过程之后，objc_msgsend第一个参数obj ，第二个参数为foo的选择器，编译后就转化为函数调用了，然后进行runtime的消息传递流程


3.当一个方法没有实现的时候，系统是怎样实现消息转发过程的？
  当调用一个未实现的对象方法，或者未实现的类方法，会消息转发
  第一次机会：类方法调用解决类方法的函数，对象方法调用解决实例方法函数，函数返回yes，为其内部添加实现的方法，代码不报异常，表未已经处理了这个未找到的方法
  第二次机会：解决实例方法返回no，此时系统调用为选择器转发目标函数，返回值是nil或一个对象，返回一个对象，即把未实现的方法交给这个对象实现，返回nil，则系统调用第三次机会的处理函数
  第三次机会：为选择器方法签名的函数，此时如果返回方法签名。如告诉系统交由某个对象去处理这个方法，此时会调用转发调用函数，这个函数可打印错误的日志，如果返回nil，不再调用转发调用函数，系统会认为此条消息无发处理，则会闪退，抛出未识别的选择器

想要得到上面答案，
从runtime的数据结构学起？

类对象与元类对象分别代表什么？
  类对象存储了该对象的所有方法列表，元类对象存储了所有类方法的方法列表
  
实例与类对象之间的关系？
  实例的isa指针指向类对象
  
类对象与元类对象之间的关系？
   类对象是元类对象的一个实例如uiview *v ，v的类对象是uiview，元类对象的实例是uiview，元类对象存储了类方法列表

消息传递机制是怎样的？
   消息查找的流程：在缓存中查找，在类对象中查找，如果是类方法，在元类对象中查找，元类对象存储了所有类方法，如果未找到在superclass指向的父类中查找，
   再到根类中查找，根类superclass指向nil，未找到进入消息转法流程。查找使用已经排序好的方法列表，用二分法，未排序好的列表，遍列查找。
   
   
消息传递过程中，如何进行缓存的方法查找？
  消息缓存查找流程和步骤：以方法选择器的名称，用hash函数，找出bucket水桶类，并找出index，找到这个类中存方了该方法的实现
  
消息转发流程是怎样的？
  当调用一个未实现的对象方法，或者未实现的类方法，会消息转发
  第一次机会：类方法调用解决类方法的函数，对象方法调用解决实例方法函数，函数返回yes，代码不报异常，表未已经处理了这个未找到的方法
  第二次机会：解决实例方法返回no，此时系统调用为选择器转发目标函数，返回值是nil或一个对象，返回一个对象，即把未实现的方法交给这个对象实现，返回nil，则系统调用第三次机会的处理函数
  第三次机会：为选择器方法签名的函数，此时如果返回方法签名。如告诉系统交由某个对象去处理这个方法，此时会调用转发调用函数，这个函数可打印错误的日志，如果返回nil，不再调用转发调用函数，系统会认为此条消息无发处理，则会闪退，抛出未识别的选择器

method-swizzling 方法混xiao  在运行时去替换一些方法的实现？
  动态容器一般链表实现的，在增删改的时候，会去判断如果不为nil就存放到这个容器中，为此可实现一个分类，当用addobject方法时，替换掉它的实现，在里面判断是否为nil
  两种交换方式：
  1：
   //获取test方法的结构体
    Method test = class_getInstanceMethod(self,@selector(test));
    //获取otherTest方法的结构体
    Method otherTest = class_getInstanceMethod(self,@selector(otherTest));
    //交换两个方法的实现
    method_exchangeImplementations(test,otherTest);
    
   2：

    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];//交换这个方法
    });
    
    
动态添加方法，动态方法解析？

   performSelector这个去调用一个test方法，如果未在.h中声明此方法，调用时xcode不会提示报错，运行时才会提示
   而[self test]直接会提示报错
   在消息转发流程解决实例方法函数中添加如下代码去处理，调用test的时候就会执行testImp。
   class_addMethod(self, @selector(test), testImp, "v@:");



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
总结：类对象存储所有对象方法 元类对象存储所有类方法  类对象的isa指针指向当前类对象，uiview* v ,v的isa指向uiview ，元类对象无论是子元类，还是元类它的
isa指针指向根元类对象，根元类对象的isa指针指向它本身，但无论是类对象，还是元类对象，它们的superclass指针都指向了父类，uiview所属objc_class,
objc_class又继承自objc_object，objc_object包含了所有的属性，方法，分类方法，协议等内容。objc_class里面主要有superclass指针。
[self class]会转成void objc_msgSend(void/*id self, SEL OP,...*)  会从当前类对象去查找方法，消息接收者为self
[super class]会转成void objc_msgSendSuper(void/*struct objc_super *super,SEL op,...*) 会从当前类的父类对象去查找方法，消息接收者为self


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

总结：
消息缓存查找流程和步骤：以方法选择器的名称，用hash函数，找出bucket水桶类，这个类中存方了该方法的实现
消息查找的流程：在缓存中查找，在类对象中查找，如果是类方法，在元类对象中查找，元类对象存储了所有类方法，如果未找到在superclass指向的父类中查找，
再到根类中查找，根类superclass指向nil，未找到进入消息转法流程。查找使用已经排序好的方法列表，用二分法，未排序好的列表，遍列查找。


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
总结：
  当调用一个未实现的对象方法，或者未实现的类方法，会消息转发
  第一次机会：类方法调用解决类方法的函数，对象方法调用解决实例方法函数，函数返回yes，代码不报异常，表未已经处理了这个未找到的方法
  第二次机会：解决实例方法返回no，此时系统调用为选择器转发目标函数，返回值是nil或一个对象，返回一个对象，即把未实现的方法交给这个对象实现，返回nil，则系统调用第三次机会的处理函数
  第三次机会：为选择器方法签名的函数，此时如果返回方法签名。如告诉系统交由某个对象去处理这个方法，此时会调用转发调用函数，这个函数可打印错误的日志，如果返回nil，不再调用转发调用函数，系统会认为此条消息无发处理，则会闪退，抛出未识别的选择器
消息转发流程是怎样的：
对于实例消息转发流程，系统会回调：resolveInstanceMethod:
对于类方法消息转发流程，系统会回调：resolveClassMethod:
主要研究实例消息转发流程：
类方法resolveInstanceMethod（解决实例方法）有一个参数sel消息选择器，返回值是bool，告诉系统要不要解决当前实例方法的实现，返回yes，
通知系统消息已经处理，结束消息转发流程，如果说返回no，系统会回调forwardingTargetForSelector:这个方法，给每二次机会
处理消息。、
第二次处理机会：
forwardingTargetForSelector:（转发目标选择器）参数也是sel，返回值id,告诉系统这次系统实例的方法调用应该由哪个对象来处理，如果指定转发目标，系统
会把这条消息指定给此转发目标，系统结束消息转发流程，如果每二次机会返回nil，未给转发目标，系统会给我们第三次处理消息的机会，系统会调用
methodSignatureForSelector:（方法签名选择器）
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











5-6 Method-Swizzlin（方法飞溅）相关面试问题

总结：
使用场景1:ios可变容器内部是一个链表，在进行增删改容器的时候，如果是nil，会闪退
  if (obj) {
        [dic setObject:obj forKey:@"key"];
    }
会写很多这样的代码
通过这个方去可这样处理：
在分类中
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];//交换这个方法
    });
}
- (void)safeAddObject:(id)anObject
{
    if (anObject) {
        [self safeAddObject:anObject];
    }else{
        NSLog(@"obj is nil");

    }
}

使用场景2:NSLOG调用的时候可替换成NSINFOLOG;这个方法中打印时可以再写一些打印的其它内容
两种交换方式：
1：
   //获取test方法的结构体
    Method test = class_getInstanceMethod(self,@selector(test));
    //获取otherTest方法的结构体
    Method otherTest = class_getInstanceMethod(self,@selector(otherTest));
    //交换两个方法的实现
    method_exchangeImplementations(test,otherTest);
    
2：

    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];//交换这个方法
    });
  





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

总结：
performSelector这个去调用一个test方法，如果未在.h中声明此方法，调用时xcode不会提示报错，运行时才会提示
而[self test]直接会提示报错
在消息转发流程解决实例方法函数中添加如下代码去处理，调用test的时候就会执行testImp。
class_addMethod(self, @selector(test), testImp, "v@:");

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
总结：
@property 自动生成get set方法
@synthesize 指定了成员变量，需重写set get 方法。
    如.m中 @synthesize name = _name;  
    - (void)setName:(NSString *)name
    {
       _name = name;
    }
@dynamic 编译时不生成get，set方法， 而是在运行时的时候添加，由用户添加的。
运行时语言：将某个函数的决议推迟到运行时
编译时语言：函数已经在编译期生成，在编译期执行哪个函数，在运行期无法修改。

你使用过@dynamic这个编译器关键字吗？
声明的属性用@dynamic这个关键字修饰的时候，实际上对应的set,get方法不是在编译时去声明好实现的，而是运行时添加的。
考察编译时语言和动态时语言的区别。
动态运行时语言将函数决议推迟到运行时。把一个属性设为@dynamic时，代表在编译时不需要生成get ,set方法实现，而是在
运行时调用get,set方法时再为它添加get,set方法的实现，这只有运行时语言才支持的功能。
编译时语言编译期决译，在编译期执行函数是哪个，运行时是无法进行修改的。

runtime实战问题：
1。[obj foo]向obj对象发送foo这个消息和objc_msgsend()函数之间有什么关系？
在编译器的处理过程之后，objc_msgsend第一个参数obj ，第二个参数为foo的选择器，编译后就转化为函数调用了，然后进行runtime的消息传递流程

2。runtime如何通过selector找到对应的imp地址的？
消息传递机制是查找当前实例对象缓存是否有imp实现，没命中，查当前类方法列表，
如果未找到实现，找当前类父类方法列表的实现，找到就返回方法实现的指针。

3。能否向编译后的类中增加实例变量？
编译后的类，由于runtime支持运行时动态添加类的。
编译后的类，它已经完成了实例变量的布局，class_ro_t已经代表了readonly，所以编译后的类是不能增加实例变量的，
如果是动态添加的类，是可以添加实例变量的。分类中可以添加实例变量，因为分类是在运行时中进行的。



其它：
runtime实现机制是什么，怎么用，一般用于嘛，你还能记得你所使用的相关头文件或者某些方法的名称吗？
回答：运行时机制，runtime库里面包含了跟类/成员变量/方法相关的API,比如获取类里面的所有成员变量，为类动态添加成员变量，动态改变类的方法实现，为类动态添加新的方法等，需要导入<ObJc/message.h>,<objc/runtime>
1>runtime,运行时机制，它是一套C语言库
什么是runtime?
2>实际上我们编写的所有OC代码，最终都是转成了runtime库的东西，比如类转成了runtime库里面的结构体等数据类型，方法转成了runtime库里面的C语言函数，平时调方法都是转成了objc_msgSend函数(所以说OC有个消息发送机制)
3>因此，可以说runtime是OC的底层实现，是OC的幕后执行者
runtime有啥用?
1>能动态产生一个类、一个成员变量、一个方法
2>能动态修改一个类、一个成员变量、一个方法
3>能动态删除一个类、一个成员变量、一个方法
常见的函数、头文件
import  : 成员变量、类、方法
class_copyIvarList : 获得某个类内部的所有成员变量
class_copyMethodList : 获得某个类内部的所有方法
class_getInstanceMethod : 获得某个具体的实例方法(对象方法，减号开头)
class_getClassMethod : 获得某个具体的类方法 （加号）
method_exchangeImplementations : 交换2个方法的实现




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
  总结：
    用非指针型和指针型管理内存，指针型，所有内容表示的只是内存这个地址，非指针型，除了表示内存地址，还表示内存管理方案内容，如有散列表
    中包含的引用计数表和弱引用表。
    sidetable数据结构去存相关引用计数
    
    
问题：ios是怎样对内存进行管理的？
分析：ios会根据不同的场景提供内存管理方案：
答：
比如对一些小对象如nsnumber这种，采用的是taggedpointer（标记指针）管理方案

对于64位架构下的ios程序，采用的是nonpointer_isa（非标记指针）管理方案，在这种架构下，isa指针是是这个比特位的
其实有32个bit位就够用了，其它是浪费的，苹果为了提高这内存的利用率，isa余下的bit位中存储了内存管理相关的内容
所以这叫非指针型isa管理方案。sidetables的本质是一张hash表，有64张sideTable存储。

散列表内存管理方案 散列表是一个复杂的数据结构，其中包括了引用计数表和弱引用表


在后面的小节中关于内存管理源码分析都是基于objc-runtime-680版本讲解



nonpointer_isa（非指针型）管理方案：

在arm64位架构中，一共有64个bit位，

前内存管理存储的前16位：

0  0  0 0  0  0  0  0  0  0  0  0            0                        0                                 0
（            shifcls            ）    （has_cxx_dtor）          （第1位has_assoc）                    （第0位）
如果这里第0位是0，表示此isa指针是一个纯的isa指针，那它其它16位的地址内容就代表了当前纯对象的ios地址
如果第0位是1,就表示它不仅是一个对象地址，里面还包含了一些类对象的管理数据，第1位表示当前对象是否有关联对象，0代表没有，1代表有
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
（has_sidetable_rc当前isa指针当中引用计数如果达上线，需外挂一个sidetable数据结构去存相关引用计数，也就是散列表）       
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

总结：
  自旋锁，线程不断尝试去获取这把锁，轻量级的，如加1操作用的锁，与信号量不同，信号量获取不到锁会休眠，等线程释放锁再唤醒。
  弱引用表也是一张hash表。

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
总结：
  mrc： 
    alloc retain 浅拷贝 引用计数加1 autorelease在autoreleasepool结束的时候调用它的release操作
    retaincount获取对象的引用计数值  dealloc必须有 super dealloc来释放父类的相关成员变量
  arc：
    需要runtime和编译器共同协作才能组成，编译器自动插入retain,release ，retain release retaincount autorelease dealloc会引起编译报错
    dealloc方法，但不能调用super dealloc
    strong alloc 浅拷贝 引用计数加1  weak 引用计数减1，内存释放后设为nil
    assign：在arc和mrc中 用于修饰基本数据类型和oc数据类型的关键字。修饰对象xcode不报错，但会产生野指针，因为对象在堆上。基本数据类型在栈上，由系统自动分配。
  


mrc是手动引用计数进行管理内存
alloc分配一个内存空间  retain 引用计数加1  release引用计数减1
retaincount获取对象的引用计数值   autorelease 这个对象会在autoreleasepool结束的时候调用它的release操作，引用计数减1
dealloc 在mrc当中调用这个需要显示调用 super dealloc来释放父类的相关成员变量


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

总结：
  alloc实现：在retaincount时才引用计数加1 
  引用计数查找：
     第一次：通过hash算法找到sidetable，
     第二次：对象指针在sidetable引用计数表中中获取引用计数成员变量，
     再对引用计数加1
  dealloc实现：
     判断是非指针型的isa ，是否有weak指针，有则将指向该对象的弱引用指针置为nil，是否有关联对象，有则移除关联对象，是否使用c++代码， 是否有额外的引用计数表sidetable，最后才能调用c函数free()
     


实现原理分析：

alloc实现：
经过一系列调用，最终调用了c函数calloc。此时并没有设置引用计数为1，
但retaincount获取的引用计数为1，我们可以看retaincount的实现

retain实现：
    sidetable & table = sidetables()[this];
这是objc680原码，这里是通过当前对象的指针到sidetables中获取它所属的sidetable，关于sidetables是由多个sidetable组成的hash表，可通过hash函数指针
通过hash函数计算，可快速找到对应的sidetable。
size_t& refcntstorage = table.refcnts[this];
在sidetable结构中获取引用计数map的成员变量，通过当前对象的指针在这个sidetable引用计数表中去获取当前对象的引用计
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
 具体通过hash算法查找弱引用表，再找到弱引用数组，把新弱引用指针加入弱引用表
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
  总结：
  runloop将要结束的时候会将上一次autoreleasepool中的对象释放，会调用autoreleastpoolpage::pop方法，会push一个新的autoreleasepool
  为什么autoreleasepool可以嵌套？因为每次autoreleasepool中的代码创建后，会创建autoreleasepoolPage，实现机制是一个双向链表，有多个
  autoreleasepoolPage，就会多次释放。autoreleasepoolPage是和线程一一对应的
  autoreleasepool中的autoreleasepool是双向链表结构，双向链表是头节点的父指针指向nil，子指针指向下一个节点,最后一个节点的子指针指向nil。
  所有的autoreleasepoolPage又放在栈中，所以最后添加的最先弹出栈
  
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
栈是向下增长的，下面低地址，上面是高地址

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
总结：

自循环引用：

类中有一个属性strong修饰，这个属性又=self
相互循环引用：

类a的属性ida=类b
类b的属性idb=类a

多循环引用：
每个类的属性强引用下一个对象，产生多循环



代理：不能用strong，会相互循环。



如何破除循环引用呢：
避免产生循环引用  如代理设为weak
在合适的时机手动断环 


nstimer的循环引用：
nstimer会被runloop强引用，造成不能释放。

nstimer有重复定时器和非重复定时器的区分：
如果创建的这个nstimer是非重复定时器，即只调用一次回调方法，那么会在定时器回调方法中调用nstimer invalidate()方法，停止定时器，然后nstimer=nil
如果创建的这个nstimer是一个重复多产回调方法的定时器，就不能作nvalidate()，nstimer=nil的操作，
解决方案：增加一个中间对象，nstimer不再指向这个obj，而是强引用中间对象，中间对象弱引用nstimer,和obj.  在中间对象的类中，nstimer回调方法中
判断弱引用的obj是否为nil，如果为nil，表示vc控制器消毁，及广告栏消毁，则可在回调方法中设置nvalidate()，nstimer=nil的操作





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
__unsafe_unretained 修饰的关键字是未增加引用计数的  不建议使用

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




GCD全称Grand Central Dispatch  大中央调度 多核编程的解决方案

GCD的任务：
需要执行的代码块，一个方法或一个block

GCD的队列：
串行队列: GCD底层只维护一个线程，任务只能串行依次执行。
并发队列: GCD底层使用线程池维护多个线程，任务可并发执行。

两者都是FIFO 先进先出来管理任务




队列的方法:

//获取当前执行该方法的队列，被废弃了，最好不要使用
dispatch_queue_t dispatch_get_current_queue(void);

/*
主队列是串行队列因为只维护主线程一个线程
*/
dispatch_queue_t dispatch_get_main_queue(void);

/*
获取一个全局的并发队列
identifier指定该队列的优先级可选值有:
    DISPATCH_QUEUE_PRIORITY_HIGH 2
    DISPATCH_QUEUE_PRIORITY_DEFAULT 0
    DISPATCH_QUEUE_PRIORITY_LOW (-2)
    DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
flags未用到传个0得了
*/
dispatch_queue_t dispatch_get_global_queue(long identifier, unsigned long flags);


/*
创建一个队列
label 队列的名称
attr 队列的属性可选值有:
    DISPATCH_QUEUE_SERIAL 创建一个串行队列
    DISPATCH_QUEUE_CONCURRENT 创建一个并发队列
通过这种方式可以自己维护一个队列
*/
dispatch_queue_t dispatch_queue_create(const char *_Nullable label, dispatch_queue_attr_t _Nullable attr);





具体获取相关队列的方法如下:

//获取串行主队列
dispatch_queue_t mainQueue = dispatch_get_mian_queue();

//获取一个默认优先级的并发队列
dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT);

//自定义创建一个名称为myConcurrentQueue的并发队列
dispatch_queue_t myConcurrentQueue = dispatch_queue_create("myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);



同步执行:在当前线程下执行，当前线程其它任务完成才可以执行
异步执行: 在当前线程下开启其他线程来执行任务，不需要等待当前线程任务完成即可执行






任务的相关方法：
/*
以异步方式执行任务，不阻塞当前线程
queue 管理任务的队列，任务最终交由该队列来执行
block block形式的任务，该block返回值、形参都为void
*/
void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);


/*
同上
使用起来不方便，一般不怎么用，需要使用C函数，也可以使用OC方法通过传递IMP来执行但是会有编译警告
context 是一个void*的指针，作为work的第一个形参
work 是一个函数指针，指向返回值为void 形参为void*的函数，且形参不能为NULL，也就是说context一定要传
*/
void dispatch_async_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);


/*
以同步方式执行任务，阻塞当前线程，必须等待任务完成当前线程才可继续执行
*/
void dispatch_sync(dispatch_queue_t queue, DISPATCH_NOESCAPE dispatch_block_t block);

//同上
void dispatch_sync_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);


/*
以同步方式提交任务，并重复执行iterations次
iterations 迭代执行次数
queue 管理任务的队列，任务最终交由该队列来执行
block block形式的任务，该block返回值为void形参为iterations迭代次数
*/
void dispatch_apply(size_t iterations, dispatch_queue_t queue,  DISPATCH_NOESCAPE void (^block)(size_t));

//同上
void dispatch_apply_f(size_t iterations, dispatch_queue_t queue, void *_Nullable context, void (*work)(void *_Nullable, size_t));


/*
以异步方式提交任务，在when时间点提交任务
queue 管理任务的队列，任务最终交由该队列来执行
block block形式的任务，该block返回值、形参都为void
*/
void dispatch_after(dispatch_time_t when, dispatch_queue_t queue, dispatch_block_t block);

//同上
void dispatch_after_f(dispatch_time_t when, dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);



/*
以异步方式提交任务，会阻塞queue队列，但不阻塞当前线程
queue 管理任务的队列，任务最终交由该队列来执行
需要说明的是，即时使用并发队列，该队列也会被阻塞，前一个任务执行完成才能执行下一个任务
block block形式的任务，该block返回值、形参都为void
*/
void dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block);

//同上
void dispatch_barrier_async_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);



/*
以异步方式提交任务，会阻塞queue队列，但不阻塞当前线程
queue 管理任务的队列，任务最终交由该队列来执行
需要说明的是，即时使用并发队列，该队列也会被阻塞，前一个任务执行完成才能执行下一个任务
block block形式的任务，该block返回值、形参都为void
*/
void dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block);

//同上
void dispatch_barrier_async_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);


/*
以同步方式提交任务，会阻塞queue队列，也会阻塞当前线程
queue 管理任务的队列，任务最终交由该队列来执行
同样的，即时是并发队列该队列也会被阻塞，需要等待前一个任务完成，同时线程也会阻塞
block block形式的任务，该block返回值、形参都为void
*/
void dispatch_barrier_sync(dispatch_queue_t queue, DISPATCH_NOESCAPE dispatch_block_t block);

//同上
void dispatch_barrier_sync_f(dispatch_queue_t queue, void *_Nullable context, dispatch_function_t work);



/*
底层线程池控制block任务在整个应用的生命周期内只执行一次
predicate 实际为long类型，用于判断是否执行过
block block形式的任务，该block返回值、形参都为void
该方法常用于实现单例类，以及结合RunLoop创建一个常驻内存的线程
*/
void dispatch_once(dispatch_once_t *predicate, dispatch_block_t block);



例：
   //使用传递函数指针的方式有点复杂，以后的栗子不再赘述
    int context = 0;
    dispatch_async_f(concurrentQueue, &context, cFuncTask);
    //也可以使用OC方法，传入IMP，但会有警告
    //dispatch_async_f(concurrentQueue, &context, [self methodForSelector:@selector(ocFuncTask:)]);
//该函数是C函数
void cFuncTask(void* context)
{

}
//OC方法
- (void)ocFuncTask:(void*) context
{

}




dispatch_apply：同步执行多少次

 //执行该方法的是主线程，不能传入主队列否则会死锁，
    dispatch_apply(20000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t t) {
        NSLog(@"Task %@ %ld", [NSThread currentThread], t);／／打印为主线程
    });
    

dispatch_after：异步在多少时间后提交任务，打印的不是主线程

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"In %@", [NSThread currentThread]);
    });
    NSLog(@"After");
    
    
    
dispatch_barrier _ (a)sync:    

dispatch_queue_t concurrentQueue = dispatch_queue_create("myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
 dispatch_async(concurrentQueue, ^{

    });    
dispatch_barrier_async(concurrentQueue, ^{
        //阻塞上面的队列，如果是dispatch_barrier_sync，阻塞队列的同时还阻塞线程
    });
    
    
dispatch_once：

@interface MyUtil: NSObject <NSCopying>

+ (instancetype)sharedUtil;

@end

@implementation MyUtil

static MyUtil *staticMyUtil = nil;

+ (instancetype)sharedUtil
{
    //保证初始化创建只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticMyUtil = [[MyUtil alloc] init];
    });
    return staticMyUtil;
}

//防止通过alloc或new直接创建对象
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //保证alloc函数只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticMyUtil = [super allocWithZone:zone];
    });
    return staticMyUtil;
}

//实现NSCopying协议的方法，防止通过copy获取副本对象
- (instancetype)copyWithZone:(NSZone *)zone
{
    return staticMyUtil;
}

@end



dispatch_ group_ t   将各个同步或异步提交任务都加入到同一个组中，当所有任务都完成后会收到通知

dispatch_group_t group = dispatch_group_create();
dispatch_group_async(group, concurrentQueue, ^{

 });
 dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"All Task Complete");
 });
 
 
防止GCD产生死锁:
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Before");

    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"In");//会死锁，因为viewWillAppear也在主队列中
    });

    NSLog(@"After");
}

dispatch_apply(1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t t) {
    dispatch_apply(2000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t t) {
        NSLog(@"===== %@ %ld", [NSThread currentThread], t);//同步执行多少次，都在同一个线程上，里面的需要等外面的执行完成
    });
 });
 
 
 
 实现定时器的三种方法：
 NSTimer、GCD以及CADisplayLink，CADisplayLink是其中精度最高的，因为它试图与屏幕刷新率保持一致
 
 NSTimer实现定时器：
 - (void)viewWillAppear:(BOOL)animated
{
    //倒计时次数
    __block int count = 10;
    //间隔1s执行一次
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //如果还在倒计时次数内
        if (count > 0)
        {
            //执行相关工作，如果有UI更新的操作需要放到主线程
            dispatch_async(dispatch_get_main_queue(), ^{

            });
            //次数--
            count --;
        }
        else
        {   
            //次数到达，取消定时器
            [timer invalidate];
        }
    }];
    //加入到RunLoop中，使用NSRunLoopCommonModes在滑动时也可以继续执行，runloop强引用timer，需要[timer invalidate]破除强引用
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]；
    
    


- (void)viewWillAppear:(BOOL)animated
{
    self.count = 10;
    //传入了self，会强引用timer，需要[timer invalidate]破除强引用
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)countDown:(NSTimer*)timer
{
    if (self.count > 0)
    {
        //执行相关工作，如果有UI更新的操作需要放到主线程
        dispatch_async(dispatch_get_main_queue(), ^{

        });
        self.count --;
    }
    else
    {
        //取消定时器
        [timer invalidate];
    }
}



GCD实现定时器:

dispatch_source_create:timer的创建
dispatch_source_set_timer  设置timer对象和间隔时间，设置每秒执行一次
dispatch_source_set_event_handler(_timer, ^{   设置timer执行事件的block块

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //执行次数
    __block int count = 10;
    //获取一个全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //这里不能使用局部变量，因为当viewDidAppear函数返回后timer就会被释放
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置timer的执行时间和间隔时间，设置每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1 * NSEC_PER_SEC, 0); 
    //设置timer执行事件的block块
    dispatch_source_set_event_handler(_timer, ^{
        if (count > 0)
        {
            //要执行的任务，更新UI需要放到主线程
            dispatch_async(dispatch_get_main_queue(), ^{

            });
            count --;
        }
        else
        {
            //执行次数达到预期就取消timer
            dispatch_source_cancel(_timer);
        }
    });
    //启动timer
    dispatch_resume(_timer);
}



CADisplayLink实现定时器：

displayLinkWithTarget:
CADisplayLink *timer = CADisplayLink displayLinkWithTarget创建定时器
timer.preferredFramesPerSecond = 1;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    self.count = 10;
    //CADisplayLink只有这一个构造方法
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown:)];
    //每秒对多少帧感兴趣，也就是每秒要执行多少次回调方法，屏幕每刷新一次调用一次回调方法，如屏幕每秒刷新60次，则调用60次回调方法
    timer.preferredFramesPerSecond = 1;
    //必须要添加进RunLoop才开始执行
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)countDown:(CADisplayLink*)timer
{
    if (self.count > 0)
    {
        //执行相关工作，如果有UI更新的操作需要放到主线程
        dispatch_async(dispatch_get_main_queue(), ^{

        });
        self.count --;
    }
    else
    {
        //取消定时器
        [timer invalidate];
    }

}




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
 
 

//https://blog.csdn.net/u014205968/article/details/78323182
可定制性 
NSOperation提供任务的封装
NSOperationQueue 提供执行队列 多核并行计算 供了更多可定制的开发方式
自动管理线程的生命周期 gcd NSOperationQueue都可
串行只需要将队列的并发数设置为一

NSOperation：
NSOperation类的自定义：
非并发队列：
子类需重写main方法，最好不要只实现一个main方法就交给队列去执行，没有实现finished属性，所以获取finished属性时只会返回NO，任务加入到队列后不会被队列删除，一直会保存，而且任务执行完成后的回调块也不会执行

并发队列：
重写start方法
子类需重写BOOL executing，BOOL finished =YES后，队列会将任务移除出队列
自定义并发任务子类重写- (BOOL)isAsynchronous 返回yes

BOOL ready =yes 任务即将开始执行 不需要重写
//添加一个依赖
- (void)addDependency:(NSOperation *)op;
//删除一个依赖
- (void)removeDependency:(NSOperation *)op;
//任务在队列里的优先级
NSOperationQueuePriority： NSOperationQueuePriorityVeryLow = -8L,Low，Normal，High，VeryHigh
@property NSOperationQueuePriority queuePriority;//优先级
//finished属性设置为YES时才会执行该回调
@property (nullable, copy) void (^completionBlock)(void);

实现GCD那样的功能，NSBlockOperation和NSInvocationOperation（Invocation调用）

NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
   //这里面不能添加异步线程，需定制，如果添加了，block或方法会立即返回，此时就会将finished设置为YES，executing设置为NO，但是其实任务并没有完成，
}];
NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task:) object:@"Hello, World!"];



NSOperationQueue

//向队列添加任务
- (void)addOperation:(NSOperation *)op;

/*
向队列中添加一组任务
YES，则阻塞当前线程直到所有任务完成
如果为False，不阻塞当前线程
*/
- (void)addOperations:(NSArray<NSOperation *> *)ops waitUntilFinished:(BOOL)wait;

/／向队列中添加一个任务，任务以block的形式传
- (void)addOperationWithBlock:(void (^)(void))block;

//获取所有任务
@property (readonly, copy) NSArray<__kindof NSOperation *> *operations;

/获取队列中的任务数量
@property (readonly) NSUInteger operationCount;

/*
最大任务并发数
1串行队列，主队列就是串行队列 主线程执行任务
大于1 并发队列，底层线程池管理多个线程来执行任务
*/
@property NSInteger maxConcurrentOperationCount;


/／队列是否挂起
@property (getter=isSuspended) BOOL suspended;

/队列的名称
@property (nullable, copy) NSString *name;

／*
取消队列中的所有任务
所有任务的cancelled属性都置为YES
*/
- (void)cancelAllOperations;

//阻塞当前线程直到所有任务完成
- (void)waitUntilAllOperationsAreFinished;

//类属性，获取当前队列
@property (class, readonly, strong, nullable) NSOperationQueue *currentQueue;

//类属性，获取主队列 任务并发数为1，即串行队列
@property (class, readonly, strong) NSOperationQueue *mainQueue;






非并发的NSOperation自定义子类：

TestOperation: NSOperation
重写：
- (void)main
{

}
最好不要只实现一个main方法就交给队列去执行，没有实现finished属性，所以获取finished属性时只会返回NO，任务加入到队列后不会被队列删除，一直会保存，而且任务执行完成后的回调块也不会执行


并发的NSOperation自定义子类
重写以下几个方法或属性:
start方法:start方法中是我们编写的任务，要保证不允许调用父类的start方法
isExecuting:手动调用KVO方法通知任务是否在执行
isFinished: 手动调用KVO方法通知任务是否完成，任务是异步的，start方法返回不一定代表任务就结束了，开发者手动修改该属性，队列就可以正常的移除任务
isAsynchronous: 是否并发执行，之前需要使用isConcurrent，但isConcurrent被废弃了，该属性标识是否并发

例子：
@interface MyOperation: NSOperation

@property (nonatomic, assign, getter=isExecuting) BOOL executing;
@property (nonatomic, assign, getter=isFinished) BOOL finished;

@end

@implementation MyOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)start
{
    //在任务开始前设置executing为YES，在此之前可能会进行一些初始化操作
    self.executing = YES;
    for (int i = 0; i < 500; i++)
    {
        /*
        需要在适当的位置判断外部是否调用了cancel方法
        如果被cancel了需要正确的结束任务
        */
        if (self.isCancelled)
        {
            //任务被取消正确结束前手动设置状态
            self.executing = NO;
            self.finished = YES;
            return;
        }
        //输出任务的各个状态以及队列的任务数
        NSLog(@"Task %d %@ Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", i, [NSThread currentThread], self.cancelled, self.executing, self.finished, [[NSOperationQueue currentQueue] operationCount]);
        [NSThread sleepForTimeInterval:0.1];
    }
    NSLog(@"Task Complete.");
    //任务执行完成后手动设置状态
    self.executing = NO;
    self.finished = YES;
}

- (void)setExecuting:(BOOL)executing
{
    //调用KVO通知
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    //调用KVO通知
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    //调用KVO通知
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    //调用KVO通知
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}

@end


使用它的类：
  self.queue = [[NSOperationQueue alloc] init];
    [self.queue setMaxConcurrentOperationCount:1];

    self.myOperation = [[MyOperation alloc] init];
    [self.queue addOperation:self.myOperation]
    
//一旦MyOperation的value值有变化，就会进入这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //判断是不是被监听的成员对象以及成员变量
    if ([object isKindOfClass:[MyOperation class]] &&
         [keyPath isEqualToString:@"isFinished"]) {
        
        // 获取value的新值
        NSNumber *valueNum = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"MyOperation Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", self.myOperation.isCancelled, self.myOperation.isExecuting, self.myOperation.isFinished, self.queue.operationCount);    

    }
}




一个下载文件的例子：


FileDownloadOperation.h:


@class FileDownloadOperation;
//定义一个协议，用于反馈下载状态
@protocol FileDownloadDelegate <NSObject>

@optional
- (void)fileDownloadOperation:(FileDownloadOperation *)downloadOperation downloadProgress:(double)progress;
- (void)fileDownloadOperation:(FileDownloadOperation *)downloadOperation didFinishWithData:(NSData *)data;
- (void)fileDownloadOperation:(FileDownloadOperation *)downloadOperation didFailWithError:(NSError *)error;
@end

@interface FileDownloadOperation: NSOperation
//定义代理对象
@property (nonatomic, weak) id<FileDownloadDelegate> delegate;
//初始化构造函数，文件URL
- (instancetype)initWithURL:(NSURL*)url;
@end


FileDownloadOperation.m


#import "FileDownloadOperation.h"

@interface FileDownloadOperation() <NSURLConnectionDelegate>

//定义executing属性
@property (nonatomic, assign, getter=isExecuting) BOOL executing;
//定义finished属性
@property (nonatomic, assign, getter=isFinished) BOOL finished;

//要下载的文件的URL
@property (nonatomic, strong) NSURL *fileURL;
//使用NSURLConnection进行网络数据的获取
@property (nonatomic, strong) NSURLConnection *connection;
//定义一个可变的NSMutableData对象，用于添加获取的数据
@property (nonatomic, strong) NSMutableData *fileMutableData;
//记录要下载文件的总长度
@property (nonatomic, assign) NSUInteger fileTotalLength;
//记录已经下载了的文件的长度
@property (nonatomic, assign) NSUInteger downloadedLength;

@end


@implementation FileDownloadOperation

@synthesize delegate = _delegate;

@synthesize executing = _executing;
@synthesize finished = _finished;

@synthesize fileURL = _fileURL;
@synthesize connection = _connection;
@synthesize fileMutableData = _fileMutableData;
@synthesize fileTotalLength = _fileTotalLength;
@synthesize downloadedLength = _downloadedLength;

//executing属性的setter
- (void)setExecuting:(BOOL)executing
{
    //设置executing属性需要手动触发KVO方法进行通知
    [self willChangeValueForKey:@"executing"];
    _executing = executing;
    [self didChangeValueForKey:@"executing"];
}
//executing属性的getter
- (BOOL)isExecuting
{
    return _executing;
}
//finished属性的setter
- (void)setFinished:(BOOL)finished
{
    //同上，需要手动触发KVO方法进行通知
    [self willChangeValueForKey:@"finished"];
    _finished = finished;
    [self didChangeValueForKey:@"finished"];
}
//finished属性的getter
- (BOOL)isFinished
{
    return _finished;
}
//返回YES标识为并发Operation
- (BOOL)isAsynchronous
{
    return YES;
}
//内部函数，用于结束任务
- (void)finishTask
{
    //中断网络连接
    [self.connection cancel];
    //设置finished属性为YES，将任务从队列中移除
    //会调用setter方法，并触发KVO方法进行通知
    self.finished = YES;
    //设置executing属性为NO
    self.executing = NO;
}
//初始化构造函数
- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init])
    {
        self.fileURL = url;

        self.fileMutableData = [[NSMutableData alloc] init];
        self.fileTotalLength = 0;
        self.downloadedLength = 0;
    }
    return self;
}
//重写start方法
- (void)start
{
    //任务开始执行前检查是否被取消，取消就结束任务
    if (self.isCancelled)
    {
        [self finishTask];
        return;
    }
    //构造NSURLConnection对象，并设置不立即开始，手动开始
    self.connection = [[NSURLConnection alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:self.fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:25] delegate:self startImmediately:NO];
    //判断是否连接，没有连接就结束任务
    if (self.connection == nil)
    {
        [self finishTask];
        return;
    }
    //成功连接到服务器后检查是否取消任务，取消任务就结束
    if (self.isCancelled)
    {
        [self finishTask];
        return;
    }
    //设置任务开始执行
    self.executing = YES;
    //获取当前RunLoop
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    //将任务交由RunLoop规划
    [self.connection scheduleInRunLoop:currentRunLoop forMode:NSRunLoopCommonModes];
    //开始从服务端获取数据
    [self.connection start];
    //判断执行任务的是否为主线程
    if (currentRunLoop != [NSRunLoop mainRunLoop])
    {
        //不为主线程启动RunLoop
        CFRunLoopRun();
    }
}

//MARK - NSURLConnectionDelegate 方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //获取并设置将要下载文件的长度大小
    self.fileTotalLength = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //网络获取失败，调用代理方法
    if ([self.delegate respondsToSelector:@selector(fileDownloadOperation:didFailWithError:)])
    {
        //需要将代理方法放到主线程中执行，防止代理方法需要修改UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate fileDownloadOperation:self didFailWithError:error];
        });
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //收到数据包后判断任务是否取消，取消则结束任务
    if (self.isCancelled)
    {
        [self finishTask];
        return;
    }
    //添加获取的数据
    [self.fileMutableData appendData:data];
    //修改已下载文件长度
    self.downloadedLength += [data length];
    //调用回调函数
    if ([self.delegate respondsToSelector:@selector(fileDownloadOperation:downloadProgress:)])
    {
        //计算下载比例
        double progress = self.downloadedLength * 1.0 / self.fileTotalLength;
        //同上，放在主线程中调用，防止主线程有修改UI的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate fileDownloadOperation:self downloadProgress:progress];
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //网络下载完成前检查是否取消任务，取消就结束任务
    if (self.isCancelled)
    {
        [self finishTask];
        return;
    }
    //调用回调函数
    if ([self.delegate respondsToSelector:@selector(fileDownloadOperation:didFinishWithData:)])
    {
        //同理，放在主线程中调用
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate fileDownloadOperation:self didFinishWithData:self.fileMutableData];
        });
    }
    //下载完成，任务结束
    [self finishTask];
}

@end




 
 
 
 
 
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
 
 
 
 NSThread是Foundation框架提供 最基础的多线程类
一个NSThread类对象即代表一个线程
GCD相比于NSThread来说不需要再关注于管理线程的生命周期，不需要自行管理一个线程池用于线程的复用，GCD是以C函数对外提供接口
Foundation框架在GCD的基础上进行了面向对象的封装，多线程类NSOperation和NSOperationQueue
POSIX标准的线程pthread，pthread和NSThread都是对内核mach kernel的mach thread的封装，所以在开发时一般不会使用pthread。
RunLoop是与线程相关的一个基本组成，线程在执行完任务后不退出，长驻线程需要runloop
NSThread是对内核mach kernel中的mach thread的封装

执行完任务执行体后该线程就退出并被自动销毁了，无法复用NSThread，尽管线程的创建相比进程更加轻量级，但创建一个线程远比创建一个普通对象要消耗资源
启动线程start方法，仅仅是将线程的状态从新建转为就绪，何时执行该线程的任务需要系统自行调度。

方法如下：

/*
需要手动调用start方法来启动线程执行任务，执行完任务执行体后该线程就退出并被销毁
使用target对象的selector作为线程的任务执行体，该selector方法最多可以接收一个参数，该参数即为argument，
*/
- (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/*
需要手动调用start方法来启动线程执行任务
使用block作为线程的任务执行体
*/
- (instancetype)initWithBlock:(void (^)(void))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));

/*
不需要手动触发
类方法，返回值为void
使用一个block作为线程的执行体，并直接启动线程
上面的实例方法返回NSThread对象需要手动调用start方法来启动线程执行任务
*/
+ (void)detachNewThreadWithBlock:(void (^)(void))block API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0));

/*
detachNewThreadSelector不需要手动触发
类方法，返回值为void
使用target对象的selector作为线程的任务执行体，该selector方法最多接收一个参数，该参数即为argument
同样的，该方法创建完县城后会自动启动线程不需要手动触发
*/
+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(nullable id)argument；

//栗子1:
NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(firstThread:) object:@"Hello, World"];
    //设置线程的名字，方便查看
    [thread setName:@"firstThread"];
    //启动线程
    [thread start];  
    
//栗子2:
/*
通过传入block的方式创建一个线程，线程执行体即为block的内容
但该方式创建线程无法传入参数
*/
NSThread *thread = [[NSThread alloc] initWithBlock:^{
    for (int i = 0; i < 100; i++)
    {
        NSLog(@"Task %@", [NSThread currentThread]);
    }
}];
//设置线程名称
[thread setName:@"firstThread"];
//启动线程
[thread start];

//栗子3:
/*
通过类方法创建并自动启动一个线程
该线程的执行体即为传入的block
*/
[NSThread detachNewThreadWithBlock:^{
    for (int i = 0; i < 100; i++)
    {
        NSLog(@"Task %@", [NSThread currentThread]);
    }
}];

//栗子4:
/*
通过类方法创建并自动启动一个线程
该线程的执行体为self的firstThread:方法，并传入相关参数
*/
[NSThread detachNewThreadSelector:@selector(firstThread:) toTarget:self withObject:@"Hello, World!"];




NSThread中几个比较常用的属性和方法
/*
类属性，用于获取当前线程
如果是在主线程调用则返回主线程对象
如果在其他线程调用则返回其他的当前线程
什么线程调用，就返回什么线程
*/
@property (class, readonly, strong) NSThread *currentThread;

//类属性，用于返回主线程，不论在什么线程调用都返回主线程
@property (class, readonly, strong) NSThread *mainThread;

/*
设置线程的优先级，范围为0-1的doule类型，数字越大优先级越高
我们知道，系统在进行线程调度时，优先级越高被选中到执行状态的可能性越大
但是我们不能仅仅依靠优先级来判断多线程的执行顺序，多线程的执行顺序无法预测
*/
@property double threadPriority;

//线程的名称，前面的栗子已经介绍过了
@property (nullable, copy) NSString *name

//判断线程是否正在执行
@property (readonly, getter=isExecuting) BOOL executing;

//判断线程是否结束
@property (readonly, getter=isFinished) BOOL finished;

//判断线程是否被取消
@property (readonly, getter=isCancelled) BOOL cancelled;

/*
让线程睡眠多长时间，立即让出当前时间片，让出CPU资源，进入阻塞状态
类方法，什么线程执行该方法，什么线程就会睡眠
*/
+ (void)sleepUntilDate:(NSDate *)date;

//同上，这里传入时间
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;

//退出当前线程，什么线程执行，什么线程就退出
+ (void)exit;

/*
实例方法，取消线程
调用该方法会设置cancelled属性为YES，但并不退出线程
*/
- (void)cancel



例二：

//按钮点击事件处理器
- (void)btnClicked
{
    //取消线程
    [self.thread cancel];
}

- (void)viewWillAppear:(BOOL)animated
{    
     self.thread = [[NSThread alloc] initWithBlock:^{
        for (int i = 0; i < 100; i++)
        {
            //获取当前正在执行的线程，即self.thread
            NSThread *currentThread = [NSThread currentThread];
            //判断线程是否被取消
            if ([currentThread isCancelled])
            {
                //如果被取消就退出当前正在执行的线程，即self.thread
                [NSThread exit];
            }
            NSLog(@"Task %@", currentThread);
            //循环内，每次循环睡1s
            [NSThread sleepForTimeInterval:1];
        }
    }];
    [self.thread setName:@"firstThread"];
    //启动线程
    [self.thread start];    
}

退出线程有如下三种情况:

任务执行体执行完成后正常退出
任务执行体执行过程中发生异常也会导致当前线程退出
执行NSThread类的exit方法退出当前线程

优先级高的线程获取到时间片即能够执行输出的机会高于优先级低的


例三：
//更新ui操作需要在主线程中进行   
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508398116220&di=ba2b7c9bf32d0ecef49de4fb19741edb&imgtype=0&src=http%3A%2F%2Fwscont2.apps.microsoft.com%2Fwinstore%2F1x%2Fea9a3c59-bb26-4086-b823-4a4869ffd9f2%2FScreenshot.398115.100000.jpg"]]];
        //图片下载完成之后使用主线程来执行更新UI的操作
        [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:NO];
    }];
    //启动线程
    [thread start];
    

锁操作：

//栗子2: 同步代码块解决
- (void)draw:(id)money
{
    @synchronized (self) {
        double drawMoney = [money doubleValue];

        if (self.balance >= drawMoney)
        {
            [NSThread sleepForTimeInterval:0.001];
            self.balance -= drawMoney;
            NSLog(@"%@ draw money %lf balance left %lf", [[NSThread currentThread] name], drawMoney, self.balance);
        }
        else
        {
            NSLog(@"%@ Balance Not Enouth", [[NSThread currentThread] name]);
        }
    }
}


//栗子3:NSLOCK的解决方案
- (void)draw:(id)money
{
    /*
    self.lock在ViewController的初始化函数中进行初始化操作
    self.lock = [[NSLock alloc] init];
    */
    [self.lock lock];
    double drawMoney = [money doubleValue];

    if (self.balance >= drawMoney)
    {
        [NSThread sleepForTimeInterval:0.001];
        self.balance -= drawMoney;
        NSLog(@"%@ draw money %lf balance left %lf", [[NSThread currentThread] name], drawMoney, self.balance);
    }
    else
    {
        NSLog(@"%@ Balance Not Enouth", [[NSThread currentThread] name]);
    }
    [self.lock unlock];
}




条件锁： 需要线程按照一定条件来执行，这时就需要线程间进行通信，NSCondition就提供了线程间通信的方法

NSCondition的声明文件:

NS_CLASS_AVAILABLE(10_5, 2_0)
@interface NSCondition : NSObject <NSLocking> {
@private
    void *_priv;
}

/*
wait 阻塞 休眠线程
signal方法或broadcast 唤醒

调用NSCondition对象wait方法的线程会阻塞，直到其他线程调用该对象的signal方法或broadcast方法来唤醒
唤醒后该线程从阻塞态改为就绪态，交由系统进行线程调度
执行wait方法时内部会自动执行unlock方法释放锁，并阻塞线程
*/
- (void)wait;

//阻塞，到某个时刻再唤醒。同上，只是该方法是在limit到达时唤醒线程
- (BOOL)waitUntilDate:(NSDate *)limit;

/*
唤醒在当前NSCondition对象上阻塞的一个线程 唤醒当前阻塞线程
如果在该对象上wait的有多个线程则随机挑选一个，被挑选的线程则从阻塞态进入就绪态
*/
- (void)signal;

/*
同上，该方法会唤醒在当前NSCondition对象上阻塞的所有线程  唤醒所有线程
*/
- (void)broadcast;

@property (nullable, copy) NSString *name API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END


存钱取钱案例：没钱了阻塞，有钱唤醒
@interface Account: NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, assign) double balance;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, assign) BOOL haveMoney;

- (void)deposite:(id)money;
- (void)draw:(id)money;

@end

@implementation Account

@synthesize accountNumber = _accountNumber;
@synthesize balance = _balance;
@synthesize condition = _condition;
@synthesize haveMoney = _haveMoney;

//NSCondition的getter，用于创建NSCondition对象
- (NSCondition*)condition
{
    if (_condition == nil)
    {
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}

- (void)draw:(id)money
{
    //设置消费者取钱20次
    int count = 0;
    while (count < 20)
    {
        //首先使用condition上锁，如果其他线程已经上锁则阻塞
        [self.condition lock];
        //判断是否有钱
        if (self.haveMoney)
        {
            //有钱则进行取钱的操作，并设置haveMoney为NO
            self.balance -= [money doubleValue];
            self.haveMoney = NO;
            count += 1;
            NSLog(@"%@ draw money %lf %lf", [[NSThread currentThread] name], [money doubleValue], self.balance);
            //取钱操作完成后唤醒其他在次condition上等待的线程
            [self.condition broadcast];
        }
        else
        {
            //如果没有钱则在次condition上等待，并阻塞
            [self.condition wait];
            //如果阻塞的线程被唤醒后会继续执行代码
            NSLog(@"%@ wake up", [[NSThread currentThread] name]);
        }
        //释放锁
        [self.condition unlock];
    }
}

- (void)deposite:(id)money
{
    //创建了三个取钱线程，每个取钱20次，则存钱60次
    int count = 0;
    while (count < 60)
    {   
        //上锁，如果其他线程上锁了则阻塞
        [self.condition lock];
        //判断如果没有钱则进行存钱操作
        if (!self.haveMoney)
        {
            //进行存钱操作，并设置haveMoney为YES
            self.balance += [money doubleValue];
            self.haveMoney = YES;
            count += 1;
            NSLog(@"Deposite money %lf %lf", [money doubleValue], self.balance);
            //唤醒其他所有在condition上等待的线程
            [self.condition broadcast];
        }
        else
        {
            //如果有钱则等待
            [self.condition wait];
            NSLog(@"Deposite Thread wake up");
        }
        //释放锁
        [self.condition unlock];
    }
}

@end

- (void)viewWillAppear:(BOOL)animate
{

    [super viewWillAppear:YES];

    Account *account = [[Account alloc] init];
    account.accountNumber = @"1603121434";
    account.balance = 0;
    //消费者线程1，每次取1000元
    NSThread *thread = [[NSThread alloc] initWithTarget:account selector:@selector(draw:) object:@(1000)];
    [thread setName:@"consumer1"];

    //消费者线程2，每次取1000元
    NSThread *thread2 = [[NSThread alloc] initWithTarget:account selector:@selector(draw:) object:@(1000)];
    [thread2 setName:@"consumer2"];

    //消费者线程3，每次取1000元
    NSThread *thread3 = [[NSThread alloc] initWithTarget:account selector:@selector(draw:) object:@(1000)];
    [thread3 setName:@"consumer3"];

    //生产者线程，每次存1000元
    NSThread *thread4 = [[NSThread alloc] initWithTarget:account selector:@selector(deposite:) object:@(1000)];
    [thread4 setName:@"productor"];

    [thread start];
    [thread2 start];
    [thread3 start];
    [thread4 start];
}



 
 
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
 
 
 @synchronized 一般创建单例对象的时候使用，保证多线程情况下创建对象是唯一的  同步锁
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







锁的新认识：

锁：  ios中的各种锁

多个线程访问修改同一块资源，保证每次只有一个线程访问修改一块资源

OSSpinLock 自旋锁（暂不建议使用，原因参见这里）
dispatch_semaphore 信号量实现加锁（GCD）
pthread_mutex 互斥锁（C语言）
NSLock 对象锁
NSCondition 条件锁
pthread_mutex （recursive）
NSRecursiveLock 递归锁
NSConditionLock 条件锁
@synchronized



1.自旋锁  OSSpinLock

尝试加锁：bool    OSSpinLockTry( volatile OSSpinLock *__lock );  尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO

加锁：void    OSSpinLockLock( volatile OSSpinLock *__lock );

解锁：void    OSSpinLockUnlock( volatile OSSpinLock *__lock );


原理：自旋锁一直轮询，去等待其它线程释放锁后获取锁，等待时会消耗大量 CPU 资源，不适用于较长时间的任务，一些简单的加1减1操作
而NSLock 请求加锁失败一秒过线程进入休眠，等待唤醒

代码1：和NSLock很像

#import <libkern/OSAtomic.h>

__block OSSpinLock oslock = OS_SPINLOCK_INIT;
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 准备上锁");//执行顺序（1）
    OSSpinLockLock(&oslock);
    sleep(4);
    NSLog(@"线程1");//执行顺序（3）
    OSSpinLockUnlock(&oslock);
    NSLog(@"线程1 解锁成功");//执行顺序（4）
    NSLog(@"--------------------------------------------------------");
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 准备上锁");//执行顺序（2）
    OSSpinLockLock(&oslock);//循环等待线程1解锁，对线程2加锁
    NSLog(@"线程2");//执行顺序（5）
    OSSpinLockUnlock(&oslock);
    NSLog(@"线程2 解锁成功");//执行顺序（6）
});


代码2： 加锁解锁需成对出现，系统先执行成对锁出现的线程，

#import <libkern/OSAtomic.h>

__block OSSpinLock oslock = OS_SPINLOCK_INIT;
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 准备上锁");//执行顺序（2）
    //注释掉加锁代码  OSSpinLockLock(&oslock);
    sleep(4);
    NSLog(@"线程1");//执行顺序（5）
    OSSpinLockUnlock(&oslock);
    NSLog(@"线程1 解锁成功");//执行顺序（6）
    NSLog(@"--------------------------------------------------------");
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 准备上锁");//执行顺序（1）
    OSSpinLockLock(&oslock);//循环等待线程1解锁，对线程2加锁
    NSLog(@"线程2");//执行顺序（3）
    OSSpinLockUnlock(&oslock);
    NSLog(@"线程2 解锁成功");//执行顺序（4）
});





2.dispatch_semaphore 信号量  

只要信号量大于0就不会阻塞线程

dispatch_semaphore_create 创建一个信号量，数值必须大于1
dispatch_semaphore_signal 信号量+1
dispatch_semaphore_wait  信号量-1  信号量为0会阻塞当前线程


代码：
dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
            NSLog(@"需要线程同步的操作1 开始");
            sleep(2);
            NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
            NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
2016-06-29 20:47:52.324 SafeMultiThread[35945:579032] 需要线程同步的操作1 开始
2016-06-29 20:47:55.325 SafeMultiThread[35945:579032] 需要线程同步的操作1 结束
2016-06-29 20:47:55.326 SafeMultiThread[35945:579033] 需要线程同步的操作2



3.pthread_mutex 互斥锁（C语言）

创建锁：
static pthread_mutex_t pLock;
pthread_mutex_init(&pLock, NULL);

加锁：
pthread_mutex_lock(&pLock);

解锁： 
pthread_mutex_unlock(&pLock);

尝试加锁：尝试加锁，可以加锁则立即加锁并返回 0,反之返回 其它
pthread_mutex_trylock(&pLock);


代码： 和NSLock很像，因为是c语言版的NSLock
static pthread_mutex_t pLock;
pthread_mutex_init(&pLock, NULL);
 //1.线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 准备上锁");//执行顺序(1)
    pthread_mutex_lock(&pLock);
    sleep(3);
    NSLog(@"线程1");//执行顺序(3)
    pthread_mutex_unlock(&pLock);
});

//1.线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 准备上锁");//执行顺序(2)
    pthread_mutex_lock(&pLock);
    NSLog(@"线程2");//执行顺序(4)
    pthread_mutex_unlock(&pLock);
});


4.pthread_mutex(recursive)
c语言的递归锁：
 我们可以发现：加锁后只能有一个线程访问该对象，后面的线程需要排队，并且 lock 和 unlock 是对应出现的，
同一线程多次 lock 是不允许的，而递归锁允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作。同一线程
可以多次加锁

代码：

static pthread_mutex_t pLock;
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
pthread_mutex_init(&pLock, &attr);
pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用

//1.线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    static void (^RecursiveBlock)(int);
    RecursiveBlock = ^(int value) {
        pthread_mutex_lock(&pLock);
        if (value > 0) {
            NSLog(@"value: %d", value);
            RecursiveBlock(value - 1);//这里递归调用还未释放锁时可以再加锁
        }
        pthread_mutex_unlock(&pLock);
    };
    RecursiveBlock(5);
});




5.NSLock 对象锁

方法：
lock
unlock
trylock：如果能加锁就返回yes，并且加锁
lockBeforeDate： 在传入的时间内尝试加锁，如果能加锁就会加锁返回yes，超出时间后都返回no，不加锁

代码：
NSLock *lock = [NSLock new];
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程1 尝试加速ing...");//执行顺序（2）
    [lock lock];
    sleep(3);
    NSLog(@"线程1");//执行顺序（3）
    [lock unlock];
    NSLog(@"线程1解锁成功");//执行顺序（4）
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"线程2 尝试加速ing...");//执行顺序（1）
    BOOL x =  [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
    if (x) {
        NSLog(@"线程2");//执行顺序（5）
        [lock unlock];
    }else{
        NSLog(@"失败");
    }
});



6.NSCondition  条件锁

方法：
wait：进入等待状态
waitUntilDate:：让一个线程等待一定的时间
signal：唤醒一个等待的线程
broadcast：唤醒所有等待的线程

代码1：
等待2秒后自动唤醒线程
NSCondition *cLock = [NSCondition new];
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSLog(@"start");
    [cLock lock];
    [cLock waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    NSLog(@"线程1");
    [cLock unlock];
});


代码2：
主动唤醒一个等待线程

NSCondition *cLock = [NSCondition new];
//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lock];
    NSLog(@"线程1加锁成功");//执行顺序（1）
    [cLock wait];
    NSLog(@"线程1");//执行顺序（4）
    [cLock unlock];
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lock];
    NSLog(@"线程2加锁成功");//执行顺序（2）
    [cLock wait];
    NSLog(@"线程2");
    [cLock unlock];
});

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    sleep(2);
    NSLog(@"唤醒一个等待的线程");//执行顺序（3）
    [cLock signal];
});




7.NSRecursiveLock 递归锁 oc语言的
递归锁允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作。同一线程可以多次加锁

方法：
- (BOOL)tryLock;   如果能加锁就返回yes，并且加锁
- (BOOL)lockBeforeDate:(NSDate *)limit;   在传入的时间内尝试加锁，如果能加锁就会加锁返回yes，超出时间后都返回no，不加锁

NSRecursiveLock *rLock = [NSRecursiveLock new];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    static void (^RecursiveBlock)(int);
    RecursiveBlock = ^(int value) {
        [rLock lock];
        if (value > 0) {
            NSLog(@"线程%d", value);
            RecursiveBlock(value - 1);
        }
        [rLock unlock];
    };
    RecursiveBlock(4);
});



8。@synchronized 关键字加锁 翻译为同步  是一种互斥锁

 @synchronized(这里添加一个OC对象，一般使用self) {
       这里写要加锁的代码
  }
　注意点
　　 1.加锁的代码尽量少
　　 2.添加的OC对象必须在多个线程中都是同一对象
    3.优点是不需要显式的创建锁对象，便可以实现锁的机制。
    4. @synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。
    所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象。
    
    


NSConditionLock 条件锁

- (void)lockWhenCondition:(NSInteger)condition; //当值为多少时加锁
- (BOOL)tryLock;//尝试加锁，如果可以加锁并返回yes
- (BOOL)tryLockWhenCondition:(NSInteger)condition;//当值为多少时尝试加锁，如果可以加锁返回yes
- (void)unlockWithCondition:(NSInteger)condition;//当值为多少时解锁
- (BOOL)lockBeforeDate:(NSDate *)limit;//在多少时间内加锁
- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;//在多少时间多少值内加锁

代码：

NSConditionLock *cLock = [[NSConditionLock alloc] initWithCondition:0];

//线程1
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    if([cLock tryLockWhenCondition:0]){
        NSLog(@"线程1");//执行顺序(1)
       [cLock unlockWithCondition:1];
    }else{
         NSLog(@"失败");
    }
});

//线程2
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lockWhenCondition:3];
    NSLog(@"线程2");//执行顺序(3)
    [cLock unlockWithCondition:2];
});

//线程3
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [cLock lockWhenCondition:1];
    NSLog(@"线程3");//执行顺序(2)
    [cLock unlockWithCondition:3];
});


分析：
我们在初始化 NSConditionLock 对象时，给了他的标示为 0

执行 tryLockWhenCondition:时，我们传入的条件标示也是 0,所 以线程1 加锁成功
执行 unlockWithCondition:时，这时候会把condition由 0 修改为 1

因为condition  修改为了  1， 会先走到 线程3，然后 线程3 又将 condition 修改为 3

最后 走了 线程2 的流程







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
这个runloop会不断接收事件消息，比如点击屏幕，滑动列表，网络请求返回
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



第二篇补充：
线程执行完一个任务后，就会退出，再执行另一个任务，又创建一个资源，这样比较浪费，如果线程常在内存，有任务的时候执行，没任务休息，这就是
runloop实现常驻线程
大致如下：
int retVal = Running;
do {
     // 执行各种任务，处理各种事件
     // ......
} while (retVal != Stop && retVal != Timeout);

一个RunLoop对应一个线程，是一种事件处理环，用来安排和协调到来的事件，关联的线程在有事件到达时时刻保持运行状态，而当没有事件需要处理时进入睡眠状态从而节约资源
获取RunLoop相当于创建RunLoop。

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
UIApplicationMain函数,内部就会第一次获取RunLoop对象,在没有满足特定条件的时候该主线程不会退出，应用就可以持续运行而不会退出。

RunLoop对象检测并负责处理以下事件：
source0：开发者提交的各种事件，需要手动唤醒线程，把当前线程从内核态切换到用户态，如点击按钮。
source1: Port-Based Sources 基于端口的事件，基于端口的，通过内核和其他线程通信事件后包装为source0事件后分发给其他线程处理，系统自动唤醒线程
performSelector:onThread:   Cocoa Perform Selector Sources 方法事件
Timer sources：CFRunLoopTimerRef 常用的定时器事件，在注册的定时器时间到达时唤醒关联的线程对象来执行定时器的回调


//获得当前线程关联的RunLoop对象
CFRunLoopGetCurrent(); 
// 获得主线程关联的RunLoop对象
CFRunLoopGetMain();

RunLoop对象保存在一个全局的字典中，，该字典以线程对象pthread_t为key，以RunLoop对象为value，
线程销毁，则会从字典移除它对应的runloop。


一个runloop对应多个mode，每个model对应（source0，source1，performSelector:onThread， Timer sources）
可通过commonMode实现model与事件源多对多关系。


Observer： CFRunLoopObserverRef
就是监听器，用来监听RunLoop的各种状态
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    //即将进入RunLoop的执行循环
    kCFRunLoopEntry = (1UL << 0),
    //即将处理Timer事件
    kCFRunLoopBeforeTimers = (1UL << 1),
    //即将处理Source事件
    kCFRunLoopBeforeSources = (1UL << 2),
    //RunLoop即将进入休眠状态
    kCFRunLoopBeforeWaiting = (1UL << 5),
    //RunLoop即将被唤醒
    kCFRunLoopAfterWaiting = (1UL << 6),
    //RunLoop即将退出
    kCFRunLoopExit = (1UL << 7),
    //监听RunLoop的全部状态
    kCFRunLoopAllActivities = 0x0FFFFFFFU
};


Mode: CFRunLoopModeRef
kCFRunLoopDefaultMode 即 NSDefaultRunLoopMode，默认运行模式
UITrackingRunLoopMode 跟踪UIScrollView滑动时使用的运行模式，保证滑动时不受其他事件处理的影响，保证丝滑
UIInitializationRunLoopMode 启动应用时的运行模式，应用启动完成后就不会再使用
GSEventReceiveRunLoopMode 事件接收运行模式
kCFRunLoopCommonModes 即 NSRunLoopCommonModes 是一种标记的模式，把事件源添加到不同的model中，还需要上述四种模式的支持


Mode内部管理了一个_source0的事件集合，一个_source1的事件集合，一个_observers的数组以及_timers的数组

runloop的数据结构有重要的几个：
_commonModes：
    如果一个model需要添加其它_commonModeItems中包含的Source/Observer/Timer，需要把model的名字加入到commonModes，从commonModes取出
    所有被标记的model添加commonModeItems中包含的Source/Observer/Timer ,实现model与事件源多对多关系


_commonModeItems：


_currentMode：
    runLoop对象正在执行的Mode 即CFRunLoopModeRef
    
    
_modes：


将NSTimer加入到commonModeItems集合中，滑动时就会自动取出commonModeItems集合中的事件源同步添加到其它模式如UITrackingRunLoopMode模式下
系统默认将kCFRunLoopDefaultMode和UITrackingRunLoopMode添加到了_commonModes中，即标识为Common属性，所以当RunLoop运行在这两种模式中会自动同步添加_commonModeItems中的Source/Timer/Observer。
代码：
  NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Hello, World");
    }];

    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
NSTimer其实是不那么精确的，RunLoop一次循环的执行延迟，线程接收timer事件延迟，就不会太精准




RunLoop 执行逻辑:

1.通知监听器RunLoop进入循环

2.通知监听器即将处理Timer事件

3.通知监听器即将处理source0(不是基于端口的)事件

4.执行source0事件

5.如果有source1(基于端口的)事件则立即执行跳转到第九步

6.通知监听器RunLoop即将进入休眠状态

7.将线程休眠，直到以下事件发生才会被唤醒:

有source1事件到达
定时器触发时间到达
RunLoop对象的超时时间过期
被外部显示唤醒


8.通知监听器RunLoop对象即将被唤醒

9.处理添加进来的事件，包括:

如果用户定义的定时器时间到达，执行定时器时间并重启循环，跳转到第二步
如果有source1事件，传递这个事件处理完成之后又回到第二步
如果RunLoop被显示唤醒并且没有超时则重启RunLoop，跳转到第二步

10.通知监听器RunLoop退出循环



 runloop整个事件循环机制这个解释更简洁：
  
  当runloop启动的时候会发送一个通知给observer告诉观察者runloop即将启动
  将要处理timer/source0事件（手动唤醒线程）
  正事处理source0事件
  如果有source1事件（自动唤醒线程）要处理，会跳过休眠。可通过goto语句来进行代码跳转处理source1自动唤醒时收到的消息
  如果没有source1要处理，线程会休眠，同时发送通知给observer,告诉observer要休眠
  正事休眠，等待唤醒，正式发生从用户态到内核态的切换
  等待唤醒的条件有三个：source1唤醒 timer事件的回调到了  外部手动唤醒
  线程被唤醒也发一个通知给observer通知已经唤醒
  处理唤醒后接收到的消息，再回到将要处理timer/source0事件（手动唤醒线程）的步骤
  
  
  RunLoop对象退出循环，只有切换model的时候，runloop会退出当前model的循环而再次进入新model的事件循环
  
  runloop对应的所有model中都没有事件源，这时候runloop就会退出。
  
  
  三种启动RunLoop的方式：
  如果没有一个输入源或者timer附加于runloop上，runloop就会立刻退出。前两种启动方式会重复调用runMode:beforeDate:方法。
  
 1。在此期间会处理来自输入源的数据 
 - (void)run;  

2。超时时间到达前处理事件源，超时runloop退出
- (void)runUntilDate:(NSDate *)limitDate；


3。超时时间到达或者第一个input source被处理，则runloop就会退出。
- (void)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;



二. 退出RunLoop的方式

  1。runloop没有input sources或者附加的timer，runloop就会退出，系统内部有可能会在当前线程的runloop中添加一些输入源，所以手动移除源不一定保证退出
  2。第二种启动方式runUntilDate:可以通过设置超时时间来退出runloop。
  3。runloop会运行一次，当超时时间到达或者第一个输入源被处理，runloop就会退出。或者使用CFRunLoopStop方法来退出。
  
  
想控制runloop的退出时机，而不是在处理完一个输入源事件之后就退出，那么就要重复调用runMode:beforeDate:，退出使用CFRunLoopStop(CFRunLoopGetCurrent());
  
NSRunLoop *myLoop  = [NSRunLoop currentRunLoop];
 myPort = (NSMachPort *)[NSMachPort port];
 [myLoop addPort:_port forMode:NSDefaultRunLoopMode];

BOOL isLoopRunning = YES; // global

while (isLoopRunning && [myLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

//关闭runloop的地方
- (void)quitLoop
 {
    isLoopRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
}
链接：https://www.jianshu.com/p/24f875775336


常驻线程，创建一个线程，回调方法中创建事件源，model，添加给runloop，while循环bool变量yes，中不断去运行这个事件源，在while循环外，移除runloop事件源，release事件源。
  


RunLoop与GCD、AutoreleasePool

RunLoop与GCD：
只有主队列的任务会交给runloop执行，其它队列任务由gcd自行处理
dispatchPort = _dispatch_get_main_queue_port_4CF();／／获取主队列端口号，作为事件源交给runloop去处理。


RunLoop与AutoreleasePool
任何代码最终都需添加到AutoreleasePool进行释放，为了保证这点，需要在任何代码前先创建AutoreleasePool
两个CFRunLoopObserver，一个监听RunLoop对象进入循环的事件，回调函数中先调用_wrapRunLoopWithAutoreleasePoolHandler函数，
这个函数优先级最高，内部_objc_autoreleasePoolPush函数来创建AutoreleasePool，保证自动释放池最先创建。

另一个监听器监听RunLoop对象进入休眠和退出循环的事件，同样回调_wrapRunLoopWithAutoreleasePoolHandler函数，这时设置优先级最低，保证先
调用其它指令，最后_objc_autoreleasePoolPop函数来释放其它指令的对象。

main函数就是被@autoreleasepool包围着，所以在主线程中创建的任何对象都会及时被释放。

autoreleasepool需要通过runloop才能释放旧的并创建新的autoreleasepool


为什么会有如下代码？

urls（有很多个）
- (void)btnClickedHandler
{
    NSArray *urls = ;
    for (NSURL *url in urls) {
        @autoreleasepool {//相当于把占内存的代码交给autoreleasepool释放，autoreleasepool又由runloop去创建或释放
            NSError *error;
            NSString *fileContents = [NSString stringWithContentsOfURL:url
                                        encoding:NSUTF8StringEncoding error:&error];//每一个url占用内存很大，占用资源
    }
}


RunLoop实现常驻内存的线程：
+ (void)entryPoint
{
    //设置当前线程名为MyThread
    [[NSThread currentThread] setName:@"MyThread"];
    //获取NSRunLoop对象，第一次获取不存在时系统会创建一个
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    /*
    添加一个Source1事件的监听端口，会一直监听是否有事件过来，由于Mode的Source/Observer/Timer中的Observer不为空
    RunLoop对象会一直监听这个端口，由于这个端口不会有任何事件到来所以不会产生影响
    监听模式是默认模式，可以修改为Common
    */
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    //启动RunLoop
    [runloop run];
}

+ (NSThread *)longTermThread
{
    //静态变量保存常驻内存的线程对象
    static NSThread *longTermThread = nil;
    //使用GCD dispatch_once 在应用生命周期只执行一次常驻线程的创建工作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建一个线程对象，并执行entryPoint方法
        longTermThread = [[NSThread alloc] initWithTarget:self selector:@selector(entryPoint) object:nil];
        //启动线程，启动后就会执行entryPoint方法
        [longTermThread start];
    });
    return longTermThread;
} 

- (void)viewDidLoad
{
    //获取这个常驻内存的线程
    NSThread *thread =  [ViewController longTermThread];
    //在该线程上提交任务
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:NO];
}
上面的栗子很好理解，主要利用了一个source1事件的监听，由于Mode的Source/Observer/Timer中的Observer不为空，所以RunLoop不会退出循环，能够常驻内存。
原文：https://blog.csdn.net/u014205968/article/details/78323201 





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
    post
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





下面最经典的总结：

HTTP和HTTPS协议
浏览器提示不安全链接：收集数据的http页面被标记为不安全链接
什么是HTTP?
超文本传输协议，是一个基于请求与响应，无状态的，应用层的协议，常基于TCP/IP协议传输数据
发展历史：
HTTP/0.9： 不涉及数据包传输，规定客户端和服务器之间通信格式，只能GET请求
HTTP/1.0： 传输内容格式不限制，增加PUT、PATCH、HEAD、 OPTIONS、DELETE命令 
HTTP/1.1： 持久连接(长连接)、节约带宽、HOST域、管道机制、分块传输编码
HTTP/2：   多路复用、服务器推送、头信息压缩、二进制协议等

多路复用：多个请求stream，如css,js请求stream多条线路共用一个tcp链接发出请求，并以多条线路同时返回


什么是HTTPS？
网络进行安全通信的传输协议，经由HTTP进行通信，利用SSL/TLS建立全信道，加密数据包。
对网站服务器的身份认证，同时保护交换数据的隐私与完整性。

HTTP请求方法
根据HTTP标准，HTTP请求可以使用多种请求方法。
HTTP1.0定义了三种请求方法： GET, POST 和 HEAD方法。
HTTP1.1新增了五种请求方法：OPTIONS, PUT, DELETE, TRACE 和 CONNECT 方法。

GET     请求指定的页面信息，并返回实体主体。
HEAD     类似于get请求，只不过返回的响应中没有具体的内容，用于获取报头
POST     向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的建立和/或已有资源的修改。
PUT     从客户端向服务器传送的数据取代指定的文档的内容。
DELETE      请求服务器删除指定的页面。
CONNECT     HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器。
OPTIONS     允许客户端查看服务器的性能。
TRACE     回显服务器收到的请求，主要用于测试或诊断。


三、HTTP VS HTTPS

HTTP特点：
 1.无状态：协议对客户端没有状态存储，对业务逻辑没有“记忆”能力，比如访问一个网站需要反复进行登录操作
 2.无连接：HTTP/1.1之前每次请求需要通过TCP三次握手四次挥手，和服务器重新建立连接
 3.基于请求和响应：由客户端发起请求，服务端响应
 4.简单快速、灵活
 5.通信未加密、请求和响应不会对服务端客户端身份确认、无法保护数据的安全
 
 无状态的一些解决策略：
 通过Cookie/Session技术：某些接口在一定时间内不需要重复操作，如登录接口，避免了重复建立连接
 HTTP/1.1持久连接（HTTP keep-alive）方法：任意一端没有明确提出断开连接，则在一定时间内保持TCP连接状态，请求首部字段中的Connection: keep-alive即为表明使用了持久连接
 
HTTPS特点：
  通过SSL或TLS提供加密处理数据、验证对方身份以及数据完整性保护以及通道安全建立。
  
  1.内容加密：采用混合加密技术，中间者无法直接查看明文内容
  2.验证身份：通过证书认证客户端访问的是自己的服务器
  4.保护数据完整性：防止传输的内容被中间人冒充或者篡改
  证书中包含了一个密钥对（公钥和私钥）和所有者识别信息。
  
http下tcp/ip建立三次连接流程：建立连接，同意建立连接，收到同意建立连接
  1.客户端发送syn报文，和客户端序列号x，目的是请求连接的信号
  2.服务端返回请求连接的syn报文和服务端确认序列号y,ack响应报文内容是客户端序列号x+1，目的是服务端把已经同意请求连接的事情再告诉客户端
  3.客服端发送ack响应报文内容是户服端序列号y+1，客服端序列号为z+1，目的是客户端把已经知道服务端同意进行连接的事情再告诉服务端
  4.连接建立成功
    发送请求行：
    get请求行：请求方式 请求的类型是图片还是css http版本号 （GET /562f25980001b1b106000338.jpg HTTP/1.1）
    post请求行：请求方式 http版本号（POST / HTTP1.1）
    
  5.客户端发送请求头信息和请求体：
  (get，pos都有)
  Host: www.wrox.com； 
  User-Agent: Mozilla/5.0 ； 
  Gecko/20050225 Firefox/1.0.1；
  Connection: Keep-Alive
  Accept-Encoding    gzip, deflate, sdch
  Accept-Language    zh-CN,zh;q=0.8
  name=Professional%20Ajax&publisher=Wiley(请求主体)
  （post有）
  Content-Type: application/x-www-form-urlencode
  Content-Length: 40

  最后发送一个空请求头代表请求完毕
  
  6.服务端应答
      1.状态行:http版本号和状态码和状态消息  http/1.1 200 ok
        状态码：
          1xx：指示信息--表示请求已接收，继续处理

          2xx：成功--表示请求已被成功接收、理解、接受

          3xx：重定向--要完成请求必须进行更进一步的操作

          4xx：客户端错误--请求有语法错误或请求无法实现

          5xx：服务器端错误--服务器未能实现合法的请求
     2.消息报头，用来说明客户端要使用的一些附加信息
         Date:生成响应的日期和时间；Date: Fri, 22 May 2009 06:07:21 GMT
         Content-Type:指定了MIME类型的HTML(text/html),编码类型是UTF-8 Content-Type: text/html; charset=UTF-8
         空行，消息报头后面的空行是必须的
     3.响应正文，服务器返回给客户端的文本信息
         <html>
           <head></head>
        </html>

为什么是三次握手：由于网络延时问题，客户端发送的syn请求建立连接一直没发送到客户端，当这个连接释放后，客户端又收到了请求包，就会发送应答包，然后等待
客户端再次确认，如果是两次握手，服务端就直接建立了一个已经释放的连接，空连接，浪费资源，如果最后服务端需确认客户端是否应答再建立连接就不会出现这样的情况。
  
  
http在tcp/ip下的四次挥手：关键客户端想断开连接，收到客户端想断开连接，服务端也想断开连接，收到服务端想断开连接，双方同时断开连接
   1.客户端没有数据发送了，发送一个fin报文，告诉服务器没有数据要发送
   2.服务端确认已收到客户端没有数据发送的信息，发送一个ack应答报文
   3.服务端也没有数据向客户端发送了，也发送一个fin报文告诉客户端
   4.客户端确认已经收到服务端没有数据发送了，再发送ack报文告诉服务端，这后就会彼此中断连接


https传输流程：
1.服务器向ca机构申请证书或自己制作证书：证书包含两个密钥，公钥和私钥，过期时间，认证机构签名，服务端域名信息，
自己颁发的证书需要客户端验证通过，才可以继续访问，而使用受信任的公司申请的证书则不会弹出提示页面

2.客户端发送一个请求：https://www.baidu.com，协议版本号、一个客户端生成的随机数（ Client random ），以及客户端支持的加密方法。

3.服务器确认双方使用的加密方法，以及一个服务器生成的随机数（ Server random ）。返回这个证书的公钥

4.客户端如果是浏览器，会使用本地配置的权威机构的公钥对证书进行解密，验证证书的颁发机构，过期时间，颁发签名，如果合法，则信任证书有效，
  如果发现异常，则会弹出一个警告框，提示证书存在问题，如果不是浏览器，代码也会验证证书是否合法。
  
5.确认数字证书有效后，然后生成一个新的随机数（ Premaster secret ），并使用数字证书中的公钥
（用本地权威的公钥解密拿到证书中的公钥）加密这个随机数（产生对称密钥），发给服务端。

6.服务端使用机构申请的证书中的私钥，获取客户端来的随机数（即 Premaster secret ）。

7.此时客户端和服务器都有Premaster secret ，在请求和响应的过程中，通过使用前面的三个随机数，生成"对话密钥"（ session key ）
谈话内容再通过这个对话密钥加密及解密


安全性考虑：
HTTPS协议的加密范围也比较有限，在黑客攻击、拒绝服务攻击、服务器劫持等方面几乎起不到什么作用，如公共wifi或者公共路由上
SSL证书的信用链体系并不安全，特别是在某些国家可以控制CA根证书的情况下，中间人攻击一样可行

成本考虑：
SSL证书需要购买申请，功能越强大的证书费用越高
SSL证书通常需要绑定IP，一IP上只能绑定一个域名
使用HTTPS协议会使页面的加载时间延长近50%，增加10%到20%的耗电量。
HTTPS连接缓存不如HTTP高效，流量成本高。即同时维护的tcp/ip连接数
HTTPS连接服务器端资源占用高很多，支持访客多的网站需要投入更大的成本
HTTPS协议握手阶段比较费时，对网站的响应速度有影响，影响用户体验。比较好的方式是采用分而治之，类似12306网站的主页使用HTTP协议，有关于用户信息等方面使用HTTPS。




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
      应该让一个对象对其它对象有尽可能少的了解，作到高内聚 低耦合
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
同时移动p指针，q指针不变
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








第16章  动画

# anmition
动画的继承结构

CAAnimation(动画根类，不可直接使用){
    CAPropertyAnimation（属性动画，抽象类，不能直接使用）{
        CABasicAnimation（基本动画，可直接使用）{
              CASpringAnimation（弹性动画，可直接使用，iOS9新加）
        }
        CAKeyframeAnimation（关键帧动画，可直接使用）
    }
    CATransition（转场动画，可直接使用）
    CAAnimationGroup （组动画，可直接使用）
}

1､CAAnimation 

属性：
//动画的代理回调
@property(nullable, strong) id delegate;
//动画执行完以后是否移除动画,默认YES
@property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;
//动画的动作规则,包含以下值
//kCAMediaTimingFunctionLinear 匀速
//kCAMediaTimingFunctionEaseIn 慢进快出
//kCAMediaTimingFunctionEaseOut 快进慢出
//kCAMediaTimingFunctionEaseInEaseOut 慢进慢出 中间加速
//kCAMediaTimingFunctionDefault 默认
@property(nullable, strong) CAMediaTimingFunction *timingFunction;

属性的详解：

委托：动画执行的代理，在动画开始前设定，不用显式的写在代码里，它包含两个方法：
动画开始回调
- (void)animationDidStart:(CAAnimation *)anim;
动画结束回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
removedOnCompletion：动画完成后是否移除动画默认为YES此属性为YES时，在fillMode不可用，具体为什么不可用，可以自己结合两个属性分析一下，这里不再赘述。
timingFunction设置动画速度曲线，默认值上面已经给出下面说它的几个方法：
。这两个方法是一样的如果我们对系统自带的速度函数不满意，可以通过这两个函数创建一个自己喜欢的速度曲线函数，具体用法可以参考这篇文章CAMediaTimingFunction使用的
+ (instancetype)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
- (instancetype)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
电子杂志曲线的函数的缓冲点，具体用法可以参考这篇文章：iOS-核心动画高级编程/ 10-缓冲
- (void)getControlPointAtIndex:(size_t)idx values:(float[2])ptr;



2､CAAnimation <CAMediaTiming>协议的属性

属性：
//开始时间.这个属性比较复杂,傻瓜用法为:CACurrentMediaTime() + x,
//其中x为延迟时间.如果设置 beginTime = CACurrentMediaTime() + 1.0,产生的效果为延迟一秒执行动画,下面详解原理
@property CFTimeInterval beginTime;
//动画执行时间,此属性和speed有关系speed默认为1.0,如果speed设置为2.0,那么动画执行时间则为duration*(1.0/2.0).
@property CFTimeInterval duration;
//动画执行速度,它duration的关系参考上面解释
@property float speed;
//动画的时间延迟,这个属性比较复杂,下面详解
@property CFTimeInterval timeOffset;
//重复执行次数
@property float repeatCount;
//重复执行时间,此属性优先级大于repeatCount.也就是说如果repeatDuration设置为1秒重复10次,那么它会在1秒内执行完动画.
@property CFTimeInterval repeatDuration;
//是否自动翻转动画,默认NO.如果设置YES,那么整个动画的执行效果为A->B->A.
@property BOOL autoreverses;
//动画的填充方式,默认为: kCAFillModeRemoved,包含以下值
//kCAFillModeForwards//动画结束后回到准备状态
//kCAFillModeBackwards//动画结束后保持最后状态
//kCAFillModeBoth//动画结束后回到准备状态,并保持最后状态
//kCAFillModeRemoved//执行完成移除动画
@property(copy) NSString *fillMode;


属性的详解：

BEGINTIME：刚才上面简单解释了下这个属性的用法：CACurrentMediaTime()+ x。会使动画延迟执行点¯x秒不知道到这里有没有人想过如果-x？会出现怎么样效果假设我们有执行一个3秒的动画，设置然后beginTime = CACurrentMediaTime()- 1.5那么执行动画你会发现动画只会执行后半段，就是也。只执行后面的3-1.5s的动画。为什么会这样？其实动画都有一个时间表（时间线）的概念。动画开始执行都是基于这个时间线的绝对时间，这个时间和它的父类有关（系统的属性注释可以看到）。默认的CALayer的的BEGINTIME为零，如果这个值为零的话，系统会把它设置为CACurrentMediaTime（），那么这个时间就是正常执行动画的时间：立即执行所以如果设置你beginTime=CACurrentMediaTime()+x;它会把它的执行时间线推迟x秒，就是也。晚执行x秒，如果你beginTime=CACurrentMediaTime()-x;那它开始的时候会从你动画对应的绝对时间开始执行。
timeOffset：时间偏移量，默认为0;既然它是时间偏移量，那么它即和动画时间相关这么解释：假设我们设置一个动画时间为5秒，动画执行的过程为1->2->3->4->5，这时候如果你设置timeOffset = 2s它那么的执行过程就会变成3->4->5->1->2如果你设置timeOffset = 4s那么它的执行过程就会变成5->1->2->3->4，这么说应该很明白了吧？

3､CAPropertyAnimation属性动画，抽象类，不能直接使用

属性：
//需要动画的属性值
@property(nullable, copy) NSString *keyPath;
//属性动画是否以当前动画效果为基础,默认为NO
@property(getter=isAdditive) BOOL additive;
//指定动画是否为累加效果,默认为NO
@property(getter=isCumulative) BOOL cumulative;
//此属性相当于CALayer中的transform属性,下面会详解
@property(nullable, strong) CAValueFunction *valueFunction;


属性的详解：
CAPropertyAnimation是属性动画顾名思义也就是针对属性才可以做的动画那它可以对谁的属性可以做动画是的CALayer的属性，比如：？界限，位置等那么问题来了，我们改变的CALayer的位置可以。设置直接[CAPropertyAnimation animationWithKeyPath:@"position"]如果我们设置它的变换（CATransform3D）呢？CATransform3D是一个矩阵，如果我们想为它做动画怎么办？下面这个属性就是用来解决这个问题的。

valueFunction：我们来看它可以设置的值：
kCAValueFunctionRotateX
kCAValueFunctionRotateY
kCAValueFunctionRotateZ
kCAValueFunctionScale
kCAValueFunctionScaleX
kCAValueFunctionScaleY
kCAValueFunctionScaleZ
kCAValueFunctionTranslate
kCAValueFunctionTranslateX
kCAValueFunctionTranslateY
kCAValueFunctionTranslateZ


方法
//创建一个CAPropertyAnimation对象
+ (instancetype)animationWithKeyPath:(nullable NSString *)path;

属性归总：
CATransform3D{
rotation旋转
transform.rotation.x
transform.rotation.y
transform.rotation.z

scale缩放
transform.scale.x
transform.scale.y
transform.scale.z

translation平移
transform.translation.x
transform.translation.y
transform.translation.z
}

CGPoint{
position
position.x
position.y
}

CGRect{
bounds
bounds.size
bounds.size.width
bounds.size.height

bounds.origin
bounds.origin.x
bounds.origin.y
}

property{
opacity
backgroundColor
cornerRadius
borderWidth
contents

Shadow{
shadowColor
shadowOffset
shadowOpacity
shadowRadius
}
}
总结：CAAnimation是基类，CAPropertyAnimation是抽象类，两者都不可以直接使用，那我们只有使用它的子类了。


4､CABasicAnimation基本动画

属性：
//开始值
@property(nullable, strong) id fromValue;
//结束值
@property(nullable, strong) id toValue;
//结束值
@property(nullable, strong) id byValue;

属性详解：
这三个属性之间的规则

fromValue状语从句：toValue不为空，的动画会效果从fromValue的值变化到toValue。
fromValue状语从句：byValue都不为空，的动画效果将会从fromValue变化到fromValue+byValue
toValue状语从句：byValue都不为空，的动画效果将会从toValue-byValue变化到toValue
只有fromValue的值不为空，的动画效果将会从fromValue的值变化到当前的状态。
只有toValue的值不为空，的动画效果将会从当前状态的值变化到toValue的值。
只有byValue的值不为空，动画的效果将会从当前的值变化到（当前状态的值+ byValue）的值。
CABasicAnimation看起来不太复杂，但实际只用这个就足以可以做很多种动画了

主要代码：
-(void)animationBegin:(UIButton *)btn{
        CABasicAnimation *animation = nil;
        switch (btn.tag) {
        case 0:{
        //淡如淡出
        animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [animation setFromValue:@1.0];
        [animation setToValue:@0.1];
        }break;
        case 1:{
        //缩放
        animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:@1.0];//设置起始值
        [animation setToValue:@0.1];//设置目标值
        }break;
        case 2:{
        //旋转
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        //setFromValue不设置,默认以当前状态为准
        [animation setToValue:@(M_PI)];
        }break;
        case 3:{
        //平移
        animation = [CABasicAnimation animationWithKeyPath:@"position"];
        //setFromValue不设置,默认以当前状态为准
        [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 200)]];
        }break;
        default:break;
        }
        [animation setDelegate:self];//代理回调
        [animation setDuration:0.25];//设置动画时间，单次动画时间
        [animation setRemovedOnCompletion:NO];//默认为YES,设置为NO时setFillMode有效
        /**
        *设置时间函数CAMediaTimingFunction
        *kCAMediaTimingFunctionLinear 匀速
        *kCAMediaTimingFunctionEaseIn 开始速度慢，后来速度快
        *kCAMediaTimingFunctionEaseOut 开始速度快 后来速度慢
        *kCAMediaTimingFunctionEaseInEaseOut = kCAMediaTimingFunctionDefault 中间速度快，两头速度慢
        */
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //设置自动翻转
        //设置自动翻转以后单次动画时间不变，总动画时间增加一倍，它会让你前半部分的动画以相反的方式动画过来
        //比如说你设置执行一次动画，从a到b时间为1秒，设置自动翻转以后动画的执行方式为，先从a到b执行一秒，然后从b到a再执行一下动画结束
        [animation setAutoreverses:YES];
        //kCAFillModeForwards//动画结束后回到准备状态
        //kCAFillModeBackwards//动画结束后保持最后状态
        //kCAFillModeBoth//动画结束后回到准备状态,并保持最后状态
        //kCAFillModeRemoved//执行完成移除动画
        [animation setFillMode:kCAFillModeBoth];
        //将动画添加到layer,添加到图层开始执行动画，
        //注意:key值的设置与否会影响动画的效果
        //如果不设置key值每次执行都会创建一个动画，然后创建的动画会叠加在图层上
        //如果设置key值，系统执行这个动画时会先检查这个动画有没有被创建，如果没有的话就创建一个，如果有的话就重新从头开始执行这个动画
        //你可以通过key值获取或者删除一个动画:
        //[self.demoView.layer animationForKey:@""];
        //[self.demoView.layer removeAnimationForKey:@""]
        [self.demoView.layer addAnimation:animation forKey:@"baseanimation"];
}

/**
*  动画开始和动画结束时 self.demoView.center 是一直不变的，说明动画并没有改变视图本身的位置
*/
- (void)animationDidStart:(CAAnimation *)anim{
NSLog(@"动画开始------：%@",    NSStringFromCGPoint(self.demoView.center));
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
NSLog(@"动画结束------：%@",    NSStringFromCGPoint(self.demoView.center));
}


CASpringAnimation弹性动画

属性：
//理解下面的属性的时候可以结合现实物理现象,比如把它想象成一个弹簧上挂着一个金属小球
//质量,振幅和质量成反比
@property CGFloat mass;
//刚度系数(劲度系数/弹性系数),刚度系数越大,形变产生的力就越大,运动越快
@property CGFloat stiffness;
//阻尼系数,阻止弹簧伸缩的系数,阻尼系数越大,停止越快,可以认为它是阻力系数
@property CGFloat damping;
//初始速率,动画视图的初始速度大小速率为正数时,速度方向与运动方向一致,速率为负数时,速度方向与运动方向相反.
@property CGFloat initialVelocity;
//结算时间,只读.返回弹簧动画到停止时的估算时间，根据当前的动画参数估算通常弹簧动画的时间使用结算时间比较准确
@property(readonly) CFTimeInterval settlingDuration;

代码1:
CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.y"];
spring.damping = 5;
spring.stiffness = 100;
spring.mass = 1;
spring.initialVelocity = 0;
spring.duration = spring.settlingDuration;
spring.fromValue = @(self.demoView1.center.y);
spring.toValue = @(self.demoView1.center.y + (btn.selected?+200:-200));
spring.fillMode = kCAFillModeForwards;
[self.demoView1.layer addAnimation:spring forKey:nil];

代码2:自定义弹性动画
#import "UIView+ShakeAnimation.h"
#import <objc/runtime.h>
typedef void (^RunAnimationBlock)();
@interface UIView ()
@property (nonatomic,  copy)RunAnimationBlock block;
@end

@implementation UIView (ShakeAnimation)

-(void)startAnimationFromFrame:(CGRect)framef
toFrame:(CGRect)framet
duration:(CGFloat)duration
shakeTimes:(NSInteger)times
stretchPercent:(CGFloat)stretchPercent
completion:(void (^)(BOOL finished))completion
{
self.layer.masksToBounds = YES;

__block CGFloat perTime = duration / times;
__block CGFloat perx = (framet.origin.x - framef.origin.x) * stretchPercent / times;
__block CGFloat pery = (framet.origin.y - framef.origin.y) * stretchPercent / times;
__block CGFloat perw = (framet.size.width - framef.size.width) * stretchPercent / times;
__block CGFloat perh = (framet.size.height - framef.size.height) * stretchPercent / times;

__block UIView * tmpView = self;
__block NSInteger tmpTimes = (NSInteger)times;
__block NSInteger tmpsymbol = -1;

__weak typeof(self) weakSelf = self;
self.block = ^{

[UIView animateWithDuration:perTime animations:^{

CGFloat x = framet.origin.x + perx * tmpTimes;
CGFloat y = framet.origin.y + pery * tmpTimes;
CGFloat w = framet.size.width + perw * tmpTimes;
CGFloat h = framet.size.height + perh * tmpTimes;
CGRect rect = CGRectMake(x, y, w, h);

tmpView.frame = rect;
}completion:^(BOOL finished) {

tmpTimes = tmpTimes + tmpsymbol;
tmpTimes = - tmpTimes;
tmpsymbol = - tmpsymbol;
if (tmpTimes != 0) {
weakSelf.block();
}else{
[UIView animateWithDuration:perTime animations:^{
tmpView.frame = framet;
}completion:^(BOOL finished) {
completion(YES);
}];
}
}];
};

self.block();
}
static char RunAnimationBlockKey;
-(RunAnimationBlock)block{
return objc_getAssociatedObject(self, &RunAnimationBlockKey);
}
-(void)setBlock:(RunAnimationBlock)block{
objc_setAssociatedObject(self, &RunAnimationBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
调用：

[self.demoView2 startAnimationFromFrame:CGRectMake(10, 300, 100, 100)
toFrame:CGRectMake(10, 300, 300, 100)
duration:0.5
shakeTimes:5
stretchPercent:0.3
completion:^(BOOL finished) {
NSLog(@"======over======:%@",self.demoView1);
}];



5､CAKeyframeAnimation关键帧动画
属性：
//关键帧值数组,一组变化值
@property(nullable, copy) NSArray *values;
//关键帧帧路径,优先级比values大
@property(nullable) CGPathRef path;
//每一帧对应的时间,时间可以控制速度.它和每一个帧相对应,取值为0.0-1.0,不设则每一帧时间相等.
@property(nullable, copy) NSArray<NSNumber *> *keyTimes;
//每一帧对应的时间曲线函数,也就是每一帧的运动节奏
@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;
//动画的计算模式,默认值: kCAAnimationLinear.有以下几个值:
//kCAAnimationLinear//关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
//kCAAnimationDiscrete//离散的,也就是没有补间动画
//kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
//kCAAnimationCubic对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,keyTimes跟timeFunctions失效
//kCAAnimationCubicPaced在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,,keyTimes跟timeFunctions失效
@property(copy) NSString *calculationMode;
//动画的张力,当动画为立方计算模式的时候此属性提供了控制插值,因为每个关键帧都可能有张力所以连续性会有所偏差它的范围为[-1,1].同样是此作用
@property(nullable, copy) NSArray<NSNumber *> *tensionValues;
//动画的连续性值
@property(nullable, copy) NSArray<NSNumber *> *continuityValues;
//动画的偏斜率
@property(nullable, copy) NSArray<NSNumber *> *biasValues;
//动画沿路径旋转方式,默认为nil.它有两个值:
//kCAAnimationRotateAuto//自动旋转,
//kCAAnimationRotateAutoReverse//自动翻转
@property(nullable, copy) NSString *rotationMode;

6､CAAnimationGroup动画组

属性

//只有一个属性,数组中接受CAAnimation元素
@property(nullable, copy) NSArray<CAAnimation *> *animations;

可以看到CAAnimationGroup只有一个属性一个CAAnimation数组。而且它继承于CAAnimation，它具有CAAnimation的特性，所以它的用法和CAAnimation是一样的，不同的是他可以包含ñ个动画，也就是说他可以接受很多个CAAnimation并且可以让它们一起开始，这就造成了动画效果的叠加，效果就是ñ个动画同时进行。

7､CATransition转场动画

//转场类型,字符串类型参数.系统提供了四中动画形式:
//kCATransitionFade//逐渐消失
//kCATransitionMoveIn//移进来
//kCATransitionPush//推进来
//kCATransitionReveal//揭开
//另外,除了系统给的这几种动画效果,我们还可以使用系统私有的动画效果:
//@"cube",//立方体翻转效果
//@"oglFlip",//翻转效果
//@"suckEffect",//收缩效果,动画方向不可控
//@"rippleEffect",//水滴波纹效果,动画方向不可控
//@"pageCurl",//向上翻页效果
//@"pageUnCurl",//向下翻页效果
//@"cameralIrisHollowOpen",//摄像头打开效果,动画方向不可控
//@"cameraIrisHollowClose",//摄像头关闭效果,动画方向不可控
@property(copy) NSString *type;
//转场方向,系统一共提供四个方向:
//kCATransitionFromRight//从右开始
//kCATransitionFromLeft//从左开始
//kCATransitionFromTop//从上开始
//kCATransitionFromBottom//从下开始
@property(nullable, copy) NSString *subtype;
//开始进度,默认0.0.如果设置0.3,那么动画将从动画的0.3的部分开始
@property float startProgress;
//结束进度,默认1.0.如果设置0.6,那么动画将从动画的0.6部分以后就会结束
@property float endProgress;
//开始进度
@property(nullable, strong) id filter;

CATransition也是继承CAAnimation，系统默认提供了12种动画样式，加上4个动画方向，除了方向不可控的四种效果外，大概一共提供了36种动画。

另外系统还给UIView的添加了很多分类方法可以快速完成一些简单的动画，如下：

UIView（UIViewAnimation）

@interface UIView(UIViewAnimation)

+ (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;  // additional context info passed to will start/did stop selectors. begin/commit can be nested
//提交动画
+ (void)commitAnimations;
//设置代理
+ (void)setAnimationDelegate:(nullable id)delegate;                          //设置动画开始方法
+ (void)setAnimationWillStartSelector:(nullable SEL)selector;                
//设置动画结束方法
+ (void)setAnimationDidStopSelector:(nullable SEL)selector;
//设置动画时间:default = 0.2
+ (void)setAnimationDuration:(NSTimeInterval)duration;              
//设置动画延迟开始时间:default = 0.0
+ (void)setAnimationDelay:(NSTimeInterval)delay;
//设置动画延迟开始日期:default = now ([NSDate date])
+ (void)setAnimationStartDate:(NSDate *)startDate;                  
//设置动画运动曲线:default =UIViewAnimationCurveEaseInOut
//UIViewAnimationCurveEaseInOut,//慢进慢出
//UIViewAnimationCurveEaseIn, //慢进快出
//UIViewAnimationCurveEaseOut,//快进慢出
//UIViewAnimationCurveLinear//匀速
+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;              
//设置重复次数: default = 0.0.  May be fractional
+ (void)setAnimationRepeatCount:(float)repeatCount;
//设置是否翻转动画: default = NO. used if repeat 
+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
//设置动画是否从当前状态开始:default = NO
+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;
//设置动画类型
+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache; 
//设置动画是否有效
+ (void)setAnimationsEnabled:(BOOL)enabled;
//
+ (BOOL)areAnimationsEnabled;
//
+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation
//
+ (NSTimeInterval)inheritedAnimationDuration 
@end


UIView（UIViewAnimationWithBlocks）
@interface UIView(UIViewAnimationWithBlocks)
//以下方法都大同小异,就不一一做注释了
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion 
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end


UIView（UIViewKeyframeAnimations）
+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations

//单视图转场动画
+ (void)transitionWithView:(UIView *)view
duration:(NSTimeInterval)duration 
options:(UIViewAnimationOptions)options
animations:(void (^ __nullable)(void))animations
completion:(void (^ __nullable)(BOOL finished))completion
//双视图转场动画
+ (void)transitionFromView:(UIView *)fromView
toView:(UIView *)toView 
duration:(NSTimeInterval)duration 
options:(UIViewAnimationOptions)options
completion:(void (^ __nullable)(BOOL finished))completion

这两个都是转场动画，不同的是第一个是单视图转场，第二个是双视图转场不过需要注意的是：单视图转场动画只能用作属性动画做不到的转场效果，比如属性动画不能给的UIImageView的形象赋值操作做动画效果等。

我们可以看到以上两个方法中都有一个共同的参数：
UIViewAnimationOptions
typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type

UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
UIViewAnimationOptionCurveEaseIn               = 1 << 16,
UIViewAnimationOptionCurveEaseOut              = 2 << 16,
UIViewAnimationOptionCurveLinear               = 3 << 16,

UIViewAnimationOptionTransitionNone            = 0 << 20, // default
UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
} NS_ENUM_AVAILABLE_IOS(4_0);

可以看到系统给到的是一个位移枚举，这就意味着这个枚举可以多个值同时使用，但是怎么用呢？其实那些枚举值可以分为三个部分。
我们分别看一下每个枚举的意思：
第一部分：动画效果
UIViewAnimationOptionTransitionNone//没有效果
UIViewAnimationOptionTransitionFlipFromLeft//从左水平翻转
UIViewAnimationOptionTransitionFlipFromRight//从右水平翻转
UIViewAnimationOptionTransitionCurlUp//翻书上掀
UIViewAnimationOptionTransitionCurlDown//翻书下盖UIViewAnimationOptionTransitionCrossDissolve//融合
UIViewAnimationOptionTransitionFlipFromTop//从上垂直翻转                    UIViewAnimationOptionTransitionFlipFromBottom//从下垂直翻转

第二部分：动画运动曲线
//开始慢，加速到中间，然后减慢到结束
UIViewAnimationOptionCurveEaseInOut
//开始慢，加速到结束
UIViewAnimationOptionCurveEaseIn
//开始快，减速到结束
UIViewAnimationOptionCurveEaseOut
//线性运动
UIViewAnimationOptionCurveLinear

第三部分：其他
//默认，跟父类作为一个整体
UIViewAnimationOptionLayoutSubviews
//设置了这个，主线程可以接收点击事件
UIViewAnimationOptionAllowUserInteraction
//从当前状态开始动画，父层动画运动期间，开始子层动画.
UIViewAnimationOptionBeginFromCurrentState
//重复执行动画，从开始到结束， 结束后直接跳到开始态
UIViewAnimationOptionRepeat
//反向执行动画，结束后会再从结束态->开始态
UIViewAnimationOptionAutoreverse
//忽略继承自父层持续时间，使用自己持续时间（如果存在）
UIViewAnimationOptionOverrideInheritedDuration
//忽略继承自父层的线性效果，使用自己的线性效果（如果存在）
UIViewAnimationOptionOverrideInheritedCurve
//允许同一个view的多个动画同时进行     
UIViewAnimationOptionAllowAnimatedContent     
//视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）             UIViewAnimationOptionShowHideTransitionViews
//不继承父动画设置或动画类型.
UIViewAnimationOptionOverrideInheritedOptions

这下可以看到，这些枚举功能都不一样但是可以随意组合，但是组合的时候需要注意，类型同一枚举的一起不能使用比如UIViewAnimationOptionCurveEaseIn状语从句：UIViewAnimationOptionCurveEaseOut





              
            
                  
第17章

73、iOS获取设备唯一标识 https://blog.csdn.net/u014795020/article/details/72667320
前言

目前市面应用普遍采用用户体验，涉及到部分重要功能时候才提醒用户注册账户，而用户之前的操作，比如收藏，点赞，关注等内容需要同时关联进注册的账户，那么根据什么记录用户的操作信息就尤为重要。下面就列出我之前收集资料总结的方案。

UDID

UDID（Unique Device Identifier），iOS 设备的唯一识别码，是一个40位十六进制序列（越狱的设备通过某些工具可以改变设备的 UDID），移动网络可以利用 UDID 来识别移动设备。 
许多开发者把 UDID 跟用户的真实姓名、密码、住址、其它数据关联起来，网络窥探者会从多个应用收集这些数据，然后顺藤摸瓜得到这个人的许多隐私数据，同时大部分应用确实在频繁传输 UDID 和私人信息。 为了避免集体诉讼，苹果最终决定在 iOS 5 的时候，将这一惯例废除。 
现在应用试图获取 UDID 已被禁止且不允许上架。

MAC 地址

MAC（Medium / Media Access Control）地址，用来表示互联网上每一个站点的标示符，是一个六个字节（48位）的十六进制序列。前三个字节是由 IEEE 的注册管理机构 RA 负责给不同厂家分配的”编制上唯一的标示符（Organizationally Unique Identifier)”，后三个字节由各厂家自行指派给生产的适配器接口，称为扩展标示符。 
MAC 地址在网络上用来区分设备的唯一性，接入网络的设备都有一个MAC地址，他们肯定都是唯一的。一部 iPhone 上可能有多个 MAC 地址，包括 WIFI 的、SIM 的等，但是 iTouch 和 iPad 上就有一个 WIFI 的，因此只需获取 WIFI 的 MAC 地址就好了。一般会采取 MD5（MAC 地址 + bundleID）获取唯一标识。 
但是 MAC 地址和 UDID 一样，存在隐私问题， iOS 7 之后，所有设备请求 MAC 地址会返回一个固定值，这个方法也不攻自破了。

OpenUDID

UDID 被弃用后，广大开发者需要寻找一个可以替代的 UDID，并且不受苹果控制的方案，由此，OpenUDID 成为了当时使用最广泛的开源 UDID 代替方案。OpenUDID 利用一个非常巧妙的方法在不同程序间存储标示符：在粘贴板中用了一个特殊的名称来存储标示符，通过这种方法，其他应用程序也可以获取。 
苹果在 iOS 7 之后对粘贴板做了限制，导致同一个设备上的应用间，无法再共享一个 OpenUDID。

UUID + 自己存储

UUID（Universally Unique IDentifier），通用唯一标示符，是一个32位的十六进制序列，使用小横线来连接：8-4-4-4-12，通过 NSUUID（iOS 6 之后）[NSUUID UUID].UUIDString 或者 CFUUID（iOS 2 之后） CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault))) 来获取，
但是每次获取的值都不一样，需要自己存储。keychain存储

推送 token + bundleID

推送 token 保证设备唯一，但是必须有网络情况下才能工作，该方法不依赖于设备本身，但依赖于 apple push，而 apple push 有时候会抽风的。

IDFA

IDFA-identifierForIdentifier（广告标示符），在同一个设备上的所有 APP 都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设定的。虽然 iPhone 默认是允许追踪的，而且一般用户都不知道有这么个设置，但是用户可以在 设置 - 隐私 - 广告追踪 里重置此 ID 的值，或者限制此 ID 的使用，所以有可能会取不到值。

IDFV

IDFV-identifierForVendor（Vendor 标示符），通过 [UIDevice currentDevice].identifierForVendor.UUIDString 来获取。是通过 bundleID 的反转的前两部分进行匹配，如果相同是同一个 Vendor ，例如对于 com.mayan.app_1 和 com.mayan.app_2 这两个 bundleID 来说，就属于同一个 Vendor ，共享同一个 IDFV，和 IDFA 不同的是，IDFV 的值一定能取到的，所以非常适合于作为内部用户行为分析的主 ID 来识别用户。但是用户删除了该 APP ，则 IDFV 值会被重置，再次安装此 APP ，IDFV 的值和之前的不同。

IDFV + keychain

通过以上几种存储唯一标识的方法分析，总结一下各有优劣。很多方法被苹果禁止，或者漏洞太多，越来越不被开发者利用，现在苹果主推IDFA和IDFV这两种方法，分别对外和对内，但是IDFV在App重新安装时候会被更改，所以我的方法是通过第一次生成的IDFV存储到keychain中，以后每次获取标识符都从keychain中获取。注意：keychain在iOS 7之后开放给开发者，但是在iOS 10中默认是关闭的，需要开发者手动打开。
我的项目用的是
+(NSString*) getCurrentDeviceUDID
{
    return [OpenUDID value];
}    






第18章

const,static,extern,#define super superclass class
#define 定义一般是以项目名开头，以KEY结尾 ，意为取值 
#define zlburl @"http://"  
常用的字符串 常用的代码 抽成宏
const define区别
推荐常有字符串常量的时候使用const 
NSString *const  cent = @"zlbcent";//去掉CONST是全局变量

#define是预编译时候   const编译的时候
#define不会检查错语   const会检查语法错误
#define可以定义代码   const不会定义代码
定义太多的宏会造成编译时间过长 ，const这个代码只会编译一次，宏是只要用到的地方都进行了替换 
因此常用的字符串使用const定义
一个错误的说法：大量使用宏会造成内存过大
这个说法是错误的，NSLOG("%@",zlburl)NSLOG("%@",zlburl)NSLOG("%@",zlburl)打印多次后还是同一个内存地址，因为常量会放到常量区里面，只分配一次内存

const用于修饰基本变量和指针变量，且修饰的变量指读，const一定放到变量的左边靠近变量

下面这两写法一样
int const a = 0
const int a = 0


下面有区别
int a = 5
int * const p = &a//报错
const int  *p = 3 //报错
int  const *p = 3 //报错
int const* const p = &a//报错
const int* const p = &a//报错

const修饰对象变量

NSString *const name = @"123";//123不能改
NSString const *name = @"123";//123能改

const使用场景
定义一个全局指读变量
NSString *const a = @"123";
方法中定义指读参数
-(void)test(NSString *const)name
{
   name = @"oo";//不能修改
}

static 作用：修饰一个局部变量，修饰全局变量
修饰局部变量，会延长其生命周期，只要成员运行，局部变量一直存在，局部变量只会在程序启动分配一次内存
-(void)tt
{
  static int a = 1;
  a++;
  }
修饰全局变量，只会在当前文件使用，修改了全局变量作用局

extern只能用来声明一个全局变量，不能用来定义变量，extern int a = 10 ;ctrl b 会报错
int a = 3;
extern int a;//这个不报错
作用是用来声明全局变量
c.m中  int a = 5;
b.m中要使用a ，需要extern int a;
如果 static int a = 1;  b.m extern int a 编译会报错的

全局变量定义 static const联合使用
NSString *const name = @"123";
只能在本文件夹用的全局变量
static NSString *const name = @"123";

extern const联合使用
NSString *const name = @"123";
extern NSString *const name；
为了防止全局变量冲突，所有全局变量定义到一个文件夹里
为了遵守苹果的风格，extern换成UIKIT_EXTERN

[super class] //super指向父类的标志，是一个编译标识符，不是一个指针，获取该对象的类名，而非父类，因为super的本质是拿到当前的对象去调用父类的方法
[self class]//获取该对象的类名
[self superclass]//获取该类父对象类名


项目中遇到的一个问题
创建一个person类，在使用时提示没有定义
分析：这个类有的，没定义，说明这个类没有参与编译
在xcode 中build phases --complle source添加上.m就可以了
造成原因是创建一个项目的时候下边有个选项未打勾，所以就不参与编译





第19章

数据存储

1.sqlite中插入特殊字符的方法？
   在特殊字符前面加“/”
   如：方法：keyWord = keyWord.replace("/","//");
   
2.codedata

CoreData是对SQLite数据库的封装。
Core Data使用起来相对直接使用SQLite3的API而言更加的面向对象，操作过程通常分为以下几个步骤：

创建管理上下文
创建管理上下可以细分为：加载模型文件->指定数据存储路径->创建对应数据类型的存储->创建管理对象上下方并指定存储。
经过这几个步骤之后可以得到管理对象上下文NSManagedObjectContext，以后所有的数据操作都由此对象负责。同时如果是第一次创建上下文，Core Data会自动创建存储文件（例如这里使用SQLite3存储），并且根据模型对象创建对应的表结构。
查询数据
对于有条件的查询，在Core Data中是通过谓词来实现的。首先创建一个请求，然后设置请求条件，最后调用上下文执行请求的方法。
插入数据
插入数据需要调用实体描述对象NSEntityDescription返回一个实体对象，然后设置对象属性，最后保存当前上下文即可。这里需要注意，增、删、改操作完最后必须调用管理对象上下文的保存方法，否则操作不会执行。
删除数据
删除数据可以直接调用管理对象上下文的deleteObject方法，删除完保存上下文即可。注意，删除数据前必须先查询到对应对象。
修改数据
修改数据首先也是取出对应的实体对象，然后通过修改对象的属性，最后保存上下文。

NSManagedObject：
    这个类对应数据库的一张表，这个类对象对应数据库中表的一条数据，是是NSObject的子类。
    
NSManagedObjectModel：包含一个或多个NSEntityDescription对象，NSEntityDescription记录的就是实体的描述信息。即包含了多张表
    
NSManagedObjectContext：
    用于操作数据库，对数据库进行增删查改。在多线程中不安全，如果实现多线程中操作数据库
    一个线程对应一个NSManagedObjectContext。
    
NSPersistentStoreCoordinator:
    决定数据存储的位置 (SQLite/XML/其它文件中)，NSManagedObjectContext多个对	象
    可以使用NSPersistentStoreCoordinator同一个对象实例，多对一，因为NSManagedObjectContext会在使用NSPersistentStoreCoordinator
    前上锁，NSPersistentStoreCoordinator对象相当于存储在本地的数据库，NSManagedObjectContext对其进行增删查改。
    
    
CoreData 数据库增删查改：https://www.jianshu.com/p/332cba029b95
    1。xcode创建项目的时候，勾选Use Core Data 会自动创建coreData模型文件，
    不勾选，右键新建文件，选Data Model创建一个模型文件
    
    2。选中模型文件，创建多个实体，及多张表，创建一个Student 实体（第一字母必须是大写），以及添加一些name、age、sex 等属性
    Add Entity:创建一个实体，即创建一张表
    Attribues:添加属性 类型
    Releationships:表之间的关系，如一对多，多对多，一对一
    
    3。避免崩溃
    选中student实体，最右边第三个图标点开codegen(代码生成)选：Manual/none
    最右边第一个图标点开：code generation - lanuage(代码生成语言)object-c
    
    4。生成对应实体的实体类 editor - create NSManagedObject subclass
    生成如下文件：
    Student+CoreDataProperties.h
    Student+CoreDataProperties.m
    Student+CoreDataClass.h
    Student+CoreDataClass.m
    
    5。生成上下文和数据库关联
            //创建数据库
         - (void)createSqlite{
    
        //1、创建模型对象
        //获取模型路径
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        //根据模型文件创建模型对象
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
        //2、创建持久化存储助理：数据库
        //利用模型对象创建助理对象
        NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
        //数据库的名称和路径
        NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
        NSLog(@"数据库 path = %@", sqlPath);
        NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
        NSError *error = nil;
        //设置数据库相关信息 添加一个持久化存储库并设置类型和路径，NSSQLiteStoreType：SQLite作为存储库
        [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
        if (error) {
            NSLog(@"添加数据库失败:%@",error);
        } else {
            NSLog(@"添加数据库成功");
        }
    
        //3、创建上下文 保存信息 对数据库进行操作
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
   
        //关联持久化助理
        context.persistentStoreCoordinator = store;
        _context = context;

    }
    
    6。Appdelegate中创建数据库助理对象
             AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
             NSPersistentContainer * container = appDelegate.persistentContainer;
    
             //返回沙盒中存储数据库的文件夹URL路径，这是一个静态方法，表示数据库的文件路径是唯一的
             NSURL * url = [NSPersistentContainer defaultDirectoryURL];
    
             NSManagedObjectContext *viewContext = container.viewContext;
    
             NSManagedObjectModel *managedObjectModel = container.managedObjectModel;
    
             NSPersistentStoreCoordinator *persistentStoreCoordinator = container.persistentStoreCoordinator;

             //使用存储调度器快速在多线程中操作数据库，效率非常高(比主线程操作块50倍！！！)
             - (void)performBackgroundTask:(void (^)(NSManagedObjectContext *))block;
             
    7。增删查排序
       5.增删改查排

       写入数据

       // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
       Student * student = [NSEntityDescription  insertNewObjectForEntityForName:@"Student"  inManagedObjectContext:_context];
    
       //2.根据表Student中的键值，给NSManagedObject对象赋值
       student.name = [NSString stringWithFormat:@"Mr-%d",arc4random()%100];
       student.age = arc4random()%20;
       student.sex = arc4random()%2 == 0 ?  @"美女" : @"帅哥" ;
       student.height = arc4random()%180;
       student.number = arc4random()%100

       //   3.保存插入的数据
       NSError *error = nil;
       if ([_context save:&error]) {
          [self alertViewWithMessage:@"数据插入到数据库成功"];
        }else{
           [self alertViewWithMessage:[NSString stringWithFormat:@"数据插入到数据库失败, %@",error]];
        }



       删除数据

       - (void)deleteData{
   
       //创建删除请求
       NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
       //删除条件
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %d", 10];
       deleRequest.predicate = pre;
   
       //返回需要删除的对象数组
       NSArray *deleArray = [_context executeFetchRequest:deleRequest error:nil];
    
       //从数据库中删除
       for (Student *stu in deleArray) {
        [_context deleteObject:stu];
        }
   
       NSError *error = nil;
       //保存--记住保存
       if ([_context save:&error]) {
          [self alertViewWithMessage:@"删除 age < 10 的数据"];
       }else{
          NSLog(@"删除数据失败, %@", error);
        }
       }


      更新修改

     //更新，修改
     - (void)updateData{
    
       //创建查询请求
       NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
       NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"帅哥"];
       request.predicate = pre;
    
       //发送请求
       NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
       //修改
       for (Student *stu in resArray) {
          stu.name = @"且行且珍惜_iOS";
       }
  
       //保存
       NSError *error = nil;
       if ([_context save:&error]) {
           [self alertViewWithMessage:@"更新所有帅哥的的名字为“且行且珍惜_iOS”"];
       }else{
           NSLog(@"更新数据失败, %@", error);
       }  
      }
      
      排序

     //排序
     - (void)sort{
        //创建排序请求
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
       //实例化排序对象
       NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
       NSSortDescriptor *numberSort = [NSSortDescriptor sortDescriptorWithKey:@"number"ascending:YES];
       request.sortDescriptors = @[ageSort,numberSort];
       //发送请求
       NSError *error = nil;
       NSArray *resArray = [_context executeFetchRequest:request error:&error];
       if (error == nil) {
          [self alertViewWithMessage:@"按照age和number排序"];
        }else{
           NSLog(@"排序失败, %@", error);
        }
      }
      
      CoreData调试:

      打开Product，选择Edit Scheme.
      选择Arguments，在下面的ArgumentsPassed On Launch中添加下面两个选项，如图：
     (1)-com.apple.CoreData.SQLDebug
     (2)1





CoreData 数据库迁移：
    NSManagedObjectModel托管对象模型变化，就必须要数据库迁移。
    引起变化：
        新增了一张表，即新增了一个实体
        新增一个实体的一个属性，即新增了一个表中的一个字段
        把一个实体的某个属性迁移到另外一个实体的某个属性里面，即把一张表中的字段移到别一张表中
        删除一个字段
        可选字段变为必选字段
  1.自动迁移，有可能数据太多，自动迁移会占用很多内存
  2.手动迁移可解决内存问题，更灵活。
  
  自动迁移案例：
      原理： 添加一个新模型，代码打开数据库迁移开关，把旧模型中字段遍列与新模型字段进行对比，最后把字段移到新模型中
      1。创建一个model版本。editor->Add Model Version 取名为：Model2.xcdatamodel，这时候xcode左边会有之前的model和现在的model
      2。选择新建的这个model版本为当前要使用的。 xcode右边 model version 选择model2
      3。修改新数据模型Model2,如增加一些字段
      4。设置数据库参数options，打开数据库升级迁移的开关
       //创建持久化存储助理：数据库
        NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
       //请求自动轻量级迁移
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
         NSError *error = nil;
        //设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
      [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:options error:&error];
      这里说一下新增加的2个参数的意义：
       NSMigratePersistentStoresAutomaticallyOption = YES，那么Core Data会试着把之前低版本的出现不兼容的持久化存储区迁移到新的模型中，
       这里的例子里，Core Data就能识别出是新表，就会新建出新表的存储区来。
       NSInferMappingModelAutomaticallyOption = YES,这个参数的意义是Core Data会根据自己认为最合理的方式去尝试MappingModel，
       从源模型实体的某个属性，映射到目标模型实体的某个属性。
       
       
       
3。简单描述下客户端的缓存机制？
    缓存可以分为：内存数据缓存、数据库缓存、文件缓存   
    每次想获取数据的时候
    先检测内存中有无缓存
    再检测本地有无缓存(数据库\文件)
    最终发送网络请求
    将服务器返回的网络数据进行缓存（内存、数据库、文件）， 以便下次读取
    
4。什么是序列化和反序列化，用来做什么

   序列化把对象转化为字节序列的过程
   反序列化把字节序列恢复成对象
   把对象写到文件或者数据库中，并且读取出来
   
5。OC中实现复杂对象的存储

   遵循NSCoding协议，实现复杂对象的存储，实现该协议后可以对其进行打包或者解包，转化为NSDate

7。iOS中常用的数据存储方式有哪些？
   
   数据存储有四种方案，NSUserDefault,KeyChain（删除app后存储的文件不会消失）,File,DB.
   其中File有三种方式：plist,Archiver（对象存储，nscoding协议）,Stream
    DB包括core Data和FMDB
    
8。说一说你对SQLite的认识
   SQLite是目前主流的嵌入式关系型数据库，其最主要的特点就是轻量级、跨平台，当前很多嵌入式操作系统都将其作为数据库首选。
   功能也绝不亚于很多大型关系数据库
   和其他数据库相比，SQLite中的SQL语法并没有太大的差别
   SQLite数据库的几个特点：
     基于C语言开发的轻型数据库
     在iOS中需要使用C语言语法进行数据库操作、访问（无法使用ObjC直接访问，因为libqlite3框架基于C语言编写）
     SQLite中采用的是动态数据类型，即使创建时定义了一种类型，在实际操作时也可以存储其他类型，但是推荐建库时使用合适的类型
     建立连接后通常不需要关闭连接（尽管可以手动关闭）
   SQLite数据库操作：
     sqlite3_open()打开数据库会指定一个数据库文件保存路径，文件存在则直接打开，否则创建并打开，
     会得到一个sqlite3类型的对象，后面需要借助这个对象进行其他操作
     执行SQL语句，执行SQL语句又包括有返回值的语句和无返回值语句。
     对于无返回值的语句（如增加、删除、修改等）直接通过sqlite3_exec()函数执行；
     对于有返回值的语句则首先通过sqlite3_prepare_v2()进行sql语句评估（语法检测），然后通过sqlite3_step()依次取出查询结果的每一行数据，对于每行数据都可以通过对应的sqlite3_column_类型()方法获得对应列的数据，如此反复循环直到遍历完成。当然，最后需要释放句柄。

9。说一说你对FMDB的认识     
    FMDB是一个处理数据存储的第三方框架，框架是对sqlite的封装，整个框架非常轻量级但又不失灵活性，而且更加面向对象
    特点：
      FMDB引入了一个MFDatabase对象来表示数据库，打开数据库和后面的数据库操作全部依赖此对象。
      FMDB中FMDatabase类提供了两个方法executeUpdate:和executeQuery:分别用于执行无返回结果的查询和有返回结果的查询。
      当然这两个方法有很多的重载这里就不详细解释了。唯一需要指出的是，如果调用有格式化参数的sql语句时，格式化符号使用“?”
      而不是“%@”、等。
      libsqlite3进行数据库操作其实是线程不安全的，在多线程中使用FMDatabaseQueue对象，相比FMDatabase而言，它是线程安全的。
      在FMDB中FMDatabase有beginTransaction、commit、rollback三个方法进行开启事务、提交事务和回滚事务。在Core Data中大家也可以发现，
      所有的增、删、改操作之后必须调用上下文的保存方法，其实本身就提供了事务的支持 
      
10。如果后期需要增加数据库中的字段怎么实现，如果不使用CoreData呢？
     编写SQL语句来操作原来表中的字段
     增加表字段：ALTER TABLE 表名 ADD COLUMN 字段名 字段类型;
     删除表字段：ALTER TABLE 表名 DROP COLUMN 字段名;
     修改表字段：ALTER TABLE 表名 RENAME COLUMN 旧字段名 TO 新字段名;

11。说说数据库的左连接和右连接的区别，如果有A，B两张表，A表有3条数据，B表有4条数据，通过左连接和右连接，查询出的数据条数最少是多少条？最多是多少条？

   数据库左连接和右连接的区别：
   主表不一样通过左连接和右连接，最小条数为3（记录条数较小的记录数），最大条数为12（3×4）
  （1）左连接：只要左边表中有记录，数据就能检索出来，而右边有的记录必要在左边表中有的记录才能被检索出来
  （2）右连接：右连接是只要右边表中有记录，数据就能检索出来
  
12。iOS 的沙盒目录结构是怎样的？ App Bundle 里面都有什么？
    沙盒结构

    Application：存放程序源文件，上架前经过数字签名，上架后不可修改
    Documents：常用目录，iCloud备份目录，存放数据,这里不能存缓存文件,否则上架不被通过
    Library

    Caches：存放体积大又不需要备份的数据,SDWebImage缓存路径就是这个
    Preference：设置目录，iCloud会备份设置信息


    tmp：存放临时文件，不会被备份，而且这个文件下的数据有可能随时被清除的可能


    App Bundle 里面有什么

    Info.plist:此文件包含了应用程序的配置信息.系统依赖此文件以获取应用程序的相关信息
    可执行文件:此文件包含应用程序的入口和通过静态连接到应用程序target的代码
    资源文件:图片,声音文件一类的
    其他:可以嵌入定制的数据资源

13。你会如何存储用户的一些敏感信息，如登录的 token
    使用keychain来存储,也就是钥匙串,使用keychain需要导入Security框架

14。使用 NSUserDefaults 时，如何处理布尔的默认值？(比如返回 NO，不知道是真的 NO 还是没有设置过)
if([[NSUserDefaults standardUserDefaults] objectForKey:ID] == nil){
    NSLog(@"没有设置");
}

15。MD5和Base64的区别是什么，各自使用场景是什么？
    MD5：是一种不可逆的摘要算法，用于生成摘要，无法逆着破解得到原文。常用的是生成32位摘要，用于验证数据的有效性。比如，在网络请求接口中，通过将所有的参数生成摘要，客户端和服务端采用同样的规则生成摘要，这样可以防篡改。又如，下载文件时，通过生成文件的摘要，用于验证文件是否损坏。
    Base64：属于加密算法，是可逆的，经过encode后，可以decode得到原文。在开发中，有的公司上传图片采用的是将图片转换成base64字符串，再上传。在做加密相关的功能时，通常会将数据进行base64加密/解密。

16。plist文件是用来做什么的。一般用它来处理一些什么方面的问题。

plist是iOS系统中特有的文件格式。我们常用的NSUserDefaults偏好设置实质上就是plist文件操作。plist文件是用来持久化存储数据的。
我们通常使用它来存储偏好设置，以及那些少量的、数组结构比较复杂的不适合存储数据库的数据。比如，我们要存储全国城市名称和id，
那么我们要优先选择plist直接持久化存储，因为更简单。

17。怎么解决sqlite锁定的问题
1>  设置数据库锁定的处理函数
int sqlite3_busy_handler(sqlite3*, int(*)(void*,int), void*);
函数可以定义一个回调函数，当出现数据库忙时，sqlite会调用该函数
当回调函数为ＮＵＬＬ时，清除busy handle，申请不到锁直接返回
回调函数的第二个函数会被传递为该由此次忙事件调用该函数的次数
回调函数返回非０,数据库会重试当前操作，返回０则当前操作返回SQLITE_BUSY

2>  设定锁定时的等待时间
int sqlite3_busy_timeout(sqlite3*, 60); 
定义一个毫秒数，当未到达该毫秒数时，sqlite会sleep并重试当前操作
如果超过ms毫秒，仍然申请不到需要的锁，当前操作返回sqlite_BUSY
当ms<=0时，清除busy handle，申请不到锁直接返回





第20章  UI 面试题

1。动态的去拉伸图片
    方法1：代码拉伸
    设置topCapHeight、leftCapWidth、bottomCapHeight、lerightCapWidth,图中的黑色区域就是图片拉伸的范围，也就是说边上的不会被拉伸
    iOS6： 
    
   // UIImageResizingModeTile, // 平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeStretch, // 拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
        // 加载图片
    UIImage *image = [UIImage imageNamed:@"chat_send_nor"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    // 设置按钮的背景图片
    [btn setBackgroundImage:newImage forState:UIControlStateNormal];

   方法2：
   1。重做一张较小的图片，只做左上角的小尾巴!
   2。选中此图片，在xcode右边属性silcing中设置参数即可拉伸
   
   
2。控制器 View的生命周期及相关函数是什么？你在开发中是如何用的？
     每次访问UIViewController的view，如果view为nil就会调用loadView方法
     如删除绑定一个控制器的xib view，就会不断的调用loadView方法
     loadView方法，就是给我们自定义UIViewController的view用的，在loadView方法中写自己创建的view，不需要[super loadView]
     [super loadView]会自动创建一个空白的view
1.首先判断控制器是否有视图，如果没有就调用loadView方法创建：通过storyboard或者代码；
2.随后调用viewDidLoad，可以进行下一步的初始化操作；只会被调用一次；
3.在视图显示之前调用viewWillAppear；该函数可以多次调用；
4.视图viewDidAppear
5.在视图消失之前调用viewWillDisappear；该函数可以多次调用；
如需要）；
6.在布局变化前后，调用viewWill/DidLayoutSubviews处理相关信息；


3.Size Classes 具体使用
对屏幕进行分类

4.使用 drawRect有什么影响？
displayIfNeeded立即执行drawRect
drawRect 方法依赖 Core Graphics 框架来进行自定义的绘制
缺点：它处理 touch 事件时每次按钮被点击后，都会用 setNeddsDisplay 进行强制重绘；
而且不止一次，每次单点事件触发两次执行。这样的话从性能的角度来说，对 CPU 和内存来说都是欠佳的
。这个方法的调用机制也是非常特别. 当你调用 setNeedsDisplay 方法时, UIKit 将会把当前图层标记为 dirty,
但还是会显示原来的内容,直到何适的时间下一次的视图渲染周期,才会将标记为 dirty 的图层重新建立 Core Graphics 上下文,
然后将内存中的数据恢复出来, 再使用 CGContextRef 进行绘制

drawrect方法不调用：
UIView初始化时没有设置rect大小
设置contentMode属性值为UIViewContentModeRedraw
通过设置contentMode属性值为UIViewContentModeRedraw，那么将在每次设置或更改frame的时候自动调用drawRect:
rect不能为0不调用
初始化一个view的时候，没有使用initWithFrame，不调用




3。描述下 SDWebImage里面给 UIImageView加载图片的逻辑

1.入口setImageWithURL:placeholderImage:options: 会先把placeholderImage 显示，然后 SDWebImageManager 根据 URL 开始处理图片。
2.进入 SDWebImageManager-downloadWithURL:delegate:options:userInfo: 交给 SDImageCache 从缓存查找图片是否已经下载queryDiskCacheForKey:delegate:userInfo:
3.先从内存图片缓存查找是否有图片，如果内存中已经有图片缓存，SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo: 到 SDWebImageManager。
4.SDWebImageManagerDelegate 回调 webImageManager:didFinishWithImage: 到UIImageView+WebCache 等前端展示图片。
5.如果内存缓存中没有，生成 NSInvocationOperation 添加到队列开始从硬盘查找图片是否已经缓存。
6.根据 URLKey 在硬盘缓存目录下尝试读取图片文件。这一步是在 NSOperation 进行的操作，所以回主线程进行结果回调notifyDelegate:
7.如果上一操作从硬盘读取到了图片，将图片添加到内存缓存中（如果空闲内存过小，会先清空内存缓存）。SDImageCacheDelegate 回调imageCache:didFindImage:forKey:userInfo: 进而回调展示图片。
8.如果从硬盘缓存目录读取不到图片，说明所有缓存都不存在该图片，需要下载图片，回调 imageCache:didNotFindImageForKey:userInfo:
9.共享或重新生成一个下载器 SDWebImageDownloader 开始下载图片。
10.图片下载由 NSURLConnection 来做，实现相关 delegate 来判断图片下载中、下载完成和下载失败。
11.connection:didReceiveData: 中利用 ImageIO 做了按图片下载进度加载效果。
12.connectionDidFinishLoading: 数据下载完成后交给 SDWebImageDecoder 做图片解码处理。
13.图片解码处理在一个 NSOperationQueue 完成，不会拖慢主线程 UI。如果有需要对下载的图片进行二次处理，最好也在这里完成，效率会好很多。
14.在主线程notifyDelegateOnMainThreadWithInfo: 宣告解码完成，imageDecoder:didFinishDecodingImage:userInfo: 回调给 SDWebImageDownloader。
15.imageDownloader:didFinishWithImage: 回调给 SDWebImageManager 告知图片下载完成。
16.通知所有的 downloadDelegates 下载完成，回调给需要的地方展示图片。
17.将图片保存到 SDImageCache 中，内存缓存和硬盘缓存同时保存。写文件到硬盘也在以单独 NSInvocationOperation 完成，避免拖慢主线程。
18.SDImageCache 在初始化的时候会注册一些消息通知，在内存警告或退到后台的时候清理内存图片缓存，应用结束的时候清理过期图片。
19.SDWebImage 也提供了UIButton+WebCache 和 MKAnnotationView+WebCache，方便使用。
20.SDWebImagePrefetcher 可以预先下载图片，方便后续使用。

4。控制器的生命周期
-[ViewController initWithNibName:bundle:]；
-[ViewController init]；
-[ViewController loadView]；
-[ViewController viewDidLoad]；
-[ViewController viewWillAppear:]；
-[ViewController viewDidAppear:]；
-[ViewController viewWillDisappear:]；
-[ViewController viewDidDisappear:]；

// 自定义控制器 view，这个方法只有实现了才会执行
- (void)loadView
{
self.view = [[UIView alloc] init];
self.view.backgroundColor = [UIColor orangeColor];
}
// view 是懒加载，只要 view 加载完毕就调用这个方法
- (void)viewDidLoad
{
[super viewDidLoad];

NSLog(@"%s",__func__);
}

// view 即将显示
- (void)viewWillAppear:(BOOL)animated
{
[super viewWillAppear:animated];

NSLog(@"%s",__func__);
}
// view 即将开始布局子控件
- (void)viewWillLayoutSubviews
{
[super viewWillLayoutSubviews];

NSLog(@"%s",__func__);
}
// view 已经完成子控件的布局
- (void)viewDidLayoutSubviews
{
[super viewDidLayoutSubviews];

NSLog(@"%s",__func__);
}
// view 已经出现
- (void)viewDidAppear:(BOOL)animated
{
[super viewDidAppear:animated];

NSLog(@"%s",__func__);
}
// view 即将消失
- (void)viewWillDisappear:(BOOL)animated
{
[super viewWillDisappear:animated];

NSLog(@"%s",__func__);
}
// view 已经消失
- (void)viewDidDisappear:(BOOL)animated
{
[super viewDidDisappear:animated];

NSLog(@"%s",__func__);
}
// 收到内存警告
- (void)didReceiveMemoryWarning
{
[super didReceiveMemoryWarning];

NSLog(@"%s",__func__);
}
// 方法已过期，即将销毁 view
- (void)viewWillUnload
{
}
// 方法已过期，已经销毁 view
- (void)viewDidUnload
{
}


5。你是怎么封装一个 view的
可以通过纯代码或者 xib 的方式来封装子控件
建立一个跟 view 相关的模型，然后将模型数据传给 view，通过模型上的数据给 view的子控件赋值
/**
* 纯代码初始化控件时一定会走这个方法
*/
- (instancetype)initWithFrame:(CGRect)frame
{
if(self = [super initWithFrame:frame])
{
[self setup];
}

return self;
}

/**
* 通过 xib初始化控件时一定会走这个方法
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
if(self = [super initWithCoder:aDecoder])
{
[self setup];
}

return self;
}

- (void)setup
{
// 初始化代码
}


6。如何进行适配
通过判断版本来控制，来执行响应的代码
功能适配：保证同一个功能在哪里都能用
UI 适配：保证各自的显示风格
// iOS版本适配
#define iOS11 ([[UIDevice currentDevice].systemVersion
doubleValue]>=11.0)

7。如何渲染 UILabel的文字？

通过 NSAttributedString/NSMutableAttributedString（富文本）

8。UIScrollView 的 contentSize能否在viewDidLoad中设置？
能
因为 UIScrollView 的内容尺寸是根据其内部的内容来决定的，所以是可以在viewDidLoad 中设置的。
补充：（这仅仅是一种特殊情况）
前提，控制器 B 是控制器 A 的一个子控制器，且控制器 B 的内容只在控制器 A 的view 的部分区域中显示。
假设控制器 B 的 view 中有一个 UIScrollView 这样一个子控件。
如果此时在控制器 B 的 viewDidLoad 中设置 UIScrollView 的 contentSize 的话会导致不准确的问题。
因为任何控制器的 view 在 viewDidLoad 的时候的尺寸都是不准确的，
如果有子控件的尺寸依赖父控件的尺寸，在这个方法中设置会导致子控件的 frame 不准确，所以这时应该-(void)viewDidLayoutSubviews;方法中设置子控件的尺寸。



9。iOS 循环渐进轮播

用UICollectionView实现的支持水平和垂直两个方向上的的分页和渐进循环轮播效果
偏移量设置成初始状态并不代表scrollview会发生滚动，但是必须把动画关掉
思路	1：
图0  图1  图2
将middle的图片设为"图1", 然后将scrollView的偏移量设置成初始状态(注意,不能开启动画, 否则露馅);
将left的图片设置成"图0", 将right的图片设置成"图2";
然后就变成了这样的:

思路2：
  图3   图0  图1   图2   图3  图0
  in0  in1  in2   in3  in4  in5
  
  标号为0-3的四张图来轮播，在首位置多插入一张图3，在末位置多插入一张图0
  
  当处在上图所示的位置, 并且向右滑动之后, 显示的是"图3"(也就是index = 0);
  这时候, 后台需要做的事情是:
  悄悄地将index = 0 变成 index = 4;
   同样的, 当向左滑到最右侧的"图3"的时候, 后台需要做的是:
   悄悄地将index = 5 变成 index = 1;
    通过这种思路实现无线轮播.

3,两种思路的优劣对比
其实两种思路差别并不是很大, 主要的优劣是这样的:
思路A :  
优点: 只需要创建三个图片框, 占用内存少;
缺点: 实现思路稍微复杂一点, 而且代码比较多; 在实际使用里面, 当网速比较慢的时候, 首次加载图片变慢的话可能会出现滚动灰色背景的画面.
思路B :
优点: 实现思路比较简单, 而且代码量少, 容易理解一点, 而且相对于A,网速慢的情况下出现轮播灰色背景框的几率少一点;
缺点: 创建比较多的图片框, 占用内存比较多一点




10.iOS 全屏侧滑手势/UIScrollView/UISlider间滑动手势冲突
https://www.jianshu.com/p/a9a322052f26
问题1：一个侧滑控件，右边是一个控制器a，点击控制器a push到控制器b，控制器b是一个uiscrollview，当uiscrollview偏移是0的时候，
右滑，应该pop到控制器a,但是结果不然，而是在scrollview上出现空白的区域

如果你了解事件的传递和响应链机制的话，应该能想到，是由于UIScrollView的内部手势方法阻断了全屏侧滑返回手势的的响应，
那我们就找到这个方法，代码如下 ；
创建一个UIScrollView的类别UIScrollView+GestureConflict，重写如下方法：

//处理UIScrollView上的手势和侧滑返回手势的冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;//则scrollview支持这个全屏侧滑返回手势
        }
    }
    return NO;
}


问题2：控制器b是一个uiscrollview,scrollview上添加了一个uislider,点击uislider滑杆滑动时没反应，必须长按滑杆150秒后拖动才有反应

方案一：这个跟UIScrollView的一个属性delaysContentTouches有关。
scrollView.delaysContentTouches = NO;
delaysContentTouches 默认值为YES 表示延迟scrollView上子视图的响应，所以当直接拖动UISlider时，如果此时touch时间在150ms以内，UIScrollView会认为是拖动自己，从而拦截了event，导致UISlider接收不到滑动的event。但是只要长按住UISlider一会儿再拖动，此时touch时间超过150ms，因此滑动的event会发送到UISlider上，然后UISlider再作出响应；设置为NO后，拖动UISlider时就可以直接做出响应，解决了UISlider与UIScrollView之间的冲突，同时也解决了向右拖拽时却触发了全屏侧滑pop返回的问题。


方案二： 重写类别UIScrollView+GestureConflict中的如下方法来解决UISlider与UIScrollView之间的冲突，然后还需要执行下面 问题补充 中的操作来处理UISlider的滑动与全屏侧滑pop返回事件的冲突。
//拦截事件的处理 事件传递给谁，就会调用谁的hitTest:withEvent:方法。
//处理UISlider的滑动与UIScrollView的滑动事件冲突
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /*
     直接拖动UISlider，此时touch时间在150ms以内，UIScrollView会认为是拖动自己，从而拦截了event，导致UISlider接受不到滑动的event。但是只要按住UISlider一会再拖动，此时此时touch时间超过150ms，因此滑动的event会发送到UISlider上。
     */
    UIView *view = [super hitTest:point withEvent:event];
    
    if([view isKindOfClass:[UISlider class]]) {
        //如果接收事件view是UISlider,则scrollview禁止响应滑动
        self.scrollEnabled = NO;
    } else {   //如果不是,则恢复滑动
        self.scrollEnabled = YES;
    }
    return view;
}

示例Demo中的UISlider是在UIScrollView上的，如果UISlider不是在UIScrollView上，
而是直接就在ViewControllerb.view上，那也就会出现拖拽UISlider时却响应了全屏侧滑pop返回手势的问题。



在支持全屏侧滑返回的UINavigationController的子类WSLNavigatioController中，遵守协议<UIGestureRecognizerDelegate>,实现如下方法：

#pragma mark -- UIGestureRecognizerDelegate
//触发之后是否响应手势事件
//处理侧滑返回与UISlider的拖动手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //如果手势是触摸的UISlider滑块触发的，侧滑返回手势就不响应
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}


11.WKWebView

在开发过程中，iOS 中实现加载 web 页面主要有两种控件，UIWebView 和 WKWebview，两种控件对应具体的实现方法不同。WKWebView 是苹果在iOS 8中引入的新组件，目的是提供一个现代的支持最新Webkit功能的网页浏览控件，摆脱过去 UIWebView的老、旧、笨，特别是内存占用量巨大的问题。它使用与Safari中一样的Nitro JavaScript引擎，大大提高了页面js执行速度。的。 
相比于UIWebView的优势： 
在性能、稳定性、占用内存方面有很大提升； 
允许JavaScript的Nitro库加载并使用（UIWebView中限制） 
增加加载进度属性：estimatedProgress，不用在自己写假进度条了 
支持了更多的HTML的属性

具体分析WKWebView的优劣势 
1.内存占用是UIWebView的1/4~1/3 
2.页面加载速度有提升，有的文章说它的加载速度比UIWebView提升了一倍左右。 
3.更为细致地拆分了 UIWebViewDelegate 中的方法 
4.自带进度条。不需要像UIWebView一样自己做假进度条（通过NJKWebViewProgress和双层代理技术实现），技术复杂度和代码量，根贴近实际加载进度优化好的多。 
5.允许JavaScript的Nitro库加载并使用（UIWebView中限制） 
6.可以和js直接互调函数，不像UIWebView需要第三方库WebViewJavascriptBridge来协助处理和js的交互。 
7.不支持页面缓存，需要自己注入cookie,而UIWebView是自动注入cookie。 
8.无法发送POST参数问题

最近项目中的UIWebView被替换为了WKWebView，因此来总结一下。
示例Demo：WKWebView的使用
本文将从以下几方面介绍WKWebView：

1、WKWebView涉及的一些类
2、WKWebView涉及的代理方法
3、网页内容加载进度条和title的实现
4、JS和OC的交互
5、本地HTML文件的实现


一、WKWebView涉及的一些类

WKWebView：网页的渲染与展示

    注意： #import <WebKit/WebKit.h>
     //初始化
       _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        //可返回的页面列表, 存储已打开过的网页 
       WKBackForwardList * backForwardList = [_webView backForwardList];

        //        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.chinadaily.com.cn"]];
        //        [request addValue:[self readCurrentCookieWithDomain:@"http://www.chinadaily.com.cn"] forHTTPHeaderField:@"Cookie"];
        //        [_webView loadRequest:request];
        //页面后退
        [_webView goBack];
        //页面前进
         [_webView goForward];
        //刷新当前页面
        [_webView reload];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC.html" ofType:nil];
        NSString *htmlString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
      //加载本地html文件
        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        



WKWebViewConfiguration：为添加WKWebView配置信息

       //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        config.requiresUserActionForMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = @"ChinaDailyForiPad";
         //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"]; 
       config.userContentController = wkUController;
        


WKUserScript：用于进行JavaScript注入

    //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];



WKUserContentController：这个类主要用来做native与JavaScript的交互管理


      //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法，设置处理接收JS方法的代理
        [wkUController addScriptMessageHandler:self  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:self  name:@"jsToOcWithPrams"];
        config.userContentController = wkUController;
       //用完记得移除
       //移除注册的js方法
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcNoPrams"];
       [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcWithPrams"];


WKScriptMessageHandler：这个协议类专门用来处理监听JavaScript方法从而调用原生OC方法，和WKUserContentController搭配使用。

注意：遵守WKScriptMessageHandler协议，代理是由WKUserContentControl设置

   //通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
    //用message.body获得JS传出的参数体
    NSDictionary * parameter = message.body;
    //JS调用OC
    if([message.name isEqualToString:@"jsToOcNoPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:@"不带参数" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if([message.name isEqualToString:@"jsToOcWithPrams"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"js调用到了oc" message:parameter[@"params"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


二、WKWebView涉及的代理方法

WKNavigationDelegate  ：主要处理一些跳转、加载处理操作


    // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
    // 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
} 
    // 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getCookie];
}
    //提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}  
   // 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {   
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
    
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
} 
    //需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}
    //进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
}



WKUIDelegate ：主要处理JS脚本，确认框，警告框等


 /**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


三、网页内容加载进度条和title的实现
   //添加监测网页加载进度的观察者
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:0
                      context:nil];
   //添加监测网页标题title的观察者
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];

   //kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
       NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        } 
    }else if([keyPath isEqualToString:@"title"]
             && object == _webView){
        self.navigationItem.title = _webView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
    //移除观察者
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];


四、JS和OC的交互

JS调用OC


这个实现主要是依靠WKScriptMessageHandler协议类和WKUserContentController两个类：WKUserContentController对象负责注册JS方法，设置处理接收JS方法的代理，代理遵守WKScriptMessageHandler，实现捕捉到JS消息的回调方法，详情可以看第一步中对这两个类的介绍。

 //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        //注册一个name为jsToOcNoPrams的js方法，设置处理接收JS方法的代理
        [wkUController addScriptMessageHandler:self  name:@"jsToOcNoPrams"];
        [wkUController addScriptMessageHandler:self  name:@"jsToOcWithPrams"];
        config.userContentController = wkUController;

注意：遵守WKScriptMessageHandler协议，代理是由WKUserContentControl设置
 //通过接收JS传出消息的name进行捕捉的回调方法  js调OC
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}





OC调用JS


 //OC调用JS  changeColor()是JS方法名，completionHandler是异步回调block
    NSString *jsString = [NSString stringWithFormat:@"changeColor('%@')", @"Js参数"];
    [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"改变HTML的背景色");
    }];
    
    //改变字体大小 调用原生JS方法
    NSString *jsFont = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", arc4random()%99 + 100];
    [_webView evaluateJavaScript:jsFont completionHandler:nil];



12。iOS UITableView/UICollectionView获取特定位置的cell

获取偏移后顶部cell的index

方案一(不推荐原因会在后面提到)：获得当前可见的所有cell，然后取可见cell数组中的第一个cell就是目标cell，再根据cell获得indexPath。代码如下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
  if (scrollView == _rightTableView && _isSelected == NO) {
      //返回tableView可见的cell数组
        NSArray * array = [_rightTableView visibleCells];
       //返回cell的IndexPath
        NSIndexPath * indexPath = [_rightTableView indexPathForCell:array.firstObject];
        NSLog(@"滑到了第 %ld 组 %ld个",indexPath.section, indexPath.row);
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [_leftTableView reloadData];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
}


方案二(推荐使用)：利用偏移量！偏移量的值实际上可以代表当时处于tableView顶部的cell在tableView上的相对位置， 那么我们就可以根据偏移量获得处于顶部的cell的indexPath。代码如下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
   if (scrollView == _rightTableView && _isSelected == NO) {
       //系统方法返回处于tableView某坐标处的cell的indexPath
        NSIndexPath * indexPath = [_rightTableView indexPathForRowAtPoint:scrollView.contentOffset];
        NSLog(@"滑到了第 %ld 组 %ld个",indexPath.section, indexPath.row);
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [_leftTableView reloadData];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
}


二、 获取处于UITableView中心的cell

获取处于tableView中间cell的效果，用上述方案一比较麻烦：要考虑可见cell 的奇、偶个数问题，还有cell是否等高的情况；方案二用起来就快捷方便多了，取的cell的位置的纵坐标相当于在偏移量的基础上又增加了tableView高度的一半。代码如下：

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //获取处于UITableView中心的cell
    //系统方法返回处于tableView某坐标处的cell的indexPath
    NSIndexPath * middleIndexPath = [_rightTableView  indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + _rightTableView.frame.size.height/2)];
    NSLog(@"中间的cell：第 %ld 组 %ld个",middleIndexPath.section, middleIndexPath.row);
}



UICollectionView获取特定位置的item与UITableView相似，仅仅是获取的方法名不同，如下：

 NSIndexPath * indexPath = [_collectionView  indexPathForItemAtPoint:scrollView.contentOffset];
 NSLog(@"滑到了第 %ld 组 %ld个",indexPath.section, indexPath.row);


获取某个cell在当前tableView/collectionView上的坐标位置

 //获取某个cell在当前tableView上的坐标位置
    CGRect rectInTableView = [_rightTableView rectForRowAtIndexPath:middleIndexPath];
    //获取cell在当前屏幕的位置
    CGRect rectInSuperview = [_rightTableView convertRect:rectInTableView toView:[_rightTableView superview]];
    NSLog(@"中间的cell处于tableView上的位置: %@ /n 中间cell在当前屏幕的位置：%@", NSStringFromCGRect(rectInTableView), NSStringFromCGRect(rectInSuperview));
    
     //获取cell在当前collection的位置
     CGRect cellInCollection = [_collectionView convertRect:item.frame toView:_collectionView];
     UICollectionViewCell * item = [_collectionView cellForItemAtIndexPath:indexPath]];
     //获取cell在当前屏幕的位置
     CGRect cellInSuperview = [_collectionView convertRect:item.frame toView:[_collectionView superview]];
     NSLog(@"获取cell在当前collection的位置: %@ /n 获取cell在当前屏幕的位置：%@", NSStringFromCGRect(cellInCollection), NSStringFromCGRect(cellInSuperview));
    

13。iOS 自定义转场动画
本文记录分享下自定义转场动画的实现方法，具体到动画效果：新浪微博图集浏览转场效果、手势过渡动画、网易音乐启动屏转场动画、开关门动画、全屏侧滑返回效果 的代码可以到Github WSLTransferAnimation下载查看，注释还算清晰。

模态化present和dismiss 自定义转场
1、创建一个遵循<UIViewControllerAnimatedTransitioning>协议的动画过渡管理对象，并实现如下两个方法：
//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

 //取出转场前后的视图控制器
  UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController * toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

 //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

 //这里有个重要的概念containerView，要做转场动画的视图就必须要加入containerView上才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];

  //如果加入了手势交互转场，就需要根据手势交互动作是否完成/取消来做操作，完成标记YES，取消标记NO，必须标记，否则系统认为还处于动画过程中，会出现无法交互之类的bug
   [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     if ([transitionContext transitionWasCancelled]) { 
    //如果取消转场
          }else{
   //完成转场
     }
}

2、自定义一个继承于UIPercentDrivenInteractiveTransition的手势过渡管理对象，可以根据手势需要设置控制动画转场进度的百分比。
//必要调用实现的系统方法

//手势过程中，通过updateInteractiveTransition设置转场过程动画进行的百分比，然后系统会根据百分比自动布局动画控件，不用我们控制了
 [self updateInteractiveTransition:percentComplete];
//完成转场操作
 [self finishInteractiveTransition];
//取消转场操作
 [self cancelInteractiveTransition];


3、转场时最上层的视图控制器需要遵循<UIViewControllerTransitioningDelegate>的协议，并设置为代理，并实现如下代理方法：
//设置转场代理
self.transitioningDelegate = self;

#pragma mark -- UIViewControllerTransitioningDelegate

//返回一个处理present动画过渡的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.transitionAnimation;
}
//返回一个处理dismiss动画过渡的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    self.transitionAnimation.transitionType = WSLTransitionOneTypeDissmiss;
    return self.transitionAnimation;
}
//返回一个处理present手势过渡的对象 
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.transitionInteractive;
}
//返回一个处理dismiss手势过渡的对象
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.transitionInteractive;
}

导航控制器push和pop 自定义转场
1、略...同上
2、略... 同上
3、在push动画之前设置导航控制器的转场动画代理，转场时最上层的视图控制器需要遵循<UINavigationControllerDelegate>的协议，并设置为代理，并实现如下代理方法：
 //在push动画之前设置转场动画代理
 self.navigationController.delegate = animationFour;

#pragma mark -- UINavigationControllerDelegate
//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.transitionType = WSLTransitionTwoTypePush;
        return self.transitionAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        self.transitionAnimation.transitionType = WSLTransitionTwoTypePop;
    }
    return self.transitionAnimation;
}

//返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    //手势开始的时候才需要传入手势过渡代理，如果直接pop或push，应该返回nil，否者无法正常完成pop/push动作
    if ( self.transitionAnimation.transitionType == WSLTransitionTwoTypePop) {
        return self.transitionInteractive.isInteractive == YES ? self.transitionInteractive : nil;
    }
    return nil;
}


全屏侧滑返回

创建一个继承于UINavigationController的一个对象WSLNavigatioController，遵守协议<UIGestureRecognizerDelegate>,实现如下方法：

  // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;

#pragma mark -- UIGestureRecognizerDelegate
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}


解决UIScrollView的滑动手势与全屏侧滑手势的冲突

创建一个UIScrollView的类别UIScrollView+GestureConflict，重写如下方法：

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

作者：且行且珍惜_iOS
链接：https://www.jianshu.com/p/a9b1307b305b
来源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。




                             网络 swift nfnetworking reactivecocoa

afnetworking：

https分单向验证和双向验证两种方式，一般经常说的https是单向验证的

SSL、TLS区别：https://blog.csdn.net/enweitech/article/details/81781405
ssl：安全套接层。
tls：在SSL更新到3.0时，IETF对SSL3.0进行了标准化，并添加了少数机制，最后成熟以后成了安全传输层协议，由一个安全层变为了协议，相当于
ssl是tls的升级版本，无区别，只是人们习惯叫ssl。

单向验证：
1  客户端向服务端发送SSL协议版本号、加密算法种类、客户端随机数等信息
2  服务端给客户端返回SSL协议版本号、加密算法种类、服务器随机数等信息，同时也返回服务器端的ca证书，该证书中包含公钥和私钥，
这里只带公钥的证书返给客户端
3  客户端使用服务端返回的信息验证服务器的合法性，包括：证书是否过期  服务器证书CA是否可靠  证书中的公钥是否能解开证书的签名  
服务器域名是否和服务器相同
4  解开公钥，再生成一个客户端随机数，用公钥加密后生成证书发给服务端
5  服务端用私钥解密客户端证书，得到客户端最后一次生成的随机数
6  此时客户端和服务器都有三个随机数 ，在请求和响应的过程中，通过使用前面的三个随机数，生成"对话密钥"（ session key ）
谈话内容再通过这个对话密钥加密及解密

双向验证： 增加了客户端向服务端发送证书，证书带公钥和私钥，同时发送证书公钥加密的对称加密方案。服务端通过客户端的证书对加密方案解密。

1  客户端向服务端发送SSL协议版本号、加密算法种类、随机数等信息。
2  服务端给客户端返回SSL协议版本号、加密算法种类、服务器随机数等信息，同时也返回服务器端的ca证书，该证书中包含公钥和私钥，
这里只带公钥的证书返给客户端
3  客户端使用服务端返回的信息验证服务器的合法性，包括：证书是否过期  服务器证书CA是否可靠  证书中的公钥是否能解开证书的签名  
服务器域名是否和服务器相同
4  验证通过后，客户端保存了服务端带公钥的ca证书，客户端会将自己的证书（只带公钥）发送至服务端，客户端证书中包含公钥和私钥
6  服务端验证客户端的证书，验证包括：客户端的证书是否过期 提供的客户端证书CA是否可靠  证书中的公钥是否能解开证书的签名 证书是否在证书废止列表（CRL）中。
通过验证后，会获得客户端的公钥
7  客户端向服务端发送自己所能支持的对称加密方案，供服务器端进行选择
8  服务器端在客户端提供的加密方案中选择加密程度最高的加密方式，通过客户端公钥进行加密，返回给客户端
10 客户端收到服务端返回的加密方案密文后，使用自己的私钥进行解密，得到加密的方式，生成一个随机数，再使用服务端的公钥进行随机数加密，发送给服务端
11  此时客户端和服务器都有三个随机数 ，在请求和响应的过程中，通过使用前面的三个随机数，生成"对话密钥"（ session key ）
谈话内容再通过这个对话密钥加密及解密


afn单向验证：

一。afn中对ca机构证书非自建证书的单向验证：
使用AFN时只需要拼接上https://即可，AFN的网络请求配置中默认使用CA认证访问HTTPS地址，所以afn不需要任何设置

二。afn中对自签名证书的单向验证：
1。从服务器要来.crt格式的证书，然后用Mac钥匙串打开，然后导出 .cer格式的证书
2。把.cer证书导入程序的中
3。验证证书的代码：

+(AFSecurityPolicy*)customSecurityPolicy
{
    //先导入证书，转换成NSSet
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet  *dataSet = [NSSet setWithArray:@[certData]];
    
    //AFSSLPinningModeCertificate 公钥和其它内容都需要验证
    //AFSSLPinningModePublicKey 只验证公钥是否通过
    //AFSSLPinningModeNone 不做任何验证 可理解为证书未在工程文件下  这种模式自签名证书请求https是不成功的
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 如果是自建证书，需要设置为YES 不是自建证书无所。
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；如置为NO，建议自己添加对应域名的校验逻辑
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = dataSet ;//不是自建证书不需要
    return securityPolicy;
}


afn双向验证：太复杂请看此文https://www.jianshu.com/p/e66eacc24dbe iOS基于AFNetworking使用自签名证书实现HTTPS请求



NSURLConnection 和 NSURLSession 区别：

NSURLConnection:
NSURLConnection在foundation框架中的一个类，它与这个框架中很多类关联：NSURLRequest、NSURLResponse、NSURLProtocol、NSHTTPCookieStorage、NSURLCredentialStorage

NSURLSession:
在iOS 7.0 推出了 NSURLSession，对foundation框架中url模块进行彻底重构。
支持 http2.0 协议 
支持直接下载到硬盘，而非先下载到内存再到硬盘 
一个NSURLSession对象发送多个请求 
下载使多线程异步处理，如一个文件开启多个线程加速下载
提供全局的 session 并可以统一配置等等，提高了 NSURLSession 的易用性、灵活性，更加地适合移动开发的需求。

http2.0 协议 ：
HTTP/2采用二进制格式而非文本格式
HTTP/2是完全多路复用的，而非有序并阻塞的——只需一个连接即可实现并行
使用报头压缩，HTTP/2降低了开销
HTTP/2让服务器可以将响应主动“推送”到客户端缓存中

区别：从iOS9 开始，NSURLConnection 中同步请求，异步请求方法过期

NSURLSession：
普通请求：NSURLSessionDataTask
上传请求：NSURLSessionUploadTask 
下载请求：NSURLSessionDownloadTask
三个请求任务会挂起需要时再启动

上传任务：
NSURLSession 与 NSURLConnection 再上传任务时，都需要设置post请求体。

下载任务：
NSURLConnection;先是将整个文件下载到内存，然后再写入到沙盒，如果文件比较大，就会出现内存暴涨的情况。
 NSURLSessionDownloadTask：会默认下载到沙盒中 tmp文件中，不会出现内存暴涨的情况，
下载完成后会把 tmp 中的临时文件删除，需要在初始化任务方法时，在 completionHandler 回调中增加保存文件的代码。

取消，暂停，继续 状态：
NSURLConnection 默认发送同步请求，不需要调用 start 方法，一但调用cancel，停止下载，下次下载重新开始
NSURLSession  取消(cancel)、暂停(suspend)、继续(resume) 继续会接着上次的下载

断点续传的方式：
NSURLConnection  设置访问请求的 HTTPHeaderField 的 Range 属性，下载的代理方法不断调用，下载完成使用 NSOutputStream 管道流进行数据保存。
NSURLSession  开启下载，会调用cancelByProducingResumeData:(void (^)(NSData *resumeData))completionHandler，
resumeData表示下载完成的数据，暂停后继续下载，[self.session downloadTaskWithResumeData:self.resumeData] resume]传入上次下载的resumeData

配置方面：
NSURLSession  NSURLSession的初始化方法sessionWithConfiguration:delegate:delegateQueue中有个参数NSURLSessionConfiguration，
此参数可配置 cookie，安全和高速缓存策略，最大主机连接数，资源管理，网络超时等

NSURLConnection  依赖与一个全局的配置对象，不能自定义配置，不够灵活

基本介绍：

NSURLConnection  

1. 异步处理代理

NSURLRequest对象作为参数，传递给NSURLConnection，代理方法NSURLConnectionDelegate返回NSURLResponse， 代理方法NSURLConnectionDataDelegate
返回NSData

2. 请求策略
请求发送到服务器之前，检查有无缓存，缓存是否过期，无过期直接返回内容，如果无缓存，已经过期，我们可以指定缓存策略来再次请求

3. 认证策略
如认证cookie中的用户名，密码是否可自动登陆，通过共享cookie和机密存储来认证区别请求的用户

4. 下载过程

NSURLConnection下载文件时，先是将整个文件下载到内存，然后再写入到沙盒，如果文件比较大，就会出现内存暴涨的情况

二、使用步骤
创建request：get请求NSURLRequest post请求NSMutableURLRequest
设置请求方式：get不用设置  post需设置request.HTTPMethod = @"POST";
设置请求体： get不用设置 post需设置request.HTTPBody
请求方法：
   get: NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];//该方法是阻塞式的，会卡住线程
   post：
   [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] 
   completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, 
   NSError * __nullable connectionError) {
代理方法：
    建立连接成功
   /*
    1.当接收到服务器响应的时候调用，该方法只会调用一次
    第一个参数connection：监听的是哪个NSURLConnection对象
    第二个参数response：接收到的服务器返回的响应头信息
   */
   [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler
:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {

    下载的数据回调多次
   /*
    2.当接收到数据的时候调用，该方法会被调用多次
    第一个参数connection：监听的是哪个NSURLConnection对象
    第二个参数data：本次接收到的服务端返回的二进制数据（可能是片段）
    */
   - (void)connection:(nonnull NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
   
   下载的数据完毕
    /*
      3.当服务端返回的数据接收完毕之后会调用
      通常在该方法中解析服务器返回的数据
    */
   - (void)connectionDidFinishLoading:(nonnull NSURLConnection *)connection
   
   下载的错误
    /*
     4.当请求错误的时候调用（比如请求超时）
     第一个参数connection：NSURLConnection对象
     第二个参数：网络请求的错误信息，如果请求失败，则error有值
    */
   - (void)connection:(nonnull NSURLConnection *)connection didFailWithError:(nonnull NSError *)error
   
   
   
   发送请求：
   
   
      get同步请求:
      
      //1.确定请求路径
      NSURL *url = [NSURL URLWithString:@""];
    
      //2.创建一个请求对象
      NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
     //3.把请求发送给服务器
     //sendSynchronousRequest  阻塞式的方法，会卡住线程
    
     NSHTTPURLResponse *response = nil;
     NSError *error = nil;
    
     /*
      第一个参数：请求对象
      第二个参数：响应头信息，当该方法执行完毕之后，该参数被赋值
      第三个参数：错误信息，如果请求失败，则error有值
      */
     //该方法是阻塞式的，会卡住线程
     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     
     
     
     
     
     
     post异步请求：
     
     //1.确定请求路径
     NSURL *url = [NSURL URLWithString:@""];
    
     //2.创建一个请求对象
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
     // 2.1设置请求方式
     // 注意: POST一定要大写
     request.HTTPMethod = @"POST";
     // 2.2设置请求体
     // 注意: 如果是给POST请求传递参数: 那么不需要写?号
     request.HTTPBody = [@"username=Mitchell&pwd=123456&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
     //3.把请求发送给服务器,发送一个异步请求
     /*
     第一个参数：请求对象
     第二个参数：回调方法在哪个线程中执行，如果是主队列则block在主线程中执行，非主队列则在子线程中执行
     第三个参数： completionHandlerBlock块：接受到响应的时候执行该block中的代码
            response：响应头信息
             data：响应体
            connectionError：错误信息，如果请求失败，那么该参数有值
      */
 
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {

       //4.解析服务器返回的数据
       NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       //转换并打印响应头信息
       NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
    }];
    
    
    
    
创建代理：
    
     第一种代理方式，自动发送请求：
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
     第二种代理方式，自动发送请求：
     /*
     第一个参数：请求对象
     第二个参数：谁成为NSURLConnetion对象的代理
     第三个参数：是否马上发送网络请求，如果该值为YES则立刻发送，如果为NO则不会发送网路请求
     */
     NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    
    //在startImmediately为NO时，调用该方法控制网络请求的发送
    [conn start];
    
    // 第一种代理方式，自动发送请求：
    //设置代理的第三种方式：使用类方法设置代理，会自动发送网络请求
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    
    //取消网络请求
    //[conn cancel];
    
    
3. NSURLConnection 与 NSRunLoop 的关联使用
    [[NSURLConnection alloc]initWithRequest:request delegate:self];异步请求时，回到代理方法中是在主线程的，主线程默认有一个
    runloop，会把NSURLConnection加入到这个runloop中，所以它的代理回调在主线程，如何让回调在子线程，需要开启一个子线程，并在子线程
    创建一个runloop。
    
    // 如果按照如下设置，那么回调的代理方法也会运行在子线程中
    NSURL *url = [NSURL URLWithString:@"http://mvvideo1.meitudata.com/55d99e5939342913.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2.2 设置回调方法也在子线程中运行
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [conn setDelegateQueue:[[NSOperationQueue alloc] init]];//开启子线程
    [conn start];//内部在子线程中创建一个runloop，所有代理回调都会在这个runloop所处的线程中执行
    
    setDelegateQueue，start方法内部作的事：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{// setDelegateQueue开启子线程

    NSRunLoop *loop = [NSRunLoop currentRunLoop];//start方法创建runloop
    [NSURLConnection connectionWithRequest:request delegate:self];
    [loop run];
    
    // 下面这样无法发送请求
    // [NSURLConnection connectionWithRequest:request delegate:self];
   });
      
      
      
NSURLSession：

   一、 session类型
   三个类方法，分别返回三种不同的配置类型，每种类型都是属于session类型的
   
   标准的配置类型： configuration 与NSURLConnection的共享配置一样
   类方法：+defaultSessionConfiguration
   返回共享NSHTTPCookieStorage，共享 NSURLCache 和共享 NSURLCredentialStorage（存储）
   
   预设配置类型： Ephemeral session  稍稍访问网站
   不会对缓存Cookie 和证书进行持久性的存储，存储一段时间会清除，对于相稍稍访问一些网站而不被记录访客信息很有用
   
   后台session配置： Background session 对后台下载有用
   可以在应用程序挂起，退出或者崩溃的情况下进行上传和下载任务，区别于任何进程外的传输守护进程。
   
   二、配置属性
   
   HTTPAdditionalHeaders ：可以设置请求头信息，如数据格式，语言，用户代理，身份认证
   
   // 设置请求的header
   NSString *userPasswordString = [NSString stringWithFormat:@"%@:%@", user, password];
   NSData * userPasswordData = [userPasswordString dataUsingEncoding:NSUTF8StringEncoding];
   NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
   NSString *authString = [NSString stringWithFormat:@"Basic %@", base64EncodedCredential];
   NSString *userAgentString = @"AppName/com.example.app (iPhone 5s; iOS 7.0.2; Scale/2.0)";
   configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json",
                                        @"Accept-Language": @"en",
                                        @"Authorization": authString,
                                        @"User-Agent": userAgentString}  
                                        
                                        
                                        
                                        
                                        
    networkServiceType： 对不同功能使用的流量进行划分，如语音，视频，网络电话流量，一般不会用
    
    
    
    
    allowsCellularAccess 和 discretionary ：在蜂窝网络时，会根据电量情况等去减少增加网络带宽，使用  discretionary不会考虑电量问题
    所以带宽会好些
    
    
    
    timeoutIntervalForRequest 和 timeoutIntervalForResource： 网络请求超时，限制在多少秒内请求，超出时间则停止请求。
    
    
    
    HTTPMaximumConnectionsPerHost：最多可以同时建立多少个连接来连接服务器
    
    
    
    
    HTTPShouldUsePipelining ：属于NSMutableURLRequest ，开启管线化请求通道，提高请求速度，不被大多服务商支持，一般关闭的
    
    
    sessionSendsLaunchEvents： 指定session是否应该在后台启动
    
    
    connectionProxyDictionary： 指定session会话可以连接代理服务器，大多数手机不需要代理服务器
    



Cookie 策略：

    HTTPCookieStorage： 存储了session 所使用的 cookie，+sharedHTTPCookieStorage 得到这个单例对象，与 NSURLConnection 是相同的
    
    HTTPCookieAcceptPolicy：什么情况下session接收服务器返回的cookie
    
    HTTPShouldSetCookies ：请求是否应该使用session存储的cookie
    

安全策略：
    
    URLCredentialStorage： 存储了 session 所使用的证书，+sharedCredentialStorage 得到这个单例对象，与 NSURLConnection 是相同的
    
    TLSMaximumSupportedProtocol 和 TLSMinimumSupportedProtocol  ：  确定 session 是否支持 SSL 协议。即https协议


缓存策略：
   
    URLCache ： 是session使用的缓存。默认情况下会使用 NSURLCache 的 +sharedURLCache 这个单例对象，这与 NSURLConnection 是相同的
    
    requestCachePolicy： 一个请求的缓存响应应该在什么时机返回，相当于 NSURLRequest 的 -cachePolicy 方法。
    

自定义协议：

    protocolClasses ： 用于配置某个特定session使用的自定义协议，相当于特定的一个请求使用什么协议
    


三、NSURLSessionTask抽象类    
    
   子类：
   普通请求：NSURLSessionDataTask
   上传请求：NSURLSessionUploadTask 
   下载请求：NSURLSessionDownloadTask
   
   这三个子类不是 alloc-init创建的，而是 NSURLSession 创建的，都有两个构造方法，其中一个带有completionHandler
   
   
四、代理
   
   根代理NSURLSessionDelegate：处理鉴定下载权力，下载任务完成通知
   
   子类：
   
   NSURLSessionTaskDelegate处理鉴定下载权力、处理任务结束通知(无论是正常还是异常)
   NSURLSessionDataDelegate处理鉴定下载权力 处理数据的接收到的通知
   NSURLSessionDownloadDelegate主要处理数据下载进度通知等。
   
   NSURLSessionTaskDelegate是NSURLSessionDelegate子类
   NSURLSessionDataDelegate， NSURLSessionDownloadDelegate是NSURLSessionTaskDelegate子类
   


五、NSURLSession 应用


1. NSURLSessionDataTask 发送 GET 请求

//确定请求路径
NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520&pwd=520&type=JSON"];
//创建 NSURLSession 对象
NSURLSession *session = [NSURLSession sharedSession];

/**
根据对象创建 Task 请求，默认在子线程中解析数据
url  方法内部会自动将 URL 包装成一个请求对象（默认是 GET 请求）
completionHandler  完成之后的回调（成功或失败）
param data     返回的数据（响应体）
param response 响应头
param error    错误信息
*/
NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:
         ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

    //解析服务器返回的数据
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}];
//发送请求（执行Task）
[dataTask resume];




2. NSURLSessionDataTask 发送 POST 请求  block方式
//确定请求路径
NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
//创建可变请求对象
NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
//修改请求方法
requestM.HTTPMethod = @"POST";
//设置请求体
requestM.HTTPBody = [@"username=520&pwd=520&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
//创建会话对象
NSURLSession *session = [NSURLSession sharedSession];
//创建请求 Task
NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestM completionHandler:
         ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

    //解析返回的数据
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}];
//发送请求
[dataTask resume];


3. NSURLSessionDataTask 设置代理发送请求
//确定请求路径
NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
//创建可变请求对象
NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
//设置请求方法
requestM.HTTPMethod = @"POST";
//设置请求体
requestM.HTTPBody = [@"username=520&pwd=520&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
//创建会话对象，设置代理
/**
第一个参数：配置信息
第二个参数：设置代理
第三个参数：队列，如果该参数传递nil 那么默认在子线程中执行
*/
NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                      delegate:self delegateQueue:nil];
//创建请求 Task
NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestM];
//发送请求
[dataTask resume];


代理方法：

//传输完成
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask 
didReceiveResponse:(nonnull NSURLResponse *)response 
completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler 
{
     //子线程中执行
     NSLog(@"接收到服务器响应的时候调用 -- %@", [NSThread currentThread]);

     self.dataM = [NSMutableData data];
     //默认情况下不接收数据
     //必须告诉系统是否接收服务器返回的数据
     completionHandler(NSURLSessionResponseAllow);
}

//传输中多次调用
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data 
{
     NSLog(@"接受到服务器返回数据的时候调用,可能被调用多次");
     //拼接服务器返回的数据
     [self.dataM appendData:data];
}

//传输错误
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
     NSLog(@"请求完成或者是失败的时候调用");
     //解析服务器返回数据
     NSLog(@"%@", [[NSString alloc] initWithData:self.dataM encoding:NSUTF8StringEncoding]);
}



设置代理之后的强引用问题

NSURLSession 对象会强引用设置的代理
控制器调用 viewDidDisappear 方法中，调用 invalidateAndCancel 方法或者是 finishTasksAndInvalidate 方法来释放强引用
invalidateAndCancel 是无论请求完成都释放代理对象
finishTasksAndInvalidate  请求完成后释放对象






4. NSURLSessionDownloadTask 下载block方式


    
//确定请求路径
NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
//创建请求对象
NSURLRequest *request = [NSURLRequest requestWithURL:url];
//创建会话对象
NSURLSession *session = [NSURLSession sharedSession];
//创建会话请求
//优点：该方法内部已经完成了边接收数据边写沙盒的操作，解决了内存飙升的问题
NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {

    //默认存储到临时文件夹 tmp 中，需要剪切文件到 cache
    NSLog(@"%@", location);//目标位置
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]  
                         stringByAppendingPathComponent:response.suggestedFilename];
    
     /**
      fileURLWithPath:有协议头
      URLWithString:无协议头
      */
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];

}];
//发送请求
[downTask resume];

4-1 暂停和恢复下载：

// 暂停
- (IBAction)suspendDownload 
{
    __weak typeof(self) weakSelf = self;
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        weakSelf.resumeData = resumeData;
    }];
}

// 开始
- (IBAction)resumeDownload 
{
    if (self.resumeData)
    {
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        [self.downloadTask resume];
    }
    else
    {
        [self.downloadTask resume];
    }
}



5. NSURLSessionDownloadTask 代理方式

NSURL *url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/63d0f703918fa0ec14b94082249759ee3c6ddbc6.jpg"];
NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];

NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
[downloadTask resume];



代理方法：

// 接收数据，可能多次被调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = totalBytesWritten * 1.0/totalBytesExpectedToWrite;
    
    // 主线程更新UI
    dispatch_async(dispatch_get_main_queue(),^ {
        [self.progressView setProgress:progress animated:YES];
    });
}

// 3.下载完成之后调用该方法
-  (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *catchDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [catchDir stringByAppendingPathComponent:@"app.dmg"];
    
    NSError *fileError = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:fileURL error:&fileError];
    
    if (fileError) {
        NSLog(@"保存下载文件出错：%@", fileError);
    } else {
        NSLog(@"保存成功：%@", filePath);
    }
}


5-1 暂停和恢复下载：

//暂停
[self.downloadTask suspend];
//开始
[self.downloadTask resume];




6. NSURLSessionDownloadTask 后台下载

1。创建 NSURLSession 时，需要创建后台模式 NSURLSessionConfiguration
NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"BackgroundIdentifier"];

NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: config delegate:self delegateQueue: [NSOperationQueue mainQueue]];

NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url];
[downloadTask resume];


2。在AppDelegate中实现下面方法，并定义变量保存completionHandler代码块：
// 应用处于后台，所有下载任务完成调用
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    _backgroundSessionCompletionHandler = completionHandler;
}



4。在下载类中实现下面NSURLSessionDelegate协议方法，其实就是先执行完task的协议，保存数据、刷新界面之后再执行在AppDelegate中保存的代码块：
// 应用处于后台，所有下载任务完成及NSURLSession协议调用之后调用
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.backgroundSessionCompletionHandler) 
        {
            void (^completionHandler)(void) = appDelegate.backgroundSessionCompletionHandler;
            appDelegate.backgroundSessionCompletionHandler = nil;
        
            // 执行block，释放阻止应用挂起的断言
            completionHandler();
        }
    });
}






AFN框架分析：
AFN以3.X版本为主，摒弃了NSURLConnection方法，全部基于NSURLSession方法实现。

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



      
        
        


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            
            
         
          
         
 






 
 
 
 
 
 
 

 
ReactiveCocoa  RAC  https://www.jianshu.com/p/87ef6720a096

1 ReactiveCocoa作用

方法选择器 代理 通知 kvo 都可用ReactiveCocoa实现
把要监听的事件 事件的回调 以block等方式 代码放到一起执行 高聚合 低耦合思想

2 编程思想

 面向过程  以处理事情的业务逻辑为核心，一步步实现
 面向对象  万物皆为对象，共同的特性 可抽取成一个类
 链式编程思想  将个方法以.方式连接一起，使代码有可读性 a(1).b(2).c(3)  方法返回值为block block的返回值是对象本身如： -(CaculatorMaker *(^)(int))add;
 
 
3 链式编程思想 模仿masonry，写一个加法计算器，练习链式编程思想。


NSObject+Caculator.h

@class CaculatorMaker;
@interface NSObject (Caculator)

//计算
+(CGFloat)makeCaulators:(void(^))(CaculatorMaker *make)) caculatorMaker;
@end



NSObject+Caculator.m

@implementation NSObject (Caculator)

+(CGFloat)makeCaulators:(void(^))(CaculatorMaker *make)) caculatorMaker
{
      //1.创建计算管理者
      CaculatorMaker *mgr = {[CaculatorMaker alloc] init];
      return mgr.result;
}



CaculatorMaker.h

@interface CaculatorMaker :NSObject

@property (nonatomic, assign) int result;

//运算方法
-(CaculatorMaker *(^)(int))add;
-(CaculatorMaker *(^)(int))sub;
-(CaculatorMaker *(^)(int))muilt;
-(CaculatorMaker *(^)(int))divide;

@end


CaculatorMaker.m

@implementation CaculatorMaker
-(CaculatorMaker *(^)(int))add
{
    return ^CaculatorMaker *(int value){
       _result +=value;
       return self;
    }
}

@end


int result = [NSObject makeCaculators:^(CaculatorMaker *make){
    make.add(1).add(2).divide(5);
}];


4 链式编程思想 一切皆为流，不需要考虑调用顺序，直接考虑结果。


6  函数式编程思想  把一系列操作，用方法套方法的方式实现 每个方法必须返回对象本身，方法的参数是block block中的参数是需要操作的参数  block返回值为最后操作的结果

7  函数式编程思想仿ReactiveCocoa 写一个加法计算器,并且加法计算器自带判断是否等于某个值.

8  案例

Caculator.h

@interface Caculator :NSObject

@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) int result;

//运算方法
-(Caculator *)caculator:(int (^) (int result))caculator;
-(Caculator *)equle:(BOOL (^) (int result))operation;

@end


Caculator.m

@implementation Caculator

-(Caculator *)caculator:(int (^) (int result))caculator{

}

@end



Caculator *c = [[Caculator alloc]init];
//计算2*5 并判断是否等于10
BOOL isqule =[[[c caculator:^(int result){
     result += 2;
     result *= 5;
     return result; 
}] equle:^BOOL(int result){

}] isEqule];//判断每一个block返回的10是否与传入result的10相等

NSLog("%d",isqule);


9  ReactiveCocoa编程思想
ReactiveCocoa结合了几种编程风格：函数式编程（Functional Programming）响应式编程（Reactive Programming）
被描述为函数响应式编程（FRP）框架。不需要考虑调用顺序，直接考虑结果 ，把每一次操作都写成一系列嵌套的方法中

10  导入ReactiveCocoa框架
podfile 文件中
use_frameworks！
pod 'ReactiveCocoa', '~> 4.0.2-alpha-1'

11 ReactiveCocoa常见类

RACSiganl 信号类 RAC中最核心的类 ,搞定这个类就能用ReactiveCocoa开发了
只要有数据改变，RACSiganl接收到此数据，内部交给订阅者去发出数据，这个类不具备发送数据能力，数据的每次改变都会调用subscribeNext 订阅这个方法，
subscribeNext内部会创建订阅者
冷信号：一个信号未被订阅，即使数据改变了，也找不到订阅者，就无法发送数据，默认信号都是冷信号
热信号：一个信号被订阅，变为热信号，数据改变了，找到订立者发出数据


RACSiganl 简单使用：
  1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
  2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
  3.发送信号 - (void)sendNext:(id)value
  
  // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {//顺序1：didSubscribe保存到信号中
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];//顺序3：subscriber订阅者调用RACSignal的didSubscribe，didSubscribe调用subscriber订阅者sendNext
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
 
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {//顺序2：创建subscriber订阅者，把nextBlock保存到subscriber中
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];



RACSignal底层实现：

    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，订阅都属于signal对象的一个成员，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    创建信号RACSiganl 会保存didSubscribe
    订阅信号RACSiganl 会创建订阅者subscriber
    订阅者subscriber  会保存nextBlock 同时创建一个RACCompoundDisp（复合disp对象）
    RACCompoundDisp对象  会保存RACSiganl信号 订阅者subscriber
    订阅者subscriber发送信号时  [subscriber sendNext:@1]; 信号RACSigan中保存的didSubscribe会调用[subscriber sendNext:@1];
    订阅者又会执行保存的nextBlock
    
    
RACSubscriber 订阅者：用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。
通过createSignal创建的信号，都有一个订阅者，帮助他发送数据。

RACDisposable 取消订阅或者清理资源，当信号发送完成[subscriber sendCompleted] 或者发送错误的时候，就会自动触发它。可主动调用它取消订阅[disposable dispost]

RACSubject 译为主题 可提供RACSiganl信号，自己可以充当信号，又能发送信号。用来代替代理，有了它，就不必要定义代理了
当订阅时会把订阅者保存到RACSubscriber的_subscribers
遍历subject中_subscribers中的订阅者，依次发送信息 ，可以被订阅多次，并且只能是先订阅后发布。

RACReplaySubject:重复提供信号类，RACSubject的子类。可以先发送信号，再订阅信号 
    场景1：一个信号每被订阅一次，想重复再接收一次，就可以先发信号
    场景2：可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值
    
    

RACSubject简单使用:

   // 1.创建信号
    RACSubject *subject = [RACSubject subject];

    // 2.订阅信号
    [subject subscribeNext:^(id x) { //创建订阅者 只保存订阅者 nextBlock保存到订阅者中， nextBlock已经赋值
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) { //创建订阅者 只保存订阅者 nextBlock保存到订阅者中， nextBlock已经赋值
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];

    // 3.发送信号
    [subject sendNext:@"1"];//遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock

    

RACSubject底层原理：
  // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
     
     原理：
    // RACSubject:底层实现和RACSignal不一样。区别在于发送信号时，RACSiganl是通过RACSiganl的didSubscribe
     调用[subscriber sendNext:]去发送，而RACSubject是直接遍历所有订阅者，再[subscriber sendNext:]发送
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。 
    


RACReplaySubject使用：

    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];

    // 2.发送信号
    [replaySubject sendNext:@1];//保存所有的值，遍历之前存的订阅者，每个订阅者都调用nextBlock发送值
    [replaySubject sendNext:@2];

    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {//遍历保存的所有值，每个订阅者都调用nextBlock发送此值

        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];

    // 订阅信号
    [replaySubject subscribeNext:^(id x) {

        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];  



RACReplaySubject底层实现原理：

// RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value

    原理：
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock

    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    




RACSubject 来替换代理的使用
  实现： 点击控制器a的按钮，跳转到控制器b，点击控制器b的按钮，告诉控制器a控制器b已经点击了按钮
  
		步骤一：在第二个控制器.h，添加一个RACSubject代替代理。
		
		@interface TwoViewController : UIViewController

		@property (nonatomic, strong) RACSubject *delegateSignal;

		@end

		步骤二：监听第二个控制器按钮点击
		@implementation TwoViewController
		- (IBAction)notice:(id)sender {
			// 通知第一个控制器，告诉它，按钮被点了
	
			 // 通知代理
			 // 判断代理信号是否有值
			if (self.delegateSignal) {
				// 有值，才需要通知
				[self.delegateSignal sendNext:nil];
			}
		}
		@end

		步骤三：在第一个控制器中，监听跳转按钮，给第二个控制器的代理信号赋值，并且监听.
		
		@implementation OneViewController 
		- (IBAction)btnClick:(id)sender {
	
			// 创建第二个控制器
			TwoViewController *twoVc = [[TwoViewController alloc] init];
	
			// 设置代理信号
			twoVc.delegateSignal = [RACSubject subject];
	
			// 订阅代理信号
			[twoVc.delegateSignal subscribeNext:^(id x) {
	   
				NSLog(@"点击了通知按钮");
			}];
	
			// 跳转到第二个控制器
			[self presentViewController:twoVc animated:YES completion:nil];
	
		}
		@end
		
		
		
		


RAC定时器：
    @weakify(self)
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        x.enabled = false;
        
        self.time = 10;
        
        //这个就是RAC中的GCD  1秒后执行发送验证码
        self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            _time --;
            NSString * title = _time > 0 ? [NSString stringWithFormat:@"请等待 %d 秒后重试",_time] : @"发送验证码";
            [self.btn setTitle:title forState:UIControlStateNormal | UIControlStateDisabled];
            self.btn.enabled = (_time==0)? YES : NO;
            if (_time == 0) {
                [self.dispoable dispose];
            }
        }];
    }];		




RACTuple   元组类,类似NSArray或字典用来包装值. 
	RACTuple *x ； 
	RACTupleUnpack(NSString *key,NSString *value) = x;   
	NSString *key = x[0];



RACSequence   RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。 RACSequence可以转为RACSignal信号类

    1.RACSequence和RACTuple简单使用 遍列数组，字典，字典转模型
    
			 // 1.遍历数组
			NSArray *numbers = @[@1,@2,@3,@4];
	
			// 这里其实是三步
			// 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
			// 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
			// 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
			[numbers.rac_sequence.signal subscribeNext:^(id x) {//把number转成RACSequence再转成RACSignal信号去订阅
	   
				NSLog(@"%@",x);
			}];
	
	
			// 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
			NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
			[dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
	   
				// 解包元组，会把元组的值，按顺序给参数里面的变量赋值
				RACTupleUnpack(NSString *key,NSString *value) = x;
		
				// 相当于以下写法
		        // NSString *key = x[0];
		        // NSString *value = x[1];
		
				NSLog(@"%@ %@",key,value);
		
			}];
	
	
			// 3.字典转模型
			// 3.1 OC写法
			NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
	
			NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
	
			NSMutableArray *items = [NSMutableArray array];
	
			for (NSDictionary *dict in dictArr) {
				FlagItem *item = [FlagItem flagWithDict:dict];
				[items addObject:item];
			}
	
			// 3.2 RAC写法
			NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
	
			NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];

			NSMutableArray *flags = [NSMutableArray array];
	
			_flags = flags;
	
			// rac_sequence注意点：调用subscribeNext，并不会马上执行nextBlock，而是会等一会。
			[dictArr.rac_sequence.signal subscribeNext:^(id x) {
				// 运用RAC遍历字典，x：字典
		
				FlagItem *item = [FlagItem flagWithDict:x];
		
				[flags addObject:item];
		
			}];
	
			NSLog(@"%@",  NSStringFromCGRect([UIScreen mainScreen].bounds));
	
	
			// 3.3 RAC高级写法:
			NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
	
			NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
			// map:映射的意思，目的：把原始值value映射成一个新值
			// array: 把集合转换成数组
			// 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
			NSArray *flags = [[dictArr.rac_sequence map:^id(id value) {
	 
				return [FlagItem flagWithDict:value];
		
			}] array];





RACCommand   RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程
     
     监听按钮点击，网络请求
     
     
			// 一、RACCommand使用步骤:
			// 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
			// 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
			// 3.执行命令 - (RACSignal *)execute:(id)input
	
			// 二、RACCommand使用注意:
			// 1.signalBlock必须要返回一个信号，不能传nil.
			// 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
			// 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
			// 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
	        // 5.executing 监听当前命令是否正在执行executing，命令是否正在工作
	
	
			// 1.创建命令
			RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		
		
				NSLog(@"执行命令");
		
				// 创建空信号,必须返回信号
				//        return [RACSignal empty];
		
				// 2.创建信号,用来传递数据
				return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
			        //网络请求完成后可以调用下面的代码
					[subscriber sendNext:@"请求数据"];//调一次，则subscribeNext执行一次
			
					// 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
					[subscriber sendCompleted];
			
					return nil;
				}];
		
			}];
	
			// 强引用命令，不要被销毁，否则接收不到数据
			_conmmand = command;
	
	
   
			// 3.订阅RACCommand中的信号
			[command.executionSignals subscribeNext:^(id x) {
		
				[x subscribeNext:^(id x) {//订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅返回的信号，就能获取发出的值。
			
					NSLog(@"%@",x);
				}];
		
			}];
	
			// RAC高级用法
			// switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
			[command.executionSignals.switchToLatest subscribeNext:^(id x) {
		
				NSLog(@"%@",x);
			}];
	
			// 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
			[[command.executing skip:1] subscribeNext:^(id x) {
		
				if ([x boolValue] == YES) {
					// 正在执行
					NSLog(@"正在执行");
			
				}else{
					// 执行完成
					NSLog(@"执行完成");
				}
		
			}];
		   // 5.执行命令
			[self.conmmand execute:@1];
	
	
	相关问题：
	
	  RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用？
		1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
		 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
	
      如何拿到RACCommand中返回信号发出的数据。
		// 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
		// 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅返回的信号，就能获取发出的值。
	
		// 五、监听当前命令是否正在执行executing
	
		// 六、使用场景,监听按钮点击，网络请求
		
		
		

RACMulticastConnection（多播连接）    用于当一个信号，被多次订阅时，创建信号的block会执行多次，造成副作用，可以使用这个类处理。
                                    RACMulticastConnection的创建通过RACSignal的-publish或者-muticast
                                    



RACMulticastConnection使用步骤:
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.创建连接 RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
    // 4.连接 [connect connect]
    
    
     // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
     // 解决：使用RACMulticastConnection就能解决.
    
		// 1.创建请求信号
	   RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		
		
			NSLog(@"发送请求");
	 
			return nil;
		}];
		// 2.订阅信号
		[signal subscribeNext:^(id x) {
	   
			NSLog(@"接收数据");
		
		}];
		// 2.订阅信号
		[signal subscribeNext:^(id x) {
		
			NSLog(@"接收数据");
		
		}];
	
		// 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
	
	
	
		// RACMulticastConnection:解决重复请求问题
		// 1.创建信号
		RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {//保存了didSubscribe
		
		
			NSLog(@"发送请求");
			[subscriber sendNext:@1];//didSubscribe会调用 订阅者的sendNext 会遍历RACSubject所有订阅者发送信号
		
			return nil;
		}];
	
		// 2.创建连接
		RACMulticastConnection *connect = [signal publish];
	
		// 3.订阅信号，
		// 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
		[connect.signal subscribeNext:^(id x) {//connect.signal是RACSubject，不再是RACSignal，保存订阅者，订阅者保存nextBlock
	   
			NSLog(@"订阅者一信号");
		
		}];
	
		[connect.signal subscribeNext:^(id x) {
		
			NSLog(@"订阅者二信号");
		
		}];
	
		// 4.连接,激活信号
		[connect connect];




RACMulticastConnection 底层原理：

    // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
    // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
    // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
    // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
    // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
    // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
    // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
    
    个人理解：
    createSignal:创建信号，保存didSubscribec
    pubilish:创建一个RACSubject，它可以接收发出信号，并把RACSignal与RACSubject保存到连接类connect中
    connect.signal订阅信号： 这里调用的是RACSubject的订阅方法，并创建订阅者，把nextBlock保存到subscriber订阅中
    [connect connect]激活连接：RACSubject会遍列数组中的订阅者，信号RACSigan中保存的didSubscribe会调用每个订阅者[subscriber sendNext:@1]送信号。
    
    
    
    

RACScheduler  RAC中的队列，用GCD封装的。


RACUnit   表⽰stream不包含有意义的值,也就是看到这个，可以直接理解为nil.


RACEvent   把数据包装成信号事件(signal event)。它主要通过RACSignal的-materialize来使用，然并卵。





ReactiveCocoa开发中常见用法：

     rac_signalForSelector：用于替代代理
     
    // 1.代替代理
    // 需求：自定义redView,监听红色view中按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    
    [[redV rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];



    代替KVO   rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
    
    // 2.KVO
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[redV rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

        NSLog(@"%@",x);

    }];
    
    
    
    监听事件:   rac_signalForControlEvents：用于监听某个事件。
    
    // 3.监听事件
    // 把按钮点击事件转换为信号，点击按钮，就会发送信号
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        NSLog(@"按钮被点击了");
    }];
    
    
    
    代替通知:  rac_addObserverForName:用于监听某个通知。
    
     // 4.代替通知
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出");
    }];



    监听文本框文字改变:rac_textSignal:只要文本框发出改变就会发出这个信号。
    
    // 5.监听文本框的文字改变
   [_textField.rac_textSignal subscribeNext:^(id x) {

       NSLog(@"文字改变了%@",x);
   }];



   处理当界面有多次请求时，需要都获取到数据时，才能展示界面
       
   rac_liftSelector:withSignalsFromArray:Signals:当传入的Signals(信号数组)，每一个signal都至少sendNext过一次，
   就会去触发第一个selector参数的方法。
   使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
   
   
     // 6.处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    
    
	}
	// 更新UI
	- (void)updateUIWithR1:(id)data r2:(id)data1
	{
		NSLog(@"更新UI%@  %@",data,data1);
	}
	
	
	
	
	
	



ReactiveCocoa常见宏


   RAC(TARGET, [KEYPATH, [NIL_VALUE]])：  用于给某个对象的某个属性绑定信号
   
    // 只要文本框文字改变，就会修改label的文字
    RAC(self.labelView,text) = _textField.rac_textSignal;
    
    
    
  
   RACObserve(self, name):监听某个对象的某个属性,返回的是信号。
   
   [RACObserve(self.view, center) subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
    }];
    
    
    
    @weakify(Obj)和@strongify(Obj)：一般两个都是配套使用,在主头文件(ReactiveCocoa.h)中并没有导入，需要自己手动导入，
    RACEXTScope.h才可以使用。但是每次导入都非常麻烦，只需要在主头文件自己导入就好了。
    
    
    
    
    
    RACTuplePack：把数据包装成RACTuple（元组类）
    
    // 把参数中的数据包装成元组
    RACTuple *tuple = RACTuplePack(@10,@20);
    
    
    
    
    RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
    
    // 把参数中的数据包装成元组
    RACTuple *tuple = RACTuplePack(@"xmg",@20);
    
    // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
    // name = @"xmg" age = @20
    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
    
    
    
    
    
    
    
    
    
                             ReactiveCocoa之进阶篇
    
ReactiveCocoa操作须知
所有的信号（RACSignal）都可以进行操作处理，因为所有操作方法都定义在RACStream.h中，因此只要继承RACStream就有了操作处理方法。    


ReactiveCocoa操作思想
运用的是Hook（钩子）思想，Hook是一种用于改娈方法执行结果的技术. 每次在调用方法前，都会截获该方法，执行自己的方法，改变结果


ReactiveCocoa核心方法bind
ReactiveCocoa操作的核心方法是bind（绑定），RAC中核心开发方式也是绑定，RAC开发，应该把重心放在绑定，而不是赋值上，如果传统开发
创建对象，先给对象赋值一些数据，再执行方法，而绑定不一样，先把未来要执行的方法与对象绑定，以后再去赋值，对象会调用这个方法。
在开发中很少使用bind方法，bind属于RAC中的底层方法，RAC已经封装了很多好用的其他方法，底层都是调用bind，用法比bind简单.


bind举例：

   // 假设想监听文本框的内容，并且在每次输出结果的时候，都在文本框的内容拼接一段文字“输出：”

    // 方式一:在返回结果后，拼接。
        [_textField.rac_textSignal subscribeNext:^(id x) {

            NSLog(@"输出:%@",x);

        }];

    // 方式二:在返回结果前，拼接，使用RAC中bind方法做处理。
    // bind方法参数:需要传入一个返回值是RACStreamBindBlock的block参数 _textField.rac_textSignal bind:^RACStreamBindBlock
    // RACStreamBindBlock是一个block的类型，返回值是信号，参数（value,stop），因此参数的block返回值也是一个block。

    // RACStreamBindBlock:
    // 参数一(value):表示接收到信号的原始值，还没做处理
    // 参数二(*stop):用来控制绑定Block，如果*stop = yes,那么就会结束绑定。
    // 返回值：信号，做好处理，在通过这个信号返回出去，一般使用RACReturnSignal,需要手动导入头文件RACReturnSignal.h。

    // bind方法使用步骤:
    // 1.传入一个返回值RACStreamBindBlock的block。
    // 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。
    // 3.描述一个返回结果的信号，作为bindBlock的返回值。
    // 注意：在bindBlock中做信号结果的处理。

    // 底层实现:
    // 1.源信号调用bind,会重新创建一个绑定信号。
    // 2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。
    // 3.当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
    // 4.调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。
    // 5.订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

    // 注意:不同订阅者，保存不同的nextBlock，看源码的时候，一定要看清楚订阅者是哪个。
    // 这里需要手动导入#import <ReactiveCocoa/RACReturnSignal.h>，才能使用RACReturnSignal。
    [[_textField.rac_textSignal bind:^RACStreamBindBlock{//会创建一个bind信号

        // 什么时候调用:
        // block作用:表示绑定了一个信号.

        return ^RACStream *(id value, BOOL *stop){//value信号的原始值，保存didSubscribe

            // 什么时候调用block:当信号有新的值发出，就会来到这个block。值变化后就有新信号发出会调用bindingBlock

            // block作用:做返回值的处理

            // 做好处理，通过信号返回出去.RACReturnSignal信号会拿到订阅者把内容sendnext发送出去
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        };

    }] subscribeNext:^(id x) {//bind信号订阅时，会创建保存订阅者，订阅者属于bind信号返回的RACReturnSignal信号，信号中的didSubscribe，生成一个bindingBlock。

        NSLog(@"%@",x);

    }];
    
    
    
    
    
ReactiveCocoa操作方法之映射(flattenMap,Map)  flattenMap，Map用于把源信号内容映射成新的内容

flattenMap简单使用：

    // flattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。

    // flattenMap使用步骤:
    // 1.传入一个block，block类型是返回值RACStream，参数value
    // 2.参数value就是源信号的内容，拿到源信号的内容做处理
    // 3.包装成RACReturnSignal信号，返回出去。


    [[_textField.rac_textSignal flattenMap:^RACStream *(id value) {

        // block什么时候 : 源信号发出的时候，就会调用这个block。

        // block作用 : 改变源信号的内容。

        // 返回值：绑定信号的内容.
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];

    }] subscribeNext:^(id x) {

        // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。  创建保存的是bind信号返回信号RACReturnSignal的订阅者

        NSLog(@"%@",x);

    }];
    
    
     // flattenMap底层实现:
    // 0.flattenMap内部调用bind方法实现的,flattenMap中block的返回值，会作为bind中bindBlock的返回值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 2.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 3.调用bindBlock，内部就会调用flattenMap的block，flattenMap的block作用：就是把处理好的数据包装成信号。
    // 4.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 5.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。




    
Map简单使用:


    // Map作用:把源信号的值映射成一个新的值

    // Map使用步骤:
    // 1.传入一个block,类型是返回对象，参数是value
    // 2.value就是源信号的内容，直接拿到源信号的内容做处理
    // 3.把处理好的内容，直接返回就好了，不用包装成信号，返回的值，就是映射的值。
    
    
   [[_textField.rac_textSignal map:^id(id value) {
        // 当源信号发出，就会调用这个block，修改源信号的内容
        // 返回值：就是处理完源信号的内容。
        return [NSString stringWithFormat:@"输出:%@",value];
    }] subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];    
    
    
    // Map底层实现:  核心（Map底层其实是调用flatternMap）
    // 0.Map底层其实是调用flatternMap,Map中block中的返回的值会作为flatternMap中block中的值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 3.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 4.调用bindBlock，内部就会调用flattenMap的block
    // 5.flattenMap的block内部会调用Map中的block，把Map中的block返回的内容包装成返回的信号。
    // 5.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 6.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来
    
    
FlatternMap和Map的区别
	1.FlatternMap中的Block返回信号。
	2.Map中的Block返回对象。
	3.开发中，如果信号发出的值不是信号，映射一般使用Map
	4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap。
	
	
	
RACSubject的RACSubject（信号的信号）使用FlatternMap

    // 创建信号中的信号
    RACSubject *signalOfsignals = [RACSubject subject];//信号的信号
    RACSubject *signal = [RACSubject subject];//信号

    [[signalOfsignals flattenMap:^RACStream *(id value) {

     // 当signalOfsignals的signals发出信号才会调用

        return value;

    }] subscribeNext:^(id x) {

        // 只有signalOfsignals的signal发出信号才会调用，因为内部订阅了bindBlock中返回的信号，也就是flattenMap返回的信号。
        // 也就是flattenMap返回的信号发出内容，才会调用。

        NSLog(@"%@aaa",x);
    }];

    // 信号的信号发送信号
    [signalOfsignals sendNext:signal];

    // 信号发送内容
    [signal sendNext:@1];
    
    
    
    
ReactiveCocoa操作方法之组合  

concat:  按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。

    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

		[subscriber sendNext:@1];

		[subscriber sendCompleted];

		return nil;
	}];
	RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

		[subscriber sendNext:@2];

		return nil;
	}];

	// 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
	RACSignal *concatSignal = [signalA concat:signalB];

	// 以后只需要面对拼接信号开发。
	// 订阅拼接的信号，不需要单独订阅signalA，signalB
	// 内部会自动订阅。
	// 注意：第一个信号必须发送完成，第二个信号才会被激活
	[concatSignal subscribeNext:^(id x) {

		NSLog(@"%@",x);//打印两次，分别是第一个信号的值 第二个信号的值

	}];

	// concat底层实现:
	// 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
	// 2.didSubscribe中，会先订阅第一个源信号（signalA）
	// 3.会执行第一个源信号（signalA）的didSubscribe
	// 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
	// 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
	// 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
	// 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
	
	
	

then:  用于连接两个信号，当第一个信号完成，才会连接then返回的信号。

	// then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
	// 注意使用then，之前信号的值会被忽略掉.
	// 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
	[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
 
		[subscriber sendNext:@1];
		[subscriber sendCompleted];
		return nil;
	}] then:^RACSignal *{
		return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
			[subscriber sendNext:@2];
			return nil;
		}];
	}] subscribeNext:^(id x) {
  
		// 只能接收到第二个信号的值，也就是then返回信号的值，之前信号的值会被忽略掉
		NSLog(@"%@",x);
	}];
	
	
	
	
merge:  把多个信号合并为一个信号，任何一个信号有新值的时候就会调用，与concat拼接信号不同的是这里不需要等signalA发送完成再发送signalB


    // merge:把多个信号合并成一个信号
    //创建多个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];

    // 合并信号,任何一个信号发送数据，都能监听到.
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    [mergeSignal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);//打印两次信号的值 
        
    }];
    
    // 底层实现：
    // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
    // 2.每发出一个信号，这个信号就会被订阅
    // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
    // 4.只要有一个信号被发出就会被监听。
    
    
    
zipWith:    把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。

   RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];

    
    
    // 压缩信号A，信号B
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    [zipSignal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);//接收一次，里面包含信号1和信号2的值
    }];
    
    // 底层实现:
    // 1.定义压缩信号，内部就会自动订阅signalA，signalB
    // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
    
    
    
    
combineLatest:    与zipWith没什么区别，将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。

     RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
       [subscriber sendNext:@1];
       
       return nil;
   }];
   
   RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
       [subscriber sendNext:@2];
       
       return nil;
   }];

   // 把两个信号组合成一个信号,跟zip一样，没什么区别
   RACSignal *combineSignal = [signalA combineLatestWith:signalB];
 
   [combineSignal subscribeNext:^(id x) {
      
       NSLog(@"%@",x);
   }];
   
   // 底层实现：
   // 1.当组合信号被订阅，内部会自动订阅signalA，signalB,必须两个信号都发出内容，才会被触发。
   // 2.并且把两个信号组合成元组发出。
   
   
   
reduce聚合:    由于信号发出的内容是元组，把信号发出元组的值聚合成一个值，（即把返回结果为元组的值更换返回类型）每个信号发送信号都能收到一次

	  RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
	 
		 [subscriber sendNext:@1];
	 
		 return nil;
	 }];
 
	 RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
	 
		 [subscriber sendNext:@2];
	 
		 return nil;
	 }];
 
	 // 聚合
	 // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
	 // reduce中的block简介:
	 // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
	 // reduceblcok的返回值：聚合信号之后的内容。
	RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
 
		return [NSString stringWithFormat:@"%@ %@",num1,num2];
	
	}];
 
	 [reduceSignal subscribeNext:^(id x) {
	
		 NSLog(@"%@",x);
	 }];
 
	 // 底层实现:
	 // 1.订阅聚合信号，每次有内容发出，就会执行reduceblcok，把信号内容转换成reduceblcok返回的值。
	 
	 
	 
	 
ReactiveCocoa操作方法之过滤

filter:  过滤信号 获取满足条件的信号.

	// 过滤:
	// 每次信号发出，会先执行过滤条件判断.
	[_textField.rac_textSignal filter:^BOOL(NSString *value) {
			return value.length > 3;
	}];
	

ignore:  忽略完某些值的信号
    // 内部调用filter过滤，忽略掉ignore的值
	[[_textField.rac_textSignal ignore:@"1"] subscribeNext:^(id x) {

		NSLog(@"%@",x);
	}];


distinctUntilChanged:  当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉

    // 过滤，当上一次和当前的值不一样，就会发出内容。
	// 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
	[[_textField.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
  
		NSLog(@"%@",x);
	}];
	
	

take:  从开始一共取N次的信号

	// 1、创建信号
	RACSubject *signal = [RACSubject subject];

	// 2、处理信号，订阅信号
	[[signal take:1] subscribeNext:^(id x) {
	
		NSLog(@"%@",x);
	}];

	// 3.发送信号
	[signal sendNext:@1];

	[signal sendNext:@2];
	
	
takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号.

	// 1、创建信号
	RACSubject *signal = [RACSubject subject];

	// 2、处理信号，订阅信号
	[[signal takeLast:1] subscribeNext:^(id x) {
	
		NSLog(@"%@",x);
	}];

	// 3.发送信号
	[signal sendNext:@1];

	[signal sendNext:@2];

	[signal sendCompleted];
	
	
takeUntil:(RACSignal *):  获取信号直到某个信号执行完成

	// 监听文本框的改变直到当前对象被销毁
	[_textField.rac_textSignal takeUntil:self.rac_willDeallocSignal];
	
	
skip:(NSUInteger):  跳过几个信号,不接受。

	// 表示输入第一次，不会被监听到，跳过第一次发出的信号
	[[_textField.rac_textSignal skip:1] subscribeNext:^(id x) {
   
		NSLog(@"%@",x);
	}];
	
	
switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。

	RACSubject *signalOfSignals = [RACSubject subject];
	RACSubject *signal = [RACSubject subject];

	// 获取信号中信号最近发出信号，订阅最近发出的信号。
	// 注意switchToLatest：只能用于信号中的信号
	[signalOfSignals.switchToLatest subscribeNext:^(id x) {
   
		NSLog(@"%@",x);
	}];
	[signalOfSignals sendNext:signal];//信号中的信号
	[signal sendNext:@1];
	
	
	
	
ReactiveCocoa操作方法之秩序

doNext:  执行Next之前，会先执行这个Block
doCompleted:  执行sendCompleted之前，会先执行这个Block

	[[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
	    [subscriber sendNext:@1];
	    [subscriber sendCompleted];
	     return nil;
	}] doNext:^(id x) {
	// 执行[subscriber sendNext:@1];之前会调用这个Block
	    NSLog(@"doNext");;
	}] doCompleted:^{
	    // 执行[subscriber sendCompleted];之前会调用这个Block
	    NSLog(@"doCompleted");;
	}] subscribeNext:^(id x) {
  
		NSLog(@"%@",x);
	}];
	
	
	
ReactiveCocoa操作方法之线程

deliverOn: 内容传递切换到制定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用。

subscribeOn: 内容传递和副作用都会切换到制定线程中



ReactiveCocoa操作方法之时间

timeout：超时，可以让一个信号在一定的时间后，自动报错

	 RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		return nil;
	}] timeout:1 onScheduler:[RACScheduler currentScheduler]];


	[signal subscribeNext:^(id x) {
	
		NSLog(@"%@",x);
	} error:^(NSError *error) {
		// 1秒后会自动调用
		NSLog(@"%@",error);
	}];
	
	
interval 定时：每隔一段时间发出信号

	[[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
   
		NSLog(@"%@",x);
	}];


delay： 延迟发送next

    RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
   
		[subscriber sendNext:@1];
		return nil;
		
	}] delay:2] subscribeNext:^(id x) {
  
		NSLog(@"%@",x);
	}];




ReactiveCocoa操作方法之重复

retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功.

     __block int i = 0;
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
            if (i == 10) {
                [subscriber sendNext:@1];
            }else{
                NSLog(@"接收到错误");
                [subscriber sendError:nil];
            }
            i++;
        
        return nil;
        
    }] retry] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    } error:^(NSError *error) {
      
        
    }];
    

replay重放：当一个信号被多次订阅,反复播放内容

    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
   
    
		[subscriber sendNext:@1];
		[subscriber sendNext:@2];
		return nil;
		
	}] replay];

	[signal subscribeNext:^(id x) {
   
		NSLog(@"第一个订阅者%@",x);
	
	}];

	[signal subscribeNext:^(id x) {
	
		NSLog(@"第二个订阅者%@",x);
	
	}];
	
	
	
throttle节流:  当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出

    RACSubject *signal = [RACSubject subject];

    _signal = signal;

	// 节流，在一定时间（1秒）内，不接收任何信号内容，过了这个时间（1秒）获取最后发送的信号内容发出。
	[[signal throttle:1] subscribeNext:^(id x) {
   
		NSLog(@"%@",x);
	}];
	
	
	
	
	
	
	
	
介绍MVVM架构思想

常见的架构思想:

MVC M:模型 V:视图 C:控制器
MVVM M:模型 V:视图+控制器 VM:视图模型
   我的理解：
     V：视图层view,viewcontrol：
        view：   控件初始化，设置数据，事件代理，不涉及网络，业务数据，只是ui数据设置，有交互以代理方式回传给viewcontrol
        viewcontrol:视图的创建，组合，包括视图之间协调逻辑，view事件回调处理
     VM:业务逻辑层viewmodel：
        viewmodel：业务逻辑处理，预排版，把网络数据转成ui数据。数据增删改查的封装者，不承担增删改查逻辑，线程安全处理，如微博下拉刷新，
        同时删除评论，需保证线程安全。
     数据层engine和model:
        engine：负责网络请求，数据解析，实际增删改查，本地的处理逻辑，如对server适配，如返回的字段需要转化传给ui
        
MVCS M:模型 V:视图 C:控制器 S:服务类

VIPER V:视图 I:交互器 P:展示器 E:实体 R:路由



MVVM介绍

模型(M):保存视图数据。

视图+控制器(V):展示内容 + 如何展示

视图模型(VM):处理展示的业务逻辑，包括按钮的点击，数据的请求和解析等等。


ReactiveCocoa + MVVM 实战一：   登录界面

需求+分析+步骤

/* 需求：1.监听两个文本框的内容，有内容才允许按钮点击
        2.默认登录请求.
 
   用MVVM：实现，之前界面的所有业务逻辑
   分析：1.之前界面的所有业务逻辑都交给控制器做处理
        2.在MVVM架构中把控制器的业务全部搬去VM模型，也就是每个控制器对应一个VM模型.
 
   步骤：1.创建LoginViewModel类，处理登录界面业务逻辑.
        2.这个类里面应该保存着账号的信息，创建一个账号Account模型
        3.LoginViewModel应该保存着账号信息Account模型。
        4.需要时刻监听Account模型中的账号和密码的改变，怎么监听？
        5.在非RAC开发中，都是习惯赋值，在RAC开发中，需要改变开发思维，由赋值转变为绑定，可以在一开始初始化的时候，就给Account模型中的属性绑定，并不需要重写set方法。
        6.每次Account模型的值改变，就需要判断按钮能否点击，在VM模型中做处理，给外界提供一个能否点击按钮的信号.
        7.这个登录信号需要判断Account中账号和密码是否有值，用KVO监听这两个值的改变，把他们聚合成登录信号.
        8.监听按钮的点击，由VM处理，应该给VM声明一个RACCommand，专门处理登录业务逻辑.
        9.执行命令，把数据包装成信号传递出去
        10.监听命令中信号的数据传递
        11.监听命令的执行时刻
 */
 
 


VM的代码

	@interface LoginViewModel : NSObject

	@property (nonatomic, strong) Account *account;


	// 是否允许登录的信号
	@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

	@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

	@end

	@implementation LoginViewModel
	- (Account *)account
	{
		if (_account == nil) {
			_account = [[Account alloc] init];
		}
		return _account;
	}
	- (instancetype)init
	{
		if (self = [super init]) {
			[self initialBind];
		}
		return self;
	}


	// 初始化绑定
	- (void)initialBind
	{
		// 监听账号的属性值改变，把他们聚合成一个信号。有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
		// 信号1RACObserve(self.account, account) 信号2   RACObserve(self.account, pwd) 
		// RACObserve(self, name):监听某个对象的某个属性,返回的是信号
		// control中代码：RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;按钮与信号绑定，会使enabled属性自动变为yes或no
		//监听文本框输入状态，确定按钮是否可以点击，return @(account.length && pwd.length);返回为bool值
		_enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, pwd)] reduce:^id(NSString *account,NSString *pwd)
		{
	
			return @(account.length && pwd.length);
	
		}];

		// 处理登录业务逻辑
		_LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
	
			NSLog(@"点击了登录");
			return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {//RACCommand 必须返回信号
		
				// 模仿网络延迟
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			
					[subscriber sendNext:@"登录成功"];//1。发送信号
			
					// 数据传送完毕，必须调用完成，否则命令永远处于执行状态
					[subscriber sendCompleted];
				});
		
				return nil;
			}];
		}];

		// 监听登录产生的数据 LoginCommand.executionSignals是RACCommand中的信号，switchToLatest表示信号的信号
		// 这段代码表示要订阅LoginCommand中信号中的信号 上面的[subscriber sendNext:@"登录成功"]，下面这个block则会执行
		[_LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
   
			if ([x isEqualToString:@"登录成功"]) {
				NSLog(@"登录成功");
			}
		}];

		// 监听登录状态
		// skip:1  表示输入第一次，不会被监听到，跳过第一次发出的信号
		// 监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号
		[[_LoginCommand.executing skip:1] subscribeNext:^(id x) {
			if ([x isEqualToNumber:@(YES)]) {
		
				// 正在登录ing... 命令信号正在执行
				// 用蒙版提示
				[MBProgressHUD showMessage:@"正在登录..."];
	   
		
			}else
			{
				// 登录成功    命令信号执行完成
				// 隐藏蒙版
				[MBProgressHUD hideHUD];
			}
		}];
	}

 
 
控制器的代码:  控制器只是绑定了按钮可否点击与是否可点击信号，绑定输入框内容改变与loginViewModel.account，业务逻辑全在vm中
 
 
		@interface ViewController ()

		@property (nonatomic, strong) LoginViewModel *loginViewModel;

		@property (weak, nonatomic) IBOutlet UITextField *accountField;
		@property (weak, nonatomic) IBOutlet UITextField *pwdField;

		@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


		@end

		- (LoginViewModel *)loginViewModel
		{
			if (_loginViewModel == nil) {
		
				_loginViewModel = [[LoginViewModel alloc] init];
			}
			return _loginViewModel;
		}

		// 视图模型绑定
		- (void)bindModel
		{
			// 给模型的属性绑定信号
			// 只要账号文本框一改变，就会给account赋值
			//RACObserve(self, name):监听某个对象的某个属性,返回的是信号
			//self.loginViewModel.account会绑定文本框文字变化的信号
			RAC(self.loginViewModel.account, account) = _accountField.rac_textSignal;
			RAC(self.loginViewModel.account, pwd) = _pwdField.rac_textSignal;
	
			// 绑定登录按钮  业务需求，监听两个文本框的内容，有内容才允许按钮点击  
			// 按钮的可否点击属性会绑定 self.loginViewModel.enableLoginSignal登录开关信号
			RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
	
		   // 监听登录按钮点击
			[[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
	  
				// 执行登录事件执行命令,会执行LoginCommand信号，相当于sendNext
				[self.loginViewModel.LoginCommand execute:nil];
			}];
		}







ReactiveCocoa + MVVM 实战二：网络请求数据

接口：这里先给朋友介绍一个免费的网络数据接口，豆瓣。可以经常用来练习一些网络请求的小Demo.

需求+分析+步骤

/*
    需求：请求豆瓣图书信息，url:https://api.douban.com/v2/book/search?q=基础
    
    分析：请求一样，交给VM模型管理
 
    步骤:
        1.控制器提供一个视图模型（requesViewModel），处理界面的业务逻辑
        2.VM提供一个命令，处理请求业务逻辑
        3.在创建命令的block中，会把请求包装成一个信号，等请求成功的时候，就会把数据传递出去。
        4.请求数据成功，应该把字典转换成模型，保存到视图模型中，控制器想用就直接从视图模型中获取。
        5.假设控制器想展示内容到tableView，直接让视图模型成为tableView的数据源，把所有的业务逻辑交给视图模型去做，这样控制器的代码就非常少了。
 */
 
 
 
视图模型(VM)代码

		@interface RequestViewModel : NSObject<UITableViewDataSource>


			// 请求命令
			@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

			//模型数组
			@property (nonatomic, strong, readonly) NSArray *models;



		@end

		@implementation RequestViewModel

		- (instancetype)init
		{
			if (self = [super init]) {
		
				[self initialBind];
			}
			return self;
		}


		- (void)initialBind
		{
			_reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		
				RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		   
			
					NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
					parameters[@"q"] = @"基础";
			
					// 发送请求
					[[AFHTTPRequestOperationManager manager] GET:@"https://api.douban.com/v2/book/search" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
						NSLog(@"%@",responseObject);
				
						// 请求成功调用
						// 把数据用信号传递出去
						// 控制器订阅后会接收到这个信号，但这个信号会被第三步数据处理
						[subscriber sendNext:responseObject];
				
						[subscriber sendCompleted];
				
				
					} failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
						// 请求失败调用
				
					}];
			
					return nil;
				}];
		
		
		
	            //第三步先进行数据处理
				// 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
				return [requestSignal map:^id(NSDictionary *value) {
					NSMutableArray *dictArr = value[@"books"];

					// 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
					NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
			 
						return [Book bookWithDict:value];
					}] array];
			
					return modelArr;
				}];
		
			}];
	
		 }

		#pragma mark - UITableViewDataSource

		- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
		{
			return self.models.count;
		}

		- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
		{
			static NSString *ID = @"cell";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
			if (cell == nil) {
		
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
			}
	
			Book *book = self.models[indexPath.row];
			cell.detailTextLabel.text = book.subtitle;
			cell.textLabel.text = book.title;
	
			return cell;
		}

		@end
 
 
 
控制器代码

	@interface ViewController ()

	@property (nonatomic, weak) UITableView *tableView;

	@property (nonatomic, strong) RequestViewModel *requesViewModel;


	@end

	@implementation ViewController
	- (RequestViewModel *)requesViewModel
	{
		if (_requesViewModel == nil) {
			_requesViewModel = [[RequestViewModel alloc] init];
		}
		return _requesViewModel;
	}

	- (void)viewDidLoad {
		[super viewDidLoad];
		// Do any additional setup after loading the view, typically from a nib.
	
		// 创建tableView
		UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		tableView.dataSource = self.requesViewModel;
	
		[self.view addSubview:tableView];
	
		// 执行命令信号的请求
	 RACSignal *requesSiganl = [self.requesViewModel.reuqesCommand execute:nil];
   
	   // 获取请求的数据，订阅命令信号
		[requesSiganl subscribeNext:^(NSArray *x) {
		
			self.requesViewModel.models = x;
		
			[self.tableView reloadData];
		
		}];

	}


	@end





