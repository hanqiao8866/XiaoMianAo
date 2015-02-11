//
//  XTBaseViewController.h
//  DoctorClient
//
//  Created by X.T. on 14-8-18.
//  Copyright (c) 2014年 X.T. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XTBarButtonItemStyle) {
    XTBarButtonItemStyleSetting = 0,
    XTBarButtonItemStyleMore,
    XTBarButtonItemStyleCamera,
    XTBackButtonItemStyle,
};

typedef void (^XTBarButtonItemActionBlock) (void);
typedef void (^XTRightBarButtonActionBlock) (void);

@interface XTBaseViewController : UIViewController

/**
 *  统一设置背景图片
 *
 *  @param backgroundImage 目标背景图片
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的视图控制器
 */
- (void)pushNewViewController:(UIViewController *)newViewController;


// 设置barButtonItem以及回调方法
- (void)configureBarButtonItemStyle:(XTBarButtonItemStyle)style action:(XTBarButtonItemActionBlock)action;

// 设置带文字的导航按钮并且回调方法
- (void)configureRightBarButtonWithTitle:(NSString *)title action:(XTRightBarButtonActionBlock)action;

// 设置带文字或带背景图片的的导航按钮并且回调方法
- (void)configureRightBarButtonWithTitle:(NSString *)title withBackgroundImage:(UIImage *)bgImage action:(XTRightBarButtonActionBlock)action;

// 设置导航条
- (void)configureNavgationItemTitle:(NSString *)navigationTitle;


@end
