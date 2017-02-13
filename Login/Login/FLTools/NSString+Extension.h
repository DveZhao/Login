//
//  NSString+Extension.h
//  Financial
//
//  Created by Dave on 15/7/22.
//  Copyright (c) 2015年 Dave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

///将数组字典对象转换成JSON
+ (NSString *)jsonStringWithParams:(id)params;

//是否是手机号
- (BOOL)isMobileNumber;

///是否是数字
- (BOOL)isNumber;

//1000000 --> 1,000,000.00
+ (NSString *)moneyString:(NSNumber *)money;

//@1000.1 --> @"1000.1"  @1000.00 --> @"1000"  @0 --> @"" @1000.12354124 --> @"1000.124"
+ (NSString *)inputMoneyString:(NSNumber *)money;


///转化成拼音
- (NSString *)pinyinString;

//从原图地址中获取缩略图地址
- (NSString *)thumbnailURLString;

//解析URL参数的工具方法。
- (NSDictionary *)queryDict;
    

//base64编码
- (NSString *)encodeByBase64;

//base64解码
- (NSString *)decodeByBase64;





///同级下一个科目编码
- (NSString *)nextSubjectCodeWithMaxRangeNum:(NSInteger)maxRangeNum;

///下级科目编码
- (NSString *)nextLevelSubjectCodeWithMaxRangeNum:(NSInteger)maxRangeNum;
@end
