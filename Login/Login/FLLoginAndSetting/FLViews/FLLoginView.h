//
//  FLLoginView.h
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginTextFiledView.h"
@interface FLLoginView : UIView
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetPwdBtn;//忘记密码
@property (nonatomic, strong) UIButton *registerBtn;//新用户注册

@property (nonatomic, strong) LoginTextFiledView *userNameTextView;
@property (nonatomic, strong) LoginTextFiledView *pwdTextView;
@property (nonatomic, strong) LoginTextFiledView *codeTextView;


@end
