//
//  FingerprintIdentification.h
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FingerprintIdentification : NSObject
//判断设备是否支持指纹解锁
+ (BOOL)judgeDeviceAuthenticationWithError:(  NSError * __autoreleasing __nullable * __nullable)error;
//调取指纹识别
+ (void) evaluateDeviceAuthenticationWithLocalizedReason:(nullable NSString *)localizedRedson reply:(void (^ __nullable)(BOOL success, NSError * __nullable error))reply;

//是否是第一次登录
+ (BOOL)isFirstLoginForAccount:( NSString * __nullable)account;
//是否可以使用指纹登录
+ (BOOL)canFingerprintLoginForAccount:( NSString * __nullable)account;
//设置密码
+ (BOOL)setPassword:(NSString * __nullable)password account:(NSString * __nullable)account andFingerprint:(BOOL)canFingerprint;
//重置密码
+ (BOOL)resetPassword:(NSString * __nullable)password account:(NSString * __nullable)account;

//获取密码
+ (NSString * __nullable)passwordForAccount:(NSString * __nullable)account;
//获取最后一次登录账号
+ (NSString * __nullable)accountForLastLogin;

//删除账号
+ (BOOL)deletePasswordForAccount:(NSString * __nullable)account;
//删除所有账号
+ (void)deleteAllAccount;


@end
