//
//  NSString+Helpers.m
//  draft-iosclient
//
//  Created by Isaac Liu on 12/24/14.
//  Copyright (c) 2014 Isaac Liu Inc. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

+ (NSString *) ordinalNumberStringForInteger:(NSInteger)number {
    int modHundred = number %100;
    NSString *suffix;
    
    if (modHundred == 11 || modHundred == 12 || modHundred == 13) {
        suffix = @"th";
    } else {
        int lastDigit = number%10;
        switch (lastDigit) {
            case 1:
                suffix = @"st";
                break;
            case 2:
                suffix = @"nd";
                break;
            case 3:
                suffix = @"rd";
                break;
            default:
                suffix = @"th";
                break;
        }}
    return [NSString stringWithFormat:@"%ld%@", (long)number, suffix];
}

+ (NSString *) pluralStringIfNeededForValue:(NSNumber *)number  singularForm:(NSString *)singularString pluralForm:(NSString *)pluralString {
    if ([number doubleValue] == 1.0) {
        return singularString;
    }
    return pluralString;
}


@end
