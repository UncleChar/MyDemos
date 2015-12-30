//
//  UncleCharAppDelegate.h
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface UncleCharAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow     *window;
@property (strong, nonatomic) Reachability *hostReach;

+ (UncleCharAppDelegate *)getUncleCharAppDelegateDelegate;
@end
