//
//  NSAttributedString+Helpers.h
//  ILLibrary
//
//  Created by Isaac Liu on 12/7/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Helpers)

+(NSMutableAttributedString *) attributedStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat)size andAlignment:(NSTextAlignment)alignment andColor:(UIColor *)color;

+ (NSMutableAttributedString *)leftAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size;

+ (NSMutableAttributedString *)rightAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size;

+ (NSMutableAttributedString *)centerAlignedAttributeStringWithString:(NSString *)string andFont:(NSString *)fontName andSize:(CGFloat) size;

+ (NSMutableAttributedString *)verticalAlignedAttributeStringWithLabel:(NSString *)label withFontName:(NSString *)fontName andFontSize:(CGFloat)size andIcon:(UIImage *)icon;

@end
