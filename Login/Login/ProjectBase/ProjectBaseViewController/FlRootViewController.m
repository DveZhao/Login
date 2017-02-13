//
//  FlRootViewController.m
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FlRootViewController.h"

@interface FlRootViewController ()

@end

@implementation FlRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = self.vcTitle;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.extendedLayoutIncludesOpaqueBars = YES;
	
	self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
	backItem.title = @"返回";
	self.navigationItem.backBarButtonItem = backItem;
	
}
- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear: YES];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	if (self.interfaceOrientation != UIInterfaceOrientationPortrait
		&&![self isMemberOfClass:NSClassFromString(@"ProofPreviewViewController")]) {
		[self forceChangeToOrientation:UIInterfaceOrientationPortrait];
	}
	if (self.forceShowNavigationBar) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.navigationController setNavigationBarHidden:NO animated:YES];
		});
	}
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}
//设置状态栏的白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

- (NSInteger)viewControllerCount{
	if ([self.navigationController isKindOfClass:NSClassFromString(@"UIMoreNavigationController")]) {
		return self.navigationController.viewControllers.count - 1;
	}
	else{
		return self.navigationController.viewControllers.count;
	}
}

- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
	[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"2"];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
