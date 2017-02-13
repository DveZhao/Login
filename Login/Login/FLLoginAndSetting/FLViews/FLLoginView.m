//
//  FLLoginView.m
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLLoginView.h"

@implementation FLLoginView
- (instancetype)init
{
	self = [super init];
	if (self) {
		[self addBactgroudImageView];
		[self createUI];
	}
	return self;
}
- (void)addBactgroudImageView{
	UIImageView *imageView = [[UIImageView alloc] init];
	imageView.image = [UIImage imageNamed:@"login_bg"];
	[self addSubview:imageView];
	
	[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	
}
- (void)createUI{
	self.logoImageView = [[UIImageView alloc] init];
	self.logoImageView.image = [UIImage imageNamed:@"icon_wwdc"];
	[self addSubview:self.logoImageView];
	
	NSInteger cornerRadius = kSCALE(30)/2.0;
	
	self.userNameTextView = [[LoginTextFiledView alloc] initWithLoginTextFiledType:LoginTextFiledType_Clean rightBtnWidth:30];
	self.userNameTextView.layer.cornerRadius = cornerRadius;
	self.userNameTextView.textField.placeholder = @"请输入账号";
	[self addSubview:self.userNameTextView];
	
	self.pwdTextView = [[LoginTextFiledView alloc] initWithLoginTextFiledType:LoginTextFiledType_Check rightBtnWidth:50];
	self.pwdTextView.layer.cornerRadius = cornerRadius;
	self.pwdTextView.textField.placeholder = @"密码";
	[self addSubview:self.pwdTextView];
	
	self.codeTextView = [[LoginTextFiledView alloc] initWithLoginTextFiledType:LoginTextFiledType_Timer rightBtnWidth:90];
	self.codeTextView.layer.cornerRadius = cornerRadius;
	self.codeTextView.textField.placeholder = @"请输入验证码";
	[self addSubview:self.codeTextView];
	
	[self addSubview:self.loginBtn];
	
}
- (UIButton *)loginBtn{
	if (!_loginBtn) {
		_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
		[_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_loginBtn.titleLabel.font = kFONT_BOLD(15);
		UIImage * bgImage = [UIImage imageNamed:@"login_btn"];
		[_loginBtn setBackgroundImage:[bgImage stretchableImageWithLeftCapWidth:bgImage.size.width/2.0 topCapHeight:bgImage.size.height/2.0] forState:UIControlStateNormal];
		_loginBtn.userInteractionEnabled = NO;
	}
	return _loginBtn;
}
- (void)updateConstraints{
	[super updateConstraints];
	[self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(self.logoImageView.image.size.height*1.5);
		make.width.mas_equalTo(self.logoImageView.image.size.width*1.5);
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(110);
	}];
	
	 CGFloat TFPadding = 58;
	[self.userNameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(50);
		make.left.mas_equalTo(self).mas_offset(TFPadding);
		make.right.mas_equalTo(self).mas_offset(-TFPadding);
		make.height.offset(kSCALE(30));
	}];
	
	[self.pwdTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.userNameTextView.mas_bottom).mas_offset(20);
		make.left.mas_equalTo(self).mas_offset(TFPadding);
		make.right.mas_equalTo(self).mas_offset(-TFPadding);
		make.height.offset(kSCALE(30));
	}];
	
	[self.codeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.pwdTextView.mas_bottom).mas_offset(20);
		make.left.mas_equalTo(self).mas_offset(TFPadding);
		make.right.mas_equalTo(self).mas_offset(-TFPadding);
		make.height.offset(kSCALE(30));
	}];
	
	[self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.codeTextView.mas_bottom).mas_offset(30);
		make.left.mas_equalTo(self.mas_left).mas_offset(TFPadding);
		make.right.mas_equalTo(self.mas_right).mas_offset(-TFPadding);
		make.height.mas_equalTo(30);
	}];

}

@end
