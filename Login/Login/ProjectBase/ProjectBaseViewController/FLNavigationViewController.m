//
//  FLNavigationViewController.m
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLNavigationViewController.h"

@interface FLNavigationViewController ()

@end

@implementation FLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
	if ([self isKindOfClass:NSClassFromString(@"UIMoreNavigationController")]) {
		if (self.viewControllers.count >= 2) {
			return [self popToViewController:self.viewControllers[1] animated:animated];
		}
		return nil;
	}
	return [super popToRootViewControllerAnimated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
	return [self.visibleViewController preferredStatusBarStyle];
}

- (BOOL)shouldAutorotate{
	return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
	return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
	return [self.visibleViewController supportedInterfaceOrientations];
}

@end
