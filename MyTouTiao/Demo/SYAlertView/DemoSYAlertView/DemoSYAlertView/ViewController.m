//
//  ViewController.m
//  DemoSYAlertView
//
//  Created by zhangshaoyu on 2018/6/5.
//  Copyright © 2018年 VSTECS. All rights reserved.
//

#import "ViewController.h"
#import "SYAlertView.h"

static CGFloat const originXY = 20.0;
static CGFloat const heightButton = 40.0;
#define widthScreen (self.view.frame.size.width)

@interface ViewController ()

@property (nonatomic, strong) SYAlertView *alertView;

@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UIView *titleMessageView;
@property (nonatomic, strong) UIView *titleEidtView;
@property (nonatomic, strong) UIView *editView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"弹窗功能";
    
    __block UIView *currentView = nil;
    
    NSArray *array = @[@"提示内容", @"提示语/提示内容", @"提示语/输入内容", @"输入内容"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10.0, (currentView.frame.origin.y + currentView.frame.size.height + 10.0), (self.view.frame.size.width - 20.0), 40.0)];
        [self.view addSubview:button];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.tag = idx;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        currentView = button;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)buttonClick:(UIButton *)button
{
    if (0 == button.tag) {
        // 默认动画
        self.alertView.showContainerView = self.messageView;
        [self.alertView show];
    } else if (1 == button.tag) {
        // 无动画
        self.alertView.animation = nil;
        //
        self.alertView.containerView.frame = CGRectMake(originXY, (self.alertView.frame.size.height - self.titleMessageView.frame.size.height) / 2, (self.alertView.frame.size.width - originXY * 2), self.titleMessageView.frame.size.height);
        [self.alertView.containerView addSubview:self.titleMessageView];
        [self.alertView show];
    } else if (2 == button.tag) {
        // 立方体动画——私有API
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.35f];
        [animation setFillMode:kCAFillModeForwards];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"cube"];
        [animation setSubtype:@"fromRight"];
        self.alertView.animation = animation;
        //
        self.alertView.containerView.frame = CGRectMake(20.0, 100.0, (self.alertView.frame.size.width - 40.0f), self.titleEidtView.frame.size.height);
        [self.alertView.containerView addSubview:self.titleEidtView];
        [self.alertView show];
    } else if (3 == button.tag) {
        // 涟漪动画——私有API
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.35f];
        [animation setFillMode:kCAFillModeForwards];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"rippleEffect"];
        self.alertView.animation = animation;
        self.alertView.originSpace = 20.0f;
        //
        self.alertView.containerView.frame = CGRectMake(20.0, (self.alertView.frame.size.height - 20.0 - self.editView.frame.size.height), (self.alertView.frame.size.width - 40.0f), self.editView.frame.size.height);
        [self.alertView.containerView addSubview:self.editView];
        [self.alertView show];
    }
}

- (void)hideClick
{
    [self.alertView hide];
}

#pragma mark - getter

- (SYAlertView *)alertView
{
    if (_alertView == nil) {
        _alertView = [[SYAlertView alloc] init];
        _alertView.isAnimation = YES;
    }
    return _alertView;
}

- (UIView *)messageView
{
    if (_messageView == nil) {
        _messageView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (widthScreen - originXY * 2), 0.0)];
        _messageView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originXY, originXY, (_messageView.frame.size.width - originXY * 2), heightButton)];
        label.textColor = [UIColor blackColor];
        label.text = @"UIAlertController这个接口类是一个定义上的提升，它添加简单，展示Alert和ActionSheet使用统一的API。因为UIAlertController使UIViewController的子类，他的API使用起来也会比较熟悉！";
        label.numberOfLines = 0;
        CGFloat height = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.height;
        CGRect rectlabel = label.frame;
        rectlabel.size.height = 8.0f * 2 + height;
        label.frame = rectlabel;
        
        UIView *currentView = label;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, heightButton)];
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor yellowColor];
        button.layer.cornerRadius = heightButton / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
        
        currentView = button;
        
        [_messageView addSubview:label];
        [_messageView addSubview:button];
        
        CGRect rect = _messageView.frame;
        rect.size.height = currentView.frame.origin.y + currentView.frame.size.height + originXY;
        _messageView.frame = rect;
    }
    return _messageView;
}

- (UIView *)titleMessageView
{
    if (_titleMessageView == nil) {
        _titleMessageView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (widthScreen - originXY * 2), 0.0)];
        _titleMessageView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originXY, originXY, (_titleMessageView.frame.size.width - originXY * 2), heightButton)];
        label.textColor = [UIColor blackColor];
        label.text = @"UIAlertController";
        [_titleMessageView addSubview:label];
        
        UIView *currentView = label;
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), (_titleMessageView.frame.size.width - originXY * 2), heightButton)];
        label2.textColor = [UIColor blackColor];
        label2.text = @"UIAlertController这个接口类是一个定义上的提升，它添加简单，展示Alert和ActionSheet使用统一的API。因为UIAlertController使UIViewController的子类，他的API使用起来也会比较熟悉！";
        label2.numberOfLines = 0;
        
        CGFloat height = [label2.text boundingRectWithSize:CGSizeMake(label2.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label2.font} context:nil].size.height;
        CGRect rectlabel = label2.frame;
        rectlabel.size.height = 8.0f * 2 + height;
        label2.frame = rectlabel;
        [_titleMessageView addSubview:label2];
        
        currentView = label2;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, heightButton)];
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor yellowColor];
        button.layer.cornerRadius = heightButton / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
        [_titleMessageView addSubview:button];
        
        currentView = button;
        
        CGRect rect = _titleMessageView.frame;
        rect.size.height = currentView.frame.origin.y + currentView.frame.size.height + originXY;
        _titleMessageView.frame = rect;
    }
    return _titleMessageView;
}

- (UIView *)titleEidtView
{
    if (_titleEidtView == nil) {
        _titleEidtView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (widthScreen - originXY * 2), 0.0)];
        _titleEidtView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originXY, originXY, (_titleEidtView.frame.size.width - originXY * 2), heightButton)];
        label.textColor = [UIColor blackColor];
        label.text = @"UIAlertController";
        label.numberOfLines = 0;
        CGFloat height = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.height;
        CGRect rectlabel = label.frame;
        rectlabel.size.height = 8.0f * 2 + height;
        label.frame = rectlabel;
        [_titleEidtView addSubview:label];
        
        UIView *currentView = label;
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, heightButton)];
        textfield.backgroundColor = [UIColor lightGrayColor];
        textfield.text = @"UITextField";
        [_titleEidtView addSubview:textfield];
        
        currentView = textfield;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, heightButton)];
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor yellowColor];
        button.layer.cornerRadius = heightButton / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
        [_titleEidtView addSubview:button];
        
        currentView = button;
        
        CGRect rect = _titleEidtView.frame;
        rect.size.height = currentView.frame.origin.y + currentView.frame.size.height + originXY;
        _titleEidtView.frame = rect;
    }
    return _titleEidtView;
}

- (UIView *)editView
{
    if (_editView == nil) {
        _editView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, (widthScreen - originXY * 2), 0.0)];
        _editView.backgroundColor = [UIColor whiteColor];
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(originXY, originXY, (_editView.frame.size.width - originXY * 2), heightButton)];
        textfield.backgroundColor = [UIColor greenColor];
        textfield.text = @"UITextField";
        
        UIView *currentView = textfield;
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, currentView.frame.size.height)];
        UITextView *textfield2 = [[UITextView alloc] initWithFrame:view2.bounds];
        textfield2.backgroundColor = [UIColor orangeColor];
        textfield2.text = @"UITextView";
        [view2 addSubview:textfield2];
        
        currentView = view2;
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, currentView.frame.size.height)];
        UIView *view32 = [[UIView alloc] initWithFrame:view3.bounds];
        [view3 addSubview:view32];
        UITextField *textfield3 = [[UITextField alloc] initWithFrame:view32.bounds];
        textfield3.backgroundColor = [UIColor greenColor];
        textfield3.text = @"UITextField";
        [view32 addSubview:textfield3];
        
        currentView = view3;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(currentView.frame.origin.x, (currentView.frame.origin.y + currentView.frame.size.height + originXY), currentView.frame.size.width, heightButton)];
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor = [UIColor yellowColor];
        button.layer.cornerRadius = heightButton / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
        
        currentView = button;
        
        [_editView addSubview:textfield];
        [_editView addSubview:view2];
        [_editView addSubview:view3];
        [_editView addSubview:button];
        
        CGRect rect = _editView.frame;
        rect.size.height = currentView.frame.origin.y + currentView.frame.size.height + originXY;
        _editView.frame = rect;
    }
    return _editView;
}

@end
