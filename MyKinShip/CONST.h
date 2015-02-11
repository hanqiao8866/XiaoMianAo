//
//  CONST.h
//  WeChat
//
//  Created by X.T. on 14-8-7.
//  Copyright (c) 2014年 X.T. All rights reserved.
//

#import <Foundation/Foundation.h>

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// image STRETCH
#define XT_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

// Max record Time
#define kVoiceRecorderTotalTime 60.0


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark -
#pragma mark 系统常用路径
#pragma mark -
#define Path_Documents [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define YoJiaoDBPath [Path_Documents stringByAppendingPathComponent:@"YoJiao.sqlite"]

#define NAVBACKGROUNDCOLOR [UIColor colorWithRed:0/255.0f green:115/255.0f blue:193/255.0f alpha:1]

#define CURRENT_VERSION_APP @"1.0"

#define HostURL @"http://test.guyizu.com/"


#define MainScreenHight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

#define CURRENTAPPVERSION 1

