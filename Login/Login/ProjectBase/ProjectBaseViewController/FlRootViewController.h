//
//  FlRootViewController.h
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlRootViewController : UIViewController

@property (nonatomic, copy) NSString *vcTitle;
@property (nonatomic, assign) BOOL forceShowNavigationBar;//侧滑返回,防止导航栏消失

- (NSInteger)viewControllerCount;

@end
