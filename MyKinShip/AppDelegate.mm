//
//  AppDelegate.m
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // 使用百度地图，启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:MapKey generalDelegate:self];
    if (!ret) {
        DLog(@"map manager start failed!");
    }
    
//    // 启动视频播放
//    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
//    NSString * videoPath = [resourcePath stringByAppendingPathComponent:@"Launch.m4v"];
//    NSURL* videoURL = [NSURL fileURLWithPath:videoPath];
//    moviePlayerController = [[LandscapeMPMoviePlayerViewController alloc] initWithContentURL:videoURL];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackComplete:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
//    
//    
//    moviePlayerController.moviePlayer.view.frame = self.window.bounds;
//    [moviePlayerController.view setTransform:CGAffineTransformMakeRotation(2 * M_PI - M_PI / 2)];
//    
//    moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyleNone;
//    moviePlayerController.moviePlayer.scalingMode = MPMovieScalingModeFill;
//    [moviePlayerController.moviePlayer play];
//    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[IndexViewController alloc] init]];
    self.window.rootViewController = nav;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Other Configation
- (void)onGetNetworkState:(int)iError
{
    if (iError == 0) {
        DLog(@"联网成功");
    } else {
        DLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (iError == 0) {
        DLog(@"授权成功");
    } else {
        DLog(@"onGetPermissionState %d",iError);
    }
}

@end
