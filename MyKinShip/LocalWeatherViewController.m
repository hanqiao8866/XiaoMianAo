//
//  LocalWeatherViewController.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "LocalWeatherViewController.h"

@interface LocalWeatherViewController ()

@end

@implementation LocalWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavgationItemTitle:@"天气"];
    [self configureBarButtonItemStyle:XTBackButtonItemStyle action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}







@end
