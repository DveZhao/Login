//
//  FLNumCountDown.h
//  Login
//
//  Created by Dave on 17/2/9.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLNumCountDown : NSObject
@property (nonatomic, assign) NSInteger timeOut;
- (void)startCountDown;
- (void)stopCountDown;
@end
