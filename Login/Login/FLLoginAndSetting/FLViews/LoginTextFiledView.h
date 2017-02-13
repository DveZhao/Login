//
//  LoginTextFiledView.h
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LoginTextFiledType){
	LoginTextFiledType_Default = 0, //默认.只有一个输入框
	LoginTextFiledType_Clean   = 1, //带有删除按钮的输入框
	LoginTextFiledType_Check      , //密码框,可以查看密码
	LoginTextFiledType_Timer      , //带有倒计时的输入框
};
@interface LoginTextFiledView : UIView

- (instancetype) initWithLoginTextFiledType:(LoginTextFiledType)type rightBtnWidth:(CGFloat)btnWidth;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *placerStr;
@property (nonatomic, strong)UIButton *rightViewBtn;

//LoginTextFiledType 为LoginTextFiledType_Timer是调用
- (void)showCodeBtnNormalTitle;
- (void)showCodeBtnSendingTitle;
- (void)showCodeBtnNumTitle:(NSInteger)countDown;

@end
