//
//  AppDelegate.h
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface LandscapeMPMoviePlayerViewController : MPMoviePlayerViewController

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager *_mapManager;
@public
    LandscapeMPMoviePlayerViewController *moviePlayerController;
}

@property (strong, nonatomic) UIWindow *window;


@end

@interface AppDelegate(MovieControllerInternal)
-(void)moviePlaybackComplete:(NSNotification *)notification;
@end

