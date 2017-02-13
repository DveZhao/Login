//
//  FLProjectBase_Const.h
//  Login
//
//  Created by Dave on 17/2/8.
//  Copyright © 2017年 ZZLing. All rights reserved.
//

#ifndef FLProjectBase_Const_h
#define FLProjectBase_Const_h


#endif /* FLProjectBase_Const_h */

#import <ReactiveCocoa.h>
#import <Masonry.h>

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "NSString+Extension.h"

//字体
#define kFONT(x) [UIFont fontWithName:@"STHeitiSC-Light" size:(x)]
#define kFONT_BOLD(x) [UIFont fontWithName:@"STHeitiSC-Medium" size:(x)]


//颜色
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//绿色
#define kCOLOR_GREEN HexRGB(0x3d9932)



#define kSCALE(x) ((x)/(320.0)*([UIScreen mainScreen].bounds.size.width))

#define SERVICE_STRGET [[NSBundle mainBundle] bundleIdentifier]