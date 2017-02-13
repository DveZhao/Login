//
//  FLAutoLogin.h
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLAutoLogin : NSObject
+ (BOOL)canAutoLogin;
+ (void)resetAutoLoginState:(BOOL)autoLoginState;
@end
