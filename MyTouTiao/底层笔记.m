TimLiu-iOS  各路大神收集的资料：https://github.com/Tim9Liu9/TimLiu-iOS/blob/master/README.md
http://www.52im.net/forum.php?mod=viewthread&tid=510&highlight=webrtc 即时通讯网
https://www.agora.io/cn/?utm_source=baidu&utm_medium=cpc 声卡网 sbpdcfn@126.com rox**17
夏天的风_song
链接：https://www.jianshu.com/p/7ca9048afa5b
    1.库和宏的一点点
    <SystemConfiguration/SystemConfiguration.h>    网络配置的库  属于coresever 如联网
    <Availability.h> 判断系统版本
    if __IPHONE_OS_VERSION_MIN_REQUIRED  最低ios版本
    
    2.#pragma 用法
    忽略编译器警告
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wgnu"
    注解
    #pragma mark - NSURLSessionDataTaskDelegate
    
    3.全局变量定义
    FOUNDATION_EXPORT NSString * const AFNetworkingTaskDidFinishNotification; .h中
    NSString * const AFNetworkingTaskDidFinishNotification = @"com.alamofire.networking.task.resume"; .m中
    
    4.strong weak的使用
    @property (nonatomic, weak) AFURLSessionManager *manager;
    __strong AFURLSessionManager *manager = self.manager;
    
    5.copy技巧
      NSData *data = nil;
    if (self.mutableData) {
        data = [self.mutableData copy];
        //We no longer need the reference, so nil it out to gain back some memory.
        self.mutableData = nil;
    }
    
    6.组任务
    当dispatch_group_async的block里面执行的是异步任务，如果还是使用上面的方法你会发现异步任务还没跑完就已经进入到了
    dispatch_group_notify方法里面了，这时用到dispatch_group_enter和dispatch_group_leave就可以解决这个问题：

#pragma mark - 语法 
- (void)downloadBaseData  
{  
    // 全局变量group  
    group = dispatch_group_create();  
    // 并行队列  
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);  
      
    // 进入组（进入组和离开组必须成对出现, 否则会造成死锁）  
    dispatch_group_enter(group);  
    dispatch_group_async(group, queue, ^{  
        // 执行异步任务1  
        [self fetchBaseData];  
    });  
      
    // 进入组  
    dispatch_group_enter(group);  
    dispatch_group_async(group, queue, ^{  
        // 执行异步任务2  
        [self fetchInspectorBaseData];  
    });  
      
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{  
        [SVProgressHUD dismiss];  
        ILog(@"全部基础数据下载完毕!");  
        [[AppDelegate sharedDelegate] showMainView];  
    });  
}  
  
#pragma mark - 用例  
- (void)fetchBaseData  
{  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{  
        [SVProgressHUD showWithStatus:@"下载基础数据中..."];  
    });  
    NSDictionary *params = @{ kPage: @0, kPageSize: @9999 };  
    [BaseDataService fetchBaseDataWithParams:params showHUD:NO success:^(NSDictionary *response) {  
          
        if ([response[kStatusCode] intValue] == kSuccessCode) {  
              
            NSArray *array = [BaseDataModel arrayOfModelsFromDictionaries:response[@"rows"] error:nil];  
            if (!array || !array.count ) {  
                [SVProgressHUD showErrorWithStatus:@"下载基础数据失败"];  
                return;  
            }  
            // 保存数据库  
            [BaseDataService saveBaseData:array];  
            // 离开组  
            dispatch_group_leave(group);  
        }  
          
    } failure:^(NSError *error) {  
          
    }];  
}  
  
#pragma mark - 获取巡查基础数据  
- (void)fetchInspectorBaseData  
{  
    NSDictionary *params = @{ kPage: @0, kPageSize: @9999 };  
    [BaseDataService fetchInspectorBaseDataWithParams:params showHUD:NO success:^(NSDictionary *response) {  
        [SVProgressHUD dismiss];  
          
        if ([response[kStatusCode] intValue] == kSuccessCode) {  
              
            NSArray *array = [InspectorBaseDataModel arrayOfModelsFromDictionaries:response[@"rows"] error:nil];  
            if (!array || !array.count ) {  
                [SVProgressHUD showErrorWithStatus:@"下载巡查基础数据失败"];  
                return;  
            }  
            // 保存数据库  
            [BaseDataService saveInspectorBaseData:array];  
            // 离开组  
            dispatch_group_leave(group);  
        }  
          
    } failure:^(NSError *error) {  
          
    }];  
}  

 7. moveItemAtURL  copyItemAtURL
 //  location是下载的临时文件目录,将文件从临时文件夹移动到沙盒  
  [[NSFileManager defaultManager] moveItemAtURL:location toURL:self.downloadFileURL error:&fileManagerError];
   //  location是下载的临时文件目录,将文件从临时文件夹复制到沙盒  
  BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
  
  8.runloop 
  方法交换之互相交换1：
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    例：
    Person * p1 = [[Person alloc] init];   
    Method m1 = class_getInstanceMethod([p1 class], @selector(printDZL));  
    Method m2 = class_getClassMethod([Person class], @selector(printDZ));  
  方法交换之一个方法交换为另一个方法2：
  将方法originalSelector替换成af_originalSelector
    af_swizzleSelector(theClass, @selector(af_originalSelector), @selector(originalSelector));
  方法添加：
  
  class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
    例：
  Method originMethod = class_getInstanceMethod(self, origSel);  
  class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
  
  8.担心某个方法以后可能不存在
  NSClassFromString(@"NSURLSessionTask")
  
  9.获取方法的指针并判断地址是否相等
      IMP classResumeIMP = method_getImplementation(class_getInstanceMethod(currentClass, @selector(resume)));
      IMP superclassResumeIMP = method_getImplementation(class_getInstanceMethod(superClass, @selector(resume)));
      if (classResumeIMP != superclassResumeIM)
  10.将某个方法转换为字符串
  NSString *str = NSStringFromSelector(@selector(test))
  
  11.respondsToSelector方法编写，判断一个方法是否可用
  - (BOOL)respondsToSelector:(SEL)selector {
    if (selector == @selector(URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:)) {
        return self.taskWillPerformHTTPRedirection != nil;
    } else if (selector == @selector(URLSession:dataTask:didReceiveResponse:completionHandler:)) {
        return self.dataTaskDidReceiveResponse != nil;
    } else if (selector == @selector(URLSession:dataTask:willCacheResponse:completionHandler:)) {
        return self.dataTaskWillCacheResponse != nil;
    } else if (selector == @selector(URLSessionDidFinishEventsForBackgroundURLSession:)) {
        return self.didFinishEventsForBackgroundURLSession != nil;
    }

    return [[self class] instancesRespondToSelector:selector];
}

  12. App Transport Security(ATS)
  iOS9 引入了新特性 App Transport Security (ATS)，要求 App 内访问的网络必须使用 HTTPs 协议。
  评估https相关证书是否被信任
  [self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]
  证书类别：
  NSURLSessionAuthChallengeUseCredential = 0, 使用（信任）证书 
  NSURLSessionAuthChallengePerformDefaultHandling = 1, 默认，忽略
  NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,   取消
  NSURLSessionAuthChallengeRejectProtectionSpace = 3,      这次取消，下载次还来问

  13.NSCopying NSMutableCopying用来实现对象的拷贝 ，NSMutableCopying拷贝的对象是可变的，深拷贝， NSCopying拷贝对象是不可变的，拷贝一个可变的对象是深拷贝，拷贝一个不
  可变的对象，是浅拷贝
  
  
  @interface Person : NSObject <NSCopying> 
  @end 
  @implementation Person 
    - (id)copyWithZone:(NSZone *)zone 
    { 
     //错误 Person *p = [[Person alloc] init]; 
      Person *p = [[[self class] alloc] init]; // <== 注意这里 
      return p; 
    } 
  @end
  @implementation Student 
    - (id)copyWithZone:(NSZone *)zone 
    { 
      Student *s = [super copyWithZone:zone]; 
      return s; 
   } 
  @end 
  原因：
  问题出在哪里了呢?
  这里:Student *s = [super copyWithZone:zone];
  由于右边的返回值是一个父类Person的实例,s便不是Student。所以当调用 s.studentId = self.studentId这个setter时,便返回了以上错误。
  
  NSCopying
  Person *p = [[Person alloc] init]; 
  Person *p1 = [Person copy];
  
  NSMutableCopying
  NSArray *nameArray = @[@"Jim", @"Tom", @"David"];
  NSArray *copyArray = [nameArray copy];
  NSMutableArray *mutableCopyArray = [nameArray mutableCopy];
  [mutableCopyArray addObject:@"Sam"];
  
  
  14.判断网络是否可用
  afnetworking中
  BOOL isNetwork = [ZLBNetworkReachablity getNetWorkStatus];
  其实调用的是Reachability 第三方工具
  Reachability  *hostReach = [Reachability reachabilityForInternetConnection];
  Reachability 第三方其实是使用SystemConfiguration/SCNetworkReachability.h 底层
  SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
  
  15.swift监听值
    /// 当statuses值发生变化时，会执行tableView.reloadData()
    var statuses: [Status]?
        {
        didSet{
            tableView.reloadData()
        }
    }
    
  16.swift中UITableView用法
  
  继承了: UITableViewController中
      /// 保存所有数据
    var statuses: [Status]?
    {
        didSet{
            tableView.reloadData()
        }
    }
      // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.statuses?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        // 2.设置数据
        cell.status = statuses![indexPath.row]
        // 3.返回cell
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    上面三个代理方法也可以这样子写
    extension HomeTableViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.statuses?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        // 2.设置数据
        cell.status = statuses![indexPath.row]
        // 3.返回cell
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
}

在cell中
class HomeTableViewCell: UITableViewCell {
    /// 头像
    @IBOutlet weak var iconImageView: UIImageView!
    /// 认证图标
    @IBOutlet weak var verifiedImageView: UIImageView!
    /// 昵称
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var vipImageView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// 正文
    @IBOutlet weak var contentLabel: UILabel!
    
    /// 模型数据
    var status: Status?
    {
        didSet{
            // 1.设置头像
            if let urlStr = status?.user?.profile_image_url
            {
                let url = URL(string:urlStr)
                iconImageView.sd_setImage(with:url)
            }
            // 2.设置认证图标
            if let type = status?.user?.verified_type
            {
                var name = ""
                switch type
                {
                case 0:
                    name = "avatar_vip"
                case 2, 3, 5:
                    name = "avatar_enterprise_vip"
                case 220:
                    name = "avatar_grassroot"
                default:
                    name = ""
                }
                verifiedImageView.image = UIImage(named: name)
            }
            
            
            // 3.设置昵称
            nameLabel.text = status?.user?.screen_name
            
            // 4.设置会员图标
            
            // 5.设置时间
            timeLabel.text = status?.created_at
            
            // 6.设置来源
            sourceLabel.text = status?.source
            
            // 7.设置正文
            contentLabel.text = status?.text
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 1.设置正文最大宽度
        contentLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

在model中这样写
import UIKit

class Status: NSObject {

    var created_at: String?

    var idstr: String?

    var text: String?

    var source: String?

    var user: User?
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    
    /// KVC的setValuesForKeysWithDictionary方法内部会调用setValue方法
    override func setValue(_ value: Any?, forKey key: String) {
        NJLog(message:"key = \(key), value = \(String(describing: value))")
        // 1.拦截user赋值操作
        if key == "user"
        {
            user = User(dict: value as! [String : AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    

    
    override var description: String {
        let property = ["created_at", "idstr", "text", "source"]
        let dict = dictionaryWithValues(forKeys:property)
        return "\(dict)"
    }
}

17. 线程

    https://www.jianshu.com/p/0aeb2848780d
    同步：没有开启新线程的能力
    异步：可以开启一个新线程
    串行队列： 任务一个一个取出来，放到当前所在的一条线程上执行
    同步队列： 任务一个一个取出来，每个任务都放到不同的线程上去执行
    
    1.  pthread_t thread1;
    pthread_create(&thread1, NULL, run, NULL);
    //void *(*)(void *)
    void *run(void *param)
    {
      return NULL;
    }
    2. /*默认开启线程 */
    [self performSelectorInBackground:@selector(run:) withObject:@"后台线程"];
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"wendingding"];
    /*调用start方法开启线程 */
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    thread1.name = @"线程1";
    //线程优先级
    [thread1 setThreadPriority:1.0];
    //开启线程
    [thread1 start];
    -(void)run:(NSString *)str
    //线程生命周期结束
    [NSThread exit];
    //三个阻塞线程的函数
    [NSThread sleepForTimeInterval:3.0];
    [NSThread sleepUntilDate:[NSDate distantFuture]];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
    //回主线程，线程间的通迅
    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    //线程安全加互斥锁
        @synchronized(self) {
            [NSThread sleepForTimeInterval:0.03];
            //1.先查看余票数量
            NSInteger count = self.totalticket;
            
            if (count >0) {
                self.totalticket = count - 1;
                NSLog(@"%@卖出去了一张票,还剩下%zd张票",[NSThread currentThread].name,self.totalticket);
            }else
            {
                NSLog(@"%@发现当前票已经买完了--",[NSThread currentThread].name);
                break;
            }
        }
     //gcd 同步函数
    //获得主队列
    dispatch_queue_t queue =  dispatch_get_main_queue();
    //创建队列(并发)
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //同步函数
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
    //异步函数
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
    //创建队列组
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
    });
    dispatch_group_async(group, queue, ^{
        
    });
    //合成
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
    
    //NSOperation
   NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //在主线程
    }];
   //在子线程
    [op addExecutionBlock:^{
        NSLog(@"3------%@",[NSThread currentThread]);
    }];
    //启动操作执行
    [op start];
    
    
    //NSOperationQueue队列
     NSOperationQueue *queue = [[NSOperationQueue alloc]init];
     NSOperation *op = [[NSOperation alloc]init];
     NSOperation *op1 = [[NSOperation alloc]init];
    [queue addOperation:op];
    [queue addOperation:op1];
     maxConcurrentOperationCount=1 串行队列
     
     //监听与依赖
     NSOperationQueue *queue = [[NSOperationQueue alloc]init];
     NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4----%@",[NSThread currentThread]);
      }];
     op4.completionBlock = ^{//监听
        NSLog(@"op4已经完成了---%@",[NSThread currentThread]);
      };
     //添加操作依赖,op5，op4执行完成才执行op1
     [op1 addDependency:op5];
     [op1 addDependency:op4];
     [queue addOperation:op4];
     
     
     //多图片下载
     原理：
     1、一个并发队列，一个存图片的内存字典，【key:iconname  value:uiimage】,一个存放图片的缓存地址
     NSCachesDirectory，沙盒结构如下：Documents itunes会备份恢复此文件   Library 存放应用的配置
     Library/Caches itunes不会备份恢复该文件，程序退出不会删除文件内容 tmp创建和存放临时文件，有可能被
     删除
     2、查看存图片的字典是否有image,如果没有，查看Library/Caches下是否有文件，如果没有就放到并发队列下载
     下载成功后先存到image中，再存到Library/Caches中
       //在该线程休息0.2秒，因为[UIImage imageWithData:data];  转换需要时间
       UIImage *image = [UIImage imageWithData:data];                    
      [NSThread sleepForTimeInterval:2.0];
    
     3、切换到主线程刷新ui
     [[NSOperationQueue mainQueue]addOperationWithBlock:^{                      
        cell.imageView.image = image;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
      }];
      
      //kvc转model
      @interface XMGAPP : NSObject
      @property (nonatomic, strong) NSString *name;
      @property (nonatomic, strong) NSString *icon;
      @property (nonatomic, strong) NSString *download;
      +(instancetype)appWithDict:(NSDictionary *)dict;
      @end
      
      @implementation XMGAPP
      +(instancetype)appWithDict:(NSDictionary *)dict
      {
        XMGAPP *app = [[XMGAPP alloc]init];
       [app setValuesForKeysWithDictionary:dict];
       return app;
      }
      @end
      
      kvc以下注意事项
      1、模型中的每个属性必须匹配这个字典中的每个key，如果字典有一个key:name  模型中没有任何一个属性是name，kvc会报错
      2、如果模型中有个属性叫name，字典中没有这个key为name的键值对，当kvc使用时，正常
      3、如果id是个关键字：modle属性设为myid
      -(void)setValue:(id)value forUndefinedkey:(NSString*)key
      {
          if([key isEqualToString:@"id"]){
            self.myid = value;
          }
      }
      4、如果模型中没有字典中的那个属性
      //重写setValue:forUndefinedKey:方法,处理不存在的key赋值问题  
      -(void) setValue:(id)value forUndefinedKey:(NSString *)key  
      {  
        NSLog(@"您尝试设置的key: %@ 不存在",key);  
        NSLog(@"您尝试设置的value: %@",value);  
       }
      5、如果使用[item setValue:nil forKey:@"price"]; 希望不报错
      //重写setNilValueForKey方法来处理设置nil问题  
      -(void) setNilValueForKey:(NSString *)key  
        {  
          //如果设置为空的话就处理  
          if([key isEqualToString:@"price"])  
          {  
            //设置为0  
            _price = 0;  
          }  
          else  
          {  
            //回调默认的方法  
        [    super setNilValueForKey:key];  
           }  
}  


18.Runloop
   http://www.cocoachina.com/ios/20160612/16631.html
   //获得当前线程对应的runloop两种方法
   NSRunLoop *currentRunloop =[NSRunLoop currentRunLoop];
   CFRunLoopRef runloop1 = CFRunLoopGetCurrent();
   //获得主线程对应的runloop两种方法
    NSRunLoop *mainRunloop =   [NSRunLoop mainRunLoop];
    CFRunLoopRef runloop2 = CFRunLoopGetMain();
    //runloop的线程
    一个runloop只能有一条线程上运行，线程死则这个runloop死掉
    手动开启一个线程的runloop运行，用CFRunLoopGetCurrent();
    runloop与线程的存储是这样实现的
    key:runloop value:线程
    //runloop的相关类
    1：有点像基类CFRunloopRef
    2：运行的模式类CFRunloopModeRef
    3：事件源类CFRunloopSourceRef
    4：Timer事件类CFRunloopTimerRef
    5：观察者类监听runloop的状态 CFRunloopObserverRef
    Runloop要运行，它必须要在一个模式下并且有source||observer||timer，才能运行。
    //runloop的几个模式
     a.kCFRunLoopDefaultMode：App的默认Mode，通常主线程是在这个Mode下运行
     b.UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
     c.UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
     d.GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到
     e.kCFRunLoopCommonModes: 这是一个占位用的Mode，不是一种真正的Mode
     //runloop观察者模式，观察当前线程下runloop的运行状态
     -(void)observer{
    
    //CFRunLoopObserverCreate(<#CFAllocatorRef allocator#>, <#CFOptionFlags activities#>, <#Boolean repeats#>, <#CFIndex order#>, <#CFRunLoopObserverCallBack callout#>, <#CFRunLoopObserverContext *context#>)
    
    //创建一个监听对象
    /*
     第一个参数:分配存储空间的
     第二个参数:要监听的状态 kCFRunLoopAllActivities 所有状态
     第三个参数:是否要持续监听
     第四个参数:优先级
     第五个参数:回调
     */
     CFRunLoopObserverRef observer =  CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), 
     kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"runloop要去处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"runloop要去处理Sources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"runloop要睡觉了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"runloop醒来啦");
                break;

            case kCFRunLoopExit:
                NSLog(@"runloop退出");
                break;
            default:
                break;
        }
    });
    
    
    //给runloop添加监听者
    /*
     第一个参数:要监听哪个runloop
     第二个参数:监听者
     第三个参数:要监听runloop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(run1) userInfo:nil repeats:YES];
    
    CFRelease(observer);
    
}
//gcd定时器Timer添加到runloop
-(void)gcdTimer
{
    //0.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    NSLog(@"%s",__func__);
    //1.创建一个GCD定时器
    /*
     第一个参数:表明创建的是一个定时器
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    self.timer = timer;
    //2.设置定时器的开始时间,间隔时间,精准度
    /*
     第1个参数:要给哪个定时器设置
      第2个参数:开始时间
      第3个参数:间隔时间
      第4个参数:精准度 一般为0 提高程序的性能
     GCD的单位是纳秒
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 10 * NSEC_PER_SEC);
    
    //3.设置定时器要调用的方法
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"-----");
    });
    
    //4.启动
    dispatch_resume(timer);
}
//NSTimer定时器添加到runloop
-(void)timer
{
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    
    NSLog(@"+++++");
    //1.创建NSTimer
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    
    //2.添加到runloop
    //把定时器添加到但当前的runloop中,并且选择默认运行模式kCFRunLoopDefaultMode == NSDefaultRunLoopMode
    
    //定时器只运行在NSDefaultRunLoopMode下，一旦RunLoop进入其他模式，这个定时器就不会工作
    //    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 定时器只运行在UITrackingRunLoopMode下，一旦RunLoop进入其他模式，这个定时器就不会工作
    //     [[NSRunLoop currentRunLoop]addTimer:timer forMode:UITrackingRunLoopMode];
    
    //    NSRunLoopCommonModes标记,
    /*
     0 : <CFString 0x109af3a40 [0x108c687b0]>{contents = "UITrackingRunLoopMode"}
     2 : <CFString 0x108c88b40 [0x108c687b0]>{contents = "kCFRunLoopDefaultMode"}
     */
     //无论是默认模式，还是滑动的时候，NSTimer都工作，这个模式兼容了NSDefaultRunLoopMode和UITrackingRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    
    一个线程包括一个 RunLoop ，一个RunLoop包含若干个 Mode，每个Mode又包含若干个Source/Timer/Observer,更换model，
    RunLoop会退出。一个model 不包含任何Source/Timer/Observer，RunLoop会退出
    
    //需求:当用户在拖拽时(UI交互时)不显示图片,拖拽完成时显示图片
    方法1 监听UIScrollerView滚动 (通过UIScrollViewDelegate监听,此处不再举例)
    方法2 RunLoop 设置运行模式
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"placeholder"] afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
    
    //进入后台线程不会死掉常驻线程 (重要)应用场景:经常在后台进行耗时操作,如:监控联网状态,扫描沙盒等 不希望线程处理完事件就销毁,保持常驻状态
    - (void)run
    {
      //addPort:添加端口(就是source)  forMode:设置模式
       [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
       //启动RunLoop
       [[NSRunLoop currentRunLoop] run];
      /*
        //另外两种启动方式
        [NSDate distantFuture]:遥远的未来  这种写法跟上面的run是一个意思
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        不设置模式
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
      */
    }
    
    应用场景无非就是让一个线程一直运行，滑动时其它操作可执行，可不执行，如NSTimer或者监听一个线程的状态
    
    //oc调js的方法
    SEL methedSEL = NSSelectorFromString(@"test");//方法
    [self performSelector:methedSEL withObject:param1 withObject:param2];//调方法
    
    //performSelector:withObject；可以直接调用一个方法，下面介绍一种运行时过程中比较麻烦的调用
    //例如调用这个方法，可以用这种方式
    -(void)callWithNumber:(NSString *)number andContent:(NSString *)content withStatus:(NSString *)status
   {

   }
   
   调用如下：
   //1.创建签名:方法名称|参数|返回|谁拥有它,和方法的调用没有关系
    NSMethodSignature *signature = [ViewController instanceMethodSignatureForSelector:@selector(callWithNumber:andContent:withStatus:)];
    //创建NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(callWithNumber:andContent:withStatus:);
    
    NSString *number = @"15376321";
     NSString *content = @"11222";
     NSString *status = @"睡觉";
    //self and _cmd 0-1已经被占用了
    [invocation setArgument:&number atIndex:2];
    [invocation setArgument:&content atIndex:3];
    [invocation setArgument:&status atIndex:4]; 
    [invocation invoke];

19.网络
     //请求方式1    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] 
    completionHandler:^(NSURLResponse * _Nullable response, 
    NSData * _Nullable data, NSError * _Nullable connectionError) {
    
    }];
    
    //参数带中文的两种传输方式1
    NSString *urlStr = @"http://120.25.226.186:32812/weather?place=Beijing&place=Shanghai";
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方法
    request.HTTPMethod = @"POST";
    //设置请求超时
    request.timeoutInterval = 10;
    //设置请求体
    request.HTTPBody = [@"username=小码哥&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //参数带中文的两种传输方式2
    NSString *urlStr = @"http://120.25.226.186:32812/login2?username=小码哥&pwd=520it&type=JSON";
    NSLog(@"转码之前---%@",urlStr); 
    urlStr =  [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"转码之后---%@",urlStr);   
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //小文件下载block方式
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] 
    completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        self.imagView.image = [UIImage imageWithData:data];
    }];
    
    //小文件下载之代理方式
    [NSURLConnection connectionWithRequest:request delegate:self];
    //代理方法
    //1.接收到服务器响应的时候调用
    -(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
    {
      self.fileData = [NSMutableData data];
      //拿到文件的总大小
      self.totalLength = response.expectedContentLength;
    }
     //2.接收到服务器返回的数据,会调用多次
    -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
    {
     [self.fileData appendData:data];
      self.currentLength = self.fileData.length;
      NSLog(@"%f",1.0 * self.currentLength / self.totalLength);
     }
    //3.当请求完成之后调用该方法
    -(void)connectionDidFinishLoading:(NSURLConnection *)connection
    {
      //保存下载的文件到沙河
      NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
      //拼接文件全路径
      NSString *fullPath = [caches stringByAppendingPathComponent:@"abc.mp4"];
      //写入数据到文件
      [self.fileData writeToFile:fullPath atomically:YES]；
    }
     //4.当请求失败的适合调用该方法,如果失败那么error有值
    -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
    {
        NSLog(@"didFailWithError");
    }
    
    //小文件下载之NSData
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imagView.image = [UIImage imageWithData:data];
    
    //大文件下载两种方式，文件存内容或都流存内容
          
    //1.更换成这样支持大文件的下载
    //创建文件句柄,指向数据写入的文件
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
    //指向从文件的末尾
    [self.handle seekToEndOfFile];
    
    //2.大文件下载方式2
    //创建输出流
    self.stream = [NSOutputStream outputStreamToFileAtPath:self.fullPath append:YES];
    //开启
    [self.stream open];
    [self.stream write:data.bytes maxLength:data.length];
    
    //NSURLConnection文件上传的方式按照http协议规则设置请求头和请求体
    //2.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.设置请求方法
    request.HTTPMethod = @"POST";
    //4.设置请求头
    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary];
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    //5.设置请求体
    NSMutableData *fileData = [NSMutableData data];
    [fileData appendData:[@"yy" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    request.HTTPBody = fileData;
    
    //NSURLSession get
    NSURLSession *session = [NSURLSession sharedSession];
    //根据会话对象来创建task
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"]];  
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    //启动任务
    [dataTask resume];
    
    //NSURLSession post
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=5it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    //启动任务
    [dataTask resume];
    
    //NSURLSession 代理方式
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //2.创建task
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_03.png"]];
    [dataTask resume];
    #pragma mark NSURLSessionDataDelegate
    //接收到服务器响应的时候调用
   -(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
   {
    NSLog(@"didReceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
   }
   //接收到服务器返回数据的时候调用,该方法可能会被调用多次
   -(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
   {
    NSLog(@"didReceiveData");
   }
   //当请求完成之后调用,如果错误,那么error有值
   -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
   {
     NSLog(@"didCompleteWithError");
   }
    
    
   //NSURLSessionDownloadTask下载block 注意:它内部已经完成了边下载边写入数据的操作
      NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:
      ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //caches
       NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
       NSString *fullPath = [caches stringByAppendingPathComponent:response.suggestedFilename];
       //剪切文件到目的地
       NSFileManager *manager = [NSFileManager defaultManager]; 
       [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    }];
    
    //NSURLSessionDownloadTask断点下载
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    NSURL * url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.3_setup.1435732931.dmg"];
    self.downloadTask = [self.session downloadTaskWithURL:url];
    [self.downloadTask resume];
    
    - (IBAction)suspendBtnClick:(id)sender {
    //暂停
    [self.downloadTask suspend];
    //这个方法可以拿到恢复下载需要的数据
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.data = resumeData;
    }];
    }
    - (IBAction)goONBtnClick:(id)sender {
        self.downloadTask = [self.session downloadTaskWithResumeData:self.data];
        [self.downloadTask resume];
    }
    
    //代理
     #pragma mark NSURLSessionDownloadDelegate
    /*
     1.当接收到数据的时候,写数据,该方法会调用多次
     bytesWritten:本次写入数据的大小
     totalBytesWritten:已经下载完成的数据大小
     totalBytesExpectedToWrite:文件大小
    */
   -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
                                              {
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        self.progressView.progress = 1.0 *totalBytesWritten/totalBytesExpectedToWrite;
    }];
}

     //恢复下载的时候调用
    -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
    {
      NSLog(@"didResumeAtOffset");
    }

     //下载完成之后调用
    -(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
    {
     NSLog(@"didFinishDownloadingToURL--%@--%@",location,[NSThread currentThread]);
    
    //确定文件要存放到哪里
    //caches
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fullPath = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    //剪切文件到目的地
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    }
 //请求完成之后调用
    -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
    {
       NSLog(@"didCompleteWithError---%@",error);
    }


    //NSURLSession文件上传
    -(void)uploadDelegate
{
    
    //1.创建session
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //2.创建task
    //PUT
    //    [session uploadTaskWithRequest:<#(nonnull NSURLRequest *)#> fromFile:<#(nonnull NSURL *)#>]
    
    //2.1 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/upload"]];
    //2.2 设置请求方法
    request.HTTPMethod = @"POST";
    
    //2.3.设置请求头
    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary];
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    //2.4设置文件上传的文件内容
    [[self.session uploadTaskWithRequest:request fromData:[self getBody]] resume];

}

    //afnetwork
    AFN封装了两种请求方式
    AFHTTPRequestOperationManager内部封装了URLConnection
    AFHTTPSessionManager内部封装了URLSession
    
   //1.URLConnection方式
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //发送请求
    /*
     第一个参数:请求地址,nsstring
     第二个参数:字典  username=df&pwd=dfsf&type=JSON
     */
    NSDictionary *dict = @{
                           @"username":@"520it",
                           @"pwd":@"5r0it"
                           };
    
    [manager GET:@"http://120.25.226.186:32812/login" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"请求成功--%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
    

    //2.AFHTTPSessionManager内部封装了URLSession
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //发送请求
    NSDictionary *dict = @{
                           @"username":@"520it",
                           @"pwd":@"520it"
                           };
    [manager GET:@"http://120.25.226.186:32812/login" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"请求成功--%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
    
    
    //URLSession的下载方式
    -(void)download
{
    //1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_03.png"]];
    NSProgress *progress = nil;
    NSURLSessionDownloadTask *downloadtask =  [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
       NSURL *url = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename]];
        return url;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
//        NSLog(@"%@",filePath);
    }];
    
    //KVO 监听progress的completedUnitCount
    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
    
    [downloadtask resume];
}

    -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(NSProgress*)progress change:(NSDictionary<NSString *,id> *)change context:(void *)context
    {
    NSLog(@"%f",1.0 * progress.completedUnitCount / progress.totalUnitCount);
//    NSLog(@"completedUnitCount=%lld,totalUnitCount=%lld", progress.completedUnitCount, progress.totalUnitCount);
    }
    
    //封装URLSession的上传
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url =@"http://120.25.226.186:32812/upload";
    NSDictionary *dict = @{
                           @"username":@"yyy",
                           };
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *image = [UIImage imageNamed:@"Snip20151012_24"];
        NSData *data = UIImagePNGRepresentation(image);
        
        [formData appendPartWithFormData:data name:@"tupian"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
    
    
    //afn请求注意返回结果的接收
    //1.创建请求管理者
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];//接收的是xml

//  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    //2.发请求
    NSDictionary *dict = @{
                           @"username":@"520it",
                           @"pwd":@"520it",
                           @"type":@"XML"
                           };
    
    [manager GET:@"http://120.25.226.186:32812/login" parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"---成功---%@",[responseObject class]);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"失败---%@",error);
    }];
    

    
    //json方式 
    BOOL isValid = [NSJSONSerialization isValidJSONObject:str];
    //json转NSData再转字符串
    NSData *data =   [NSJSONSerialization dataWithJSONObject:str options:kNilOptions error:nil];
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    //NSData转json
    NSDictionary *dictM = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    
    //xml方式 sax解析
    //创建解析器Sax
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    //设置代理
    parser.delegate = self;
    //开始解析
    [parser parse];
    //代理方法 开始解析XML文档
    -(void)parserDidStartDocument:(NSXMLParser *)parser
    //解析XML文档中的每一个元素,会调用多次
    -(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
    namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
    //解析XML文档中的每一个元素结束
    -(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
    namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    //整个XML文档都已经解析完成
    -(void)parserDidEndDocument:(NSXMLParser *)parser
    
     //xml方式 Document解析
    GDataXMLDocument *doc  = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
    //拿到根元素
    NSArray *eles =  [doc.rootElement elementsForName:@"video"];
        for (GDataXMLElement *ele in eles) {
            XMGVideo *video = [[XMGVideo alloc]init];
            video.name = [ele attributeForName:@"name"].stringValue;
            video.length = [ele attributeForName:@"length"].stringValue.integerValue;
            video.image = [ele attributeForName:@"image"].stringValue;
            video.url = [ele attributeForName:@"url"].stringValue; 
            [self.videos addObject:video];
        }
    
20.单例的规范写法
    Tools.h
    #import <Foundation/Foundation.h>
    @interface Tools : NSObject<NSCopying,NSMutableCopying>
    +(instancetype)shareTools;
    @end
    
    Tools.m
    #import "Tools.h"

    @implementation Tools

    static Tools *_instance;

    //保证只分配一次存储空间
    +(instancetype)allocWithZone:(struct _NSZone *)zone
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
        return _instance;
    }

    //返回一个实例化对象
    +(instancetype)shareTools
    {
        //注意:最好是写self
        return [[self alloc]init];
    }

    //严谨起见
    -(id)copyWithZone:(NSZone *)zone
    {
    //    return [[self class]allocWithZone:zone];
        return _instance;
    }

    -(id)mutableCopyWithZone:(NSZone *)zone
    {
        return _instance;
    }
    @end
    
21. 宏定义单例
    单井号就是将后面的 宏参数 进行字符串操作，就是将后面的参数用双引号引起来
    双井号就是用于连接。
    例：
    #define PRINT(NAME) printf("token"#NAME"=%d\n", token##NAME)
    
    宏实现单例
    #define singleH(name) \
    +(instancetype)share##name;\  //##连接变量
    #if __has_feature(objc_arc)//ARC

    #define singleM(name) static id _instance;\
    +(instancetype)allocWithZone:(struct _NSZone *)zone\
      {\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
      });\
        return _instance;\
      }\
      \
    +(instancetype)share##name\
      {\
        return [[self alloc]init];\
      }\
    -(id)copyWithZone:(NSZone *)zone\
      {\
        return _instance;\
      }\
     \
    -(id)mutableCopyWithZone:(NSZone *)zone\
      {\
        return _instance;\
      }
    #else
    #define singleM static id _instance;\
    +(instancetype)allocWithZone:(struct _NSZone *)zone\
    {\
      static dispatch_once_t onceToken;\
      dispatch_once(&onceToken, ^{\
      _instance = [super allocWithZone:zone];\
    });\
      return _instance;\
    }\
    \
    +(instancetype)shareTools\
    {\
      return [[self alloc]init];\
    }\
    -(id)copyWithZone:(NSZone *)zone\
    {\
      return _instance;\
    }\
    \
    -(id)mutableCopyWithZone:(NSZone *)zone\
    {\
      return _instance;\
    }\
    -(oneway void)release\
    {\
    }\
    \
    -(instancetype)retain\
    {\
      return _instance;\
    }\
    \
    -(NSUInteger)retainCount\
   {\
    return MAXFLOAT;\
    }
    #endif
    
22.YTKNetwork猿题库  http://www.cocoachina.com/ios/20170720/19942.html
YTKBaseRequest 
定义枚举：
a.request错误码
  请求状态错误码
  json格式化错误码
  
b.定义request序列化
  http请求序列化
  json请求序列化
  
c.定义response序列化
  http响应序列化
  json响应序列化
  xml响应序列化
  
d.定义请求的优先级别
  优先级高，默认，低
  
  AFMultipartFormData协议定义
  构造一个格式化数据的代理方法
  typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
  构造一个传输进度的代理方法
  typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);
  
  请求完成的回调定义
  typedef void(^YTKRequestCompletionBlock)(__kindof YTKBaseRequest *request);
  
  请求结果状态的协议
  完成
  - (void)requestFinished:(__kindof YTKBaseRequest *)request;
  失败
  - (void)requestFailed:(__kindof YTKBaseRequest *)request;
  
  请求过程的附加协议，及请求状态
  请求将开始
  - (void)requestWillStart:(id)request;
  请求将停止
  - (void)requestWillStop:(id)request;
  请求正在停止
  - (void)requestDidStop:(id)request;
  
  YTKBaseRequest的属性
   nullable 对象可以为空 nonnull对象不应为空
   NSURLSessionTask *requestTask;请求任务
   NSURLRequest *currentRequest；当前请求
   NSURLRequest *originalRequest;原始请求
   NSHTTPURLResponse *response; 响应
   NSInteger responseStatusCode; 响应状态码
   NSDictionary *responseHeaders; 响应头文件信息
   NSData *responseData;响应的原始数据
   NSString *responseString 响应的字符串
   id responseObject;响应的对象
   id responseJSONObject;响应的是json对象
   NSError *error；一个网络错误
   BOOL cancelled;返回是否请求已经取消
   BOOL executing;返回请求是否在执行中
   NSInteger tag;请求的标识符
   NSDictionary *userInfo;用来存储请求信息的附加信息
   id<YTKRequestDelegate> delegate;请求的代理，如果用block可忽略
   @property (nonatomic, copy, nullable) YTKRequestCompletionBlock successCompletionBlock;请求成功的块回调这里用了copy
   YTKRequestCompletionBlock failureCompletionBlock 请求失败的回调
   NSMutableArray<id<YTKRequestAccessory>> *requestAccessories;请求状态的回调 开始，正在，将要 请求
   AFConstructingBlock constructingBodyBlock;构造请求的数据
   NSString *resumableDownloadPath;每次开始请求把文件下载的数据保存在这个路径下用于恢复下载
   AFURLSessionTaskProgressBlock resumableDownloadProgressBlock;重新下载的进度
   YTKRequestPriority requestPriority;请求的优先级
   
   YTKBaseRequest的方法
   - (void)setCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                              failure:(nullable YTKRequestCompletionBlock)failure;  请求成功失败的回调方法
    - (void)clearCompletionBlock; 清除成功失败的回调方法
    
    - (void)addAccessory:(id<YTKRequestAccessory>)accessory;添加一个请求状态 开始请求 请求中 请求结束
    
    - (void)start;把自身加入到一个requt队列进行请求

     - (void)stop;从队列中移除掉这个请求

     - (void)startWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
                                    failure:(nullable YTKRequestCompletionBlock)failure;开始一个队列带block
                                    
    YTKBaseRequest的子类需要复写的方法
    
    - (void)requestCompletePreprocessor;当线程切到主线程成功时，如果缓存已经被加载了，那会调用这个方法
    
    - (void)requestCompleteFilter;切到主线程成功后会调用此方法
    
    - (void)requestFailedPreprocessor;请求失败切到主线程前调用
    
    - (void)requestFailedFilter;当请求失败时调用主线程。
    
    - (NSString *)baseUrl;基础的请求路径 http://www.baidu.com
    
    - (NSString *)requestUrl;路径后面拼接的url /v1/login

    - (NSString *)cdnUrl; cdn 的url
    
    - (NSTimeInterval)requestTimeoutInterval;请求超时设置 默认是60秒
    
    - (nullable id)requestArgument;添加请求的参数
    
    - (id)cacheFileNameFilterForRequestArgument:(id)argument;在缓存时重写此方法以过滤具有某些参数的请求。
    
    - (YTKRequestMethod)requestMethod; http请求的方式
    
    - (YTKRequestSerializerType)requestSerializerType; http请求的类型，是http的还是json的
    
    - (YTKResponseSerializerType)responseSerializerType;http响应的类型 json xml http
    
   - (nullable NSArray<NSString *> *)requestAuthorizationHeaderFieldArray; 需要用户名和密码的http认证
   
   - (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;添加一个http请求头文件
   
   - (nullable NSURLRequest *)buildCustomUrlRequest;构建一个自定义的请求，requestArgument`, `allowsCellularAccess`, `requestMethod`都被忽略
   
   - (BOOL)useCDN;用cdn发送请求
   
   - (BOOL)allowsCellularAccess; 允许蜂窝访问
   
   - (nullable id)jsonValidator; json校验
   
   - (BOOL)statusCodeValidator; 状态码校验
   
   YTKRequest
   定义枚举
   YTKRequestCacheErrorExpired 缓存过期的错误
   YTKRequestCacheErrorVersionMismatch 缓存版本失去配置的错误
   YTKRequestCacheErrorSensitiveDataMismatch 缓存灵敏度配置的错误
   YTKRequestCacheErrorAppVersionMismatch 缓存app版本失去配置的错误
   YTKRequestCacheErrorInvalidCacheTime 错误无效的缓存时间
   YTKRequestCacheErrorInvalidMetadata  错误无效的元数级，即描述数据
   YTKRequestCacheErrorInvalidCacheData 错误无效的缓存数据
   
   BOOL ignoreCache; 是否忽略缓存
   - (BOOL)isDataFromCache; 判断数据是否来自本地缓存。
   - (BOOL)loadCacheWithError:(NSError * __autoreleasing *)error;  判断缓存是否加载成功
   - (void)startWithoutCache;启用这方法会更新缓存
   - (void)saveResponseDataToCacheFile:(NSData *)data; 将缓存保存到一个位置
   - (NSInteger)cacheTimeInSeconds; 设置保存缓存的时间，-1即表示不保存缓存
   - (long long)cacheVersion; 标识一个缓存的版本，默认是0
   - (nullable id)cacheSensitiveData;标识一个缓存的敏感度
   - (BOOL)writeCacheAsynchronously; 是否将缓存默认写入异步存储区 默认值是
   
   
   BatchRequest 批量处理请求的类
   YTKBatchRequestDelegate 协议及方法
   - (void)batchRequestFinished:(YTKBatchRequest *)batchRequest; 批量请求完成
   - (void)batchRequestFailed:(YTKBatchRequest *)batchRequest;  批量请求失败

   YTKBatchRequestAgent   跟踪所有的批量请求可以发起批量请求，持有一个数组来保存所有的请求类。在请求执行后遍历这个数组来发起请求，如果其中有一个请求返回失败，则认定本组请求失败。
   
   YTKChainRequestAgent   链式请求代理
   - (instancetype)init NS_UNAVAILABLE;  NS_UNAVAILABLE真接禁止使用此方法
   + (instancetype)new NS_UNAVAILABLE;   NS_DESIGNATED_INITIALIZER 表示是根初始化方法
   
   YTKNetworkAgent 处理实际请求的底层类真正发起请求的类。负责发起请求，结束请求，并持有一个字典来存储正在执行的请求。
   - (instancetype)init NS_UNAVAILABLE;
   + (instancetype)new NS_UNAVAILABLE;
   + (YTKNetworkAgent *)sharedAgent;
   - (void)addRequest:(YTKBaseRequest *)request; //添加一个请求
   - (void)cancelRequest:(YTKBaseRequest *)request;  //取消一个请求
   - (void)cancelAllRequests; //取消之前所有添加的请求
   - (NSString *)buildRequestUrl:(YTKBaseRequest *)request; //返回一个请求的url
   
   YTKNetworkConfig 存储网络的其他配置 如过滤一些请求，或者缓存的响应
   
   YTKNetworkPrivate 网络私有类
   + (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator; 校验json
   + (void)addDoNotBackupAttribute:(NSString *)path; 添加没有备份的数据
   + (NSString *)md5StringFromString:(NSString *)string; md5字符串格式化
   + (NSString *)appVersionString; app的版本
   + (NSStringEncoding)stringEncodingWithRequest:(YTKBaseRequest *)request;请求的字符编码
   + (BOOL)validateResumeData:(NSData *)data;认证恢复的数据
   
   
   有趣的NSLog 全局宏定义
   .h中
   FOUNDATION_EXPORT void YTKLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);
   .m中
   void YTKLog(NSString *format, ...) {
#ifdef DEBUG
    if (![YTKNetworkConfig sharedConfig].debugLogEnabled) {
        return;
    }
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
    }
    
    1.分类是用于给原有类添加方法的,因为分类的结构体指针中，没有属性列表，只有方法列表。所以< 原则上讲它只能添加方法, 不能添加属性(成员变量),实际上可以通过其它方式添加属性> ;
    2.分类中的可以写@property, 但不会生成setter/getter方法, 也不会生成实现以及私有的成员变量（编译时会报警告）;//程序可以运行，但是不能调用
    3.可以在分类中访问原有类中.h中的属性;
    4.如果分类中有和原有类同名的方法, 会优先调用分类中的方法, 就是说会忽略原有类的方法。所以同名方法调用的优先级为 分类 > 本类 > 父类。因此在开发中尽量不要覆盖原有类;
    5.如果多个分类中都有和原有类中同名的方法, 那么调用该方法的时候执行谁由编译器决定；编译器会执行最后一个参与编译的分类中的方法。


    YTKNetworkAgent 封装了AFNetworking
    YTKRequest 继承了YTKBaseRequest
    YTKNetworkAgent 管理YTKBaseRequest
    YTKNetworkConfig 配置YTKRequest和YTKNetworkAgent
    YTKNetworkPrivate 为YTKBaseRequest、YTKRequest、YTKNetworkAgent提供分类工具
    
    在这里简单说明一下：

YTKNetwork框架将每一个请求实例化，YTKBaseRequest是所有请求类的基类，YTKRequest是它的子类。所以如果我们想要发送一个请求，则需要创建并实例化一个继承于YTKRequest的自定义的请求类（CustomRequest）并发送请求。
YTKNetworkAgent是一个单例，负责管理所有的请求类（例如CustomRequest）。当CustomRequest发送请求以后，会把自己放在YTKNetworkAgent持有的一个字典里，让其管理自己。
我们说YTKNetwork封装了AFNetworking，实际上是YTKNetworkAgent封装了AFNetworking，由它负责AFNetworking请求的发送和AFNetworking的回调处理。所以如果我们想更换一个第三方网络请求库，就可以在这里更换一下。而YTKRequest更多的是只是负责缓存的处理。
YTKNetworkConfig与YTKPriviate的具体职能现在不做介绍，会在后文给出。
OK，现在我们知道了YTKNetwork中类与类之间的关系以及关键类的大致职能，接下来我会告诉你


详细介绍命令模式：

命令模式的本质是对命令的封装，将发出命令的责任和执行命令的责任分割开。
命令模式允许请求的一方和接收的一方独立开来，使得请求的一方不必知道接收请求的一方的接口，更不必知道请求是怎么被接收，以及操作是否被执行、何时被执行，以及是怎么被执行的。
可能还是觉得有点抽象，在这里举一个《Head First 设计模式》里的例子，一个客人在餐厅点餐的过程：

你将点的菜写在订单里，交给了服务员。
服务员将订单交给厨师。
厨师做好菜之后将做好的菜交给服务员。
最后服务员把菜递给你。
在这里，命令就好比是订单，而你是命令的发起者。你的命令（订单）通过服务员（调用者）交给了命令的执行者（厨师）。

所以至于这道菜具体是谁做，怎么做，你是不知道的，你做的只是发出命令和接受结果。而且对于餐厅来说，厨师是可以随便换的，而你可能对此一无所知。反过来，厨师只需要好好把菜做好，至于是谁点的菜也不需要他考虑。

23.git解决图片上传不上去的问题
git push origin master
git commit -m "提交信息"

pod update如果出现[!] Unable to find a specification for `SGPagingView`
请 pod repo remove master 
再 pod update --verbose --no-repo-update

24.swift中的维度
let arr = [[1, 2, 3], [4, 5]]

let newArr = arr.flatMap { $0 }
// newArr 的值为 [1, 2, 3, 4, 5]

第二个是用来 flat 可选值的：
let arr = [1, 2, 3, nil, nil, 4, 5]
let newArr = arr.flatMap { $0 }
这两个版本虽然都是用来降维的，但第二个版本除了 flat 之外其实还有 filter 的作用，在使用时容易产生歧义
最初这个提案用了 filterMap 这个名字，但后来经过讨论，就决定参考了 Ruby 的 Array::compact 方法，使用 compactMap 这个名字。
let newArr = arr.compactMap { $0 }修改后是这样
// newArr 的值为 [1, 2, 3, 4, 5]

swift 自动对行内闭包提供简写实际参数名，你也可以通过 0,
1 , $2 等名字来替换闭包的实际参数值。

如果你在闭包表达式中使用这些简写实际参数名，那么你可以在闭包的实际参数列表中忽略对其的定义，
并且简写实际参数名的数字和类型将会从期望的函数类型中推断出来。 in 关键字也能被省略，因为闭包表达式完全由它的函数体组成：

let numbers = [3,2,4,1,5,7,6];

var sortedNumbers = numbers.sorted(by:{$0 < $1});
print(sortedNumbers);//输出为：[1, 2, 3, 4, 5, 6, 7]

sortedNumbers = numbers.sorted(by:{$1 < $0});
print(sortedNumbers);//输出为：[7, 6, 5, 4, 3, 2, 1]
可以看出，可以用0、
1、2来表示调用闭包中参数，
0指代第一个参数，1指代第二个参数，
2指代第三个参数，以此类推n+1指代第n个参数，
后的数字代表参数的位置，一一对应。

遍列一个数组并将其中的字典转换为model放到title数组中
 titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
代码延展
//                        datas.compactMap({   这个方法很有意思，
//                            $0 //第一个参数，相当于得到数组中每一个元素
//                             datas[i]; //假代码
//                             Person p = datas[i]
//                             return p//多次返回每一个对象
//                        })
                        //HomeNewsTitle.deserialize(from: $0 as? Dictionary) 每循环一次把第一个参数边转为一个mode返回
                        //titles+= //每次向titles中放入一个元素



25.swift中的闭包
和oc中block作用一样，用于传参，和回调
是一个代码块，也是一个函数，只是这个函数没有名字
 1、//定义一个求和闭包
    //闭包类型：(Int,Int)->(Int)
    let add:(Int,Int)->(Int) = {
      (a,b) in //in之前a,b相当于参数，in之后相当于执行的代码块
      return a + b;
    }
   //执行闭包，相当于调用函数 
   let result = add(1100, 200);
    //打印闭包返回值
    print("result=\(result)");
    
  2、如果闭包没有参数，则(a,b) in可以全部省略
  3、//声明一个闭包类型 AddBlock  
   typealias AddBlock = (Int,Int)->(Int); 
   let add:AddBlock = {  
      (a,b) in  
      return a + b;  
    } 
  4、如果闭包是函数的最后一个参数，那么返回值的括号可省略
 func post(url:String,succesce:(String)->(Void)) {  
  
    print("发送请求");  
  
    succesce("请求完成");  
  }  
  //第二个参数：闭包 (String)->(Void)  
  func post(url:String,succesce:(String)->Void) {  
  
    print("发送请求");  
  
    succesce("请求完成");  
  }   
  5、两个类之间的通信
  
  class CustomView: UIView 
  //声明一个属性btnClickBlock，type为闭包可选类型  
  //闭包类型：()->() ，无参数，无返回值  
  var btnClickBlock:(()->())?; 
  btn.addTarget(self, action: #selector(CustomView.btnClick), for: .touchDown); 
  //按钮点击事件函数  
  func btnClick(){  
    if self.btnClickBlock != nil {  
      //点击按钮执行闭包  
      //注意：属性btnClickBlock是可选类型，需要先解包  
      self.btnClickBlock!();  
    }  
  }  
  
  class ViewController: UIViewController 
    //创建CustomView对象  
    let cutomeView = CustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 200));  
    //给cutomeView的btnClickBlock闭包属性赋值  
    cutomeView.btnClickBlock = {  
      // () in 无参数可以省略  
      //当按钮被点击时会执行此代码块  
      print("按钮被点击");  
    }  
    
    6、异步回调（callBack） 网络请求的回调
    /// 定义一个网络请求函数  
  ///  
  /// - parameter urlString: 请求接口  String  
  /// - parameter succeed:  成功的回调 可选闭包  
  /// - parameter failure:  失败的回调 可选闭包  
  func requestData(urlString:String,succeed: ((Any?)->(Void))?,failure:((Any?)->(Void))?){  
  
    let request = URLRequest(url: URL(string: urlString)!);  
  
    //发送网络请求  
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (_, data, error) in  
      if error == nil {  
        //请求成功，执行成功的回调，并把数据传递出去  
        succeed?(data);  
      }else{  
         //请求失败，执行失败的回调，并把错误传递出去  
        failure?(error);  
      }  
    }  
  }  
  
  // 调用函数requestData函数  
    requestData(urlString: "http://www.baidu.com", succeed: { (data) -> (Void) in  
  
      //成功的回调  
      guard let result = data as? Data else{  
        return;  
      }  
  
      let srt = NSString(data: result, encoding: String.Encoding.utf8.rawValue);  
  
      print(srt!)  
  
  
      }) { (error) -> (Void) in  
        //失败的的回调  
        print(error);  
    } 
    
    7、逃逸闭包  6的异省回调没有问题是因为 函数参数是可选类型 ((Any?)->(Void))?，但是如果((Any?)->(Void))参数是这样，有可能为nil
    则修改为 @escaping((Any?)->(Void)) 因为成功和失败的回调要弄成闭包类型，而你又要异步使用。闭包是等异步任务完成以后才调用，而函数是会很快执行完毕并返回的，
    所以闭包它需要逃逸，以便稍后的回调
    /// 定义一个网络请求函数  
 ///  
 /// - parameter urlString: 请求接口  String  
 /// - parameter succeed: 成功的回调 闭包 因需要异步使用，前面加关键字@escaping修饰，指明其为逃逸闭包  
 /// - parameter failure: 失败的回调 闭包 因需要异步使用，前面加关键字@escaping修饰，指明其为逃逸闭包  
 func requestData(urlString:String,succeed: @escaping (Any?)->(Void),failure:@escaping (Any?)->(Void)){  //少了?多了 @escaping
  
   let request = URLRequest(url: URL(string: urlString)!);  
  
   //发送网络请求  
   NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (_, data, error) in  
     if error == nil {  
       //请求成功，执行成功的回调，并把数据传递出去  
       succeed(data);  
     }else{  
        //请求失败，执行失败的回调，并把错误传递出去  
       failure(error);  
     }  
   }  
 }  
 
 
 26.cocoapod的版本号
 一个简单的podfile:
pod 'AFNetworking', '~> 1.0' 版本号可以是1.0，可以是1.1，1.9，但必须小于2
 
一个更简单的podfile:
pod 'AFNetworking', '1.0' // 版本号指定为1.0
 
一个更更简单的podfile:
pod 'AFNetworking',  //不指定版本号，任何版本都可以

  27.protocol
  Swift:协议作为类型使用的一个好处
  在Swift里，协议可以像int、String一样，作为变量的类型来使用。如：
  protocol CompanyRules {
    func responsibility() -> String
  }

  class LiLei: CompanyRules {
    func responsibility() -> String {
        return "lilei负责重活"
    }
   }

  var myInstance: CompanyRules?
  myInstance = LiLei()
  myInstance的类型是CompanyRules，那么任何服从CompanyRules协议的实例都可以赋值给myInstance，这就是协议作为变量类型的好处。
  然而我发现这里使用 Any类型也能达到要求，那么使用Any和CompanyRules作为变量的类型的区别是什么
  
  protocol CompanyRules {
    func responsibility() -> String
}

class LiLei: CompanyRules {
    func responsibility() -> String {
        return "lilei负责重活"
    }
}

class MeiMei: CompanyRules {
    func responsibility() -> String {
        return "meimei负责轻活"
    }
}

class Employee: NSObject {
    var sexy: String?
    
    var _person: CompanyRules?
    var person: CompanyRules {//定义了一个闭包类型的变量
        get {
            if sexy == "男"  {
                return LiLei()
            }
            else{
                return MeiMei()
            }
        }
    }
    
    var _person1: Any?
    var person1: Any {
        get {
            if sexy == "男"  {
                return LiLei()
            }
            else{
                return MeiMei()
            }
        }
    }
    
    override init() {
        super.init()
        self.sexy = "男"
    }
}
说明：协议CompanyRules表示公司规则，员工LiLei和MeiMei都服从CompanyRules。现在有雇员类Employee里有一个变量person，根据性别返回不同的实例。因为person的类型是CompanyRules，因此任何采取了CompanyRules的实例都可以赋值给person。
同样，有一个变量person1，作用和person类似，但是它的类型是Any，那么任何类型都可以赋值给person1。

现在我们根据不同性别来获取员工的职责：

func doSomething(item: UIBarButtonItem) {
        //获取person的职责
        let employee = Employee()
        print(employee.person.responsibility())
        
        //获取person1的职责
        if employee.person1 is LiLei {
            let instance = employee.person1 as! LiLei
            print(instance.responsibility())
        }
        else{
            let instance = employee.person1 as! MeiMei
            print(instance.responsibility())
        }
    }

说明：可以看到，类型为协议的person可以直接输出员工的职责，但是Any类型的person1则需要先判断它的类型，然后转化为对应的类型才能使用

27.swift与oc混编
在xcode创建oc文件，swift会自动添加一个bridage的文件，在这个文件中#import"oc.h",则这个类就可以用了

28.git的使用  分钟 git 命令入门到放弃 TOWER工具破解版

使用homebrew安装
brew install git

配置Git用户名及邮箱
bal user.name "My Name"
$ git config --global user.email myEmail@example.com

在/git_exercise目录创建一个新仓库 – git init
$ cd Desktop/git_exercise/
$ git init

检查状态 – git status
仓库的当前状态：是否为最新代码，有什么更新等等执行git status:
$ git status
 
On branch master
Initial commit
Untracked files: //尚未跟踪
  (use "git add ..." to include in what will be committed)
 
	hello.txt

暂存 – git add git 有个概念叫 暂存区。你可以把它看成一块空白帆布，包裹着所有你可能会提交的变动，它一开始为空，
你可以通过 git add 命令添加内容，并使用 git commit 提交
$ git add hello.txt
如果需要提交目录下的所有内容
$ git add -A

使用git status查看：提交的是一个全新文件。
$ git status 
On branch master
Initial commit
Changes to be committed:
(use "git rm --cached ..." to unstage)
new file:   hello.txt

提交 – git commit
一次提交代表着我们的仓库到了一个交付状态，通常是完成了某一块小功能。它就像是一个快照，允许我们像使用时光机一样回到旧时光
创建提交，需要我们提交东西到暂存区（git add），然后
$ git commit -m "Initial commit."    m “Initial commit.”表示对这次提交的描述

远端仓库
到目前为止，我们的操作都是在本地的，它存在于.git文件中。为了能够协同开发，我们需要把代码发布到远端仓库上。

1.链接远端仓库 – git remote add
为了能够上传到远端仓库，我们需要先建立起链接，这篇教程中，远端仓库的地址为：https://github.com/tutorialzine/awesome-project,
但你应该自己在Github, BitBucket上搭建仓库，自己一步一步尝试。 添加测试用的远端仓库
$ git remote add origin https://github.com/tutorialzine/awesome-project.git
一个项目可以同时拥有好几个远端仓库为了能够区分，通常会起不同的名字。通常主远端仓库被称为origin。

2.上传到服务器 – git push
每次我们要提交代码到服务器上时，都会使用到git push
git push命令会有两个参数，远端仓库的名字，以及分支的名字
$ git push origin master
 
Counting objects: 3, done.
Writing objects: 100% (3/3), 212 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/tutorialzine/awesome-project.git
 * [new branch]      master -> master
 
 取决于你使用的服务器，push过程你可能需要验证身份。如果没有出差错，现在使用浏览器去你的远端分支上看，hello.txt已经在那里等着你了。
 
 3.克隆仓库 – git clone
放在Github上的开源项目，人们可以看到你的代码。可以使用 git clone进行下载到本地。
git clone https://github.com/tutorialzine/awesome-project.git
本地也会创建一个新的仓库，并自动将github上的分支设为远端分支

4.从服务器上拉取代码 – git pull
如果你更新了代码到仓库上，其他人可以通过git pull命令拉取你的变动：
$ git pull origin master
From https://github.com/tutorialzine/awesome-project
 * branch            master     -> FETCH_HEAD
Already up-to-date.
因为暂时没有其他人提交，所有没有任何变动

5.分支
https://www.jianshu.com/p/7dddf0e9f1ef iOS里的Git版本管理方法 圣迪
当你在做一个新功能的时候，最好是在一个独立的区域上开发，通常称之为分支。分支之间相互独立，并且拥有自己的历史记录。这样做的原因是：

稳定版本的代码不会被破坏
不同的功能可以由不同开发者同时开发。
开发者可以专注于自己的分支，不用担心被其他人破坏了环境
在不确定之前，同一个特性可以拥有几个版本，便于比较

1.创建新分支 – git branch
每一个仓库的默认分支都叫master, 创建新分支可以这样：
$ git branch amazing_new_feature 创建了一个名为amazing_new_feature的新分支，它跟当前分支同一起点

单独使用git branch，可以查看分支状态：
$ git branch
  amazing_new_feature
* master * 号表示当前活跃分支为master，使用git checkout切换分支。

2.切换分支 – git checkout
$ git checkout amazing_new_feature

3.合并分支 – git merge
我们的 amazing_new_feature 分支的任务是增加一个featuer.txt。我们来创建，添加到暂存区，提交。
$ git add feature.txt
$ git commit -m "New feature complete."

新分支任务完成了，回到master分支
$ git checkout master

现在去查看文件，你会发现，之前创建的feature.txt文件不见了，因为master分支上并没有feature.txt。
使用git merge 把 amazing_new_feature 分支合并到master上。
$ git merge amazing_new_feature

ok! 然后再把amazing_new_feature 分支删掉吧。
$ git branch -d amazing_new_feature


高级

这篇文章的最后一节，我们来说些比较高级并且使用的技巧。
1.比对两个不同提交之间的差别
每次提交都有一个唯一id，查看所有提交和他们的id，可以使用 git log:

$ git log
 
commit ba25c0ff30e1b2f0259157b42b9f8f5d174d80d7
Author: Tutorialzine
Date:   Mon May 30 17:15:28 2016 +0300
 
    New feature complete
 
commit b10cc1238e355c02a044ef9f9860811ff605c9b4
Author: Tutorialzine
Date:   Mon May 30 16:30:04 2016 +0300
 
    Added content to hello.txt
 
commit 09bd8cc171d7084e78e4d118a2346b7487dca059
Author: Tutorialzine
Date:   Sat May 28 17:52:14 2016 +0300
 
    Initial commit
    
    
$ git show 
id 很长，但是你并不需要复制整个字符串，前一小部分就够了。
查看某一次提交更新了什么，使用 git show:
$ git show b10cc123
 
commit b10cc1238e355c02a044ef9f9860811ff605c9b4
Author: Tutorialzine
Date:   Mon May 30 16:30:04 2016 +0300
 
    Added content to hello.txt
 
diff --git a/hello.txt b/hello.txt
index e69de29..b546a21 100644
--- a/hello.txt
+++ b/hello.txt
  -0,0 +1
+Nice weather today, isn't it?

查看两次提交的不同，可以使用git diff id1..id2 语法：
$ git diff 09bd8cc..ba25c0ff
 
diff --git a/feature.txt b/feature.txt
new file mode 100644
index 0000000..e69de29
diff --git a/hello.txt b/hello.txt
index e69de29..b546a21 100644
--- a/hello.txt
+++ b/hello.txt
  -0,0 +1
+Nice weather today, isn't it?
比较首次提交和最后一次提交，我们可以看到所有的更改。当然使用git difftool命令更加方便。

2.回滚某个文件到之前的版本 滚到某一次commit
git 允许我们将某个特定的文件回滚到特定的提交，使用的也是 git checkout。
下面的例子，我们将hello.txt回滚到最初的状态，需要指定回滚到哪个提交，以及文件的全路径。

$ git checkout 09bd8cc1 hello.txt

git reset
git reset 是撤销某次提交，但是此次之后的修改都会被退回到暂存区。
git reset HEAD 回退所有内容到上一个版本
git reset 057d 回退到某个版本

git revert

Revert撤销一个提交的同时会创建一个新的提交。这是一个安全的方法，因为它不会重写提交历史

3.回滚提交
最新的一次有个别名叫HEAD
如果从暂存区提交了某个文件，再从commit回到暂存区，可以使用 git commit —amend

使用场景

下表来源于延伸阅读（1）

命令	作用域	常用情景
git reset HEAD	提交层面	在私有分支上舍弃一些没有提交的更改
git reset	文件层面	将文件从缓存区中移除
git checkout HEAD	提交层面	切换分支或查看旧版本
git checkout	文件层面	舍弃工作目录中的更改
git revert HEAD	提交层面	在公共分支上回滚更改
git revert	文件层面	（然而并没有）

4.解决合并冲突

冲突经常出现在合并分支或者是拉去别人的代码。有些时候git能自动处理冲突，但大部分需要我们手动处理。

比如John 和 Tim 分别在各自的分支上写了两部分代码。
John 喜欢 for:

// Use a for loop to console.log contents.
for(var i=0; i console.log(arr[i]);
}
Tim 喜欢 forEach:

// Use forEach to console.log contents.
arr.forEach(function(item) {
console.log(item);
});

假设John 现在去拉取 Tim的代码:
$ git merge tim_branch
 
Auto-merging print_array.js
CONFLICT (content): Merge conflict in print_array.js
Automatic merge failed; fix conflicts and then commit the result.

这时候git并不知道如何解决冲突，因为他不知道John和Tim谁写得更好。

于是它就在代码中插入标记。
HEAD
// Use a for loop to console.log contents.
for(var i=0; iarr.length; i++) {
    console.log(arr[i]);
}
=======
// Use forEach to console.log contents.
arr.forEach(function(item) {
    console.log(item);
});
>>>>>>> Tim s commit.

==== 号上方是当前最新一次提交，下方是冲突的代码。我们需要解决这样的冲突，经过组委会成员讨论，一致认定，在座的各位都是垃圾！两个都不要。改成下面的代码。
// Not using for loop or forEach.
// Use Array.toString() to console.log contents.
console.log(arr.toString());

好了，再提交一下：
$ git add -A
$ git commit -m "Array printing conflict resolved."

如果在大型项目中，这个过程可能容易出问题。你可以使用GUI 工具来帮助你。使用 git mergetool。

5.配置 .gitignore

大部分项目中，会有写文件，文件夹是我们不想提交的。为了防止一不小心提交，我们需要gitignore文件：

在项目根目录创建.gitignore文件
在文件中列出不需要提交的文件名，文件夹名，每个一行
.gitignore文件需要提交，就像普通文件一样
通常会被ignore的文件有：

log文件
task runner builds
node_modules等文件夹
IDEs生成的文件
个人笔记
例如：

*.log
build/
node_modules/
.idea/
my_notes.txt

29.动画
1.类
CAAnimation  动画
    CAPropertyAnimation  属性动画
        CABasicAnimation  基础动画
           （duration：动画持续时间  repeatcount:动画重复次数  repeatduration:在一定时间内执行动画，与次数无关）
           
            (begintime:指定动画开始时间一般当前时间加上多少秒 ）
           
           （timingfunction:动画速度变化（属性值：kCAMediaTimingFunctionLinear均速 kCAMediaTimingFunctionEaseIn加速到突然停止 kCAMediaTimingFunctionEaseOut加速再减慢 
            kCAMediaTimingFunctionEaseInEaseOut开始和结束慢，中间快 kCAMediaTimingFunctionDefault：开始和结束慢，中间快，加速减速都稍微慢））
            使用方法：pathAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
           （fillmode：动画开始和结束动作：默认kcafillmoderemoved)
            属性值：kCAFillModeForwards：
            
            (autoreverses:动画结束后是否再反向执行逆动画 fromvalue：改变属性的起始值  tovalue：改变必属性结束时的值 byvalue 改变属性相同起始值变量)
           
            CASpringAnimation  Spring动画
            
        CAKeyframeAnimation    关键贞动画
    CATransition               过渡动画   
    CAAnimationGroup           组动画
    

30.block中的weak和strong
只有当block直接或间接的被self持有时，才需要weak self。// 这种情况没必要
[self fetchDataWithSucess:^{
     [self doSomething];
}];

//这种情况就有必要
__weak CurrentViewController* blockSelf = self；
self.onTapEvent = ^{
    [blockSelf doSomething];
}
关于Block的copy
@property (nonatomic, copy) void (^getCardInfo)(NSDictionary *cardInfo); 
copy后才会放到堆上。指针指向block的时候才不会释放掉;  
brush.getCardInfo=^(NSDictionary *info){  
    [self test];  
};  

关于strongself
以 AFNetworking 中 AFNetworkReachabilityManager.m 的一段代码举例：

__weak __typeof(self)weakSelf = self;
AFNetworkReachabilityStatusBlock callback = ^(AFNetworkReachabilityStatus status) {
    __strong __typeof(weakSelf)strongSelf = weakSelf;
    //下面代码如果不加strongSelf容易释放掉
    strongSelf.networkReachabilityStatus = status;
    if (strongSelf.networkReachabilityStatusBlock) {
        strongSelf.networkReachabilityStatusBlock(status);
    }

};
有没有这样一个需求场景，block 会产生循环引用，但是业务又需要你不能使用 weak self? 如果有，请举一个例子并且解释这种情况下如何解决循环引用问题。
如果没有 strongSelf 的那行代码，那么后面的每一行代码执行时，self 都可能被释放掉了，这样很可能造成逻辑异常

 YTKNetwork 库中，我们的每一个网络请求 API 会持有回调的 block，回调的 block 会持有 self，而如果 self 也持有网络请求 API 的话，我们就构造了一个循环引用。虽然我们构造出了循环引用，但是因为在网络请求结束时，网络请求 API 会主动释放对 block 的持有，因此，整个循环链条被解开，循环引用就被打破了，所以不会有内存泄漏问题。代码其实很简单，如下所示：

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}
总结来说，解决循环引用问题主要有两个办法：

第一个办法是「事前避免」，我们在会产生循环引用的地方使用 weak 弱引用，以避免产生循环引用。 
第二个办法是「事后补救」，我们明确知道会存在循环引用，但是我们在合理的位置主动断开环中的一个引用，使得对象得以回收。 

31.runloop
作用：
1.保持程序运行
2.处理app的各种事件（比如触摸，定时器等等）
3.节省CPU资源，提高性能。

两个API：
Foundatio NSRunLoop
Core Foundation CFRunLoopRef

.RunLoop与线程：
1.每条线程都有唯一的与之对应的RunLoop对象 ，底层用字典保存 
2.主线程runloop已经创建好了，子线程runloop需要手动创建 CFRunLoopGetCurrent(); [NSRunLoop currentRunLoop];创建用的懒加载
3.线程结束runloop销毁

获取RunLoop对象

Foundation
[NSRunLoop currentRunLoop]; // 获得当前线程的RunLoop对象
[NSRunLoop mainRunLoop]; // 获得主线程的RunLoop对象

Core Foundation
CFRunLoopGetCurrent(); // 获得当前线程的RunLoop对象
CFRunLoopGetMain(); // 获得主线程的RunLoop对象

在Core Foundation中有RunLoop的五个类
    CFRunLoopRef
    CFRunLoopModeRef
    CFRunLoopSourceRef
    CFRunLoopTimerRef
    CFRunLoopObserverRef
    
一个runloop运行同一时间只能运行一种模式，但可以选择5种不同类型的模式，每个模式下都包括 CFRunLoopSourceRef，CFRunLoopTimerRef
CFRunLoopObserverRef，不同模式下的源和观察者互不干涉，runloop要运行，必需包含 CFRunLoopSourceRef，CFRunLoopTimerRef中的一个
如果需要切换 Mode，只能退出 Loop，再重新指定一个 Mode 进入

CFRunLoopModeRef
    kCFRunLoopDefaultMode //App的默认Mode，通常主线程是在这个Mode下运行
    UITrackingRunLoopMode //界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
    UIInitializationRunLoopMode // 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
    GSEventReceiveRunLoopMode // 接受系统事件的内部 Mode，通常用不到
    kCFRunLoopCommonModes //这是一个占位用的Mode，不是一种真正的Mode，相当于即是 kCFRunLoopDefaultMode也是UITrackingRunLoopMode
    
CFRunLoopSourseRef是事件源，分为两种
sourse0：非基于port的 （port相当于是系统），不属于用户自己写的方法
sourse1：基于port 系统提供的

CFRunLoopObserverRef
CFRunLoopObserver是观察者，可以监听runLoop的状态改变
监听的状态如下：
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) { 
kCFRunLoopEntry = (1UL << 0), //即将进入Runloop
kCFRunLoopBeforeTimers = (1UL << 1), //即将处理NSTimer 
kCFRunLoopBeforeSources = (1UL << 2), //即将处理Sources 
kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠 
kCFRunLoopAfterWaiting = (1UL << 6), //刚从休眠中唤醒 
kCFRunLoopExit = (1UL << 7), //即将退出runloop 
kCFRunLoopAllActivities = 0x0FFFFFFFU //所有状态改变};

实验1:
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));//永远不返回，因为有runloop
    }
}

实验2:尝试打印RunLoop对象

打印出很多runloop相关内容

- (IBAction)ButtonDidClick:(id)sender {
    NSLog(@"ButtonDidClick");
    NSLog(@"----%@", [NSRunLoop currentRunLoop]);
}

实验3:NSTimer的使用
- (IBAction)ButtonDidClick:(id)sender {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    这个方法默认把nstimer加入到了一个kCFRunLoopDefaultMode模式中，当手没动scrollview的时候，runloop切换到 UITrackingRunLoopMode模式
    导致NSTimer不执行
    解决方法：
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:kCFRunLoopCommonModes];//同时加到默认和跟踪模式下
}

- (void)timerTest
{
    NSLog(@"timerTest----");
}


实验4：NSTimer未运行，这种创建的timer没有在作何模式下，需加到一种模式下
- (IBAction)ButtonDidClick:(id)sender {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
   [[NSRunLoop currentRunLoop] addTimer:timer forMode:kCFRunLoopCommonModes];//同时加到默认和跟踪模式下
}

- (void)timerTest
{
    NSLog(@"timerTest----");
}

实验5：关CFRunLoopObserverRef的实验
首先回顾CFRunLoopObserverRef，是RunLoop的监听者，监听的状态如下：
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) { 
kCFRunLoopEntry = (1UL << 0), //即将进入Runloop
kCFRunLoopBeforeTimers = (1UL << 1), //即将处理NSTimer 
kCFRunLoopBeforeSources = (1UL << 2), //即将处理Sources 
kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠 
kCFRunLoopAfterWaiting = (1UL << 6), //刚从休眠中唤醒 
kCFRunLoopExit = (1UL << 7), //即将退出runloop 
kCFRunLoopAllActivities = 0x0FFFFFFFU //所有状态改变};
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createObserver];
}


- (void)createObserver
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"--------%zd", activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);  // 添加监听者，关键！
    CFRelease(observer); // 释放
}

运行可以看到打印的数字对应枚举

runloop事件与观察者
每次运行runloop ，线程都会把未处理的消息通知观察者
1、通知观察者runloop 已经启动
2、通知观察者任何即将要开始的定时器
3、通知观察者任何即将启动的其它源
4、启动准备好源
5、如果有源处理唤醒后收到的消息，然后再加到第2步

32、instancetype和id
instancetype用来在编译期确定实例的类型，而使用id，运行时检查类型.
id可以作为方法的参数  instancetype只适用于初始化方法和便利构造器的返回值类型

33、copy mutablecopy 
copy遇到NSMutableArray，深拷贝 拷贝出来的是NSMutableArray可变
copy遇到NSArray 浅拷贝 拷贝出来的是NSArray不可变
MutalbeCopy遇到NSMutableArray 深拷贝，拷贝出来的是NSMutableArray可变 
MutalbeCopy遇到NSArray  深拷贝 拷贝出来的是NSMutableArray可变 
MutalbeCopy的东西都是深拷贝，且都是可变数组
copy一个可变的数组，深拷贝，不可变
copy一个不可变数组  浅拷贝，不可变

对象的拷贝需要重写协议，才能深拷贝，其中又分可变和不可变

   typedef NS_ENUM(NSInteger, CYLSex) {
       CYLSexMan,
       CYLSexWoman
   };

   @interface CYLUser : NSObject<NSCopying>

   @property (nonatomic, readonly, copy) NSString *name;
   @property (nonatomic, readonly, assign) NSUInteger age;
   @property (nonatomic, readonly, assign) CYLSex sex;

   - (instancetype)initWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;
   + (instancetype)userWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;

   @end
   
   - (id)copyWithZone:(NSZone *)zone {
	CYLUser *copy = [[[self class] allocWithZone:zone] 
		             initWithName:_name
 							      age:_age
						          sex:_sex];
	return copy;
}

有些复杂的对象，如对象包含一个数组，那需把数组也拷贝过去

/ .h文件
// http://weibo.com/luohanchenyilong/
// https://github.com/ChenYilong
// 以第一题《风格纠错题》里的代码为例

typedef NS_ENUM(NSInteger, CYLSex) {
    CYLSexMan,
    CYLSexWoman
};

@interface CYLUser : NSObject<NSCopying>

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) NSUInteger age;
@property (nonatomic, readonly, assign) CYLSex sex;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;
+ (instancetype)userWithName:(NSString *)name age:(NSUInteger)age sex:(CYLSex)sex;
- (void)addFriend:(CYLUser *)user;
- (void)removeFriend:(CYLUser *)user;

@end

@implementation CYLUser {
   NSMutableSet *_friends;
}

- (void)setName:(NSString *)name {
   _name = [name copy];
}

- (instancetype)initWithName:(NSString *)name
                        age:(NSUInteger)age
                        sex:(CYLSex)sex {
   if(self = [super init]) {
       _name = [name copy];
       _age = age;
       _sex = sex;
       _friends = [[NSMutableSet alloc] init];
   }
   return self;
}

- (void)addFriend:(CYLUser *)user {
   [_friends addObject:user];
}

- (void)removeFriend:(CYLUser *)user {
   [_friends removeObject:user];
}

- (id)copyWithZone:(NSZone *)zone {
   CYLUser *copy = [[[self class] allocWithZone:zone]
                    initWithName:_name
                    age:_age
                    sex:_sex];
   copy->_friends = [_friends mutableCopy];
   return copy;
}

- (id)deepCopy {
   CYLUser *copy = [[[self class] alloc]
                    initWithName:_name
                    age:_age
                    sex:_sex];
   copy->_friends = [[NSMutableSet alloc] initWithSet:_friends
                                            copyItems:YES];
   return copy;
}

@end

34、runtime
我为了搞清属性是怎么实现的,曾经反编译过相关的代码,他大致生成了五个东西

OBJC_IVAR_$类名$属性名称 ：该属性的“偏移量” (offset)，这个偏移量是“硬编码” (hardcode)，表示该变量距离存放对象的内存区域的起始地址有多远。
setter 与 getter 方法对应的实现函数
ivar_list ：成员变量列表
method_list ：方法列表
prop_list ：属性列表
也就是说我们每次在增加一个属性,系统都会在 ivar_list 中添加一个成员变量的描述,在 method_list 中增加 setter 与 getter 方法的描述,
在属性列表中增加一个属性的描述,然后计算该属性在对象中的偏移量,然后给出 setter 与 getter 方法对应的实现,在 setter 方法中从偏移量的位置
开始赋值,在 getter 方法中从偏移量开始取值,为了能够读取正确字节数,系统对象偏移量的指针类型进行了类型强转.
objc_setAssociatedObject
objc_getAssociatedObject

runtime 如何实现 weak 变量的自动置nil？
weak 对象会放入一个 hash 表中，用 weak 指向的对象内存地址作为 key，当此对象的引用计数为0的时候会 dealloc，假如 weak 指向的对象内存地址是a，那么就会以a为键，
 在这个 weak 表中搜索，找到所有以a为键的 weak 对象，从而设置为 nil。
objc_storeWeak(&a, b)函数理解为：objc_storeWeak(value, key) key变nil，将value置nil


35、 @synthesize和@dynamic分别有什么作用？
@syntheszie var = _var;生成指向var的get，set方法，如果没写编译器会自动生成get,set
@dynamic 告诉编译器：需要用户实现get,set，如果不写，编译器不会生成get,set

不会autosynthesis（自动合成属性）？
同时重写了 setter 和 getter 时
重写了只读属性的 getter 时
使用了 @dynamic 时
在 @protocol 中定义的所有属性
在 category 中定义的所有属性
重载的属性

当你在子类中重载了父类中的属性，你必须 使用 @synthesize 来手动合成ivar。
//
// .m文件
// http://weibo.com/luohanchenyilong/ (微博@iOS程序犭袁)
// https://github.com/ChenYilong
// 打开第14行和第17行中任意一行，就可编译成功

@import Foundation;

@interface CYLObject : NSObject
@property (nonatomic, copy) NSString *title;
@end

@implementation CYLObject {
   //    NSString *_title;
}

//@synthesize title = _title;

- (instancetype)init
{
   self = [super init];
   if (self) {
       _title = @"微博@iOS程序犭袁";
   }
   return self;
}

- (NSString *)title {
   return _title;
}

- (void)setTitle:(NSString *)title {
   _title = [title copy];
}

@end

36、如果属性不指定作何关键字描述，那对应的默认属性关键字为
基本数据类型：atomic,readwrite,assign
Objective-C 对象：atomic,readwrite,strong

37、objc中向一个nil对象发送消息将会发生什么？
如果向一个nil对象发送消息，如果该方法返回的为基本数值类型，那返回的是一值是0,
如果返回值为结构体，那结构体各字段的值是0，如果不是上述的类型，那返回为未定义
通过objc_msgSend(receiver, selector)发送
struct objc_class {
  Class isa OBJC_ISA_AVAILABILITY; //isa指针指向Meta Class，因为Objc的类的本身也是一个Object，所以指向的是这个类类型，及对象
  #if !__OBJC2__
  Class super_class OBJC2_UNAVAILABLE; // 父类
  const char *name OBJC2_UNAVAILABLE; // 类名
  long version OBJC2_UNAVAILABLE; // 类的版本信息，默认为0
  long info OBJC2_UNAVAILABLE; // 类信息，供运行期使用的一些位标识
  long instance_size OBJC2_UNAVAILABLE; // 该类的实例变量大小
  struct objc_ivar_list *ivars OBJC2_UNAVAILABLE; // 该类的成员变量链表
  struct objc_method_list **methodLists OBJC2_UNAVAILABLE; // 方法定义的链表
  struct objc_cache *cache OBJC2_UNAVAILABLE; // 方法缓存，对象接到一个消息会根据isa指针查找消息对象，这时会在method Lists中遍历，如果cache了，常用的方法调用时就能够提高调用的效率。
  struct objc_protocol_list *protocols OBJC2_UNAVAILABLE; // 协议链表
  #endif
  } OBJC2_UNAVAILABLE;
  objc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类，
  然后在该类中的方法列表以及其父类方法列表中寻找方法运行，
 发送消息的时候，objc_msgSend方法不会返回值，所谓的返回内容都是具体调用时执行的。 
 那么，回到本题，如果向一个nil对象发送消息，首先在寻找对象的isa指针时就是0地址返回了，所以不会出现任何错误
 
 38、通过clang编译后查看源码，查看[obj foo]和objc_msgSend()函数之间有什么关系
 #import "CYLTest.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        CYLTest *test = [[CYLTest alloc] init];
        [test performSelector:(@selector(iOSinit))];
        return 0;
    }
}
clang -rewrite-objc main.m
生成一个main.cpp文件，大概有4万多行代码
我们可以看到大概是这样的：
((void ()(id, SEL))(void )objc_msgSend)((id)obj, sel_registerName("foo"));
[obj foo];在objc编译时，会被转意为：objc_msgSend(obj, @selector(foo));。


39、什么时候会报unrecognized selector的异常
可查看github上demo  _objc_msgForward_demo
//
//  Monkey.m
//  _objc_msgForward_demo
//
//  Created by luguobin on 15/9/21.
//  Copyright © 2015年 XS. All rights reserved.
//

#import "Monkey.h"
#import "ForwardingTarget.h"
#import <objc/runtime.h>

@interface Monkey()
@property (nonatomic, strong) ForwardingTarget *target;
@end

@implementation Monkey

- (instancetype)init
{
    self = [super init];
    if (self) {
        _target = [ForwardingTarget new];
        [self performSelector:@selector(sel:) withObject:@"yeyu"];
    }
    
    return self;
}


id dynamicMethodIMP(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%s:动态添加的方法",__FUNCTION__);
    NSLog(@"%@", str);
    return @"1";
}


//对象查找selector时，先查找cachelist，如果没有则查找methodlist，如果还没有就查找父类的methodlist
//进入该方法，该方法为本类对象添加一个未找到的方法sel，然后重新调用新添加的这个sel方法
+ (BOOL)resolveInstanceMethod:(SEL)sel __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0) {
    
    class_addMethod(self.class, sel, (IMP)dynamicMethodIMP, "@@:");
    BOOL result = [super resolveInstanceMethod:sel];
    result = YES;
    return result; // 1
}

//如果resolveInstanceMethod没作任何处理，会进入这个方法，把消息重启后转发给其它对象ForwardingTarget，
//ForwardingTarget对象调用它自身的sel方法
- (id)forwardingTargetForSelector:(SEL)aSelector __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0) {
    id result = [super forwardingTargetForSelector:aSelector];
    result = self.target;
    return result; // 2
}
//如果forwardingTargetForSelector方法未处理，则进入这个方法，这个方法返回一个对象，其中包括
//sel方法的参数及返回值，如果返回的这个对象是nil，那发送消息Runtime则会向doesNotRecognizeSelector发消息，然后程序挂掉，如果不是nil，返回了这个sel函数的签名，那会调用forwardInvocation:方法，该方法再转发给自身对象的invocationTest进行处理
//
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    id result = [super methodSignatureForSelector:aSelector];
    NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    result = sig;
    return result; // 3
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    //    [super forwardInvocation:anInvocation];
    anInvocation.selector = @selector(invocationTest);
    [self.target forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    [super doesNotRecognizeSelector:aSelector];
}

@end

40、一个objc对象如何进行内存布局？
每一个对象内部都有一个isa指针,指向他的类，这个类即对象
它有 对象方法列表（对象能够接收的消息列表，保存在它所对应的类对象中）成员变量的列表,属性列表,
还有一个superclass的指针，指向他的父类对象     
一个objc对象的isa的指针指向什么？有什么作用？
指向他的类对象,从而可以找到对象上的方法                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

41. 下面的代码输出什么？

   @implementation Son : Father
   - (id)init
   {
       self = [super init];
       if (self) {
           NSLog(@"%@", NSStringFromClass([self class]));
           NSLog(@"%@", NSStringFromClass([super class]));
       }
       return self;
   }
   @end
   都输出 Son
NSStringFromClass([self class]) = Son
NSStringFromClass([super class]) = Son
上面的例子不管调用[self class]还是[super class]，接受消息的对象都是当前 Son ＊xxx 这个对象。
当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找。然后调用父类的这个方法。

42、iOS 如何创建一个线程，要求可以一直工作，不会执行一次就结束。常驻线程
方法1：开启一个线程，让线程调用的方法加入一个自动释方池，自动释放池中写一个死循环，循环加锁，则永远线程常驻其中，因为没有线程没有执行完
@synthesize name;  
- (void)viewDidLoad  
{  
    [super viewDidLoad];  
    // Do any additional setup after loading the view, typically from a nib.  
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadFunc) object:nil];  
    [thread start];  
}  
static bool over = NO;  
- (void)threadFunc  
{  
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];  
    while (YES) {  
        @synchronized(name){  
            name = @"Frank";  
            [NSThread sleepForTimeInterval:2];  
            if ([NSThread isMultiThreaded]) {  
                NSLog(@"%@ isMultiThreaded",name);  
            }  
            if (over) {  
                break;  
            }  
        }  
    }  
    [pool release];  
}  
方法2：开启一个线程，这个子线程调的方法需手成开启一个runloop，这样runloop一直循环就可以实现常驻线程
   [self performSelector:@selector(time) onThread:self.thred withObject:nil waitUntilDone:NO];
-(void)run{
    NSLog(@"thred ===============%@",[NSThread currentThread]);
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}

43、afn2.0 为什么需要常驻线程
1为什么要添加一个不退出的线程
2为什么只添加了一个线程
AFN把网络请求的发起和收到结果解析放在了子线程中，但子线程一般都是执行完退出，但afn收到网络请求是延时的，也许线程退出了才收到
请求，为了保证线程不退出，所以写了一个常驻线程
如果频繁的开启多个线程启用多个runloop会占用内存，内存泄漏，所以只开启了一个常驻线程，其实这里的一个常驻线程是指把每个AFHTTPRequestOperation
请求加到NSOperationQueue，这个队列会根据cpu的核数来开启具体的几条线程

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

45、gcd的信号量semaphore
信号量为0则阻塞线程，大于0则不会阻塞，通过改变信号量的值，来控制是否阻塞线程，从而达到线程同步。

GCD的时候如何让线程同步，目前我能想到的就三种
1.dispatch_group
dispatch_group_t相关属性介绍
dispatch_group_async(group, queue, block);把一个block任务添另到队列中，并交给组管理
dispatch_group_enter(group)下面的任务由group组管理，group组的任务数+1
dispatch_group_leave(group);任务离开这个组
dispatch_group_create();创建一个组
dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);永远等待组下，这个代码下面的语句永远不会执行
dispatch_group_notify(group1, queue1,block);监听组中的所有任务，当所有任务完成才会执行此方法


常见用法的区别

组合方式1使用到了下面的方法：
dispatch_group_async(group, queue, block);
dispatch_group_notify(group1, queue1, block);

同步任务：异步任务执行-1，异步任务执行-2会随机打印，因为dispatch_group_async,切记没有dispatch_group_sync这个方法
  dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务1",(long)i);

            }
        });
    });

    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
 //   等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程,因为是dispatch_syn同步没有开启线程的能力，所以会一直阻塞当前线程，直到任务完成执行下面代码）
//    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
//    NSLog(@"dispatch_group_wait语句等待上面同步任务执行完成才执行");

    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成会执行这句话");
    });
    2018-05-24 13:21:21.530919+0800 222[99709:5236661] 任务2-同步任务执行-:0
2018-05-24 13:21:21.530934+0800 222[99709:5236663] 任务1-同步任务执行-:0
2018-05-24 13:21:22.532045+0800 222[99709:5236663] 任务1-同步任务执行-:1
2018-05-24 13:21:22.532059+0800 222[99709:5236661] 任务2-同步任务执行-:1
2018-05-24 13:21:23.535790+0800 222[99709:5236661] 任务2-同步任务执行-:2
2018-05-24 13:21:23.535878+0800 222[99709:5236663] 任务1-同步任务执行-:2
2018-05-24 13:21:23.535959+0800 222[99709:5236663] Method1-全部任务执行完成会执行这句话

异步任务： 异步任务执行-1，异步任务执行-2会随机打印，因为dispatch_group_async,切记没有dispatch_group_sync这个方法
 dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务1",(long)i);

            }
        });
    });
    
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
//    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）在异步任务下这个wait不起作用了，因为这dispatch_async有开启新线程的能力
//，dispatch_group_wait只能阻塞当前线程
//    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）  在异步任务下这句话不起作用了，会先执行 NSLog(@"Method1-全部任务执行完成");
    //再打印异步任务执行1或异步任务执行2
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成");
    });
2018-05-24 13:22:33.800905+0800 222[99808:5239197] Method1-全部任务执行完成
2018-05-24 13:22:34.800935+0800 222[99808:5239198] 任务1-异步任务执行-:0
2018-05-24 13:22:34.801011+0800 222[99808:5239196] 任务2-异步任务执行-:0
2018-05-24 13:22:35.801195+0800 222[99808:5239198] 任务1-异步任务执行-:1
2018-05-24 13:22:35.801195+0800 222[99808:5239196] 任务2-异步任务执行-:1
2018-05-24 13:22:36.801369+0800 222[99808:5239198] 任务1-异步任务执行-:2
2018-05-24 13:22:36.801369+0800 222[99808:5239196] 任务2-异步任务执行-:2
组合方式2

dispatch_group_enter(group);

dispatch_group_leave(group);

dispatch_group_notify(group1, queue1,block);

在这种组合下，根据任务是同步、异步又分为两种，这两种组合的执行代码与运行结果如下：

同步：
dispatch_queue_t queue2 = dispatch_queue_create("dispatchGroupMethod2.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group2 = dispatch_group_create();
    

    dispatch_group_enter(group2);//把下面任务加入到这个组中，并在任务结束后离开这个组，所以任务按1，2，3这样执行，不会像dispatch_group_async，任务随机执行
    dispatch_sync(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-同步任务执行-:%ld",@"任务1",(long)i);
            
        }
        dispatch_group_leave(group2);//这个任务执行完会离开group2，group2任务数减1，如果group2中还有任务数没执行完，永远不会执行dispatch_group_notify这个方法
    });
    

    
    dispatch_group_enter(group2);//把下面任务加入到这个组中，并在任务结束后离开这个组，所以任务按1，2，3这样执行，不会像dispatch_group_async，任务随机执行
    dispatch_sync(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-同步任务执行-:%ld",@"任务2",(long)i);
            
        }
        dispatch_group_leave(group2);
    });
    
//    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
//    dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group2, queue2, ^{
        NSLog(@"Method2-全部任务执行完成");
    });

2018-05-21 13:08:28.580944+0800 222[23502:1828298] 任务1-同步任务执行-:0
2018-05-21 13:08:29.586230+0800 222[23502:1828298] 任务1-同步任务执行-:1
2018-05-21 13:08:30.588698+0800 222[23502:1828298] 任务1-同步任务执行-:2
2018-05-21 13:08:31.592323+0800 222[23502:1828298] 任务2-同步任务执行-:0
2018-05-21 13:08:32.594173+0800 222[23502:1828298] 任务2-同步任务执行-:1
2018-05-21 13:08:33.599511+0800 222[23502:1828298] 任务2-同步任务执行-:2
2018-05-21 13:08:33.599634+0800 222[23502:1828345] Method2-全部任务执行完成

 
异步：
 dispatch_queue_t queue2 = dispatch_queue_create("dispatchGroupMethod2.queue2", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group2 = dispatch_group_create();
        
        
        dispatch_group_enter(group2);
        dispatch_async(queue2, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务1",(long)i);
                
            }
            dispatch_group_leave(group2);
        });
        
        
        
        dispatch_group_enter(group2);
        dispatch_async(queue2, ^{//任务随机执行，因为是异步，可能是任务2执行两次，再执行任务1一次，这里打印出交替执行，是因为有sleep(1)的作用，因为线程是交替切换的
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务2",(long)i);
                
            }
            dispatch_group_leave(group2);
        });
        
        //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
        //    dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
        
        //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
        dispatch_group_notify(group2, queue2, ^{
            NSLog(@"Method2-全部任务执行完成");
        });
        
2018-05-21 13:14:42.957358+0800 222[23897:1837205] 任务2-异步任务执行-:0
2018-05-21 13:14:42.957360+0800 222[23897:1837207] 任务1-异步任务执行-:0
2018-05-21 13:14:43.960226+0800 222[23897:1837205] 任务2-异步任务执行-:1
2018-05-21 13:14:43.960280+0800 222[23897:1837207] 任务1-异步任务执行-:1
2018-05-21 13:14:44.964497+0800 222[23897:1837205] 任务2-异步任务执行-:2
2018-05-21 13:14:44.964497+0800 222[23897:1837207] 任务1-异步任务执行-:2
2018-05-21 13:14:49.979265+0800 222[23897:1837207] Method2-全部任务执行完成

2.dispatch_barrier
 dispatch_barrier_async代码块，会阻塞当前线程，直到这个代码块执行完成，但是这个必须是在私自创建的串行或并行队列上，如果加入到全局队列上不会阻塞
 会数据错乱
 
 //创建了一个私有的并发队列，因为是私有的，把以下面代码是按顺序执行
 let currentQueue:dispatch_queue_t = dispatch_queue_create("com.eric", DISPATCH_QUEUE_CONCURRENT);
    
    var num = 10
    dispatch_barrier_async(currentQueue) {
        sleep(1)
        num = 11
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 12
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 13
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 14
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("5")
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("6")
        print(NSThread.currentThread())
    }
    print("结束")
    
    //创建了一个全局并发队列，不是私有的，这个时候执行会数据错乱
    let currentQueue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    var num = 10
    dispatch_barrier_async(currentQueue) {
        sleep(1)
        num = 11
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 12
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 13
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 14
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("5")
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("6")
        print(NSThread.currentThread())
    }
    print("结束")

执行结果:
<pre>结束
14
14
14
5
6

创建了一个私有的串行队列，因为是私有的，按顺序执行
let currentQueue:dispatch_queue_t = dispatch_queue_create("com.eric", DISPATCH_QUEUE_SERIAL);
    //let currentQueue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    var num = 10
    dispatch_barrier_async(currentQueue) {
        sleep(5)
        num = 11
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 12
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 13
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        num = 14
        print(num)
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("5")
        print(NSThread.currentThread())
    }
    dispatch_barrier_async(currentQueue) {
        print("6")
        print(NSThread.currentThread())
    }
    print("结束")









3.dispatch_semaphore

dispatch_semaphore_create 创建一个semaphore
dispatch_semaphore_signal 发送一个信号 +1
dispatch_semaphore_wait 等待信号 为0时阻塞

demo1:
实现线程的同步，同一时间只有一个线程访问
思路：创建一个值为1的信号量，每个线程任务在执行前会信号量减1，此时为0,执行完成后信号量加1，则其它线程又可以执行
/传递的参数是信号量最初值,下面例子的信号量最初值是1
 dispatch_semaphore_t signal = dispatch_semaphore_create(1);

    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

       // 当信号量是0的时候,dispatch_semaphore_wait(signal, overTime);这句代码会一直等待直到overTime超时.
//这里信号量是1 所以不会在这里发生等待.
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
       long signalValue = dispatch_semaphore_signal(signal);//这句代码会使信号值 增加1 
//并且会唤醒一个线程去开始继续工作,如果唤醒成功,那么返回一个非零的数,如果没有唤醒,那么返回 0
        
        NSLog(@"%ld",signalValue);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
        long signalValue = dispatch_semaphore_signal(signal);
        
        NSLog(@"%ld",signalValue);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作3");
        dispatch_semaphore_signal(signal);
        long signalValue = dispatch_semaphore_signal(signal);
        
        NSLog(@"%ld",signalValue);
    });

demo2:
利用 dispatch_semaphore_t signal 组织一个并发数是10 的一个多线程工作队列.这个demo测试不正确，并不是创建了并发数为10的线程队列
    dispatch_group_t group = dispatch_group_create();创建一个组线程
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//每次wait都减1，减到0则阻塞
       //注意这里信号量从10开始递减,并不会阻塞循环.循环10次,递减到0的时候,开始阻塞.不再循环第11次
        NSLog(@"-------");
        dispatch_group_async(group, queue, ^{//所有线程任务放入这个组中
            NSLog(@"%i",i);
            sleep(1);
            dispatch_semaphore_signal(semaphore);//当值为0时，这里执行后会加1，然后循环第11次，但第11次遇到wait，会
        });//创建一个新线程,并在线程结束后,发送信号量,通知阻塞的循环继续创建新线程.
    }
dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//只有所有任务block执行完，才能执行往下的代码


demo3:利用 dispatch_semaphore_t signal 组织一个生产消费模式
什么是生产者消费者模式？一个死循环里面一直等待消费，别一个线程生产一个产品，信号量加1，消费者在死循环里面收到信号进行消费

实现方案：创建一个信号量为0的信号，创建一个异步线程任务，内部while(1)循环，用一个信号等待，再创建一个异步线程，while(1) dispatch_semaphore_signal(sem);信号加1

__block int product = 0;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //消费者队列
        
        while (1) {
            if(!dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER))){
////非 0的时候,就是成功的timeout了,这里判断就是没有timeout   成功的时候是 0
                
                NSLog(@"消费%d产品",product);
                product--;
            };
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //生产者队列   
        while (1) {

                sleep(1); //wait for a while
                product++;
                NSLog(@"生产%d产品",product);
                dispatch_semaphore_signal(sem);
        }
        
    });
    
46.iOS网络请求缓存
URLCache类
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("URLCache's disk capacity is \(URLCache.shared.diskCapacity) bytes")
        print("URLCache's disk usage capacity is \(URLCache.shared.currentDiskUsage) bytes")
        print("URLCache's memory capacity is \(URLCache.shared.memoryCapacity) bytes")
        print("URLCache's memory usage capacity is \(URLCache.shared.currentMemoryUsage) bytes")
        return true
    }
URLCache's disk capacity is 10000000 bytes
URLCache's disk usage capacity is 86016 bytes
URLCache's memory capacity is 512000 bytes
URLCache's memory usage capacity is 0 bytes
系统默认在内存上分配约512KB的空间，在磁盘上分配约10M的空间。

配置缓存空间。项目中如果你觉得系统默认分配的缓存空间不够的时候我们可以手动去配置URLCache的缓存空间,以及数据缓存的位置。
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        URLCache.shared.diskCapacity = 1024 * 1024 * 5
        URLCache.shared.memoryCapacity = 1024 * 1024 * 30
        print("URLCache's disk capacity is \(URLCache.shared.diskCapacity) bytes")
        print("URLCache's disk usage capacity is \(URLCache.shared.currentDiskUsage) bytes")
        print("URLCache's memory capacity is \(URLCache.shared.memoryCapacity) bytes")
        print("URLCache's memory usage capacity is \(URLCache.shared.currentMemoryUsage) bytes")
        print("\(URLCache.shared)")
        return true
    }
    
缓存策略
HTTP定义了与服务器交互不同的方法，最基本的四种分别是：GET,POST,PUT,DELETE对应的分别是：查,改,增,删
URLCache只会对你的GET进行缓存
在caching in http中，服务器返回的头中会有这个字段：cache-control:max-age 
cache-control代表缓存的策略 max-age过期时间
public
private(default)
no-cache
max-age
must-revalidate

当ios请求网络后，如果设置了网络缓存，会在caches目录下创建几个数据库文件，
用数据库打开会有几张表，字段中request_key是返回url加参数的内容，即使cache-control没开启缓存，
数据库也会存数据，只是不使用这个数据

3.自定义缓存
let imgUrl = URL.init(string: "http://img15.3lian.com/2015/f2/50/d/71.jpg")
        var request = URLRequest.init(url: imgUrl!)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let respose = URLCache.shared.cachedResponse(for: request);
自己如何保存缓存
管理缓存：
URLCache.shared.removeAllCachedResponses()
URLCache.shared.removeCachedResponse(for: URLRequest)
URLCache.shared.removeCachedResponse(for: URLSessionDataTask)
URLCache.shared.storeCachedResponse(CachedURLResponse, for: URLRequest)
URLCache.shared.storeCachedResponse(CachedURLResponse, for: URLSessionDataTask)

如何更新缓存 Last-Modifie And ETag
第一次请求，服务器返回状态码200并返回当前url数据最后修改时间Last-Modified
Last-Modified: Fri, 12 May 2006 18:53:33 GMT
第二次请求，上次的修改时间已经在本地，这个时候把上次修改时间发送给服务器If-Modified-Since
格式类似这样：
If-Modified-Since: Fri, 12 May 2006 18:53:33 GMT

如果服务器资源未变化，返回304，内容为空，直接urlcache中获取
if ETagFromServer != ETagOnClient || LastModifiedFromServer != LastModifiedOnClient，如果和上次时间不相等

   GetDataFromServer
else

   GetDataFromURLCache
   
或Etag："50b1c1d4f775c61:df3" If-None-Match: W/"50b1c1d4f775c61:df3"hash值来判断
如果相等返回在304，服务器未修改，如果服务器被修改了，etag会发生相应的改变


47、SDWebImage原理和缓存机制
独立的异步图像下载
<SDWebImageOperation>)downloadImageWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionWithFinishedBlock)completedBlock; 来建立一个SDWebImageDownLoader 的实例。这样就可以有下载进度的回调和下载完成的回调，可以在回调完成进度条相关的操作和显示图片相关的操作。
实现了异步下载，并能显示下载进度

独立的异步图像缓存
SDImageCache类提供一个管理缓存的单例类。
SDImageCache *imageCache = [SDImageCache sharedImageCache]
先查找内存，如果内存不存在该图片，再查找硬盘；查找硬盘时，以URL的MD5值作为key
查找图片：
UIImage *cacheImage = [imageCache imageFromKey:myCacheKey];

缓存图片：
[ imageCache storeImage:myImage forKey:myCacheKey];
只缓存在内存中，不缓存在硬盘中
storeImage:forKey:toDisk:no;

主要用到的对象：
1.UIImageView(WebCache)，分类 入口封装，读取图片后回调
2.SDWebImagemanager 在图片未下载完成前的处理，记录是正在读取图片，或从缓存中读取图片SDImageCache，或从网络中请求图片SDWebImageDownloader
并实现管理
3.SDImageCache,根据URL作为key，对图片进行存储和读取（存在内存（以URL作为key）和存在硬盘两种（以URL的MD5值作为key））。实现图片和内存清理工作。

SDWebImage加载图片的流程
1.入口 setImageWithURL:placeholderImage:options:会先把 placeholderImage显示，然后 SDWebImageManager根据 URL 开始处理图片。
2.进入SDWebImageManager 类中downloadWithURL:delegate:options:userInfo:，交给
SDImageCache从缓存查找图片是否已经下载
queryDiskCacheForKey:delegate:userInfo:.//SDWebImageManager中从SDImageCache查看图片是否已经下载，
3.如果内存中已经有图片缓存，SDImageCacheDelegate回调 imageCache:didFindImage:forKey:userInfo:到
SDWebImageManager。SDWebImageManager的SDWebImageManagerDelegate再次回调到前端显示，如第4步
4.SDWebImageManagerDelegate 回调
webImageManager:didFinishWithImage: 到 UIImageView+WebCache,等前端展示图片。
5.如果内存缓存中没有，生成 ｀NSOperation ｀添加到队列，开始从硬盘查找图片是否已经缓存。在硬盘中查找使用了队列
6.根据 URL的MD5值Key在硬盘缓存目录下尝试读取图片文件。这一步是在 NSOperation 进行的操作，所以回主线程进行结果回调 notifyDelegate:。
7.如果上一操作从硬盘读取到了图片，将图片添加到内存缓存中（如果空闲内存过小， 会先清空内存缓存）。
SDImageCacheDelegate'回调 imageCache:didFindImage:forKey:userInfo:`。进而回调展示图片。进行了图片显示
8.如果从硬盘内存中都读不到图片，需要下载图片， 回调 imageCache:didNotFindImageForKey:userInfo:。
9.共享或重新生成一个下载器 SDWebImageDownloader开始下载图片。
10.图片下载由 NSURLConnection来做，实现相关 delegate
来判断图片下载中、下载完成和下载失败。
11.connection:didReceiveData: 中利用 ImageIO做了按图片下载进度加载效果。
12.connectionDidFinishLoading: 数据下载完成后交给 SDWebImageDecoder做图片解码处理。
13.图片解码处理在一个 NSOperationQueue完成，不会拖慢主线程 UI.如果有需要 对下载的图片进行二次处理，最好也在这里完成，效率会好
14.在主线程 notifyDelegateOnMainThreadWithInfo:
宣告解码完成 imageDecoder:didFinishDecodingImage:userInfo: 回调给 SDWebImageDownloader`。
15.imageDownloader:didFinishWithImage:回调给 SDWebImageManager告知图片 下载完成。
16. SDWebImageManager通知所有的 downloadDelegates下载完成，回调给需要的地方展示图片。
17.将图片保存到 SDImageCache中，内存缓存和硬盘缓存同时保存。写文件到硬盘 也在以单独 NSOperation 完成，避免拖慢主线程。
18.SDImageCache 在初始化的时候会注册一些消息通知，
在内存警告或退到后台的时 候清理内存图片缓存，应用结束的时候清理过期图片。

48、iOS，K线图
一、什么是K线图

1、K线图的定义：

K线（Candlestick chart）又称“阴阳烛”，是反映价格走势的一种图线，其特色在于一个线段内记录了多项讯息，相当易读易懂且实用有效，广泛用于股票、期货、贵金属、数字货币等行情的技术分析，称为K线分析

2、K线图相关的专业术语

K线可分“阳线”、“阴线”和“中立线”三种

阳线代表收盘价大于开盘价

阴线代表开盘价大于收盘价

中立线则代表开盘价等于收盘价。

3、K线图的表示

最早阳线以红色表示，阴线则以黑色表示，但由于彩色印刷成本高，所以后来阳线常改以白色空心方块表示。在亚洲国家（或大中华经济圈），多半配合传统习惯，阳线以红色表示，阴线以绿色表示，即是红升绿跌。至于中立线的颜色则不一而足，难以卒论，但以异于其他两线为原则。在欧美，习惯则正好相反，阴线以红色表示，阳线以绿色表示。香港跟欧美相同，采用绿升红跌。

二、怎么画K线图

首先我们找到该日或某一周期的最高和最低价，垂直地连成一条直线；然后再找出当日或某一周期的开市和收市价，把这二个价位连接成一条狭长的长方柱体。假如当日或某一周期的收市价较开市价为高（即低开高收），我们便以红色来表示，或是在柱体上留白，这种柱体就称之为"阳线"。如果当日或某一周期的收市价较开市价为低（即高开低收），我们则以绿色表示，又或是在柱上涂黑色，这柱体就是"阴线"了。

分时图是大盘和个股的实时（即时）分时走向图，其在实战研判中的地位极其重要，是即时把握多空力量转化即市场变化直接的根本所在。

K线图分类：

分时K线图，分时K线图实际上就是一个折线图

标准K线图，一般画成阴阳烛的样式

1、折线图画法

计算坐标

先计算出单位数值所占的Y轴的高度：diviceHeight =  SizeHeight／（MaxNumber－MinNumber）

计算出当前Y轴的坐标：总高度减去当前值所占的高度currentY = Height -   (nowNumber *diviceHeight);

开始画图

重写drawRect方法

- (void)drawRect:(CGRect)rect {

if (self.pointsArray) {

//画连接线

CGContextRef context = UIGraphicsGetCurrentContext();//获取绘图上下文

CGContextSetLineWidth(context, _lineWidth);//设置线宽

CGContextSetShouldAntialias(context, YES);//设置反锯齿边缘

UIColor *color = _lineColor?_lineColor:_defaultColor;

CGContextSetStrokeColorWithColor(context, [color CGColor]);//设置线的颜色

//定义多个点，画多点连线

for (id item in self.pointsArray) {

CGPoint currentPoint = CGPointFromString(item);

if ((int)currentPoint.y<=(int)self.frame.size.height && currentPoint.y>=0) {

if ([self.pointsArray indexOfObject:item]==0) {

CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);//这个是起始点

continue;

}

CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);

CGContextStrokePath(context); //开始画线

if ([self.pointsArray indexOfObject:item]

CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);

}

}

}

}

}

2、阴阳烛图，该图需要4个坐标点，开盘，关盘，最大值，最小值

计算坐标

坐标计算方法同折线图

画图

首先，要确定线的颜色，收盘值－开盘值>0红线，收盘值－开盘值<0绿线，开盘值-收盘值=0白线；

第二，在最高值和次高值之间画一条线（线宽是阴线的宽度）

第三，在开盘值和收盘值之间画一条宽线（烛线宽，画线时不绘制端点）

第四，特殊情况，开盘值、收盘值、最高值和最低值都相等的，绘制的是横线，线宽是1，线长是烛线宽，绘制起始点是（oldX-（烛线宽／2），oldY），结束（oldX-（烛线宽／2），oldY）

#pragma mark画一根K线

-(void)drawKWithContext:(CGContextRef)context height:(CGPoint)heightPoint Low:(CGPoint)lowPoint open:(CGPoint)openPoint close:(CGPoint)closePoint width:(CGFloat)width{

CGContextSetShouldAntialias(context, NO);

//首先判断是绿的还是红的，根据开盘价和收盘价的坐标来计算

BOOL isKong = NO;

UIColor *color = [UIColor colorWithHexString:@"#FF0000"withAlpha:1];//设置默认红色

//如果开盘价坐标在收盘价坐标上方则为绿色即空

if (openPoint.y

isKong = YES;

color = [UIColor colorWithHexString:@"#00FFFF"withAlpha:1];//设置为绿色

}

//设置颜色

CGContextSetStrokeColorWithColor(context, [color CGColor]);

//首先画一个垂直的线包含上影线和下影线

//定义两个点画两点连线

CGContextSetLineWidth(context, KLineWidth);

const CGPoint points[] = {heightPoint,lowPoint};

CGContextStrokeLineSegments(context, points, 2);//绘制线段（默认不绘制端点）

//再画中间的实体

CGFloat halfWidth = 0;

//纠正实体的中心点为当前坐标

openPoint = CGPointMake(openPoint.x-halfWidth, openPoint.y);

closePoint = CGPointMake(closePoint.x-halfWidth, closePoint.y);

//开始画实体

CGContextSetLineWidth(context, width); //改变线的宽度

const CGPoint point[] = {openPoint,closePoint};

CGContextStrokeLineSegments(context, point, 2);//绘制线段（默认不绘制端点）

//CGContextSetLineCap(context, kCGLineCapSquare) ;//设置线段的端点形状，方形

//开盘价格和收盘价格一样，画一条横线

if ((openPoint.y-closePoint.y<=1) && (closePoint.y-openPoint.y<=1) ) {

//这里设置开盘价和收盘价一样时候的颜色CGContextSetStrokeColorWithColor(context, [color CGColor]);

CGPoint pointLeft = CGPointMake(openPoint.x-KCandleWidth/2, openPoint.y);

CGPoint pointRight = CGPointMake(openPoint.x+KCandleWidth/2, openPoint.y);

CGContextSetLineWidth(context, 1); //改变线的宽度

const CGPoint point[] = {pointLeft,pointRight};

CGContextStrokeLineSegments(context, point, 2);//绘制线段（默认不绘制端点）

}

}

最后，上代码K线图demo

作者：夏天的风_song
链接：https://www.jianshu.com/p/7ca9048afa5b
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

49、iOS 事件响应机制 https://blog.csdn.net/yongyinmg/article/details/19616527
1、为什么触摸事件是由Application产生，然后分发，而不是直接触摸谁，谁响应？
2、事件冲突是怎么产生的，能否复现？
3、通过Application的层级可以找到当前在终端显示的view，那么自己可否也通过代码实现？

问题1
因为UIApplication 是当前app的最底层，默认的第一响应者， 所以由UIApplication进行事件分发。
UIView,UIViewController继承自UIResponder，会沿着事件响应条向上传递，即是指向它的父容器传递,即nextResponder

问题2
同一手势，如点击事件，在父uiview和子uiview中都有实现，就会出现冲突

问题3
-(UIViewController *)getCurrentViewController{
  UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;//拿到根vc
  if([vc isKindOfClass:[UINavigationController class]]){
      UINavigationController *nav = (UINavigationController *)vc;
      if(nav.viewControllers count>1){
         return [nav.viewControllers lastObject];
      }else{
          return (id)nav;
      }
   }else if([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabVC = (UITabBarController *)vc;//tabbarControl
        UIViewController *selectVC = tabVC.viewControllers[tabVC.selectedIndex];//tabbarcontrol通过selectedindex得到UINavigationControll
        UINavigationController *nav = (UINavigationController *)selectVC;
        if([nav.viewControllers count]>1){//UINavigationController管理控制器，栈的方式，里面包含多个控制器
          return [nav.viewControllers lastObject];
        }else{
          return (id)nav;
      }
   }else{
          return (id)vc;
      }
}

UITouch对象 手指相关联 包括的属性触摸的位置、时间、阶段， 当手指离开屏幕时，系统会销毁相应的UITouch对象

属性：
@property(nonatomic,readonly,retain) UIWindow  *window; 获取触摸产生时所处的窗口
@property(nonatomic,readonly,retain) UIView  *view; 获取触摸产生时所处的视图
@property(nonatomic,readonly) NSUInteger tapCount; 获取短时间内点按屏幕的次数，可以根据tapCount判断单击、双击或更多的点击
@property(nonatomic,readonly) NSTimeInterval timestamp; 获取触摸事件产生或变化时的时间，单位是秒
@property(nonatomic,readonly) UITouchPhase  phase; 获取当前触摸事件所处的状态,是刚开始还是结束还是取消
UITouchPhase 枚举：
UITouchPhaseBegan 开始触摸
UITouchPhaseMoved 移动
UITouchPhaseStationary 停留
UITouchPhaseEnded 触摸结束
UITouchPhaseCancelled 触摸中断
@property(nonatomic,readonly) UITouchType type;触摸类型
UITouchType 枚举：
UITouchTypeDirect 垂直的触摸类型
UITouchTypeIndirect 非垂直的触摸类型
UITouchTypeStylus 水平的触摸类型
@property(nonatomic,readonly) CGFloat majorRadius; 获取手指与屏幕的接触半径
@property(nonatomic,readonly) CGFloat majorRadiusTolerance;  获取手指与屏幕的接触半径的误差
@property(nullable,nonatomic,readonly,copy)   NSArray <UIGestureRecognizer *> *gestureRecognizers;  获取触摸手势
@property(nonatomic,readonly) CGFloat force;  获取触摸压力值，一般的压力感应值为1.0
@property(nonatomic,readonly) CGFloat maximumPossibleForce;  获取最大触摸压力值

方法：
返回以点击的这个uiview为00坐标触摸的位置，传view为nil时，返回的是触摸点在UIWindow的位置
- (CGPoint)locationInView:(nullable UIView *)view;

返回前一个触摸点的位置
- (CGPoint)previousLocationInView:(nullable UIView *)view;

当前触摸对象的坐标
- (CGPoint)preciseLocationInView:(nullable UIView *)view;

event  是触摸，加速，远程，还是按压事件
@property(nonatomic,readonly) UIEventType type; 获取事件类型
UIEventType枚举：
UIEventTypeTouches 触摸事件
UIEventTypeMotion 加速事件
UIEventTypeRemoteControl 远程控制事件
UIEventTypePresses 按压事件

获取远程控制事件
@property(nonatomic,readonly) UIEventSubtype  subtype;
UIEventSubtype 枚举：
// 不包含任何子事件类型
UIEventSubtypeNone                              = 0,
// 摇晃事件（从iOS3.0开始支持此事件）
UIEventSubtypeMotionShake                       = 1,
//远程控制子事件类型（从iOS4.0开始支持远程控制事件）
//播放事件【操作：停止状态下，按耳机线控中间按钮一下】
UIEventSubtypeRemoteControlPlay                 = 100,
//暂停事件
UIEventSubtypeRemoteControlPause                = 101,
//停止事件
UIEventSubtypeRemoteControlStop                 = 102,
//播放或暂停切换【操作：播放或暂停状态下，按耳机线控中间按钮一下】
UIEventSubtypeRemoteControlTogglePlayPause      = 103,
//下一曲【操作：按耳机线控中间按钮两下】
UIEventSubtypeRemoteControlNextTrack            = 104,
//上一曲【操作：按耳机线控中间按钮三下】
UIEventSubtypeRemoteControlPreviousTrack        = 105,
//快退开始【操作：按耳机线控中间按钮三下不要松开】
UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
//快退停止【操作：按耳机线控中间按钮三下到了快退的位置松开】
UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
//快进开始【操作：按耳机线控中间按钮两下不要松开】
UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
//快进停止【操作：按耳机线控中间按钮两下到了快进的位置松开】
UIEventSubtypeRemoteControlEndSeekingForward    = 109,

@property(nonatomic,readonly) NSTimeInterval  timestamp; 获取触摸产生或变化的时间戳

方法： 
- (nullable NSSet <UITouch *> *)allTouches; 获取触摸点的集合，可以判断多点触摸事件
- (nullable NSSet <UITouch *> *)touchesForWindow:(UIWindow *)window; 获取指定窗口里的触摸点
- (nullable NSSet <UITouch *> *)touchesForView:(UIView *)view;获取指定视图里的触摸点
- (nullable NSSet <UITouch *> *)touchesForGestureRecognizer:(UIGestureRecognizer *)gesture;获取手势对象



具体说明Responder Chain(ios事件传递)

UIResponder是所有responder对象的基类，包括触摸事件(Touch Event)，、运动事件(Motion Event加速计事件)和远程控制事件(Remote-Control Events摇控器控制)的编程接口

处理触摸事件(Touch Event)
– touchesBegan:withEvent: 触摸开始事件
– touchesMoved:withEvent: 触摸移动事件
– touchesEnded:withEvent: 触摸终止事件
– touchesCancelled:withEvent: 触摸跟踪取消事件
- (void)touchesEstimatedPropertiesUpdated:(NSSet * _Nonnull)touches 3D触摸事件


加速计事件

- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event; 开始加速
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event; 结束加速
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event; 加速中断

远程控制事件
- (void)remoteControlReceivedWithEvent:(nullable UIEvent *)event;


触摸事件 总是由屏幕顶部向它的父容器传递
 UIViewController,UIView，和所有继承自UIView的UIKit类(包括UIWindow,继承自UIView)都直接或间接的继承自UIResponder,
 它们都是responder object对象，都实现了上述4个方法。UIResponder中的默认实现是什么都不做，但子类会沿着responder chain继续向上
 传递到下一个responder,即nextResponder。即向父类传递，需要调用[super touchesBegan:touches withEvent:event];
 如果子类没有实现touch	方法，事件也会向它的父容器传递
 
 传递规则
 UIView的nextResponder属性，如果有管理此view的UIViewController对象，则为此UIViewController对象；否则nextResponder即为其superview。
UIViewController的nextResponder属性为其管理view的superview.
UIWindow的nextResponder属性为UIApplication对象。
UIApplication的nextResponder属性为nil。

如何间接的得到一个uiview的控制器
@implementation UIView (ParentController)
-(UIViewController*)parentController{
    UIResponder *responder = [self nextResponder];
    while (responder) {
	if ([responder isKindOfClass:[UIViewController class]]) {
		return (UIViewController*)responder;
	}
	responder = [responder nextResponder];
    }
    return nil;
}
@end


Gesture Recognizers 势识别器对象
包括点击、双指缩放、拖拽、滑动、旋转以及长按
每一个Gesture Recognizer关联一个View，但是一个View可以关联多个Gesture Recognizer，
First Responder就是UIApplication,

第一响应者 (The First Responder)
　　什么是第一响应者？简单的讲，第一响应者是一个UIWindow对象接收到一个事件后，第一个来响应的该事件的对象。
注意：这个第一响应者与触摸检测到的第一个响应的UIView并不是一个概念。第一响应者一般情况下用于处理非触摸事件
（手机摇晃、耳机线控的远程空间）或非本窗口的触摸事件（键盘触摸事件），通俗点讲其实就是管别人闲事的响应者。在IOS中，当然管闲事并不是所有控件都愿意的，
这么说好像并不是很好理解，或着是站在编程人员的角度来看待这个问题，程序员负责告诉系统哪个对象可以成为第一响应者(canBecomeFirstResponder)，
如果方法canBecomeFirstResponder返回YES，这个响应者对象才有资格称为第一响应者。有资格并不代表一定可以成为第一响应者，
还要becomeFirstResponder正式成为第一响应者。同时也有对应的canResignFirstResponder和resignFirstResponder是否可以解除第一响应者。

值得注意的是，一个UIWindow对象在某一时刻只能有一个响应者对象可以成为第一响应者。我们可以通过isFirstResponder来判断某一个对象是否为第一响应者。

UIApplication-UIWindow 处理非触摸的一些闲事

响应链大概有以下几个步骤

设备将touch到的UITouch和UIEvent对象打包, 放到当前活动的Application的事件队列中
单例的UIApplication会从事件队列中取出触摸事件并传递给单例UIWindow
UIWindow使用hitTest:withEvent:方法查找touch操作的所在的视图view
RunLoop这边我大概讲一下

主线程的RunLoop被唤醒
通知Observer，处理Timer和Source 0
Springboard接受touch event之后转给App进程中
RunLoop处理Source 1，Source1 就会触发回调，并调用_UIApplicationHandleEventQueue() 进行应用内部的分发。
RunLoop处理完毕进入睡眠，此前会释放旧的autorelease pool并新建一个autorelease pool

作者：故胤道长
链接：https://www.jianshu.com/p/c687110e552c
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

50、ios动画
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


51、在一个HTTPS连接的网站里，输入账号密码点击登录后，到服务器返回这个请求前，中间经历了什么

客户端打包请求。包括url，端口啊，你的账号密码等等。账号密码登陆应该用的是Post方式，所以相关的用户信息会被加载到body里面。
这个请求应该包含三个方面：网络地址，协议，资源路径。注意，这里是HTTPS，就是HTTP + SSL / TLS，在HTTP上又加了一层处理加密信息的模块（相当于是个锁）。
这个过程相当于是客户端请求钥匙。

服务器接受请求。一般客户端的请求会先发送到DNS服务器。 DNS服务器负责将你的网络地址解析成IP地址，这个IP地址对应网上一台机器。这其中可能发生Hosts Hijack和ISP failure的问题。过了DNS这一关，信息就到了服务器端，此时客户端会和服务器的端口之间建立一个socket连接，socket一般都是以file descriptor的方式解析请求。这个过程相当于是服务器端分析是否要向客户端发送钥匙模板。

服务器端返回数字证书。服务器端会有一套数字证书（相当于是个钥匙模板），这个证书会先发送给客户端。这个过程相当于是服务器端向客户端发送钥匙模板。

客户端生成加密信息。根据收到的数字证书（钥匙模板），客户端会生成钥匙，并把内容锁上，此时信息已经加密。这个过程相当于客户端生成钥匙并锁上请求。

客户端发送加密信息。服务器端会收到由自己发送出去的数字证书加锁的信息。 这个时候生成的钥匙也一并被发送到服务器端。这个过程是相当于客户端发送请求。

服务器端解锁加密信息。服务器端收到加密信息后，会根据得到的钥匙进行解密，并把要返回的数据进行对称加密。这个过程相当于服务器端解锁请求、生成、加锁回应信息。

服务器端向客户端返回信息。客户端会收到相应的加密信息。这个过程相当于服务器端向客户端发送回应。

客户端解锁返回信息。客户端会用刚刚生成的钥匙进行解密，将内容显示在浏览器上。

HTTPS加密过程详解请去https原理：证书传递、验证和数据加密、解密过程解析

客户端请求，服务器先返回数字证书，相当于给客户端钥匙，客户端拿到钥匙，为内容上锁，同时生成新的钥匙，一起发给服务器，服务器会根据这个钥匙解密，并把返回的内容
再通过这钥匙加密，再给客户端，客户端再用刚刚生成的钥匙解密内容

作者：故胤道长
链接：https://www.jianshu.com/p/c687110e552c
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


52、在一个app中间有一个button，在你手触摸屏幕点击后，到这个button收到点击事件，中间发生了什么

响应链大概有以下几个步骤

设备将touch到的UITouch和UIEvent对象打包, 放到当前活动的Application的事件队列中
单例的UIApplication会从事件队列中取出触摸事件并传递给单例UIWindow
UIWindow使用hitTest:withEvent:方法查找touch操作的所在的视图view
RunLoop这边我大概讲一下

主线程的RunLoop被唤醒
通知Observer，处理Timer和Source 0
Springboard接受touch event之后转给App进程中
RunLoop处理Source 1，Source1 就会触发回调，并调用_UIApplicationHandleEventQueue() 进行应用内部的分发。
RunLoop处理完毕进入睡眠，此前会释放旧的autorelease pool并新建一个autorelease pool

作者：故胤道长
链接：https://www.jianshu.com/p/c687110e552c
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

53、介绍一下观察者模式

观察者模式(Observer Pattern)：定义对象间的一种一对多依赖关系，使得每当一个对象状态发生改变时，其相关依赖对象皆得到通知并被自动更新。
在IOS中典型的推模型实现方式为NSNotificationCenter和KVO。
观察者Observer，通过NSNotificationCenter的addObserver:selector:name:object接口来注册对某一类型通知感兴趣。在注册时候一定要注意，NSNotificationCenter不会对观察者进行引用计数+1的操作，我们在程序中释放观察者的时候，一定要去报从center中将其注销了。
通知中心NSNotificationCenter，通知的枢纽。
被观察的对象，通过postNotificationName:object:userInfo:发送某一类型通知，广播改变。
通知对象NSNotification，当有通知来的时候，Center会调用观察者注册的接口来广播通知，同时传递存储着更改内容的NSNotification对象。
KVO

KVO的全称是Key-Value Observer，即键值观察。是一种没有中心枢纽的观察者模式的实现方式。一个主题对象管理所有依赖于它的观察者对象，并且在自身状态发生改变的时候主动通知观察者对象。

注册观察者
[object addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:]。
更改主题对象属性的值，即触发发送更改的通知。
在制定的回调函数中，处理收到的更改通知。
注销观察者 [object removeObserver:self forKeyPath:property]。

作者：故胤道长
链接：https://www.jianshu.com/p/c687110e552c
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

53、锁
@synchronized是性能最差的
@synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁，所以性能差一些
使用的obj为该锁的唯一标识，只有当标识相同时，才为满足互斥
NSObject *obj = [[NSObject alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(3);
            NSLog(@"需要线程同步的操作1 结束");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作2");
        }
    });
2018-05-24 13:27:07.223750+0800 222[255:5247931] 需要线程同步的操作1 开始
2018-05-24 13:27:10.224576+0800 222[255:5247931] 需要线程同步的操作1 结束
2018-05-24 13:27:10.224880+0800 222[255:5247934] 需要线程同步的操作2

dispatch_semaphore 信号量
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

如果把超时时间设置为<2s的时候，执行的结果就是：

2016-06-30 18:53:24.049 SafeMultiThread[30834:434334] 需要线程同步的操作1 开始
2016-06-30 18:53:25.554 SafeMultiThread[30834:434332] 需要线程同步的操作2
2016-06-30 18:53:26.054 SafeMultiThread[30834:434334] 需要线程同步的操作1 结束


dispatch_semaphore是GCD用来同步的一种方式，与他相关的共有三个函数，
分别是dispatch_semaphore_create，dispatch_semaphore_signal，dispatch_semaphore_wait。
dispatch_semaphore_create 创建一个信号量，数值可自己填写
dispatch_semaphore_signal 信号量+1
dispatch_semaphore_wait  信号量-1  信号量为0会阻塞当前线程

NSLock 互斥锁
lock和unlock加锁，解锁，当线程未能加上锁时会休眠，当解锁时线程补唤醒再去获取锁
tryLock 试图加锁，加锁不成功返回no，成功返回yes，不会阻塞
if ([lock tryLock]) {//尝试获取锁，如果获取不到返回NO，不会阻塞该线程
            NSLog(@"锁可用的操作");
            [lock unlock];
        }else{
            NSLog(@"锁不可用的操作");
        }
lockBeforeDate 
NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:3];
        if ([lock lockBeforeDate:date]) {//尝试在未来的3s内获加锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else{
            NSLog(@"超时，没有获得锁");
        }

demo:
        NSLock *lock = [[NSLock alloc] init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //[lock lock];
            [lock lockBeforeDate:[NSDate date]];
            NSLog(@"需要线程同步的操作1 开始");
            sleep(2);
            NSLog(@"需要线程同步的操作1 结束");
            [lock unlock];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(1);
            if ([lock tryLock]) {//尝试获取锁，如果获取不到返回NO，不会阻塞该线程
                NSLog(@"锁可用的操作");
                [lock unlock];
            }else{
                NSLog(@"锁不可用的操作");
            }
            
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:3];
            if ([lock lockBeforeDate:date]) {//尝试在未来的3s内获取锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
                NSLog(@"没有超时，获得锁");
                [lock unlock];
            }else{
                NSLog(@"超时，没有获得锁");
            }
            
        });
        
2018-05-24 14:03:48.449916+0800 222[2681:5314260] 需要线程同步的操作1 开始
2018-05-24 14:03:49.454159+0800 222[2681:5314261] 锁不可用的操作
2018-05-24 14:03:50.451897+0800 222[2681:5314260] 需要线程同步的操作1 结束
2018-05-24 14:03:50.451998+0800 222[2681:5314261] 没有超时，获得锁


NSConditionLock 条件锁
@interface NSConditionLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER;

@property (readonly) NSInteger condition;
- (void)lockWhenCondition:(NSInteger)condition;
- (BOOL)tryLock;
- (BOOL)tryLockWhenCondition:(NSInteger)condition;
- (void)unlockWithCondition:(NSInteger)condition;
- (BOOL)lockBeforeDate:(NSDate *)limit;
- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end
NSConditionLock 和 NSLock 类似，都遵循 NSLocking 协议，方法都类似，只是多了一个 condition 属性，
每个操作都多了一个关于 condition 属性的方法，例如 tryLock，tryLockWhenCondition:，NSConditionLock 可以称为条件锁，
只有 condition 参数与初始化时候的 condition 相等，lock 才能正确进行加锁操作。
unlockWithCondition: 并不是当 Condition 符合条件时才解锁，而是解锁之后，修改 Condition 的值，这个结论可以从下面的例子中得出。
//主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:1];//锁值为1时加锁
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:0]) {//锁值为0时加锁
            NSLog(@"线程2");
            [lock unlockWithCondition:2];//解锁后设置锁值为2
            NSLog(@"线程2解锁成功");
        } else {
            NSLog(@"线程2尝试加锁失败");
        }
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {//锁值为2时加锁
            NSLog(@"线程3");
            [lock unlock];//解锁
            NSLog(@"线程3解锁成功");
        } else {
            NSLog(@"线程3尝试加锁失败");
        }
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {//锁值为2时加锁
            NSLog(@"线程4");
            [lock unlockWithCondition:1];  //解锁后设置锁值为2  
            NSLog(@"线程4解锁成功");
        } else {
            NSLog(@"线程4尝试加锁失败");
        }
    });
    
2016-08-19 13:51:15.353 ThreadLockControlDemo[1614:110697] 线程2
2016-08-19 13:51:15.354 ThreadLockControlDemo[1614:110697] 线程2解锁成功
2016-08-19 13:51:16.353 ThreadLockControlDemo[1614:110689] 线程3
2016-08-19 13:51:16.353 ThreadLockControlDemo[1614:110689] 线程3解锁成功
2016-08-19 13:51:17.354 ThreadLockControlDemo[1614:110884] 线程4
2016-08-19 13:51:17.355 ThreadLockControlDemo[1614:110884] 线程4解锁成功
2016-08-19 13:51:17.355 ThreadLockControlDemo[1614:110884] 线程1

递归锁

demo1:会闪退  普通锁在同一个线程不能多次加锁
        //普通线程锁
        NSLock *lock = [[NSLock alloc] init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            static void (^block)(int);
            block = ^(int value) {
                //加锁
                [lock lock];
                if (value > 0) {
                    NSLog(@"%d",value);
                    sleep(2);
                    //递归调用
                    block(--value);
                }
                //解锁
                [lock unlock];
            };
            //调用代码块
            block(10);
        });
        
demo2：递归锁 它允许同一线程多次加锁，而不会造成死锁

//递归锁
NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
static void (^block)(int);
block = ^(int value) {
//加锁
[lock lock];
if (value > 0) {
NSLog(@"%d",value);
sleep(2);
//递归调用
block(--value);
}
//解锁
[lock unlock];
};
//调用代码块
block(10);
});


NSCondition  

@interface NSCondition : NSObject <NSLocking> {
@private
    void *_priv;
}

- (void)wait;
- (BOOL)waitUntilDate:(NSDate *)limit;
- (void)signal;
- (void)broadcast;

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end
对象实际上作为一个锁和一个线程检查器,和NSLock很像，只是多了一个[lock wait];，这个会阻塞当前的线程，- (BOOL)waitUntilDate:(NSDate *)limit;
设置3秒阻塞，阻塞3秒结束后继续执行。signal 再次发送一个信号，则阻塞的那个条件while继续会执行一次
    while (!array.count) {
        [lock wait];
     }
NSCondition *lock = [[NSCondition alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        while (!array.count) {
            [lock wait];
        }
        [array removeAllObjects];
        NSLog(@"array removeAllObjects");
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [lock lock];
        [array addObject:@1];
        NSLog(@"array addObject:@1");
        [lock signal];
        [lock unlock];
    });

OSSpinLock


是一种自旋锁，也只有加锁，解锁，尝试加锁三个方法
NSLock 请求加锁失败的话，会先轮询，但一秒过后便会使线程进入 waiting 状态，等待唤醒
OSSpinLock 会一直轮询，等待时会消耗大量 CPU 资源，不适用于较长时间的任务。

typedef int32_t OSSpinLock;

bool    OSSpinLockTry( volatile OSSpinLock *__lock );

void    OSSpinLockLock( volatile OSSpinLock *__lock );

void    OSSpinLockUnlock( volatile OSSpinLock *__lock );

#import <libkern/OSSpinLockDeprecated.h>
__block OSSpinLock theLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        NSLog(@"线程1");
        sleep(10);
        OSSpinLockUnlock(&theLock);
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        OSSpinLockLock(&theLock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&theLock);
    });

2016-08-19 20:25:13.526 ThreadLockControlDemo[2856:316247] 线程1
2016-08-19 20:25:23.528 ThreadLockControlDemo[2856:316247] 线程1解锁成功
2016-08-19 20:25:23.529 ThreadLockControlDemo[2856:316260] 线程2

pthread_mutex
 C 语言下多线程锁的方式 
 C语言下的NSLock实现
 static pthread_mutex_t theLock;

- (void)example5 {
    pthread_mutex_init(&theLock, NULL);
    
    pthread_t thread;
    pthread_create(&thread, NULL, threadMethord1, NULL);
    
    pthread_t thread2;
    pthread_create(&thread2, NULL, threadMethord2, NULL);
}

void *threadMethord1() {
    pthread_mutex_lock(&theLock);
    printf("线程1\n");
    sleep(2);
    pthread_mutex_unlock(&theLock);
    printf("线程1解锁成功\n");
    return 0;
}

void *threadMethord2() {
    sleep(1);
    pthread_mutex_lock(&theLock);
    printf("线程2\n");
    pthread_mutex_unlock(&theLock);
    return 0;
}

线程1
线程1解锁成功
线程2

int pthread_mutex_init(pthread_mutex_t * __restrict, const pthread_mutexattr_t * __restrict);
这个初始化锁能生成几种不同的类型，共4种类型
PTHREAD_MUTEX_NORMAL 缺省类型，也就是普通锁。当一个线程加锁以后，其余请求锁的线程将形成一个等待队列，并在解锁后先进先出原则获得锁。

PTHREAD_MUTEX_ERRORCHECK 检错锁，如果同一个线程请求同一个锁，则返回 EDEADLK，否则与普通锁类型动作相同。这样就保证当不允许多次加锁时不会出现嵌套情况下的死锁。

PTHREAD_MUTEX_RECURSIVE 递归锁，允许同一个线程对同一个锁成功获得多次，并通过多次 unlock 解锁。

PTHREAD_MUTEX_DEFAULT 适应锁，动作最简单的锁类型，仅等待解锁后重新竞争，没有等待队列。

代码就设置锁为递归锁。实现和 NSRecursiveLock 类似的效果。
- (void)example5 {
    pthread_mutex_init(&theLock, NULL);
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&theLock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    pthread_t thread;
    pthread_create(&thread, NULL, threadMethord, 5);

}

void *threadMethord(int value) {
    pthread_mutex_lock(&theLock);
    
    if (value > 0) {
        printf("Value:%i\n", value);
        sleep(1);
        threadMethord(value - 1);
    }
    pthread_mutex_unlock(&theLock);
    return 0;
}

Value:5
Value:4
Value:3
Value:2
Value:1
回到 pthread_mutex，锁初始化完毕，就要上锁解锁了
pthread_mutex_lock(&theLock);
pthread_mutex_unlock(&theLock);
和 NSLock 的 lock unlock 用法一致，但还注意到有一个 pthread_mutex_trylock 方法，pthread_mutex_trylock 和 tryLock 的区别在于，tryLock 返回的是 YES 和 NO，pthread_mutex_trylock 加锁成功返回的是 0，失败返回的是错误提示码。


54、简单粗暴系列之HTTPS原理
一、开篇
  简单粗暴，本文来聊聊HTTPS。
  啥是HTTPS? 说白了就是HTTP Over SSL。HTTP呢，就是我们平时上网时，浏览器和服务器之间传输数据的一项协议。普通情况下，浏览器发送的请求会经过若干个网络中间节点，最后到达服务器；然后服务器又将请求的数据经过若干个网络中间节点发送回给浏览器，这时候浏览器就能够显示我们想要看到的页面。
  这个过程中，其实并没有存在什么太大的问题。问题出在，如果我们需要在网页上输入一些敏感信息，如我们的银行卡账号和密码，发送给服务器，就会在中间节点中存在泄漏的风险。HTTPS就是为了保障传输过程中的安全目的而生的。HTTPS保证了数据仅仅只在发送方和目的方双方可见，而对中间任一一个节点都不可见。这是怎么实现的？我们来慢慢看。

二、故事
我们首先来看一个故事：
1）流程
  有两个大师，他们需要经常交流研究心得，因此需要频繁地进行相互信件往来。在信件往来的过程中，我们假设发送方是大师A，而目的方是大师B。A想告诉B一些研究的最新成果，于是将相关的研究成果写成了一封信，从邮局邮寄给B。这封信通过邮局的若干个快递员，最终到达了B的手里。这样就形成了一个最典型的数据传输过程。

2）加密、解密、密钥、加密算法
  现在，大师A觉得，我写的这封信，要是哪个快递员打开看过了，我的最新研究成果不就泄漏了吗？要是这个快递员拿去卖钱我半辈子努力不就白费了？于是乎大师A就想了个办法，在书写的过程中，每个字符都加4。如字符A就写成E，字符B就写成F，以此类推。大师B收到了信件后，再把每个字符都减去4，这样就可以正确得到大师A想传递的研究成果的内容。而最重要的是，即使快递员在中间拆开信件，如果不知道4这个数字，是无法正确的到信件内容的。
  我们将大师A每个字符加4的过程，叫做“加密”；大师B每个字符减4的过程，叫做“解密”；而数字4，就是我们常说的密钥。而这种加密算法，名为凯撒算法。

3）证书
  就这样，平安地度过了一段时间，直到突然有一天大师B收到一封来自于大师A的信，但是大师B使用之前的方式怎么也明白不了大师A说的是什么。于是电话询问大师A关于这封信的内容。结果大师A说，这不是我写的啊。这才发现，大师B收到的是一封伪造大师A的来信。为防止以上事情再次发生，大师A与大师B商量说，以后每封信上，我都会签上自己特有的签名，并带上相关内容的HASH值。
  HASH值用来校验这封信是否有被篡改过，而签名类似于指纹，用来标示这封信是否真实来自于指纹上所指向的人。一般来说，签名的内容中会包含这封信的发件方地址等信息。大师B收到信件后第一时间通过内容的HASH值来校验信件的内容长度；通过签名来校验发件方地址和指纹信息是否匹配。只有全部匹配才继续用之前的密钥进行解密操作。
  这些标明了大师A身份信息等信息的签名，就是我们常说的证书。
  经过以上的故事，我们大致明白了密钥、加密解密、算法等必要的知识了。而HTTPS的过程其实和这个类似，只不过多了一些数学的描述。

三、HTTPS工作原理
  HTTPS工作在客户端和服务器端之间。以上故事中，客户端可以看作为大师A，服务器端可以看作为大师B。客户端和服务器本身都会自带一些加密的算法，用于双方协商加密的选择项。
1、客户端首先会将自己支持的加密算法，打个包告诉服务器端。
2、服务器端从客户端发来的加密算法中，选出一组加密算法和HASH算法（注，HASH也属于加密），并将自己的身份信息以证书的形式发回给客户端。而证书中包含了网站的地址，加密用的公钥，以及证书的颁发机构等；
  这里有提到公钥的概念是故事中没有的。我们常见的加密算法一般是一些对称的算法，如凯撒加密；对称算法即加密用的密钥和解密用的密钥是一个。如故事中的密钥是4。还有一种加密解密算法称之为非对称算法。这种算法加密用的密钥（公钥）和解密用的密钥（私钥）是两个不同的密钥；通过公钥加密的内容一定要使用私钥才能够解密。
  这里，服务器就将自己用来加密用的公钥一同发还给客户端，而私钥则服务器保存着，用户解密客户端加密过后的内容。

3、客户端收到了服务器发来的数据包后，会做这么几件事情：
 1）验证一下证书是否合法。一般来说，证书是用来标示一个站点是否合法的标志。如果说该证书由权威的第三方颁发和签名的，则说明证书合法。
 2）如果证书合法，或者客户端接受和信任了不合法的证书，则客户端就会随机产生一串序列号，使用服务器发来的公钥进行加密。这时候，一条返回的消息就基本就绪。
 3）最后使用服务器挑选的HASH算法，将刚才的消息使用刚才的随机数进行加密，生成相应的消息校验值，与刚才的消息一同发还给服务器。

4、服务器接受到客户端发来的消息后，会做这么几件事情：
 1）使用私钥解密上面第2）中公钥加密的消息，得到客户端产生的随机序列号。
 2）使用该随机序列号，对该消息进行加密，验证的到的校验值是否与客户端发来的一致。如果一致则说明消息未被篡改，可以信任。
 3）最后，使用该随机序列号，加上之前第2步中选择的加密算法，加密一段握手消息，发还给客户端。同时HASH值也带上。

5、客户端收到服务器端的消息后，接着做这么几件事情：
 1）计算HASH值是否与发回的消息一致
 2）检查消息是否为握手消息

6、握手结束后，客户端和服务器端使用握手阶段产生的随机数以及挑选出来的算法进行对称加解密的传输。
  为什么不直接全程使用非对称加密算法进行数据传输？这个问题的答案是因为非对称算法的效率对比起对称算法来说，要低得多得多；因此往往只用在HTTPS的握手阶段。
  以下是我们一些经常使用的加密算法，是不是有熟悉的味道？
   非对称加密算法：RSA, DSA/DSS
   对称加密算法： AES, 3DES
   HASH算法：MD5, SHA1, SHA256

这就是HTTPS的基本原理，如果没有简单粗暴，请告诉我，以帮助我持续改进；如果真的简单粗暴，请告诉有需要的人，大家共同进步。

hash检验，如md5 等签名算法

55、理解面向 HTTP API 的 REST 和 RPC
rest CRUD (create, read, update, delete)  操作 GET,POST,PUT,DELETE,OPTIONS

rpc post get
RPC 会这样做：
POST /SendUserMessage HTTP/1.1
Host: api.example.com
Content-Type: application/json
{"userId": 501, "message": "Hello!"}

REST 方法中，做同样的事情会这样：
POST /users/501/messages HTTP/1.1
Host: api.example.com
Content-Type: application/json
{"message": "Hello!"}

使用 REST API，你已经拥有 GET /trips 和 POST /trips，然后很多人会尝试使用有点像下面这些动作的节点：

POST /trips/123/start

POST /trips/123/finish

POST /trips/123/cancel

URL区别：RPC 方法 POST /startTrip 或者像 REST 的 POST /trips/123/start 节


55、Swift中enum、struct、class三者异同

关于枚举、结构体的介绍这里仅仅是冰山一角，他们还有更加丰富的功能需要读者在阅读完本文后深入学习。了解这些基础内容，可以帮助我们在Swift开发中更熟练的使用他们。这里根据官方文档介绍结合自己的理解简单的做一下总结：

枚举、结构体、类的共同点：  
1，定义属性和方法；
2，下标语法访问值；
3，初始化器；
4，支持扩展增加功能；
5，可以遵循协议；

类特有的功能：
1，继承；
2，允许类型转换；
3，析构方法释放资源；
4，引用计数；

枚举用来作一些常数，多选项的常数  值类型
结构体不能继承，可以把一些部份功能交给结构体 值类型，默认有初始化列表方法，自定义初始化方法后原init方法失效
类，可继承，引用类型，有引用计数，有析构方法

类是引用类型
引用类型(reference types，通常是类)被复制的时候其实复制的是一份引用，两份引用指向同一个对象。所以在修改一个实例的数据时副本的数据也被修改了(s1、s2)。

枚举，结构体是值类型
值类型(value types)的每一个实例都有一份属于自己的数据，在复制时修改一个实例的数据并不影响副本的数据(p1、p2)。值类型和引用类型是这三兄弟最本质的区别。

我该如何选择
关于在新建一个类型时如何选择到底是使用值类型还是引用类型的问题其实在理解了两者之间的区别后是非常简单的，在这苹果官方已经做出了非常明确的指示（以下内容引自苹果官方文档）：

当你使用Cocoa框架的时候，很多API都要通过NSObject的子类使用，所以这>时候必须要用到引用类型class。在其他情况下，有下面几个准则：

什么时候该用值类型：
要用==运算符来比较实例的数据时
你希望那个实例的拷贝能保持独立的状态时
数据会被多个线程使用时
什么时候该用引用类型（class）：
要用==运算符来比较实例身份的时候
你希望有创建一个共享的、可变对象的时候
文章最后

以上就是本人前段时间学习心得，示例代码在Swift3.0语法下都是编译通过的，知识点比较少，部分描述引自官方的文档。如果文中有任何纰漏或错误欢迎在评论区留言指出，本人将在第一时间修改过来；喜欢我的文章，可以关注我以此促进交流学习； 如果觉得此文戳中了你的G点请随手点赞；转载请注明出处，谢谢支持。

作者：老板娘来盘一血
链接：https://www.jianshu.com/p/78a6a4941516
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


56、block与代理的对比，双方的优缺点及在什么样的环境下，优先使用哪一种更为合适？
两者都是一种回调方式，block更轻型，一般类似于两个方法用block比较好，比如网络类
，如果就成功，失败，用block，如果成功，失败，进度，https验证，delegate比较好
block高内聚，能够直接访问上下文，block容易引起循环引用，
代理通常被 weak 引用，不会出现内存泄漏的问题；
代理需要建协议，实现接口，把它的方法分离开来

通知

： 一对一  一对多  传值

四个步骤: 
 1.发送通知
2.创建监听者
3.接收通知
4.移除监听者
 使用场景:
1- 很多控制器都需要知道一个事件，应该用通知；
2 - 相隔多层的两个控制器之间跳转


代理

“一对一”，对同一个协议，一个代理对象只能设置一个代理delegate


六个步骤:
1.声明一个协议,定义代理方法
2. 遵循协议
3.设置一个代理对象
4.调用代理方法
5.给代理赋值
6.实现代理方法

注意事项:

1,单例对象不能用代理；
2,代理执行协议方法时要使用 respondsToSelector检查其代理是否符合协议(检查对象能否响应指定的消息),以避免代理在回调时因为没有实现方法而造成程序崩溃 

使用场景:

公共接口，方法较多也选择用delegate进行解耦 
iOS最常用tableViewDelegate，textViewDelegate 
iOS有很多例子比如常用的网络库AFNetwork，ASIHTTP库，UIAlertView类。


block

什么是Block：

Block是iOS4.0+ 和Mac OS X 10.6+ 引进的对C语言的扩展，用来实现匿名函数的特性。
Blocks语法块代码以闭包得形式将各种内容进行传递，可以是代码，可以是数组无所不能。

闭包就是能够读取其它函数内部变量的函数。就是在一段请求连续代码中可以看到调用参数（如发送请求）和响应结果。所以采用Block技术能够抽象出很多共用函数，提高了代码的可读性，可维护性，封装性。



使用场景：
一：动画
二：数据请求回调
三：枚举回调
四：多线程gcd
...

 异步和简单的回调用block更好 
BLOCK最典型的是大所周知的AFNETWORK第三方库。

注意事项:

block需要注意防止循环引用：
    ARC下这样防止：
__weak typeof(self) weakSelf = self;
  [yourBlock:^(NSArray *repeatedArray, NSArray *incompleteArray) {
       [weakSelf doSomething];
    }];

     非ARC
__block typeof(self) weakSelf = self;
  [yourBlock:^(NSArray *repeatedArray, NSArray *incompleteArray) {
       [weakSelf doSomething];
    }];

delegate 和 block对比
 
    效率：Delegate比NSNOtification高； 
 1,   Delegate和Block一般都是一对一的通信； 

 2,   Delegate需要定义协议方法，代理对象实现协议方法，并且需要建立代理关系才可以实现通信； 
      Block：Block更加简洁，不需要定义繁琐的协议方法，但通信事件比较多的话，建议使用Delegate； 

3,  delegate运行成本低。block成本很高的。
block出栈需要将使用的数据从栈内存拷贝到堆内存，当然对象的话就是加计数，使用完或者block置nil后才消除；delegate只是保存了一个对象指针，直接回调，没有额外消耗。相对C的函数指针，只多做了一个查表动作 .

4，代理更注重过程信息的传输：比如发起一个网络请求，可能想要知道此时请求是否已经开始、是否收到了数据、数据是否已经接受完成、数据接收失败
    block注重结果的传输：比如对于一个事件，只想知道成功或者失败，并不需要知道进行了多少或者额外的一些信息


5 Blocks 更清晰。比如 一个 viewController 中有多个弹窗事件，Delegate 就得对每个事件进行判断识别来源。而 Blocks 就可以在创建事件的时候区分开来了。这也是为什么现在苹果 API 中越来越多地使用 Blocks 而不是 Delegate。

      

57、KVC 与 KVO 是 Objective C 的关键概念
KVC，即是指 NSKeyValueCoding，一个非正式的 Protocol，提供一种机制来间接访问对象的属性。KVO 就是基于 KVC 实现的关键技术之一。
KVC 有两个方法：一个是设置 key 的值，另一个是获取 key 的值 ，key 可以从一个对象中获取值，而 key path 可以将多个 key 用点号 "." 分割连接起来，
[p valueForKey:@"name"];
[p setValue:newName forKey:@"name"];
[p valueForKeyPath:@"spouse.name"]; //获取到spouse是一个对象，再获取到这个对象的name

Key-Value Observing (KVO)
它能够观察一个对象的 KVC key path 值的变化。举个例子，用代码观察一个 person 对象的 address 变化，以下是实现的三个方法：
[self addObserver:self forKeyPath:@"address" options:0 context:KVO_CONTEXT_ADDRESS_CHANGED];//实现观察地address属性
observeValueForKeyPath:ofObject:change:context: 在被观察的 key path 的值变化时调用。
dealloc 停止观察

static NSString *const KVO_CONTEXT_ADDRESS_CHANGED = @"KVO_CONTEXT_ADDRESS_CHANGED"

@implementation PersonWatcher

-(void) watchPersonForChangeOfAddress:(Person *)p
{

    // this begins the observing
    [p addObserver:self
        forKeyPath:@"address"
           options:0
           context:KVO_CONTEXT_ADDRESS_CHANGED];

    // keep a record of all the people being observed,
    // because we need to stop observing them in dealloc
    [m_observedPeople addObject:p];
}

// whenever an observed key path changes, this method will be called
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context

{
    // use the context to make sure this is a change in the address,
    // because we may also be observing other things
    if(context == KVO_CONTEXT_ADDRESS_CHANGED) {
        NSString *name = [object valueForKey:@"name"];
        NSString *address = [object valueForKey:@"address"];
        NSLog(@"%@ has a new address: %@", name, address);
    }
}

-(void) dealloc;
{

    // must stop observing everything before this object is
    // deallocated, otherwise it will cause crashes
    for(Person *p in m_observedPeople){
        [p removeObserver:self forKeyPath:@"address"];
    }

    [m_observedPeople release];
    m_observedPeople = nil;

    [super dealloc];

}

-(id) init;
{
    if(self = [super init]){
        m_observedPeople = [NSMutableArray new];
    }

    return self;
}

@end

58、xmpp ,mqtt

xmpp 任何XMPP用户都可以向其他任何XMPP用户传递消息。
多个XMPP服务器也可以通过一个专门的&ldquo;服务器-服务器&rdquo;协议相互通信，提供了创建分散型社交网络和协作框架的可能性
即qq和微信可以通信
OpenFire作为服务器
XMPPFramework(三方框架)
发送的内容为xml，里面包括一定的内容文本，如果是音频，发送时先上传，成功后获取到url再发给对方
接收方，根据标志位，知道是音频，先下载再播放
如果仅是推送数据，用mqtt更好，xmpp传输xml格式是硬伤，数据量增大

mqtt在1999年，IBM发明 用到的库mqttkit
使用发布/订阅消息模式，提供一对多的消息发布，订阅就能收到服务器发的消息
使用 TCP/IP 提供网络连接
有三种消息发布服务质量：
“至多一次”，消息发布完全依赖底层 TCP/IP 网络。会发生消息丢失或重复。只发送一次
“至少一次”，确保消息到达，但消息重复可能会发生。
“只有一次”，确保消息到达一次。这一级别可用于如下情况，在计费系统中，消息重复或丢失会导致不正确的结果。
小型传输，开销很小（固定长度的头部是 2 字节），协议交换最小化，以降低网络流量；

59、推送
一种是本地推送，一种就是远程推送
本地推送（Local Notification)
1.客户端注册本地通知 
2.客户端接收通知
3.客户端处理通知中的数据

APNS之前，有这么几点需要了解：

1：APNS是免费的。只要有开发者账号便可以申请APNS证书。

2：APNS又是不可靠的，苹果对信息推送的可靠性不做任何保证。

3：APNS对消息的大小是有限制的，总容量不能超过256字节。

：用户第一次安装应用并第一次启动时，会弹出对话框提示应用需要开通推送，是否允许，如果允许，应用会得到一个硬件token。

有三点需要注意：

第一，此token唯一与设备相关，同一设备上不同应用获取的token是一样的；

第二，当应用被卸载，然后重新安装时，确认对话框不会再出现，自动继承前一次安装的设置信息；

第三，推送设置可以在设置-通知中进行更改。可以选择开启消息框、声音以及badge number中的一种或多种。

把apns证书，token交给服务器，服务器通过代码向apns发消息，apns接到消息再转发给手机
3：应用将受到的token发送到服务端，也就是APNS消息的源头。

4：应用服务器通过token及证书向苹果的消息服务器发送消息。

5：苹果将接收到的消息发送到对应设备上的对应应用。

6：如果应用未处于Active状态（未启动或backgroud），默认设置下，屏幕顶部会弹出消息框，同时有声音提示，点击改消息框会进入应用，如不点击则应用图标上会有badge number出现。



60、mvvm reactivecocoa


61、数据库
CoreData (一) 增删改查 https://github.com/wslcmk?tab=repositories
Core Data是iOS5之后才出现的一个框架，本质上是对SQLite的一个封装，
它提供了对象-关系映射(ORM)的功能，即能够将OC对象转化成数据，保存在SQLite数据库文件中，
也能够将保存在数据库中的数据还原成OC对象，通过CoreData管理应用程序的数据模型，可以极大程度减少需要编写的代码数量！

首先创建一个.xcdatamodel的模型文件，在这个模型文件中添加实体（Entities）
并添加属性name、age、sex 等属性
在最右边Entity Name填写模形的name
选中此模型，xcode-editor-createNSmanagerObjet
会自动创建这个模型的类
Student+CoreDataClass
Student+CoreDataProperties

 1//根据模型文件创建模型对象
 NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
 NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
 2//创建持久化存储助理
 NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
 3 //数据库的路径来设置一个持久的数据库
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    NSError *error = nil;
    //设置数据库相关信息 ，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
 4 //创建一个管理对象，与模型助理关联
     if (error) {
        NSLog(@"添加数据库失败:%@",error);
    } else {
        NSLog(@"添加数据库成功");
    }
    
    //3、创建上下文 保存信息 操作数据库
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context = context;
    
    CoreData调试:

打开Product，选择Edit Scheme.
选择Arguments，在下面的ArgumentsPassed On Launch中添加下面两个选项，如图：
(1)-com.apple.CoreData.SQLDebug
(2)1
    
62、k线
macd： DIFF指标作为短期移动均线 ，DEA作为一个中长期移动平均线
63、视频直播
Mac-Operation not permitted问题
https://blog.csdn.net/z82367825/article/details/55000615 
FFmpeg-iOS静态库编译
https://blog.csdn.net/taylorwenzhan/article/details/51918339
视频直播初窥
https://www.cnblogs.com/oc-bowen/p/5896199.html
iOS中集成ijkplayer视频直播框架
https://www.jianshu.com/p/1f06b27b3ac0

64、网络封装
65、布局
66、架构
67、画方法
68、算法
69、
nullable: 表示修饰的属性或参数可以为空 
nonnull:非空，表示修饰的属性或参数不能为空，
nonnull,nullable只能修饰对象，不能修饰基本数据类型

null_resettable的使用：
** null_resettable: get方法:不能返回为空，set方法可以为空**
@property(nonatomic,strong,null_resettable) NSNumber * number;

null_unspecified的使用：

null_unspecified:不确定是否为空,使用方式有三种：
@property(nonatomic,strong) NSNumber *_Null_unspecified height;
@property(nonatomic,strong) NSNumber *__null_unspecified height;
@property(nonatomic,strong,null_unspecified) NSNumber * height;
苹果为了减轻我们的工作量，专门提供了两个宏：NS_ASSUME_NONNULL_BEGIN， NS_ASSUME_NONNULL_END。在这两个宏之间的代码，
所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。
70、UIWindow层级 keywindow
UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal; //默认，值为0
UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert; //值为2000 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar ; // 值为1000

层级越高的window总是显示在最前面
弹出AlertView和ActionSheet的时候系统会帮你改变keyWindow  但是当弹出键盘的时候keyWindow是不变
四个关于window变化的通知
UIKIT_EXTERN NSString *const UIWindowDidBecomeVisibleNotification; // 当window激活时并展示在界面的时候触发，返回空
UIKIT_EXTERN NSString *const UIWindowDidBecomeHiddenNotification;  // 当window隐藏的时候触发，暂时没有实际测，返回空
UIKIT_EXTERN NSString *const UIWindowDidBecomeKeyNotification;     // 当window被设置为keyWindow时触发，返回空
UIKIT_EXTERN NSString *const UIWindowDidResignKeyNotification;     // 当window的key位置被取代时触发，返回空

当前app可以打开的多个window 如系统状态栏其实就是一个window ,程序启动的时候创建的默认的window ，弹出键盘也是一个window ，
alterView 弹框也是window 。但是keyWindow只有一个 ，一般情况下就是我们程序启动时设置的默认的window

获取keyWindow的方式
UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

1) 同一层级的 最后一个显示出来，上一个被覆盖

2）UIWindow在显示的时候是不管KeyWindow是谁，都是Level优先的，即Level最高的始终显示在最前面。

3）谁最后设置的 makeKeyAndVisible 谁就是keyWindow 其他的也会显示出来 所有的window都可以监听键盘 和点击的事件 

(1)UITextEffectsWindow
这是iOS8引入的一个新window，是键盘所在的window。它的windowLevel是最高的。
(2)UIRemoteKeyboardWindow
iOS9之后,新增了一个类型为 UIRemoteKeyboardWindow 的窗口用来显示键盘按钮。
销毁一个UIWindow
self.testWindow.hidden = YES;
self.testWindow = nil;

添加一个window在手机上
    UIWindow *window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
    window1.backgroundColor = [UIColor redColor];
    window1.windowLevel = UIWindowLevelAlert;
    [window1 makeKeyAndVisible];
    
71、viewDidLoad, viewWillDisappear, viewWillAppear等区别及各自的加载顺序
viewWillAppear:视图即将可见时调用。默认情况下不执行任何操作

viewDidAppear:视图已完全过渡到屏幕上时调用

viewWillDisappear:Calledafter the view was dismissed, covered or otherwise hidden. Defaultdoesnothing视图被驳回后调用，覆盖或以其他方式隐藏。默认情况下不执行任何操作loadView;Thisis where subclasses should create their custom view hierarchy ifthey aren't using a nib. Should never be calleddirectly.这是当他们没有正在使用nib视图页面，子类将会创建自己的自定义视图层。绝不能直接调用。
viewDidLoad：在视图加载后被调用，如果是在代码中创建的视图加载器，他将会在loadView方法后被调用，如果是从nib视图页面输出，他将会在视图设置好后后被调用。

viewWillAppear：当收到视图在视窗将可见时的通知会呼叫的方法

viewDidAppear：当收到视图在视窗已可见时的通知会呼叫的方法

viewWillDisappear：当收到视图将去除、被覆盖或隐藏于视窗时的通知会呼叫的方法

viewDidDisappear：当收到视图已去除、被覆盖或隐藏于视窗时的通知会呼叫的方法

didReceiveMemoryWarning：收到系统传来的内存警告通知后会执行的方法

shouldAutorotateToInterfaceOrientation：是否支持不同方向的旋转视图

willAnimateRotationToInterfaceOrientation：在进行旋转视图前的会执行的方法（用于调整旋转视图之用）


代码的执行顺序

1、alloc创建对象，分配空间

2、init (initWithNibName) 初始化对象，初始化数据

3、loadView从nib载入视图，通常这一步不需要去干涉。除非你没有使用xib文件创建视图

4、viewDidLoadr控制器载入完成，可以进行自定义数据以及动态创建其他控件

5、viewWillAppear视图将出现在屏幕之前，马上这个视图就会被展现在屏幕上了

6、viewDidAppear视图已在屏幕上渲染完成 当一个视图被移除屏幕并且销毁的时候的执行顺序，这个顺序差不多和上面的相反

1、viewWillDisappear视图将被从屏幕上移除之前执行

2、viewDidDisappear视图已经被从屏幕上移除，用户看不到这个视图了

3、dealloc视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放


71、判断模态
viewDidAppear{
if (self.presentingViewController) {
      模态
    } else {

    }

}

72、runtime的消息机制
runtime方法名都是有前缀的，谁负责的事情就以这个开头
runtime本质是发消息，只声明，不实现方法，不会报错，因为runtime运行时，只有在运行时才会去检测方法
Clang重写m文件为cpp文件 
clang -rewrite-objc main.m编译出底层代码main.cpp,大概有10万行，搜索autoreleasepool 
id objc = [[NSObject alloc]init];
使用
#import<obj/message.h>

runtime消息机制
id ob = objc_msgsend(参数1：谁发消息  参数2：发什么消息)
xode6苹果不推荐用runtime，不希望使用者了解太多底层实现，如果想用需在plish里面添加runtime参数
就会出runtime方法提示了
oc的任何方法，最终都转换为消息机制
oc先转换成c++代码

runtime消息机制调用多个参数
id objc = objc_msgsend([nsobject class],@selector(alloc));//给类对象发送一个消息
objc = objc_msgsend(objc,@selector(init));
objc = objc_msgsend(objc,sel_registername(init));//这两者是一个意思
runtime用在哪些地方：
person *p = [person alloc]
p.name 找不到
因为没有init方法，init让对象处于真正可用状态，能把方法声明暴露出来
但用runtime 可以在不初始化的情况下去找到这个私有方法
应用范围
调用一些底层私有方法
调多参数
objc_msgsend(objc,@selector(run),20);

runtime方法的调用流程
方法保存在哪里？
对象方法：p里面有个isa指针指向一个类对象，类对象里面都有方法列表
类方法：保存在一个元类方法列表中
怎么找到这个类对象：通过isa指针去查找，方法名注册成对应的方法编号，通过这个方法编号去查找，这个编号查到对应的内存地址，
从代码区通过内存地址能找到方法的实现
内存5大区：
一个由C/C++编译的程序占用的内存分为以下几个部分 ：

  1、栈区（stack）  —   由编译器自动分配释放   ，存放函数的参数值，局部变量的值等。其    操作方式类似于数据结构中的栈。

    2、堆区（heap） —   一般由程序员分配释放，   若程序员不释放，程序结束时可能由OS回收   。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表。

    3、全局区（静态区）（static）—   全局变量和静态变量的存储是放在一块的，初始化的    全局变量和静态变量在一块区域，   未初始化的全局变量和未初始化的静态变量在相邻的另一块区域。   -   程序结束后由系统释放。

    4、文字常量区   —   常量字符串就是放在这里的。   程序结束后由系统释放。

    5、程序代码区   —   存放函数体的二进制代码。        




runtime的应用
1、为系统类动态添加属性
NSObject *obj = [NSObject alloc]init];
obj.name ="objname"//属性本质是让属性与某个对象产生关联
@interface nsobject(proerty)
@property nsstring *name; @property 只会生成set,get方法的声明，不会声明实现，也不会声明下划线的成员属性
@synthesize toDoItems = _toDoItems；可省略
#import "NSObject+property.h"
#import <objc/message.h>

@implementation NSObject (property)

- (void)setName:(NSString *)name
{
    // Associated : |əˈsəʊʃɪeɪt|关联的意思

    /*
     产生关联,让某个对象(name)与当前对象的属性(name)产生关联
     参数1: id object :表示给哪个对象添加关联
     参数2: const void *key : 表示: id类型的key值(以后用这个key来获取属性) 属性名
     参数3: id value : 属性值
     参数4: 策略, 是个枚举(点进去,解释很详细)
     */

    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSString *)name
{
    return objc_getAssociatedObject(self, "name");
}

// 下面是策略(是个枚举值)的类型
OBJC_ASSOCIATION_ASSIGN = 0,
< Specifies a weak reference to the associated object.

OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
< Specifies a strong reference to the associated object.
                                          The association is not made atomically.//字符串类型

OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
< Specifies that the associated object is copied.
                                       The association is not made atomically

OBJC_ASSOCIATION_RETAIN = 01401,
< Specifies a strong reference to the associated object.
                                         The association is made atomically.

OBJC_ASSOCIATION_COPY = 01403
< Specifies that the associated object is copied.
                                      The association is made atomically.


@end

runtime 应用方法交换
方法交换的本质
通过isa指针，找到类对象或元类的方法列表，列表中有方法编号，通过编号可以找到实现该方法的地址，交换则是在方法列表中进行的
什么情况下使用方法交换
扩展系统的一个方法，如UIImage的imagewithname
如果用一个子类继承uiimage，复写imagewithname方法，在使用时需要import这个子类，对于一些老项目，所有uiimage对象都得改成子类对象
如果使用分类复写方法，不可行，因为分类会覆盖掉本身的方法，因为不是继承，不能实现super imagewithname
如果使用分类扩展一个新的sx_imagewithname也不太好，因为老项目同样需要一个一个的去修改
所以采用运行时交换方法
交换方法注意的几点
1、用于和imagewithname交换的那个分类方法，在调用imagewithname会引起死循环调用，因为这个方法已经被交换
2、这种方式必须用分类去实现
3、交换方法写到load里面，因为load函数是把类加载到内存中会执行，只执行一次，注意，swift没有load方法
有,如果是swift，可以在initialize方法中写，但是需要在dispath_once这个block中执行，因为initialize可能执行多次
person *p1 =[[person alloc]init]
person *p2 =[[person alloc]init]
init执行两次，initialize执行1次，load执行1次

student *s = [[student alloc]init];
person *p =[[person alloc]init]
init执行两次，initialize执行两次，load执行1次
例：
#import "NSString+ExchangeMethod.h"
#import <objc/runtime.h>

@implementation NSString (ExchangeMethod)

+ (void)load
{
    // 获取系统的对象方法
    Method stringByAppendingStringMethod = class_getInstanceMethod(self, @selector(stringByAppendingString:));
    
    // 获取自己定义的对象方法
    Method sjx_stringByAppendingStringMethod = class_getInstanceMethod(self, @selector(sjx_stringByAppendingString:));
    
    // 方法交换
    method_exchangeImplementations(stringByAppendingStringMethod, sjx_stringByAppendingStringMethod);
}

- (NSString *)sjx_stringByAppendingString:(NSString *)aString
{
    if (aString == nil || aString.length == 0) {
        aString = @"输入的字符串为空哦！！";
    }
    
    /*
     因为已经交换了方法，所以在这里调用 sjx_stringByAppendingString: 实际为 stringByAppendingString: 
     如果这里写 stringByAppendingString: 会造成死循环
     */
    return [self sjx_stringByAppendingString:aString];
}

@end

runtime动态添加方法 开发使用场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。

问题：performselector使用过吗？什么情况下使用？
在运行时用到过，一个方法只要被实现了，都会添加到方法列表中，performselector会在运行时去方法列表找方法的实现。
通常与检查方法- (BOOL)respondsToSelector:(SEL)aSelector;去调用，（判断方法是否已经实现，可以调用），
performselector可以调用没有声明的方法，相当于只要是方法都可以调用，相当于它是高级会员，能访问系统一些私有的方法

resolveInstanceMethod和resolveClassMethod 对象方法和类方法 这两个方法用什么作用？
person *p = [[person alloc]init];
[p run];/
如果run方法没有实现，则会调用resolveInstanceMethod，这个函数里面就可以编写一些运行时的方法

void aaa(id self,sel _cmd){

}
+(BOOL)resolveInstanceMethod:(SEL)sel{
// NSStringFromSelector(sel)把方法转字符串
if(sel==NSSelectorFromString(@"eat")){//把字符串转换为方法
  //class给哪个类添加方法
  //sel添加哪个方法
  //方法实现，函数入品，函数名
  //类型，是否有参数或无参数有返回值
  class_addmethod(self,sel,imp(aaa),"v@:")
}
任何方法都有两个隐藏参数，self,_cmd(获取当前方法的编号)
NSStringFromSelector(_cmd)会把方法编号转为函数名

知识点：
#import "ViewController.h"
#import "Person.h"

/* 
    1：
    Runtime(动态添加方法):OC都是懒加载机制,只要一个方法实现了,就会马上添加到方法列表中.
    app:免费版,收费版
    QQ,微博,直播等等应用,都有会员机制
    performSelector：去执行某个方法。performSelector withObject ：object为前面方法的参数
    
    2：
    美团有个面试题?有没有使用过performSelector,什么时候使用?动态添加方法的时候使用过?怎么动态添加方法?用runtime?为什么要动态添加方法?
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _cmd:当前方法的方法编号
    
    Person *p = [[Person alloc] init];
    
    // 执行某个方法
//    [p performSelector:@selector(eat)];
    
    [p performSelector:@selector(run:) withObject:@10];
    

}

@end
复制代码
复制代码
#import "Person.h"
#import <objc/message.h>

@implementation Person

// 没有返回值,也没有参数
// void,(id,SEL)
void aaa(id self, SEL _cmd, NSNumber *meter) {
    
    NSLog(@"跑了%@", meter);
    
}

// 任何方法默认都有两个隐式参数,self,_cmd（_cmd代表方法编号，打印结果为当前执行的方法名）
// 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
// 作用:动态添加方法,处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // [NSStringFromSelector(sel) isEqualToString:@"eat"];
    if (sel == NSSelectorFromString(@"run:")) {
        // eat
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
        // type: 方法类型：void用v来表示，id参数用@来表示，SEL用:来表示
        //aaa不会生成方法列表
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];

}

//- (void)test
//{
//    // [NSStringFromSelector(sel) isEqualToString:@"eat"];
//    if (sel == NSSelectorFromString(@"eat")) {
//        // eat
//        // class: 给哪个类添加方法
//        // SEL: 添加哪个方法
//        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
//        // type: 方法类型
//        class_addMethod(self, sel, (IMP)aaa, "v@:");
//        
//        return YES;
//    }
//    
//    return [super resolveInstanceMethod:sel];
//}
@end
复制代码
####3.动态添加方法

* 开发使用场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。

* 经典面试题：有没有使用performSelector，其实主要想问你有没有动态添加过方法。

* 简单使用

 

```

@implementation ViewController

 

- (void)viewDidLoad {

    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.

    

    Person *p = [[Person alloc] init];

    

    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。

    // 动态添加方法就不会报错

    [p performSelector:@selector(eat)];

    

}

 

 

@end

 

 

@implementation Person

// void(*)()

// 默认方法都有两个隐式参数，

void eat(id self,SEL sel)

{

    NSLog(@"%@ %@",self,NSStringFromSelector(sel));

}

 

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.

// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法

+ (BOOL)resolveInstanceMethod:(SEL)sel

{

    

    if (sel == @selector(eat)) {

        // 动态添加eat方法

        

        // 第一个参数：给哪个类添加方法

        // 第二个参数：添加方法的方法编号

        // 第三个参数：添加方法的函数实现（函数地址）

        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd

        class_addMethod(self, @selector(eat), eat, "v@:");

        

    }

    

    return [super resolveInstanceMethod:sel];

}

@end

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

UUID（Universally Unique IDentifier），通用唯一标示符，是一个32位的十六进制序列，使用小横线来连接：8-4-4-4-12，通过 NSUUID（iOS 6 之后）[NSUUID UUID].UUIDString 或者 CFUUID（iOS 2 之后） CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault))) 来获取，但是每次获取的值都不一样，需要自己存储。

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


74、空”园三兄弟之nil和Nil及NUL
说到空指针，大家立马想到的是nil，其实OC大家族中的三个成员nil，Nil还有NULL，都是空指针，即没有指向任何东西的指针，给空指针发送消息也不会报错！

下面就说说关于nil和Nil及NULL的区别: 
nil: A null pointer to an Objective-C object. nil 是一个OC对象值。

//nil的定义
#define nil __DARWIN_NULL
#define __DARWIN_NULL ((void *)0)

//nil怎么用
Person *p = [Person new]; 
p = nil;
Nil: A null pointer to an Objective-C class.给类对象赋值

//Nil的定义
#define Nil __DARWIN_NULL
#define __DARWIN_NULL ((void *)0)

//Nil怎么用
Class someClass = Nil;
NULL: A null pointer to anything else, is for C-style memory pointers. 用于对非对象指针赋空值，比如C指针 

//NULL的定义
#define NULL ((void*)0)

//NULL的用法
char *ptr = NULL;
int* p = NULL;
struct S *s = NULL;
通过查看定义我们发现，nil，Nil，NULL其实并没有什么本质上的不同，只是OC种用不同的形式来表示他们应该用在不用的地方，但是其实他们可以通用，你给一个OC对象或者类对象或者C语言指针赋值为NIL,nil,NULL都是不会报错的。

NSNull: The NSNull class defines a singleton object used to represent null values in collection objects (which don’t allow nil values).

//NSNULL的定义
@interface NSNull : NSObject <NSCopying, NSSecureCoding>
+ (NSNull *)null;
@end

//NSNULL的使用
[NSNull null]; //返回一个单例的NSNULL对象
//他返回的对象用在比如像NSArray这样的类型中，nil或NULL不能做为加到其中的Object
//如果定义了一个NSArray，为其分配了内存，又想设置其中的内容为空，则可以用[NSNULL null]返回的对象来初始化NS   

75、const,static,extern,#define super superclass class
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

76、reactivecocoa MVVM

链式编程思想:

必须要返回一个block,block必须有返回值，返回对象的本身
把所有的代码聚合在block里面
当一个对象的方法返回值是block时,直接对象.方法
1、为NSObject添加分类
+ (int)xmg_makeCalculate:(void (^)(CalculateManager *))block
{
    // 创建计算管理者
    CalculateManager *mgr = [[CalculateManager alloc] init];
    
    // 执行计算
    block(mgr);
    
    return mgr.result;
}
2、创建一个计算器管理类用于数学运算

@propery(noamtic,assgin)int result;
-（instance）add:(int)value
{
  _result+=value;
  return self;
}
把add方法封装成block，则可以实现.add(5).add(3)把block当成返回值
把-（instance）add:(int)value换成-(void(^)())add:(int)value则可以实现mgr.add(5)
@property (nonatomic, assign) int result;
- (CalculateManager * (^)(int))add
{
    
    return ^(int value){
        _result += value;
        
        return self;
        
    };
    
}
3、在其它类中如何使用
int reslut = [NSObject xmg_makeCalculate:^(CalculateManager *mgr){
  mgr.add(5).add(3).sub(1)
}];


响应式编程思想：
不需要考虑调用顺序，只需要考虑结果，产生一个事件后，事件会像流一样的传播出去，
然后影响结果，产生一个东西会影响很多东西

kvo就是响应式编程思想。对象的属性一改变，就能知道。
例：a+b = c; 链式，先知道a,再知道b，就能求出c， 响应式，先知道b，后知道a，也能求出c
不用管某个变量是否有值，先写好方程式，有值的时候自然能算出来
kvo本质就是一个对象有没有调用set方法
@public
 nsstring *_name;外界通过p->name就可以访问了，通过p->name去修改值就不能改变成员属性了
 因为没访问set方法
 监听一个方法有没打印，可以重写一个方法，两种方式重写一个方法：一种分类，一种是子类继承
 用分类不太好，因为分类没有super方法，不能调用重写前的方法；
 本质，不需要覆盖原有的方法实现，只需要判断set方法有没调用
 
 kvo的实现思路：
1、 创建一个NSObject的分类，增加如下方法，这个方法中，通过运行时 objc_setAssociatedObject，把self与观察者observer，通过observerKey关联，
 object_setClass(self, [XMGKVONotifying_Person class]);把person的isa指针绑定到子类XMGKVONotifying_Person类，解决调用person.name时直接调用XMGKVONotifying_Person.setName
 // 监听某个对象的属性
// 谁调用就监听谁
- (void)xmg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
    /*
     // 1.自定义NSKVONotifying_Person子类
     // 2.重写setName,在内部恢复父类做法,通知观察者
     // 3.如何让外界调用自定义Person类的子类方法,修改当前对象的isa指针,指向NSKVONotifying_Person
     */
    
    // 把观察者保存到当前对象
    objc_setAssociatedObject(self, (__bridge const void *)(observerKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 修改对象isa指针
    object_setClass(self, [XMGKVONotifying_Person class]);
    
}
关键策略是一个枚举值。

OBJC_ASSOCIATION_ASSIGN = 0,      <指定一个弱引用关联的对象>

OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,<指定一个强引用关联的对象>

OBJC_ASSOCIATION_COPY_NONATOMIC = 3,  <指定相关的对象复制>

OBJC_ASSOCIATION_RETAIN = 01401,      <指定强参考>

OBJC_ASSOCIATION_COPY = 01403    <指定相关的对象复制>


 2、自定一个 XMGKVONotifying_Person类，继承person,通过self与observerKey取出观察者对象，观察者对象去调用observeValueForKeyPath，则实现了当person.name值改变时会调用observeValueForKeyPath方法
 extern NSString *const observerKey ;
@implementation XMGKVONotifying_Person
- (void)setName:(NSString *)name
{
    [super setName:name];
    
    // 通知观察者调用observeValueForKeyPath
    // 需要把观察者保存到当前对象
    // 获取观察者
   id obsetver = objc_getAssociatedObject(self, observerKey);
    
    [obsetver observeValueForKeyPath:@"name" ofObject:self change:nil context:nil];
    
}
@end


函数式编程思想：是把操作尽量写成一系列嵌套的函数或者方法调用
函数式编程本质:就是往方法中传入Block,方法中嵌套Block调用，把代码聚合起来管理
函数式编程特点：每个方法必须有返回值（本身对象）,把函数或者Block当做参数,block参数（需要操作的值）block返回值（操作结果）
代表：ReactiveCocoa。

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CalculateManager *mgr = [[CalculateManager alloc] init];
    
   int result 执行顺序6 = [[mgr calculate:^(int result){执行顺序1
       // 存放所有的计算代码
        result += 5; 执行顺序4
        result *= 5;
        return result; 执行顺序7
    }] result]; 执行顺序8
    NSLog(@"%d",result);
}

@end

@interface CalculateManager : NSObject

@property (nonatomic, assign) int result;

// 计算
- (instancetype)calculate:(int(^)(int))calculateBlock;

@end

@implementation CalculateManager
- (instancetype)calculate:(int (^)(int))calculateBlock  执行顺序2
{
    _result =  calculateBlock(_result); 执行顺序3
    return self;执行顺序5
}
@end

ReactiveCocoa编程思想

ReactiveCocoa结合了几种编程风格：

函数式编程（Functional Programming）

响应式编程（Reactive Programming）
你可能听说过ReactiveCocoa被描述为函数响应式编程（FRP）框架
以后使用RAC解决问题，就不需要考虑调用顺序，直接考虑结果，把每一次操作都写成一系列嵌套的方法中，使代码高聚合，方便管理

如何导入ReactiveCocoa框架
通常都会使用CocoaPods（用于管理第三方框架的插件）帮助我们导入。

cd 到工程目录 
touch podfile 创建文件
open podfile 打开文件
pod search  ReactiveCocoa查看描述 找到pod 'ReactiveCocoa', '~> 4.0.2-alpha-1'
pod install出错
加上use_frameworks! swift的东西，则可以用
由于ReactiveCocoa没有提示，最好创建一个全局的头文件，把ReactiveCocoa import到这个文件中

ReactiveCocoa常见类
常见类
RACSiganl:信号类,只要有数据传递就用这个信号类。只要有数据改变，信号内部接收到数据，就会马上发出数据。它本身没有发送信号的能力
发送数据是交给订阅者去发送数据的
默认一个信号都是冷信号，也就是值改变了，也不会触发，只有订阅了这个信号，这个信号才会变为热信号，值改变了才会触发。
如何订阅信号：调用信号RACSignal的subscribeNext就能订阅
RACSignal使用步骤：
创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
订阅信号,才会激活信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
发送信号 - (void)sendNext:(id)value
有数所产生就使用RACSiganl
不同类型的信号处理订阅的方式不一样
// 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {步骤1

        // block调用时刻：每当有订阅者订阅信号，就会调用block。步骤3

        // 2.发送信号
        [subscriber sendNext:@1];

        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];//取消订阅信号

        return [RACDisposable disposableWithBlock:^{

            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。

            // 执行完Block后，当前信号就不在被订阅了。

            NSLog(@"信号被销毁");

        }];
    }];
//订阅信号,才会激活信号.步骤2订阅会调用步聚1的block
  RACDisposable *disposable =  [siganl subscribeNext:^(id x) {x信号发出的值
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
    
这个是怎么实现的，可以安装一下OmniGraffle64绘图软件了解一下流程，流程图软件
// RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。 
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
RACSubscriber:表示订阅者的意思，用于发送信号并且把nextBlock保存到subscriber中这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。当发送订阅完成就会默认取消订阅，调这个block
因为这会RACSubscriber订阅者不存在了，所以只要订阅者在这个信号就不会被取消息，可以创建一个RACSubscriber的强指针去保存RACSubscriber，信号就不会被取消了
【disposable dispose】	可主动取消订阅




RACReplaySubject与RACSubject
RACReplaySubject:重复提供信号类，RACSubject的子类。
Subject 可以翻译为信号提供者，信号提供者，自己可以充当信号，又能发送信号。
使用场景一:替代代理，代理有一大堆协议，很烦人
 // 1.创建信号
    RACSubject *subject = [RACSubject subject];//因为继承一个RACSignal,内部保存了一个数组，
        // 2.订阅信号
    [subject subscribeNext:^(id x) {//创建了一个订阅者，并保存了next这个block,订阅者保存在数组中，不同的信号订阅方式不同
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
     // 3.发送信号
    [subject sendNext:@"1"];//这个就不用在block中用订阅者发送，取出每个订阅者并遍列数组中的block执行它
这种信号不同于RACSignal，可被订阅多次，每订阅一次会创建一个订阅者



RACReplaySubject
// 1.创建信号
RACReplaySubject *replaySubject = [RACReplaySubject subject];//创建信号时没有block，可以先订阅信号，也可以先发送
// 2.发送信号
[replaySubject sendNext:@1];//保存值1，遍历所有订阅者，这个时候只有一个订阅者，去发数据
// 3.订阅信号
[replaySubject subscribeNext:^(id x) {//创建了一个订阅者,遍历所有的值，拿到当前订阅者去发送消息，只拿到一个订阅者去发送数据

        NSLog(@"第一个订阅者接收到的数据%@",x);
}];

RACReplaySubject与RACSubject区别
RACReplaySubject 可以先发送信号再订阅数据，因为它可以先把要发送的值保存起来，subscribeNext 遍历所有的值，拿到当前订阅者去发送消息

- (void)RACSubject
{
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    
    // 不同信号订阅的方式不一样
    // RACSubject处理订阅:仅仅是保存订阅者
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一接收到数据:%@",x);
    }];
    
    // 3.发送数据
    [subject sendNext:@1];
    
    //    [subject subscribeNext:^(id x) {
    //        NSLog(@"订阅二接收到数据:%@",x);
    //    }];
    // 保存订阅者
    
   
    // 底层实现:遍历所有的订阅者,调用nextBlock
    
    // 执行流程:
    
    // RACSubject被订阅,仅仅是保存订阅者
    // RACSubject发送数据,遍历所有的订阅,调用他们的nextBlock
}


RACSubject代替代理
// 需求:
    // 1.给当前控制器添加一个按钮，modal到另一个控制器界面
    // 2.另一个控制器view中有个按钮，点击按钮，通知当前控制器
    
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

RACReplaySubject 可以先发送信号再订阅数据，因为它可以先把要发送的值保存起来，subscribeNext 遍历所有的值，拿到当前订阅者去发送消息
- (void)RACReplaySubject
{
    // 1.创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // 遍历所有的值,拿到当前订阅者去发送数据
    
    // 3.发送信号
    [subject sendNext:@1];
//    [subject sendNext:@1];
    // RACReplaySubject发送数据:
    // 1.保存值
    // 2.遍历所有的订阅者,发送数据
    
    
    // RACReplaySubject:可以先发送信号,在订阅信号
}

rac中的集合类

RACTuple:元组类,类似NSArray,用来包装值. swift元组除了保存对象还能保存基本数据类型，这里的元组只能保存对象
- (void)tuple
{
    // 元组
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"213",@"321",@1]];
    NSString *str = tuple[0];
    
    NSLog(@"%@",str);
}

RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典，NSArray,NSDictionary可转换为RACSequence
// 数组遍历，复杂写法
    NSArray *arr = @[@"213",@"321",@1];//NSArray转换为RACSequence
    RACSequence *sequence = arr.rac_sequence;
    把这个集合转换成信号，只有信号才能订阅，这样就遍历出里面的值
    // 把集合转换成信号
    RACSignal *signal = sequence.signal;
   [signal subscribeNext:^(id x) {//内部会把所有的元素发出来
          NSLog(@"%@",x);
   }];
   
   //数组遍历简单写法：
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
//字典遍历
// 字典
    NSDictionary *dict = @{@"account":@"aaa",@"name":@"xmg",@"age":@18};
    
    // 转换成集合
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //       NSString *key = x[0];
        //        NSString *value = x[1];
        //        NSLog(@"%@ %@",key,value);
        
        // RACTupleUnpack:用来解析元组
        // 宏里面的参数,传需要解析出来的变量名
        // = 右边,放需要解析的元组
        RACTupleUnpack(NSString *key,NSString *value) = x;//解包元组
        
        NSLog(@"%@ %@",key,value);
    }];
}


  // 解析plist文件
   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
//        Flag *flag = [Flag flagWithDict:x];
//        [arr addObject:flag];
//    }];
    
    // 高级用法
    // 会把集合中所有元素都映射成一个新的对象
   NSArray *arr = [[dictArr.rac_sequence map:^id(NSDictionary *value) {
        // value:集合中元素
        // id:返回对象就是映射的值
        return [Flag flagWithDict:value];
    }] array];
    
    NSLog(@"%@",arr);
    
7.ReactiveCocoa开发中使有场影

7.1 代替代理:
rac_signalForSelector：用于替代代理。
    // 需求：自定义redView,控制器监听红色view中按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    监听某个对象有没调用某个方法，但是这种方式不好，不能传值
    [[redV rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮");
    }];
    

7.2 代替KVO :
rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。与传统比较好处，如果监听多值，不用在观察者方法中写if语句去判断是哪个值改变了
 // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[redV rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

        NSLog(@"%@",x);

    }];
7.3 监听事件:
rac_signalForControlEvents：用于监听某个事件。
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        NSLog(@"按钮被点击了");
    }];
7.4 代替通知:
rac_addObserverForName:用于监听某个通知。
    // 把监听到的通知转换信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出");
    }];

7.5 监听文本框文字改变:
rac_textSignal:只要文本框发出改变就会发出这个信号。
   [_textField.rac_textSignal subscribeNext:^(id x) {

       NSLog(@"文字改变了%@",x);
   }];
7.6 使用场景处理当界面有多个模块，每个模块都请求数据，需要所有模块请求数据完成，才能展示界面

rac_liftSelector:withSignalsFromArray:Signals:当传入的Signals(信号数组)，每一个signal都至少sendNext过一次，就会去触发第一个selector参数的方法。
使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。


    
8、总结
RACSignal RACSubject RACReplaySubject不同信号订阅方式不同，无论什么信号都会创建RACSubscriber订阅者，订阅者一发发送就会调用subernext这段代码，

RACSignal，RACSignal-》[创建一个新的信号]并保存didSubscribe到这个新信号中-》subscribeNext:nextBlock方法[订阅信号]，方法内部实现创建订阅者，把nextBlock保存到订阅者中，[调用新信号保存的didSubscribe]->
didSubscribe中调用[subscriber sendNext:@1]发送信号方法--》sendNext方法执行nextBlock订阅 （当两个对象互相传值用这种信号）

RACSubject RACSubject-》[创建一个新的信号]并没有保存什么didSubscribe-》新信号订阅subscribeNext的方法内部实现创建订阅者，保存订阅者--》
发信号的方法，遍列所有订阅者，调用它们的nextBlock订阅block(替换代理用此信号）

RACReplaySubject 无论是创建订阅，或发送信号，都会创建一个订阅者它可以先把要发送的值保存起来，subscribeNext 遍历所有的值，拿到当前订阅者去发送消息，这个信号订阅和发送信号的顺序可以随便切换

rac_liftSelector 一个界面有多个接口请求数据，等所有请求都完成再展示数据，这时候用这个方法
// 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
[self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];//request1,request2是信号，当这两个信号发送数据的时候才会调用下面方法
// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}    


   热销模块：
   RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {步骤1

        // 请求数据
        NSLog("AFN请求数据")；

        // 2.请求完成发送数据
        [subscriber sendNext:@1];

    }];
    
   最新模块：
   RACSignal *newsiganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {步骤1

        // 请求数据
        NSLog("AFN请求数据")；

        // 2.请求完成发送数据
        [subscriber sendNext:@1];

    }];
    
[self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[siganl,newsiganl]];//，当这两个请求信号发送数据的时候才会调用下面方法，r1:r2就是sendNext发送的数据

// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
} 

rac宏

   [_textField.rac_textSignal subscribeNext:^(id x) {

       self.labelView.text = x;
   }];
 // 只要文本框文字改变，就会修改label的文字 给某个对象的某个属性绑定一个信号，这个信号一改变就会修改值
    RAC(self.labelView,text) = _textField.rac_textSignal;
    
        // RACObserve(self.view, center)监听某个对象的某个属性，只要属性改变就产生信号，就可以用subscribeNext订阅
    [RACObserve(self.view, center) subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
    }];
    
防循环引用
@weakify(self)//保证这个是弱指针不会强引用self
RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {步骤1

       @strongify(self)//用一个强指针指向self，保证这个指针在这个block这个代码块不会提前销毁，
       NSLog(self);//此时self 就是一个弱指针了
    }];
    _signal = signal
    
  
RACTuplePack：把数据包装成RACTuple（元组类）
  // 把参数中的数据包装成元组
    RACTuple *tuple = RACTuplePack(@10,@20);
    RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
    // 把参数中的数据包装成元组
    RACTuple *tuple = RACTuplePack(@"xmg",@20);

    // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
    // name = @"xmg" age = @20
    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
    
RACMulticastConnection
    在项目里,经常会使用这种方式创建一个signal 然后next
    RACSignal *four = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSLog(@"oneSignal createSignal");
        [subscriber sendNext:@""];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"oneSignal dispose");
        }];
    }];
    
    [four subscribeNext:^(id x) {
        NSLog(@"fristSignal 1");
    }];
    [four subscribeNext:^(id x) {
       NSLog(@"fristSignal 2");
   }];
   看上去是没有问题的,但是一跑起来就会发现

2015-10-17 00:06:20.050 conatAndThen[4518:2969779] oneSignal createSignal
2015-10-17 00:06:20.051 conatAndThen[4518:2969779] fristSignal 1
2015-10-17 00:06:20.052 conatAndThen[4518:2969779] oneSignal dispose
2015-10-17 00:06:20.053 conatAndThen[4518:2969779] oneSignal createSignal
2015-10-17 00:06:20.053 conatAndThen[4518:2969779] fristSignal 2
2015-10-17 00:06:20.053 conatAndThen[4518:2969779] oneSignal dispose
createSignal 被调用两次,来看看这是为什么
1.createSignal传入createBlock 返回 一个RACDynamicSignal 对象

这个对象保存了didSubscrib的block

2.在subscribNext中传入nextBlock创建一个RACSubscriber对象

3.执行subscribe这个方法

在subscribe中 调用了didSubscribe

并将保存了nextBlock的RACSubscriber对象

4.如果在createBlock中调用了subsribe sendNext的话 subscribe就会调用传入的nextBlock

总的来说

我们在createBlock经常看到的id<RACSubscriber> subscriber

这个subsriber就是在subsrbeNext时创建的,每次执行subscribeNext都会调用createBlock

,这就不难理解为什么createBlock为什么会重复执行

这根本就是不同的RACSubscriber

RAC 通过RACSignal 的multicast 方法来解决这个问题

这个方法返回一个RACMulticastConnection对象 调用connect 方法后,再获取signal属性,createBlock被调用多次的问题就会得到解决
RACMulticastConnection *connection = [four multicast:[RACReplaySubject subject]];
 
[connection connect];
 
[connection.signal subscribeNext:^(id x) {
    NSLog(@"fristSignal 1");
}];
 
[connection.signal subscribeNext:^(id x) {
    NSLog(@"fristSignal 2");
}];
结果
2015-10-17 00:16:55.053 conatAndThen[4576:2977593] oneSignal createSignal
2015-10-17 00:16:55.054 conatAndThen[4576:2977593] oneSignal dispose
2015-10-17 00:16:55.055 conatAndThen[4576:2977593] fristSignal 1
2015-10-17 00:16:55.056 conatAndThen[4576:2977593] fristSignal 2

来看看RACMulticastConnection是怎么解决问题的

mulitcast 这个方法,首先就创建了一个RACMulticastConnection对象保存参数起来

connect 方法里面会对sourceSignal subscribe 也就是执行createBlock

所以我们看到是fristSignal 1比dispose先一步执行

这时我们在后续操作的subscriNext的signal已经不是原来的signal了,

而是didsubscribeBlock为空的signal,所以不管后面有多少次subscribNext都不会让createBlock重复执行

raccommand
是处理事件的类如按钮点击事件
RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
监听按钮点击，网络请求，raccommand
一、RACCommand使用步骤:
1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
3.执行命令 - (RACSignal *)execute:(id)input

二、RACCommand使用注意:
1.signalBlock必须要返回一个信号，不能传nil.
2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。

三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。

四、如何拿到RACCommand中返回信号发出的数据。
1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。

五、监听当前命令是否正在执行executing

六、使用场景,监听按钮点击，网络请求

七、代码

    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        //input打印结果是1
        NSLog(@"执行命令");

        // 创建空信号,必须返回信号
        //        return [RACSignal empty];

        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            [subscriber sendNext:@"请求数据"];

            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];

            return nil;
        }];

    }];

    // 强引用命令，不要被销毁，否则接收不到数据
    _conmmand = command;


    // 3.执行命令
    [self.conmmand execute:@1];

    // 4.订阅RACCommand中的信号//executionSignals 正在执行的信号
    [command.executionSignals subscribeNext:^(id x) {

        [x subscribeNext:^(id x) {

            NSLog(@"%@",x);//打印的是请求数据
        }];

    }];

    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];

    // 5.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {

        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");

        }else{
            // 执行完成
            NSLog(@"执行完成");
        }

    }];
    
1.ReactiveCocoa常见操作方法介绍。

1.1 ReactiveCocoa操作须知

所有的信号（RACSignal）都可以进行操作处理，因为所有操作方法都定义在RACStream.h中，而RACSignal继承RACStream。
1.2 ReactiveCocoa操作思想

运用的是Hook（钩子）思想，Hook是一种用于改变API(应用程序编程接口：方法)执行结果的技术.
Hook用处：截获API调用的技术。
Hook原理：在每次调用一个API返回结果之前，先执行你自己的方法，改变结果的输出。
RAC开发方式：RAC中核心开发方式，也是绑定，之前的开发方式是赋值，而用RAC开发，应该把重心放在绑定，也就是可以在创建一个对象的时候，就绑定好以后想要做的事情，而不是等赋值之后在去做事情。
列如：把数据展示到控件上，之前都是重写控件的setModel方法，用RAC就可以在一开始创建控件的时候，就绑定好数据。
1.3 ReactiveCocoa核心方法bind

ReactiveCocoa操作的核心方法是bind（绑定）,给RAC中的信号进行绑定，只要信号一发送数据，就能监听到，从而把发送数据改成自己想要的数据。

在开发中很少使用bind方法，bind属于RAC中的底层方法，RAC已经封装了很多好用的其他方法，底层都是调用bind，用法比bind简单.

bind方法简单介绍和使用。
    // 假设想监听文本框的内容，并且在每次输出结果的时候，都在文本框的内容拼接一段文字“输出：”

    // 方式一:在返回结果后，拼接。
        [_textField.rac_textSignal subscribeNext:^(id x) {

            NSLog(@"输出:%@",x);

        }];

    // 方式二:在返回结果前，拼接，使用RAC中bind方法做处理。
    // bind方法参数:需要传入一个返回值是RACStreamBindBlock的block参数
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

    [[_textField.rac_textSignal bind:^RACStreamBindBlock{

        // 什么时候调用:
        // block作用:表示绑定了一个信号.

        return ^RACStream *(id value, BOOL *stop){

            // 什么时候调用block:当信号有新的值发出，就会来到这个block。

            // block作用:做返回值的处理

            // 做好处理，通过信号返回出去.
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        };

    }] subscribeNext:^(id x) {

        NSLog(@"%@",x);

    }];
    
1.4ReactiveCocoa操作方法之映射(flattenMap,Map)

flattenMap，Map用于把源信号内容映射成新的内容。
flattenMap简单使用

   // 监听文本框的内容改变，把结构重新映射成一个新值.

  // flattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。

    // flattenMap使用步骤:
    // 1.传入一个block，block类型是返回值RACStream，参数value
    // 2.参数value就是源信号的内容，拿到源信号的内容做处理
    // 3.包装成RACReturnSignal信号，返回出去。

    // flattenMap底层实现:
    // 0.flattenMap内部调用bind方法实现的,flattenMap中block的返回值，会作为bind中bindBlock的返回值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 2.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 3.调用bindBlock，内部就会调用flattenMap的block，flattenMap的block作用：就是把处理好的数据包装成信号。
    // 4.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 5.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。



    [[_textField.rac_textSignal flattenMap:^RACStream *(id value) {

        // block什么时候 : 源信号发出的时候，就会调用这个block。

        // block作用 : 改变源信号的内容。

        // 返回值：绑定信号的内容.
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];

    }] subscribeNext:^(id x) {

        // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。

        NSLog(@"%@",x);

    }];
    
    Map简单使用:

 // 监听文本框的内容改变，把结构重新映射成一个新值.

    // Map作用:把源信号的值映射成一个新的值

    // Map使用步骤:
    // 1.传入一个block,类型是返回对象，参数是value
    // 2.value就是源信号的内容，直接拿到源信号的内容做处理
    // 3.把处理好的内容，直接返回就好了，不用包装成信号，返回的值，就是映射的值。

    // Map底层实现:
    // 0.Map底层其实是调用flatternMap,Map中block中的返回的值会作为flatternMap中block中的值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 3.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 4.调用bindBlock，内部就会调用flattenMap的block
    // 5.flattenMap的block内部会调用Map中的block，把Map中的block返回的内容包装成返回的信号。
    // 5.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 6.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

       [[_textField.rac_textSignal map:^id(id value) {
        // 当源信号发出，就会调用这个block，修改源信号的内容
        // 返回值：就是处理完源信号的内容。
        return [NSString stringWithFormat:@"输出:%@",value];
    }] subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];
FlatternMap和Map的区别

1.FlatternMap中的Block返回信号。
2.Map中的Block返回对象。
3.开发中，如果信号发出的值不是信号，映射一般使用Map
4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap。
总结：signalOfsignals用FlatternMap。

    // 创建信号中的信号
    RACSubject *signalOfsignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];

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
    
    1.5 ReactiveCocoa操作方法之组合。
concat:按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
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

        NSLog(@"%@",x);

    }];

    // concat底层实现:
    // 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
    // 2.didSubscribe中，会先订阅第一个源信号（signalA）
    // 3.会执行第一个源信号（signalA）的didSubscribe
    // 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
    // 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
    // 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
    // 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
    
    then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
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

        // 只能接收到第二个信号的值，也就是then返回信号的值
        NSLog(@"%@",x);
    }];
merge:把多个信号合并为一个信号，任何一个信号有新值的时候就会调用.
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

        NSLog(@"%@",x);

    }];

    // 底层实现：
    // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
    // 2.每发出一个信号，这个信号就会被订阅
    // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
    // 4.只要有一个信号被发出就会被监听。
    
    zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。
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

        NSLog(@"%@",x);
    }];

    // 底层实现:
    // 1.定义压缩信号，内部就会自动订阅signalA，signalB
    // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
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
reduce聚合:用于信号发出的内容是元组，把信号发出元组的值聚合成一个值
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
1.6 ReactiveCocoa操作方法之过滤。

filter:过滤信号，使用它可以获取满足条件的信号.

// 过滤:
// 每次信号发出，会先执行过滤条件判断.
[_textField.rac_textSignal filter:^BOOL(NSString *value) {
      return value.length > 3;
}];
ignore:忽略完某些值的信号.

  // 内部调用filter过滤，忽略掉ignore的值
[[_textField.rac_textSignal ignore:@"1"] subscribeNext:^(id x) {

  NSLog(@"%@",x);
}];
distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。

  // 过滤，当上一次和当前的值不一样，就会发出内容。
// 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
[[_textField.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {

  NSLog(@"%@",x);
}];
take:从开始一共取N次的信号

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
takeUntil:(RACSignal *):获取信号直到执行完这个信号

// 监听文本框的改变，知道当前对象被销毁
[_textField.rac_textSignal takeUntil:self.rac_willDeallocSignal];
skip:(NSUInteger):跳过几个信号,不接受。

  // 表示输入第一次，不会被监听到，跳过第一次发出的信号
  [[_textField.rac_textSignal skip:1] subscribeNext:^(id x) {

      NSLog(@"%@",x);
  }];
switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。

RACSubject *signalOfSignals = [RACSubject subject];
RACSubject *signal = [RACSubject subject];
[signalOfSignals sendNext:signal];
[signal sendNext:@1];

// 获取信号中信号最近发出信号，订阅最近发出的信号。
// 注意switchToLatest：只能用于信号中的信号
[signalOfSignals.switchToLatest subscribeNext:^(id x) {

  NSLog(@"%@",x);
}];
1.7 ReactiveCocoa操作方法之秩序。

doNext: 执行Next之前，会先执行这个Block
doCompleted: 执行sendCompleted之前，会先执行这个Block

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
1.8 ReactiveCocoa操作方法之线程。
deliverOn: 内容传递切换到制定线程中，副作用在原来线程中,把在创建信号时block中的代码称之为副作用。

subscribeOn: 内容传递和副作用都会切换到制定线程中。

1.9 ReactiveCocoa操作方法之时间。

timeout：超时，可以让一个信号在一定的时间后，自动报错。

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
delay 延迟发送next。

 RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

 [subscriber sendNext:@1];
 return nil;
}] delay:2] subscribeNext:^(id x) {

 NSLog(@"%@",x);
}];
1.9 ReactiveCocoa操作方法之重复。

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
throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
        RACSubject *signal = [RACSubject subject];

    _signal = signal;

    // 节流，在一定时间（1秒）内，不接收任何信号内容，过了这个时间（1秒）获取最后发送的信号内容发出。
    [[signal throttle:1] subscribeNext:^(id x) {

        NSLog(@"%@",x);
    }];

1.介绍MVVM架构思想

1 程序为什么要架构：便于程序员开发和维护代码。

2 常见的架构思想:

MVC M:模型 V:视图 C:控制器

MVVM M:模型 V:视图+控制器 VM:视图模型

MVCS M:模型 V:视图 C:控制器 C:服务类

VIPER V:视图 I:交互器 P:展示器 E:实体 R:路由 (http://www.cocoachina.com/ios/20140703/9016.html)

3 MVVM介绍

模型(M):保存视图数据。

视图+控制器(V):展示内容 + 如何展示

视图模型(VM):处理展示的业务逻辑，包括按钮的点击，数据的请求和解析等等。

2.ReactiveCocoa + MVVM 登录界面

1.需求

1.监听两个文本框的内容，有内容才允许按钮点击
2.默认登录请求.
2.分析

1.界面的所有业务逻辑都交给控制器做处理
2.在MVVM架构中把控制器的业务全部搬去VM模型，也就是每个控制器对应一个VM模型.
3.步骤

        1.创建LoginViewModel类，处理登录界面业务逻辑.
        2.这个类里面应该保存着账号的信息，创建一个账号Account模型
        3.PHLoginViewModel应该保存着账号信息Account模型。
        4.需要时刻监听Account模型中的账号和密码的改变，怎么监听？
        5.在非RAC开发中，都是习惯赋值，在RAC开发中，需要改变开发思维，由赋值转变为绑定，可以在一开始初始化的时候，就给Account模型中的属性绑定，并不需要重写set方法。
        6.每次Account模型的值改变，就需要判断按钮能否点击，在VM模型中做处理，给外界提供一个能否点击按钮的信号.
        7.这个登录信号需要判断Account中账号和密码是否有值，用KVO监听这两个值的改变，把他们聚合成登录信号.
        8.监听按钮的点击，由VM处理，应该给VM声明一个RACCommand，专门处理登录业务逻辑.
        9.执行命令，把数据包装成信号传递出去
        10.监听命令中信号的数据传递
        11.监听命令的执行时刻
4.代码实现

4.1 控制器的代码

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) PHLoginViewModel *phLoginVM;
@end

@implementation ViewController

- (PHLoginViewModel *)phLoginVM
{
    if (_phLoginVM == nil) {
        _phLoginVM = [[PHLoginViewModel alloc] init];
    }
    return _phLoginVM;
}

// MVVM:
// VM:视图模型,处理界面上所有业务逻辑
// 每一个控制器对应一个VM模型
// VM:最好不要包括视图V
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self phBindViewModel];

    [self phLoginEvent];
}

// 绑定viewModel
- (void)phBindViewModel
{
    // 1.给视图模型的账号和密码绑定信号
    RAC(self.phLoginVM, account) = _accountField.rac_textSignal;
    RAC(self.phLoginVM, pwd) = _pwdField.rac_textSignal;

}

// 登录事件
- (void)phLoginEvent
{
    // 1.处理文本框业务逻辑
    // 设置按钮能否点击
    RAC(_loginBtn, enabled) = self.phLoginVM.phLoginEnableSiganl;

    // 2.监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       // 处理登录事件
        [self.phLoginVM.phLoginCommand execute:nil];
    }];
}


4.2 VM的代码

VM.h的代码
// 保存登录界面的账号和密码
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;

// 处理登录按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *phLoginEnableSiganl;

///** 登录按钮命令 */
@property (nonatomic, strong, readonly) RACCommand *phLoginCommand;
VM.m的代码
- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

// 初始化操作

- (void)setup
{
    //1.处理登录点击的信号
    _phLoginEnableSiganl = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *account, NSString *pwd){

        return @(account.length && pwd.length);
    }];

    //2.处理登录点击命令
    _phLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 发送数据
                [subscriber sendNext:@"请求登录数据"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];

    //3.处理登录请求返回的结果
    [_phLoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    //4.处理登录执行过程
    [[_phLoginCommand.executing skip:1] subscribeNext:^(id x) {

        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在登录ing......"];
        } else {
            // 执行完成
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            NSLog(@"执行完成");
        }
    }];
}

3.ReactiveCocoa + MVVM 网络请求数据

1.需求

请求豆瓣音乐信息，url:https://api.douban.com/v2/book/search?q=经典
2.分析

请求一样，交给VM模型管理
3.步骤

        1.控制器提供一个视图模型（PHRequesViewModel），处理界面的业务逻辑
        2.VM提供一个命令，处理请求业务逻辑
        3.在创建命令的block中，会把请求包装成一个信号，等请求成功的时候，就会把数据传递出去。
        4.请求数据成功，应该把字典转换成模型，保存到视图模型中，控制器想用就直接从视图模型中获取。
        5.假设控制器想展示内容到tableView，直接让视图模型成为tableView的数据源，
          把所有的业务逻辑交给视图模型去做，这样控制器的代码就非常少了。
4.控制器的代码

@interface ViewController ()
/** 请求视图模型 */
@property (nonatomic, strong) PHRequestViewModel *phRequestVM;
@end

@implementation ViewController

- (PHRequestViewModel *)phRequestVM
{
    if (_phRequestVM == nil) {
        _phRequestVM = [[PHRequestViewModel alloc] init];
    }
    return _phRequestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建tableView

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self.phRequestVM;
    self.phRequestVM.tableView = tableView;
    [self.view addSubview:tableView];

    // 执行请求
    [self.phRequestVM.phRequestCommand execute:nil];
}

5.VM的代码

@interface PHRequestViewModel : NSObject<UITableViewDataSource>

// 请求命令
@property (nonatomic, strong, readonly) RACCommand *phRequestCommand;

// 模型数组
@property (nonatomic, strong, readonly) NSArray *models;
// 控制器中的view
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation PHRequestViewModel
- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _phRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 执行命令
        // 发送请求

        // 创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           // 创建请求管理者
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:@"https://api.douban.com/v2/music/search" parameters:@{@"q":@"经典"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                // 请求成功的时候调用
                NSLog(@"%@",responseObject);
                // 输出plist文件
                [responseObject writeToFile:@"/Users/apple/Desktop/yinyue.plist" atomically:YES];

                // 请求成功的时候调用

                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {


            }];

            return nil;
        }];

         // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [signal map:^id(NSDictionary *value) {
            NSMutableDictionary *dictArr = value[@"musics"];

             // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {

                return [PHMusic ph_MusicWithDict:value];
            }] array];
            return modelArr;
        }];
    }];

    // 获取请求的数据

    [_phRequestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
       // 有了新数据
        _models = x;
        // 刷新表格
        [self.tableView reloadData];
    }];

}

# pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    PHMusic *music = self.models[indexPath.row];
    cell.textLabel.text = music.title;
    cell.imageView.image = [UIImage imageNamed:music.image];

    return cell;
}

噶梨给给的博客
ReactiveCocoa应用－1
1.简介
  ReactiveCocoa（简称为RAC）,是由Github开源的一个应用于iOS和OS开发的新框架,Cocoa是苹果整套框架的简称，因此很多苹果框架喜欢以Cocoa结尾。
2.作用
  在我们iOS开发过程中，当某些事件响应的时候，需要处理某些业务逻辑,这些事件都用不同的方式来处理。比如按钮的点击使用action，ScrollView滚动使用delegate，属性值改变使用KVO等系统提供的方式。其实这些事件
  ，都可以通过RAC处理。ReactiveCocoa为事件提供了很多处理方法，而且利用RAC处理事件很方便，可以把要处理的事情，和监听的事情的代码放在一起，这样非常方便我们管理，就不需要跳到对应的方法里。
3.编程风格
 函数式编程（Functional Programming）
 响应式编程（Reactive Programming）
 所以，你可能听说过ReactiveCocoa被描述为函数响应式编程（FRP）框架。以后使用RAC解决问题，就不需要考虑调用顺序，直接考虑结果，把每一次操作都写成一系列嵌套的方法中。
4.导入
 使用pods导入
5.创建与使用
 5.1 RACSignal
   RACSignal是RAC中最核心的类，整个RAC框架主要就是将事件的触发绑定到信号上，然后在需要做处理的地方订阅信号，当事件触发的时候，订阅者就能够收到相应的消息来同步处理一些事情，所谓的信号，
   就是这个RACSignal类。
RACSignal类的一些绕弯子的地方：
1 RACSignal只是一个信号，但是它自己不能主动的去发送，它只是一个信号，自己不能够主动的去做事情。
2 创建了一个RACSignal类后，如果没有订阅这，即使RACSignal的事件触发了，也不会有信号触发。只有存在订阅者的时候，信号才会触发。
 创建
+ (RACSignal *)createSignal:(RACDisposable * (^)(id subscriber))didSubscribe {
RACSignal *signal = [[RACSignal alloc] init];
signal.didSubscribe = didSubscribe;
return [signal setNameWithFormat:@"+createSignal:"];
}
这个方法是RACSignal的类方法，返回值是一个RACSignal类的对象，传入参数是一个名字为didSubscribe的block，这个block的返回值是一个RACDisposable类的对象，
传入参数是一个实现了RACSubscriber协议的对象。方法内部流程：第一步：创建了一个RACSignal对象signal。第二步：将方法中的名为didSubscribe的block参数赋值给signal.didSubscribe属性。
第三步然后返回这个signal对象

@property (nonatomic, copy) RACDisposable * (^didSubscribe)(id subscriber);

可以看到，signal.didSubscribe的block类型就是createSignal方法中的didSubscribe

创建一个RACSignal对象  

RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id didSubscribe) {
        
        NSLog(@"信号触发");
        
        [didSubscribe sendNext:@"消息"];//didSubscribe是订阅者
        [didSubscribe sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号处理完成");
        }];
    }];

block中存放的这段代码就是createSignal方法中的didSubscribe参数，方法中传入的参数(id didSubscriber)就是这个信号的订阅者对象，这个protocol中最常用的两个方法：

@protocol RACSubscriber
@required
// 发送当前的信号给订阅者.
// value - 信号传递的值，可以为空
- (void)sendNext:(id)value;
// 发送完成状态给订阅者.
//
// 结束订阅, 并销毁订阅者 (之后该订阅者不能够在订阅这个信号).
- (void)sendCompleted;

createSignal中的didSubscribe存放的就是被订阅后触发的命令，当一个信号被订阅的同时，就会执行didSubscribe中的命令。

订阅信号使用的是RACSignal对象的subscribeNext方法：
  [signal subscribeNext:^(id x) {
        NSLog(@"收到了: %@", x);
    }];
//信号触发
//收到了: 消息
//信号处理完成
当RACSignal对象调用subscribeNext的时候，就是订阅了这个RACSignal对象，同时就会执行之前RACSignal对象通过createSiganl方法中的名为didSubscribe的block参数中存放的代码块，当代码块中的sendNext方法之行后，
就会调用subscribeNext方法的nextBlock代码块中的命令，然后调用sendCompleted命令确认信号完成，销毁订阅，最后通过createSignal:中block参数返回的RACDisposable对象完成收尾。

  RACSubject
    可以看到，RACSignal不能够自己主动发送信号，只是在被订阅的时候，调用didSubscribe来发送，如果要让信号主动发送一些内容，需要使用另一个类RACSubject，这里看一下RACSubject的继承关系，
    其实它就是继承自RACSignal，然后自己遵守了RACSignal的createSignal方法中的subscriber参数所遵守的那个RACSubscriber协议：
@interface RACSubject : RACSignal
 
// Returns a new subject.
+ (instancetype)subject;
 
@end

RACSubject的创建之通过一个subject的类方法即可，创建后订阅这个信号后再发送，订阅者就能够收到：
   RACSubject *subject = [RACSubject subject];
    NSLog(@"%@", subject);

    [subject subscribeNext:^(id x) {
        NSLog(@"1接收到: %@", x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"2接收到: %@", x);
    }];
    [subject sendNext:@"信号"];
//1接收到: 信号
//2接收到: 信号

信号的发送和订阅可以在两个地方分别实现，这样可以实现类似于代理的回调：
创建一个二级界面，声明一个RACSubject对象：
@interface SecondViewController : UIViewController
 
@property (nonatomic, strong) RACSubject *delegateSignal;
 
@end

点击事件
[[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@"来自远方的问候"];
        }
    }];

在上级界面中，创建二级控制器的RACSubject对象，同时订阅这个信号：
 SecondViewController *secondViewController = [[SecondViewController alloc] init];
    secondViewController.delegateSignal = [RACSubject subject];
    [secondViewController.delegateSignal subscribeNext:^(id x) {
        NSLog(@"收到了远方的回调: %@", x);
    }];
    
    [self presentViewController:secondViewController animated:YES completion:nil];
//收到了远方的回调: 来自远方的问候
这样就完成发送信号，订阅者就能够收到回调。

5.2，RACCommand
RACCommand是用来包装RACSignal的一个类，可以把RACSignal包装成命令段形式，可以用execute方法执行这个命令，而且可以监听到内部的执行状态。
          RACCommand初始化的方法是initWithSignalBlock，在block中返回一个RACSignal对象：
 RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id subscriber) {
            //延时2s，模仿网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"数据"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
        
        return [signal map:^id(NSString *string) {
            return [NSString stringWithFormat:@"加工过的%@", string];
        }];
    }];
  进一步监听command的状态：
 [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在请求");
        }else{
            NSLog(@"请求完毕");
        }
    }];

通过execute方法执行命令，其实就是相当于订阅command内部的signal，execute方法返回一个RACSignal对象，所以可以直接订阅它来接受信号：
   [[command execute:nil] subscribeNext:^(id x) {
        NSLog(@"请求到 %@", x);
    }];
//正在请求
//请求到 加工过的数据
//请求完毕

5.3，RACSequence
       RACSequence是针对集合类操作定义的一个类，可以用来做遍历：
  NSArray *array = @[@1,@2,@3,@4,@5];
    [array.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    NSDictionary *dict = @{@"name" : @"Joker", @"age" : @"0"};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@ : %@", key, value);
    }];
      字典的遍历返回的是RACTuple类，读取内部的值用RACTupleUnpack解包


ReactiveCocoa应用－2 
1.监听方法的调用
  rac_signalForSelector可以用来监听一个对象方法的调用，当方法调用的时候，就能收到回调：


UIViewController *xxxViewController = [[UIViewController alloc]init];
[[xxxViewController rac_signalForSelector:@selector(touchesBegan:withEvent:)]subscribeNext:^(idx)
{
 NSLog(@"xxxViewController- touchesBegan:withEvent:");
}];


 [self presentViewController:xxxViewController animated:YES completion:nil];

当二级界面点击事件触发，就会收到回调，这个可以用来替代代理。

2.监听控制事件


可以用来监听控制事件，如按钮的点击：




 [[button rac_signalForControlEvents:UIControlEventTouchDown]subscribeNext:^(idx)

{
        //按钮点击对应的操作
}];



用来替换addTarget方法


3.监听文本改变
[self.textField.rac_textSignal subscribeNext:^(idx)

{
    NSLog(@"当前的文字：%@",x);
 }];
textField文字改变的时候，订阅者就会收到

4.监听属性 

用来监听某个对象的某个属性的改变，格式为：RACObserve(要监听的对象， 要监听对象的属性)：

[RACObserve(self.label,text)subscribeNext:^(idx)

{
  NSLog(@"当前Label的文字：%@",x);
}];
当UILabel的text改变时，订阅者就能收到


4.属性绑定

将某个对象的属性和信号绑定起来，当订阅者收到信号的同时，改变对象的属性，格式为：RAC(对象，对象的属性) =
RACSignal对象
//textField输入改变的同时改变label的文字
RAC(self.label,text)= self.textField.rac_textSignal;


ReactiveCocoa应用－3 

RAC+MVVM
  写一个例子，利用ReactiveCocoa实现一个最简单的登录界面，通过：MVC->MVC ＋ RAC ->MVVM ＋RAC 来一步一步的过渡代码
先提前定义下登陆界面的需求：一共需要两个输入框输入账号和密码，一个登陆按钮进行登陆操作。账号和密码必长度须在1-6位之间，登录按钮默认为不可点击状态，当账号和密码同时不为空且满足长度条件时，登录按钮变为可点击状态，点击按钮完成登录操作
1.MVC
 通过controlEvents来监听textField的改变，来监听两个输入框内容的改变，同时根据两个输入框内容长度来实时改变按钮的状态
#pragma mark - MVC
- (void)setMVC
{
     [self.nameTextField addTarget:self action:@selector(nameTextFieldEditChanged) forControlEvents:UIControlEventEditingChanged];
      self.nameTextField.backgroundColor = [UIColor blueColor];

    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldEditChanged) forControlEvents:UIControlEventEditingChanged];
    self.passwordTextField.backgroundColor = [UIColor blueColor];
    
    self.loginButton.enabled = NO;
    
    [self.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchDown];
}
 
- (void)nameTextFieldEditChanged
{
    self.account.account = self.nameTextField.text;
    
    self.nameTextField.backgroundColor = self.nameTextField.text.length <= 6 ? [UIColor blueColor] : [UIColor redColor];
    
    self.loginButton.enabled = self.nameTextField.text.length && self.nameTextField.text.length <= 6 && self.passwordTextField.text.length && self.passwordTextField.text.length <= 6;
}
 
- (void)passwordTextFieldEditChanged
{
    self.account.password = self.nameTextField.text;
    
    self.passwordTextField.backgroundColor = self.passwordTextField.text.length <=  6 ? [UIColor blueColor] : [UIColor redColor];
    
    self.loginButton.enabled = self.nameTextField.text.length && self.nameTextField.text.length <= 6 && self.passwordTextField.text.length && self.passwordTextField.text.length <= 6;
}
 
- (void)loginButtonClick:(UIButton *)sender
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"登录成功:%@", self.account.account);
    });
}

2.MVC+RAC
  信号的定义绑定和监听都在Controller中实现，这里可以看到同样的效果，用RAC只需要定义一个方法就可以了，代码量大幅度减少，使可读性更高
#pragma mark - MVC+RAC
- (void)setRAC
{
    RAC(self.account, account) = self.nameTextField.rac_textSignal;
    RAC(self.account, password) = self.passwordTextField.rac_textSignal;
    RACSignal *loginButtonEnableSignal = [RACSignal combineLatest:@[RACObserve(self.account, account), RACObserve(self.account, password)] reduce:^id(NSString *account, NSString *password){
        return @(account.length && password.length && account.length < 7 && password.length < 7);
    }];
    
    RAC(self.loginButton, enabled) = loginButtonEnableSignal;
    
    RAC(self.nameTextField, backgroundColor) = [RACObserve(self.account, account) map:^id(NSString *value) {
        return value.length > 6 ? [UIColor redColor] : [UIColor blueColor];
    }];
    
    RAC(self.passwordTextField, backgroundColor) = [RACObserve(self.account, password) map:^id(NSString *value) {
        return value.length > 6 ? [UIColor redColor] : [UIColor blueColor];
    }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"登录成功:%@", self.account.account);
        });
    }];
}

3.MVVM+RAC
  将Controller中关于Model的值监听和Model值改变的同时对View的影响判断等相关的业务全都交给ViewModel去做，Controller主要的作用就是将View和ViewModel关联起来。最后还是要说一下，并不是用了RAC就是MVVM，是不是MVVM取决于有没有ViewModel，而不是有没有RAC，没有RAC也是可以实现MVVM的
ViewModel：

@interface JKRLoginViewModel : NSObject
@property (nonatomic, strong) JKRAccount *account; 
@property (nonatomic, strong) RACSignal *enableLoginSignal;
@property (nonatomic, strong) RACSignal *accountTextFieldBackgroundColorSignal;
@property (nonatomic, strong) RACSignal *passwordTextFieldBackgroundSignal; 
@property (nonatomic, strong) RACCommand *LoginCommand;
@end

#import "JKRLoginViewModel.h"

@implementation JKRLoginViewModel
 
- (JKRAccount *)account
{
    if (!_account) {
        _account = [[JKRAccount alloc] init];
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
 
- (void)initialBind
{
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account), RACObserve(self.account, password)] reduce:^id(NSString *account, NSString *password){
        return @(account.length && password.length && account.length < 7 && password.length < 7);
    }];
    
    _accountTextFieldBackgroundColorSignal = [RACObserve(self.account, account) map:^id(NSString *string) {
        return string.length > 6 ? [UIColor redColor] : [UIColor blueColor];
    }];
    
    _passwordTextFieldBackgroundSignal = [RACObserve(self.account, password) map:^id(NSString *string) {
        return string.length > 6 ? [UIColor redColor] : [UIColor blueColor];
    }];
    
    __weak typeof(self) weakSelf = self;
    
    _LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"点击了登录");
        
        return [RACSignal createSignal:^RACDisposable *(id subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[NSString stringWithFormat:@"登录成功:%@", weakSelf.account.account]];
                
                [subscriber sendCompleted];
            });
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"登录信号完成");
            }];
        }];
    }];
    
    [_LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:@"登录成功"]) {
            NSLog(@"登录成功");
        }
    }];

    [[_LoginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            NSLog(@"登录中");
        }else{
            NSLog(@"登录完成");
        }
    }];
}
@end

Controller：
#pragma mark - MVVM+RAC
- (void)bindModel
{
    RAC(self.loginViewModel.account, account) = self.nameTextField.rac_textSignal;
    RAC(self.loginViewModel.account, password) = self.passwordTextField.rac_textSignal;

    RAC(self.loginButton, enabled) = self.loginViewModel.enableLoginSignal;

    RAC(self.nameTextField, backgroundColor) = self.loginViewModel.accountTextFieldBackgroundColorSignal;

    RAC(self.passwordTextField, backgroundColor) = self.loginViewModel.passwordTextFieldBackgroundSignal;

    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(id x) {
        [[self.loginViewModel.LoginCommand execute:nil] subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }];
}


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
 
 
 78、自己动手搭建VPN服务器
2017年12月06日 16:48:07
阅读数：4063
1.注册vultr服务，选择2.5美元/月套餐
https://my.vultr.com/  sbpdcfn@126.com Snrifk81...   系统帐号：root snrifk81...
2.SSH 客户端登陆服务器（此处选用xshell）
3.安装启动shadowsocks服务
apt-get update
apt-get install shadowsocks

CentOS:
$ yum install python-setuptools && easy_install pip
$ pip install shadowsocks
4.启动shadowsocks服务
ssserver -p 8999 -k  你的密码 -m rc4-md5 -d start
5.自动启动shadowsocks服务
1)将你的启动脚本复制到/etc/init.d目录下（以下假设你的脚本为vpnRun）
vim /etc/init.d/vpnRun.sh
#!/bin/bash
ssserver -p 8999 -k 你的密码 -m rc4-md5 -d start
exit 0


2)设置脚本文件的权限
$sudo chmod 775 /etc/init.d/vpnRun.sh


3)执行如下命令脚本放到启动脚本中去
$cd /etc/init.d/
ln -s vpnRun.sh /etc/rc5.d/S95vpnRun


/*
3)执行如下命令脚本放到启动脚本中去
$cd /etc/init.d/
$sudo update-rc.d vpnRun.sh defaults 95
sudo update-rc.d vpnRun.sh defaults 90
需要注意的是数字95是脚本的启动顺序号，按照自己的需要相应的修改即可。在你有多个启动脚本，而它们之间又有先后启动的依赖关系时你就知道这个数字的具体作用了。


4)卸载启动脚本
$cd /etc/init.d
$sudo update-rc.d -f vpnRun.sh remove
*/

78-----2

作为一名程序员，难免会需要访问“外网”，查找资料 
我查阅了相关资料，发现去买一个VPN账号并不划算，价格和自己买一个VPS差不多 
于是我决定自己搭建一个VPN

一、选择合适的VPS

什么是VPS请自己百度吼 
国外常见的VPS有很多，如Linode、Vultr、SugarHosts等，具体请看该网站https://www.vpser.net/ 
我选择的是Vultr，他们家有$2.5/月的廉价VPS，每月500G流量，当然，能不能抢到货就看你们自己咯

具体购买流程我就不多说了（买东西应该不用教吧，哈哈哈哈）

二、正式开始

操作系统：CentOS 7 
搭建VPN的方式有很多，我也只查阅了ss的搭建方式。略略略

第一步：搭建ss

啥是ss？？？ss是shadowsocks的简称，一个可穿透防火墙的快速代理（官方文档）

CentOS:
$ yum install python-setuptools && easy_install pip
$ pip install shadowsocks

# 其他操作系统请查看官方文档
1
2
3
4
5
第二步：编写ss配置

$ vim /etc/shadowsocks.json

# 如果提示 vim: command not found
# 可以使用 vi /etc/shadowsocks.json
# vi 是linux系统下标准的编辑器，类似于windows的记事本
# vim 需要另外安装
1
2
3
4
5
6
如果不懂 vi 怎么使用，请自行百度

填入下列json信息（单用户，多用户，选择其中一种)

/****** 单用户 ******/
{
    "server":"120.0.0.1", // 这里填写你的服务器外网IP
    "server_port":8388,   // 这是你要连接ss的端口
    "local_address":"120.0.0.1", // 默认填写120.0.0.1即可
    "local_port":1080, // 默认填写1080即可
    "password":"password", // 密码
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false
}
/****** 多用户 ******/
{
    "server":"120.0.0.1", // 你的服务器外网IP
    "port_password": {
        "8381":"password1",
        "8382":"password2",
        "8383":"password3"    // 最后一个账户后面没","，加上就报错
    },
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false
}
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
第三步：配置开机启动

$ vim /etc/rc.local
1
填写

ssserver -c /etc/shadowsocks.json -d start
1
第四步：开启端口

注意：接下来开始对CentOS的版本有要求了！

我使用的是CentOS 7 ！！！ 
CentOS 6 的童鞋们我会在下面给相关链接，请自行查阅！！！

# 查看已开放端口
$ firewall-cmd --list-ports

# 开启端口 以开启8388端口为例
$ firewall-cmd --zone=public --add-port=8388/tcp --permanent

# 重启防火墙
$ firewall-cmd --reload
1
2
3
4
5
6
7
8
CentOS 7 以下版本请看这里 Centos 7和 Centos 6开放查看端口 防火墙关闭打开

第五步：安装serverspeeder加速（ TCP 加速引擎）

安装

# 安装
$ wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh

# 卸载
$ chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f
1
2
3
4
5
当然，在你安装的时候，有很大可能会报内核不支持 
这个时候就需要修改Linux内核了，一定要选择对应系统版本的内核，不然VPS可能会die

CentOS 7 内核更换（内核：3.10.0-327.el7.x86_64）

# 安装 3.10.0-327.el7.x86_64 内核
$ rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force
1
2
3
如果安装内核的时候报错 
The name of network interface is not eth0, please retry after changing the name 
那么请执行下面这个命令，没报错就不用了

$ yum install net-tools -y
1
查看内核是否安装成功

$ rpm -qa | grep kernel
# 如果打印出来的信息里存在 3.10.0-327.el7.x86_64 ，说明安装成功
1
2
重启VPS

$ reboot
1
查看当前使用内核版本

$ uname -r 
# 3.10.0-327.el7.x86_64
1
2
至此，再执行一下serverspeeder安装命令，就万事大吉了！！！

最后一步

# 启动ss
$ ssserver -c /etc/shadowsocks.json -d start
# 停止ss
$ ssserver -c /etc/shadowsocks.json -d stop
ss客户端下载地址

Windows  https://github.com/shadowsocks/shadowsocks-windows/releases

Mac OS  https://github.com/shadowsocks/ShadowsocksX-NG/releases

Linux  https://github.com/shadowsocks/shadowsocks-qt5/releases

IOS  https://github.com/shadowsocks/shadowsocks-iOS/releases

Android  https://github.com/shadowsocks/shadowsocks-android/releases





79、html5学习

框架：
sencha-touch
phoneGap
jQuery mobile跨平台
Bootstrap

开发方式：
原生，html5，原生结合html5

网页由三部份组成：
html,css,javascript

<!--根标签-->
<html>
   <!--头部-->
   <head>
      <!--标题标签-->
      <title>我的第一个程序</title>
      <!--设置编码-->
      <meta charset="UTF-8">
   </head>
   <!--主要内容-->
   <body>
       <div>你好,世界!</div>
   </body>
</html>
<!--HTML中的标签-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>常见的HTML的标签</title>
</head>
<body>
    <!--标题标签-->
    <h1>我是h1标签</h1>
    <h2>我是h2标签</h2>
    <h3>我是h3标签</h3>
    <h4>我是h4标签</h4>
    <h5>我是h5标签</h5>
    <h6>我是h6标签</h6>
    <hr>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>
        <div>
            <p>我是段落</p>
        </div>
    </div>

    <!--表单标签-->
    <input placeholder="我是占位文字"><br><br><br><br>
    <input value="我是默认的文字"><br>
    <input type="date"><br>
    <input type="file"><br>
    <input type="color"><br>
    <input type="radio"><br>
    <input type="checkbox"><br>

    <!--段落标签-->
    <p>我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签</p>
    <p>我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签</p>
    <p>我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签</p>
    <p>我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签</p>

    <!--图像标签-->
    <!--
      相对路径和绝对路径:
      相对路径: 资源在当前的项目中  ./  ../ ././
      绝对路径: 资源不在当前的项目中 网络上  本地  http://  https:// ftp://  file:///
http://localhost:63342/%E4%BB%A3%E7%A0%81/01-HTML%E7%9A%84%E5%9F%BA%E6%9C%AC%E8%AF%AD%E6%B3%95/img/img_01.jpg
    -->
   <a href="http://www.520it.com" target="_blank">
       <img src="http://www.520it.com/userfiles/1/images/cms/site/2015/09/index_06.jpg" alt="这是一张图片" width="20%" />
   </a>

    <img src="img/img_01.jpg" width="150" />

    <!--换行标签-->
    <br>

    <!--列表标签-->
    <!--无序列表-->
    <ul>
        <li>我是无序列表</li>
        <li>我是无序列表</li>
        <li>我是无序列表</li>
        <li>我是无序列表</li>
        <li>我是无序列表</li>
    </ul>

    <!--有序列表-->
    <ol type="I">
        <li>我是有序列表</li>
        <li>我是有序列表</li>
        <li>我是有序列表</li>
        <li>我是有序列表</li>
        <li>我是有序列表</li>
    </ol>

    <!--超链接标签-->
    <a href="#">我是超链接</a>
    <a href="http://www.baidu.com" target="_blank">百度一下,你就知道</a>

    <!--div标签-->
    <hr>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
    <div>我是div标签我是div标签我是div标签我是div标签</div>
</body>
</html>

href和src的区别：

href是引用,相当于iOS中的import,不是必需的.(比如<link>,<a>,...)
src是引入,是必需的,没有这个资源,标签就用不起来.(比如<img>,<audio>,<video>,...)

双标签(首尾呼应,内部可以层层嵌套)<HTML中大部分是双标签>相当于容器
单标签(<img>,<meta>,<input>...)


html5中新增标签

                   

结构性标签： 用来描述如一篇报纸的新闻，有标题，文章内容，辅助信息，导航等，这些标签是会自动缩放的
1. section
表示页面中的一个内容区块，比如章节，页眉等,该标签呢我们同样可以把他理解为一个容器，或者说是一个大容器，
主要功能其实就是进行分区，报纸大家也都见过，有很多不同的板块，当我们开发一个页面进行功能分拆的时候，这就需要<section/>了。
2. article
表示页面中的一块与上下文不相关的内容。
3. header
这个主要是用来存放标题的了，很好理解。
4. footer
内容区块的脚注，比如编写一些底部一些公司信息
5. nav
导航链接的部分
新增加的标签我感觉目前的使用还不是很多，目前多数网站还是<div/>,<span/>之类的，不过作为知识还是应该了解一下啦

例：
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>一个papi酱，老总讲了又讲，丽人丽妆咋这么急？--百度百家</title>
</head>
<body>
   <!--文章-->
   <article>
       <!--头部-->
       <header>
           <h2>一个papi酱，老总讲了又讲，丽人丽妆咋这么急？</h2>
           <h4>分类 :互联网</h4>
           <img src="img/share.png">
       </header>
       <!--主要内容-->
       <img src="http://g.hiphotos.baidu.com/news/crop%3D0%2C1%2C415%2C249%3Bw%3D638/sign=b11ea766412309f7f320f7524f3e20c2/e61190ef76c6a7ef304f1ad4fafaaf51f2de66d3.jpg" width="40%">
       <section>
           <h3>丽人丽妆快炒过头了</h3>
           <p>看它借助PAPI酱炒作用心，除了这类人物具有爆款价值外，可能还有借机传播公司价值、后续融资、IPO的用意。当然，阻击对手的用心似乎也在流露。</p>
           <p>当初嫁接PAPI酱被质疑是个内部循环、营销噱头，罗振宇、黄韬、阿里的关系，确实容易引发外界质疑。不过，如果丽人丽妆最后真金白银地掏了，那也是不错的品牌传播案。声量上来，无所谓好坏。</p>
       </section>
       <section>
           <h3>丽人丽妆这家公司风格，确实本不像今日</h3>
           <p>它的商业模式有些看点，但也谈不上特别出奇。它从化妆品代运营模式走出来，走向所谓真零售，自采自销，与许多国内外化妆品品牌建立了授权合作，崇尚的是所谓“网上专柜”。</p>
       </section>
       <!--尾部-->
       <footer>
           <h3>版权声明</h3>
           <div>本文仅代表作者观点，不代表百度立场。</div>
           <div>本文系作者授权百度百家发表，未经许可，不得转载。</div>
       </footer>
   </article>
</body>
</html>

极块性标签：
完成web页面区域的划分，确保内容有效的分隔
aside
表示出article之外的，与article元素相关内容的辅助信息。
figure 对多个元素组合并展示的元素，常与figcaption联合使用，很少用
code 表示一段代码块，很多浏览器不支持
dialog qq聊天中的汽泡，一般不常用


行内语义性标签:
丰富展示内容
meter:表示特定范围内的百分比，如用电量，工资，数量百分比
time:显示时间，目前所有的浏览器都不支持
progress：表示进度
audio：播放音频
video：播放视频

交互性标签：
detail
datagrid
menu 所有主流浏览器均不支持 menu 元素
command 目前只有 Internet Explorer 支持 <command> 标签


例：
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
 <meter value="30" max="100" min="0">浏览器兼容</meter>
 <progress value="40" max="100"></progress>

  <!--音频-->
  <audio src="source/music.m4a" controls="controls"></audio>//controls是播放器必须的
  <video src="source/BigBuck.m4v" controls="controls"></video>
</body>
</html>

css层叠相式表：
用来控制html5的样式
编写格式：键值对方式
color:red;
background-color:blue;
font-size:20px;

css的三种书写形式：
行内样式： 在标签的style属性中写<body style="color:red">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSS的行内样式</title>
</head>
<body>
   <div style="color: blue; font-size: 28px; background-color: aqua;">我是容器标签</div>
   <p style="color: red; font-size: 60px; border:5px dashed purple">我是段落标签</p>
   <div>我是容器标签</div>
   <div>我是容器标签</div>
   <div>我是容器标签</div>
   <div>我是容器标签</div>
   <div>我是容器标签</div>
   <p>我是段落标签</p>
   <p>我是段落标签</p>
   <p>我是段落标签</p>
   <p>我是段落标签</p>
   <p>我是段落标签</p>
   <p>我是段落标签</p>
</body>
</html>

页内样式：在本网页的style标签中书写
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSS的页内样式</title>
    <!--
      css的规律:
      1. 就近原则
      2. 叠加原则
    -->
    <link href="css/index.css" rel="stylesheet">
    <style>
        div{
            color:red;
            font-size: 30px;
            border: 4px solid yellow;
        }

        p{
            color: blue;
            font-size: 44px;
            background-color: yellowgreen;
        }
    </style>

    <!--
       网站 =  N个网页 + 服务器 + 数据库 + ....
    -->
</head>
<body>
    <div>我是容器标签</div>
    <div>我是容器标签</div>
    <div>我是容器标签</div>
    <div>我是容器标签</div>
    <div>我是容器标签</div>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
</body>
</html>

外部样式：在单独的CSS文件中书写，然后在网页中用link标签引用，可以共享使用css样式
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSS的外部样式</title>
    <!--引用外部的样式-->
    <link rel="stylesheet" href="css/index.css">//rel 关系
</head>
<body>
    <div>我是容器标签</div>
    <div>我是容器标签</div>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
</body>
</html>

index.css
div{
   color: olivedrab;
   font-size: 66px;
   background-color: greenyellow;
}

p{
    color: goldenrod;
    font-size: 2px;
    border: 2px dashed darkolivegreen;//宽度，线条虚线，双线
}


css的选择器

标签选择器：根据标签的名称选择样式
div{
   color: olivedrab;
}

类选择器：
.high{
   color: olivedrab;
}
<div class="high">我是容器标签</div>
<div class="high">我是容器标签</div>

id选择器：一一对应
#id{
   color: olivedrab;
}
<div class="first">我是容器标签</div>

并列选择器： 相当于或
div, .high{
   color: olivedrab;
}
<di>我是容器标签</div>
<div class="high">我是容器标签</div>

复合选择器：逻辑与针对单个标签，找到class为high的p标签,中间不能有空格
p.high{
   color: olivedrab;
}
<div class="high">我是容器标签</div>
<div>我是容器标签</div>
<div>我是容器标签</div>
<p class="high">我是容器标签</div>

后代选择器：中间必须有空格
方式1：
div div span{
   color: olivedrab;
}
方式2：
div span{
   color: olivedrab;
}
<div class="high">
<p></p>
<div><span></span></div>
</div>


直接后代选择器：中间没有空格
<div>a{
   color: olivedrab;
}
<div class="high">
<a></a>
<div><a></a></div>
</div>

相邻兄弟选择器:在div上面或者下面的第一个p标签会被选中
div+p{
   color: olivedrab;
}
<div class="high">
<a></a>
</div>
<p><a></a></p>
<p><a></a></p>

属性选择器:标签可以添加任意属性
<div>[name]{
   color: olivedrab;
}
<div>[name][age]{
   color: olivedrab;
}
<div>[name="high"]{
   color: olivedrab;
}
<div name="high">
</div>

<div name="high" age="20">
</div>

伪类选择器：在标签后面加一个:跟上属性，触发某些操作的时候去执行
:active 向被激活的元素添加样式
:focus  向拥有键盘输入焦点的元素添加样式  常用
:hover  当鼠标悬浮在元素上方时，向元素添加样式  常用
:link   向未被访问的链接添加样式
:visited 向已被访问的链接添加样式
:first-child 向元素的第一个子元素添加样式
:lang 向带有指定lang属性的元素添加样式

        /*伪类*/
input:focus{
            /*去除外线条*/
            outline: none;
            /*改变宽度和高度*/
            width: 500px;
            height: 50px;
            /*改变文字的大小*/
            font-size: 20px;
}
<input placeholder="我是输入框">

        /*当鼠标移动上来*/
        #main:hover{
            width: 300px;
            height: 200px;
            background-color: aqua;
        }
 <div id="main">我是div标签</div>
 
伪元素选择器：
:first-letter 向文本的第一个字母添加特死样式
:first-line  向文本的首行添加特殊样式
:before 在元素之前添加内容
:after  在元素之后添加内容

可用例子：
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSS的常见选择器</title>
    <style>
        /* 标签选择器 */
        div{
            color: red;
        }

        p{
            color: blue;
        }

        /* 类选择器 */
        .test1{
           color: green;
        }

        /*id选择器*/
        #main{
            font-size: 40px;
        }

        /*并列选择器*/
        #main, .test1{
           border: 1px solid rosybrown;
        }

        /*复合选择器*/
        p#test1{
            background-color: yellow;
        }

        /*后代选择器*/
        div sapn{
            color: red;
        }

        /*直接后代选择器*/
        div.test1>a{
           color: green;
        }

        /*伪类*/
        input:focus{
            /*去除外线条*/
            outline: none;
            /*改变宽度和高度*/
            width: 500px;
            height: 50px;
            /*改变文字的大小*/
            font-size: 20px;
        }

        /*当鼠标移动上来*/
        #main:hover{
            width: 300px;
            height: 200px;
            background-color: aqua;
        }
    </style>
</head>
<body>
    <div id="main">我是div标签</div>
    <!--<div id="main">我是div标签</div>-->
    <div>我是div标签</div>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p>我是段落标签</p>
    <p id="test1">我是段落标签</p>
    <div class="test1">
        我是div标签
        <a href="#">我是超链接</a>
        <div>
            <span href="#">我是二级链接</span>
        </div>
    </div>
    <br><br><br><br>
    <input placeholder="我是输入框">
</body>
</html>



选择器的优先级别：
 <title>选择器的优先级别</title>
    <!--
      css样式遵循的规律:
      1. 相同类型的选择器遵循: a.就近原则 b.叠加原则 class="test1 test2"
      2. 不同类型的选择器遵循:
         a> 选择器的针对性越强，它的优先级就越高
         b> 选择器的权值加到一起，大的优先；如果权值相同，后定义的优先
         c>
          important > 内联 > id > 类| 伪类 | 属性选择 | 伪元素 > 标签  > 通配符 > 继承

    -->
    <style>

        /*复合选择器*/
        div.test1{/*权值:10+1*/
            color: darkolivegreen;
        }

        div#main{/*权值:100+1*/
            color: chartreuse;
        }

        /*id选择器*/
        #main{/*权值:100*/
            color:deeppink;
        }

        #second{
            color: palegoldenrod;
        }


        /*类选择器*/
        .test1{/*权值:10*/
            color: blue;
        }

        .test2{/*权值:10*/
            color: yellow;
        }

        /*标签选择器*/
        div{/*权值:1*/
            color: red !important;//权值最高1000
        }

        /*
        通配符:
            1. 优先级别非常低
            2. 性能比较差
        */
        *{  /*权值:0*/
           font-size: 30px ;
        }
    </style>
</head>
<body>
   <div id="main" class="test1 test2" style="color: blue;">我是用来测试优先级别的</div>//类名有两个，test1 test2 ，id 只能有一个
</body>
</html>


标签的类型和修改标签的类型：
display: block;
display: inline;
display: inline-block;
display: none;//把某个标签隐藏掉

行内标签：多个标签同一行显示,宽度和高度取决于内容的尺寸，改不了它的宽高的
<span label a >

块级标签：一个标签独占一行，能够随时设置宽和高
<div p ul li h1 h2>

行内块级标签：前面两者优点集合，在同一行显示，可以改变高度宽度
<input button>

整个列子：
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>常见的标签的类型</title>
    <style>
        div{
            background-color: red;
            width: 200px;
            height: 80px;

            /*隐藏标签*/
            /*display: none;*/

            /*改变标签的类型: 块级--->行内标签*/
            /*display: inline;*/

            /*改变标签的类型: 块级--->行内-块级标签*/
            display: inline-block;
        }

        p{
            background-color: yellow;
            width: 100px;
            height: 80px;

            /*改变标签的类型: 块级--->行内标签*/
            /*display: inline;*/

            /*改变标签的类型: 块级--->行内-块级标签*/
            display: inline-block;
        }

        span{
            background-color: aqua;
            width: 300px;
            height: 90px;

            /*改变标签的类型: 行内--->块级标签*/
            /*display: block;*/

            /*改变标签的类型: 行内--->行内-块级标签*/
            /*display: inline-block;*/
        }

        button{
            width: 100px;
            height: 80px;
        }
    </style>
</head>
<body>

<!--块级标签-->
  <div>div标签</div>
  <p>段落标签</p>


<!--行内标签(内联标签)-->
  <span>我是行内标签</span>
  <span>我是行内标签</span>
  <span>我是行内标签</span>
  <a href="#">我是超链接</a>
  <a href="#">我是超链接</a>

<!--行内-块级标签-->
  <input>
  <button>我是按钮</button>
  <button>我是按钮</button>
</body>
</html>



css的属性，继承和不可继承
继承性划分方式：

可继承属性，父标签中的属性，会作用于子标签
一般是文字控制类的属性，控制文字样式的
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSS的可继承属性</title>
    <style>
        body{
           color: red;
           font-size: 30px;
        }
    </style>
</head>
<body>
    <div>我是块级标签</div>
    <span>我是行内标签</span>
    <button>我是行内-块级标签</button>
</body>
</html>

不可继承属性，父标签中属性是私有的，不可作用于子标签
一般是区块控制属性，如宽高
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        #main{
            background-color: red;
            width: 500px;
            height: 300px;
        }

        .test1{
            /*width: 100px;*/
            background-color: green;
        }
    </style>
</head>
<body>
    <div id="main">
        <div class="test1">我是里面的</div>
    </div>
</body>
</html>

常用的属性：
所有标签都可以继承：cursor控制光标的形状 visibility
display:none 同样隐藏，但不占位了
visibility：
visible	默认值。元素是可见的。
hidden	元素是不可见的。隐藏了，但是保留了占位
collapse	当在表格元素中使用时，此值可删除一行或一列，但是它不会影响表格的布局。
被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。
inherit	规定应该从父元素继承 visibility 属性的值。

内联标签可继承
letter-spacing、word-spacing、white-space、line-height、color、font、font-family、font-size、font-style、font-variant、font-weight、text-decoration、text-transform、direction
常用的：
line-height 行高
color
font 过期了
font-family 设置字体的样式，黑体。。
font-size
font-weight 是否加粗
text-decoration 对文本修饰，下划线，上划线等
块级标签可继承
text-indent 首行缩进
text-align  水平居中
列表标签可继承
list-style、list-style-type、list-style-position、list-style-image
常用的：list-style 列表的属性，列表的类型，主要用途是去除列表左边的标符号

不可继承属性
常用的：
display、margin、border、padding、background
height、min-height、max-height、width、min-width、max-width
overflow、position、left、right、top、bottom、z-index
float
不常用的：
clear
table-layout、vertical-align
page-break-after、page-bread-before
unicode-bidi

其它css属性：
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .test1{
            font-family: sans-serif;
            font-weight: bolder;
            /*添加到文本的修饰*/
            text-decoration: line-through;
        }

        p.test2{
            width: 250px;
            height: 100px;;
            background-color: orange;
            /*首行缩进*/
            text-indent: 2%;
            /*处理超出的内容:hidden直接裁剪*/
            overflow: scroll;
        }

        a{
            text-decoration: none;
        }

        ul{
            list-style: none;
        }

        div.test3{
            /*no-repeat:不平铺*/
            background: url("images/bg.jpeg") no-repeat;
            background-size: cover;
            width: 500px;
            height: 150px;
        }
    </style>
</head>
<body>
    <p class="test1">我是段落标签</p>
    <p class="test2">我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签我是段落标签</p>

    <a href="#">百度一下,你就知道</a>

    <ul>
        <li>1122121212121</li>
        <li>1122121212121</li>
        <li>1122121212121</li>
        <li>1122121212121</li>
    </ul>

    <div class="test3">设置背景</div>
</body>
</html>

盒子模型：每一个标签相当于一个盒子
content：装的文字图片
往外padding:盒子与内容之间的填充
boder:边框
margin:盒子与盒子之间

标准的盒子模型： 
content  padding-top padding-left padding-right padding-bottom
boder-top boder-left boder-right boder-bottom
margin-top margin-left margin-right margin-bottom

在goole,firefox,safair等支持3c标准的浏览器上，盒子的大小是content的大小
但在360等是支持ie标准的协议有所不同，盒子大小是算上boder为基础的

content的属性有哪些：
height  设置元素高度
max-height  设置元素最大高度，考虑到兼容性，最大上限
max-width
min-height  设置元素最小高度
min-width
width

padding的属性：
padding  设置所有的边距距离
padding-bottom
padding-left
padding-right
padding-top

padding :10px 5px 15px 20px; 上右下左
padding :10px 5px  上下10px 左右5px
padding :10px 5px 15px ; 上10px右左5px下15px
padding :10px; 4个内边距都为10px


border属性：
border:5px solid red;   宽度 样式 颜色
border-radius: 边框圆解

margin属性：
margin  所有外边距属性
margin-bottom 下边距属性
margin-left
margin-right
margin-top

margin :10px 5px 15px 20px; 上右下左
margin :10px 5px  上下10px 左右5px
margin :10px 5px 15px ; 上10px右左5px下15px
margin :10px; 4个外边距都为10px

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HTML的盒子模型</title>
    <style>
        *{
            margin: 0;
        }

        div{
            background: red;
            width: 250px;
            height: 140px;
            /*设置边框*/
            border: 2px solid black;
            /*设置内边距*/
            padding:10px;
            /*设置外边距*/
            margin: 30px;
        }
        p{
            background-color: blue;
            width: 200px;
            height: 130px;
        }
    </style>
</head>
<body>
   <div>演示盒子模型</div>
   <p>辅助</p>
</body>
</html>


css新增的一些特性

可以设置标签透明度：

rgba透明度 RGB(红色R+绿色G+蓝色B),RGBA则在其基础上增加了Alpha通道，可用于设置透明值
background-color: rgba(255,0,0,1.0);

块阴影与圆角阴影
box-shadow  text-shadow
 /*块阴影*/
 box-shadow: 10px 10px  10px purple;//水平（必选），cui直（必选） ，阴影朦胧，阴影颜色
/*文字阴影*/
text-shadow: 10px 10px 9px purple;

圆角
border-radius
border-top-left-radius: 100px;
border-bottom-right-radius: 100px;

边框图片
border-image


形变 动画
transform: none | <transform-function>[<transform-fuction>]


  <title>CSS3新增的特性</title>
    <style>
        div{
           width: 200px;
           height: 80px;
           margin: 30px;
           background-color: rgba(255,0,0,1.0);
            /*块阴影*/
           box-shadow: 10px 10px  10px purple;
            /*设置圆角*/
           /*border-radius: 20px;*/
            border-top-left-radius: 100px;
            border-bottom-right-radius: 100px;

        }

        div:hover{
            /*设置不透明度*/
            opacity: 0.1;
        }


        /*.test1{*/
            /*background-color: rgba(255,0,0,1.0);*/
        /*}*/

        /*.test2{*/
            /*background-color: rgba(255,0,0,0.8);*/
        /*}*/

        /*.test3{*/
            /*background-color: rgba(255,0,0,0.6);*/
        /*}*/

        /*.test4{*/
            /*background-color: rgba(255,0,0,0.4);*/
        /*}*/

        /*.test5{*/
            /*background-color: rgba(255,0,0,0.2);*/
        /*}*/

        .test6{
            color: red;
            font-size: 200px;
            /*文字阴影*/
            text-shadow: 10px 10px 9px purple;
        }
    </style>
</head>
<body>
   <div class="test1">1</div>
   <div class="test2">2</div>
   <div class="test3">3</div>
   <div class="test4">4</div>
   <div class="test5">5</div>

   <p class="test6">SeeMyGo</p>
</body>
</html>