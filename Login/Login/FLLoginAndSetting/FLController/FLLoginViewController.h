//
//  FLLoginViewController.h
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FlRootViewController.h"

@interface FLLoginViewController : FlRootViewController

//是否重新登录
@property (nonatomic, assign, getter=isReLogin) BOOL reLogin;
@end
