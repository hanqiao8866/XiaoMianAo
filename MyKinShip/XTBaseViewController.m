//
//  XTBaseViewController.m
//  DoctorClient
//
//  Created by X.T. on 14-8-18.
//  Copyright (c) 2014年 X.T. All rights reserved.
//

#import "XTBaseViewController.h"

@interface XTBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) XTBarButtonItemActionBlock barbuttonItemAction;
@property (nonatomic, copy) XTRightBarButtonActionBlock rightBarButtonAction;

@end

@implementation XTBaseViewController

#pragma mark - Public Method
// 设置视图的背景图片
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

// push到一个新的页面
- (void)pushNewViewController:(UIViewController *)newViewController
{
    [self.navigationController pushViewController:newViewController animated:YES];
}

// 设置导航栏上的文字
- (void)configureNavgationItemTitle:(NSString *)navigationTitle
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = navigationTitle;
    titleLabel.font = [UIFont systemFontOfSize:21.0f];
    self.navigationItem.titleView = titleLabel;
}

// 设置导航栏按钮的点击事件
- (void)configureBarButtonItemStyle:(XTBarButtonItemStyle)style action:(XTBarButtonItemActionBlock)action
{
    switch (style) {
        case XTBarButtonItemStyleSetting:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        case XTBarButtonItemStyleMore:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        case XTBarButtonItemStyleCamera:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        case XTBackButtonItemStyle:
        {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0 , 0, 15, 20);
            [backBtn addTarget:self action:@selector(clickedBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
            [backBtn setImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
            UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = navBackBtn;
            break;
        }
        default:
            break;
    }
    self.barbuttonItemAction = action;
}

- (void)clickedBarButtonItemAction
{
    if (self.barbuttonItemAction) {
        self.barbuttonItemAction();
    }
}

// 设置带文字或带背景图片的的导航按钮并且回调方法
- (void)configureRightBarButtonWithTitle:(NSString *)title withBackgroundImage:(UIImage *)bgImage action:(XTRightBarButtonActionBlock)action
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0.0, 0.0, 50.0, 30.0);
    [rightBtn addTarget:self action:@selector(clickedRightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = navRightBtn;

    self.rightBarButtonAction = action;
}

// 设置带文字的导航按钮并且回调方法
- (void)configureRightBarButtonWithTitle:(NSString *)title action:(XTRightBarButtonActionBlock)action
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn addTarget:self action:@selector(clickedRightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =navRightBtn;
    
    self.rightBarButtonAction = action;
}

- (void)clickedRightBarButtonItemAction
{
    if (self.rightBarButtonAction) {
        self.rightBarButtonAction();
    }
}

#pragma mark - View rotation
// 设置屏幕可以自动翻转
- (BOOL)shouldAutorotate
{
    return NO;
}

// 仅支持竖屏
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    //ios7.0适配
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3navgationitem"] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

// 设置状态栏显示为白色 注意要禁用“View controller-based status bar appearance” 将其设为NO
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.navigationController.viewControllers.count == 1) {
        //关闭主界面的右滑返回
        return NO;
    } else {
        return YES;
    }
}




@end
