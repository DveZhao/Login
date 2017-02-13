//
//  AppDelegate.m
//  Login
//
//  Created by Dave on 17/2/13.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "AppDelegate.h"
#import "FLNavigationViewController.h"
#import "FLLoginViewController.h"//登录界面
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	//设置导航栏的颜色
	[self setNavigationBarColor];
	
	//登录界面
	//通知是用于在数据请求时通知登录过期,从而跳转到登录界面
	[self loadLoginViewController:nil];

	return YES;
}
- (void)loadLoginViewController:(NSNotification *)noti{
	FLLoginViewController * FLLoginVc = [[FLLoginViewController alloc] init];
	FLLoginVc.reLogin = noti?YES:NO;
	FLNavigationViewController *nvc = [[FLNavigationViewController alloc] initWithRootViewController:FLLoginVc];
	self.window.rootViewController = nvc;
	
}
- (void)setNavigationBarColor{
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:kFONT_BOLD(20),NSForegroundColorAttributeName:[UIColor whiteColor]}];
	[UINavigationBar appearance].translucent = NO;
	[[UINavigationBar appearance] setBarTintColor:kCOLOR_GREEN];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	
	[[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
	
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
