//
//  FLLoginViewModel.h
//  Login
//
//  Created by Dave on 17/2/10.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLLoginViewModel : NSObject

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;

//用户名是否正确
- (RACSignal *)userNameSignalIsVaild;
//密码有效是否长度
- (RACSignal *)passwordSignalIsVaild;
//密码是否可用(数字,大小写字母组合)
- (RACSignal *)passwordSignalIsCanUse;
//登录按钮是否可点击
- (RACSignal *)loginBtnIsCanClick;


@end
