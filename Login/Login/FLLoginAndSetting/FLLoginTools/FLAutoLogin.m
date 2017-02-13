//
//  FLAutoLogin.m
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLAutoLogin.h"
NSString *const FLAUTOLOGIN = @"AUTOLOGIN";
@implementation FLAutoLogin
+ (BOOL)canAutoLogin{
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if ([[userDefaults objectForKey:FLAUTOLOGIN] isEqual:@(YES)]) {
		return YES;
	}
	return NO;
}
+ (void)resetAutoLoginState:(BOOL)autoLoginState{
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:@(autoLoginState) forKey:FLAUTOLOGIN];
	[userDefaults synchronize];
}
@end
