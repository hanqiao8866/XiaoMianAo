//
//  ParentsBirthdayViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "ParentsBirthdayViewController.h"

@interface ParentsBirthdayViewController ()

@end

@implementation ParentsBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"父母生日"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}






@end
