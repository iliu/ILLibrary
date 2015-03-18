//
//  NSString+Helpers.h
//  draft-iosclient
//
//  Created by Isaac Liu on 12/24/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

+ (NSString *) ordinalNumberStringForInteger:(NSInteger)number;

+ (NSString *) pluralStringIfNeededForValue:(NSNumber *)number  singularForm:(NSString *)singularString pluralForm:(NSString *)pluralString;

+ (CGFloat) heightForString:(NSString *)string font:(NSString *)fontName size:(CGFloat)size width:(CGFloat)width;

@end
