//
//  FLLoginViewModel.m
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLLoginViewModel.h"
#import "NSString+Extension.h"
@interface FLLoginViewModel()

@end
@implementation FLLoginViewModel

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self initIalize];
	}
	return self;
}
- (void)initIalize{
	self.userNameSignal = RACObserve(self, userName);
	self.passwordSignal = RACObserve(self, passWord);
}

- (RACSignal *)userNameSignalIsVaild{
	RACSignal *userNameIsVaild = [self.userNameSignal map:^id(NSString *name) {
		@weakify(self);
		if (name.length >= 11) {
			@strongify(self);
			
			name = [name substringToIndex:11];
			
			NSLog(@"name = %@",name);
		}
		return @([name isMobileNumber]);
	}];
	
	
	return userNameIsVaild;
}
- (RACSignal *)passwordSignalIsVaild{
	@weakify(self);
	return [self.passwordSignal map:^id(NSString *pwd) {
		@strongify(self);
		if (pwd.length > 12) {
			pwd = [pwd substringToIndex:12];
			self.passWord = pwd;
		}
		return @(pwd.length >= 3 ? YES : NO);
	}];
}
- (RACSignal *)loginBtnIsCanClick {
	RACSignal *loginActiveSignal = [RACSignal combineLatest:@[[self userNameSignalIsVaild],[self passwordSignalIsVaild]] reduce:^id(NSNumber *userNameIsVaild, NSNumber *pwdIsVaild){
		return @(userNameIsVaild.boolValue && pwdIsVaild.boolValue);
	}];
	return loginActiveSignal;
}

@end
