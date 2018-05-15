
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