//
//  IndexViewController.h
//  MyKinShip
//
//  Created by 谢涛 on 15/2/11.
//  Copyright (c) 2015年 谢涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : XTBaseViewController

@property (weak, nonatomic) IBOutlet UIView *mainBackView;

- (IBAction)tapMainIconGesture:(UITapGestureRecognizer *)sender;

@end
