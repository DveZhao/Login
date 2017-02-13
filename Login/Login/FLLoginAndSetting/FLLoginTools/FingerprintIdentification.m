//
//  FingerprintIdentification.m
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FingerprintIdentification.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SSKeychain.h"

static  NSString *const PasswordAuthPrefix = @"PWD**";

@implementation FingerprintIdentification
+ (BOOL)judgeDeviceAuthenticationWithError:(NSError * _Nullable __autoreleasing *)error{
	LAContext *context = [[LAContext alloc] init];
	return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:error];
}
+ (void)evaluateDeviceAuthenticationWithLocalizedReason:(NSString *)localizedRedson reply:(void (^)(BOOL, NSError * _Nullable))reply{
	LAContext *context = [[LAContext alloc] init];
	[context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedRedson reply:reply];
}

//是否是第一次登录
+ (BOOL)isFirstLoginForAccount:(NSString *)account{
	NSLog(@"%@",SERVICE_STRGET);
	NSError *error = nil;
	[SSKeychain passwordForService:SERVICE_STRGET account:account error:&error];
	if (error) {
		return YES;
	}
	return NO;
}
//是否可以使用指纹登录
+ (BOOL)canFingerprintLoginForAccount:(NSString *)account{
	if ([self isFirstLoginForAccount:account]) {
		return NO;
	}
	NSString *password = [SSKeychain passwordForService:SERVICE_STRGET account:account error:nil];
	return [password hasPrefix:PasswordAuthPrefix];
}
//设置密码
+ (BOOL)setPassword:(NSString *)password account:(NSString *)account andFingerprint:(BOOL)canFingerprint{
	if (canFingerprint) {
		return [SSKeychain setPassword:[PasswordAuthPrefix stringByAppendingString:password] forService:SERVICE_STRGET account:account];
	}
	return [SSKeychain setPassword:password forService:SERVICE_STRGET account:account];
}
//重新设置密码
+ (BOOL)resetPassword:(NSString * __nullable)password account:(NSString * __nullable)account{
	if ([self canFingerprintLoginForAccount:account]) {
		password = [PasswordAuthPrefix stringByAppendingString:password];
	}
	return [SSKeychain setPassword:password forService:SERVICE_STRGET account:account];
}


//获取密码
+ (NSString * __nullable)passwordForAccount:(NSString * __nullable)account
{
	NSString *password = [SSKeychain passwordForService:SERVICE_STRGET account:account];
	if ([password hasPrefix:PasswordAuthPrefix]) {
		NSInteger prefixlength = PasswordAuthPrefix.length;
		return [password substringFromIndex:prefixlength];
	}
	return password;
}

//最后一次登录的账号
+ (NSString *)accountForLastLogin
{
	NSArray *accounts = [SSKeychain accountsForService:SERVICE_STRGET];
	if (accounts) {
		return accounts.lastObject[kSSKeychainAccountKey];
	}
	return nil;
}
//删除账号
+ (BOOL)deletePasswordForAccount:(NSString * __nullable)account
{
	return [SSKeychain deletePasswordForService:SERVICE_STRGET account:account];
}
//删除所有账号
+ (void)deleteAllAccount
{
	NSArray *accounts = [SSKeychain accountsForService:SERVICE_STRGET];
	[accounts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[SSKeychain deletePasswordForService:SERVICE_STRGET account:obj[kSSKeychainAccountKey]];
	}];
}

@end
