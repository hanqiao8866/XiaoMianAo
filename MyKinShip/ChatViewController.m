//
//  ChatViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/12.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configureNavgationItemTitle:@"聊贴心话"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}






@end
