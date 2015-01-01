//
//  UIColor+PGMColorString.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/5/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PGMColorString)

+(NSString *)hexValuesFromUIColor:(UIColor *)color;
+(UIColor *) colorWithRGBValuesRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andAlpha:(CGFloat)alpha;

@end
