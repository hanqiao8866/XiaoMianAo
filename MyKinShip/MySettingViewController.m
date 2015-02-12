//
//  MySettingViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "MySettingViewController.h"

@interface MySettingViewController ()

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configureNavgationItemTitle:@"我的设置"];
    [self.navigationItem  setHidesBackButton:YES];
    [self configureRightBarButtonWithTitle:nil withBackgroundImage:[UIImage imageNamed:@"deletebtnimage"] action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}





@end
