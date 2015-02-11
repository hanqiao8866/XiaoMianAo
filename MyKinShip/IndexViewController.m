//
//  IndexViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()
{
    UIButton *backBtn; // 返回按钮
}

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configureNavgationItemTitle:@"首页"];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0 , 0, 30, 35);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.hidden = YES;
    [backBtn setImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    UIBarButtonItem *navBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = navBackBtn;
    
    
    
}

// 返回按钮点击事件
- (void)backBtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainBackView.frame = CGRectMake(0, 0, MainScreenWidth, 300);
    } completion:^(BOOL finished) {
        backBtn.hidden = YES;
        [self configureNavgationItemTitle:@"首页"];
    }];
}



- (IBAction)tapMainIconGesture:(UITapGestureRecognizer *)sender {
    DLog(@"%ld",(long)sender.view.tag);
    
    switch (sender.view.tag) {
        case 1:
        {
            DLog(@"父母位置点击");
            [UIView animateWithDuration:0.5 animations:^{
                self.mainBackView.frame = CGRectMake(0, -400, MainScreenWidth, 300);
            } completion:^(BOOL finished) {
                backBtn.hidden = NO;
                [self configureNavgationItemTitle:@"父母位置"];
            }];
        }
            break;
        case 2:
            DLog(@"当地天气点击");
            break;
        case 3:
            DLog(@"父母生日点击");
            break;
        case 4:
            DLog(@"吃药提醒点击");
            break;
        case 5:
            DLog(@"聊贴心话点击");
            break;
        case 6:
            DLog(@"我的相册点击");
            break;
        case 7:
            DLog(@"我的视频点击");
            break;
        case 8:
            DLog(@"我的语音点击");
            break;
        case 9:
            DLog(@"我的设置点击");
            break;
            
        default:
            break;
    }
    
    
}



@end
