//
//  LoginTextFiledView.m
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "LoginTextFiledView.h"
#import "UIButton+ImageTitleStyle.h"
@interface LoginTextFiledView()
{
	CGFloat rightPadding;
}
@property (nonatomic, assign)LoginTextFiledType fieldType;
@property (nonatomic, strong) UIView *LineView;

@end
@implementation LoginTextFiledView
- (instancetype)initWithLoginTextFiledType:(LoginTextFiledType)type rightBtnWidth:(CGFloat)btnWidth{
	self = [super init];
	if (self) {
		self.translatesAutoresizingMaskIntoConstraints = NO;
		self.backgroundColor = [UIColor whiteColor];
		self.layer.masksToBounds = YES;
		self.fieldType = type;
		rightPadding = btnWidth;
		[self createUIWithLoginTextFiledType:type];
	}
	return self;
}

- (void)createUIWithLoginTextFiledType:(LoginTextFiledType)type{
	
	[self addSubview:self.textField];
	
	if (type == LoginTextFiledType_Default) {
		return;
	}else if (type == LoginTextFiledType_Clean){
		self.textField.textColor = [UIColor redColor];
		[self addSubview:self.rightViewBtn];
		[self.rightViewBtn setImage:[UIImage imageNamed:@"login_err"] forState:UIControlStateNormal];
		[self.rightViewBtn setImage:[UIImage imageNamed:@"login_dui"] forState:UIControlStateSelected];
		@weakify(self);
		[[self.rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
			@strongify(self);
			self.rightViewBtn.selected = NO;
			self.textField.text = @"";
			self.textField.textColor = [UIColor redColor];
		}];
		return;
		
	}else if (type == LoginTextFiledType_Check){
		self.textField.keyboardType = UIKeyboardTypeNumberPad;
		self.textField.secureTextEntry = YES;
		[self addSubview:self.rightViewBtn];
		[self.rightViewBtn setImage:[UIImage imageNamed:@"login_eye_red"] forState:UIControlStateNormal];
		[self.rightViewBtn setImage:[UIImage imageNamed:@"login_eye_gray"] forState:UIControlStateSelected];
		[self.rightViewBtn setTitle:@"显示" forState:UIControlStateNormal];
		[self.rightViewBtn setTitle:@"隐藏" forState:UIControlStateSelected];
		[self.rightViewBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		[self.rightViewBtn setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:22];
		@weakify(self);
		[[self.rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
			@strongify(self);
			if(!self.rightViewBtn.selected){
				
				self.textField.secureTextEntry = NO;
			}else{
				self.textField.secureTextEntry = YES;
			}
			self.rightViewBtn.selected = !self.rightViewBtn.selected;
		}];
		return;
		
	}else if (type == LoginTextFiledType_Timer){
		[self addSubview:self.rightViewBtn];
		
		[self.rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
		self.rightViewBtn.userInteractionEnabled = YES;
		[self.rightViewBtn addSubview:self.LineView];
	}

}
- (void)showCodeBtnNormalTitle{
	[self.rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
	self.rightViewBtn.userInteractionEnabled = YES;
}
- (void)showCodeBtnSendingTitle{
	[self.rightViewBtn setTitle:@"发送中..." forState:UIControlStateNormal];
	self.rightViewBtn.userInteractionEnabled = NO;
}
- (void)showCodeBtnNumTitle:(NSInteger)countDown{

	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *numStr = [NSString stringWithFormat:@"验证码(%.2ld)",(long)countDown];
		[self.rightViewBtn setTitle:numStr forState:UIControlStateNormal];
	});
	self.rightViewBtn.userInteractionEnabled = NO;
	
}
- (UITextField *)textField{
	if (!_textField) {
		_textField = [[UITextField alloc] init];
		_textField.translatesAutoresizingMaskIntoConstraints = NO;
		_textField.borderStyle = UITextBorderStyleNone;
		_textField.font = [UIFont fontWithName:@"Helvetica" size:12];
	}
	return _textField;
}
- (UIButton *)rightViewBtn{
	if (!_rightViewBtn) {
		_rightViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_rightViewBtn.translatesAutoresizingMaskIntoConstraints = NO;
		_rightViewBtn.backgroundColor = [UIColor whiteColor];
		_rightViewBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
		[_rightViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//		[_rightViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
	}
	return _rightViewBtn;
}
- (UIView *)LineView{
	if (!_LineView) {
		_LineView = [[UIView alloc] init];
		_LineView.translatesAutoresizingMaskIntoConstraints = NO;
		_LineView.frame = CGRectMake(0, 0, 1, self.frame.size.height);
		_LineView.backgroundColor = HexRGB(0xebebeb);
	}
	return _LineView;
}
- (void)updateConstraints{
	[super updateConstraints];
	
	CGFloat leftPadding = 12;
	//textfiled 的约束条件
	NSLayoutConstraint *textfieldTopCon = [self.textField.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0];
	NSLayoutConstraint *textfieldButtomCon = [self.textField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0];
	NSLayoutConstraint *textfieldLeftCon = [self.textField.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:leftPadding];
	NSLayoutConstraint *textfieldRightCon;
	
	//rightViewbtn 的约束条件
	NSLayoutConstraint *rightViewbtnTopCon = [self.rightViewBtn.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0];
	NSLayoutConstraint *rightViewbtnButtomCon = [self.rightViewBtn.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0.0];
	NSLayoutConstraint *rightViewbtnLeftCon = [self.rightViewBtn.leftAnchor constraintEqualToAnchor:self.textField.rightAnchor constant:0.0];
	NSLayoutConstraint *rightViewbtnRightCon = [self.rightViewBtn.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0.0];

	
	if (self.fieldType == LoginTextFiledType_Default) {
		textfieldRightCon = [self.textField.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-leftPadding];
	}else if (self.fieldType == LoginTextFiledType_Clean || self.fieldType == LoginTextFiledType_Check){
		textfieldRightCon = [self.textField.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-rightPadding];
	}else{
		textfieldRightCon = [self.textField.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-rightPadding];
		NSLayoutConstraint *lineLeftCon = [self.LineView.leftAnchor constraintEqualToAnchor:self.rightViewBtn.leftAnchor constant:0.0];
		NSLayoutConstraint *lineTopCon  = [self.LineView.topAnchor constraintEqualToAnchor:self.rightViewBtn.topAnchor constant:0.0];
		NSLayoutConstraint *lineBottomCon=[self.LineView.bottomAnchor constraintEqualToAnchor:self.rightViewBtn.bottomAnchor constant:0.0];
		NSLayoutConstraint *lineWidthCon= [self.LineView.widthAnchor constraintEqualToConstant:1.0];
		
		[NSLayoutConstraint activateConstraints:@[lineTopCon,lineLeftCon,lineBottomCon,lineWidthCon]];
	}
	
	NSArray * arr = @[textfieldTopCon,textfieldLeftCon,textfieldButtomCon,textfieldRightCon,rightViewbtnTopCon,rightViewbtnLeftCon,rightViewbtnButtomCon,rightViewbtnRightCon];
	
	[NSLayoutConstraint activateConstraints:arr];
	
}


@end
