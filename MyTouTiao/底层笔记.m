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

28.git的使用  分钟 git 命令入门到放弃

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
