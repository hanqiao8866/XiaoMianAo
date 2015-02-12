//
//  NoticeEatMedicineViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "NoticeEatMedicineViewController.h"

@interface NoticeEatMedicineViewController ()

@end

@implementation NoticeEatMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"吃药提醒"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self configureRightBarButtonWithTitle:nil withBackgroundImage:[UIImage imageNamed:@"addbtnimage"] action:^{
        DLog(@"添加按钮点击事件");
    }];
}


@end
