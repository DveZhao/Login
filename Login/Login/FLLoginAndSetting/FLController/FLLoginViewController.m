//
//  FLLoginViewController.m
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLLoginViewController.h"
#import "FLLoginView.h"
#import "FLNumCountDown.h"
#import "FingerprintIdentification.h"
#import "FLAutoLogin.h"
#import "FLLoginViewModel.h"
@interface FLLoginViewController ()

@property (nonatomic, strong) FLLoginView *loginView;
@property (nonatomic, strong) FLNumCountDown *countDown;


@end

@implementation FLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor yellowColor];
	[self createLoginView];
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear: YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:YES];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (FLNumCountDown *)countDown{
	if (!_countDown) {
		_countDown = [[FLNumCountDown alloc] init];
	}
	return _countDown;
}
- (void)createLoginView{
	_loginView = [[FLLoginView alloc] init];
	[self.view addSubview:_loginView];
	[_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	
	FLLoginViewModel *flLoginVM = [[FLLoginViewModel alloc] init];
	flLoginVM.userName = [self defualtUserName];
	self.loginView.userNameTextView.textField.text = flLoginVM.userName;

	RAC(flLoginVM, userName) = self.loginView.userNameTextView.textField.rac_textSignal;
	RAC(flLoginVM, passWord) = self.loginView.pwdTextView.textField.rac_textSignal;
    RAC(self.loginView.loginBtn,userInteractionEnabled) = [flLoginVM loginBtnIsCanClick];
	
	@weakify(flLoginVM, self);
	[flLoginVM.userNameSignal subscribeNext:^(NSString *name) {
		@strongify(self);
		self.loginView.userNameTextView.textField.text = [name substringToIndex:11];
	}];
	
	
	[[flLoginVM userNameSignalIsVaild] subscribeNext:^(NSNumber *isVaild) {
		
		@strongify(flLoginVM,self);
		
		if ([isVaild boolValue]) {
			self.loginView.userNameTextView.textField.textColor = [UIColor blackColor];
			self.loginView.userNameTextView.rightViewBtn.selected = YES;
		}else{
			self.loginView.userNameTextView.textField.textColor = [UIColor redColor];
			self.loginView.userNameTextView.rightViewBtn.selected = NO;
		}
	}];
	
	
	
//	[[flLoginVM loginBtnIsCanClick] subscribeNext:^(NSNumber *isVaild) {
//		@strongify(self);
//		self.loginView.loginBtn.userInteractionEnabled = isVaild.boolValue;
//	}];
	
//	RACSignal *usrNameIsRightSignal = [[_loginView.userNameTextView.textField rac_textSignal] map:^id(NSString *userName) {
//		@strongify(self);
//		if (userName.length >= 11) {
//			userName = [userName substringToIndex:11];
//			self.loginView.userNameTextView.textField.text = userName;
//		}else{
//			self.loginView.userNameTextView.textField.textColor = [UIColor redColor];
//		}
//		return @([userName isMobileNumber]);
//	}];
//	
//	RACSignal *pwdIsRightSingal = [[_loginView.pwdTextView.textField rac_textSignal] map:^id(NSString *password) {
//		@strongify(self);
//		if (password.length > 12) {
//			password = [password substringToIndex:12];
//			self.loginView.pwdTextView.textField.text = password;
//		}
//		return @(password.length >= 3 ? YES : NO);
//	}];
	
//	[usrNameIsRightSignal subscribeNext:^(NSNumber *isVaild) {
//		@strongify(self);
//		if ([isVaild boolValue]) {
//			self.loginView.userNameTextView.textField.textColor = [UIColor blackColor];
//			self.loginView.userNameTextView.rightViewBtn.selected = YES;
//		}
//	}];
	
	
//	RACSignal *loginActiveSignal = [RACSignal combineLatest:@[usrNameIsRightSignal,pwdIsRightSingal] reduce:^id(NSNumber *usrNameIsVaild, NSNumber *pwdIsVaild){
//		return @(usrNameIsVaild.boolValue && pwdIsVaild.boolValue);
//	}];
//	
//	[loginActiveSignal subscribeNext:^(NSNumber *isVaild) {
//		@strongify(self);
//		self.loginView.loginBtn.userInteractionEnabled = isVaild.boolValue;
//	}];
	
	//登录操作
	[[self.loginView.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		@strongify(self);
		[self loginRequestWithUserName:_loginView.userNameTextView.textField.text andPassword:_loginView.pwdTextView.textField.text];
	}];
	
	
	//验证码没有没有参与登录判断,需要时,需要添加信号判断
	[RACObserve(self.countDown, timeOut) subscribeNext:^(NSNumber *num) {
		@strongify(self);
		NSLog(@"%@",num);
		NSInteger timeNum = [num integerValue];
		if (timeNum <60) {
			[self.loginView.codeTextView showCodeBtnNumTitle:timeNum];
		}else{
			[self.loginView.codeTextView showCodeBtnNormalTitle];
		}
	}];
	
	[[self.loginView.codeTextView.rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		@strongify(self);
		[self.loginView.codeTextView showCodeBtnSendingTitle];
		@weakify(self);
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			@strongify(self);
			[self.countDown startCountDown];
			[self.loginView.codeTextView showCodeBtnNumTitle:self.countDown.timeOut];
		});
		
	}];
	
}
- (NSString *)defualtUserName{
	return [FingerprintIdentification accountForLastLogin];
}
- (NSString *)defualtPassword{
	return [FingerprintIdentification passwordForAccount:[self defualtUserName]];
}
//请求登录
- (void)loginRequestWithUserName:(NSString *)userName andPassword:(NSString *)password{
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		//登录成功
		[self judgeFingerprintLoginWithUserName:userName Password:password];
		[self reAutoLoginState:YES];
		//登录失败
//		[self reAutoLoginState:NO];
	});
}
//第一次登录操作----是否开启指纹登录----重新保存密码等
- (void)judgeFingerprintLoginWithUserName:(NSString *)userName Password:(NSString *)password{
	//判断是否是第一次登录
	if ([FingerprintIdentification isFirstLoginForAccount:_loginView.userNameTextView.textField.text]) {
		//询问是否开启指纹识别
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login 支持指纹登录" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"开启", nil];
		[alertView show];
		@weakify(self);
		[alertView.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
			@strongify(self);
			if (x.integerValue == 1) {
				if ([FingerprintIdentification judgeDeviceAuthenticationWithError:nil]) {
					[FingerprintIdentification setPassword:password account:userName andFingerprint:YES];
				}else{
					UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"未开启系统Touch ID" message:@"请先在系统设置-TouchID与密码中开启" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
					[alerView show];
					[FingerprintIdentification setPassword:password account:userName andFingerprint:NO];
				}
				
			}else{
				//点击取消
				[FingerprintIdentification setPassword:password account:userName andFingerprint:NO];
			}
			[self loginSuccess];
		}];
	}else{
		//重新保存密码
		[FingerprintIdentification resetPassword:password account:userName];
		[self loginSuccess];
	}
}
//通知登录成功
- (void)loginSuccess{
	
}
//指纹登录
- (void)showFingerprintLogin{
	if (![FingerprintIdentification canFingerprintLoginForAccount:[self defualtUserName]]) {
		[self autoLogin]; //自动登录
		return;
	}
	if (![FingerprintIdentification judgeDeviceAuthenticationWithError:nil]) {
		return;
	}
	[FingerprintIdentification evaluateDeviceAuthenticationWithLocalizedReason:@"使用指纹登录" reply:^(BOOL success, NSError * _Nullable error) {
		if(success) {
			[self loginRequestWithUserName:[self defualtUserName]andPassword:[self defualtPassword]];
		}
		else if(error){
			
		}
	}];

}
-(void)autoLogin{
	if (self.isReLogin) {
		[FLAutoLogin resetAutoLoginState:NO];
		return;
	}
	
	if ([FLAutoLogin canAutoLogin]) {
		[self loginRequestWithUserName:[self defualtPassword] andPassword:[self defualtPassword]];
	}
}
- (void)reAutoLoginState:(BOOL)autoLogin{
	[FLAutoLogin resetAutoLoginState:autoLogin];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
