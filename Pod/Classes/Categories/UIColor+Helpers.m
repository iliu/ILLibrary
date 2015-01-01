//
//  UIColor+PGMColorString.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/5/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UIColor+Helpers.h"

@implementation UIColor (PGMColorString)

// FIXME: This current returns RGBValues

+(NSString *)hexValuesFromUIColor:(UIColor *)color {
    
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }
    
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];
    
    return returnString;    
}

+(UIColor *) colorWithRGBValuesRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(CGFloat)(red/255.0) green:(CGFloat)(green/255.0) blue:(CGFloat)(blue/255.0) alpha:alpha];
}


@end
