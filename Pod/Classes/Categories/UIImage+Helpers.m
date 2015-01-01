//
//  UIImage+Helpers.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/24/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Colors)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
