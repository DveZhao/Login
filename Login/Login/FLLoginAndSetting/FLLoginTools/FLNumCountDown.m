//
//  FLNumCountDown.m
//  Login
//
//  Created by Dave on 17/2/9.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#import "FLNumCountDown.h"
@interface FLNumCountDown()
{
	dispatch_source_t _timer;

}
@end
@implementation FLNumCountDown

- (instancetype)init
{
	self = [super init];
	if (self) {
		
		[self setTime];
	}
	return self;
}
- (void)setTime{
	self.timeOut = 60;
}
- (void)startCountDown{
	self.timeOut = 60;
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
		dispatch_source_set_event_handler(_timer, ^{
		
		if (self.timeOut <= 0) {
			dispatch_source_cancel(_timer);
		}else{
			self.timeOut --;
		}
	});
	dispatch_source_set_cancel_handler(_timer, ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			self.timeOut = 60;
		});
	});
	dispatch_resume(_timer);
}
- (void)stopCountDown{
	
	dispatch_source_cancel(_timer);
	dispatch_source_set_cancel_handler(_timer, ^{
		[self setTime];
	});
}
@end
