//
//  NSString+Extension.m
//  Financial
//
//  Created by Dave on 15/7/22.
//  Copyright (c) 2015年 Dave. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
//将数组字典对象转换成JSON
+ (NSString *)jsonStringWithParams:(id)params
{
	NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
	return [[NSString alloc]initWithData:paramsData encoding:NSUTF8StringEncoding];
}

//是否是手机号
- (BOOL)isMobileNumber
{
	NSString * MOBILE = @"^[1][3,4,5,7,8][0-9]{9}$";
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	
	if ([regextestmobile evaluateWithObject:self] == YES)
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

//是否是数字
- (BOOL)isNumber
{
	if (self== nil || [self isEqualToString:@""]) {
		return YES;
	}
	NSString * number = @"^(-?\\d+)(.\\d+)?$";
	NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
	if ([regextest evaluateWithObject:self] == YES) {
		return YES;
	}
	else {
		return NO;
	}
}

//1000000 --> 1,000,000.00
+ (NSString *)moneyString:(NSNumber *)money
{
    if ([money isKindOfClass:[NSNull class]] || money == nil || money.doubleValue == 0.0) {
        return @"0.00";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale currentLocale];
    formatter.currencySymbol = @"";
    return [formatter stringFromNumber:money];
}
//@1000.1 --> @"1000.1"  @1000.00 --> @"1000"  @0 --> @"" @1000.12354124 --> @"1000.124"
+ (NSString *)inputMoneyString:(NSNumber *)money
{
    if ([money isKindOfClass:[NSNull class]] || money == nil || money.doubleValue == 0.0) {
        return @"";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.locale = [NSLocale currentLocale];
    return [formatter stringFromNumber:money];
}

//转化成拼音
- (NSString *)pinyinString
{
	NSString *pinyinStr;
	CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0,  (CFStringRef)self);
	string = string?:(CFMutableStringRef)@"";
	CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
	CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
	pinyinStr = [(__bridge NSString *)string stringByReplacingOccurrencesOfString:@" " withString:@""];
	CFRelease(string);
	return pinyinStr;
}
//从原图地址中获取缩略图地址
- (NSString *)thumbnailURLString
{
   NSString *replacedStr = [self stringByReplacingOccurrencesOfString:@"/original/" withString:@"/thumbnail/"];
    return [replacedStr stringByAppendingString:@"@compress"];
}

//解析URL参数
- (NSDictionary *)queryDict{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }
    }
    return params;
}

//base64编码
- (NSString *)encodeByBase64 {
    NSData* originData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}
//base64解码
- (NSString *)decodeByBase64 {
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    return decodeStr;
}

//同级下一个科目编码
- (NSString *)nextSubjectCodeWithMaxRangeNum:(NSInteger)maxRangeNum
{
	if (self.length<4) return nil;
	NSString *leftCode = [self substringToIndex:self.length - maxRangeNum];
	NSString *rightCode = [self substringFromIndex:self.length - maxRangeNum];
	
	NSString *formatStr = [NSString stringWithFormat:@".%ldld",maxRangeNum];
	formatStr = [@"%" stringByAppendingString:formatStr];
	NSString *newRightCode = [NSString stringWithFormat:formatStr,rightCode.integerValue+1];
	return [NSString stringWithFormat:@"%@%@",leftCode,newRightCode];
}

//下级科目编码
- (NSString *)nextLevelSubjectCodeWithMaxRangeNum:(NSInteger)maxRangeNum
{
	if (self.length<4) return nil;
	NSString *formatStr = [NSString stringWithFormat:@".%ldld",maxRangeNum];
	formatStr = [@"%" stringByAppendingString:formatStr];
	NSString *tailStr= [NSString stringWithFormat:formatStr,1];
	return [NSString stringWithFormat:@"%@%@",self,tailStr];
}
@end
