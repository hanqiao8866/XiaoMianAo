//
//  MyVoiceViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "MyVoiceViewController.h"

@interface MyVoiceViewController ()

@end

@implementation MyVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"我的语音"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self configureRightBarButtonWithTitle:nil withBackgroundImage:[UIImage imageNamed:@"addbtnimage"] action:^{
        DLog(@"添加按钮点击事件");
    }];
}






@end
