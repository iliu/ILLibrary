//
//  NSNumber+Helpers.m
//  Pods
//
//  Created by Isaac Liu on 1/2/15.
//
//

#import "NSNumber+Helpers.h"

@implementation NSNumber (Helpers)


+ (NSNumberFormatter *)ILNumberFormatter {
    static NSNumberFormatter *sharedNumberFormatter = nil;
    if (!sharedNumberFormatter) {
        sharedNumberFormatter = NSNumberFormatter.new;
        [sharedNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return sharedNumberFormatter;
}

+ (NSNumber *) numberFromString:(NSString *) string {
    NSNumberFormatter *formatter = [self ILNumberFormatter];
    return [formatter numberFromString:string];
}


@end
